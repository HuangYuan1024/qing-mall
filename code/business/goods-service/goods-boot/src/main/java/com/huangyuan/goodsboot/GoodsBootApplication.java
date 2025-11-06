package com.huangyuan.goodsboot;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan(basePackages = {"com.huangyuan.goodsboot", "com.huangyuan.goodsinterface", "com.huangyuan.qingspringbootstarterweb"})
public class GoodsBootApplication {

    public static void main(String[] args) {
        SpringApplication.run(GoodsBootApplication.class, args);
    }

}
