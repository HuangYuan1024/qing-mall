package com.huangyuan.goodsapplication.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.io.Serializable;

@Data
@AllArgsConstructor
public class SkuAttributeDto implements Serializable {
    private Integer id;
    private String name;
    private String options;
    private Integer sort;
}
