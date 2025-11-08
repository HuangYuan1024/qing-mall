package com.huangyuan.goodsinterface.controller;

import com.huangyuan.goodsapplication.command.ChangeBrandCmd;
import com.huangyuan.goodsapplication.command.CreateBrandCmd;
import com.huangyuan.goodsapplication.dto.BrandDto;
import com.huangyuan.goodsapplication.service.BrandCommandService;
import com.huangyuan.goodsapplication.service.BrandQueryService;
import com.huangyuan.qingcommon.result.RespResult;
import io.swagger.v3.oas.annotations.Operation;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/brand")
public class BrandController {

    private final BrandCommandService commandService;
    private final BrandQueryService queryService;

    /**
     *  增加品牌功能
     */
    @PostMapping("/addBrand")
    @Operation(summary = "添加品牌")
    public RespResult<Void> create(@Valid @RequestBody CreateBrandCmd cmd) {
        commandService.createBrand(cmd);
        return RespResult.ok();
    }

    // 根据id 去得到一个品牌信息
    @GetMapping("/getBrandById/{id}")
    @Operation(summary = "根据id查询品牌")
    public RespResult<BrandDto> getBrandById(@PathVariable("id") Integer id){
        BrandDto brand = queryService.getBrand(id);
        return RespResult.ok(brand);
    }

    // 修改实现
    @PutMapping("/updateBrand")
    @Operation(summary = "修改品牌")
    public RespResult<Void> updateBrand(@Valid @RequestBody ChangeBrandCmd cmd){
        commandService.updateBrand(cmd);
        return RespResult.ok();
    }

    // 删除品牌
    @DeleteMapping("/deleteBrand/{id}")
    @Operation(summary = "删除品牌")
    public RespResult<Void> deleteBrand(@PathVariable("id") Integer id){
        commandService.deleteBrand(id);
        return RespResult.ok();
    }

}

