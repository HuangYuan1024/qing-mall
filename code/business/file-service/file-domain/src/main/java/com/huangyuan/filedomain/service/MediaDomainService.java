package com.huangyuan.filedomain.service;

import com.huangyuan.filedomain.aggregate.Media;
import com.huangyuan.filedomain.repository.MediaRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

@Service
@AllArgsConstructor
public class MediaDomainService {

    private final MediaRepository repository;

    public Media uploadImage(MultipartFile file){
        String bucket = "image";
        String key  = (String) generateKey(file.getOriginalFilename());

        String url;
        try {
            url = repository.upload(bucket, key, file.getInputStream(), file.getSize(), file.getContentType());
        } catch (IOException e) {
            throw new RuntimeException(e);
        }

        return Media.create(bucket, key, file.getSize(),
                file.getContentType(), url);
    }

    public String generateKey(String s) {
        return s;
    }

    public String generatePresignedUrl(String image, String key, int i) {
        return repository.generatePresignedUrl(image, key, i);
    }
}
