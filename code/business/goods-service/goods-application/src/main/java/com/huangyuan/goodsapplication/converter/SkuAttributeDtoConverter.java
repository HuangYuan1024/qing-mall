package com.huangyuan.goodsapplication.converter;

import com.huangyuan.goodsapplication.dto.SkuAttributeDto;
import com.huangyuan.goodsdomain.aggregate.SkuAttribute;
import com.huangyuan.goodsdomain.aggregate.SkuAttributeId;
import lombok.NoArgsConstructor;
import org.springframework.stereotype.Component;

@Component
@NoArgsConstructor
public final class SkuAttributeDtoConverter {
    public SkuAttribute toDomain(SkuAttributeDto skuAttributeDto) {
        if (skuAttributeDto == null) return null;

        return new SkuAttribute(
            new SkuAttributeId(skuAttributeDto.getId()),
            skuAttributeDto.getName(),
            skuAttributeDto.getOptions(),
            skuAttributeDto.getSort()
        );
    }

    public SkuAttributeDto toDto(SkuAttribute skuAttribute) {
        if (skuAttribute == null) return null;

        return new SkuAttributeDto(
            skuAttribute.getId().value(),
            skuAttribute.getName(),
            skuAttribute.getOptions(),
            skuAttribute.getSort()
        );
    }
}
