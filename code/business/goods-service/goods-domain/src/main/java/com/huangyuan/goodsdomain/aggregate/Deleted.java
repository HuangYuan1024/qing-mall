package com.huangyuan.goodsdomain.aggregate;

import lombok.Getter;

@Getter
public enum Deleted {
    NO(0),
    YES(1);

    private final int value;

    Deleted(int value) {
        this.value = value;
    }

    boolean isYes() {
        return this == YES;
    }

}
