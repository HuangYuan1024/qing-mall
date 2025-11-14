package com.huangyuan.goodsapplication.command;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.io.Serializable;

@Data
public class UpdateBrandCommand implements Serializable {
    @NotNull
    private Integer id;
    @NotBlank
    private String name;
    @NotBlank
    private String image;
    @NotBlank
    private String initial;
    @NotNull
    private Integer sort;
}
