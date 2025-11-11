package com.huangyuan.goodsapplication.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;

@Data
@AllArgsConstructor
public class SkuDto implements Serializable {

    /** 商品 ID（自定义字符串） */
    private String id;

    /** SKU 名称 */
    private String name;

    /** 价格（单位：分） */
    private Integer price;

    /** 库存数量 */
    private Integer num;

    /** 主图 URL */
    private String image;

    /** 多图 URL（逗号分隔） */
    private String images;

    /** 创建时间 */
    private LocalDateTime createTime;

    /** 更新时间 */
    private LocalDateTime updateTime;

    /** 所属 SPU ID */
    private String spuId;

    /** 叶子类目 ID */
    private Integer categoryId;

    /** 叶子类目名称（冗余） */
    private String categoryName;

    /** 品牌 ID（冗余） */
    private Integer brandId;

    /** 品牌名称（冗余） */
    private String brandName;

    /** 规格属性文本（如：颜色:红色,尺寸:XL） */
    private String skuAttribute;

    /** 商品状态 1=正常 2=下架 3=删除 */
    private Integer status;
}
