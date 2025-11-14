package com.huangyuan.goodsapplication.command;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

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