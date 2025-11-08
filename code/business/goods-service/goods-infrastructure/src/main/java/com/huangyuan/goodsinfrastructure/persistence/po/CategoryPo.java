package com.huangyuan.goodsinfrastructure.persistence.po;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

/**
 * 商品类目持久化对象
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("category")
public class CategoryPo implements Serializable {

    /** 分类ID */
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /** 分类名称 */
    private String name;

    /** 排序（越小越靠前） */
    private Integer sort;

    /** 上级ID；0 表示顶级节点 */
    private Integer parentId;
}