package com.huangyuan.goodsdomain.service;

import com.huangyuan.goodsdomain.aggregate.Category;

public interface CategoryDomainService {

    Category createCategory(String name, Integer sort, Integer parentId);

    Category updateCategory(Integer id, String name, Integer sort, Integer parentId);

    Category deleteCategory(Integer id);
}
