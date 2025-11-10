package com.huangyuan.goodsdomain.service;

import com.huangyuan.goodsdomain.model.SkuAttribute;

public interface SkuAttributeDomainService {
    SkuAttribute createSkuAttribute(String name, String options, Integer sort);
    SkuAttribute updateSkuAttribute(Integer id, String name, String options, Integer sort);
    SkuAttribute deleteSkuAttribute(Integer id);
}
