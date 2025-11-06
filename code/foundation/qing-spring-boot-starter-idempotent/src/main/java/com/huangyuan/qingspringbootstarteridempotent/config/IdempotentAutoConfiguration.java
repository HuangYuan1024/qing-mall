package com.huangyuan.qingspringbootstarteridempotent.config;

import com.huangyuan.qingspringbootstarteridempotent.interceptor.IdempotentInterceptor;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.core.StringRedisTemplate;

@Configuration
@ConditionalOnProperty(name = "idempotent.enabled", matchIfMissing = true)
public class IdempotentAutoConfiguration {

    @Bean
    public IdempotentInterceptor idempotentInterceptor(StringRedisTemplate redis) {
        return new IdempotentInterceptor(redis);
    }
}
