package com.huangyuan.goodsdomain.event;

import com.huangyuan.goodsdomain.aggregate.SpuId;
import com.huangyuan.qingcommon.domain.DomainEvent;
import lombok.Getter;

@Getter
public class SpuOnShelfEvent extends DomainEvent {
    private final SpuId spuId;

    public SpuOnShelfEvent(SpuId spuId) {
        this.spuId = spuId;
    }

    @Override
    public String getEventType() {
        return "SpuOnShelfEvent";
    }
}
