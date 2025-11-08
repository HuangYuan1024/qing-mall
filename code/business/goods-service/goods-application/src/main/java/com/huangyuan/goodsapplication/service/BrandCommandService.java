package com.huangyuan.goodsapplication.service;

import com.huangyuan.goodsapplication.command.ChangeBrandCmd;
import com.huangyuan.goodsapplication.command.CreateBrandCmd;

public interface BrandCommandService {

    void createBrand(CreateBrandCmd cmd);

    void updateBrand(ChangeBrandCmd cmd);

    void deleteBrand(Integer id);
}
