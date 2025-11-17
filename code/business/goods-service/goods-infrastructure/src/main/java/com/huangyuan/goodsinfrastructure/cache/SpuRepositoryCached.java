package com.huangyuan.goodsinfrastructure.cache;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huangyuan.goodsdomain.aggregate.Spu;
import com.huangyuan.goodsdomain.repository.SpuRepository;
import com.huangyuan.goodsinfrastructure.persistence.repository.SpuRepositoryImpl;
import com.huangyuan.qingspringbootstarterlock.annotation.DistributedLock;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Primary;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Repository;

import java.time.Duration;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.ThreadLocalRandom;

@Repository
@Primary // 优先使用缓存
@RequiredArgsConstructor
public class SpuRepositoryCached implements SpuRepository {

    private final SpuRepositoryImpl delegate;
    private final RedisTemplate<String, Object> redis;
    private static final String PREFIX = "spu:id:";

    /**
     * 随机生成缓存过期时间
     * @return Duration
     */
    private Duration randomTTL() {
        // 1~10 分钟
        int randomSeconds = ThreadLocalRandom.current().nextInt(60, 600);
        // 基础 5 min + 随机
        return Duration.ofSeconds(300 + randomSeconds);
    }

    /* -------------------- 单对象缓存 -------------------- */

    /**
     * 使用分布式锁防止缓存击穿：
     * 1. 锁粒度：单 spu
     * 2. 等待锁 3s，持锁最长 10s（足够回源 + 写缓存）
     * 3. 锁 key 动态拼接，保证不同 spu 互不影响
     */
    @Override
    @DistributedLock(
            key = "'lock:spu:' + #id",
            waitTime = 3000,
            leaseTime = 10000,
            timeUnit = TimeUnit.MILLISECONDS
    )
    public Optional<Spu> find(String id) {
        String key = PREFIX + id;

        // 第一次检查缓存
        Object cachedObj = redis.opsForValue().get(key);
        if (cachedObj != null) {
            if (cachedObj instanceof Spu) {
                return Optional.of((Spu) cachedObj);
            } else {
                // 类型不匹配，删除错误缓存
                redis.delete(key);
            }
        }

        try {
            // 获取锁后二次检查
            cachedObj = redis.opsForValue().get(key);
            if (cachedObj != null) {
                if (cachedObj instanceof Spu) {
                    return Optional.of((Spu) cachedObj);
                } else {
                    redis.delete(key);
                }
            }

            // 查询数据库
            Optional<Spu> fromDb = delegate.find(id);

            if (fromDb.isPresent()) {
                redis.opsForValue().set(key, fromDb.get(), randomTTL());
            } else {
                // 缓存空值防止穿透
                redis.opsForValue().set(key, "NULL_PLACEHOLDER", Duration.ofMinutes(1));
            }

            return fromDb;
        } catch (Exception e) {
            // 记录日志并返回空结果
            return Optional.empty();
        }
    }

    @Override
    public void save(Spu spu) {
        delegate.save(spu);
        redis.opsForValue().set(PREFIX + spu.getId(), spu, randomTTL());
    }

    @Override
    public void delete(String id) {
        delegate.delete(id);
        redis.delete(PREFIX + id);
    }

    /* -------------------- 实时查询透传 -------------------- */
    @Override
    public boolean existsName(String name) {
        // 实时性高，直接走 DB
        return delegate.existsName(name);
    }

    @Override
    public List<Spu> listAll() {
        // 数据量大且变化频繁，先不走缓存
        return delegate.listAll();
    }

    @Override
    public Page<Spu> page(Long current, Long size) {
        // 分页缓存代价高，后续可定制 Page 缓存 key
        return delegate.page(current, size);
    }
}