package com.huangyuan.goodsinterface.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.PageDTO;
import com.huangyuan.goodsapplication.command.CreateBrandCommand;
import com.huangyuan.goodsapplication.command.UpdateBrandCommand;
import com.huangyuan.goodsapplication.dto.BrandDto;
import com.huangyuan.goodsapplication.service.command.BrandCommandAppService;
import com.huangyuan.goodsapplication.service.query.BrandQueryAppService;
import com.huangyuan.qingcommon.result.RespResult;
import io.swagger.v3.oas.annotations.Operation;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/brand")
public class BrandController {

    private final BrandCommandAppService commandService;
    private final BrandQueryAppService queryService;

    /**
     *  增加品牌
     */
    @PostMapping("/addBrand")
    @Operation(summary = "添加品牌")
    public RespResult<Void> create(@Valid @RequestBody CreateBrandCommand cmd) {
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
    public RespResult<Void> updateBrand(@Valid @RequestBody UpdateBrandCommand cmd){
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

    @GetMapping("/listBrands")
    @Operation(summary = "查询品牌列表(条件查询)")
    public RespResult<List<BrandDto>> listBrands(@Valid BrandDto brand){
        return RespResult.ok(queryService.listBrands(brand));
    }

    @GetMapping("/pageBrands")
    @Operation(summary = "分页查询品牌(条件查询)")
    public RespResult<PageDTO<BrandDto>> pageBrands(@RequestParam("pageNum") Long pageNum,
                                                    @RequestParam("pageSize") Long pageSize,
                                                    @Valid BrandDto brand){
        return RespResult.ok(queryService.pageBrands(pageNum, pageSize, brand));
    }

    @GetMapping("/category/{id}")
    @Operation(summary = "根据分类id查询品牌列表")
    public RespResult<List<BrandDto>> listBrandsByCategoryId(@PathVariable("id") Integer id){
        return RespResult.ok(queryService.listBrandsByCategoryId(id));
    }

}
