package com.huangyuan.goodsapplication.service;

import com.huangyuan.goodsapplication.command.ChangeCategoryCmd;
import com.huangyuan.goodsapplication.command.CreateCategoryCmd;

public interface CategoryCommandService {

    void createCategory(CreateCategoryCmd cmd);
    void updateCategory(ChangeCategoryCmd cmd);
    void deleteCategory(Integer id);
}
