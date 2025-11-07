package com.huangyuan.goodsdomain.service.impl;

import com.huangyuan.goodsdomain.model.Brand;
import com.huangyuan.goodsdomain.model.BrandId;
import com.huangyuan.goodsdomain.repository.BrandRepository;
import com.huangyuan.goodsdomain.service.BrandDomainService;
import com.huangyuan.qingcommon.exception.BizException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class BrandDomainServiceImpl implements BrandDomainService {

    private final BrandRepository repository;

    public Brand createBrand(String name, String image, String initial, Integer sort) {
        if (repository.existsName(name)) {
            throw new BizException("品牌名称已存在");
        }
        return Brand.create(name, image, initial, sort);
    }

    public Brand updateBrand(Integer id, String name, String image, String initial, Integer sort) {
        if (name == null || name.isBlank()) {
            throw new BizException("品牌名不能为空");
        }

        Brand oldBrand = repository.find(new BrandId(id))
                .orElseThrow(() -> new BizException("要修改的品牌不存在"));

        if (!oldBrand.getName().equals(name) && repository.existsName(name)) {
            throw new BizException("要修改的品牌名称已存在");
        }

        return Brand.update(new BrandId(id), name, image, initial, sort);
    }

    public Brand deleteBrand(Integer id) {
        Brand brand = repository.find(new BrandId(id))
                .orElseThrow(() -> new BizException("要删除的品牌不存在"));

        return Brand.delete(new BrandId(id));
    }
}
