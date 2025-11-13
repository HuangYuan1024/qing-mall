package com.huangyuan.goodsapplication.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CategoryDto implements Serializable {
    private Integer id;
    private String name;
    private Integer sort;
    private Integer parentId;
}
