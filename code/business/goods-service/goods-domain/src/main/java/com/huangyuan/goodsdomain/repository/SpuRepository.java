package com.huangyuan.goodsdomain.repository;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.huangyuan.goodsdomain.aggregate.Spu;
import com.huangyuan.goodsdomain.aggregate.SpuId;

import java.util.List;
import java.util.Optional;

public interface SpuRepository {
    void save(Spu spu);
    Optional<Spu> findById(SpuId id);
    void delete(Spu spu);
    boolean existsName(String name);
    List<Spu> listAll();
    Page<Spu> page(Long current, Long size);
}
