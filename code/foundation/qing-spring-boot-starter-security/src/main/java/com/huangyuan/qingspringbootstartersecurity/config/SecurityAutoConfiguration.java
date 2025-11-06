package com.huangyuan.qingspringbootstartersecurity.config;

import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.oauth2.jwt.JwtDecoder;
import org.springframework.security.oauth2.jwt.NimbusJwtDecoder;

import javax.crypto.spec.SecretKeySpec;
import java.nio.charset.StandardCharsets;

@Configuration
@ConditionalOnProperty(name = "security.enabled", matchIfMissing = true)
public class SecurityAutoConfiguration {

    @Bean
    public JwtDecoder jwtDecoder() {
        // 使用对称密钥创建 JwtDecoder
        String secretKey = "your-secret-key-shisindiaiaabsidan"; // 实际使用时应该从配置文件中读取
        SecretKeySpec key = new SecretKeySpec(secretKey.getBytes(StandardCharsets.UTF_8), "HmacSHA256");
        return NimbusJwtDecoder.withSecretKey(key).build();
    }
}


