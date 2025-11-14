package com.huangyuan.fileinterface.controller;

import com.huangyuan.fileapplication.dto.PresignDto;
import com.huangyuan.fileapplication.service.command.MediaCommandAppService;
import com.huangyuan.qingcommon.result.RespResult;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/media")
public class MediaController {

    private final MediaCommandAppService commandService;

    /**
     * 获取上传签名
     * @param ext 文件后缀
     * @param minutes 过期时间
     * @return 签名
     */
    @GetMapping("/signaturePut")
    public RespResult<PresignDto> signature(@RequestParam(value = "ext") String ext,
                                            @RequestParam(value = "minutes", defaultValue = "10") Integer minutes) {
        return RespResult.ok(commandService.getPresignPut(ext, minutes));
    }

    /**
     * 获取下载签名
     * @param key 文件名
     * @param minutes 过期时间
     * @return 签名
     */
    @GetMapping("/signatureGet/{key}")
    public RespResult<PresignDto> signatureGet(@PathVariable(value = "key") String key,
                                               @RequestParam(value = "minutes", defaultValue = "10") Integer minutes) {
        return RespResult.ok(commandService.getPresignGet(key, minutes));
    }
}
