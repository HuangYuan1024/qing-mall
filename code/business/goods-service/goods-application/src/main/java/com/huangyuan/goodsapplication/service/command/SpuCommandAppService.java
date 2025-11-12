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

        // 转换为领域对象
        SpuId spuId = new SpuId(idGenerator.generateId().toString());
        BrandId brandId = new BrandId(command.getSpu().getBrandId());
        CategoryPath categoryPath = new CategoryPath(command.getSpu().getCategoryOneId(), command.getSpu().getCategoryTwoId(), command.getSpu().getCategoryThreeId());
        Content content = new Content(command.getSpu().getContent());
        AttributeList attributeList = new  AttributeList(command.getSpu().getAttributeList());
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

        // 调用领域工厂方法创建聚合根
        Spu spu = Spu.createSpu(
                spuId,
                command.getSpu().getName(),
                command.getSpu().getIntro(),
                brandId,
                categoryPath,
                ImageList.create(command.getSpu().getImages()),
                command.getSpu().getAfterSalesService(),
                content,
                attributeList,
                skuParams
        );

        // 4. 保存
        spuRepository.save(spu);

        // 5. 返回DTO
        return converter.toDto(spu);
    }

    public void updateSpu(String spuId, UpdateSpuCommand command) {

        // 获取聚合根
        Spu spu = spuRepository.find(spuId)
                .orElseThrow(() -> new BizException("商品不存在"));

        // 转换为领域对象
        BrandId brandId = new BrandId(command.getSpu().getBrandId());
        CategoryPath categoryPath = new CategoryPath(command.getSpu().getCategoryOneId(), command.getSpu().getCategoryTwoId(), command.getSpu().getCategoryThreeId());
        Content content = new Content(command.getSpu().getContent());
        AttributeList attributeList = new AttributeList(command.getSpu().getAttributeList());

        // 调用聚合根方法
        spu.updateSpu(
                command.getSpu().getName(),
                command.getSpu().getIntro(),
                brandId,
                categoryPath,
                command.getSpu().getAfterSalesService(),
                content,
                attributeList
        );

        spuRepository.save(spu);
    }
}
