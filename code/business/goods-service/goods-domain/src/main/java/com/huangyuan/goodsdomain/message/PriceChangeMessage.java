package com.huangyuan.goodsdomain.message;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PriceChangeMessage {
    private String goodsId;
    private String goodsName;
    private BigDecimal oldPrice;
    private BigDecimal newPrice;
    private LocalDateTime changeTime;
    // getters/setters
}