package com.huangyuan.goodsdomain.aggregate;

import com.huangyuan.qingcommon.domain.Entity;
import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * SKU 实体（生命周期受 SPU 控制）
 */
@Getter
@AllArgsConstructor
public class Sku extends Entity<String> {

    private final SkuId id;
    private final String name;
    private final Integer price; // 分
    private final Integer num;
    private final String image;
    private final String attrText; // 规格描述
    private final SpuId spuId;    // 归属

    private SkuStatus status;

    /* 包可见构造：只允许聚合根创建 */
    Sku(SkuId id, String name, Integer price, Integer num,
        String image, String attrText, Spu spu) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.num = num;
        this.image = image;
        this.attrText = attrText;
        this.spuId = spu.getId();
        this.status = SkuStatus.ACTIVE;
    }

    void offShelf() {
        this.status = SkuStatus.OFF;
    }

    boolean isActive() {
        return status == SkuStatus.ACTIVE;
    }
}