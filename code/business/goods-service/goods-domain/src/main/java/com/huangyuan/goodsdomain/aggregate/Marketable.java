package com.huangyuan.goodsdomain.aggregate;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum Marketable {
    DOWN(0),
    UP(1);

    private final int code;

    boolean isUp() {
        return this == UP;
    }

}
