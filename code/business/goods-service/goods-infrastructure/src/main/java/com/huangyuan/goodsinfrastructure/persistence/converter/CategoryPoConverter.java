package com.huangyuan.goodsinfrastructure.persistence.converter;

import com.huangyuan.goodsdomain.aggregate.Category;
import com.huangyuan.goodsinfrastructure.persistence.po.CategoryPo;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

@Mapper
public interface CategoryPoConverter {

    CategoryPoConverter INSTANCE = Mappers.getMapper(CategoryPoConverter.class);

    @Mapping(target = "id", expression = "java(new CategoryId(po.getId()))")
    Category toDomain(CategoryPo po);

    @Mapping(target = "id", expression = "java(domain.getId().getValue())")
    CategoryPo toPo(Category domain);
}
