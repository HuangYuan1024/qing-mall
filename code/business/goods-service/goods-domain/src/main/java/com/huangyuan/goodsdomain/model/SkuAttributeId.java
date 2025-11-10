package com.huangyuan.goodsdomain.model;

import lombok.AllArgsConstructor;
import lombok.Getter;

import java.io.Serializable;

@Getter
@AllArgsConstructor
public class SkuAttributeId implements Serializable {
    private final Integer value;
}
