package com.huangyuan.paymentdomain.model;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class Payment {
    private String paymentId;
    private String orderId;
    private String userId;
    private String amount;
    private PaymentStatus status;
}
