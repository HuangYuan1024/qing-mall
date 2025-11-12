package com.huangyuan.goodsinfrastructure.persistence.converter;

import com.huangyuan.goodsdomain.aggregate.Sku;
import com.huangyuan.goodsinfrastructure.persistence.po.SkuPo;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

public interface SkuPoConverter {

    SkuPoConverter INSTANCE = Mappers.getMapper(SkuPoConverter.class);

    @Mapping(target = "id", expression = "java(new SkuId(po.getId()))")
    @Mapping(target = "spuId", expression = "java(new SpuId(po.getSpuId()))")
    @Mapping(target = "status", expression = "java(SkuStatus.of(po.getStatus()))")
    Sku toDomain(SkuPo po);

    @Mapping(target = "id", expression = "java(domain.getId().getValue())")
    @Mapping(target = "spuId", expression = "java(domain.getSpuId().getValue())")
    @Mapping(target = "status", expression = "java(domain.getStatus().getCode())")
    SkuPo toPo(Sku domain);

}
