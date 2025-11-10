package com.huangyuan.goodsapplication.service.impl;

import com.huangyuan.goodsapplication.command.ChangeSkuAttributeCmd;
import com.huangyuan.goodsapplication.command.CreateSkuAttributeCmd;
import com.huangyuan.goodsapplication.service.SkuAttributeCommandService;
import com.huangyuan.goodsdomain.aggregate.SkuAttribute;
import com.huangyuan.goodsdomain.repository.SkuAttributeRepository;
import com.huangyuan.goodsdomain.service.SkuAttributeDomainService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
@RequiredArgsConstructor
public class SkuAttributeCommandServiceImpl implements SkuAttributeCommandService {

    private final SkuAttributeDomainService domainService;
    private final SkuAttributeRepository repository;

    @Override
    public void createSkuAttribute(CreateSkuAttributeCmd cmd) {
        SkuAttribute skuAttribute = domainService.createSkuAttribute(cmd.getName(), cmd.getOptions(), cmd.getSort());
        repository.save(skuAttribute);
    }

    @Override
    public void updateSkuAttribute(ChangeSkuAttributeCmd cmd) {
        SkuAttribute skuAttribute = domainService.updateSkuAttribute(cmd.getId(), cmd.getName(), cmd.getOptions(), cmd.getSort());
        repository.save(skuAttribute);
    }

    @Override
    public void deleteSkuAttribute(Integer id) {
        SkuAttribute skuAttribute = domainService.deleteSkuAttribute(id);
        repository.delete(skuAttribute);
    }
}
