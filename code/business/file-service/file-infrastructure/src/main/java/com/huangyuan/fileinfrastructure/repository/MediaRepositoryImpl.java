package com.huangyuan.fileinfrastructure.repository;

import com.huangyuan.filedomain.repository.MediaRepository;
import com.huangyuan.fileinfrastructure.config.MinioConfig;
import com.huangyuan.qingcommon.exception.BizException;
import io.minio.*;
import io.minio.http.Method;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.io.InputStream;
import java.util.concurrent.TimeUnit;

@Repository
@RequiredArgsConstructor
public class MediaRepositoryImpl implements MediaRepository {

    private final MinioConfig minioConfig;
    private final MinioClient minioClient;

    @Override
    public String upload(String bucket, String key, InputStream in,
                         long size, String contentType) {
        try {
            if (!minioClient.bucketExists(BucketExistsArgs.builder().bucket(bucket).build())) {
                minioClient.makeBucket(MakeBucketArgs.builder().bucket(bucket).build());
                // 公共读策略
                String policy = """
                        {"Version":"2012-10-17","Statement":[{"Effect":"Allow","Principal":"*","Action":"s3:GetObject","Resource":"arn:aws:s3:::%s/*"}]}
                        """.formatted(bucket);
                minioClient.setBucketPolicy(SetBucketPolicyArgs.builder().bucket(bucket).config(policy).build());
            }
            minioClient.putObject(
                    PutObjectArgs.builder()
                            .bucket(bucket)
                            .object(key)
                            .stream(in, size, -1)
                            .contentType(contentType)
                            .build());
            // 返回永久直链
            return "%s/%s/%s".formatted(minioConfig.getEndpoint(), bucket, key);
        } catch (Exception e) {
            throw new BizException("FILE_UPLOAD_FAILED", e.getMessage());
        }
    }

    @Override
    public String generatePresignedUrl(String bucket, String key, int minutes) {
        try {
            return minioClient.getPresignedObjectUrl(
                    GetPresignedObjectUrlArgs.builder()
                            .method(Method.GET)
                            .bucket(bucket)
                            .object(key)
                            .expiry(minutes, TimeUnit.MINUTES)
                            .build());
        } catch (Exception e) {
            throw new BizException("FILE_PRESIGN_FAILED", e.getMessage());
        }
    }

    @Override
    public void delete(String bucket, String key) {
        try {
            minioClient.removeObject(RemoveObjectArgs.builder().bucket(bucket).object(key).build());
        } catch (Exception e) {
            throw new BizException("FILE_DELETE_FAILED", e.getMessage());
        }
    }
}
