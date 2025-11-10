package com.huangyuan.goodsdomain.repository;

import com.huangyuan.goodsdomain.aggregate.SkuAttribute;
import com.huangyuan.goodsdomain.aggregate.SkuAttributeId;

import java.util.List;
import java.util.Optional;

public interface SkuAttributeRepository {
    void save(SkuAttribute skuAttribute);
    Optional<SkuAttribute> find(SkuAttributeId id);
    boolean existsName(String name);
    List<SkuAttribute> listAll();
    List<SkuAttribute> listByCategoryId(Integer categoryId);
    int delete(SkuAttribute skuAttribute);
}
