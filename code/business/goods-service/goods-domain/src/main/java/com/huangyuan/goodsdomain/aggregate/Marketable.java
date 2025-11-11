package com.huangyuan.goodsdomain.aggregate;

import com.huangyuan.qingcommon.exception.BizException;
import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.Map;
import java.util.Optional;

@Getter
@AllArgsConstructor
public enum Marketable {
    DOWN(0),
    UP(1);

    private final int code;

    private static final Map<Integer, Marketable> CODE_MAP = Map.of(
            0, DOWN,
            1, UP
    );

    public static Marketable of(int code) {
        return Optional.ofNullable(CODE_MAP.get(code))
                .orElseThrow(() -> new BizException("非法上架状态码:" + code));
    }

    public boolean isUp() {
        return this == UP;
    }
}
