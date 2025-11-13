package com.huangyuan.qingspringbootstarterweb.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import org.springframework.web.filter.CorsFilter;


@Configuration
public class CorsConfig {

    @Bean
    public CorsFilter corsFilter() {
        CorsConfiguration config = new CorsConfiguration();
        config.setAllowCredentials(true);                       // 允许携带 cookie
        config.addAllowedOrigin("http://localhost:8088");       // 前端地址
        config.addAllowedHeader("*");                           // 允许任何头
        config.addAllowedMethod("*");                           // 允许任何方法 (GET/POST/PUT/DELETE/OPTIONS)

        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", config);        // 对所有接口生效
        return new CorsFilter(source);
    }
}
