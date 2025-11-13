package com.huangyuan.goodsinfrastructure.persistence.converter;

import com.huangyuan.goodsdomain.aggregate.*;
import com.huangyuan.goodsinfrastructure.persistence.po.SkuPo;
import lombok.NoArgsConstructor;

@NoArgsConstructor
public final class SkuPoConverter {

    public Sku toDomain(SkuPo po) {
        if (po == null) return null;
        return new Sku(
                new SkuId(po.getId()),
                po.getName(),
                po.getPrice(),
                po.getNum(),
                po.getImage(),
                po.getCreateTime(),
                po.getUpdateTime(),
                new SpuId(po.getSpuId()),
                po.getSkuAttribute(),
                SkuStatus.of(po.getStatus())
        );
    }

    public SkuPo toPo(Sku domain, ImageList images, CategoryPath categoryPath, String categoryName, BrandId brandId, String brandName) {
        if (domain == null) return null;
        return new SkuPo(
                domain.getId().value(),
                domain.getName(),
                domain.getPrice(),
                domain.getNum(),
                domain.getImage(),
                String.join(",", images.urls()),
                domain.getCreateTime(),
                domain.getUpdateTime(),
                domain.getSpuId().getValue(),
                categoryPath.threeId(),
                categoryName,
                brandId.value(),
                brandName,
                domain.getSkuAttribute(),
                domain.getStatus().getCode()
        );
    }

}
