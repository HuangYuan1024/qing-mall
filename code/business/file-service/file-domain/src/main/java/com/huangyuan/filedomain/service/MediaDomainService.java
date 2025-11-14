package com.huangyuan.filedomain.service;

import com.huangyuan.filedomain.repository.MediaRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.Random;

@Service
@AllArgsConstructor
public class MediaDomainService {

    private final MediaRepository repository;

    public String generateKey(String s) {
        LocalDateTime now = LocalDateTime.now();
        Random random = new Random();
        int i = random.nextInt(1000000);
        return now.toString() + i + s;
    }

    public String generatePresignedGetUrl(String image, String key, int i) {
        return repository.generatePresignedGetUrl(image, key, i);
    }

    public String generatePresignedPutUrl(String image, String key, int i) {
        return repository.generatePresignedPutUrl(image, key, i);
    }
}
