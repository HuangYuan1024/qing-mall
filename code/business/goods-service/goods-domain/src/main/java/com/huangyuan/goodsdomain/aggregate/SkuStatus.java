package com.huangyuan.goodsdomain.aggregate;

import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.Map;
import java.util.Optional;

@Getter
@AllArgsConstructor
public enum SkuStatus {
    ACTIVE(1),
    OFF(2),
    DELETED(3);

    private final int code;

    private static final Map<Integer, SkuStatus> CODE_MAP = Map.of(
            1, ACTIVE,
            2, OFF,
            3, DELETED
    );

    public static SkuStatus of(int code) {
        return Optional.ofNullable(CODE_MAP.get(code))
                .orElseThrow(() -> new IllegalArgumentException("非法SKU状态码:" + code));
    }
}
