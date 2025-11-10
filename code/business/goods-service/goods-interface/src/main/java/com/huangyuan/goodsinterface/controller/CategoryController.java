package com.huangyuan.goodsinterface.controller;

import com.huangyuan.goodsapplication.dto.CategoryDto;
import com.huangyuan.goodsapplication.service.CategoryCommandService;
import com.huangyuan.goodsapplication.service.CategoryQueryService;
import com.huangyuan.qingcommon.result.RespResult;
import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/category")
public class CategoryController {


    private final CategoryCommandService commandService;
    private final CategoryQueryService queryService;

    /**
     * 根据父ID查询子分类
     */
    @GetMapping("/parent/{pid}")
    @Operation(summary = "根据父ID查询子分类")
    public RespResult<List<CategoryDto>> getCategoryByParentId(@PathVariable("pid") Integer pid) {
        List<CategoryDto> categories = queryService.listCategoriesByParentId(pid);
        return RespResult.ok(categories);
    }

}
