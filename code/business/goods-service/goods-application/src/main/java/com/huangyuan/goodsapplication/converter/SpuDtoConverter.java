package com.huangyuan.goodsapplication.converter;

import com.huangyuan.goodsapplication.dto.SpuDto;
import com.huangyuan.goodsdomain.aggregate.*;
import lombok.NoArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.List;

@NoArgsConstructor
@Component
public final class SpuDtoConverter {
    public Spu toDomain(SpuDto spuDto, List<SkuCreationParam> skuParams) {
        if (spuDto == null) return null;

        return Spu.createSpu(
                new SpuId(spuDto.getId()),
                spuDto.getName(),
                spuDto.getIntro(),
                new BrandId(spuDto.getBrandId()),
                new CategoryPath(spuDto.getCategoryOneId(), spuDto.getCategoryTwoId(), spuDto.getCategoryThreeId()),
                ImageList.create(spuDto.getImages()),
                spuDto.getAfterSalesService(),
                new Content(spuDto.getContent()),
                new AttributeList(spuDto.getAttributeList()),
                skuParams
        );
    }

    public SpuDto toDto(Spu spu) {
        if (spu == null) return null;

        return new SpuDto(
                spu.getId().getValue(),
                spu.getName(),
                spu.getIntro(),
                spu.getBrandId().value(),
                spu.getCategoryPath().oneId(),
                spu.getCategoryPath().twoId(),
                spu.getCategoryPath().threeId(),
                String.join(",", spu.getImages().urls()),
                spu.getAfterSalesService(),
                spu.getContent().html(),
                spu.getAttributeList().json(),
                spu.getMarketable().getCode(),
                spu.getDeleted().getCode(),
                spu.getStatus().getCode()
        );
    }
}
