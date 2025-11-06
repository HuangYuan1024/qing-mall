package com.huangyuan.qingspringbootstarterlock.config;

import org.junit.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.DynamicPropertyRegistry;
import org.springframework.test.context.DynamicPropertySource;
import org.testcontainers.containers.GenericContainer;
import org.testcontainers.containers.wait.strategy.Wait;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.junit.jupiter.Testcontainers;

import static org.assertj.core.api.Assertions.assertThat;


@SpringBootTest(classes = LockAutoConfiguration.class)
@Testcontainers
public class LockAutoConfigurationTest {

    @Container
    private static final GenericContainer<?> redis =
            new GenericContainer<>("redis:7-alpine")
                    .withExposedPorts(6379)
                    .waitingFor(Wait.forListeningPort());

    @DynamicPropertySource
    static void redisProps(DynamicPropertyRegistry r) {
        r.add("spring.redis.host", redis::getHost);
        r.add("spring.redis.port", redis::getFirstMappedPort);
    }

    @Test
    public void contextLoads() {
        // 验证上下文确实能够成功加载
        assertThat(redis.isRunning()).isTrue();
    }
}

