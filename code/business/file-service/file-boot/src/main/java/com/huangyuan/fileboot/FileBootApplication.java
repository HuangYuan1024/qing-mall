package com.huangyuan.fileboot;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan(basePackages = {"com.huangyuan.fileboot", "com.huangyuan.fileinterface", "com.huangyuan.qingspringbootstarterweb"})
public class FileBootApplication {

    public static void main(String[] args) {
        SpringApplication.run(FileBootApplication.class, args);
    }

}
