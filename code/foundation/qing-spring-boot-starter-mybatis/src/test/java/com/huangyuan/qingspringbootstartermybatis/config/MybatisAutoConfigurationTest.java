package com.huangyuan.qingspringbootstartermybatis.config;

import org.assertj.core.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.DynamicPropertyRegistry;
import org.springframework.test.context.DynamicPropertySource;
import org.testcontainers.containers.MySQLContainer;
import org.testcontainers.junit.jupiter.Testcontainers;
import org.testcontainers.junit.jupiter.Container;

import java.time.Duration;

@SpringBootTest(classes = MybatisAutoConfiguration.class)
@Testcontainers
class MybatisAutoConfigurationTest {

    @Container
    static MySQLContainer<?> mysql = new MySQLContainer<>("mysql:9.1")
            .withDatabaseName("qing")
            .withUsername("root")
            .withPassword("root")
            .withCommand("--innodb-buffer-pool-size=256M", "--max-connections=100")
            .withStartupTimeout(Duration.ofMinutes(2));

    @DynamicPropertySource
    static void mysqlProps(DynamicPropertyRegistry r) {
        r.add("spring.datasource.url", mysql::getJdbcUrl);
        r.add("spring.datasource.username", mysql::getUsername);
        r.add("spring.datasource.password", mysql::getPassword);
    }

    @Test
    void contextLoads() {
        // 验证应用上下文能够正常加载
        Assertions.assertThat(mysql.isRunning()).isTrue();
        Assertions.assertThat(mysql.getJdbcUrl()).isNotNull();
    }
}


