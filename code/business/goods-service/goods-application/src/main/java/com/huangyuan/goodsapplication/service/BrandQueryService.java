package com.huangyuan.goodsapplication.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.PageDTO;
import com.huangyuan.goodsapplication.dto.BrandDto;

import java.util.List;

public interface BrandQueryService {

    List<BrandDto> listBrands(BrandDto brand);

    PageDTO<BrandDto> pageBrands(Long pageNum, Long pageSize, BrandDto brand);

    List<BrandDto> listBrandsByCategoryId(Integer categoryId);

    BrandDto getBrand(Integer id);

}
