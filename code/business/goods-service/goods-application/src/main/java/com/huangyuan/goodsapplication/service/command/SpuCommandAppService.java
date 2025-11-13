package com.huangyuan.goodsapplication.service.command;

import com.huangyuan.goodsapplication.command.CreateSpuCommand;
import com.huangyuan.goodsapplication.command.UpdateSpuCommand;
import com.huangyuan.goodsapplication.converter.SpuDtoConverter;
import com.huangyuan.goodsapplication.dto.SkuDto;
import com.huangyuan.goodsapplication.dto.SpuDto;
import com.huangyuan.goodsdomain.aggregate.*;
import com.huangyuan.goodsdomain.repository.SpuRepository;
import com.huangyuan.qingcommon.exception.BizException;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.SimpleIdGenerator;

import java.util.ArrayList;
import java.util.List;

@Service
@Transactional
@AllArgsConstructor
public class SpuCommandAppService {

    private final SpuRepository spuRepository;
    private final SpuDtoConverter converter;

    public SpuDto createSpu(CreateSpuCommand command) {

        SimpleIdGenerator idGenerator = new SimpleIdGenerator();
        command.getSpu().setId(idGenerator.generateId().toString());

        // 转换为领域对象
        List<SkuCreationParam> skuParams = new ArrayList<>();
        for (SkuDto sku : command.getSkus()) {
            skuParams.add(new SkuCreationParam(
                    sku.getName(),
                    sku.getPrice(),
                    sku.getNum(),
                    sku.getImage(),
                    sku.getSkuAttribute()
            ));
        }

        Spu spu = converter.toDomain(command.getSpu(), skuParams);

        // 4. 保存
        spuRepository.save(spu);

        // 5. 返回DTO
        return converter.toDto(spu);
    }

    public void updateSpu(String spuId, UpdateSpuCommand command) {

        // 获取聚合根
        Spu spu = spuRepository.find(spuId)
                .orElseThrow(() -> new BizException("商品不存在"));

        // 调用聚合根方法
        spu.updateSpu(
                command.getSpu().getName(),
                command.getSpu().getIntro(),
                new BrandId(command.getSpu().getBrandId()),
                new CategoryPath(command.getSpu().getCategoryOneId(), command.getSpu().getCategoryTwoId(), command.getSpu().getCategoryThreeId()),
                command.getSpu().getAfterSalesService(),
                new Content(command.getSpu().getContent()),
                new AttributeList(command.getSpu().getAttributeList())
        );

        spuRepository.save(spu);
    }
}
