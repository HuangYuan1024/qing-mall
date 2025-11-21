package com.huangyuan.paymentinfrastructure.message;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.huangyuan.paymentdomain.event.PaymentCompletedEvent;
import com.huangyuan.paymentdomain.event.PaymentCreatedEvent;
import com.huangyuan.paymentdomain.event.PaymentFailedEvent;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.rocketmq.client.producer.SendResult;
import org.apache.rocketmq.spring.core.RocketMQTemplate;
import org.apache.rocketmq.spring.support.RocketMQHeaders;
import org.springframework.messaging.Message;
import org.springframework.messaging.support.MessageBuilder;
import org.springframework.stereotype.Component;

@Component
@Slf4j
@RequiredArgsConstructor
public class RocketMQMessageProducer {

    private final RocketMQTemplate rocketMQTemplate;
    private final ObjectMapper objectMapper;

    /**
     * 发送支付创建事务消息
     */
    public void sendPaymentCreatedTransaction(PaymentCreatedEvent event, Runnable localTransaction) {
        try {
            // 将对象转换为 JSON 字符串进行序列化
            String jsonPayload = objectMapper.writeValueAsString(event);

            Message<String> message = MessageBuilder.withPayload(jsonPayload)
                    .setHeader(RocketMQHeaders.TRANSACTION_ID, event.getPaymentId())
                    .build();

            rocketMQTemplate.sendMessageInTransaction("PAYMENT_CREATE_TRANSACTION_TOPIC", message, localTransaction);
            log.info("支付创建事务消息发送成功: paymentId={}", event.getPaymentId());
        } catch (JsonProcessingException e) {
            log.error("支付创建事务消息序列化失败: paymentId={}", event.getPaymentId(), e);
            throw new RuntimeException("消息序列化失败", e);
        } catch (Exception e) {
            log.error("支付创建事务消息发送失败: paymentId={}", event.getPaymentId(), e);
            throw new RuntimeException("消息发送失败", e);
        }
    }

    /**
     * 发送支付完成消息
     */
    public void sendPaymentCompleted(PaymentCompletedEvent event) {
        try {
            // 使用 JSON 序列化版本
            sendPaymentCompletedJson(event);
        } catch (Exception e) {
            log.error("支付完成消息发送失败: paymentId={}", event.getPaymentId(), e);
            throw new RuntimeException("消息发送失败", e);
        }
    }

    /**
     * 发送支付失败消息
     */
    public void sendPaymentFailed(PaymentFailedEvent event) {
        try {
            // 使用 JSON 序列化版本
            sendPaymentFailedJson(event);
        } catch (Exception e) {
            log.error("支付失败消息发送失败: paymentId={}", event.getPaymentId(), e);
            throw new RuntimeException("消息发送失败", e);
        }
    }

    /**
     * 发送支付完成有序消息
     */
    public void sendPaymentCompletedOrderly(PaymentCompletedEvent event, String hashKey) {
        try {
            String jsonPayload = objectMapper.writeValueAsString(event);
            SendResult sendResult = rocketMQTemplate.syncSendOrderly("PAYMENT_COMPLETE_TOPIC", jsonPayload, hashKey);
            log.info("支付完成有序消息发送成功: paymentId={}, hashKey={}, msgId={}",
                    event.getPaymentId(), hashKey, sendResult.getMsgId());
        } catch (JsonProcessingException e) {
            log.error("支付完成有序消息序列化失败: paymentId={}, hashKey={}", event.getPaymentId(), hashKey, e);
            throw new RuntimeException("消息序列化失败", e);
        } catch (Exception e) {
            log.error("支付完成有序消息发送失败: paymentId={}, hashKey={}", event.getPaymentId(), hashKey, e);
            throw new RuntimeException("有序消息发送失败", e);
        }
    }

    /**
     * 发送支付失败有序消息
     */
    public void sendPaymentFailedOrderly(PaymentFailedEvent event, String hashKey) {
        try {
            String jsonPayload = objectMapper.writeValueAsString(event);
            SendResult sendResult = rocketMQTemplate.syncSendOrderly("PAYMENT_FAIL_TOPIC", jsonPayload, hashKey);
            log.info("支付失败有序消息发送成功: paymentId={}, hashKey={}, msgId={}",
                    event.getPaymentId(), hashKey, sendResult.getMsgId());
        } catch (JsonProcessingException e) {
            log.error("支付失败有序消息序列化失败: paymentId={}, hashKey={}", event.getPaymentId(), hashKey, e);
            throw new RuntimeException("消息序列化失败", e);
        } catch (Exception e) {
            log.error("支付失败有序消息发送失败: paymentId={}, hashKey={}", event.getPaymentId(), hashKey, e);
            throw new RuntimeException("有序消息发送失败", e);
        }
    }

    /**
     * 发送支付完成消息（JSON序列化版本）
     */
    public void sendPaymentCompletedJson(PaymentCompletedEvent event) {
        try {
            String jsonPayload = objectMapper.writeValueAsString(event);

            // 构建消息，添加必要的头信息
            Message<String> message = MessageBuilder.withPayload(jsonPayload)
                    .setHeader("paymentId", event.getPaymentId())
                    .setHeader("eventType", "PAYMENT_COMPLETED")
                    .build();

            SendResult sendResult = rocketMQTemplate.syncSend("PAYMENT_COMPLETE_TOPIC", message);
            log.info("支付完成JSON消息发送成功: paymentId={}, msgId={}",
                    event.getPaymentId(), sendResult.getMsgId());
        } catch (JsonProcessingException e) {
            log.error("支付完成消息JSON序列化失败: paymentId={}", event.getPaymentId(), e);
            throw new RuntimeException("消息序列化失败", e);
        } catch (Exception e) {
            log.error("支付完成JSON消息发送失败: paymentId={}", event.getPaymentId(), e);
            throw new RuntimeException("消息发送失败", e);
        }
    }

    /**
     * 发送支付失败消息（JSON序列化版本）
     */
    public void sendPaymentFailedJson(PaymentFailedEvent event) {
        try {
            String jsonPayload = objectMapper.writeValueAsString(event);

            // 构建消息，添加必要的头信息
            Message<String> message = MessageBuilder.withPayload(jsonPayload)
                    .setHeader("paymentId", event.getPaymentId())
                    .setHeader("eventType", "PAYMENT_FAILED")
                    .build();

            SendResult sendResult = rocketMQTemplate.syncSend("PAYMENT_FAIL_TOPIC", message);
            log.info("支付失败JSON消息发送成功: paymentId={}, msgId={}",
                    event.getPaymentId(), sendResult.getMsgId());
        } catch (JsonProcessingException e) {
            log.error("支付失败消息JSON序列化失败: paymentId={}", event.getPaymentId(), e);
            throw new RuntimeException("消息序列化失败", e);
        } catch (Exception e) {
            log.error("支付失败JSON消息发送失败: paymentId={}", event.getPaymentId(), e);
            throw new RuntimeException("消息发送失败", e);
        }
    }
}