package com.huangyuan.goodsdomain.aggregate;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum Deleted {
    NO(0),
    YES(1);

    private final int code;

    boolean isYes() {
        return this == YES;
    }

}
