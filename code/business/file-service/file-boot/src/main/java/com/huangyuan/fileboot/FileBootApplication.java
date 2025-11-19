package com.huangyuan.fileboot;

import org.apache.dubbo.config.spring.context.annotation.EnableDubbo;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication(scanBasePackages = "com.huangyuan")
@MapperScan("com.huangyuan.fileinfrastructure.persistence.mapper")
@EnableDubbo(scanBasePackages = "com.huangyuan.goodsapplication.service")
@ComponentScan(basePackages = {"com.huangyuan.fileboot", "com.huangyuan.fileinterface", "com.huangyuan.fileapplication", "com.huangyuan.filedomain", "com.huangyuan.fileinfrastructure", "com.huangyuan.qingspringbootstarterweb"})
public class FileBootApplication {

    public static void main(String[] args) {
        SpringApplication.run(FileBootApplication.class, args);
    }

}
