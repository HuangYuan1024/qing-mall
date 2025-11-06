package com.huangyuan.qingspringbootstartersecurity.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
public class SecurityPermitConfig {

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                .csrf(AbstractHttpConfigurer::disable)          // 如不需要可留着
                .authorizeHttpRequests(auth -> auth
                        .requestMatchers("/hello", "/actuator/hello").permitAll()  // 放行端点
                        .anyRequest().authenticated()      // 其余仍需认证
                )
                .oauth2ResourceServer(oauth2 -> oauth2.jwt(Customizer.withDefaults())); // 保留 JWT 校验
        return http.build();
    }
}
