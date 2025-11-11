package com.huangyuan.goodsapplication.converter;

import com.huangyuan.goodsapplication.dto.SkuDto;
import com.huangyuan.goodsdomain.aggregate.Sku;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

@Mapper
public interface SkuDtoConverter {

    SkuDtoConverter INSTANCE = Mappers.getMapper(SkuDtoConverter.class);

    @Mapping(target = "id", expression = "java(sku.getId().getValue())")
    @Mapping(target = "images", source = "images")
    @Mapping(target = "spuId", expression = "java(sku.getSpuId().getValue())")
    @Mapping(target = "categoryId", source = "categoryId")
    @Mapping(target = "categoryName", source = "categoryName")
    @Mapping(target = "brandId", source = "brandId")
    @Mapping(target = "brandName", source = "brandName")
    @Mapping(target = "status", expression = "java(sku.getStatus().getCode())")
    SkuDto toDto(Sku sku, String images, Integer categoryId, String categoryName, Integer brandId, String brandName);
}
