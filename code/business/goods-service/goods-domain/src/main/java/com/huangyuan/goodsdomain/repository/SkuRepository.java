package com.huangyuan.goodsdomain.repository;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huangyuan.goodsdomain.aggregate.Sku;

import java.util.List;

public interface SkuRepository {
    Sku save(Sku sku);
    Sku findById(String id);
    void delete(Sku sku);
    boolean existsName(String name);
    List<Sku> listAll();
    Page<Sku> page(Long current, Long size);
    List<Sku> listBySpuId(String spuId);
    Page<Sku> pageBySpuId(Long current, Long size, String spuId);
}
