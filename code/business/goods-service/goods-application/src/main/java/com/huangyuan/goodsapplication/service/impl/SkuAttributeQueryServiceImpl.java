package com.huangyuan.goodsapplication.service.impl;

import com.huangyuan.goodsapplication.converter.SkuAttributeDtoConverter;
import com.huangyuan.goodsapplication.dto.SkuAttributeDto;
import com.huangyuan.goodsapplication.service.SkuAttributeQueryService;
import com.huangyuan.goodsdomain.model.SkuAttributeId;
import com.huangyuan.goodsdomain.repository.SkuAttributeRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class SkuAttributeQueryServiceImpl implements SkuAttributeQueryService {

    private final SkuAttributeRepository repository;
    private final SkuAttributeDtoConverter converter = SkuAttributeDtoConverter.INSTANCE;

    @Override
    public List<SkuAttributeDto> listSkuAttributes() {
        return repository.listAll().stream()
                .map(converter::toDto)
                .toList();
    }

    @Override
    public List<SkuAttributeDto> listSkuAttributesByCategoryId(Integer categoryId) {
        return repository.listByCategoryId(categoryId).stream()
                .map(converter::toDto)
                .toList();
    }

    @Override
    public SkuAttributeDto getSkuAttribute(Integer id) {
        return repository.find(new SkuAttributeId(id))
                .map(converter::toDto)
                .orElseThrow(() -> new RuntimeException("属性不存在"));
    }
}
