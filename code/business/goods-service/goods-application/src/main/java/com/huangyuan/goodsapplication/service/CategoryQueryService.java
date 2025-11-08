package com.huangyuan.goodsapplication.service;

import com.huangyuan.goodsapplication.dto.CategoryDto;

import java.util.List;

public interface CategoryQueryService {

    List<CategoryDto> listCategoriesByParentId(Integer parentId);

    List<CategoryDto> listCategories();

    CategoryDto getCategory(Integer id);
}
