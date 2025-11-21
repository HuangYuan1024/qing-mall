package com.huangyuan.paymentapplication.service;

import com.huangyuan.paymentapplication.dto.PaymentDto;
import com.huangyuan.paymentdomain.event.PaymentCompletedEvent;
import com.huangyuan.paymentdomain.event.PaymentCreatedEvent;
import com.huangyuan.paymentdomain.event.PaymentFailedEvent;
import com.huangyuan.paymentdomain.model.Payment;
import com.huangyuan.paymentdomain.model.PaymentStatus;
import com.huangyuan.paymentdomain.repository.PaymentRepository;
import com.huangyuan.paymentinfrastructure.message.RocketMQMessageProducer;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;

@Service
@Slf4j
@RequiredArgsConstructor
public class PaymentApplicationService {

    private final PaymentRepository paymentRepository;

    private final RocketMQMessageProducer messageProducer;

    /**
     * 创建支付（使用事务消息）
     */
    @Transactional
    public PaymentDto createPayment(Payment payment) {
        // 1. 创建支付记录（状态为 INIT）
        paymentRepository.save(payment);

        // 2. 发送事务消息
        PaymentCreatedEvent event = buildPaymentCreatedEvent(payment);

        messageProducer.sendPaymentCreatedTransaction(event, () -> {
            // 本地事务执行：更新支付状态为 PROCESSING
            payment.setStatus(PaymentStatus.PROCESSING);
            paymentRepository.save(payment);
            log.info("支付本地事务执行完成: paymentId={}", payment.getPaymentId());
        });

        return new PaymentDto(payment.getPaymentId(), payment.getOrderId(), payment.getAmount());
    }

    /**
     * 支付回调处理
     */
    @Transactional
    public void handlePaymentCallback(Payment payment, Boolean isSuccess, Integer statusCode, String failReason) {
        if (isSuccess) {
            // 支付成功
            payment.setStatus(PaymentStatus.of(statusCode));
            paymentRepository.save(payment);
            
            // 发送支付完成消息
            PaymentCompletedEvent event = buildPaymentCompletedEvent(payment);
            messageProducer.sendPaymentCompleted(event);
            
        } else {
            // 支付失败
            payment.setStatus(PaymentStatus.of(statusCode));
            paymentRepository.save(payment);
            
            // 发送支付失败消息
            PaymentFailedEvent event = buildPaymentFailedEvent(payment, failReason);
            messageProducer.sendPaymentFailed(event);
        }
    }

    private PaymentCreatedEvent buildPaymentCreatedEvent(Payment payment) {
        return new PaymentCreatedEvent(payment.getPaymentId(), payment.getOrderId(), "0", payment.getStatus(), LocalDateTime.now());
    }

    private PaymentFailedEvent buildPaymentFailedEvent(Payment payment, String failReason) {
        return new PaymentFailedEvent(payment.getPaymentId(), payment.getOrderId(), "0", failReason, LocalDateTime.now());
    }

    private PaymentCompletedEvent buildPaymentCompletedEvent(Payment payment) {
        return new PaymentCompletedEvent(payment.getPaymentId(), payment.getOrderId(), "0", payment.getStatus(), LocalDateTime.now());
    }
}