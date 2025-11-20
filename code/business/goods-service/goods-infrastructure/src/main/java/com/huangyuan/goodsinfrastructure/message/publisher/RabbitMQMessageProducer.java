package com.huangyuan.goodsinfrastructure.message.publisher;

import com.huangyuan.goodsdomain.event.GoodsPriceChangedEvent;
import com.huangyuan.goodsdomain.event.GoodsStatusChangedEvent;
import com.huangyuan.goodsdomain.message.GoodsStatusChangeMessage;
import com.huangyuan.goodsdomain.message.PriceChangeMessage;
import com.huangyuan.goodsdomain.service.DomainEventPublisher;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.stereotype.Component;

@Component
@Slf4j
@AllArgsConstructor
public class RabbitMQMessageProducer implements DomainEventPublisher {

    private RabbitTemplate rabbitTemplate;
    
    @Override
    public void publishGoodsStatusChanged(GoodsStatusChangedEvent event) {
        GoodsStatusChangeMessage message = convertToMessage(event);
        rabbitTemplate.convertAndSend(
            "goods.exchange",
            "goods.status.change",
            message
        );
        log.info("商品状态变更事件已发送: goodsId={}", event.getGoodsId());
    }
    
    @Override
    public void publishGoodsPriceChanged(GoodsPriceChangedEvent event) {
        PriceChangeMessage message = convertToMessage(event);
        rabbitTemplate.convertAndSend(
            "goods.exchange", 
            "goods.price.change",
            message
        );
        log.info("商品价格变更事件已发送: goodsId={}", event.getGoodsId());
    }
    
    private GoodsStatusChangeMessage convertToMessage(GoodsStatusChangedEvent event) {
        // 转换逻辑
        return new GoodsStatusChangeMessage(event.getGoodsId(), event.getNewStatus().getCode(), event.getGoodsId(), event.getOccurredOn());
    }

    private PriceChangeMessage convertToMessage(GoodsPriceChangedEvent event) {
        // 转换逻辑
        return new PriceChangeMessage(event.getGoodsId(), "null", event.getOldPrice(), event.getNewPrice(), event.getOccurredOn());
    }
}