package com.huangyuan.qingspringbootstarterlock.aspect;

import com.huangyuan.qingspringbootstarterlock.annotation.DistributedLock;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.redisson.api.RLock;
import org.redisson.api.RedissonClient;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import java.util.concurrent.TimeUnit;


@Aspect
@Component
public class DistributedLockAspect {

    private static final Logger logger = LoggerFactory.getLogger(DistributedLockAspect.class);

    private final RedissonClient redissonClient;

    public DistributedLockAspect(RedissonClient client) {
        this.redissonClient = client;
    }

    @Pointcut("@annotation(com.huangyuan.qingspringbootstarterlock.annotation.DistributedLock)")
    public void distributedLockPointcut() {
    }


    // 环绕通知处理分布式锁逻辑
    @Around("distributedLockPointcut()")
    public Object handleDistributedLock(ProceedingJoinPoint joinPoint) throws Throwable {
        // 分布式锁的核心逻辑实现
        // 1. 获取锁
        // 2. 执行目标方法
        // 3. 释放锁
        // 4. 异常处理和日志记录

        // 获取方法签名和注解信息
        MethodSignature signature = (MethodSignature) joinPoint.getSignature();
        DistributedLock distributedLock = signature.getMethod().getAnnotation(DistributedLock.class);

        String lockKey = distributedLock.value();
        long waitTime = distributedLock.waitTime();
        long leaseTime = distributedLock.leaseTime();
        TimeUnit timeUnit = distributedLock.timeUnit();

        RLock lock = redissonClient.getLock(lockKey);

        try {
            boolean isLocked = lock.tryLock(waitTime, leaseTime, timeUnit);
            if (!isLocked) {
                logger.warn("Failed to acquire distributed lock for key: {}", lockKey);
                throw new RuntimeException("Failed to acquire distributed lock");
            }

            logger.info("Successfully acquired distributed lock for key: {}", lockKey);

            // 执行目标方法
            return joinPoint.proceed();

        } catch (InterruptedException e) {
            logger.error("Thread interrupted while acquiring lock for key: {}", lockKey, e);
            Thread.currentThread().interrupt();
            throw e;
        } catch (Exception e) {
            logger.error("Error occurred during method execution with lock for key: {}", lockKey, e);
            throw e;
        } finally {
            // 释放锁
            if (lock.isHeldByCurrentThread()) {
                lock.unlock();
                logger.info("Successfully released distributed lock for key: {}", lockKey);
            }
        }
    }
}


