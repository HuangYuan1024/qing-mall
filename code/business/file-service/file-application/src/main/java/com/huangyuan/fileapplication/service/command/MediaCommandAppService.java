package com.huangyuan.fileapplication.service.command;

import com.huangyuan.fileapplication.converter.MediaDtoConverter;
import com.huangyuan.fileapplication.dto.PresignDto;
import com.huangyuan.filedomain.service.MediaDomainService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@Service
@Transactional
@AllArgsConstructor
public class MediaCommandAppService {

    private final MediaDomainService domainService;   // 领域服务
    private final MediaDtoConverter converter;

    public PresignDto getPresignPut(String ext, Integer minutes) {
        String key = domainService.generateKey(ext);
        String url = domainService.generatePresignedPutUrl("image", key, minutes);
        return new PresignDto(url, key, (long) (minutes * 60));
    }

    public PresignDto getPresignGet(String key, Integer minutes) {
        String url = domainService.generatePresignedGetUrl("image", key, minutes);
        return new PresignDto(url, key, (long) (minutes * 60));
    }
}
