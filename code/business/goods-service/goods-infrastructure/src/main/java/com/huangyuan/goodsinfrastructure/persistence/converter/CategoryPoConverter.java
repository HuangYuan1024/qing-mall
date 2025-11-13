package com.huangyuan.goodsinfrastructure.persistence.converter;

import com.huangyuan.goodsdomain.aggregate.Category;
import com.huangyuan.goodsdomain.aggregate.CategoryId;
import com.huangyuan.goodsinfrastructure.persistence.po.CategoryPo;
import lombok.NoArgsConstructor;

@NoArgsConstructor
public final class CategoryPoConverter {

    public Category toDomain(CategoryPo po) {
        if (po == null) return null;
        return new Category(
            new CategoryId(po.getId()),
            po.getName(),
            po.getSort(),
            po.getParentId()
        );
    }

    public CategoryPo toPo(Category domain) {
        if (domain == null) return null;
        return new CategoryPo(
            domain.getId().value(),
            domain.getName(),
            domain.getSort(),
            domain.getParentId()
        );
    }
}
