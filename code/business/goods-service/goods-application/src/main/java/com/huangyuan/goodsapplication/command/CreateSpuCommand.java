package com.huangyuan.goodsapplication.command;

import com.huangyuan.goodsapplication.dto.SkuDto;
import com.huangyuan.goodsapplication.dto.SpuDto;
import lombok.Data;

import java.io.Serializable;
import java.util.List;

@Data
public class CreateSpuCommand implements Serializable {

    SpuDto spu;

    List<SkuDto> skus;
}
