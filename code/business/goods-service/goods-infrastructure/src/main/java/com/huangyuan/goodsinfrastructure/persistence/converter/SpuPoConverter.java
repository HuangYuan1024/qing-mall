package com.huangyuan.goodsinfrastructure.persistence.converter;

import com.huangyuan.goodsdomain.aggregate.*;
import com.huangyuan.goodsinfrastructure.persistence.po.SpuPo;
import lombok.NoArgsConstructor;

@NoArgsConstructor
public final class SpuPoConverter {

    /**
     * PO 转 Domain
     * @param po po
     * @return domain
     */
    public Spu toDomain(SpuPo po) {
        if (po == null) return null;

        return new Spu(
                new SpuId(po.getId()),
                po.getName(),
                po.getIntro(),
                new BrandId(po.getBrandId()),
                new CategoryPath(po.getCategoryOneId(), po.getCategoryTwoId(), po.getCategoryThreeId()),
                ImageList.create(po.getImages()),
                po.getAfterSalesService(),
                new Content(po.getContent()),
                new AttributeList(po.getAttributeList()),
                Marketable.of(po.getIsMarketable()),
                Deleted.of(po.getIsDelete()),
                AuditStatus.of(po.getStatus())
        );
    }

    /**
     * Domain 转 PO
     * @param domain domain
     * @return po
     */
    public SpuPo toPo(Spu domain) {
        if (domain == null) return null;

        SpuPo po = new SpuPo();
        po.setId(domain.getId().getValue());
        po.setName(domain.getName());
        po.setIntro(domain.getIntro());
        po.setBrandId(domain.getBrandId().value());
        po.setCategoryOneId(domain.getCategoryPath().oneId());
        po.setCategoryTwoId(domain.getCategoryPath().twoId());
        po.setCategoryThreeId(domain.getCategoryPath().threeId());
        po.setImages(String.join(",", domain.getImages().urls()));
        po.setAfterSalesService(domain.getAfterSalesService());
        po.setContent(domain.getContent().html());
        po.setAttributeList(domain.getAttributeList().json());
        po.setIsMarketable(domain.getMarketable().getCode());
        po.setIsDelete(domain.getDeleted().getCode());
        po.setStatus(domain.getAuditStatus().getCode());
        return po;
    }
}
