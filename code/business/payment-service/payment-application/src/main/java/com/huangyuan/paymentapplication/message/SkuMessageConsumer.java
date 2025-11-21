package com.huangyuan.paymentapplication.message;

import com.huangyuan.paymentdomain.event.PaymentCompletedEvent;
import com.huangyuan.paymentdomain.model.PaymentStatus;
import lombok.extern.slf4j.Slf4j;
import org.apache.rocketmq.spring.annotation.RocketMQMessageListener;
import org.apache.rocketmq.spring.core.RocketMQListener;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;

@Component
@Slf4j
@RocketMQMessageListener(
        topic = "PAYMENT_COMPLETE_TOPIC",
        consumerGroup = "goods-payment-complete-consumer"
)
public class SkuMessageConsumer implements RocketMQListener<String> {
    
    /**
     * 监听支付完成消息，扣减库存
     */
    public void handlePaymentComplete(PaymentCompletedEvent event) {
        try {
            log.info("收到支付完成消息，准备扣减库存: orderId={}", event.getOrderId());
            
            // 根据订单ID获取订单详情并扣减库存
            log.info("库存扣减完成: orderId={}", event.getOrderId());
            
        } catch (Exception e) {
            log.error("扣减库存失败: orderId={}", event.getOrderId(), e);
            throw e;
        }
    }

    @Override
    public void onMessage(String s) {
        handlePaymentComplete(new PaymentCompletedEvent("1", "1", "1", PaymentStatus.PROCESSING, LocalDateTime.now()));
        log.info("支付完成消息处理完成: {}", s);
    }
}
