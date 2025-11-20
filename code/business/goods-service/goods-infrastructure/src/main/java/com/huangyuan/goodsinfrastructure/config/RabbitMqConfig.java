package com.huangyuan.goodsinfrastructure.config;

import org.springframework.amqp.core.*;
import org.springframework.amqp.support.converter.Jackson2JsonMessageConverter;
import org.springframework.amqp.support.converter.MessageConverter;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class RabbitMqConfig {

    /**
     * 配置JSON消息转换器
     */
    @Bean
    public MessageConverter jsonMessageConverter() {
        return new Jackson2JsonMessageConverter();
    }

    /**
     * 商品服务相关的队列、交换机配置
     */
    @Bean
    public TopicExchange goodsExchange() {
        return new TopicExchange("goods.exchange", true, false);
    }

    @Bean
    public Queue goodsStatusQueue() {
        return QueueBuilder.durable("goods.status.queue")
                .deadLetterExchange("dlx.exchange")
                .deadLetterRoutingKey("goods.status.dlq")
                .ttl(10000) // 可选：设置消息TTL为10秒
                .build();
    }

    @Bean
    public Queue goodsPriceQueue() {
        return QueueBuilder.durable("goods.price.queue")
                .deadLetterExchange("dlx.exchange")
                .deadLetterRoutingKey("goods.price.dlq")
                .build();
    }

    @Bean
    public Binding goodsStatusBinding() {
        return BindingBuilder.bind(goodsStatusQueue())
                .to(goodsExchange())
                .with("goods.status.change");
    }

    @Bean
    public Binding goodsPriceBinding() {
        return BindingBuilder.bind(goodsPriceQueue())
                .to(goodsExchange())
                .with("goods.price.change");
    }

    /**
     * 死信交换机配置
     */
    @Bean
    public DirectExchange dlxExchange() {
        return new DirectExchange("dlx.exchange", true, false);
    }

    /**
     * 商品状态变更的死信队列
     */
    @Bean
    public Queue goodsStatusDlq() {
        return new Queue("goods.status.dlq", true);
    }

    /**
     * 商品价格变更的死信队列
     */
    @Bean
    public Queue goodsPriceDlq() {
        return new Queue("goods.price.dlq", true);
    }

    /**
     * 死信队列绑定
     */
    @Bean
    public Binding goodsStatusDlqBinding() {
        return BindingBuilder.bind(goodsStatusDlq())
                .to(dlxExchange())
                .with("goods.status.dlq");
    }

    @Bean
    public Binding goodsPriceDlqBinding() {
        return BindingBuilder.bind(goodsPriceDlq())
                .to(dlxExchange())
                .with("goods.price.dlq");
    }
}