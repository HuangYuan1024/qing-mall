package main
import (
  "github.com/alibaba/higress/plugins/wasm-go/pkg/wrapper"
  "github.com/higress-group/proxy-wasm-go-sdk/proxywasm"
  "github.com/higress-group/proxy-wasm-go-sdk/proxywasm/types"
  "github.com/tidwall/gjson"
)
func main() {
  wrapper.SetCtx(
    // 插件名称
    "my-plugin",
    // 为解析插件配置，设置自定义函数
     wrapper.ParseConfigBy(parseConfig),
    // 为处理请求头，设置自定义函数
    wrapper.ProcessRequestHeadersBy(onHttpRequestHeaders),
  )
}
// 自定义插件配置
type MyConfig struct {
  mockEnable bool
}
// 在控制台插件配置中填写的yaml配置会自动转换为json，此处直接从json这个参数里解析配置即可
func parseConfig(json gjson.Result, config *MyConfig, log wrapper.Log) error {
  // 解析出配置，更新到config中
  config.mockEnable = json.Get("mockEnable").Bool()
  return nil
}
func onHttpRequestHeaders(ctx wrapper.HttpContext, config MyConfig, log wrapper.Log) types.Action {
  proxywasm.AddHttpRequestHeader("hello", "world")
  if config.mockEnable {
    proxywasm.SendHttpResponse(200, nil, []byte("hello world"), -1)
  }
  return types.ActionContinue
}