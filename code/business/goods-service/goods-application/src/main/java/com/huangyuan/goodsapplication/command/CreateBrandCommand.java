package com.huangyuan.goodsapplication.command;

import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.io.Serializable;

@Data
public class CreateBrandCommand implements Serializable {
    @NotBlank
    private String name;
    @NotBlank
    private String image;
    @NotBlank
    private String letter;
    @NotNull
    private Integer sort;
}