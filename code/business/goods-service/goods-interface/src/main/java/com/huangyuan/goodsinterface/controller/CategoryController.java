package com.huangyuan.goodsinterface.controller;

import com.huangyuan.goodsapplication.command.CreateCategoryCommand;
import com.huangyuan.goodsapplication.dto.CategoryDto;
import com.huangyuan.goodsapplication.service.command.CategoryCommandAppService;
import com.huangyuan.goodsapplication.service.query.CategoryQueryAppService;
import com.huangyuan.qingcommon.result.RespResult;
import io.swagger.v3.oas.annotations.Operation;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/category")
public class CategoryController {


    private final CategoryCommandAppService commandService;
    private final CategoryQueryAppService queryService;

    /**
     * 添加分类
     */
    @PostMapping("/addCategory")
    @Operation(summary = "添加分类")
    public RespResult<Void> create(@Valid @RequestBody CreateCategoryCommand command) {
        commandService.createCategory(command);
        return RespResult.ok();
    }

    /**
     * 根据父ID查询子分类
     */
    @GetMapping("/parent/{id}")
    @Operation(summary = "根据父ID查询子分类")
    public RespResult<List<CategoryDto>> getCategoryByParentId(@PathVariable("id") Integer id) {
        List<CategoryDto> categories = queryService.listCategoriesByParentId(id);
        return RespResult.ok(categories);
    }

}
