package com.huangyuan.goodsapplication.converter;

import com.huangyuan.goodsapplication.dto.SpuDto;
import com.huangyuan.goodsdomain.aggregate.Spu;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

@Mapper
public interface SpuDtoConverter {

    SpuDtoConverter INSTANCE = Mappers.getMapper(SpuDtoConverter.class);

    @Mapping(target = "id", expression = "java(spu.getId().getValue())")
    @Mapping(target = "brandId", expression = "java(spu.getBrandId().getValue())")
    @Mapping(target = "categoryOneId", expression = "java(spu.getCategoryPath().getOneId())")
    @Mapping(target = "categoryTwoId", expression = "java(spu.getCategoryPath().getTwoId())")
    @Mapping(target = "categoryThreeId", expression = "java(spu.getCategoryPath().getThreeId())")
    @Mapping(target = "images", expression = "java(String.join(\",\", spu.getImages().getUrls()))")
    @Mapping(target = "content", expression = "java(spu.getContent().getHtml())")
    @Mapping(target = "attributeList", expression = "java(spu.getAttributeList().getJson())")
    @Mapping(target = "isMarketable", expression = "java(spu.getMarketable().getCode())")
    @Mapping(target = "isDelete", expression = "java(spu.getDeleted().getCode())")
    @Mapping(target = "status", expression = "java(spu.getAuditStatus().getCode())")
    SpuDto toDto(Spu spu);
}
