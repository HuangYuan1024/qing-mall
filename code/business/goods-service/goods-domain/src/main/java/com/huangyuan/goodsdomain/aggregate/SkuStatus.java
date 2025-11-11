package com.huangyuan.goodsdomain.aggregate;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum SkuStatus {
    ACTIVE(1),
    OFF(2),
    DELETED(3);

    private final int code;
}
