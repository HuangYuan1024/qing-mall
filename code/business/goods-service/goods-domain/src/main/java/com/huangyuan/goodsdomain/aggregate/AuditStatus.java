package com.huangyuan.goodsdomain.aggregate;

import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.Map;
import java.util.Optional;

@Getter
@AllArgsConstructor
public enum AuditStatus {
    PENDING(0),
    PASSED(1),
    REJECTED(2);

    private final int code;

    private static final Map<Integer, AuditStatus> CODE_MAP = Map.of(
            0, PENDING,
            1, PASSED,
            2, REJECTED
    );

    public static AuditStatus of(int code) {
        return Optional.ofNullable(CODE_MAP.get(code))
                .orElseThrow(() -> new IllegalArgumentException("非法审核状态码:" + code));
    }
}
