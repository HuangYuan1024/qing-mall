package com.huangyuan.qingcommon.domain;

import lombok.Getter;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.UUID;

@Getter
public abstract class DomainEvent implements Serializable {

    private final String eventId;
    private final LocalDateTime timestamp;

    public DomainEvent() {
        this.eventId = UUID.randomUUID().toString();
        this.timestamp = LocalDateTime.now();
    }

    public DomainEvent(String eventId, LocalDateTime timestamp) {
        this.eventId = eventId;
        this.timestamp = timestamp;
    }

    public abstract String getEventType();
}
