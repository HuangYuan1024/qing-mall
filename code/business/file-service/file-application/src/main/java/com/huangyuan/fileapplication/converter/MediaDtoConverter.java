package com.huangyuan.fileapplication.converter;

import com.huangyuan.fileapplication.dto.MediaDto;
import com.huangyuan.filedomain.aggregate.Media;
import lombok.NoArgsConstructor;
import org.springframework.stereotype.Component;

@Component
@NoArgsConstructor
public final class MediaDtoConverter {

    public MediaDto toDto(Media media) {
        if (media == null) return null;
        return new MediaDto(
                media.getId().value(),
                media.getUrl()
        );
    }
}
