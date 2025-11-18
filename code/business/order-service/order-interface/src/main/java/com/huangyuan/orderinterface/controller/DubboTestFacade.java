package com.huangyuan.orderinterface.controller;

import com.huangyuan.goodsapplication.dto.BrandDto;
import com.huangyuan.goodsapplication.service.query.BrandQueryAppService;
import com.huangyuan.qingcommon.result.RespResult;
import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.dubbo.config.annotation.DubboReference;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/dubbo-test")
public class DubboTestFacade {

    /**
     * 直接引用goods-service的Dubbo服务
     * check = false 表示启动时不强制检查服务提供者是否存在
     */
    @DubboReference(check = false, version = "1.0.0", interfaceClass = BrandQueryAppService.class)
    private BrandQueryAppService brandQueryService;

    /**
     * 测试基础连通性
     */
    @GetMapping("/connect")
    @Operation(summary = "测试Dubbo服务连通性")
    public String testConnect() {
        try {
            String result = brandQueryService.sayHello("order-service");
            log.info("Dubbo服务调用成功: {}", result);
            return "SUCCESS: " + result;
        } catch (Exception e) {
            log.error("Dubbo服务调用失败", e);
            return "FAILED: " + e.getMessage();
        }
    }

    /**
     * 测试品牌查询
     */
    @GetMapping("/brand/{id}")
    @Operation(summary = "根据id查询品牌")
    public RespResult<BrandDto> getBrandById(@PathVariable("id") Integer id){
        BrandDto brand = brandQueryService.getBrand(id);
        return RespResult.ok(brand);
    }

    /**
     * 完整的服务状态检查
     */
    @GetMapping("/status")
    @Operation(summary = "完整服务状态检查")
    public String serviceStatus() {
        StringBuilder status = new StringBuilder();
        
        // 测试连通性
        status.append("=== Dubbo服务状态检查 ===\n");
        
        try {
            String helloResult = brandQueryService.sayHello("Status-Check");
            status.append("✅ 连通性测试: ").append(helloResult).append("\n");
        } catch (Exception e) {
            status.append("❌ 连通性测试失败: ").append(e.getMessage()).append("\n");
        }
        
        try {
            BrandDto goods = brandQueryService.getBrand(17);
            status.append("✅ 业务方法测试: ").append(goods.getName()).append("\n");
        } catch (Exception e) {
            status.append("❌ 业务方法测试失败: ").append(e.getMessage()).append("\n");
        }
        
        return status.toString();
    }

    /**
     * 只显示项目相关的堆栈信息，避免过多无关信息
     */
    private String getRelevantStackTrace(Exception e) {
        StringBuilder sb = new StringBuilder();
        sb.append("相关堆栈信息:\n");
        for (StackTraceElement element : e.getStackTrace()) {
            if (element.getClassName().contains("com.example") || 
                element.getClassName().contains("apache.dubbo")) {
                sb.append("    ").append(element).append("\n");
            }
        }
        return sb.toString();
    }
}