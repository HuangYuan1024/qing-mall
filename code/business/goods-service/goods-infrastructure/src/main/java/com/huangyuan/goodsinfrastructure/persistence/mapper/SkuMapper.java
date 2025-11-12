package com.huangyuan.goodsinfrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.huangyuan.goodsinfrastructure.persistence.po.SkuPo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface SkuMapper extends BaseMapper<SkuPo> {

    /**
     * 根据ID查询属性是否存在
     * @param id 属性ID
     * @return true/false
     */
    boolean existsById(@Param("id") String id);

    /**
     * 根据SPU ID查询属性
     * @param spuId SPU ID
     * @return 属性
     */
    List<SkuPo> selectBySpuId(@Param("spuId") String spuId);
}
