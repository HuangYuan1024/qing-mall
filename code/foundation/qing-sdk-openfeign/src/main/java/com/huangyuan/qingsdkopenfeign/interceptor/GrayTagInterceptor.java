package com.huangyuan.qingsdkopenfeign.interceptor;

import feign.RequestInterceptor;
import feign.RequestTemplate;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

public class GrayTagInterceptor implements RequestInterceptor {

    private static final String GRAY_TAG_HEADER = "gray-tag";

    @Override
    public void apply(RequestTemplate template) {
        // 从当前请求中获取灰度标签并传递给下游服务
        try {
            RequestAttributes requestAttributes = RequestContextHolder.getRequestAttributes();

            if (requestAttributes instanceof ServletRequestAttributes) {
                ServletRequestAttributes attributes = (ServletRequestAttributes) requestAttributes;
                HttpServletRequest request = attributes.getRequest();

                // 直接获取灰度标签header，避免遍历所有header
                String headerValue = request.getHeader(GRAY_TAG_HEADER);
                if (headerValue != null) {
                    template.header(GRAY_TAG_HEADER, headerValue);
                }
            }
        } catch (Exception e) {
            // 避免因单个请求处理失败影响整个应用
            // 可以考虑添加适当的日志记录
        }
    }
}

