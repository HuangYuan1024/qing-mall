package com.huangyuan.goodsinfrastructure.persistence.converter;

import com.huangyuan.goodsdomain.model.SkuAttribute;
import com.huangyuan.goodsinfrastructure.persistence.po.SkuAttributePo;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

@Mapper
public interface SkuAttributePoConverter {

    SkuAttributePoConverter INSTANCE = Mappers.getMapper(SkuAttributePoConverter.class);

    @Mapping(target = "id", expression = "java(new SkuAttributeId(po.getId()))")
    SkuAttribute toDomain(SkuAttributePo po);

    @Mapping(target = "id", expression = "java(domain.getId().getValue())")
    SkuAttributePo toPo(SkuAttribute domain);
}
