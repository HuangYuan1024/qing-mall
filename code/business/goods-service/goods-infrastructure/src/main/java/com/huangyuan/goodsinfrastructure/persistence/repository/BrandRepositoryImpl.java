package com.huangyuan.goodsinfrastructure.persistence.repository;

import cn.hutool.core.collection.CollUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huangyuan.goodsdomain.aggregate.Brand;
import com.huangyuan.goodsdomain.aggregate.BrandId;
import com.huangyuan.goodsdomain.repository.BrandRepository;
import com.huangyuan.goodsinfrastructure.persistence.converter.BrandPoConverter;
import com.huangyuan.goodsinfrastructure.persistence.mapper.BrandMapper;
import com.huangyuan.goodsinfrastructure.persistence.po.BrandPo;
import jakarta.validation.constraints.NotNull;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Repository
@RequiredArgsConstructor
public class BrandRepositoryImpl implements BrandRepository {

    private final BrandMapper mapper;
    private final BrandPoConverter converter;

    @Override
    public Brand save(Brand brand) {
        BrandPo po = converter.toPo(brand);
        if (mapper.existsById(po.getId())) {
            mapper.updateById(po);
        } else {
            mapper.insert(po);
        }
        return brand;
    }

    @Override
    public Optional<Brand> find(BrandId id) {
        return Optional.ofNullable(mapper.selectById(id.value()))
                .map(converter::toDomain);
    }

    @Override
    public boolean existsName(String name) {
        return mapper.exists(new LambdaQueryWrapper<BrandPo>().eq(BrandPo::getName, name));
    }

    @Override
    public List<Brand> listAll() {
        return mapper.selectList(null).stream()
                .map(converter::toDomain)
                .toList();
    }

    @Override
    public List<Brand> listByCondition(Brand brand) {
        if (brand == null) {
            return listAll();
        }
        QueryWrapper<BrandPo> queryWrapper = new QueryWrapper<>();
        if (brand.getName() != null) {
            queryWrapper.like("name", brand.getName());
        }
        if (brand.getInitial() != null) {
            queryWrapper.eq("initial", brand.getInitial());
        }
        return mapper.selectList(queryWrapper).stream()
                .map(converter::toDomain)
                .toList();
    }

    @Override
    public List<Brand> listByCategoryId(Integer categoryId) {
        List<Integer> brandIds = mapper.selectBrandIds(categoryId);
        if (CollUtil.isEmpty(brandIds)) {
            return Collections.emptyList();
        }

        List<BrandPo> brandPos = mapper.selectByBrandIds(brandIds);

        return brandPos.stream()
                .map(converter::toDomain)
                .toList();
    }

    @NotNull
    private Page<Brand> getBrandPage(Page<BrandPo> poPage) {
        Page<Brand> domainPage = new Page<>(poPage.getCurrent(), poPage.getSize(), poPage.getTotal());
        List<Brand> records = poPage.getRecords().stream()
                .map(converter::toDomain)
                .collect(Collectors.toList());

        domainPage.setRecords(records);

        return domainPage;
    }

    @Override
    public Page<Brand> page(Long current, Long size) {
        Page<BrandPo> poPage = mapper.selectPage(
                new Page<>(current, size),
                null
        );

        return getBrandPage(poPage);
    }

    @Override
    public Page<Brand> pageByName(Long current, Long size, String name) {
        Page<BrandPo> poPage = mapper.selectPage(
                new Page<>(current, size),
                Wrappers.<BrandPo>lambdaQuery()
                        .like(BrandPo::getName, name)
        );

        return getBrandPage(poPage);
    }

    @Override
    public int delete(Brand brand) {
        return mapper.deleteById(brand.getId().value());
    }
}