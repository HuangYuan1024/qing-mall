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
    public abstract T getIdValue();

    /**
     * 相等性只比较 ID；子类可重写更严格规则
     */
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Entity<?> entity)) return false;
        return getIdValue() != null && getIdValue().equals(entity.getIdValue());
    }

    @Override
    public int hashCode() {
        return getIdValue() == null ? 0 : getIdValue().hashCode();
    }
}
