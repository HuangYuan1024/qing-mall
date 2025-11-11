package com.huangyuan.goodsapplication.converter;

import com.huangyuan.goodsapplication.dto.BrandDto;
import com.huangyuan.goodsdomain.aggregate.Brand;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

@Mapper
public interface BrandDtoConverter {

    BrandDtoConverter INSTANCE = Mappers.getMapper(BrandDtoConverter.class);

    /* Domain → DTO */
    @Mapping(target = "id", expression = "java(brand.getId().getValue())")
    BrandDto toDto(Brand brand);

    /* DTO → Domain */
    @Mapping(target = "id", expression = "java(new BrandId(brandDto.getId()))")
    Brand toDomain(BrandDto brandDto);
}
