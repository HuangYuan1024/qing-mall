package com.huangyuan.goodsdomain.aggregate;

import com.huangyuan.goodsdomain.event.SpuOnShelfEvent;
import com.huangyuan.qingcommon.domain.AggregateRoot;
import com.huangyuan.qingcommon.exception.BizException;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

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

    /* ------------------------------------------------------------
     * 业务行为：聚合根负责保证不变量
     * ---------------------------------------------------------- */

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
                      String image, String attrText) {
        Sku sku = new Sku(skuId, skuName, price, num, image, attrText, this);
        skus.add(sku);
        return sku;
    }

    /** 批量下架所有 SKU */
    public void offAllSku() {
        skus.forEach(Sku::offShelf);
        this.marketable = Marketable.DOWN;
    }

    /* ------------------------------------------------------------
     * 只读视图
     * ---------------------------------------------------------- */
    public List<Sku> getSkus() {
        return new ArrayList<>(skus); // 防御性拷贝
    }

    public Sku getSku(SkuId skuId) {
        return skus.stream()
                .filter(s -> s.getId().equals(skuId))
                .findFirst()
                .orElseThrow(() -> new BizException("SKU不存在"));
    }
}