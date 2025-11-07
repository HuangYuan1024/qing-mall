package com.huangyuan.goodsinfrastructure.persistence.converter;

import com.huangyuan.goodsdomain.model.Brand;
import com.huangyuan.goodsinfrastructure.persistence.po.BrandPo;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

@Mapper
public interface BrandPoConverter {

    BrandPoConverter INSTANCE = Mappers.getMapper(BrandPoConverter.class);

    /* ① Po.id -> Domain(BrandId.value) */
    @Mapping(source = "id", target = "id.value")
    Brand toDomain(BrandPo po);

    /* ② Domain(BrandId.value) -> Po.id */
    @Mapping(source = "id.value", target = "id")
    BrandPo toPo(Brand domain);
}