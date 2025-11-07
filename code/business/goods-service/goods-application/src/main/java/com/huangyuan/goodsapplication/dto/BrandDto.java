package com.huangyuan.goodsapplication.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.io.Serializable;

@Data
@AllArgsConstructor
public class BrandDto implements Serializable {
    private Integer id;
    private String name;
    private String image;
    private String initial;
    private Integer sort;
}
