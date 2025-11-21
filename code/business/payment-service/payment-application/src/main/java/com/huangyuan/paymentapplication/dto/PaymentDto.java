package com.huangyuan.paymentapplication.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class PaymentDto {
    private String paymentId;
    private String orderId;
    private String amount;
}
