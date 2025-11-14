#!/bin/bash

echo "🔍 检查部署环境..."

# 检查Docker
if command -v docker &> /dev/null; then
    echo "✅ Docker 已安装: $(docker --version)"
else
    echo "❌ Docker 未安装"
    exit 1
fi

# 检查Docker Compose
if command -v docker-compose &> /dev/null; then
    echo "✅ Docker Compose 已安装: $(docker-compose --version)"
else
    echo "❌ Docker Compose 未安装"
    exit 1
fi

# 检查必要的目录和文件
REQUIRED_FILES=(
    "docker-compose.yml"
    "../../docker/service/goods-service/Dockerfile"
    "../../docker/mysql/init/01-init-databases.sql"
    "../../docker/mysql/init/02-nacos-schema.sql"
    "../../docker/mysql/init/03-shop-goods.sql"
    "../../docker/higress/config.yaml"
)

for file in "${REQUIRED_FILES[@]}"; do
    if [ -f "$file" ]; then
        echo "✅ $file 存在"
    else
        echo "❌ $file 不存在"
    fi
done

# 检查goods-service jar包
JAR_FILE="../../../code/business/goods-service/goods-boot/target/*.jar"
if ls $JAR_FILE 1> /dev/null 2>&1; then
    echo "✅ goods-service jar包存在"
else
    echo "⚠️  goods-service jar包不存在，请先构建项目"
fi

# 检查file-service jar包
JAR_FILE="../../../code/business/file-service/file-boot/target/*.jar"
if ls $JAR_FILE 1> /dev/null 2>&1; then
    echo "✅ file-service jar包存在"
else
    echo "⚠️  file-service jar包不存在，请先构建项目"
fi

echo ""
echo "📋 环境检查完成！"