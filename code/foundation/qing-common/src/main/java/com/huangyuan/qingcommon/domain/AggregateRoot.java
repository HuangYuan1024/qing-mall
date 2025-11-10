package com.huangyuan.qingcommon.domain;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * 聚合根超类型
 * @param <T> ID 类型
 */
public abstract class AggregateRoot<T extends Serializable> extends Entity<T> {

    private final List<Object> domainEvents = new ArrayList<>();

    /* ---------- 事件相关 ---------- */

    protected void registerEvent(Object event) {
        domainEvents.add(event);
    }

    /**
     * 外部（通常是 Repository 或 ApplicationService）获取并清空事件
     */
    public List<Object> pollAllEvents() {
        List<Object> copy = List.copyOf(domainEvents);
        domainEvents.clear();
        return copy;
    }

    public boolean hasEvents() {
        return !domainEvents.isEmpty();
    }
}
