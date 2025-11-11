package com.huangyuan.goodsapplication.command;

import lombok.Data;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

@Data
public class CreateSpuCommand implements Serializable {
    private final String name;
    private final String intro;
    private final Integer brandId;
    private final List<Integer> categoryIds;
    private final String afterSalesService;
    private final String contentHtml;
    private final Map<String, String> attributes;
    private final List<CreateSkuCommand> skus;

    public void validate() {
        if (name == null || name.isBlank()) {
            throw new IllegalArgumentException("商品名称不能为空");
        }
    }
}
