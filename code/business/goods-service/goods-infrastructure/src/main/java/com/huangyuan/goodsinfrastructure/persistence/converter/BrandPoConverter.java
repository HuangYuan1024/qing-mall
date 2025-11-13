package com.huangyuan.goodsinfrastructure.persistence.converter;

import com.huangyuan.goodsdomain.aggregate.Brand;
import com.huangyuan.goodsdomain.aggregate.BrandId;
import com.huangyuan.goodsinfrastructure.persistence.po.BrandPo;
import lombok.NoArgsConstructor;
import org.springframework.stereotype.Component;

@Component
@NoArgsConstructor
public final class BrandPoConverter {
    public Brand toDomain(BrandPo po) {
        if (po == null) return null;
        return new Brand(
                new BrandId(po.getId()),
                po.getName(),
                po.getImage(),
                po.getInitial(),
                po.getSort()
        );
    }
    public BrandPo toPo(Brand domain) {
        if (domain == null) return null;
        return new BrandPo(
                domain.getId().value(),
                domain.getName(),
                domain.getImage(),
                domain.getInitial(),
                domain.getSort()
        );
    }
}
