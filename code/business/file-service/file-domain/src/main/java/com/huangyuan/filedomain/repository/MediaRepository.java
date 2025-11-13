package com.huangyuan.filedomain.repository;

import java.io.InputStream;

public interface MediaRepository {
    String upload(String bucket, String key, InputStream in, long size, String contentType);
    void delete(String bucket, String key);
    String generatePresignedUrl(String bucket, String key, int minutes);
}
