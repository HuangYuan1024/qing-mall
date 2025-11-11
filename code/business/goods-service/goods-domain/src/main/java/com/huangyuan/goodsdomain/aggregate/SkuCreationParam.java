package com.huangyuan.goodsdomain.aggregate;

import org.springframework.util.SimpleIdGenerator;

public record SkuCreationParam(String skuName, Integer price, Integer stock, String image, String attrText) {
    public SkuId getSkuId() {
        SimpleIdGenerator idGenerator = new SimpleIdGenerator();
        return new SkuId(idGenerator.generateId().toString());
    }
}
