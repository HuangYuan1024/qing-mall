package com.huangyuan.goodsinfrastructure.persistence.converter;

import com.huangyuan.goodsdomain.aggregate.SkuAttribute;
import com.huangyuan.goodsdomain.aggregate.SkuAttributeId;
import com.huangyuan.goodsinfrastructure.persistence.po.SkuAttributePo;
import lombok.NoArgsConstructor;
import org.springframework.stereotype.Component;

@Component
@NoArgsConstructor
public final class SkuAttributePoConverter {

    public SkuAttribute toDomain(SkuAttributePo po) {
        if (po == null) return null;
        return new SkuAttribute(
                new SkuAttributeId(po.getId()),
                po.getName(),
                po.getOptions(),
                po.getSort()
        );
    }

    public SkuAttributePo toPo(SkuAttribute domain) {
        if (domain == null) return null;
        return new SkuAttributePo(
                domain.getId().value(),
                domain.getName(),
                domain.getOptions(),
                domain.getSort()
        );
    }
}
