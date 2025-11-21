package com.huangyuan.paymentinfrastructure.repository;

import com.huangyuan.paymentdomain.model.Payment;
import com.huangyuan.paymentdomain.model.PaymentStatus;
import com.huangyuan.paymentdomain.repository.PaymentRepository;
import org.springframework.stereotype.Repository;

@Repository
public class PaymentRepositoryImpl implements PaymentRepository {
    @Override
    public void save(Payment payment) {

    }

    @Override
    public Payment findById(String paymentId) {
        return new Payment("123456", "123456", "123456", "123456", PaymentStatus.PROCESSING);
    }
}
