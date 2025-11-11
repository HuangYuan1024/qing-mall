package com.huangyuan.goodsapplication.service.query;

import com.huangyuan.goodsapplication.converter.CategoryDtoConverter;
import com.huangyuan.goodsapplication.dto.CategoryDto;
import com.huangyuan.goodsdomain.aggregate.CategoryId;
import com.huangyuan.goodsdomain.repository.CategoryRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class CategoryQueryAppService {

    private final CategoryRepository repository;
    private final CategoryDtoConverter converter = CategoryDtoConverter.INSTANCE;

    public List<CategoryDto> listCategoriesByParentId(Integer parentId) {
        return repository.listByParentId(parentId).stream()
                .map(converter::toDto)
                .toList();
    }

    public List<CategoryDto> listCategories() {
        return repository.listAll().stream()
                .map(converter::toDto)
                .toList();
    }

    public CategoryDto getCategory(Integer id) {
        return repository.find(new CategoryId(id))
                .map(converter::toDto)
                .orElseThrow(() -> new RuntimeException("分类不存在"));
    }
}
