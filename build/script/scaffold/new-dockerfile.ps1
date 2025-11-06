# ============= new-service.ps1 =============

# 该PowerShell脚本用于生成新的Dockerfile，创建目录结构、复制模板、修改内容等

# 命令格式:  .\new-dockerfile.ps1 <service_name>
# 示例用法(生成一个user-service的Dockerfile):  .\new-dockerfile.ps1 ums

# 注意事项：
# 1. 在运行脚本之前，请先启用系统长路径支持（具体操作可百度或询问AI）
# 2. 请使用PowerShell 7 或更高版本运行此脚本！

param(
# 只允许输入一个「单词」
    [Parameter(Mandatory = $true)]
    [ValidatePattern('^[a-zA-Z0-9-]+$', ErrorMessage = '输入内容只能包含字母、数字、连字符')]   # 简单校验，防止带空格或特殊符号
    [string]$Word,  # 必填，比如：ums、order、product等

# 旧参数保留，但不再强制，默认值由 $Word 自动拼出来
    [string]$Service = "$Word-service"
)

# 如果想强制用户只通过 -Word 传参，可以把下面注释行打开：
# $PSBoundParameters.Remove('Service')  | Out-Null

Write-Host "Word    : $Word"
Write-Host "Service : $Service"

$PSDefaultParameterValues['*:Encoding'] = 'utf8NoBom'
$ErrorActionPreference = "Stop"
$Root       = Split-Path -Parent $PSScriptRoot | Split-Path -Parent | Split-Path -Parent

# 模板文件(可手动修改为其它路径)
$Template = Join-Path $Root "build\template\docker\Dockerfile"

if (!(Test-Path $Template)) {
    Write-Error "模板文件 $Template 不存在！"
    exit 1
}

# 目标目录(可手动修改为其它路径)
$Target = Join-Path $Root "build\docker\service\$Service"

if (Test-Path $Target) {
    Write-Error "目标目录 $Target 已存在！"
    exit 1
}

# 全小写 word
$newWord = $Word.ToLower()

# 1. 创建目录结构
New-Item -ItemType Directory -Path $Target | Out-Null

# 2. 复制模板文件
Copy-Item $Template -Destination $Target | Out-Null

# 3. 查找并替换文件中的内容（“generatetemplate” → “$newWord”）
Get-ChildItem $Target -File -Recurse | ForEach-Object {
    # 强制 UTF-8 读写，避免 BOM
    $content = Get-Content $_.FullName -Raw -Encoding UTF8
    $content -replace 'generatetemplate', $newWord |
            Set-Content -NoNewline -Encoding UTF8 -Path $_.FullName
}

Write-Host ">>> Dockerfile生成完毕：$Target\Dockerfile"