package com.huangyuan.qingcommon.result;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

@Setter
@Getter
public class RespResult<T> implements Serializable {

    //响应数据结果集
    private T data;

    /**
     * 状态码
     * 20000 操作成功
     * 50000 操作失败
     */
    private Integer code;

    /***
     * 响应信息
     */
    private String message;

    public RespResult() {
    }

    public RespResult(RespCode resultCode) {
        this.code = resultCode.getCode();
        this.message = resultCode.getMessage();
    }

    public RespResult(T data, RespCode resultCode) {
        this.data = data;
        this.code = resultCode.getCode();
        this.message = resultCode.getMessage();
    }
    public static RespResult<Void> ok() {
        return new RespResult<>(null, RespCode.SUCCESS);
    }

    public static <T> RespResult<T> ok(T data) {
        return new RespResult<>(data, RespCode.SUCCESS);
    }

    public static RespResult<Void> error() {
        return new RespResult<>(null, RespCode.ERROR);
    }

    public static RespResult<Void> error(String message) {
        return secByError(RespCode.ERROR.getCode(), message);
    }

    // 自定义异常
    public static RespResult<Void> secByError(Integer code, String message) {
        RespResult<Void> err = new RespResult<>();
        err.setCode(code);
        err.setMessage(message);
        return err;
    }

    public static RespResult<Void> error(RespCode resultCode) {
        return new RespResult<>(resultCode);
    }


}