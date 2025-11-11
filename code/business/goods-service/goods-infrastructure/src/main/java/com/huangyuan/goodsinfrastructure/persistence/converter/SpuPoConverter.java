package com.huangyuan.goodsinfrastructure.persistence.converter;

import com.huangyuan.goodsdomain.aggregate.Spu;
import com.huangyuan.goodsinfrastructure.persistence.po.SpuPo;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

@Mapper
public interface SpuPoConverter {
    SpuPoConverter INSTANCE = Mappers.getMapper(SpuPoConverter.class);

    @Mapping(target = "id", expression = "java(new SpuId(po.getId()))")
    @Mapping(target = "brandId", expression = "java(new BrandId(po.getBrandId()))")
    @Mapping(target = "categoryPath", expression = "java(new CategoryPath(po.getCategoryOneId(), po.getCategoryTwoId(), po.getCategoryThreeId()))")
    @Mapping(target = "images", expression = "java(ImageList.create(po.getImages()))")
    @Mapping(target = "content", expression = "java(new Content(po.getContent()))")
    @Mapping(target = "attributeList", expression = "java(new AttributeList(po.getAttributeList()))")
    @Mapping(target = "marketable", expression = "java(Marketable.of(po.getIsMarketable()))")
    @Mapping(target = "deleted", expression = "java(Deleted.of(po.getIsDelete()))")
    @Mapping(target = "auditStatus", expression = "java(AuditStatus.of(po.getStatus()))")
    Spu toDomain(SpuPo po);

    @Mapping(target = "id", expression = "java(domain.getId().getValue())")
    @Mapping(target = "brandId", expression = "java(domain.getBrandId().getValue())")
    @Mapping(target = "categoryOneId", expression = "java(domain.getCategoryPath().getOne().getValue())")
    @Mapping(target = "categoryTwoId", expression = "java(domain.getCategoryPath().getTwo().getValue())")
    @Mapping(target = "categoryThreeId", expression = "java(domain.getCategoryPath().getThree().getValue())")
    @Mapping(target = "images", expression = "java(String.join(\",\", domain.getImages().getUrls()))")
    @Mapping(target = "content", expression = "java(domain.getContent().getHtml())")
    @Mapping(target = "attributeList", expression = "java(domain.getAttributeList().getJson())")
    @Mapping(target = "isMarketable", expression = "java(domain.getMarketable().getCode())")
    @Mapping(target = "isDelete", expression = "java(domain.getDeleted().getCode())")
    @Mapping(target = "status", expression = "java(domain.getAuditStatus().getCode())")
    SpuPo toPo(Spu domain);
}
