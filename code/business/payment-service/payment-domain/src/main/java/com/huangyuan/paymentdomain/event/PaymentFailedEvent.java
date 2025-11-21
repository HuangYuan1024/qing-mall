package com.huangyuan.paymentdomain.event;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@AllArgsConstructor
public class PaymentFailedEvent {
    private String paymentId;
    private String orderId;
    private String amount;
    private String failReason;
    private LocalDateTime failTime;
    
    // getters/setters
}