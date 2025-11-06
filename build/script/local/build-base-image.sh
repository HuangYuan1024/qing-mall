#!/bin/bash

# 基础镜像信息
BASE_IMAGE_NAME="qing/base"
BASE_IMAGE_TAG="1.0.0"
BASE_IMAGE_FULL="${BASE_IMAGE_NAME}:${BASE_IMAGE_TAG}"
DOCKERFILE_PATH="../../docker/Dockerfile.base"  # 根据实际路径调整

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 日志函数
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# 检查 Docker 是否运行
check_docker() {
    if ! docker info > /dev/null 2>&1; then
        log_error "Docker 未运行或当前用户没有权限访问 Docker"
        exit 1
    fi
}

# 检查镜像是否存在
check_image_exists() {
    log_info "检查镜像是否存在: ${BASE_IMAGE_FULL}"
    if docker image inspect "${BASE_IMAGE_FULL}" > /dev/null 2>&1; then
        log_info "镜像 ${BASE_IMAGE_FULL} 已存在"
        return 0
    else
        log_warn "镜像 ${BASE_IMAGE_FULL} 不存在"
        return 1
    fi
}

# 构建基础镜像
build_base_image() {
    log_info "开始构建基础镜像: ${BASE_IMAGE_FULL}"

    # 检查 Dockerfile 是否存在
    if [ ! -f "$DOCKERFILE_PATH" ]; then
        log_error "Dockerfile 不存在: $DOCKERFILE_PATH"
        log_error "请检查路径是否正确"
        exit 1
    fi

    # 构建镜像
    if docker build -t "${BASE_IMAGE_FULL}" -f "$DOCKERFILE_PATH" .; then
        log_info "✅ 基础镜像构建成功: ${BASE_IMAGE_FULL}"

        # 暂停5秒
        sleep 5

        # 验证镜像
        log_info "验证镜像..."
        if docker run --rm "${BASE_IMAGE_FULL}" java -version && \
           docker run --rm "${BASE_IMAGE_FULL}" curl --version; then
            log_info "✅ 镜像验证成功"
        else
            log_warn "⚠️  镜像验证过程中出现警告"
        fi
    else
        log_error "❌ 基础镜像构建失败"
        exit 1
    fi
}

# 主函数
main() {
    log_info "=== 基础镜像构建脚本 ==="
    log_info "目标镜像: ${BASE_IMAGE_FULL}"
    log_info "Dockerfile: ${DOCKERFILE_PATH}"
    echo

    # 检查 Docker
    check_docker

    # 检查镜像是否存在
    if check_image_exists; then
        log_info "无需构建，镜像已存在"
    else
        log_info "需要构建基础镜像"
        build_base_image
    fi

    log_info "=== build-base-image.sh 脚本执行完成 ==="
}

# 执行主函数
main "$@"