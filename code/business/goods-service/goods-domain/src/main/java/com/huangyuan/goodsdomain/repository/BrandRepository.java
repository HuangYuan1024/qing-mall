package com.huangyuan.goodsdomain.repository;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huangyuan.goodsdomain.model.Brand;
import com.huangyuan.goodsdomain.model.BrandId;

import java.util.List;
import java.util.Optional;

public interface BrandRepository {
    Brand save(Brand brand);
    Optional<Brand> find(BrandId id);
    boolean existsName(String name);
    List<Brand> listAll();
    List<Brand> listByCondition(Brand brand);
    List<Brand> listByCategoryId(Integer categoryId);
    Page<Brand> page(Long current, Long size);
    Page<Brand> pageByName(Long current, Long size, String name);
    int delete(Brand brand);
}
