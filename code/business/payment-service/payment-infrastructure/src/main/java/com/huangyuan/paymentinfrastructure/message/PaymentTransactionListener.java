package com.huangyuan.paymentinfrastructure.message;

import com.huangyuan.paymentdomain.event.PaymentCreatedEvent;
import com.huangyuan.paymentdomain.model.PaymentStatus;
import com.huangyuan.paymentdomain.repository.PaymentRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.rocketmq.client.producer.LocalTransactionState;
import org.apache.rocketmq.client.producer.TransactionListener;
import org.apache.rocketmq.common.message.Message;
import org.apache.rocketmq.common.message.MessageExt;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;

@Component
@Slf4j
@RequiredArgsConstructor
public class PaymentTransactionListener implements TransactionListener {

    private final PaymentRepository paymentRepository;

    @Override
    public LocalTransactionState executeLocalTransaction(Message message, Object o) {
        PaymentCreatedEvent event = new PaymentCreatedEvent(
                message.getProperty("paymentId"),
                message.getProperty("orderId"),
                message.getProperty("amount"),
                PaymentStatus.PROCESSING,
                LocalDateTime.now()
        );
        try {
            // 创建本地事务
            log.info("创建本地事务: {}", event);
            // 处理本地事务
//            paymentRepository.save(event);
            // 返回事务状态
            return LocalTransactionState.COMMIT_MESSAGE;
        } catch (Exception e) {
            // 处理异常
            log.error("创建本地事务失败: {}", event, e);
            return LocalTransactionState.ROLLBACK_MESSAGE;
        }
    }

    @Override
    public LocalTransactionState checkLocalTransaction(MessageExt messageExt) {
        PaymentCreatedEvent event = new PaymentCreatedEvent(
                messageExt.getProperty("paymentId"),
                messageExt.getProperty("orderId"),
                messageExt.getProperty("amount"),
                PaymentStatus.PROCESSING,
                LocalDateTime.now()
        );
        try {
            // 检查本地事务状态
            log.info("检查本地事务状态: {}", event);
//            if (paymentRepository.findById(event.getPaymentId()) != null) {
//                return LocalTransactionState.COMMIT_MESSAGE;
//            }
            // 返回事务状态
            return LocalTransactionState.COMMIT_MESSAGE;
        } catch (Exception e) {
            // 处理异常
            log.error("检查本地事务状态失败: {}", event, e);
            return LocalTransactionState.ROLLBACK_MESSAGE;
        }
    }
}
