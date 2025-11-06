package com.huangyuan.qingspringbootstarteridempotent.interceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.lang.NonNull;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import java.util.concurrent.TimeUnit;

public class IdempotentInterceptor implements HandlerInterceptor {

    private static final Logger logger = LoggerFactory.getLogger(IdempotentInterceptor.class);

    private final StringRedisTemplate redisTemplate;

    public IdempotentInterceptor(StringRedisTemplate redisTemplate) {
        this.redisTemplate = redisTemplate;
    }

    @Override
    public boolean preHandle(@NonNull HttpServletRequest request,
                             @NonNull HttpServletResponse response,
                             @NonNull Object handler)
            throws Exception {
        // 幂等性校验逻辑
        // 1. 从请求中获取幂等令牌
        // 2. 检查令牌是否已存在
        // 3. 如果不存在则存储令牌并允许请求通过，否则拒绝请求

        String token = request.getHeader("Idempotent-Token");
        if (token == null || token.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Missing idempotent token");
            return false;
        }

        // 尝试设置令牌，如果设置成功说明是第一次请求
        Boolean success = redisTemplate.opsForValue().setIfAbsent(token, "1", 30, TimeUnit.MINUTES);
        if (Boolean.TRUE.equals(success)) {
            return true; // 允许请求通过
        } else {
            response.setStatus(HttpServletResponse.SC_CONFLICT);
            response.getWriter().write("Request already processed");
            return false; // 拒绝重复请求
        }
    }

    @Override
    public void postHandle(@NonNull HttpServletRequest request,
                           @NonNull HttpServletResponse response,
                           @NonNull Object handler,
                           ModelAndView modelAndView) throws Exception {
        // 请求处理完成后的操作

    }

    @Override
    public void afterCompletion(@NonNull HttpServletRequest request,
                                @NonNull HttpServletResponse response,
                                @NonNull Object handler,
                                Exception ex) throws Exception {
        // 请求完成后清理工作
        if (ex != null) {
            // 记录异常信息
            logger.error("Request processing failed for URI: {}", request.getRequestURI(), ex);
        }

        // 清理线程局部变量等资源
        // 示例：ThreadLocalCleaner.cleanup();

        // 其他清理工作
    }

}
