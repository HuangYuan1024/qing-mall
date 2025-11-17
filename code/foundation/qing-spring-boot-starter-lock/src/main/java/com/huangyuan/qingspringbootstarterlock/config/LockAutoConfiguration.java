package com.huangyuan.qingspringbootstarterlock.config;

import com.huangyuan.qingspringbootstarterlock.aspect.DistributedLockAspect;
import jakarta.annotation.Resource;
import lombok.AllArgsConstructor;
import org.redisson.api.RedissonClient;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
@AllArgsConstructor
@ConditionalOnProperty(name = "lock.enabled", matchIfMissing = true)
public class LockAutoConfiguration {

    @Resource
    private final RedissonClient redissonClient;

    @Bean
    public DistributedLockAspect distributedLockAspect() {
        return new DistributedLockAspect(redissonClient);
    }
}
