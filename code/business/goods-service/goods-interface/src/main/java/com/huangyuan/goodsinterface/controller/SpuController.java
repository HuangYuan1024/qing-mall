package com.huangyuan.goodsinterface.controller;

import com.huangyuan.goodsapplication.command.CreateSpuCommand;
import com.huangyuan.goodsapplication.service.command.SpuCommandAppService;
import com.huangyuan.qingcommon.result.RespResult;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("/spu")
public class SpuController {

    private final SpuCommandAppService commandService;

    /**
     * 保存商品
     */
    @RequestMapping("/save")
    public RespResult<Void> save(@Valid @RequestBody CreateSpuCommand createSpuCommand) {
        commandService.createSpu(createSpuCommand);
        return RespResult.ok();
    }

    @RequestMapping("/updateStatus")
    public RespResult<Void> updateStatus(@RequestParam("spuId") String spuId,
                                         @RequestParam("statusCode") Integer statusCode) {
        commandService.updateGoodsStatus(spuId, statusCode);
        return RespResult.ok();
    }
}
