# 运维指南（v0.0.1 待完善）

## 1. 友情提示

```java
/**
 * 该运维指南尚未完善，很多配置没有说明，部署一定会不成功，请等待后续我完善指南！
 * 我部署各种组件时都非常很折磨，经常遇到版本冲突、网络异常、格式错误、配置失效等问题
 */
```

## 2. 基础环境

本项目需要 Windows11 + WSL2 (建议装一个Ubuntu-22.04) + Docker Desktop v4.48.0或更高版本

确保WSL磁盘空间至少有60GB以上

确保网络可以同时连接中国网络和外国网络（很重要）

## 3. 部署流程

各种配置文件和sql文件我都放在qing-mall-server/build/docker/目录下了，如有需要可以查阅

一键部署脚本是位于qing-mall-server/build/script/local/目录下的deploy.sh，请使用Ubuntu-22.04系统执行该脚本，会自动拉取各个镜像并做好配置在容器运行

等脚本执行完毕，容器运行正常后，执行下一步

Higress部署脚本是位于qing-mall-server/higress/bin/目录下的startup.sh，请使用Ubuntu-22.04系统执行该脚本，会自动拉取Higress各个镜像并在容器运行

注意！Higress的gateway容器运行时会因为网络问题无法连接Nacos，请在上一步的higress-gateway容器启动时，迅速执行以下命令：

```sh
HIGRESS_CONTAINER=$(docker ps --filter "name=higress-gateway" --format "{{.Names}}" | head -1) && if [ -n "$HIGRESS_CONTAINER" ]; then echo "连接 Higress 容器 ($HIGRESS_CONTAINER) 到网络app-network..."; docker network connect local_app-network "$HIGRESS_CONTAINER" 2>/dev/null || echo "⚠️  网络连接已存在或连接失败"; else echo "⚠️  未找到 Higress 容器，跳过网络连接"; fi
```

注意不要换行执行，该命令会把higress-gateway容器注册到项目使用的网络，以便连接Nacos

## 4. 项目体验

### 1. 服务访问地址：

- Nacos 控制台: http://localhost:8181/ (账号密码: nacos/nacos)
- Higress 控制台: http://localhost:8080 (账号密码: admin/admin)
- MySQL: localhost:3306 (账户密码：root/root)
- Higress 网关: http://localhost

### 2. 常用命令：

- 查看日志: 

  ```sh
  docker-compose logs -f
  ```

- 停止服务: 

  ```sh
  docker-compose down
  ```

- 重启服务: 

  ```sh
  docker-compose restart
  ```

## 5. 联系我

如有问题请及时联系黄愿，这个项目的部署脚本并不能确保一键部署启动，我的自动化部署写得还是比较稚嫩，很多部署细节需要自己手动去做修改

- 邮箱：3205518128@qq.com

- GitHub: https://github.com/HuangYuan1024