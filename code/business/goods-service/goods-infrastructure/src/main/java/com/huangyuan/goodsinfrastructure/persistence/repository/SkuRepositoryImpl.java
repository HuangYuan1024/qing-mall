package com.huangyuan.goodsinfrastructure.persistence.repository;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huangyuan.goodsdomain.aggregate.Sku;
import com.huangyuan.goodsdomain.repository.SkuRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@RequiredArgsConstructor
public class SkuRepositoryImpl implements SkuRepository {
    @Override
    public Sku save(Sku sku) {
        return null;
    }

    @Override
    public Sku findById(String id) {
        return null;
    }

    @Override
    public void delete(Sku sku) {

    }

    @Override
    public boolean existsName(String name) {
        return false;
    }

    @Override
    public List<Sku> listAll() {
        return List.of();
    }

    @Override
    public Page<Sku> page(Long current, Long size) {
        return null;
    }

    @Override
    public List<Sku> listBySpuId(String spuId) {
        return List.of();
    }

    @Override
    public Page<Sku> pageBySpuId(Long current, Long size, String spuId) {
        return null;
    }
}
