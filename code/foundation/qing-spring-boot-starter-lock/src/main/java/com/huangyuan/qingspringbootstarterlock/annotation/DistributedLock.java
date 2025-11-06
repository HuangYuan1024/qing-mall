package com.huangyuan.qingspringbootstarterlock.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;
import java.util.concurrent.TimeUnit;

@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
public @interface DistributedLock {

    /**
     * 锁的名称
     */
    String value() default "";

    /**
     * 锁的键名，支持SpEL表达式
     */
    String key() default "";

    /**
     * 锁超时时间，单位毫秒
     */
    long timeout() default 10000;

    /**
     * 等待锁超时时间，单位毫秒
     */
    long leaseTime() default 5000;

    /**
     * 获取锁的最大等待时间
     */
    long waitTime() default 3000;

    /**
     * 时间单位
     */
    TimeUnit timeUnit() default TimeUnit.MILLISECONDS;
}


