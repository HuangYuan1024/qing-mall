package com.huangyuan.goodsdomain.service;

import com.huangyuan.goodsdomain.aggregate.Category;
import com.huangyuan.goodsdomain.aggregate.CategoryId;
import com.huangyuan.goodsdomain.repository.CategoryRepository;
import com.huangyuan.qingcommon.exception.BizException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class CategoryDomainService {

    private final CategoryRepository repository;

    public Category createCategory(String name, Integer sort, Integer parentId) {
        if (repository.existsName(name)) {
            throw new BizException("分类名称已存在");
        }
        return Category.create(name, sort, parentId);
    }

    public Category updateCategory(Integer id, String name, Integer sort, Integer parentId) {
        if (name == null || name.isBlank()) {
            throw new BizException("分类名不能为空");
        }
        Category oldCategory = repository.find(new CategoryId(id))
                .orElseThrow(() -> new BizException("要修改的分类不存在"));
        if (!oldCategory.getName().equals(name) && repository.existsName(name)) {
            throw new BizException("要修改的分类名称已存在");
        }
        return Category.update(new CategoryId(id), name, sort, parentId);
    }

    public Category deleteCategory(Integer id) {
        repository.find(new CategoryId(id))
                .orElseThrow(() -> new BizException("要删除的分类不存在"));
        return Category.delete(new CategoryId(id));
    }

}
