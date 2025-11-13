package com.huangyuan.goodsapplication.service.query;

import com.huangyuan.goodsapplication.converter.SkuAttributeDtoConverter;
import com.huangyuan.goodsapplication.dto.SkuAttributeDto;
import com.huangyuan.goodsdomain.aggregate.SkuAttributeId;
import com.huangyuan.goodsdomain.repository.SkuAttributeRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class SkuAttributeQueryAppService {

    private final SkuAttributeRepository repository;
    private final SkuAttributeDtoConverter converter;

    public List<SkuAttributeDto> listSkuAttributes() {
        return repository.listAll().stream()
                .map(converter::toDto)
                .toList();
    }

    public List<SkuAttributeDto> listSkuAttributesByCategoryId(Integer categoryId) {
        return repository.listByCategoryId(categoryId).stream()
                .map(converter::toDto)
                .toList();
    }

    public SkuAttributeDto getSkuAttribute(Integer id) {
        return repository.find(new SkuAttributeId(id))
                .map(converter::toDto)
                .orElseThrow(() -> new RuntimeException("属性不存在"));
    }
}
