package com.huangyuan.goodsapplication.service.command.impl;

import com.huangyuan.goodsapplication.command.CreateBrandCommand;
import com.huangyuan.goodsapplication.service.command.BrandCommandAppService;
import com.huangyuan.goodsdomain.aggregate.Brand;
import com.huangyuan.goodsdomain.repository.BrandRepository;
import com.huangyuan.goodsdomain.service.BrandDomainService;
import lombok.RequiredArgsConstructor;
import org.apache.dubbo.config.annotation.DubboService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@DubboService(version = "1.0.0", interfaceClass = BrandCommandAppService.class)
@RequiredArgsConstructor
public class BrandCommandAppServiceImpl implements BrandCommandAppService {

    private final BrandDomainService domainService;
    private final BrandRepository repository;

    @Override
    public void createBrand(CreateBrandCommand cmd) {
        Brand brand = domainService.createBrand(cmd.getName(), cmd.getImage(), cmd.getLetter(), cmd.getSort());
        repository.save(brand);
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void updateBrand(Integer id, CreateBrandCommand cmd) {
        Brand brand = domainService.updateBrand(id, cmd.getName(), cmd.getImage(), cmd.getLetter(), cmd.getSort());
        repository.save(brand);
    }

    @Override
    public void deleteBrand(Integer id) {
        Brand brand = domainService.deleteBrand(id);
        repository.delete(brand);
    }
}
