package com.huangyuan.goodsapplication.service.query;

import com.huangyuan.goodsapplication.converter.SpuDtoConverter;
import com.huangyuan.goodsapplication.dto.SpuDto;
import com.huangyuan.goodsdomain.repository.SpuRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class SpuQueryAppService {

    private final SpuRepository spuRepository;
    private final SpuDtoConverter converter;

    SpuDto getSpu(String id) {
        return spuRepository.find(id)
                .map(converter::toDto)
                .orElseThrow(() -> new RuntimeException("商品不存在"));
    }

    List<SpuDto> listSpus() {
        return spuRepository.listAll().stream()
                .map(converter::toDto)
                .toList();
    }
}
