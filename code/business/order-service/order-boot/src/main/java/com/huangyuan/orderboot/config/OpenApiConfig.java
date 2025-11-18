package com.huangyuan.orderboot.config;

import io.swagger.v3.oas.models.ExternalDocumentation;
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class OpenApiConfig {

    @Bean
    public OpenAPI customOpenAPI() {
        return new OpenAPI()
                .info(new Info()
                        .title("晴云商城-商品服务API")
                        .version("1.0.0")
                        .description("商品中心领域服务"))
                .externalDocs(new ExternalDocumentation()
                        .description("在线文档")
                        .url("http://localhost:8081/swagger-ui.html"));
    }
}
