package main

import (
	"fmt"
	"strings"

	"github.com/alibaba/higress/plugins/wasm-go/pkg/wrapper"
	"github.com/higress-group/proxy-wasm-go-sdk/proxywasm"
	"github.com/higress-group/proxy-wasm-go-sdk/proxywasm/types"
	"github.com/tidwall/gjson"
	"github.com/tidwall/resp"
)

/* ---------- 插件配置 ---------- */
type RedisCacheConfig struct {
	client      wrapper.RedisClient
	serviceName string
	servicePort int64
	ttl         int32
	username    string
	password    string
	timeout     int64
}

/* ---------- 注册插件 ---------- */
func main() {
	wrapper.SetCtx(
		"redis-cache",
		wrapper.ParseConfigBy(parseConfig),
		wrapper.ProcessRequestHeadersBy(onRequestHeaders),
		wrapper.ProcessResponseHeadersBy(onResponseHeaders),
		wrapper.ProcessResponseBodyBy(onResponseBody),
	)
}

/* ---------- 解析配置 ---------- */
func parseConfig(json gjson.Result, config *RedisCacheConfig, log wrapper.Log) error {
	log.Debugf("parseConfig()")
	
	config.serviceName = json.Get("serviceName").String()
	config.servicePort = json.Get("servicePort").Int()
	config.ttl = int32(json.Get("ttl").Int())
	config.username = json.Get("username").String()
	config.password = json.Get("password").String()
	config.timeout = json.Get("timeout").Int()
	
	// 设置默认值
	if config.servicePort == 0 {
		config.servicePort = 6379
	}
	if config.ttl == 0 {
		config.ttl = 300 // 5分钟默认TTL
	}
	if config.timeout == 0 {
		config.timeout = 1000 // 1秒默认超时
	}
	
	// 创建Redis客户端
	config.client = wrapper.NewRedisClusterClient(wrapper.FQDNCluster{
		FQDN: config.serviceName,
		Port: config.servicePort,
	})
	
	// 初始化Redis连接
	err := config.client.Init(config.username, config.password, config.timeout)
	if err != nil {
		log.Errorf("Redis初始化失败: %v", err)
		return err
	}
	
	log.Infof("Redis缓存插件配置完成: Host=%s, Port=%d, TTL=%d", config.serviceName, config.servicePort, config.ttl)
	return nil
}

/* ---------- 请求阶段 ---------- */
func onRequestHeaders(ctx wrapper.HttpContext, config RedisCacheConfig, log wrapper.Log) types.Action {
	log.Debugf("onRequestHeaders()")
	
	// 获取请求路径和host
	path, err := proxywasm.GetHttpRequestHeader(":path")
	if err != nil {
		log.Errorf("获取请求路径失败: %v", err)
		return types.ActionContinue
	}
	
	host, _ := proxywasm.GetHttpRequestHeader(":authority")
	if host == "" {
		host, _ = proxywasm.GetHttpRequestHeader("host")
	}
	
	// 构建缓存键
	cacheKey := buildCacheKey(host, path)
	log.Debugf("缓存键: %s", cacheKey)
	
	// 设置缓存键到上下文
	ctx.SetContext("cacheKey", cacheKey)
	
	// 尝试从Redis获取缓存
	err = config.client.Get(cacheKey, func(response resp.Value) {
		if response.Error() != nil {
			log.Debugf("Redis GET失败或缓存未命中: %v", response.Error())
			proxywasm.ResumeHttpRequest()
			return
		}
		
		cachedValue := response.String()
		if cachedValue != "" {
			log.Infof("🎯 缓存命中! Key: %s", cacheKey)
			
			// 发送缓存的响应
			headers := [][2]string{
				{"content-type", "application/json"},
				{"x-cache", "HIT"},
				{"x-cache-key", cacheKey},
			}
			if err := proxywasm.SendHttpResponse(200, headers, []byte(cachedValue), -1); err != nil {
				log.Errorf("发送缓存响应失败: %v", err)
				proxywasm.ResumeHttpRequest()
			}
		} else {
			log.Debugf("⏳ 缓存未命中: %s", cacheKey)
			proxywasm.ResumeHttpRequest()
		}
	})
	
	if err != nil {
		log.Errorf("调用Redis GET失败: %v", err)
		return types.ActionContinue
	}
	
	// 暂停请求，等待Redis回调
	return types.ActionPause
}

/* ---------- 响应头阶段 ---------- */
func onResponseHeaders(ctx wrapper.HttpContext, config RedisCacheConfig, log wrapper.Log) types.Action {
	log.Debugf("onResponseHeaders()")
	
	// 检查是否有缓存键
	cacheKeyObj := ctx.GetContext("cacheKey")
	if cacheKeyObj == nil {
		return types.ActionContinue
	}
	
	cacheKey, ok := cacheKeyObj.(string)
	if !ok || cacheKey == "" {
		return types.ActionContinue
	}
	
	// 只缓存200响应
	status, err := proxywasm.GetHttpResponseHeader(":status")
	if err != nil || status != "200" {
		log.Debugf("不缓存非200响应: %s", status)
		// 清除缓存键，避免在响应体阶段处理
		ctx.SetContext("cacheKey", "")
		return types.ActionContinue
	}
	
	// 添加缓存标记头
	proxywasm.AddHttpResponseHeader("x-cache", "MISS")
	proxywasm.AddHttpResponseHeader("x-cache-key", cacheKey)
	
	log.Debugf("准备缓存响应，Key: %s", cacheKey)
	return types.ActionContinue
}

/* ---------- 响应体阶段 ---------- */
func onResponseBody(ctx wrapper.HttpContext, config RedisCacheConfig, body []byte, log wrapper.Log) types.Action {
	log.Debugf("onResponseBody()")
	
	// 检查是否有缓存键
	cacheKeyObj := ctx.GetContext("cacheKey")
	if cacheKeyObj == nil {
		return types.ActionContinue
	}
	
	cacheKey, ok := cacheKeyObj.(string)
	if !ok || cacheKey == "" {
		return types.ActionContinue
	}
	
	if len(body) == 0 {
		log.Warnf("响应体为空，跳过缓存")
		return types.ActionContinue
	}
	
	log.Debugf("开始缓存响应体，大小: %d 字节, Key: %s", len(body), cacheKey)
	
	// 设置缓存到Redis
	err := config.client.Set(cacheKey, string(body), func(response resp.Value) {
		if response.Error() != nil {
			log.Errorf("Redis SET失败: %v", response.Error())
		} else {
			log.Infof("✅ 缓存写入成功: %s", cacheKey)
			
			// 设置过期时间
			err := config.client.Expire(cacheKey, int64(config.ttl), func(response resp.Value) {
				if response.Error() != nil {
					log.Errorf("设置TTL失败: %v", response.Error())
				} else {
					log.Infof("✅ TTL设置成功: %s (%d秒)", cacheKey, config.ttl)
				}
			})
			
			if err != nil {
				log.Errorf("调用Redis EXPIRE失败: %v", err)
			}
		}
	})
	
	if err != nil {
		log.Errorf("调用Redis SET失败: %v", err)
	}
	
	return types.ActionContinue
}

/* ---------- 工具函数 ---------- */
func buildCacheKey(host, path string) string {
	// 清理路径，移除重复的斜杠
	cleanPath := strings.ReplaceAll(path, "//", "/")
	
	if host != "" {
		return fmt.Sprintf("hg:cache:%s%s", host, cleanPath)
	}
	return fmt.Sprintf("hg:cache:%s", cleanPath)
}