package com.huangyuan.fileinterface.controller;

import com.huangyuan.fileapplication.dto.MediaDto;
import com.huangyuan.fileapplication.dto.PresignDto;
import com.huangyuan.fileapplication.service.command.MediaCommandAppService;
import com.huangyuan.qingcommon.result.RespResult;
import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequiredArgsConstructor
@RequestMapping("/media")
public class MediaController {

    private final MediaCommandAppService commandService;

    /** 管理后台上传 */
    @PostMapping(value = "/upload/image", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public RespResult<MediaDto> uploadImage(@RequestPart("file") MultipartFile file) {
        return RespResult.ok(commandService.uploadImage(file));
    }

    /** 前端直传签名 */
    @GetMapping("/signature")
    public RespResult<PresignDto> signature(@RequestParam String ext,
                                            @RequestParam(defaultValue = "10") int minutes) {
        return RespResult.ok(commandService.getPresign(ext, minutes));
    }
}
