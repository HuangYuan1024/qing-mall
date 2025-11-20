package com.huangyuan.goodsdomain.event;

import lombok.AllArgsConstructor;
import lombok.Getter;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Getter
@AllArgsConstructor
public class GoodsPriceChangedEvent {
    private final String goodsId;
    private final BigDecimal oldPrice;
    private final BigDecimal newPrice;
    private final LocalDateTime occurredOn;
    // constructor & getters
}