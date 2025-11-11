package com.huangyuan.goodsdomain.aggregate;

import java.io.Serializable;
import java.util.Map;

public record AttributeList(String json) implements Serializable {
    public static AttributeList empty() {
        return new AttributeList("{}");
    }

    public static AttributeList fromMap(Map<String, String> attributes) {
        return new AttributeList(attributes.entrySet().stream()
                .map(entry -> "{\"name\":\"" + entry.getKey() + "\",\"value\":\"" + entry.getValue() + "\"}")
                .reduce((a, b) -> a + "," + b)
                .map(s -> "[" + s + "]")
                .orElse("[]"));
    }
}
