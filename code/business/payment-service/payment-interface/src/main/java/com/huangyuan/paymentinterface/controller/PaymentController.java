package com.huangyuan.paymentinterface.controller;

import com.huangyuan.paymentapplication.service.PaymentApplicationService;
import com.huangyuan.paymentdomain.model.Payment;
import com.huangyuan.paymentdomain.model.PaymentStatus;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/rocketmq")
public class PaymentController {

    private final PaymentApplicationService paymentApplicationService;

    @RequestMapping("/test")
    public String test() {
        log.info("创建支付");
        paymentApplicationService.createPayment(new Payment("1", "1", "1", "1", PaymentStatus.PROCESSING));
        log.info("支付创建完成");
        log.info("支付回调处理");
        paymentApplicationService.handlePaymentCallback(new Payment("1", "1", "1", "1", PaymentStatus.PROCESSING), true, 0, "");
        return "success";
    }
}
