package com.huangyuan.filedomain.aggregate;

import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.Map;
import java.util.Optional;

@Getter
@AllArgsConstructor
public enum MediaStatus {
    UPLOADED(0),
    DELETED(1);

    private final int code;

    private static final Map<Integer, MediaStatus> CODE_MAP = Map.of(
            0, UPLOADED,
            1, DELETED
    );

    public static MediaStatus of(int code) {
        return Optional.ofNullable(CODE_MAP.get(code))
                .orElseThrow(() -> new IllegalArgumentException("非法媒体状态码:" + code));
    }
}
