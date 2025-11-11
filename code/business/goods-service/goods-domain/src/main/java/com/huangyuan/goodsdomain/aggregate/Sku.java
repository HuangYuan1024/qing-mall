package com.huangyuan.goodsdomain.aggregate;

import com.huangyuan.qingcommon.domain.Entity;
import lombok.AllArgsConstructor;
import lombok.Getter;

import java.time.LocalDateTime;

/**
 * SKU 实体（生命周期受 SPU 控制）
 */
@Getter
@AllArgsConstructor
public class Sku extends Entity<String> {

    private final SkuId id;
    private final String name;
    private final Integer price;
    private final Integer num;
    private final String image;
    private final LocalDateTime createTime;
    private final LocalDateTime updateTime;
    private final SpuId spuId;
    private final String skuAttribute;
    private SkuStatus status;

    void offShelf() {
        this.status = SkuStatus.OFF;
    }

    boolean isActive() {
        return status == SkuStatus.ACTIVE;
    }
}