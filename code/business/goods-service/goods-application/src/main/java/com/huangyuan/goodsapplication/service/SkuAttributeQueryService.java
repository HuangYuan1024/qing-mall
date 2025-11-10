package com.huangyuan.goodsapplication.service;

import com.huangyuan.goodsapplication.dto.SkuAttributeDto;

import java.util.List;

public interface SkuAttributeQueryService {

    List<SkuAttributeDto> listSkuAttributes();

    List<SkuAttributeDto> listSkuAttributesByCategoryId(Integer categoryId);

    SkuAttributeDto getSkuAttribute(Integer id);

}
