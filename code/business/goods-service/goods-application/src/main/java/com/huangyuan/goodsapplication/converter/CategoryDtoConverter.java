package com.huangyuan.goodsapplication.converter;

import com.huangyuan.goodsapplication.dto.CategoryDto;
import com.huangyuan.goodsdomain.aggregate.Category;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

@Mapper
public interface CategoryDtoConverter {

    CategoryDtoConverter INSTANCE = Mappers.getMapper(CategoryDtoConverter.class);

    @Mapping(target = "id", expression = "java(domain.getId().getValue())")
    CategoryDto toDto(Category category);

    @Mapping(target = "id", expression = "java(new CategoryId(dto.getId()))")
    Category toDomain(CategoryDto categoryDto);

}
