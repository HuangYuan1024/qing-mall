PLUGIN_NAME ?= hello-world
BUILDER_REGISTRY ?= higress-registry.cn-hangzhou.cr.aliyuncs.com/plugins/
REGISTRY ?= docker.io/huangyuan1024/
GO_VERSION ?= 1.19
TINYGO_VERSION ?= 0.28.1
ORAS_VERSION ?= 1.0.0
HIGRESS_VERSION ?= 1.4.1
USE_HIGRESS_TINYGO ?= true
BUILDER ?= ${BUILDER_REGISTRY}wasm-go-builder:go${GO_VERSION}-tinygo${TINYGO_VERSION}-oras${ORAS_VERSION}
BUILD_TIME := $(shell date "+%Y%m%d-%H%M%S")
COMMIT_ID := $(shell git rev-parse --short HEAD 2>/dev/null)
IMAGE_TAG = $(if $(strip $(PLUGIN_VERSION)),${PLUGIN_VERSION},${BUILD_TIME}-${COMMIT_ID})
IMG ?= ${REGISTRY}${PLUGIN_NAME}:${IMAGE_TAG}
GOPROXY := $(shell go env GOPROXY)
EXTRA_TAGS ?= proxy_wasm_version_0_2_100

.DEFAULT:
local-docker-build:
	DOCKER_BUILDKIT=1 docker build --build-arg BUILDER=${BUILDER}  \
	                            --build-arg GOPROXY=$(GOPROXY) \
	                             --build-arg EXTRA_TAGS=$(EXTRA_TAGS) \
	                            -t ${IMG} \
	                            --output build \
	                            .
	@echo ""
	@echo "output wasm file: ./build/plugin.wasm"

build-image:
	DOCKER_BUILDKIT=1 docker build --build-arg BUILDER=${BUILDER}  \
	                            --build-arg GOPROXY=$(GOPROXY) \
	                            --build-arg EXTRA_TAGS=$(EXTRA_TAGS) \
	                            -t ${IMG} \
	                            .
	@echo ""
	@echo "image:            ${IMG}"

build-push: build-image
	docker push ${IMG}

local-build:
	tinygo build -scheduler=none -target=wasi -gc=custom -tags='custommalloc nottinygc_finalizer $(EXTRA_TAGS)' \
		-o ./build/plugin.wasm main.go
	@echo ""
	@echo "wasm: ./build/plugin.wasm"

local-run:
	echo  > ./envoy.log
	docker compose down
	docker compose up -d

local-all: local-build local-run
local-docker-all: local-docker-build local-run