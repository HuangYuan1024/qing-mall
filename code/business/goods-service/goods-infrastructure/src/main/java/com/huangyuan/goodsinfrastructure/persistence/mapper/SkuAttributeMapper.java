package com.huangyuan.goodsinfrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.huangyuan.goodsinfrastructure.persistence.po.SkuAttributePo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface SkuAttributeMapper extends BaseMapper<SkuAttributePo> {

    /**
     * 根据ID查询属性是否存在
     * @param id 属性ID
     * @return true/false
     */
    boolean existsById(@Param("id") Integer id);

    /**
     * 根据分类ID查询属性
     * @param id 分类ID
     * @return 属性
     */
    List<SkuAttributePo> selectByCategoryId(@Param("id") Integer id);

}
