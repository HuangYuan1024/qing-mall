package com.huangyuan.goodsapplication.service;

import com.huangyuan.goodsapplication.command.ChangeSkuAttributeCmd;
import com.huangyuan.goodsapplication.command.CreateSkuAttributeCmd;

public interface SkuAttributeCommandService {
    void createSkuAttribute(CreateSkuAttributeCmd cmd);
    void updateSkuAttribute(ChangeSkuAttributeCmd cmd);
    void deleteSkuAttribute(Integer id);
}
