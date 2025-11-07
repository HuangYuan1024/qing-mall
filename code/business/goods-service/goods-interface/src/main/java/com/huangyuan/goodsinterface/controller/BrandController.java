package com.huangyuan.goodsinterface.controller;

import com.huangyuan.goodsapplication.command.ChangeBrandCmd;
import com.huangyuan.goodsapplication.command.CreateBrandCmd;
import com.huangyuan.goodsapplication.dto.BrandDto;
import com.huangyuan.goodsapplication.service.impl.BrandCommandServiceImpl;
import com.huangyuan.goodsapplication.service.impl.BrandQueryServiceImpl;
import com.huangyuan.qingcommon.result.RespResult;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/brand")
public class BrandController {

    private final BrandCommandServiceImpl commandService;
    private final BrandQueryServiceImpl queryService;

    /**
     *  增加品牌功能
     * @param cmd
     * @return
     */
    @PostMapping("/addBrand")
    public RespResult create(@Valid @RequestBody CreateBrandCmd cmd) {
        commandService.createBrand(cmd);
        return RespResult.ok();
    }

    @GetMapping("/getBrandById/{id}")
    // 根据id 去得到一个品牌信息
    public RespResult getBrandById(@PathVariable("id") Integer id){
        BrandDto brand = queryService.getBrand(id);
        return RespResult.ok(brand);
    }

    // 修改实现
    @PostMapping("/upateBrand")
    public RespResult upateBrand(@RequestBody ChangeBrandCmd cmd){
        commandService.updateBrand(cmd.getId(),cmd);
        return RespResult.ok();
    }

    // 删除品牌
    @DeleteMapping("/deleteBrand/{id}")
    public RespResult deleteBrand(@PathVariable("id") Integer id){
        commandService.deleteBrand(id);
        return RespResult.ok();
    }

}

