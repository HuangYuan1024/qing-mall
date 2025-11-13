package com.huangyuan.goodsapplication.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class SkuAttributeDto implements Serializable {
    private Integer id;
    private String name;
    private String options;
    private Integer sort;
}
