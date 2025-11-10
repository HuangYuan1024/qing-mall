package com.huangyuan.qingcommon.domain;

import java.io.Serializable;

/**
 * 领域实体超类型
 * @param <T> ID 类型
 */
public abstract class Entity<T extends Serializable> implements Serializable {

    /**
     * 子类必须实现：返回业务唯一标识
     */
    public abstract T getId();

    /**
     * 相等性只比较 ID；子类可重写更严格规则
     */
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Entity<?> entity)) return false;
        return getId() != null && getId().equals(entity.getId());
    }

    @Override
    public int hashCode() {
        return getId() == null ? 0 : getId().hashCode();
    }
}
