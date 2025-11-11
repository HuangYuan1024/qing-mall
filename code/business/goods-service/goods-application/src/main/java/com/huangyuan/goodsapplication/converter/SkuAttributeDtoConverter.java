package com.huangyuan.goodsapplication.converter;

import com.huangyuan.goodsapplication.dto.SkuAttributeDto;
import com.huangyuan.goodsdomain.aggregate.SkuAttribute;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

@Mapper
public interface SkuAttributeDtoConverter {

    SkuAttributeDtoConverter INSTANCE = Mappers.getMapper(SkuAttributeDtoConverter.class);

    @Mapping(target = "id", expression = "java(skuAttribute.getId().getValue())")
    SkuAttributeDto toDto(SkuAttribute skuAttribute);

}
