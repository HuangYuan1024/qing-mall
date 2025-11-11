package com.huangyuan.goodsdomain.aggregate;

import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.huangyuan.goodsdomain.event.SpuCreatedEvent;
import com.huangyuan.goodsdomain.event.SpuOffShelfEvent;
import com.huangyuan.goodsdomain.event.SpuOnShelfEvent;
import com.huangyuan.goodsdomain.event.SpuUpdatedEvent;
import com.huangyuan.qingcommon.domain.AggregateRoot;
import com.huangyuan.qingcommon.exception.BizException;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * 商品聚合根
 */
@Getter
@AllArgsConstructor
@NoArgsConstructor(access = AccessLevel.PROTECTED) // 防止外部 new
public class Spu extends AggregateRoot<String> {

    /* ========== 基础属性 ========== */
    private SpuId id;
    private String name;
    private String intro;
    private BrandId brandId;
    private CategoryPath categoryPath;   // 值对象：一/二/三级
    private ImageList images;
    private String afterSalesService;
    private Content content;
    private AttributeList attributeList;  // 规格模板
    private Marketable marketable;     // 枚举：是否上架
    private Deleted deleted;        // 枚举：是否删除
    private AuditStatus auditStatus;    // 枚举：审核状态

    /* ========== 内部实体 ========== */
    private final List<Sku> skus = new ArrayList<>();

    /* ========== 业务构造 ========== */
    public Spu(SpuId id, String name, BrandId brandId, CategoryPath categoryPath) {
        this.id = id;
        this.name = name;
        this.brandId = brandId;
        this.categoryPath = categoryPath;
        this.marketable = Marketable.DOWN;
        this.deleted = Deleted.NO;
        this.auditStatus = AuditStatus.PENDING;
    }

    /*-----------------------------------------------------------
      业务行为：聚合根负责保证不变量
    -----------------------------------------------------------*/

    /** 上架 */
    public void putOnShelf() {
        if (deleted.isYes()) {
            throw new BizException("已删除不能上架");
        }
        if (auditStatus != AuditStatus.PASSED) {
            throw new BizException("未审核通过不能上架");
        }
        if (skus.isEmpty()) {
            throw new BizException("至少维护一个 SKU 才能上架");
        }
        if (skus.stream().anyMatch(s -> !s.isActive())) {
            throw new BizException("存在无效 SKU");
        }
        this.marketable = Marketable.UP;
        registerEvent(new SpuOnShelfEvent(this.id));
    }

    /** 新增 SKU（只能通过根） */
    public Sku addSku(SkuId skuId, String skuName, Integer price, Integer num,
                      String image, String skuAttribute) {
        LocalDateTime now = LocalDateTime.now();
        Sku sku = new Sku(skuId, skuName, price, num, image, now, now, this.id, skuAttribute, SkuStatus.ACTIVE);
        skus.add(sku);
        return sku;
    }

    /** 批量下架所有 SKU */
    public void offAllSku() {
        skus.forEach(Sku::offShelf);
        this.marketable = Marketable.DOWN;
    }

    /*----------------------------------------------------------
      只读视图
    ----------------------------------------------------------*/
    public List<Sku> getSkus() {
        return new ArrayList<>(skus); // 防御性拷贝
    }

    public Sku getSku(SkuId skuId) {
        return skus.stream()
                .filter(s -> s.getId().equals(skuId))
                .findFirst()
                .orElseThrow(() -> new BizException("SKU不存在"));
    }


    /*----------------------------------------------------------
      工厂方法
    ----------------------------------------------------------*/
    /**
     * 创建商品聚合根（工厂方法）
     * @param id 商品ID
     * @param name 商品名称
     * @param intro 商品介绍
     * @param brandId 品牌ID
     * @param categoryPath 分类路径
     * @param afterSalesService 售后服务
     * @param content 商品详情
     * @param attributeList 属性列表
     * @param skuParams 初始SKU列表（可为空）
     * @return 商品聚合根
     */
    public static Spu createSpu(SpuId id, String name, String intro, BrandId brandId,
                                CategoryPath categoryPath, String afterSalesService,
                                Content content, AttributeList attributeList,
                                List<SkuCreationParam> skuParams) {

        // 参数校验
        if (id == null) {
            throw new BizException("商品ID不能为空");
        }
        if (StringUtils.isBlank(name)) {
            throw new BizException("商品名称不能为空");
        }
        if (brandId == null) {
            throw new BizException("品牌不能为空");
        }
        if (categoryPath == null || categoryPath.isValid()) {
            throw new BizException("商品分类不完整");
        }

        // 创建聚合根
        Spu spu = new Spu();
        spu.id = id;
        spu.name = name.trim();
        spu.intro = intro != null ? intro.trim() : "";
        spu.brandId = brandId;
        spu.categoryPath = categoryPath;
        spu.afterSalesService = afterSalesService;
        spu.content = content != null ? content : Content.empty();
        spu.attributeList = attributeList != null ? attributeList : AttributeList.empty();
        spu.images = ImageList.empty();
        spu.marketable = Marketable.DOWN;
        spu.deleted = Deleted.NO;
        spu.auditStatus = AuditStatus.PENDING;

        // 创建初始SKU
        if (skuParams != null && !skuParams.isEmpty()) {
            for (SkuCreationParam param : skuParams) {
                spu.addSku(param.getSkuId(), param.skuName(), param.price(), param.stock(), param.image(), param.attrText());
            }
        }

        // 注册领域事件
        spu.registerEvent(new SpuCreatedEvent(spu.id, spu.name, spu.brandId, spu.categoryPath));

        return spu;
    }

    /**
     * 更新商品基本信息
     * @param name 商品名称
     * @param intro 商品介绍
     * @param brandId 品牌ID
     * @param categoryPath 分类路径
     * @param afterSalesService 售后服务
     * @param content 商品详情
     * @param attributeList 属性列表
     */
    public void updateSpu(String name, String intro, BrandId brandId,
                          CategoryPath categoryPath, String afterSalesService,
                          Content content, AttributeList attributeList) {

        // 基础校验
        if (this.deleted.isYes()) {
            throw new BizException("已删除的商品不能修改");
        }
        if (StringUtils.isBlank(name)) {
            throw new BizException("商品名称不能为空");
        }
        if (brandId == null) {
            throw new BizException("品牌不能为空");
        }
        if (categoryPath == null || categoryPath.isValid()) {
            throw new BizException("商品分类不完整");
        }

        // 如果商品已上架，修改基础信息需要先下架并重新审核
        boolean needReaudit = this.marketable.isUp();

        // 更新字段
        this.name = name.trim();
        this.intro = intro != null ? intro.trim() : "";
        this.brandId = brandId;
        this.categoryPath = categoryPath;
        this.afterSalesService = afterSalesService;
        this.content = content != null ? content : Content.empty();
        this.attributeList = attributeList != null ? attributeList : AttributeList.empty();

        // 业务规则：修改基础信息后，如果原已上架，需要下架并重新审核
        if (needReaudit) {
            this.marketable = Marketable.DOWN;
            this.auditStatus = AuditStatus.PENDING;
            // 注册下架事件
            registerEvent(new SpuOffShelfEvent(this.id, "基础信息变更自动下架"));
        }

        // 注册更新事件
        registerEvent(new SpuUpdatedEvent(this.id, this.name, this.brandId, this.categoryPath));
    }


}