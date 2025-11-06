package com.huangyuan.qingspringbootstarterweb.exception;

import com.huangyuan.qingcommon.exception.BizException;
import com.huangyuan.qingcommon.result.R;
import jakarta.validation.ConstraintViolation;
import jakarta.validation.ConstraintViolationException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.validation.BindException;
import org.springframework.validation.FieldError;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.method.annotation.MethodArgumentTypeMismatchException;
import org.springframework.web.servlet.NoHandlerFoundException;

import java.util.stream.Collectors;

/**
 * 全局异常兜底
 * 统一返回 R<T> 对象，前端只认这一种结构
 */
@Slf4j
@RestControllerAdvice
public class GlobalExceptionHandler {

    /*=================== 业务异常 ===================*/
    @ExceptionHandler(BizException.class)
    public R<Void> handleBiz(BizException e) {
        log.warn("BizException: {}", e.getMessage());
        return R.fail(e.getCode(), e.getMessage());
    }

    /*=================== 参数校验 ===================*/
    // @Valid 注解在 body 上
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public R<Void> handleValidBody(MethodArgumentNotValidException e) {
        String msg = e.getBindingResult().getFieldErrors()
                .stream()
                .map(FieldError::getDefaultMessage)
                .collect(Collectors.joining(","));
        return R.fail("400", msg);
    }

    // @Valid 注解在 query/path 上
    @ExceptionHandler(ConstraintViolationException.class)
    public R<Void> handleValidParam(ConstraintViolationException e) {
        String msg = e.getConstraintViolations()
                .stream()
                .map(ConstraintViolation::getMessage)
                .collect(Collectors.joining(","));
        return R.fail("400", msg);
    }

    // 表单/URL 绑定失败
    @ExceptionHandler(BindException.class)
    public R<Void> handleBind(BindException e) {
        String msg = e.getFieldErrors()
                .stream()
                .map(FieldError::getDefaultMessage)
                .collect(Collectors.joining(","));
        return R.fail("400", msg);
    }

    /*=================== 常见容器异常 ===================*/
    @ExceptionHandler({
            NoHandlerFoundException.class,
            HttpRequestMethodNotSupportedException.class,
            HttpMessageNotReadableException.class,
            MethodArgumentTypeMismatchException.class
    })
    public R<Void> handleSpringMvp(Exception e) {
        log.warn("SpringMVC 异常: {}", e.getMessage());
        return R.fail("400", "请求参数或路径异常");
    }

    /*=================== 兜底 ===================*/
    @ExceptionHandler(Throwable.class)
    public R<Void> handleAll(Throwable e) {
        log.error("系统异常", e);
        return R.fail("500", "服务器内部错误");
    }
}
