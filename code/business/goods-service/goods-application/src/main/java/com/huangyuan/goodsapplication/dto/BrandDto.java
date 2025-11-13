package com.huangyuan.goodsapplication.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BrandDto implements Serializable {
    private Integer id;
    private String name;
    private String image;
    private String letter;
    private Integer sort;
}
