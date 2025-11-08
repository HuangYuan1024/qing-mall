package com.huangyuan.goodsapplication.service.impl;

import com.huangyuan.goodsapplication.dto.CategoryDto;
import com.huangyuan.goodsapplication.service.CategoryQueryService;
import com.huangyuan.goodsdomain.model.CategoryId;
import com.huangyuan.goodsdomain.repository.CategoryRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class CategoryQueryServiceImpl implements CategoryQueryService {

    private final CategoryRepository repository;

    @Override
    public List<CategoryDto> listCategoriesByParentId(Integer parentId) {
        return repository.listAll().stream()
                .filter(c -> c.getParentId().equals(parentId))
                .map(c -> new CategoryDto(c.getId().getValue(), c.getName(), c.getSort(), c.getParentId()))
                .toList();
    }

    @Override
    public List<CategoryDto> listCategories() {
        return repository.listAll().stream()
                .map(c -> new CategoryDto(c.getId().getValue(), c.getName(), c.getSort(), c.getParentId()))
                .toList();
    }

    @Override
    public CategoryDto getCategory(Integer id) {
        return repository.find(new CategoryId(id))
                .map(c -> new CategoryDto(c.getId().getValue(), c.getName(), c.getSort(), c.getParentId()))
                .orElseThrow(() -> new RuntimeException("分类不存在"));
    }
}
