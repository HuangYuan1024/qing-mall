package com.huangyuan.goodsapplication.service.impl;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.plugins.pagination.PageDTO;
import com.huangyuan.goodsapplication.converter.BrandDtoConverter;
import com.huangyuan.goodsapplication.dto.BrandDto;
import com.huangyuan.goodsapplication.service.BrandQueryService;
import com.huangyuan.goodsdomain.model.Brand;
import com.huangyuan.goodsdomain.model.BrandId;
import com.huangyuan.goodsdomain.repository.BrandRepository;
import com.huangyuan.qingcommon.exception.BizException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import javax.validation.constraints.NotNull;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class BrandQueryServiceImpl implements BrandQueryService {

    private final BrandRepository repository;
    private final BrandDtoConverter converter;

    public List<BrandDto> listBrands(BrandDto brand) {
        if (brand == null) {
            return repository.listAll().stream()
                    .map(converter::toDto)
                    .toList();
        } else {
            return repository.listByCondition(converter.toDomain(brand)).stream()
                    .map(converter::toDto)
                    .toList();
        }
    }

    @NotNull
    private PageDTO<BrandDto> getBrandDtoPageDto(Page<Brand> page) {
        PageDTO<BrandDto> applicationPage = new PageDTO<>(page.getCurrent(), page.getSize(), page.getTotal());
        List<BrandDto> records = page.getRecords().stream()
                .map(converter::toDto)
                .collect(Collectors.toList());

        applicationPage.setRecords(records);
        return applicationPage;
    }

    @Override
    public PageDTO<BrandDto> pageBrands(Long pageNum, Long pageSize, BrandDto brand) {
        Page<Brand> poPage;

        if (brand == null || brand.getName() == null) {
            poPage = repository.page(pageNum, pageSize);
        } else {
            poPage = repository.pageByName(pageNum, pageSize, brand.getName());
        }

        return getBrandDtoPageDto(poPage);
    }

    @Override
    public List<BrandDto> listBrandsByCategoryId(Integer categoryId) {
        return repository.listByCategoryId(categoryId).stream()
                .map(converter::toDto)
                .toList();
    }

    public BrandDto getBrand(Integer id) {
        return repository.find(new BrandId(id))
                .map(converter::toDto)
                .orElseThrow(() -> new BizException("品牌不存在"));
    }
}
