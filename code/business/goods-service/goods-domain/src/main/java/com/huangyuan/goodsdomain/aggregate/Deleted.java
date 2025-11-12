package com.huangyuan.goodsdomain.aggregate;

import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.Map;
import java.util.Optional;

@Getter
@AllArgsConstructor
public enum Deleted {
    NO(0),
    YES(1);

    private final int code;

    private static final Map<Integer, Deleted> CODE_MAP = Map.of(
            0, NO,
            1, YES
    );

    public static Deleted of(int code) {
        return Optional.ofNullable(CODE_MAP.get(code))
                .orElseThrow(() -> new IllegalArgumentException("非法删除状态码:" + code));
    }

    boolean isYes() {
        return this == YES;
    }

}
