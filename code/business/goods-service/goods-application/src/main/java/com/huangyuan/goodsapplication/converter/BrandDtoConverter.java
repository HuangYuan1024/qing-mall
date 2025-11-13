package com.huangyuan.goodsapplication.converter;

import com.huangyuan.goodsapplication.dto.BrandDto;
import com.huangyuan.goodsdomain.aggregate.*;
import lombok.NoArgsConstructor;
import org.springframework.stereotype.Component;

@Component
@NoArgsConstructor
public final class BrandDtoConverter {
    public Brand toDomain(BrandDto brandDto) {
        if (brandDto == null) return null;

        return new Brand(
                new BrandId(brandDto.getId()),
                brandDto.getName(),
                brandDto.getImage(),
                brandDto.getLetter(),
                brandDto.getSort()
        );
    }

    public BrandDto toDto(Brand brand) {
        if (brand == null) return null;

        return new BrandDto(
                brand.getId().value(),
                brand.getName(),
                brand.getImage(),
                brand.getInitial(),
                brand.getSort()
        );
    }
}
