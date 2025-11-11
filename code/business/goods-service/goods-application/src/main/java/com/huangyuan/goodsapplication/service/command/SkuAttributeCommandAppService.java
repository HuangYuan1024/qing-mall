package com.huangyuan.goodsapplication.service.command;

import com.huangyuan.goodsapplication.command.CreateSkuAttributeCommand;
import com.huangyuan.goodsapplication.command.UpdateSkuAttributeCommand;
import com.huangyuan.goodsdomain.aggregate.SkuAttribute;
import com.huangyuan.goodsdomain.repository.SkuAttributeRepository;
import com.huangyuan.goodsdomain.service.SkuAttributeDomainService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
@RequiredArgsConstructor
public class SkuAttributeCommandAppService {

    private final SkuAttributeDomainService domainService;
    private final SkuAttributeRepository repository;

    public void createSkuAttribute(CreateSkuAttributeCommand cmd) {
        SkuAttribute skuAttribute = domainService.createSkuAttribute(cmd.getName(), cmd.getOptions(), cmd.getSort());
        repository.save(skuAttribute);
    }

    public void updateSkuAttribute(UpdateSkuAttributeCommand cmd) {
        SkuAttribute skuAttribute = domainService.updateSkuAttribute(cmd.getId(), cmd.getName(), cmd.getOptions(), cmd.getSort());
        repository.save(skuAttribute);
    }

    public void deleteSkuAttribute(Integer id) {
        SkuAttribute skuAttribute = domainService.deleteSkuAttribute(id);
        repository.delete(skuAttribute);
    }
}
