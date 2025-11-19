package com.huangyuan.orderinterface.controller;

import com.huangyuan.goodsapplication.dto.BrandDto;
import com.huangyuan.goodsapplication.service.query.BrandQueryAppService;
import com.huangyuan.orderapplication.service.command.OrderCommandAppService;
import com.huangyuan.qingcommon.result.RespResult;
import io.seata.core.context.RootContext;
import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.dubbo.config.annotation.DubboReference;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

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

    private final OrderCommandAppService orderCommandAppService;

    /**
     * 测试Seata分布式事务
     */
    @GetMapping("/seata/{isRollback}")
    @Operation(summary = "测试Seata分布式事务")
    public Map<String, Object> testSeata(@PathVariable("isRollback") Boolean isRollback) {
        Map<String, Object> result = new HashMap<>();

        try {
            // 记录测试开始前的时间和数据状态
            result.put("startTime", LocalDateTime.now().toString());
            result.put("xid", RootContext.getXID());

            orderCommandAppService.createOrder(isRollback);

            result.put("success", true);
            result.put("message", "执行成功！分布式事务已提交");
            result.put("endTime", LocalDateTime.now().toString());

        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "执行失败！分布式事务已回滚");
            result.put("error", e.getMessage());
            result.put("endTime", LocalDateTime.now().toString());
            result.put("xid", RootContext.getXID()); // 回滚后XID可能为null
        }

        return result;
    }

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