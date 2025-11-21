package com.huangyuan.paymentapplication.message;

import com.huangyuan.paymentdomain.event.PaymentFailedEvent;
import lombok.extern.slf4j.Slf4j;
import org.apache.rocketmq.spring.annotation.RocketMQMessageListener;
import org.apache.rocketmq.spring.core.RocketMQListener;
import org.springframework.stereotype.Component;

@Component
@RocketMQMessageListener(
    topic = "PAYMENT_FAIL_TOPIC",
    consumerGroup = "order-payment-fail-consumer"
)
@Slf4j
public class PaymentFailConsumer implements RocketMQListener<PaymentFailedEvent> {

    @Override
    public void onMessage(PaymentFailedEvent event) {
        try {
            log.info("收到支付失败消息: paymentId={}, orderId={}", 
                    event.getPaymentId(), event.getOrderId());
            
            // 更新订单状态为支付失败
            // orderService.updateOrderStatus(event.getOrderId(), OrderStatus.PAYMENT_FAILED);
            log.info("订单状态更新完成: orderId={}", event.getOrderId());
            
        } catch (Exception e) {
            log.error("处理支付失败消息失败: paymentId={}", event.getPaymentId(), e);
            throw e;
        }
    }
}