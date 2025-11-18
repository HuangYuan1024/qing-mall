package main

import (
	"fmt"
	"strings"

	"github.com/alibaba/higress/plugins/wasm-go/pkg/wrapper"
	"github.com/google/uuid"
	"github.com/higress-group/proxy-wasm-go-sdk/proxywasm"
	"github.com/higress-group/proxy-wasm-go-sdk/proxywasm/types"
	"github.com/tidwall/gjson"
)

func main() {
	wrapper.SetCtx(
		// 插件名称
		"easy-logger",
		// 设置自定义函数解析插件配置
		wrapper.ParseConfigBy(parseConfig),
		// 设置自定义函数处理请求头
		wrapper.ProcessRequestHeadersBy(onHttpRequestHeaders),
		// 设置自定义函数处理请求体
		wrapper.ProcessRequestBodyBy(onHttpRequestBody),
		// 设置自定义函数处理响应头
		wrapper.ProcessResponseHeadersBy(onHttpResponseHeaders),
		// 设置自定义函数处理响应体
		wrapper.ProcessResponseBodyBy(onHttpResponseBody),
		// 设置自定义函数处理流式请求体
		//wrapper.ProcessStreamingRequestBodyBy(onHttpStreamingRequestBody),
		// 设置自定义函数处理流式响应体
		//wrapper.ProcessStreamingResponseBodyBy(onHttpStreamingResponseBody),
	)
}

// 自定义插件配置
type LoggerConfig struct {
	// 是否打印请求
	request bool
	// 是否打印响应
	response bool
	// 打印响应状态码，* 表示打印所有状态响应，500,502,503 表示打印 HTTP 500、502、503 状态响应，默认是 *
	responseStatusCodes string
}

func parseConfig(json gjson.Result, config *LoggerConfig, log wrapper.Log) error {
	log.Debugf("parseConfig()")
	config.request = json.Get("request").Bool()
	config.response = json.Get("response").Bool()
	config.responseStatusCodes = json.Get("responseStatusCodes").String()
	if config.responseStatusCodes == "" {
		config.responseStatusCodes = "*"
	}
	log.Debugf("parse config:%+v", config)
	return nil
}

func onHttpRequestHeaders(ctx wrapper.HttpContext, config LoggerConfig, log wrapper.Log) types.Action {
	log.Debugf("onHttpRequestHeaders()")
	requestId := uuid.New().String()
	ctx.SetContext("requestId", requestId)
	if !config.request {
		return types.ActionContinue
	}
	// 获取并打印请求头
	headers, _ := proxywasm.GetHttpRequestHeaders()
	var build strings.Builder
	build.WriteString("\n===========request headers===============\n")
	build.WriteString(fmt.Sprintf("requestId:%s\n", requestId))
	for _, values := range headers {
		build.WriteString(fmt.Sprintf("%s:%s\n", values[0], values[1]))
	}
	log.Infof(build.String())
	// 继续处理请求
	return types.ActionContinue
}

func onHttpRequestBody(ctx wrapper.HttpContext, config LoggerConfig, body []byte, log wrapper.Log) types.Action {
	log.Debugf("onHttpRequestBody()")
	// 打印请求体
	if config.request {
		var build strings.Builder
		build.WriteString("\n===========request body===============\n")
		requestId := ctx.GetContext("requestId").(string)
		build.WriteString(fmt.Sprintf("requestId:%s\n", requestId))
		build.WriteString(fmt.Sprintf("body:%s\n", string(body)))
		log.Infof(build.String())
	}
	return types.ActionContinue
}

func onHttpResponseHeaders(ctx wrapper.HttpContext, config LoggerConfig, log wrapper.Log) types.Action {
	log.Debugf("onHttpResponseHeaders()")
	// 添加自定义响应头
	proxywasm.AddHttpResponseHeader("x-easy-logger", "1.0.0")
	if !config.response {
		return types.ActionContinue
	}
	// 获取响应状态码
	statusCode, _ := proxywasm.GetHttpResponseHeader(":status")
	logResponseBody := false
	// 根据响应状态码决定是否打印响应体
	if config.responseStatusCodes == "*" || strings.Contains(config.responseStatusCodes, statusCode) {
		logResponseBody = true
	}
	// 将是否记录响应体的信息存储在上下文中，在 onHttpResponseBody 阶段获取上下文判断是否打印响应体
	ctx.SetContext("logResponseBody", logResponseBody)
	// 获取响应头
	headers, _ := proxywasm.GetHttpResponseHeaders()
	// 打印响应头
	var build strings.Builder
	build.WriteString("\n===========response headers===============\n")
	requestId := ctx.GetContext("requestId").(string)
	build.WriteString(fmt.Sprintf("requestId:%s\n", requestId))
	for _, values := range headers {
		build.WriteString(fmt.Sprintf("%s:%s\n", values[0], values[1]))
	}
	log.Infof(build.String())
	return types.ActionContinue
}

func onHttpResponseBody(ctx wrapper.HttpContext, config LoggerConfig, body []byte, log wrapper.Log) types.Action {
	log.Debugf("onHttpResponseBody()")
	// 获取在 onHttpRequestHeaders 阶段设置的上下文
	logResponseBody, ok := ctx.GetContext("logResponseBody").(bool)
	if !ok {
		return types.ActionContinue
	}
	// 打印响应体
	if logResponseBody {
		var build strings.Builder
		build.WriteString("\n===========response body===============\n")
		requestId := ctx.GetContext("requestId").(string)
		build.WriteString(fmt.Sprintf("requestId:%s\n", requestId))
		build.WriteString(fmt.Sprintf("body:%s\n", string(body)))
		log.Infof(build.String())
	}
	return types.ActionContinue
}