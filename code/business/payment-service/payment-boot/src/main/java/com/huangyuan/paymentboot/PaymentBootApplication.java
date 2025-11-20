package com.huangyuan.paymentboot;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan(basePackages = {"com.huangyuan.paymentboot", "com.huangyuan.paymentinterface", "com.huangyuan.qingspringbootstarterweb"})
public class PaymentBootApplication {

    public static void main(String[] args) {
        SpringApplication.run(PaymentBootApplication.class, args);
    }

}
