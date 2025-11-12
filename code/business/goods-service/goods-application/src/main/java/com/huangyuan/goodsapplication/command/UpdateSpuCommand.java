package com.huangyuan.goodsapplication.command;

import com.huangyuan.goodsapplication.dto.SkuDto;
import com.huangyuan.goodsapplication.dto.SpuDto;
import lombok.Data;

import java.util.List;

@Data
public class UpdateSpuCommand {

    SpuDto spu;

    List<SkuDto> skus;
}
