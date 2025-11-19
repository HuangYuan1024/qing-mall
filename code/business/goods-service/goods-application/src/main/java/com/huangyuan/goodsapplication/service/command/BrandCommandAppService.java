package com.huangyuan.goodsapplication.service.command;

import com.huangyuan.goodsapplication.command.CreateBrandCommand;

public interface BrandCommandAppService {

    void createBrand(CreateBrandCommand cmd);

    void updateBrand(Integer id, CreateBrandCommand cmd);

    void deleteBrand(Integer id);

}