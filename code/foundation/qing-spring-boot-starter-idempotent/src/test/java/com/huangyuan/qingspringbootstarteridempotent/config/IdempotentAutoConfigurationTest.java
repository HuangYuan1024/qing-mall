package com.huangyuan.qingspringbootstarteridempotent.config;


import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.DynamicPropertyRegistry;
import org.springframework.test.context.DynamicPropertySource;
import org.testcontainers.containers.GenericContainer;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.junit.jupiter.Testcontainers;
import org.testng.annotations.Test;

@SpringBootTest(classes = IdempotentAutoConfiguration.class)
@Testcontainers
class IdempotentAutoConfigurationTest {

    private static final String REDIS_IMAGE = "redis:7-alpine";
    private static final int REDIS_PORT = 6379;

    @Container
    static GenericContainer<?> redis =
            new GenericContainer<>(REDIS_IMAGE).withExposedPorts(REDIS_PORT);

    @DynamicPropertySource
    static void redisProps(DynamicPropertyRegistry registry) {
        registry.add("spring.redis.host", redis::getHost);
        registry.add("spring.redis.port", redis::getFirstMappedPort);
    }

    @Test
    void contextLoads() {}
}

