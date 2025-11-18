package com.huangyuan.orderboot;

import org.apache.dubbo.config.spring.context.annotation.EnableDubbo;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication(scanBasePackages = "com.huangyuan")
@MapperScan("com.huangyuan.orderinfrastructure.persistence.mapper")
@EnableDubbo(scanBasePackages = "com.huangyuan.orderapplication.service")
@ComponentScan(basePackages = {"com.huangyuan.orderboot", "com.huangyuan.orderinterface", "com.huangyuan.orderintegration", "com.huangyuan.orderapplication", "com.huangyuan.orderdomain", "com.huangyuan.orderinfrastructure", "com.huangyuan.qingspringbootstarterweb"})
public class OrderBootApplication {

    public static void main(String[] args) {
        SpringApplication.run(OrderBootApplication.class, args);
    }

}
