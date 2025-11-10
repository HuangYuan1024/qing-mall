package com.huangyuan.goodsinfrastructure.persistence.converter;

import com.huangyuan.goodsdomain.model.Brand;
import com.huangyuan.goodsinfrastructure.persistence.po.BrandPo;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

@Mapper
public interface BrandPoConverter {

    BrandPoConverter INSTANCE = Mappers.getMapper(BrandPoConverter.class);

    /* ① Po → Domain */
    @Mapping(target = "id", expression = "java(new BrandId(po.getId()))")
    Brand toDomain(BrandPo po);

    /* ② Domain → Po */
    @Mapping(target = "id", expression = "java(domain.getId().getValue())")
    BrandPo toPo(Brand domain);
}