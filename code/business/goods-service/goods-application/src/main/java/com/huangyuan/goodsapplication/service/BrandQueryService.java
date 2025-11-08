package com.huangyuan.goodsapplication.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.PageDTO;
import com.huangyuan.goodsapplication.dto.BrandDto;

import java.util.List;

public interface BrandQueryService {

    List<BrandDto> listBrands();

    PageDTO<BrandDto> listBrands(Integer pageNum, Integer pageSize, BrandDto brand);

    List<BrandDto> listBrandsByCategoryId(Integer categoryId);

    BrandDto getBrand(Integer id);

}
