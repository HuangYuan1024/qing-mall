package com.huangyuan.paymentdomain.event;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.huangyuan.paymentdomain.model.PaymentStatus;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PaymentCompletedEvent {
    private String paymentId;
    private String orderId;
    private String amount;
    private PaymentStatus status;
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSSSS")
    private LocalDateTime completeTime;
}
