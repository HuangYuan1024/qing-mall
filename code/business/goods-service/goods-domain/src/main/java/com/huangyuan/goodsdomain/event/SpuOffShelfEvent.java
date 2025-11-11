package com.huangyuan.goodsdomain.event;

import com.huangyuan.goodsdomain.aggregate.SpuId;
import com.huangyuan.qingcommon.domain.DomainEvent;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class SpuOffShelfEvent extends DomainEvent {
    private final SpuId spuId;

    private final String reason;

    @Override
    public String getEventType() {
        return "";
    }
}
