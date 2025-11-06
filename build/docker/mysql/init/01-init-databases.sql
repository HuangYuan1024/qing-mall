# build/docker/mysql/init/01-init-databases.sql

-- 创建业务数据库
CREATE DATABASE IF NOT EXISTS `love_movie` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 创建Nacos配置数据库
CREATE DATABASE IF NOT EXISTS `nacos_config` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 创建其他微服务数据库（根据您的需要添加）
# CREATE DATABASE IF NOT EXISTS `movie_service` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
# CREATE DATABASE IF NOT EXISTS `order_service` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
# CREATE DATABASE IF NOT EXISTS `promotion_service` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
# CREATE DATABASE IF NOT EXISTS `search_service` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 创建专用用户（可选，增强安全性）
CREATE USER IF NOT EXISTS 'app_user'@'%' IDENTIFIED BY 'app_password';
GRANT ALL PRIVILEGES ON love_movie.* TO 'app_user'@'%';
# GRANT ALL PRIVILEGES ON movie_service.* TO 'app_user'@'%';
# GRANT ALL PRIVILEGES ON order_service.* TO 'app_user'@'%';
# GRANT ALL PRIVILEGES ON promotion_service.* TO 'app_user'@'%';
# GRANT ALL PRIVILEGES ON search_service.* TO 'app_user'@'%';

CREATE USER IF NOT EXISTS 'nacos_user'@'%' IDENTIFIED BY 'nacos_password';
GRANT ALL PRIVILEGES ON nacos_config.* TO 'nacos_user'@'%';

FLUSH PRIVILEGES;