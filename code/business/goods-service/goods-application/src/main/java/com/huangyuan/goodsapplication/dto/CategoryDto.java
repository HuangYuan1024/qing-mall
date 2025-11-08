package com.huangyuan.goodsapplication.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.io.Serializable;

@Data
@AllArgsConstructor
public class CategoryDto implements Serializable {
    private Integer id;
    private String name;
    private Integer sort;
    private Integer parentId;
}
