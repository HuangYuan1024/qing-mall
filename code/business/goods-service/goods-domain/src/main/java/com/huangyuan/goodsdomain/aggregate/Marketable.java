package com.huangyuan.goodsdomain.aggregate;

import lombok.Getter;

@Getter
public enum Marketable {
    DOWN(0),
    UP(1);

    private final int value;

    Marketable(int value) {
        this.value = value;
    }

    boolean isUp() {
        return this == UP;
    }

}
