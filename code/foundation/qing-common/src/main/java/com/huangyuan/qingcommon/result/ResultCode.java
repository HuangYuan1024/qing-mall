package com.huangyuan.qingcommon.result;

import lombok.Data;

@Data
public class ResultCode {
    private String code;
    private String message;

    // 常用结果码常量
    public static final ResultCode SUCCESS = new ResultCode("200", "成功");
    public static final ResultCode ERROR = new ResultCode("500", "错误");
    public static final ResultCode NOT_FOUND = new ResultCode("404", "未找到");
    public static final ResultCode UNAUTHORIZED = new ResultCode("401", "未授权");


    public ResultCode() {
    }

    public ResultCode(String code, String message) {
        this.code = code;
        this.message = message;
    }
}

