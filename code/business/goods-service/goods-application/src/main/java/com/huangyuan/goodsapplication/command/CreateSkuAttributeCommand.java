package com.huangyuan.goodsapplication.command;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.io.Serializable;

@Data
public class CreateSkuAttributeCommand implements Serializable {
    @NotBlank
    private String name;
    @NotBlank
    private String options;
    @NotNull
    private Integer sort;
}
