package com.huangyuan.goodsinfrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.huangyuan.goodsinfrastructure.persistence.po.SpuPo;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface SpuMapper extends BaseMapper<SpuPo> {

    /**
     * 根据ID查询SPU是否存在
     * @param id SPU ID
     * @return true/false
     */
    boolean existsById(String id);
}
