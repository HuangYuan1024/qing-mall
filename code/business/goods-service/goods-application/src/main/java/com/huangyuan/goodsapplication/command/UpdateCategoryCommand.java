package com.huangyuan.goodsapplication.command;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.io.Serializable;

@Data
public class UpdateCategoryCommand implements Serializable {
    @NotNull
    private Integer id;
    @NotBlank
    private String name;
    @NotNull
    private Integer sort;
    @NotNull
    private Integer parentId;
}
