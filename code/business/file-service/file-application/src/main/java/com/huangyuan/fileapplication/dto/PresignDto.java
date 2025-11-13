package com.huangyuan.fileapplication.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

/**
 * 预签名URL数据传输对象
 * 用于文件上传/下载的预签名URL相关信息传输
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class PresignDto implements Serializable {

    /**
     * 预签名URL
     */
    private String url;

    /**
     * 预签名URL的key
     */
    private String key;

    /**
     * 过期时间(秒)
     */
    private Long expiresIn;
}

