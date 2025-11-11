package com.huangyuan.goodsinfrastructure.persistence.repository;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huangyuan.goodsdomain.aggregate.Spu;
import com.huangyuan.goodsdomain.aggregate.SpuId;
import com.huangyuan.goodsdomain.repository.SpuRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
@RequiredArgsConstructor
public class SpuRepositoryImpl implements SpuRepository {
    @Override
    public void save(Spu spu) {

    }

    @Override
    public Optional<Spu> findById(SpuId id) {
        return Optional.empty();
    }

    @Override
    public void delete(Spu spu) {

    }

    @Override
    public boolean existsName(String name) {
        return false;
    }

    @Override
    public List<Spu> listAll() {
        return List.of();
    }

    @Override
    public Page<Spu> page(Long current, Long size) {
        return null;
    }
}
