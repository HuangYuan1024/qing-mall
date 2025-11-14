package com.huangyuan.fileinfrastructure.config;

import io.minio.MinioClient;
import lombok.Getter;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Getter
@Configuration
public class MinioConfig {

    private final String endpoint = "http://localhost:9000";
    private final String accessKey = "minio";
    private final String secretKey = "minio123";
    private final String region = "us-east-1";

    @Bean
    public MinioClient minioClient() {
        return MinioClient.builder()
                .endpoint(endpoint)
                .credentials(accessKey, secretKey)
                .region(region)
                .build();
    }
}
