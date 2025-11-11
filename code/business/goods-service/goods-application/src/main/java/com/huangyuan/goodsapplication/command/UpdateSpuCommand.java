package com.huangyuan.goodsapplication.command;

import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

@Data
public class UpdateSpuCommand {

    @NotBlank
    private final String name;
    @NotBlank
    private final String intro;
    @NotNull
    private final Integer brandId;

    public void validate() {
        if (name == null || name.isBlank()) {
            throw new IllegalArgumentException("商品名称不能为空");
        }
    }
}
