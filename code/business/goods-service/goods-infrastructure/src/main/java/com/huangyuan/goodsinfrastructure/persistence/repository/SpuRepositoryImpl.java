package com.huangyuan.goodsinfrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huangyuan.goodsdomain.aggregate.Spu;
import com.huangyuan.goodsdomain.repository.SpuRepository;
import com.huangyuan.goodsinfrastructure.persistence.converter.SpuPoConverter;
import com.huangyuan.goodsinfrastructure.persistence.mapper.SpuMapper;
import com.huangyuan.goodsinfrastructure.persistence.po.SpuPo;
import jakarta.validation.constraints.NotNull;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Repository
@RequiredArgsConstructor
public class SpuRepositoryImpl implements SpuRepository {

    private final SpuMapper mapper;
    private final SpuPoConverter converter;

    @Override
    public void save(Spu spu) {
        SpuPo po = converter.toPo(spu);
        if (mapper.existsById(po.getId())) {
            mapper.updateById(po);
        } else {
            mapper.insert(po);
        }
    }

    @Override
    public Optional<Spu> find(String id) {
        return Optional.ofNullable(mapper.selectById(id))
                .map(converter::toDomain);
    }

    @Override
    public void delete(String id) {
        mapper.deleteById(id);
    }

    @Override
    public boolean existsName(String name) {
        return mapper.exists(new LambdaQueryWrapper<SpuPo>().eq(SpuPo::getName, name));
    }

    @Override
    public List<Spu> listAll() {
        return mapper.selectList(null).stream()
                .map(converter::toDomain)
                .toList();
    }

    @NotNull
    private Page<Spu> getSpuPage(Page<SpuPo> poPage) {
        Page<Spu> domainPage = new Page<>(poPage.getCurrent(), poPage.getSize(), poPage.getTotal());
        List<Spu> records = poPage.getRecords().stream()
                .map(converter::toDomain)
                .collect(Collectors.toList());

        domainPage.setRecords(records);

        return domainPage;
    }

    @Override
    public Page<Spu> page(Long current, Long size) {
        Page<SpuPo> poPage = mapper.selectPage(
                new Page<>(current, size),
                null
        );
        return getSpuPage(poPage);
    }
}
