package com.huangyuan.goodsapplication.command;

import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
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
