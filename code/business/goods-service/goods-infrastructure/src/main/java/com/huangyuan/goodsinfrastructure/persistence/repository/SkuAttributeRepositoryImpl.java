package com.huangyuan.goodsinfrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.huangyuan.goodsdomain.aggregate.SkuAttribute;
import com.huangyuan.goodsdomain.aggregate.SkuAttributeId;
import com.huangyuan.goodsdomain.repository.SkuAttributeRepository;
import com.huangyuan.goodsinfrastructure.persistence.converter.SkuAttributePoConverter;
import com.huangyuan.goodsinfrastructure.persistence.mapper.SkuAttributeMapper;
import com.huangyuan.goodsinfrastructure.persistence.po.SkuAttributePo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
@RequiredArgsConstructor
public class SkuAttributeRepositoryImpl implements SkuAttributeRepository {

    private final SkuAttributeMapper mapper;
    private final SkuAttributePoConverter converter = SkuAttributePoConverter.INSTANCE;

    @Override
    public void save(SkuAttribute skuAttribute) {
        SkuAttributePo po = converter.toPo(skuAttribute);
        if (mapper.existsById(po.getId())) {
            mapper.updateById(po);
        } else {
            mapper.insert(po);
        }
    }

    @Override
    public Optional<SkuAttribute> find(SkuAttributeId id) {
        return Optional.ofNullable(mapper.selectById(id.value()))
                .map(converter::toDomain);
    }

    @Override
    public boolean existsName(String name) {
        return mapper.exists(new LambdaQueryWrapper<SkuAttributePo>().eq(SkuAttributePo::getName, name));
    }

    @Override
    public List<SkuAttribute> listAll() {
        return mapper.selectList(null).stream()
                .map(converter::toDomain)
                .toList();
    }

    @Override
    public List<SkuAttribute> listByCategoryId(Integer categoryId) {
        return mapper.selectByCategoryId(categoryId).stream()
                .map(converter::toDomain)
                .toList();
    }

    @Override
    public int delete(SkuAttribute skuAttribute) {
        return mapper.deleteById(skuAttribute.getId().value());
    }
}
