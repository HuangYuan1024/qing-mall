package com.huangyuan.goodsapplication.message;

import com.huangyuan.goodsapplication.service.command.SpuCommandAppService;
import com.huangyuan.goodsdomain.message.GoodsStatusChangeMessage;
import com.huangyuan.goodsdomain.message.PriceChangeMessage;
import com.rabbitmq.client.Channel;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.amqp.support.AmqpHeaders;
import org.springframework.messaging.handler.annotation.Header;
import org.springframework.stereotype.Component;

import java.io.IOException;

@Component
@Slf4j
@RequiredArgsConstructor
public class GoodsMessageConsumer {

    private final SpuCommandAppService spuCommandAppService;
    
    /**
     * 监听商品状态变更消息（来自其他服务）
     */
    @RabbitListener(queues = "goods.status.queue")
    public void handleGoodsStatusChange(GoodsStatusChangeMessage message,
                                        Channel channel,
                                        @Header(AmqpHeaders.DELIVERY_TAG) long deliveryTag) {
        try {
            log.info("处理商品状态变更消息: goodsId={}, status={}",
                    message.getGoodsId(), message.getStatus());
            
            // 刷新Redis缓存
            spuCommandAppService.refreshGoodsCache(message.getGoodsId());
            
            // 手动确认消息
            
        } catch (Exception e) {
            log.error("处理商品状态变更消息失败: {}", message, e);
            try {
                // 拒绝消息，重新入队
                channel.basicNack(deliveryTag, false, true);
            } catch (IOException ex) {
                log.error("消息NACK失败: {}", ex.getMessage());
            }
        }
    }
    
    /**
     * 监听价格变更消息
     */
    @RabbitListener(queues = "goods.price.queue")
    public void handlePriceChange(PriceChangeMessage message,
                                  Channel channel,
                                  @Header(AmqpHeaders.DELIVERY_TAG) long deliveryTag) {
        try {
            log.info("处理价格变更消息: goodsId={}, newPrice={}", 
                    message.getGoodsId(), message.getNewPrice());
            
            // 更新价格相关缓存
            
            // 发送价格变更通知等

        } catch (Exception e) {
            log.error("处理价格变更消息失败: {}", message, e);
            // 错误处理逻辑
            try {
                channel.basicNack(deliveryTag, false, true);
            } catch (IOException ex) {
                log.error("消息NACK失败: {}", ex.getMessage());
            }
        }
    }
}