package com.huangyuan.goodsinfrastructure.persistence.converter;

import com.huangyuan.goodsdomain.model.Category;
import com.huangyuan.goodsinfrastructure.persistence.po.CategoryPo;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

@Mapper
public interface CategoryPoConverter {

    CategoryPoConverter INSTANCE = Mappers.getMapper(CategoryPoConverter.class);

    @Mapping(source = "id", target = "id.value")
    Category toDomain(CategoryPo po);

    @Mapping(source = "id.value", target = "id")
    CategoryPo toPo(Category domain);
}
