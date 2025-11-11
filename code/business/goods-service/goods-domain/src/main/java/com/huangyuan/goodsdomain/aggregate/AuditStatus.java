package com.huangyuan.goodsdomain.aggregate;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum AuditStatus {
    PENDING(0),
    PASSED(1),
    REJECTED(2);

    private final int code;
}
