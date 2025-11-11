package com.huangyuan.goodsapplication.service.command;

import com.huangyuan.goodsapplication.command.CreateCategoryCommand;
import com.huangyuan.goodsapplication.command.UpdateCategoryCommand;
import com.huangyuan.goodsdomain.aggregate.Category;
import com.huangyuan.goodsdomain.repository.CategoryRepository;
import com.huangyuan.goodsdomain.service.CategoryDomainService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
@RequiredArgsConstructor
public class CategoryCommandAppService {

    private final CategoryDomainService domainService;
    private final CategoryRepository repository;

    public void createCategory(CreateCategoryCommand cmd) {
        Category category = domainService.createCategory(cmd.getName(), cmd.getSort(), cmd.getParentId());
        repository.save(category);
    }

    public void updateCategory(UpdateCategoryCommand cmd) {
        Category category = domainService.updateCategory(cmd.getId(), cmd.getName(), cmd.getSort(), cmd.getParentId());
        repository.save(category);
    }

    public void deleteCategory(Integer id) {
        Category category = domainService.deleteCategory(id);
        repository.delete(category);
    }
}
