package com.huangyuan.goodsapplication.service.impl;

import com.huangyuan.goodsapplication.dto.BrandDto;
import com.huangyuan.goodsapplication.service.BrandQueryService;
import com.huangyuan.goodsdomain.model.BrandId;
import com.huangyuan.goodsdomain.repository.BrandRepository;
import com.huangyuan.qingcommon.exception.BizException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class BrandQueryServiceImpl implements BrandQueryService {

    private final BrandRepository repository;

    public List<BrandDto> listBrands() {
        return repository.listAll().stream()
                .map(b -> new BrandDto(b.getId().getValue(), b.getName(), b.getImage(), b.getInitial(), b.getSort()))
                .toList();
    }

    public BrandDto getBrand(Integer id) {
        return repository.find(new BrandId(id))
                .map(b -> new BrandDto(b.getId().getValue(), b.getName(), b.getImage(), b.getInitial(), b.getSort()))
                .orElseThrow(() -> new BizException("品牌不存在"));
    }
}
