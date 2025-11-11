package com.huangyuan.goodsdomain.event;

import com.huangyuan.goodsdomain.aggregate.BrandId;
import com.huangyuan.goodsdomain.aggregate.CategoryPath;
import com.huangyuan.goodsdomain.aggregate.SpuId;
import com.huangyuan.qingcommon.domain.DomainEvent;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class SpuUpdatedEvent extends DomainEvent {

    private final SpuId spuId;
    private final String spuName;
    private final BrandId brandId;
    private final CategoryPath categoryPath;

    @Override
    public String getEventType() {
        return "SpuUpdateEvent";
    }
}
