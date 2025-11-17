package com.huangyuan.qingspringbootstarterlock.aspect;

import com.huangyuan.qingspringbootstarterlock.annotation.DistributedLock;
import com.huangyuan.qingspringbootstarterlock.parser.SpelParser;
import jakarta.annotation.Resource;
import lombok.AllArgsConstructor;
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
@AllArgsConstructor
public class DistributedLockAspect {

    private static final Logger logger = LoggerFactory.getLogger(DistributedLockAspect.class);

    @Resource
    private final RedissonClient redissonClient;

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

        String lockKey = SpelParser.parse(distributedLock.key(), joinPoint);
        long waitTime = distributedLock.waitTime();
        long leaseTime = distributedLock.leaseTime();
        TimeUnit timeUnit = distributedLock.timeUnit();

        RLock lock = redissonClient.getLock(lockKey);

        try {
            boolean isLocked = lock.tryLock(waitTime, leaseTime, timeUnit);
            if (!isLocked) {
                logger.warn("获取分布式锁失败，key: {}", lockKey);
                throw new RuntimeException("获取分布式锁失败");
            }

            logger.info("成功获取分布式锁，key: {}", lockKey);

            // 执行目标方法
            return joinPoint.proceed();

        } catch (InterruptedException e) {
            logger.error("获取锁时线程被中断，key: {}", lockKey, e);
            Thread.currentThread().interrupt();
            throw e;
        } catch (Exception e) {
            logger.error("执行带锁方法时发生错误，key: {}", lockKey, e);
            throw e;
        } finally {
            // 释放锁
            if (lock.isHeldByCurrentThread()) {
                lock.unlock();
                logger.info("成功释放分布式锁，key: {}", lockKey);
            }
        }
    }
}


