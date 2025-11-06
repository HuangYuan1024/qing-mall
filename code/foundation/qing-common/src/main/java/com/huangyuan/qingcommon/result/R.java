package com.huangyuan.qingcommon.result;

import com.huangyuan.qingcommon.dto.PageDTO;
import lombok.Data;

@Data
public class R<T> {
    private String code;
    private String msg;
    private T data;
    private PageDTO page;

    public R() {
    }
    public R(String code, String msg) {
        this.code = code;
        this.msg = msg;
    }
    public R(String code, String msg, T data) {
        this.code = code;
        this.msg = msg;
        this.data = data;
    }
    public R(String code, String msg, T data, PageDTO page) {
        this.code = code;
        this.msg = msg;
        this.data = data;
        this.page = page;
    }

    public static <T> R<T> success(T data) {
        return new R<>(ResultCode.SUCCESS.getCode(), ResultCode.SUCCESS.getMessage(), data);
    }
    public static <T> R<T> success(T data, PageDTO page) {
        return new R<>(ResultCode.SUCCESS.getCode(), ResultCode.SUCCESS.getMessage(), data, page);
    }
    public static <T> R<T> fail(ResultCode resultCode) {
        return new R<>(resultCode.getCode(), resultCode.getMessage());
    }
    public static <T> R<T> fail(ResultCode resultCode, String msg) {
        return new R<>(resultCode.getCode(), msg);
    }
    public static <T> R<T> fail(String code, String msg) {
        return new R<>(code, msg);
    }
}
