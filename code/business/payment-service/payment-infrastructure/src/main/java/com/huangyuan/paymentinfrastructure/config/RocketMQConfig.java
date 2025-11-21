package com.huangyuan.paymentinfrastructure.config;

import com.huangyuan.paymentinfrastructure.message.PaymentTransactionListener;
import lombok.RequiredArgsConstructor;
import org.apache.rocketmq.client.producer.TransactionMQProducer;
import org.apache.rocketmq.spring.core.RocketMQTemplate;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;

@Configuration
@RequiredArgsConstructor
public class RocketMQConfig {

    @Value("${rocketmq.name-server}")
    private String nameSrv;

    @Value("${rocketmq.producer.group}")
    private String group;

    private final PaymentTransactionListener paymentTransactionListener;

    @Bean
    public TransactionMQProducer txProducer() {
        TransactionMQProducer producer = new TransactionMQProducer(group);
        producer.setNamesrvAddr(nameSrv);
        producer.setTransactionListener(paymentTransactionListener);
        return producer;
    }

    @Bean
    @Primary
    public RocketMQTemplate rocketMQTemplate(TransactionMQProducer txProducer) {
        RocketMQTemplate template = new RocketMQTemplate();
        template.setProducer(txProducer);
        return template;
    }
}