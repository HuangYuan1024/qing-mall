package com.huangyuan.goodsinfrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huangyuan.goodsdomain.aggregate.BrandId;
import com.huangyuan.goodsdomain.aggregate.CategoryPath;
import com.huangyuan.goodsdomain.aggregate.ImageList;
import com.huangyuan.goodsdomain.aggregate.Sku;
import com.huangyuan.goodsdomain.repository.SkuRepository;
import com.huangyuan.goodsinfrastructure.persistence.converter.SkuPoConverter;
import com.huangyuan.goodsinfrastructure.persistence.mapper.BrandMapper;
import com.huangyuan.goodsinfrastructure.persistence.mapper.CategoryMapper;
import com.huangyuan.goodsinfrastructure.persistence.mapper.SkuMapper;
import com.huangyuan.goodsinfrastructure.persistence.mapper.SpuMapper;
import com.huangyuan.goodsinfrastructure.persistence.po.SkuPo;
import com.huangyuan.goodsinfrastructure.persistence.po.SpuPo;
import jakarta.validation.constraints.NotNull;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Repository
@RequiredArgsConstructor
public class SkuRepositoryImpl implements SkuRepository {

    private final SkuMapper mapper;
    private final SpuMapper spuMapper;
    private final CategoryMapper categoryMapper;
    private final BrandMapper brandMapper;
    private final SkuPoConverter converter;

    @Override
    public void save(Sku sku) {
        SpuPo spuPo = spuMapper.selectById(sku.getSpuId().value());
        ImageList images = ImageList.create(spuPo.getImages());
        CategoryPath categoryPath = new CategoryPath(spuPo.getCategoryOneId(), spuPo.getCategoryTwoId(), spuPo.getCategoryThreeId());
        String categoryName = categoryMapper.selectById(categoryPath.threeId()).getName();
        BrandId brandId = new BrandId(spuPo.getBrandId());
        String brandName = brandMapper.selectById(brandId.value()).getName();
        SkuPo po = converter.toPo(sku, images, categoryPath, categoryName, brandId, brandName);
        if (mapper.existsById(po.getId())) {
            mapper.updateById(po);
        } else {
            mapper.insert(po);
        }
    }

    @Override
    public Optional<Sku> find(String id) {
        return Optional.ofNullable(mapper.selectById(id))
                .map(converter::toDomain);
    }

    @Override
    public void delete(Sku sku) {
        mapper.deleteById(sku.getId().value());
    }

    @Override
    public boolean existsName(String name) {
        return mapper.exists(new LambdaQueryWrapper<SkuPo>().eq(SkuPo::getName, name));
    }

    @Override
    public List<Sku> listAll() {
        return mapper.selectList(null).stream()
                .map(converter::toDomain)
                .toList();
    }

    @NotNull
    private Page<Sku> getSkuPage(Page<SkuPo> poPage) {
        Page<Sku> domainPage = new Page<>(poPage.getCurrent(), poPage.getSize(), poPage.getTotal());
        List<Sku> records = poPage.getRecords().stream()
                .map(converter::toDomain)
                .collect(Collectors.toList());

        domainPage.setRecords(records);

        return domainPage;
    }

    @Override
    public Page<Sku> page(Long current, Long size) {
        Page<SkuPo> poPage = mapper.selectPage(
                new Page<>(current, size),
                null
        );
        return getSkuPage(poPage);
    }

    @Override
    public List<Sku> listBySpuId(String spuId) {
        return mapper.selectBySpuId(spuId).stream()
                .map(converter::toDomain)
                .toList();
    }

    @Override
    public Page<Sku> pageBySpuId(Long current, Long size, String spuId) {
        Page<SkuPo> poPage = mapper.selectPage(
                new Page<>(current, size),
                Wrappers.<SkuPo>lambdaQuery()
                        .eq(SkuPo::getSpuId, spuId)
        );
        return getSkuPage(poPage);
    }

    @Override
    public void delete(String id) {
        mapper.deleteById(id);
    }

}
