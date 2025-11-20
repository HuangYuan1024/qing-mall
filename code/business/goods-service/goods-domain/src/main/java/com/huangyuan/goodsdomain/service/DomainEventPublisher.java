package com.huangyuan.goodsdomain.service;

import com.huangyuan.goodsdomain.event.GoodsPriceChangedEvent;
import com.huangyuan.goodsdomain.event.GoodsStatusChangedEvent;

public interface DomainEventPublisher {
    void publishGoodsStatusChanged(GoodsStatusChangedEvent event);
    void publishGoodsPriceChanged(GoodsPriceChangedEvent event);
}