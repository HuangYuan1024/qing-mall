package com.huangyuan.goodsapplication.command;

import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.io.Serializable;

@Data
public class CreateSkuAttributeCmd implements Serializable {
    @NotBlank
    private String name;
    @NotBlank
    private String options;
    @NotNull
    private Integer sort;
}
