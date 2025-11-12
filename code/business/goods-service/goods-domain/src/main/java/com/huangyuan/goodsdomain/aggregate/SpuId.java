package com.huangyuan.goodsdomain.aggregate;

import java.io.Serializable;

public record SpuId(String value) implements Serializable {
    public String getValue() {
        return value;
    }
}
