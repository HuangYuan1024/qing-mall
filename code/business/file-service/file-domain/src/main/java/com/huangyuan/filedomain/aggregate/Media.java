package com.huangyuan.filedomain.aggregate;

import com.baomidou.mybatisplus.core.toolkit.IdWorker;
import com.huangyuan.qingcommon.domain.AggregateRoot;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 媒体聚合根
 */
@Data
@AllArgsConstructor
@NoArgsConstructor(access = AccessLevel.PROTECTED) // 防止外部 new
public class Media extends AggregateRoot<MediaId> {

    private MediaId id;
    private String bucket;
    private String objectKey;
    private long size;
    private String contentType;
    private String url;          // 只读直链
    private MediaStatus status;  // UPLOADED / DELETED

    public static Media create(String bucket, String objectKey, long size,
                               String contentType, String url) {
        return new Media(new MediaId(IdWorker.getId()), bucket, objectKey,
                size, contentType, url, MediaStatus.UPLOADED);
    }
}
