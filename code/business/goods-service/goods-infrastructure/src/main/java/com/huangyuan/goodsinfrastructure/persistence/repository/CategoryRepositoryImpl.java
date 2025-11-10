package com.huangyuan.goodsinfrastructure.persistence.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.huangyuan.goodsdomain.model.Category;
import com.huangyuan.goodsdomain.model.CategoryId;
import com.huangyuan.goodsdomain.repository.CategoryRepository;
import com.huangyuan.goodsinfrastructure.persistence.converter.CategoryPoConverter;
import com.huangyuan.goodsinfrastructure.persistence.mapper.CategoryMapper;
import com.huangyuan.goodsinfrastructure.persistence.po.CategoryPo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
@RequiredArgsConstructor
public class CategoryRepositoryImpl implements CategoryRepository {

    private final CategoryMapper mapper;
    private final CategoryPoConverter converter = CategoryPoConverter.INSTANCE;

    @Override
    public Category save(Category category) {
        CategoryPo po = converter.toPo(category);
        if (mapper.existsById(po.getId())) {
            mapper.updateById(po);
        } else {
            mapper.insert(po);
        }
        return category;
    }

    @Override
    public Optional<Category> find(CategoryId id) {
        return Optional.ofNullable(mapper.selectById(id.getValue()))
                .map(converter::toDomain);
    }

    @Override
    public boolean existsName(String name) {
        return mapper.exists(new LambdaQueryWrapper<CategoryPo>().eq(CategoryPo::getName, name));
    }

    @Override
    public List<Category> listAll() {
        return mapper.selectList(null).stream()
                .map(converter::toDomain)
                .toList();
    }

    @Override
    public List<Category> listByParentId(Integer parentId) {
        return mapper.selectByParentId(parentId).stream()
                .map(converter::toDomain)
                .toList();
    }

    @Override
    public int delete(Category category) {
        return mapper.deleteById(category.getId().getValue());
    }
}
