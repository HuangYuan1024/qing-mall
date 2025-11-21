package com.huangyuan.paymentdomain.repository;

import com.huangyuan.paymentdomain.model.Payment;

public interface PaymentRepository {
    void save(Payment payment);

    Payment findById(String paymentId);
}
