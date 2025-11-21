package com.huangyuan.paymentapplication.message;

import com.huangyuan.paymentdomain.event.PaymentCompletedEvent;
import lombok.extern.slf4j.Slf4j;
import org.apache.rocketmq.spring.annotation.RocketMQMessageListener;
import org.apache.rocketmq.spring.core.RocketMQListener;
import org.springframework.stereotype.Component;

@Component
@RocketMQMessageListener(
    topic = "PAYMENT_COMPLETE_TOPIC",
    consumerGroup = "order-payment-complete-consumer"
)
@Slf4j
public class PaymentCompleteConsumer implements RocketMQListener<PaymentCompletedEvent> {

    @Override
    public void onMessage(PaymentCompletedEvent event) {
        try {
            log.info("收到支付完成消息: paymentId={}, orderId={}", 
                    event.getPaymentId(), event.getOrderId());
            
            // 更新订单状态为已支付
            log.info("订单状态更新完成: orderId={}", event.getOrderId());
            
        } catch (Exception e) {
            log.error("处理支付完成消息失败: paymentId={}", event.getPaymentId(), e);
            throw e; // 抛出异常让 RocketMQ 重试
        }
    }
}