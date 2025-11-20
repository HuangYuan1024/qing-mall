package com.huangyuan.goodsdomain.event;

import com.huangyuan.goodsdomain.aggregate.AuditStatus;
import lombok.Getter;

import java.time.LocalDateTime;

@Getter
public class GoodsStatusChangedEvent {
    private final String goodsId;
    private final AuditStatus oldStatus;
    private final AuditStatus newStatus;
    private final LocalDateTime occurredOn;
    
    public GoodsStatusChangedEvent(String goodsId, AuditStatus oldStatus, AuditStatus newStatus) {
        this.goodsId = goodsId;
        this.oldStatus = oldStatus;
        this.newStatus = newStatus;
        this.occurredOn = LocalDateTime.now();
    }
}