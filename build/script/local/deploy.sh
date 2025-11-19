#!/bin/bash

set -e

echo "🚀 开始部署微服务套件..."

echo "检查环境..."
./check-environment.sh

# 检查Docker是否运行
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker 未运行，请启动Docker"
    exit 1
fi

# 检查是否已经有运行中的容器
echo "📦 检查现有容器..."
RUNNING_CONTAINERS=$(docker ps -q --filter "name=qing_")
if [ -n "$RUNNING_CONTAINERS" ]; then
    echo "🛑 停止现有容器..."
    docker stop $RUNNING_CONTAINERS
fi

# 清除旧service容器（容错写法）
echo "清除旧service容器..."
docker ps -aq --filter "name=_service" | xargs -r docker rm -f

echo "构建基础镜像..."
./build-base-image.sh

# 清除旧service镜像（强制）
echo "清除旧service镜像..."
#docker image rm -f qing/goods-service:latest || true
#docker image rm -f qing/file-service:latest || true
#docker image rm -f qing/order-service:latest || true

# 构建所有服务
echo "🔨 构建所有服务..."
docker-compose up -d

# 等待服务启动
echo "⏳ 等待服务启动..."
sleep 5

# 验证 Nacos 配置 - 使用更可靠的验证方法
echo "🔍 验证 Nacos 配置..."
echo "检查 Nacos 配置文件内容:"
docker exec qing_nacos cat /home/nacos/conf/application.properties || echo "无法读取配置文件"

# 多种方式验证配置
CONFIG_CHECK1=$(docker exec qing_nacos grep -q "nacos.core.api.compatibility.console.enabled=true" /home/nacos/conf/application.properties 2>/dev/null && echo "found" || echo "not found")
CONFIG_CHECK2=$(docker exec qing_nacos cat /home/nacos/conf/application.properties 2>/dev/null | grep -q "nacos.core.api.compatibility.console.enabled=true" && echo "found" || echo "not found")

# 检查 server.address 配置
SERVER_ADDRESS_CHECK=$(docker exec qing_nacos grep -q "server.address=0.0.0.0" /home/nacos/conf/application.properties 2>/dev/null && echo "found" || echo "not found")

echo "配置检查结果:"
echo "方式1: $CONFIG_CHECK1"
echo "方式2: $CONFIG_CHECK2"
echo "server.address 检查: $SERVER_ADDRESS_CHECK"

if [ "$CONFIG_CHECK1" = "found" ] || [ "$CONFIG_CHECK2" = "found" ]; then
    echo "✅ Nacos 兼容性配置验证成功"
else
    echo "❌ Nacos 兼容性配置验证失败，尝试直接写入容器..."

    # 直接写入容器
    docker exec qing_nacos sh -c 'echo "nacos.core.api.compatibility.console.enabled=true" >> /home/nacos/conf/application.properties'

    # 重启 Nacos 使配置生效
    echo "重启 Nacos 容器..."
    docker restart qing_nacos

    # 等待 Nacos 重启
    echo "等待 Nacos 重启..."
    for i in {1..30}; do
        if curl -f http://localhost:8848/nacos/ > /dev/null 2>&1; then
            echo "✅ Nacos 重启成功"
            break
        fi
        echo "⏱️  等待 Nacos 启动... ($i/30)"
        sleep 2
    done

    # 最终验证
    if docker exec qing_nacos grep -q "nacos.core.api.compatibility.console.enabled=true" /home/nacos/conf/application.properties 2>/dev/null; then
        echo "✅ Nacos 兼容性配置最终验证成功"
    else
        echo "❌ Nacos 兼容性配置仍然失败，但继续部署..."
    fi
fi

# 验证 server.address 配置
if [ "$SERVER_ADDRESS_CHECK" = "found" ]; then
    echo "✅ server.address 配置为 0.0.0.0 验证成功"
else
    echo "❌ server.address 配置验证失败，尝试直接写入容器..."

    # 直接写入容器
    docker exec qing_nacos sh -c 'echo "server.address=0.0.0.0" >> /home/nacos/conf/application.properties'

    # 重启 Nacos 使配置生效
    echo "重启 Nacos 容器..."
    docker restart qing_nacos

    # 等待 Nacos 重启
    echo "等待 Nacos 重启..."
    for i in {1..30}; do
        if curl -f http://localhost:8848/nacos/ > /dev/null 2>&1; then
            echo "✅ Nacos 重启成功"
            break
        fi
        echo "⏱️  等待 Nacos 启动... ($i/30)"
        sleep 2
    done

    # 最终验证
    if docker exec qing_nacos grep -q "server.address=0.0.0.0" /home/nacos/conf/application.properties 2>/dev/null; then
        echo "✅ server.address 配置最终验证成功"
    else
        echo "❌ server.address 配置仍然失败，但继续部署..."
    fi
fi

# 注册nginx到nacos
IP=$(docker inspect qing_cache -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}')
curl -s -X POST "http://localhost:8848/nacos/v1/ns/instance" \
  -d "serviceName=cache" \
  -d "ip=$IP" \
  -d "port=9080" \
  -d "namespaceId=higress-system" \
  -d "healthy=true" \
  -d "ephemeral=true"
echo " Nginx(cache)被注册到Nacos: $IP:9080"

# 注册redis到nacos
IP=$(docker inspect qing_redis -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}')
curl -s -X POST "http://localhost:8848/nacos/v1/ns/instance" \
  -d "serviceName=redis" \
  -d "ip=$IP" \
  -d "port=6379" \
  -d "namespaceId=higress-system" \
  -d "healthy=true" \
  -d "ephemeral=true"
echo " Redis被注册到Nacos: $IP:6379"

# 安装 Higress
./higress-install.sh

# 检查服务状态
echo "🔍 检查服务状态..."
docker-compose ps

echo "✅ 部署完成！"
echo ""
echo "📊 服务访问地址："
echo "   - Nacos 控制台: http://localhost:8181/ (账号: nacos/nacos)"
echo "   - Higress 控制台: http://localhost:8080 (账号: admin/admin)"
echo "   - MySQL: localhost:3306 (root/root)"
echo "   - Higress Gateway: http://localhost:80"
echo ""
echo "🔧 常用命令："
echo "   - 查看日志: docker-compose logs -f"
echo "   - 停止服务: docker-compose down"
echo "   - 重启服务: docker-compose restart"
echo "   - 查看Higress状态: cd $HIGRESS_INSTALL_DIR && bin/status.sh"
echo "   - Higress安装目录: $HIGRESS_INSTALL_DIR"