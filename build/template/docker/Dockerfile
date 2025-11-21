# 1. 基础镜像
FROM qing/base:1.0.0

# 2. 系统层优化
ENV TZ=Asia/Shanghai \
    LANG=C.UTF-8

# 3. 创建非 root 用户
RUN useradd -r -s /bin/false -U -m -d /app app && \
    chown -R app:app /app
USER app
WORKDIR /app

# 4. 拷贝 FatJar (优化权限)
COPY --chown=app:app code/business/generatetemplate-service/generatetemplate-boot/target/*.jar app.jar

## 5. 健康检查 (可选)
# HEALTHCHECK --interval=30s --timeout=3s --start-period=60s --retries=3/ \
#     CMD curl -f http://localhost:8080/health || exit 1

# 6. 启动（exec 形式 + 推荐常用参数）
ENTRYPOINT ["java", \
            "-XX:+UseContainerSupport", \
            "-XX:MaxRAMPercentage=75.0", \
            "-XX:+UseG1GC", \
            "-XX:+UseStringDeduplication", \
            "-XshowSettings:vm", \
            "-jar", \
            "/app/app.jar"]
