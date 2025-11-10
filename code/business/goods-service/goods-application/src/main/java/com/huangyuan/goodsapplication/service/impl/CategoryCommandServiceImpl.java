package com.huangyuan.goodsapplication.service.impl;

import com.huangyuan.goodsapplication.command.ChangeCategoryCmd;
import com.huangyuan.goodsapplication.command.CreateCategoryCmd;
import com.huangyuan.goodsapplication.service.CategoryCommandService;
import com.huangyuan.goodsdomain.aggregate.Category;
import com.huangyuan.goodsdomain.repository.CategoryRepository;
import com.huangyuan.goodsdomain.service.CategoryDomainService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
@RequiredArgsConstructor
public class CategoryCommandServiceImpl implements CategoryCommandService {

    private final CategoryDomainService domainService;
    private final CategoryRepository repository;

    @Override
    public void createCategory(CreateCategoryCmd cmd) {
        Category category = domainService.createCategory(cmd.getName(), cmd.getSort(), cmd.getParentId());
        repository.save(category);
    }

    @Override
    public void updateCategory(ChangeCategoryCmd cmd) {
        Category category = domainService.updateCategory(cmd.getId(), cmd.getName(), cmd.getSort(), cmd.getParentId());
        repository.save(category);
    }

    @Override
    public void deleteCategory(Integer id) {
        Category category = domainService.deleteCategory(id);
        repository.delete(category);
    }
}
