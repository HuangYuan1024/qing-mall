package com.huangyuan.goodsdomain.service.impl;

import com.huangyuan.goodsdomain.model.SkuAttribute;
import com.huangyuan.goodsdomain.model.SkuAttributeId;
import com.huangyuan.goodsdomain.repository.SkuAttributeRepository;
import com.huangyuan.goodsdomain.service.SkuAttributeDomainService;
import com.huangyuan.qingcommon.exception.BizException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class SkuAttributeDomainServiceImpl implements SkuAttributeDomainService {

    private final SkuAttributeRepository repository;

    @Override
    public SkuAttribute createSkuAttribute(String name, String options, Integer sort) {
        if (repository.existsName(name)) {
            throw new BizException("属性名称已存在");
        }
        return SkuAttribute.create(name, options, sort);
    }

    @Override
    public SkuAttribute updateSkuAttribute(Integer id, String name, String options, Integer sort) {
        if (name == null || name.isBlank()) {
            throw new BizException("属性名不能为空");
        }
        SkuAttribute oldSkuAttribute = repository.find(new SkuAttributeId(id))
                .orElseThrow(() -> new BizException("要修改的属性不存在"));
        if (!oldSkuAttribute.getName().equals(name) && repository.existsName(name)) {
            throw new BizException("要修改的属性名称已存在");
        }
        return SkuAttribute.update(new SkuAttributeId(id), name, options, sort);
    }

    @Override
    public SkuAttribute deleteSkuAttribute(Integer id) {
        repository.find(new SkuAttributeId(id))
                .orElseThrow(() -> new BizException("要删除的属性不存在"));
        return SkuAttribute.delete(new SkuAttributeId(id));
    }
}
