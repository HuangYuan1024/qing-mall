package com.huangyuan.goodsapplication.service.command;

import com.huangyuan.goodsapplication.command.CreateBrandCommand;
import com.huangyuan.goodsdomain.aggregate.Brand;
import com.huangyuan.goodsdomain.repository.BrandRepository;
import com.huangyuan.goodsdomain.service.BrandDomainService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
@RequiredArgsConstructor
public class BrandCommandAppService {

    private final BrandDomainService domainService;
    private final BrandRepository repository;

    public void createBrand(CreateBrandCommand cmd) {
        Brand brand = domainService.createBrand(cmd.getName(), cmd.getImage(), cmd.getLetter(), cmd.getSort());
        repository.save(brand);
    }

    public void updateBrand(Integer id, CreateBrandCommand cmd) {
        Brand brand = domainService.updateBrand(id, cmd.getName(), cmd.getImage(), cmd.getLetter(), cmd.getSort());
        repository.save(brand);
    }

    public void deleteBrand(Integer id) {
        Brand brand = domainService.deleteBrand(id);
        repository.delete(brand);
    }
}