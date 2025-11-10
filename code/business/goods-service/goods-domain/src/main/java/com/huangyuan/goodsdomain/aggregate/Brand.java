package com.huangyuan.goodsdomain.aggregate;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * Brand 聚合根
 */
@Getter
@AllArgsConstructor
public class Brand {

    private final BrandId id;
    private String name;
    private String image;
    private String initial;
    private Integer sort;

    public static Brand create(String name, String image, String initial, Integer sort) {
        return new Brand(null, name, image, initial, sort);
    }

    public static Brand update(BrandId id, String name, String image, String initial, Integer sort) {
        return new Brand(id, name, image, initial, sort);
    }

    public static Brand delete(BrandId id) {
        return new Brand(id, null, null, null, null);
    }

    /* ---------- 业务行为 ---------- */
    public void rename(String newName) {
        if (newName == null || newName.isBlank()) {
            throw new IllegalArgumentException("品牌名不能为空");
        }
        this.name = newName;
    }

    public void changeImage(String newImage) {
        this.image = newImage;
    }

    public void changeInitial(String newInitial) {
        this.initial = newInitial;
    }

    public void changeSort(Integer newSort) {
        this.sort = newSort;
    }

    public void delete() {
        this.name = null;
        this.image = null;
        this.initial = null;
        this.sort = null;
    }
}
