package com.huangyuan.goodsapplication.command;

import lombok.Data;

import java.io.Serializable;

@Data
public class CreateSkuCommand implements Serializable {
    private final String skuName;
    private final Integer price;
    private final Integer stock;
    private final String image;
    private final String attrText;
}
