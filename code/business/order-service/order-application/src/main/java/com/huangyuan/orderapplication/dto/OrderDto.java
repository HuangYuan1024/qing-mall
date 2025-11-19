package com.huangyuan.orderapplication.dto;

import lombok.Data;

@Data
public class OrderDto {
    private String userId;
    private String spuId;
    private String skuId;
    private Integer num;
    private String addressId;
    private String couponId;
    private String paymentId;
    private String invoiceId;
    private String remark;
    private String status;
    private String createTime;
    private String updateTime;
    private String deleteTime;
    private String deleteFlag;
    private String version;
}
