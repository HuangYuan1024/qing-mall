package com.huangyuan.goodsinfrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.huangyuan.goodsdomain.model.Brand;
import com.huangyuan.goodsdomain.model.BrandId;
import com.huangyuan.goodsdomain.repository.BrandRepository;
import com.huangyuan.goodsinfrastructure.persistence.mapper.BrandMapper;
import com.huangyuan.goodsinfrastructure.persistence.converter.BrandPoConverter;
import com.huangyuan.goodsinfrastructure.persistence.po.BrandPo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
@RequiredArgsConstructor
public class BrandRepositoryImpl implements BrandRepository {

    private final BrandMapper mapper;
    private final BrandPoConverter converter = BrandPoConverter.INSTANCE;

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
        return Optional.ofNullable(mapper.selectById(id.getValue()))
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
    public int delete(Brand brand) {
        return mapper.deleteById(brand.getId().getValue());
    }
}