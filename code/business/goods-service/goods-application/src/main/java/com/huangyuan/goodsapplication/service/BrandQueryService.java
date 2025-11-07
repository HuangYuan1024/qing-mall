package com.huangyuan.goodsapplication.service;

import com.huangyuan.goodsapplication.dto.BrandDto;

import java.util.List;

public interface BrandQueryService {

    List<BrandDto> listBrands();

    BrandDto getBrand(Integer id);
}
