package com.huangyuan.paymentboot;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication(scanBasePackages = "com.huangyuan")
@MapperScan("com.huangyuan.paymentinfrastructure.persistence.mapper")
@ComponentScan(basePackages = {"com.huangyuan.paymentboot", "com.huangyuan.paymentinterface", "com.huangyuan.paymentintegration", "com.huangyuan.paymentapplication", "com.huangyuan.paymentdomain", "com.huangyuan.paymentinfrastructure", "com.huangyuan.qingspringbootstarterweb"})
public class PaymentBootApplication {

    public static void main(String[] args) {
        SpringApplication.run(PaymentBootApplication.class, args);
    }

}
