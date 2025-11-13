package com.huangyuan.goodsapplication.converter;

import com.huangyuan.goodsapplication.dto.CategoryDto;
import com.huangyuan.goodsdomain.aggregate.Category;
import com.huangyuan.goodsdomain.aggregate.CategoryId;
import lombok.NoArgsConstructor;
import org.springframework.stereotype.Component;

@Component
@NoArgsConstructor
public final class CategoryDtoConverter {
    public Category toDomain(CategoryDto categoryDto) {
        if (categoryDto == null) return null;

        return new Category(
            new CategoryId(categoryDto.getId()),
            categoryDto.getName(),
            categoryDto.getSort(),
            categoryDto.getParentId()
        );
    }

    public CategoryDto toDto(Category category) {
        if (category == null) return null;

        return new CategoryDto(
            category.getId().value(),
            category.getName(),
            category.getSort(),
            category.getParentId()
        );
    }
}
