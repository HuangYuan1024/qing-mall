package com.huangyuan.goodsinfrastructure.persistence.po;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

/**
 * SKU 属性持久化对象
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("sku_attribute")
public class SkuAttributePo implements Serializable {

    /** 主键ID */
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /** 属性名称 */
    private String name;

    /** 属性选项，多个用英文逗号分隔（长度 2000） */
    private String options;

    /** 排序（越小越靠前） */
    private Integer sort;

}
