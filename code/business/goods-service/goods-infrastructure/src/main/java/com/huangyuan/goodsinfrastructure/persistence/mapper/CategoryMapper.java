package com.huangyuan.goodsinfrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.huangyuan.goodsinfrastructure.persistence.po.CategoryPo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface CategoryMapper extends BaseMapper<CategoryPo> {

    /**
     * 查询分类是否存在
     * @param id 分类ID
     * @return true/false
     */
    boolean existsById(@Param("id") Integer id);

    /**
     * 根据父ID查询子分类
     * @param parentId 父ID
     * @return 子分类
     */
    List<CategoryPo> selectByParentId(@Param("parentId") Integer parentId);

}
