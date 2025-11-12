package com.huangyuan.goodsdomain.aggregate;

import org.springframework.util.SimpleIdGenerator;

public record SkuCreationParam(String name, Integer price, Integer num, String image, String attribute) {
    public SkuId getSkuId() {
        SimpleIdGenerator idGenerator = new SimpleIdGenerator();
        return new SkuId(idGenerator.generateId().toString());
    }
}
