package com.huangyuan.goodsdomain.aggregate;

import java.io.Serializable;
import java.util.List;

public record ImageList(List<String> urls) implements Serializable {

    public static ImageList create(String urls) {
        // 按逗号划分字符串，转化为列表并返回
        return new ImageList(List.of(urls.split(",")));
    }

    public static ImageList empty() {
        return new ImageList(List.of());
    }
}
