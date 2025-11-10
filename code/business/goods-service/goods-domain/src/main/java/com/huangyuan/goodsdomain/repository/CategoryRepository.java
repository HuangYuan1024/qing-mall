package com.huangyuan.goodsdomain.repository;

import com.huangyuan.goodsdomain.model.Category;
import com.huangyuan.goodsdomain.model.CategoryId;

import java.util.List;
import java.util.Optional;

public interface CategoryRepository {
    Category save(Category category);
    Optional<Category> find(CategoryId id);
    boolean existsName(String name);
    List<Category> listAll();
    List<Category> listByParentId(Integer parentId);
    int delete(Category category);
}
