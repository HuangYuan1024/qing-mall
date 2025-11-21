package com.huangyuan.paymentdomain.event;

import com.huangyuan.paymentdomain.model.PaymentStatus;
import lombok.AllArgsConstructor;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@AllArgsConstructor
public class PaymentCreatedEvent {
    private String paymentId;
    private String orderId;
    private String amount;
    private PaymentStatus status;
    private LocalDateTime createTime;
    
    // getters/setters
}