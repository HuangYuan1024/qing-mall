package com.huangyuan.goodsinfrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.huangyuan.goodsinfrastructure.persistence.po.BrandPo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface BrandMapper extends BaseMapper<BrandPo> {

    /**
     * 根据ID查询品牌是否存在
     * @param id 品牌ID
     * @return true/false
     */
    boolean existsById(@Param("id") Integer id);

    /**
     * 根据分类ID查询品牌ID
     * @param categoryId 分类ID
     * @return brandIds
     */
    List<Integer> selectBrandIds(@Param("categoryId") Integer categoryId);

    /**
     * 根据品牌ID查询品牌
     * @param brandIds 品牌ID
     * @return brands
     */
    List<BrandPo> selectByBrandIds(@Param("brandIds") List<Integer> brandIds);

}
