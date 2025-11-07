package com.huangyuan.goodsinfrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.huangyuan.goodsinfrastructure.persistence.po.BrandPo;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface BrandMapper extends BaseMapper<BrandPo> {
    boolean existsById(Integer id);
}