package com.huangyuan.goodsdomain.message;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class GoodsStatusChangeMessage {
    private String goodsId;
    private Integer status;
    private String operatorId;
    private LocalDateTime changeTime;
}