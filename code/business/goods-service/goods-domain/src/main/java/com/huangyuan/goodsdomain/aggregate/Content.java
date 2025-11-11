package com.huangyuan.goodsdomain.aggregate;

import java.io.Serializable;

public record Content(String html) implements Serializable {
    public static Content empty() {
        return new Content("空");
    }
}
