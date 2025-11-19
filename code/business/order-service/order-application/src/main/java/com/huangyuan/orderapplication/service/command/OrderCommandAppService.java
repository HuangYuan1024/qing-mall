package com.huangyuan.orderapplication.service.command;

import com.huangyuan.goodsapplication.command.CreateBrandCommand;
import com.huangyuan.goodsapplication.dto.BrandDto;
import com.huangyuan.goodsapplication.service.command.BrandCommandAppService;
import com.huangyuan.goodsapplication.service.query.BrandQueryAppService;
import io.seata.spring.annotation.GlobalTransactional;
import lombok.RequiredArgsConstructor;
import org.apache.dubbo.config.annotation.DubboReference;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class OrderCommandAppService {

    @DubboReference(check = false, version = "1.0.0", interfaceClass = BrandQueryAppService.class)
    private BrandQueryAppService brandQueryService;

    @DubboReference(check = false, version = "1.0.0", interfaceClass = BrandCommandAppService.class)
    private BrandCommandAppService brandCommandAppService;

    @GlobalTransactional
    public void createOrder(boolean isRollback) {
        try {
            // 1. 品牌改信息(第一个)
            BrandDto brandDto1 = brandQueryService.getBrand(17);
            if (brandDto1 == null) {
                throw new RuntimeException("品牌17不存在");
            }
            CreateBrandCommand cmd1 = new CreateBrandCommand();
            cmd1.setName(brandDto1.getName() + "-哦吼吼");
            cmd1.setImage(brandDto1.getImage());
            cmd1.setLetter(brandDto1.getLetter());
            cmd1.setSort(brandDto1.getSort());
            brandCommandAppService.updateBrand(brandDto1.getId(), cmd1);

            // 2. 品牌改信息(第二个)
            BrandDto brandDto2 = brandQueryService.getBrand(19);
            if (brandDto2 == null) {
                throw new RuntimeException("品牌19不存在");
            }
            CreateBrandCommand cmd2 = new CreateBrandCommand();
            cmd2.setName(brandDto2.getName() + "-哦吼吼");
            cmd2.setImage(brandDto2.getImage());
            cmd2.setLetter(brandDto2.getLetter());
            cmd2.setSort(brandDto2.getSort());
            brandCommandAppService.updateBrand(brandDto2.getId(), cmd2);

            // 模拟异常，测试分布式事务回滚
            if (isRollback) {
                throw new RuntimeException("模拟异常");
            }

        } catch (Exception e) {
            throw new RuntimeException("分布式事务测试回滚: " + e.getMessage(), e);
        }
    }
}
