package com.huangyuan.goodsapplication.command;

import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
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
