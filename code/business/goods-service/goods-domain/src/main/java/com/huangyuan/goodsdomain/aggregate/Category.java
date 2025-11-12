package com.huangyuan.goodsdomain.aggregate;

import lombok.AllArgsConstructor;
import lombok.Data;

/**
 * Category 聚合根
 */
@Data
@AllArgsConstructor
public class Category {

    private final CategoryId id;
    private String name;
    private Integer sort;
    private Integer parentId;

    public static Category create(String name, Integer sort, Integer parentId) {
        return new Category(null, name, sort, parentId);
    }
    public static Category update(CategoryId id, String name, Integer sort, Integer parentId) {
        return new Category(id, name, sort, parentId);
    }
    public static Category delete(CategoryId id) {
        return new Category(id, null, null, null);
    }
}
