package com.huangyuan.goodsapplication.service.impl;

import com.huangyuan.goodsapplication.command.ChangeBrandCmd;
import com.huangyuan.goodsapplication.command.CreateBrandCmd;
import com.huangyuan.goodsapplication.service.BrandCommandService;
import com.huangyuan.goodsdomain.model.Brand;
import com.huangyuan.goodsdomain.repository.BrandRepository;
import com.huangyuan.goodsdomain.service.impl.BrandDomainServiceImpl;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
@RequiredArgsConstructor
public class BrandCommandServiceImpl implements BrandCommandService {

    private final BrandDomainServiceImpl domainService;
    private final BrandRepository repository;

    public void createBrand(CreateBrandCmd cmd) {
        Brand brand = domainService.createBrand(cmd.getName(), cmd.getImage(), cmd.getInitial(), cmd.getSort());
        repository.save(brand);
    }

    public void updateBrand(ChangeBrandCmd cmd) {
        Brand brand = domainService.updateBrand(cmd.getId(), cmd.getName(), cmd.getImage(), cmd.getInitial(), cmd.getSort());
        repository.save(brand);
    }

    public void deleteBrand(Integer id) {
        Brand brand = domainService.deleteBrand(id);
        repository.delete(brand);
    }
}