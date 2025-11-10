package com.huangyuan.goodsinterface.controller;

import com.huangyuan.goodsapplication.dto.SkuAttributeDto;
import com.huangyuan.goodsapplication.service.SkuAttributeCommandService;
import com.huangyuan.goodsapplication.service.SkuAttributeQueryService;
import com.huangyuan.qingcommon.result.RespResult;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/skuAttribute")
public class SkuAttributeController {

    private final SkuAttributeCommandService commandService;
    private final SkuAttributeQueryService queryService;

    /**
     * 根据分类ID查询属性列表
     */
    @GetMapping("/category/{id}")
    public RespResult<List<SkuAttributeDto>> categoryAttributeList(@PathVariable("id") Integer id) {
        return RespResult.ok(queryService.listSkuAttributesByCategoryId(id));
    }

}
