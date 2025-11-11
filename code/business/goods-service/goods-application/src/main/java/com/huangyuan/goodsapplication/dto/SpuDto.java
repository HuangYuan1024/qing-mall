package com.huangyuan.goodsapplication.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.io.Serializable;

@Data
@AllArgsConstructor
public class SpuDto implements Serializable {

    /** 主键（自定义字符串） */
    private String id;

    /** SPU 名称 */
    private String name;

    /** 简介 */
    private String intro;

    /** 品牌 ID */
    private Integer brandId;

    /** 一级分类 */
    private Integer categoryOneId;

    /** 二级分类 */
    private Integer categoryTwoId;

    /** 三级分类 */
    private Integer categoryThreeId;

    /** 图片列表（多图逗号分隔） */
    private String images;

    /** 售后服务 */
    private String afterSalesService;

    /** 商品详情富文本 */
    private String content;

    /** 规格属性 JSON（长 3000） */
    private String attributeList;

    /** 是否上架 0=下架 1=上架 */
    private Integer isMarketable;

    /** 是否删除 0=未删 1=已删 */
    private Integer isDelete;

    /** 审核状态 0=未审 1=已审 2=不通过 */
    private Integer status;
}
