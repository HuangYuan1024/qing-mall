package com.huangyuan.qingsdkopenfeign.config;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.ApplicationContext;

import static org.assertj.core.api.AssertionsForClassTypes.assertThat;

@SpringBootTest(classes = OpenFeignSdkAutoConfiguration.class)
class OpenFeignSdkAutoConfigurationTest {

    @Autowired
    private ApplicationContext applicationContext;

    @Test
    void contextLoads() {
        // 验证Spring上下文成功加载
        assertThat(applicationContext).isNotNull();

        // 可以添加更多具体的Bean存在性验证
        // 例如：assertThat(applicationContext.getBean(YourBean.class)).isNotNull();
    }
}

