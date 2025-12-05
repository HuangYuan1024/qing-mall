# 使用Higress官方脚本安装Higress
echo "🔧 安装 Higress..."

# 获取项目根目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"

# 指定Higress安装目录
HIGRESS_INSTALL_DIR="$PROJECT_ROOT/higress"
echo "Higress 安装目录: $HIGRESS_INSTALL_DIR"

## 创建安装目录
#mkdir -p "$HIGRESS_INSTALL_DIR"
#
## 进入安装目录执行安装命令
#cd ../../../

## 清理可能存在的旧安装
#echo "🧹 清理可能存在的旧 Higress 安装..."
#docker ps -a --filter "name=higress" --format "{{.Names}}" | xargs -r docker rm -f
#docker network ls --filter "name=higress" --format "{{.Name}}" | xargs -r docker network rm 2>/dev/null || true

## 执行Higress安装脚本
#echo "执行 Higress 安装脚本..."
## 用宿主的Docker网络
#./build/script/local/get-higress.sh -c "nacos://host.docker.internal:8848" -a
#echo "✅ Higress 安装成功"

# 由于官方脚本会创建自己的容器，我们需要调整网络配置
echo "🌐 配置网络连接..."
sleep 5

echo "当前网络列表:"
docker network ls | grep app

# 将Higress网关容器加入到app-network网络
HIGRESS_CONTAINER=$(docker ps --filter "name=higress-gateway" --format "{{.Names}}" | head -1)
if [ -n "$HIGRESS_CONTAINER" ]; then
    echo "连接 Higress 容器 ($HIGRESS_CONTAINER) 到网络app-network..."
    docker network connect local_app-network "$HIGRESS_CONTAINER" 2>/dev/null || echo "⚠️  网络连接已存在或连接失败"
else
    echo "⚠️  未找到 Higress 容器，跳过网络连接"
fi