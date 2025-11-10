package com.huangyuan.goodsdomain.service;

import com.huangyuan.goodsdomain.aggregate.Brand;

public interface BrandDomainService {

    Brand createBrand(String name, String image, String initial, Integer sort);

    Brand updateBrand(Integer id, String name, String image, String initial, Integer sort);

    Brand deleteBrand(Integer id);
}
