package com.huangyuan.goodsdomain.repository;

import com.huangyuan.goodsdomain.model.Brand;
import com.huangyuan.goodsdomain.model.BrandId;

import java.util.List;
import java.util.Optional;

public interface BrandRepository {
    Brand save(Brand brand);
    Optional<Brand> find(BrandId id);
    boolean existsName(String name);
    List<Brand> listAll();
    List<Brand> listByName(String name);
    List<Brand> listByCategoryId(Integer categoryId);
    int delete(Brand brand);
}
