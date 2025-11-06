# ============= new-service.ps1 =============

# 该PowerShell脚本用于生成新的服务，创建目录结构、复制模板、修改文件名、包名、内容等

#                命令格式:     .\new-service.ps1 <service_name>
# 示例用法(生成一个user服务):    .\new-service.ps1 ums

# 注意事项：
# 1. 在运行脚本之前，请先启用系统长路径支持（具体操作可百度或询问AI）
# 2. 请使用PowerShell 7 或更高版本运行此脚本！

param(
    # 只允许输入一个「单词」
    [Parameter(Mandatory = $true)]
    [ValidatePattern('^[a-zA-Z0-9-]+$', ErrorMessage = '输入内容只能包含字母、数字、连字符')]   # 简单校验，防止带空格或特殊符号
    [string]$Word,  # 必填，比如：ums、order、product等

    # 旧参数保留，但不再强制，默认值由 $Word 自动拼出来
    [string]$Service = "$Word-service",
    [string]$Package = "com.huangyuan.$Word"
)

# 如果想强制用户只通过 -Word 传参，可以把下面两行打开：
# $PSBoundParameters.Remove('Service')  | Out-Null
# $PSBoundParameters.Remove('Package')  | Out-Null

Write-Host "Word    : $Word"
Write-Host "Service : $Service"
Write-Host "Package : $Package"

$PSDefaultParameterValues['*:Encoding'] = 'utf8NoBom'
$ErrorActionPreference = "Stop"
$Root       = Split-Path -Parent $PSScriptRoot | Split-Path -Parent | Split-Path -Parent

# 模板目录(可手动修改为其它路径)
$Template   = Join-Path $Root "build/template/generatetemplate-service"

if (!(Test-Path $Template)) {
    Write-Error "模板目录 $Template 不存在！"
    exit 1
}

# 目标目录(可手动修改为其它路径)
$Target     = Join-Path $Root "code\business\$Service"

if (Test-Path $Target) {
    Write-Error "目标目录 $Target 已存在！"
    exit 1
}

# 全小写 word
$newWord      = $Word.ToLower()
# 首字母大写 Word
$newWordCap   = (Get-Culture).TextInfo.ToTitleCase($newWord)
# 全大写 WORD
$newWordUpper = $newWord.ToUpper()

# 1. 整体拷贝模板
Write-Host ">>> 拷贝模板..."
Copy-Item -Path $Template -Destination $Target -Recurse

# 2. 拆分旧/新包名、groupId、artifactId
$OldPkg     = "com.huangyuan.generatetemplate"
$OldGroupId = "com.huangyuan"
$OldArtifact= "generatetemplate-service"

$NewPkg     = $Package
$NewGroupId = $Package.Substring(0, $Package.LastIndexOf('.'))
$NewArtifact= $Service

# 3. 递归替换文件内容 + 文件名
$oldWord      = 'generatetemplate'
$oldWordCap   = (Get-Culture).TextInfo.ToTitleCase($oldWord)  # Generatetemplate
$excludeSet   = @('.jar','.class','.zip','.jpg','.png','.gif','.ico','.dll','.exe','.bin')

Get-ChildItem $Target -File -Recurse | ForEach-Object {
    # 跳过已知二进制后缀
    if ($excludeSet -contains $_.Extension) { return }

    # 跳过空文件
    if ($_.Length -eq 0) { return }

    $content = Get-Content $_.FullName -Raw -ErrorAction SilentlyContinue
    if ([string]::IsNullOrEmpty($content)) { return }   # 二进制或读不出内容直接跳过

    # ------ 1. 复合类名/变量名（大小写敏感）------
    $content = [regex]::Replace($content, 'Generatetemplate(?=[A-Z])', $newWordCap,     'None')  # GeneratetemplateController -> WordController
    $content = [regex]::Replace($content, 'GENERATETEMPLATE(?=[A-Z])', $newWordUpper,   'None')  # GENERATETEMPLATE_DTO       -> WORD_DTO
    $content = [regex]::Replace($content, '\bgeneratetemplate\b',      $newWord,        'None')  # generatetemplateService    -> wordService

    # ------ 2. 替换包名、groupId、artifact ------
    $content = $content -replace [regex]::Escape($OldPkg),     $NewPkg
    $content = $content -replace [regex]::Escape($OldGroupId), $NewGroupId
    $content = $content -replace [regex]::Escape($OldArtifact),$NewArtifact

    # 写回文件
    Set-Content -Path $_.FullName -Value $content -NoNewline

    # ------ 4. 文件名替换 ------
    if ($_.Name -match $oldWordCap) {
        $newName = $_.Name -replace $oldWordCap, $newWordCap
        Rename-Item -Path $_.FullName -NewName $newName -Force
    }
}

# 4. 同级改名：com\huangyuan\generatetemplate*  ->  com\huangyuan\word*
Get-ChildItem $Target -Dir -Recurse | Where-Object {
    $_.FullName -match 'src\\(main|test)\\java\\com\\huangyuan$'
} | ForEach-Object {
    # 先改父级 generatetemplate -> word
    Get-ChildItem $_ -Dir -Filter 'generatetemplate' | Rename-Item -NewName $newWord -Force
    # 再改同级 generatetemplate* -> word*
    Get-ChildItem $_ -Dir -Filter 'generatetemplate*' | Rename-Item -NewName { $_.Name -replace '^generatetemplate', $newWord } -Force
}

# 5. 统一改模块名（文件夹 & pom.xml 里 artifactId 已替换，这里只改目录名）
@('generatetemplate-boot','generatetemplate-domain','generatetemplate-infrastructure','generatetemplate-interface','generatetemplate-application','generatetemplate-integration') | ForEach-Object {
    $old = Join-Path $Target $_
    $new = $_.Replace('generatetemplate', $Service.Split('-')[0])
    if (Test-Path $old) { Rename-Item $old $new -Force }
}

Write-Host ">>> 完成！新服务已生成：$Target"
