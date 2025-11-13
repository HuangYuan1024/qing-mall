package com.huangyuan.fileapplication.service.command;

import com.huangyuan.fileapplication.converter.MediaDtoConverter;
import com.huangyuan.fileapplication.dto.MediaDto;
import com.huangyuan.fileapplication.dto.PresignDto;
import com.huangyuan.filedomain.aggregate.Media;
import com.huangyuan.filedomain.service.MediaDomainService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;


@Service
@Transactional
@AllArgsConstructor
public class MediaCommandAppService {

    private final MediaDomainService domainService;   // 领域服务
    private final MediaDtoConverter converter;

    @Transactional   // 仅包裹本地 DB 操作
    public MediaDto uploadImage(MultipartFile file) {
        Media media = domainService.uploadImage(file);
        return converter.toDto(media);
    }

    public PresignDto getPresign(String ext, Integer minutes) {
        String key = domainService.generateKey("file." + ext);
        String url = domainService.generatePresignedUrl("image", key, minutes);
        return new PresignDto(url, key, (long) (minutes * 60));
    }
}
