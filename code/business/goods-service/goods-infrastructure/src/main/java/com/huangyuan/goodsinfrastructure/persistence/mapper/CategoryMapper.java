package com.huangyuan.goodsinfrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.huangyuan.goodsinfrastructure.persistence.po.CategoryPo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 *  分类 mapper
 * @author 大飞
 * @since 1.0
 *
 */
public interface CategoryMapper extends BaseMapper<CategoryPo> {

    /**
     * 查询分类是否存在
     * @return true/false
     */
    boolean existsById(@Param("id") Integer id);

    /**
     * 根据父ID查询子分类
     * @return 子分类
     */
    List<CategoryPo> selectByParentId(@Param("parentId") Integer parentId);
}