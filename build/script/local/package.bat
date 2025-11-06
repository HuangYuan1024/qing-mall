@echo off
rem 如遇中文乱码，可 chcp 65001
title Maven Package - goods-boot
color 0A

echo 🚀 开始打包项目...
echo 命令: mvn clean package -pl :goods-boot -am %*

call mvn clean package -pl :goods-boot -am %*
if %errorlevel% neq 0 (
    echo.
    echo ❌ 构建失败！
    pause
    exit /b %errorlevel%
)

echo.
echo ✅ 构建成功！
pause