package com.huangyuan.qingspringbootstartermybatis.config;

import com.baomidou.mybatisplus.extension.plugins.MybatisPlusInterceptor;
import com.baomidou.mybatisplus.extension.plugins.handler.TenantLineHandler;
import com.baomidou.mybatisplus.extension.plugins.inner.BlockAttackInnerInterceptor;
import com.baomidou.mybatisplus.extension.plugins.inner.PaginationInnerInterceptor;
import com.baomidou.mybatisplus.extension.plugins.inner.TenantLineInnerInterceptor;
import org.springframework.context.annotation.Bean;

// 配分页、多租户、链路ID
public class MybatisPlusConfig {

    @Bean
    public MybatisPlusInterceptor mybatisPlusInterceptor() {
        MybatisPlusInterceptor interceptor = new MybatisPlusInterceptor();

        // 分页插件 - 优先级最高
        interceptor.addInnerInterceptor(new PaginationInnerInterceptor());

        // 多租户插件 - 需要配置租户处理器
        TenantLineInnerInterceptor tenantInterceptor = getTenantLineInnerInterceptor();
        interceptor.addInnerInterceptor(tenantInterceptor);

        // 链路ID插件
        interceptor.addInnerInterceptor(new BlockAttackInnerInterceptor());

        return interceptor;
    }

    private static TenantLineInnerInterceptor getTenantLineInnerInterceptor() {
        TenantLineInnerInterceptor tenantInterceptor = new TenantLineInnerInterceptor();
        tenantInterceptor.setTenantLineHandler(new TenantLineHandler() {
            @Override
            public net.sf.jsqlparser.expression.Expression getTenantId() {
                // TODO 后续换成从登录上下文/请求头里取
                return new net.sf.jsqlparser.expression.LongValue(1);
            }

            @Override
            public boolean ignoreTable(String tableName) {
                // 忽略全局表、字典表等
                return "sys_config".equalsIgnoreCase(tableName)
                        || "dict".equalsIgnoreCase(tableName);
            }
        });
        return tenantInterceptor;
    }
}


