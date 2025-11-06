package com.huangyuan.generatetemplateboot;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan(basePackages = {"com.huangyuan.generatetemplateboot", "com.huangyuan.generatetemplateinterface", "com.huangyuan.qingspringbootstarterweb"})
public class GeneratetemplateBootApplication {

    public static void main(String[] args) {
        SpringApplication.run(GeneratetemplateBootApplication.class, args);
    }

}
