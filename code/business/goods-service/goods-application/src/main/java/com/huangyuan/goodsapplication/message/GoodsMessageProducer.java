package com.huangyuan.goodsapplication.message;

import java.math.BigDecimal;

public interface GoodsMessageProducer {
    void sendGoodsStatusChange(Long goodsId, Boolean onSale);
    void sendPriceChange(Long goodsId, BigDecimal oldPrice, BigDecimal newPrice);
}