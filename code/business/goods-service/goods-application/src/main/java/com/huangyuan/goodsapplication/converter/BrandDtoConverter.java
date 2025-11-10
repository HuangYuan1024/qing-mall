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
    @Mapping(target = "id", expression = "java(domain.getId().getValue())")
    BrandDto toDto(Brand domain);

    /* DTO → Domain */
    @Mapping(target = "id", expression = "java(new BrandId(dto.getId()))")
    Brand toDomain(BrandDto dto);
}
