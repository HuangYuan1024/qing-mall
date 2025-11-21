package com.huangyuan.paymentdomain.model;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.Map;
import java.util.Optional;

@Getter
@AllArgsConstructor
@JsonFormat(shape = JsonFormat.Shape.STRING)   // 序列化时使用枚举的name
public enum PaymentStatus {
    PROCESSING(0),
    ACTIVE(1),
    OFF(2),
    DELETED(3);

    private final int code;

    private static final Map<Integer, PaymentStatus> CODE_MAP = Map.of(
            0, PROCESSING,
            1, ACTIVE,
            2, OFF,
            3, DELETED
    );

    public static PaymentStatus of(int code) {
        return Optional.ofNullable(CODE_MAP.get(code))
                .orElseThrow(() -> new IllegalArgumentException("非法Payment状态码:" + code));
    }

    // 用于Jackson反序列化：从字符串转换为枚举
    @JsonCreator
    public static PaymentStatus fromString(String name) {
        try {
            return PaymentStatus.valueOf(name);
        } catch (IllegalArgumentException e) {
            throw new IllegalArgumentException("非法Payment状态名:" + name, e);
        }
    }
}
