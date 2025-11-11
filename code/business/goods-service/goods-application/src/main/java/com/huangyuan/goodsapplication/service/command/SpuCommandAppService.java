package com.huangyuan.goodsapplication.service.command;

import com.huangyuan.goodsapplication.command.CreateSkuCommand;
import com.huangyuan.goodsapplication.command.CreateSpuCommand;
import com.huangyuan.goodsapplication.command.UpdateSpuCommand;
import com.huangyuan.goodsapplication.converter.SpuDtoConverter;
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
        // 1. 验证Command格式
        command.validate();

        SimpleIdGenerator idGenerator = new SimpleIdGenerator();

        // 2. 转换为领域对象
        SpuId spuId = new SpuId(idGenerator.generateId().toString());
        BrandId brandId = new BrandId(command.getBrandId());
        CategoryPath categoryPath = new CategoryPath(command.getCategoryIds().get(0), command.getCategoryIds().get(1), command.getCategoryIds().get(2));
        Content content = new Content(command.getContentHtml());
        AttributeList attributeList = AttributeList.fromMap(command.getAttributes());
        List<SkuCreationParam> skuParams = new ArrayList<>();
        for (CreateSkuCommand skuCommand : command.getSkus()) {
            skuParams.add(new SkuCreationParam(
                    skuCommand.getSkuName(),
                    skuCommand.getPrice(),
                    skuCommand.getStock(),
                    skuCommand.getImage(),
                    skuCommand.getAttrText()
            ));
        }

        // 3. 调用领域工厂方法创建聚合根
        Spu spu = Spu.createSpu(
                spuId,
                command.getName(),
                command.getIntro(),
                brandId,
                categoryPath,
                command.getAfterSalesService(),
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
        command.validate();

        // 获取聚合根
        Spu spu = spuRepository.findById(new SpuId(spuId))
                .orElseThrow(() -> new BizException("商品不存在"));

        // 转换为领域对象
        BrandId brandId = new BrandId(command.getBrandId());
        CategoryPath categoryPath = new CategoryPath(command.getCategoryIds());
        Content content = new Content(command.getContentHtml());
        AttributeList attributeList = AttributeList.fromMap(command.getAttributes());

        // 调用聚合根方法
        spu.updateSpu(
                command.getName(),
                command.getIntro(),
                brandId,
                categoryPath,
                command.getAfterSalesService(),
                content,
                attributeList
        );

        spuRepository.save(spu);
    }
}
