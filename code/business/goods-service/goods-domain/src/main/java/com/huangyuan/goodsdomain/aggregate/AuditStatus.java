package com.huangyuan.goodsdomain.aggregate;

import lombok.Getter;

@Getter
public enum AuditStatus {
    PENDING(0),
    PASSED(1),
    REJECTED(2);

    private final int value;

    AuditStatus(int value) {
        this.value = value;
    }
}
