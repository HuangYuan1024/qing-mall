package com.huangyuan.goodsdomain.model;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * SkuAttribute 聚合根
 */
@Getter
@AllArgsConstructor
public class SkuAttribute {

    private final SkuAttributeId id;
    private String name;
    private String options;
    private Integer sort;

    public static SkuAttribute create(String name, String options, Integer sort) {
        return new SkuAttribute(null, name, options, sort);
    }
    public static SkuAttribute update(SkuAttributeId id, String name, String options, Integer sort) {
        return new SkuAttribute(id, name, options, sort);
    }
    public static SkuAttribute delete(SkuAttributeId id) {
        return new SkuAttribute(id, null, null, null);
    }

}
