/*
 Navicat Premium Data Transfer

 Source Server         : mysql8
 Source Server Type    : MySQL
 Source Server Version : 80022
 Source Host           : localhost:3306
 Source Schema         : gec-auth-demo

 Target Server Type    : MySQL
 Target Server Version : 80022
 File Encoding         : 65001

 Date: 19/06/2023 10:15:58
*/

# 使用数据库 love_movie
USE `love_movie`;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sys_category
-- ----------------------------
DROP TABLE IF EXISTS `sys_category`;
CREATE TABLE `sys_category`  (
                                 `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键',
                                 `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '栏目名',
                                 `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
                                 `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
                                 `is_deleted` tinyint(0) NULL DEFAULT 0,
                                 PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_category
-- ----------------------------
INSERT INTO `sys_category` VALUES (1, '电视剧', '2022-11-16 11:16:47', '2023-01-16 11:17:27', 0);
INSERT INTO `sys_category` VALUES (2, '电影', '2022-12-14 11:16:57', '2023-01-16 11:17:30', 0);
INSERT INTO `sys_category` VALUES (3, '综艺', '2023-01-04 11:17:03', '2023-01-16 11:17:33', 0);
INSERT INTO `sys_category` VALUES (4, '动漫', '2022-11-16 11:17:08', '2023-01-16 11:17:35', 0);
INSERT INTO `sys_category` VALUES (5, '网剧', '2022-10-19 11:17:15', '2023-01-16 11:17:40', 0);
INSERT INTO `sys_category` VALUES (6, '纪录片', '2022-10-05 11:17:20', '2023-01-16 11:18:23', 0);
INSERT INTO `sys_category` VALUES (7, '肥皂剧', '2023-01-16 11:14:45', '2023-01-16 11:18:19', 0);

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
                             `id` bigint(0) NOT NULL AUTO_INCREMENT,
                             `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '部门名称',
                             `parent_id` bigint(0) NULL DEFAULT 0 COMMENT '上级部门id',
                             `tree_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT ',' COMMENT '树结构',
                             `sort_value` int(0) NULL DEFAULT 1 COMMENT '排序',
                             `leader` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '负责人',
                             `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '电话',
                             `status` tinyint(1) NULL DEFAULT 1 COMMENT '状态（1正常 0停用）',
                             `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
                             `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
                             `is_deleted` tinyint(0) NOT NULL DEFAULT 0 COMMENT '删除标记（0:可用 1:已删除）',
                             PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2018 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '组织机构' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (1, '测试集团有限公司', 0, ',1,', 1, '张老师', '15659090912', 1, '2022-05-24 16:13:13', '2022-05-24 16:13:13', 0);
INSERT INTO `sys_dept` VALUES (10, '西安校区', 1, ',1,10,', 1, '李老师', '18790007789', 1, '2022-05-24 16:13:15', '2022-05-24 16:13:15', 0);
INSERT INTO `sys_dept` VALUES (20, '武汉校区', 1, ',1,20,', 1, '王老师', '15090987678', 1, '2022-05-25 14:02:25', '2022-05-25 14:02:25', 0);
INSERT INTO `sys_dept` VALUES (30, '长沙校区', 1, ',1,30,', 1, '李老师', '15090987678', 1, '2022-05-25 14:02:24', '2022-05-25 14:02:24', 0);
INSERT INTO `sys_dept` VALUES (1010, '教学部分', 10, ',1,10,1010,', 1, '李老师', '15090987678', 1, '2022-05-25 14:02:24', '2022-05-25 14:02:24', 0);
INSERT INTO `sys_dept` VALUES (1020, '运营部门', 10, ',1,10,1020,', 1, '王老师', '15090987678', 1, '2022-05-25 14:02:29', '2022-05-25 14:02:29', 0);
INSERT INTO `sys_dept` VALUES (1021, 'Java学科', 1010, ',1,10,1010,1021,', 1, '王老师', '15090987678', 1, '2022-05-24 16:13:31', '2022-05-24 16:13:31', 0);
INSERT INTO `sys_dept` VALUES (1022, '大数据学科', 1010, ',1,10,1010,1022,', 1, '王老师', '15090987678', 1, '2022-05-25 14:02:22', '2022-05-25 14:02:22', 0);
INSERT INTO `sys_dept` VALUES (1024, '前端学科', 1010, ',1,10,1010,1024,', 1, '李老师', '15090987678', 1, '2022-05-25 14:02:22', '2022-05-25 14:02:22', 0);
INSERT INTO `sys_dept` VALUES (1025, '客服', 1020, ',1,10,1020,1025,', 1, '李老师', '15090987678', 1, '2022-05-25 14:02:23', '2022-05-25 14:02:23', 0);
INSERT INTO `sys_dept` VALUES (1026, '网站推广', 1020, ',1,10,1020,1026,', 1, '30.607366', '15090987678', 1, '2022-05-25 14:02:26', '2022-05-25 14:02:26', 0);
INSERT INTO `sys_dept` VALUES (1027, '线下运营', 1020, ',1,10,1020,1027,', 1, '李老师', '15090987678', 1, '2022-05-25 14:02:26', '2022-05-25 14:02:26', 0);
INSERT INTO `sys_dept` VALUES (1028, '设计', 1020, ',1,10,1020,1028,', 1, '李老师', '15090987678', 1, '2022-05-25 14:02:27', '2022-05-25 14:02:27', 0);
INSERT INTO `sys_dept` VALUES (2012, '教学部门', 20, ',1,20,2012,', 1, '王老师', '18909890765', 1, '2022-05-24 16:13:51', '2022-05-24 16:13:51', 0);
INSERT INTO `sys_dept` VALUES (2013, '教学部门', 30, ',1,30,2013,', 1, '李老师', '18567867895', 1, '2022-05-24 16:13:50', '2022-05-24 16:13:50', 0);
INSERT INTO `sys_dept` VALUES (2016, 'Java学科', 2012, ',1,20,2012,2012,', 1, '张老师', '15090909909', 1, '2022-05-25 10:51:12', '2022-05-25 10:51:12', 0);
INSERT INTO `sys_dept` VALUES (2017, '大数据学科', 2012, ',1,20,2012,2012,', 1, '李老师', '15090980989', 1, '2022-05-27 09:11:54', NULL, 0);

-- ----------------------------
-- Table structure for sys_login_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_login_log`;
CREATE TABLE `sys_login_log`  (
                                  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '访问ID',
                                  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '用户账号',
                                  `ipaddr` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '登录IP地址',
                                  `status` tinyint(1) NULL DEFAULT 0 COMMENT '登录状态（0成功 1失败）',
                                  `msg` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '提示信息',
                                  `access_time` datetime(0) NULL DEFAULT NULL COMMENT '访问时间',
                                  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
                                  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
                                  `is_deleted` tinyint(0) NOT NULL DEFAULT 0 COMMENT '删除标记（0:可用 1:已删除）',
                                  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 35 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统访问记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_login_log
-- ----------------------------
INSERT INTO `sys_login_log` VALUES (3, 'admin', '127.0.0.1', 0, '登录成功', NULL, '2023-01-16 17:02:52', NULL, 0);
INSERT INTO `sys_login_log` VALUES (4, 'admin', '127.0.0.1', 0, '登录成功', NULL, '2023-01-18 12:57:00', NULL, 0);
INSERT INTO `sys_login_log` VALUES (5, 'admin', '127.0.0.1', 0, '登录成功', NULL, '2023-01-18 20:09:28', NULL, 0);
INSERT INTO `sys_login_log` VALUES (6, 'admin', '127.0.0.1', 0, '登录成功', NULL, '2023-01-18 20:24:12', NULL, 0);
INSERT INTO `sys_login_log` VALUES (7, 'dafei2022', '127.0.0.1', 0, '登录成功', NULL, '2023-01-18 20:34:01', NULL, 0);
INSERT INTO `sys_login_log` VALUES (8, 'dafei2022', '127.0.0.1', 0, '登录成功', NULL, '2023-01-18 20:34:54', NULL, 0);
INSERT INTO `sys_login_log` VALUES (9, 'admin', '127.0.0.1', 0, '登录成功', NULL, '2023-01-18 21:34:53', NULL, 0);
INSERT INTO `sys_login_log` VALUES (10, 'dafei2022', '127.0.0.1', 0, '登录成功', NULL, '2023-01-18 21:41:13', NULL, 0);
INSERT INTO `sys_login_log` VALUES (11, 'admin', '127.0.0.1', 0, '登录成功', NULL, '2023-01-18 21:41:47', NULL, 0);
INSERT INTO `sys_login_log` VALUES (12, 'dafei2022', '127.0.0.1', 0, '登录成功', NULL, '2023-01-18 21:42:25', NULL, 0);
INSERT INTO `sys_login_log` VALUES (13, 'admin', '127.0.0.1', 0, '登录成功', NULL, '2023-01-18 21:48:31', NULL, 0);
INSERT INTO `sys_login_log` VALUES (14, 'dafei2022', '127.0.0.1', 0, '登录成功', NULL, '2023-01-18 21:48:56', NULL, 0);
INSERT INTO `sys_login_log` VALUES (15, 'admin', '127.0.0.1', 0, '登录成功', NULL, '2023-01-18 21:49:42', NULL, 0);
INSERT INTO `sys_login_log` VALUES (16, 'ceshi123', '127.0.0.1', 0, '登录成功', NULL, '2023-01-18 21:50:58', NULL, 0);
INSERT INTO `sys_login_log` VALUES (17, 'ceshi123', '127.0.0.1', 0, '登录成功', NULL, '2023-01-18 21:51:00', NULL, 0);
INSERT INTO `sys_login_log` VALUES (18, 'ceshi123', '127.0.0.1', 0, '登录成功', NULL, '2023-01-18 21:51:01', NULL, 0);
INSERT INTO `sys_login_log` VALUES (19, 'ceshi123', '127.0.0.1', 0, '登录成功', NULL, '2023-01-18 21:51:02', NULL, 0);
INSERT INTO `sys_login_log` VALUES (20, 'ceshi123', '127.0.0.1', 0, '登录成功', NULL, '2023-01-18 21:51:03', NULL, 0);
INSERT INTO `sys_login_log` VALUES (21, 'ceshi123', '127.0.0.1', 0, '登录成功', NULL, '2023-01-18 21:51:03', NULL, 0);
INSERT INTO `sys_login_log` VALUES (22, 'ceshi123', '127.0.0.1', 0, '登录成功', NULL, '2023-01-18 21:51:04', NULL, 0);
INSERT INTO `sys_login_log` VALUES (23, 'ceshi123', '127.0.0.1', 0, '登录成功', NULL, '2023-01-18 21:51:24', NULL, 0);
INSERT INTO `sys_login_log` VALUES (24, 'admin', '127.0.0.1', 0, '登录成功', NULL, '2023-01-18 21:53:50', NULL, 0);
INSERT INTO `sys_login_log` VALUES (25, 'ceshi123', '127.0.0.1', 0, '登录成功', NULL, '2023-01-18 21:55:06', NULL, 0);
INSERT INTO `sys_login_log` VALUES (26, 'ceshi123', '127.0.0.1', 0, '登录成功', NULL, '2023-01-18 21:55:07', NULL, 0);
INSERT INTO `sys_login_log` VALUES (27, 'admin', '127.0.0.1', 0, '登录成功', NULL, '2023-01-18 21:55:27', NULL, 0);
INSERT INTO `sys_login_log` VALUES (28, 'ceshi123', '127.0.0.1', 0, '登录成功', NULL, '2023-01-18 21:55:57', NULL, 0);
INSERT INTO `sys_login_log` VALUES (29, 'admin', '127.0.0.1', 0, '登录成功', NULL, '2023-01-19 09:19:32', NULL, 0);
INSERT INTO `sys_login_log` VALUES (30, 'admin', '127.0.0.1', 0, '登录成功', NULL, '2023-01-19 18:54:20', NULL, 0);
INSERT INTO `sys_login_log` VALUES (31, 'admin', '127.0.0.1', 0, '登录成功', NULL, '2023-02-02 17:11:48', NULL, 0);
INSERT INTO `sys_login_log` VALUES (32, 'admin', '127.0.0.1', 0, '登录成功', NULL, '2023-02-02 17:15:31', NULL, 0);
INSERT INTO `sys_login_log` VALUES (33, 'admin', '127.0.0.1', 0, '登录成功', NULL, '2023-02-02 17:18:43', NULL, 0);
INSERT INTO `sys_login_log` VALUES (34, 'admin', '127.0.0.1', 0, '登录成功', NULL, '2023-02-02 17:39:18', NULL, 0);

-- ----------------------------
-- Table structure for sys_member
-- ----------------------------
DROP TABLE IF EXISTS `sys_member`;
CREATE TABLE `sys_member`  (
                               `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '主键',
                               `username` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名',
                               `password` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
                               `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号',
                               PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_member
-- ----------------------------
INSERT INTO `sys_member` VALUES (1, 'tom', '123456', '13800000000');
INSERT INTO `sys_member` VALUES (2, 'jerry', '123456', '13800000001');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
                             `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '编号',
                             `parent_id` bigint(0) NOT NULL DEFAULT 0 COMMENT '所属上级',
                             `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '名称',
                             `type` tinyint(0) NOT NULL DEFAULT 0 COMMENT '类型(0:目录,1:菜单,2:按钮)',
                             `path` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '路由地址',
                             `component` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '组件路径',
                             `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '权限标识',
                             `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '图标',
                             `sort_value` int(0) NULL DEFAULT NULL COMMENT '排序',
                             `status` tinyint(0) NULL DEFAULT NULL COMMENT '状态(0:禁止,1:正常)',
                             `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
                             `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
                             `is_deleted` tinyint(0) NOT NULL DEFAULT 0 COMMENT '删除标记（0:可用 1:已删除）',
                             PRIMARY KEY (`id`) USING BTREE,
                             INDEX `idx_parent_id`(`parent_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 39 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '菜单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (2, 0, '系统管理', 0, 'system', 'Layout', NULL, 'el-icon-s-tools', 1, 1, '2021-05-31 18:05:37', '2022-06-09 09:23:24', 0);
INSERT INTO `sys_menu` VALUES (3, 2, '用户管理', 1, 'sysUser', 'system/sysUser/list', '', 'el-icon-s-custom', 1, 1, '2021-05-31 18:05:37', '2022-06-09 09:22:47', 0);
INSERT INTO `sys_menu` VALUES (4, 2, '角色管理', 1, 'sysRole', 'system/sysRole/list', '', 'el-icon-ums-solid', 2, 1, '2021-05-31 18:05:37', '2022-06-09 09:37:18', 0);
INSERT INTO `sys_menu` VALUES (5, 2, '菜单管理', 1, 'sysMenu', 'system/sysMenu/list', '', 'el-icon-s-unfold', 3, 1, '2021-05-31 18:05:37', '2022-06-09 09:37:21', 0);
INSERT INTO `sys_menu` VALUES (6, 3, '查看', 2, NULL, NULL, 'bnt.sysUser.list', NULL, 1, 1, '2021-05-31 18:05:37', '2022-06-09 09:22:38', 0);
INSERT INTO `sys_menu` VALUES (7, 3, '添加', 2, NULL, NULL, 'bnt.sysUser.add', NULL, 1, 1, '2021-05-31 18:05:37', '2022-06-09 09:22:38', 0);
INSERT INTO `sys_menu` VALUES (8, 3, '修改', 2, NULL, NULL, 'bnt.sysUser.update', NULL, 1, 1, '2021-05-31 18:05:37', '2022-06-09 09:22:38', 0);
INSERT INTO `sys_menu` VALUES (9, 3, '删除', 2, NULL, NULL, 'bnt.sysUser.remove', NULL, 1, 1, '2021-05-31 18:05:37', '2022-06-09 09:22:38', 0);
INSERT INTO `sys_menu` VALUES (10, 4, '查看', 2, NULL, NULL, 'bnt.sysRole.list', NULL, 1, 1, '2021-05-31 18:05:37', '2022-06-09 09:22:38', 0);
INSERT INTO `sys_menu` VALUES (11, 4, '添加', 2, NULL, NULL, 'bnt.sysRole.add', NULL, 1, 1, '2021-05-31 18:05:37', '2022-06-09 09:22:38', 0);
INSERT INTO `sys_menu` VALUES (12, 4, '修改', 2, NULL, NULL, 'bnt.sysRole.update', NULL, 1, 1, '2021-05-31 18:05:37', '2022-06-09 09:22:38', 0);
INSERT INTO `sys_menu` VALUES (13, 4, '删除', 2, NULL, NULL, 'bnt.sysRole.remove', NULL, 1, 1, '2021-05-31 18:05:37', '2022-06-09 09:22:38', 0);
INSERT INTO `sys_menu` VALUES (14, 5, '查看', 2, NULL, NULL, 'bnt.sysMenu.list', NULL, 1, 1, '2021-05-31 18:05:37', '2022-06-09 09:22:38', 0);
INSERT INTO `sys_menu` VALUES (15, 5, '添加', 2, NULL, NULL, 'bnt.sysMenu.add', NULL, 1, 1, '2021-05-31 18:05:37', '2022-06-09 09:22:38', 0);
INSERT INTO `sys_menu` VALUES (16, 5, '修改', 2, NULL, NULL, 'bnt.sysMenu.update', NULL, 1, 1, '2021-05-31 18:05:37', '2022-06-09 09:22:38', 0);
INSERT INTO `sys_menu` VALUES (17, 5, '删除', 2, NULL, NULL, 'bnt.sysMenu.remove', NULL, 1, 1, '2021-05-31 18:05:37', '2022-06-09 09:22:38', 0);
INSERT INTO `sys_menu` VALUES (18, 3, '分配角色', 2, NULL, NULL, 'bnt.sysUser.assignRole', NULL, 1, 1, '2022-05-23 17:14:32', '2022-06-09 09:22:38', 0);
INSERT INTO `sys_menu` VALUES (19, 4, '分配权限', 2, 'assignAuth', 'system/sysRole/assignAuth', 'bnt.sysRole.assignAuth', NULL, 1, 1, '2022-05-23 17:18:14', '2022-06-09 09:22:38', 0);
INSERT INTO `sys_menu` VALUES (20, 2, '部门管理', 1, 'sysDept', 'system/sysDept/list', '', 'el-icon-s-operation', 4, 1, '2022-05-24 10:07:05', '2022-06-09 09:38:12', 1);
INSERT INTO `sys_menu` VALUES (21, 20, '查看', 2, NULL, NULL, 'bnt.sysDept.list', NULL, 1, 1, '2022-05-24 10:07:44', '2022-06-09 09:22:38', 1);
INSERT INTO `sys_menu` VALUES (22, 2, '岗位管理', 1, 'sysPost', 'system/sysPost/list', '', 'el-icon-more-outline', 5, 1, '2022-05-24 10:25:30', '2022-06-09 09:38:13', 1);
INSERT INTO `sys_menu` VALUES (23, 22, '查看', 2, NULL, NULL, 'bnt.sysPost.list', NULL, 1, 1, '2022-05-24 10:25:45', '2022-06-09 09:22:38', 1);
INSERT INTO `sys_menu` VALUES (24, 20, '添加', 2, NULL, NULL, 'bnt.sysDept.add', NULL, 1, 1, '2022-05-25 15:31:27', '2022-06-09 09:22:38', 1);
INSERT INTO `sys_menu` VALUES (25, 20, '修改', 2, NULL, NULL, 'bnt.sysDept.update', NULL, 1, 1, '2022-05-25 15:31:41', '2022-06-09 09:22:38', 1);
INSERT INTO `sys_menu` VALUES (26, 20, '删除', 2, NULL, NULL, 'bnt.sysDept.remove', NULL, 1, 1, '2022-05-25 15:31:59', '2022-06-09 09:22:38', 1);
INSERT INTO `sys_menu` VALUES (27, 22, '添加', 2, NULL, NULL, 'bnt.sysPost.add', NULL, 1, 1, '2022-05-25 15:32:44', '2022-06-09 09:22:38', 1);
INSERT INTO `sys_menu` VALUES (28, 22, '修改', 2, NULL, NULL, 'bnt.sysPost.update', NULL, 1, 1, '2022-05-25 15:32:58', '2022-06-09 09:22:38', 1);
INSERT INTO `sys_menu` VALUES (29, 22, '删除', 2, NULL, NULL, 'bnt.sysPost.remove', NULL, 1, 1, '2022-05-25 15:33:11', '2022-06-09 09:22:38', 1);
INSERT INTO `sys_menu` VALUES (30, 34, '操作日志', 1, 'sysOperLog', 'system/sysOperLog/list', '', 'el-icon-document-remove', 7, 1, '2022-05-26 16:09:59', '2022-06-09 09:39:23', 0);
INSERT INTO `sys_menu` VALUES (31, 30, '查看', 2, NULL, NULL, 'bnt.sysOperLog.list', NULL, 1, 1, '2022-05-26 16:10:17', '2022-06-09 09:22:38', 0);
INSERT INTO `sys_menu` VALUES (32, 34, '登录日志', 1, 'sysLoginLog', 'system/sysLoginLog/list', '', 'el-icon-s-goods', 8, 1, '2022-05-26 16:36:13', '2022-06-09 09:39:24', 0);
INSERT INTO `sys_menu` VALUES (33, 32, '查看', 2, NULL, NULL, 'bnt.sysLoginLog.list', NULL, 1, 1, '2022-05-26 16:36:31', '2022-06-09 09:36:36', 0);
INSERT INTO `sys_menu` VALUES (34, 2, '日志管理', 0, 'log', 'ParentView', '', 'el-icon-tickets', 6, 1, '2022-05-31 13:23:07', '2022-06-09 09:39:22', 0);
INSERT INTO `sys_menu` VALUES (35, 34, 'test2', 1, '', '', '', 'el-icon-s-tools', 1, 1, '2023-01-06 16:54:50', '2023-01-06 16:56:07', 1);
INSERT INTO `sys_menu` VALUES (36, 2, '影视管理', 1, 'sysMovie', 'system/sysMovie/list', 'bnt.sysMovie.list', 'el-icon-tickets', 6, 1, '2023-01-14 17:30:43', '2023-01-15 20:41:53', 0);
INSERT INTO `sys_menu` VALUES (37, 36, '视频播放', 2, 'assignVideo', 'system/sysMovie/assignVideo', 'bnt.sysMovie.assignVideo', '', 1, 1, '2023-01-15 20:44:53', NULL, 0);
INSERT INTO `sys_menu` VALUES (38, 2, '分类管理', 1, 'sysCategory', 'system/sysCategory/list', '', 'el-icon-s-tools', 1, 1, '2023-01-16 10:30:31', '2023-01-16 10:31:27', 0);
INSERT INTO `sys_menu` VALUES (39, 0, '员工管理', 0, 'admin/system/employee', 'Layout', '', 'el-icon-s-custom', 1, 1, '2023-06-18 22:53:35', '2023-06-18 22:53:56', 0);
INSERT INTO `sys_menu` VALUES (40, 39, '添加员工', 1, 'admin/system/employee/addemp', 'view/system/emps/list', '', 'el-icon-s-check', 1, 1, '2023-06-18 22:55:09', NULL, 0);

-- ----------------------------
-- Table structure for sys_movie
-- ----------------------------
DROP TABLE IF EXISTS `sys_movie`;
CREATE TABLE `sys_movie`  (
                              `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键',
                              `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电影名称',
                              `cid` int(0) NULL DEFAULT NULL COMMENT '分类id',
                              `description` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '内容描述',
                              `keyword` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关键字，用来搜索',
                              `director` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '导演姓名',
                              `actor` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '主演',
                              `image` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '缩略图',
                              `type` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '2' COMMENT '视频类型:1.免费视频  2.付费视频',
                              `url` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '播放连接',
                              `play_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '播放id,阿里云提供',
                              `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
                              `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
                              `is_deleted` tinyint(0) NULL DEFAULT 0 COMMENT '删除标记（0:可用 1:已删除）',
                              PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_movie
-- ----------------------------
INSERT INTO `sys_movie` VALUES (1, '荞麦疯长', 2, '20世纪90年代的小城市里，云荞(马思纯饰)想要“活成一部电影”；李麦(钟楚曦饰)期待着看得见希望的未来；吴风(黄景瑜饰)要在平凡的日子里背水一战。每个人都有着对未来的憧憬，并带着憧憬与不可知开始了异乡漂泊之路。“云彼有荞麦，无风亦可长”，底层年轻人背井离乡，逆风成长', '背水一战 憧憬 漂泊', '徐展雄', '马思纯、钟楚曦、黄景瑜', '/images/qiaomaifengzhang.jpg', '2', '', '', NULL, NULL, 0);
INSERT INTO `sys_movie` VALUES (2, '花木兰', 2, '中国的皇帝颁布法令，要求每家出一名男子服兵役，抵御北方侵略者。作为一名受人尊敬的战士的长女，花木兰（刘亦菲饰）站出来替生病的父亲应征入伍。她女扮男装，化名为花军，经历了种种考验，同时必须利用内在的力量，接纳自己真正的潜能。这是一场史诗般的旅程，让木兰蜕变为一名受人尊敬的战士，也赢得来自国家与骄傲的父亲的尊重', '服兵役 尊重  神秘', '妮基·卡罗', '刘亦菲、甄子丹、巩俐、李连杰、安柚鑫、李截、郑佩佩、赵家玲、马志、唐莎娜', '/images/huamulan.jpg', '2', '', '', NULL, NULL, 0);
INSERT INTO `sys_movie` VALUES (3, '一出好戏', 2, '《一出好戏》是由上海瀚纳影视文化传媒有限公司制作的喜剧片，由黄渤执导，黄渤、王宝强、舒淇、张艺兴、于和伟、王迅联袂主演。该片于2018年8月10日在中国内地上映，2020年4月2日在韩国上映。该片讲述了公司员工团建出游遭遇海难，众人流落在荒岛之上，为了生存他们共同生活，并面对一系列人性问题的寓言故事', '喜剧 荒岛', '黄渤', '黄渤、张冀、郭俊立、查慕春、崔斯韦、邢爱娜、黄湛中', '/images/yichuhaoxi.jpg', '2', '', '', NULL, NULL, 0);
INSERT INTO `sys_movie` VALUES (4, '极线杀手', 2, '别名「黑色凯萨」的世界顶尖杀手邓肯·维兹拉（麦斯·米科尔森饰）在享受退休生活之际，前雇主突然指控他不利于公司。他在身不由己的情况下重回本行，与一群杀手正面对决。这群心狠手辣的杀手不仅在年纪与体力占尽优势，更不计一切要取他性命。', '复仇特工 机密', '乔纳斯·阿克伦德', '麦斯·米科尔森、凡妮莎·哈金斯、凯瑟琳·温妮克、罗伯特·梅耶、马特·卢卡斯', '/images/jisushashou.jpg', '2', '', '', NULL, NULL, 0);
INSERT INTO `sys_movie` VALUES (5, '东北往事：我叫刘海柱', 2, '《东北往事：我叫刘海柱》讲述的是上世纪80年代初的东北，爱慕同事周萌的工人刘海柱因帮扶弱者，爱打抱不平，招惹上了不良分子并给自己的家人朋友带来危险。在经历被坏人打伤，被工厂开除等人生打击低谷后，刘海柱更面临危及生命的挑战。但此时，这个神奇的男人竟然还能重新站起来，面对一个个惊天的挑战，令世人震惊的完成着属于他的精彩传奇', '男人 挑战', '周润泽', '许君聪、杨蕊嘉、刘奔、龚小钧、田璐', '/images/dongbeiwangshi.jpg', '2', '', '', NULL, NULL, 0);
INSERT INTO `sys_movie` VALUES (6, '最美逆行', 2, '电影《最美逆行》是一部反映广东援鄂医务人员广州武汉高铁乘警们在本次疫情中坚难困苦，努力奋斗，可歌可泣的英雄故事', '新冠病毒 疫情 ', '范雨林  、邢博、胡树华', '程琤、启杰领衔主演，王奎荣，迟志强，沙溢、黄一山、陈龙，刘烨，柳海龙、梁梓滔、肖午、田甜等', '/images/zuimeinixing.jpg', '2', '', '', NULL, NULL, 0);
INSERT INTO `sys_movie` VALUES (7, '复仇者联盟4：终局之战', 2, '来自泰坦星的灭霸为了解决宇宙资源匮乏、人口暴增的问题，集齐了所有无限宝石，一个响指成功地使全宇宙生命随机减半。\r\n宇宙由于灭霸的行动而变得满目疮痍，但是五年之后，被困在量子领域的蚁人意外回到现实世界，他的出现为幸存的复仇者点燃了希望。无论前方将遭遇怎样的后果，幸存的复仇者都必须在剩余盟友的帮助下再一次集结，以逆转灭霸的所作所为，彻底恢复宇宙的秩序', '复联4 漫威 机器人 地球 宇宙', '安东尼·罗素、乔·罗素', '小罗伯特·唐尼，克里斯·埃文斯，马克·鲁法洛，克里斯·海姆斯沃斯，斯嘉丽·约翰逊，杰瑞米·雷纳', '/images/fulian4.jpg', '2', '', '', NULL, NULL, 0);
INSERT INTO `sys_movie` VALUES (8, '蜘蛛侠：英雄归来', 2, '彼得帕克（汤姆·赫兰德 Tom Holland 饰）在内战后受到了钢铁侠托尼斯塔克（小罗伯特·唐尼 Robert Downey Jr. 饰）的赏识，表面上，彼得进入托尼的公司成为了一名实习生，实际上，他和复仇者联盟的成员们一起接受了各种各样的训练。托尼虽然欣赏彼得的勇敢和正直，却并不认为他目前已经拥有加入复联的实力，他派出了特工哈皮（乔恩·费儒 Jon Favreau 饰）暗中观察，这让十分想证明自己的彼得感到万分焦躁。\r\n　　在对付两个银行劫匪的过程中，彼得发现劫匪们使用的是一种前所未见的新型武器，他孤身一人深入敌后顺藤摸瓜找到了幕后主使秃鹰（迈克尔·基顿 Michael Keaton 饰），让他彼得没有想到的是，秃鹰竟然是他爱慕的女生利兹（劳拉·海瑞尔 Laura Harrier 饰）的父亲', '蜘蛛侠  回归 返校日', '乔·沃茨', ' 汤姆·赫兰德 / 小罗伯特·唐尼 / 玛丽莎·托梅 / 迈克尔·基顿 / 雅各布·巴特朗', '/images/zhizhuxia.jpg', '2', '', '', NULL, NULL, 0);
INSERT INTO `sys_movie` VALUES (9, '哥斯拉2：怪兽之王', 2, '动物基因组学（帝王计划）研究机构的一个小组在一座庙里研究着魔斯拉。她从幼体中孵出，在一群雇佣兵袭击这个机构时，魔斯拉逃了出去。然后她在一个瀑布包了茧，随后破茧而出，完成了全形态生长。在2014年，哥斯拉被整个世界看到后，“帝王组织”在水下建了一个基地，在这个位于水下好几英里的水中基地中，他们研究着哥斯拉和其它可能存在的生物。那是他们真正的研究核心', '基因 哥斯拉 怪兽', '迈克尔·道赫蒂', '凯尔·钱德勒，维拉·法梅加，米莉·博比·布朗，渡边谦，章子怡，布莱德利·惠特福德，莎莉·霍金斯', '/images/gesila2.jpg', '2', '', '', NULL, NULL, 0);
INSERT INTO `sys_movie` VALUES (14, '123', 2, '123', '123', '123', '123', 'https://movie-demotest.oss-cn-guangzhou.aliyuncs.com/images/2022/12/04/1670134005878.jpg', '2', NULL, 'bd9953467f794b0187ab646f44e9fc1f', NULL, '2023-01-16 11:40:47', 1);
INSERT INTO `sys_movie` VALUES (15, 'aaa', 1, 'aa', 'aa', 'aa', 'aa', 'https://movie-demotest.oss-cn-guangzhou.aliyuncs.com/images/2022/12/29/1672297101457.jpg', '2', NULL, '34ea1550874671ed9fad6723b78e0102', NULL, '2023-01-16 11:40:42', 1);
INSERT INTO `sys_movie` VALUES (16, '您好，北京', 2, '《您好，北京》是由曹茜茜执导，安泽豪、刘犇、李斐然领衔主演，徐峥特别出演的温情现实主义题材电影。 [1]  于2022年11月18日在全国上映 [16]  。 该片讲述了一个创业的中年人、一位快递员和一位年轻的歌手在北京生活奋斗的经历。', 'aa', '曹茜茜', '安泽豪、刘犇、李斐然', 'https://movie-demotest.oss-cn-guangzhou.aliyuncs.com/images/2023/01/16/1673840418551.jpg', '2', NULL, NULL, '2023-01-15 16:08:16', '2023-01-16 11:42:13', 0);
INSERT INTO `sys_movie` VALUES (17, '汪汪队立大功之超能救援', 2, '《汪汪队立大功之超能救援》是全球知名儿童冒险IP《汪汪队立大功》剧场版电影，由加拿大斯平玛斯特有限公司和美国维亚康姆国际集团联合出品；中国电影集团公司进口，中国电影股份有限公司发行，中国电影股份有限公司译制。于2020年11月13日在中国电影院上映。 [1] ', '测试视频', '查尔斯·E·巴斯蒂安', '麦克斯·卡林内斯库德文·科恩德鲁·戴维斯欧文·梅森', 'https://movie-demotest.oss-cn-guangzhou.aliyuncs.com/images/2023/01/16/1673840329578.jpg', '2', NULL, NULL, '2023-01-15 19:30:30', '2023-01-16 11:41:56', 0);
INSERT INTO `sys_movie` VALUES (18, '鬼吹灯之南海归墟', 2, '摸金校尉胡八一等人，在金盆洗手后协助友人明叔前往南海打捞珍珠，不料遭遇海难、坠入海底，却意外发现了一个沉没在海底的千年古国遗迹，他们在海底历经了重重艰险，最终团结合作战胜深海巨兽，并巧妙利用遗迹内的机关装置逃生', '鬼吹灯之南海归墟', '项河生 、项秋良', '王紫逸、夏若妍、韩烨洲、骆达华', 'https://movie-demotest.oss-cn-guangzhou.aliyuncs.com/images/2023/01/16/1673840174541.jpg', '2', NULL, NULL, '2023-01-15 19:38:09', '2023-01-16 11:41:37', 0);
INSERT INTO `sys_movie` VALUES (19, '狙击手：逆战', 2, '《狙击手：逆战》是由严嘉执导，于荣光、邢恩领衔主演的电影，于2023年1月13日在优酷上线。', '狙击手：逆战', '严嘉', '于荣光、邢恩', 'https://movie-demotest.oss-cn-guangzhou.aliyuncs.com/images/2023/01/16/1673839921366.jpg', '2', NULL, '5db35c90973571edb3906723b78e0102', '2023-01-15 19:41:53', '2023-01-18 21:38:33', 0);
INSERT INTO `sys_movie` VALUES (20, '我不是药神', 1, '《我不是药神》是由文牧野执导，宁浩、徐峥共同监制，徐峥、周一围、王传君、谭卓、章宇、杨新鸣等主演的剧情片 。', '犯罪、剧情、搞笑', '尚进文、牧野', '徐峥、王传君、周一围、谭卓、章宇', 'https://movie-demotest.oss-cn-guangzhou.aliyuncs.com/images/2023/01/16/1673839623317.jpg', '2', NULL, '49bff090973571ed800c6732b68e0102', '2023-01-15 19:44:13', '2023-01-18 21:37:56', 0);

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
                                 `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '日志主键',
                                 `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '模块标题',
                                 `business_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '业务类型（0其它 1新增 2修改 3删除）',
                                 `method` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '方法名称',
                                 `request_method` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '请求方式',
                                 `operator_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
                                 `oper_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '操作人员',
                                 `dept_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '部门名称',
                                 `oper_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '请求URL',
                                 `oper_ip` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '主机地址',
                                 `oper_param` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '请求参数',
                                 `json_result` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '返回参数',
                                 `status` int(0) NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
                                 `error_msg` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '错误消息',
                                 `oper_time` datetime(0) NULL DEFAULT NULL COMMENT '操作时间',
                                 `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
                                 `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
                                 `is_deleted` tinyint(0) NOT NULL DEFAULT 0 COMMENT '删除标记（0:可用 1:已删除）',
                                 PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 64 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '操作日志记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (1, '角色管理', '1', 'com.gec.auth.controller.SysRoleController.save()', 'POST', '1', 'admin', '', '/admin/auth/sysRole/save', '', '{\"param\":{},\"roleCode\":\"\",\"roleName\":\"test\",\"id\":5}', '{\"code\":200,\"message\":\"成功\"}', 0, '', NULL, '2022-05-26 15:59:44', NULL, 0);
INSERT INTO `sys_oper_log` VALUES (2, '角色管理', 'DELETE', 'com.gec.auth.controller.SysRoleController.remove()', 'DELETE', 'MANAGE', 'admin', '', '/admin/auth/sysRole/remove/5', '', '', '{\"code\":200,\"message\":\"成功\"}', 0, '', NULL, '2022-05-26 16:05:27', NULL, 0);
INSERT INTO `sys_oper_log` VALUES (3, '角色管理', 'DELETE', 'com.gec.auth.controller.SysRoleController.remove()', 'DELETE', 'MANAGE', 'admin', '', '/admin/auth/sysRole/remove/4', '127.0.0.1', '', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-26 16:52:40', NULL, 0);
INSERT INTO `sys_oper_log` VALUES (4, '角色管理', 'UPDATE', 'com.gec.auth.controller.SysRoleController.updateById()', 'PUT', 'MANAGE', 'admin', '', '/admin/auth/sysRole/update', '127.0.0.1', '{\"isDeleted\":0,\"createTime\":1622507920000,\"param\":{},\"roleCode\":\"\",\"roleName\":\"普通管理员\",\"description\":\"普通管理员\",\"updateTime\":1645670566000,\"id\":2}', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-27 08:47:54', NULL, 0);
INSERT INTO `sys_oper_log` VALUES (5, '菜单管理', 'UPDATE', 'com.gec.auth.controller.SysMenuController.updateById()', 'PUT', 'MANAGE', 'admin', '', '/admin/auth/sysMenu/update', '127.0.0.1', '{\"code\":\"SysRole\",\"select\":false,\"level\":3,\"updateTime\":1653287810000,\"type\":1,\"parentId\":2,\"isDeleted\":0,\"children\":[{\"code\":\"btn.SysRole.list\",\"select\":false,\"level\":4,\"updateTime\":1622460772000,\"type\":2,\"parentId\":4,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"查看\",\"id\":10},{\"code\":\"btn.SysRole.add\",\"select\":false,\"level\":4,\"updateTime\":1653547976000,\"type\":2,\"parentId\":4,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"添加\",\"id\":11},{\"code\":\"btn.SysRole.update\",\"select\":false,\"level\":4,\"updateTime\":1653547981000,\"type\":2,\"parentId\":4,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"修改\",\"id\":12},{\"code\":\"btn.SysRole.remove\",\"select\":false,\"level\":4,\"updateTime\":1622507874000,\"type\":2,\"parentId\":4,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"删除\",\"id\":13},{\"code\":\"btn.SysRole.assignAuth\",\"select\":false,\"level\":4,\"toCode\":\"AssignAuth\",\"updateTime\":1653376735000,\"type\":2,\"parentId\":4,\"isDeleted\":0,\"children\":[],\"createTime\":1653297494000,\"param\":{},\"name\":\"分配权限\",\"id\":19}],\"createTime\":1622455537000,\"param\":{},\"name\":\"角色管理\",\"id\":4}', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-27 08:48:08', NULL, 0);
INSERT INTO `sys_oper_log` VALUES (6, '岗位管理', 'UPDATE', 'com.gec.auth.controller.SysPostController.updateById()', 'PUT', 'MANAGE', 'admin', '', '/admin/auth/sysPost/update', '127.0.0.1', '{\"isDeleted\":0,\"createTime\":1653359648000,\"param\":{},\"name\":\"总经理\",\"description\":\"2\",\"postCode\":\"zjl\",\"id\":6,\"status\":1}', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-27 08:56:29', NULL, 0);
INSERT INTO `sys_oper_log` VALUES (7, '岗位管理', 'INSERT', 'com.gec.auth.controller.SysPostController.save()', 'POST', 'MANAGE', 'admin', '', '/admin/auth/sysPost/save', '127.0.0.1', '{\"param\":{},\"name\":\"网咨\",\"description\":\"\",\"postCode\":\"wz\",\"id\":7,\"status\":1}', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-27 08:56:37', NULL, 0);
INSERT INTO `sys_oper_log` VALUES (8, '岗位管理', 'DELETE', 'com.gec.auth.controller.SysPostController.remove()', 'DELETE', 'MANAGE', 'admin', '', '/admin/auth/sysPost/remove/7', '127.0.0.1', '', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-27 08:56:41', NULL, 0);
INSERT INTO `sys_oper_log` VALUES (9, '菜单管理', 'UPDATE', 'com.gec.auth.controller.SysMenuController.updateById()', 'PUT', 'MANAGE', 'admin', '', '/admin/auth/sysMenu/update', '127.0.0.1', '{\"code\":\"btn.sysDept.list\",\"select\":false,\"level\":4,\"toCode\":\"\",\"updateTime\":1653358064000,\"type\":2,\"parentId\":20,\"isDeleted\":0,\"children\":[],\"createTime\":1653358064000,\"param\":{},\"name\":\"查看\",\"id\":21}', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-27 09:02:49', NULL, 0);
INSERT INTO `sys_oper_log` VALUES (10, '菜单管理', 'UPDATE', 'com.gec.auth.controller.SysMenuController.updateById()', 'PUT', 'MANAGE', 'admin', '', '/admin/auth/sysMenu/update', '127.0.0.1', '{\"code\":\"btn.sysDept.add\",\"select\":false,\"level\":4,\"toCode\":\"\",\"updateTime\":1653463887000,\"type\":2,\"parentId\":20,\"isDeleted\":0,\"children\":[],\"createTime\":1653463887000,\"param\":{},\"name\":\"添加\",\"id\":24}', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-27 09:02:55', NULL, 0);
INSERT INTO `sys_oper_log` VALUES (11, '菜单管理', 'UPDATE', 'com.gec.auth.controller.SysMenuController.updateById()', 'PUT', 'MANAGE', 'admin', '', '/admin/auth/sysMenu/update', '127.0.0.1', '{\"code\":\"btn.sysDept.update\",\"select\":false,\"level\":4,\"toCode\":\"\",\"updateTime\":1653463901000,\"type\":2,\"parentId\":20,\"isDeleted\":0,\"children\":[],\"createTime\":1653463901000,\"param\":{},\"name\":\"修改\",\"id\":25}', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-27 09:03:01', NULL, 0);
INSERT INTO `sys_oper_log` VALUES (12, '菜单管理', 'UPDATE', 'com.gec.auth.controller.SysMenuController.updateById()', 'PUT', 'MANAGE', 'admin', '', '/admin/auth/sysMenu/update', '127.0.0.1', '{\"code\":\"btn.sysDept.remove\",\"select\":false,\"level\":4,\"toCode\":\"\",\"updateTime\":1653463919000,\"type\":2,\"parentId\":20,\"isDeleted\":0,\"children\":[],\"createTime\":1653463919000,\"param\":{},\"name\":\"删除\",\"id\":26}', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-27 09:03:07', NULL, 0);
INSERT INTO `sys_oper_log` VALUES (13, '部门管理', 'UPDATE', 'com.gec.auth.controller.SysDeptController.updateById()', 'PUT', 'MANAGE', 'admin', '', '/admin/auth/sysDept/update', '127.0.0.1', '{\"leader\":\"张老师\",\"updateTime\":1653447072000,\"parentId\":2012,\"sortValue\":1,\"isDeleted\":0,\"createTime\":1653447072000,\"param\":{},\"phone\":\"15090909909\",\"name\":\"Java学科\",\"id\":2016,\"treePath\":\",1,20,2012,2012,\",\"status\":1}', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-27 09:11:28', NULL, 0);
INSERT INTO `sys_oper_log` VALUES (14, '部门管理', 'INSERT', 'com.gec.auth.controller.SysDeptController.save()', 'POST', 'MANAGE', 'admin', '', '/admin/auth/sysDept/save', '127.0.0.1', '{\"leader\":\"李老师\",\"parentId\":2012,\"param\":{},\"phone\":\"15090980989\",\"name\":\"大数据学科\",\"id\":2017,\"treePath\":\",1,20,2012,2012,\"}', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-27 09:11:54', NULL, 0);
INSERT INTO `sys_oper_log` VALUES (15, '部门管理', 'UPDATE', 'com.gec.auth.controller.SysDeptController.updateById()', 'PUT', 'MANAGE', 'admin', '', '/admin/auth/sysDept/update', '127.0.0.1', '{\"leader\":\"李老师\",\"parentId\":2012,\"sortValue\":1,\"isDeleted\":0,\"createTime\":1653613914000,\"param\":{},\"phone\":\"15090980989\",\"name\":\"大数据学科\",\"id\":2017,\"treePath\":\",1,20,2012,2012,\",\"status\":1}', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-27 09:16:38', NULL, 0);
INSERT INTO `sys_oper_log` VALUES (16, '角色管理', 'UPDATE', 'com.gec.auth.controller.SysRoleController.updateById()', 'PUT', 'MANAGE', 'admin', '', '/admin/auth/sysRole/update', '127.0.0.1', '{\"isDeleted\":0,\"createTime\":1622507920000,\"param\":{},\"roleCode\":\"COMMON\",\"roleName\":\"普通管理员\",\"description\":\"普通管理员\",\"updateTime\":1645670566000,\"id\":2}', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-27 09:28:15', NULL, 0);
INSERT INTO `sys_oper_log` VALUES (17, '角色管理', 'INSERT', 'com.gec.auth.controller.SysRoleController.save()', 'POST', 'MANAGE', 'admin', '', '/admin/auth/sysRole/save', '127.0.0.1', '{\"param\":{},\"roleCode\":\"\",\"roleName\":\"用户管理员\",\"id\":6}', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-27 10:42:18', NULL, 0);
INSERT INTO `sys_oper_log` VALUES (18, '角色管理', 'UPDATE', 'com.gec.auth.controller.SysRoleController.updateById()', 'PUT', 'MANAGE', 'admin', '', '/admin/auth/sysRole/update', '127.0.0.1', '{\"isDeleted\":0,\"createTime\":1653619337000,\"param\":{},\"roleCode\":\"\",\"roleName\":\"用户管理员\",\"updateTime\":1653619337000,\"id\":6}', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-27 10:43:59', NULL, 0);
INSERT INTO `sys_oper_log` VALUES (19, '菜单管理', 'UPDATE', 'com.gec.auth.controller.SysMenuController.updateById()', 'PUT', 'MANAGE', 'admin', '', '/admin/auth/sysMenu/update', '127.0.0.1', '{\"code\":\"sysUser\",\"select\":false,\"level\":3,\"updateTime\":1653957062000,\"type\":1,\"parentId\":2,\"path\":\"sysUser/list\",\"sortValue\":1,\"component\":\"auth/sysUser/list\",\"isDeleted\":0,\"children\":[{\"code\":\"bnt.sysUser.list\",\"select\":false,\"level\":4,\"updateTime\":1653957062000,\"type\":2,\"parentId\":3,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"查看\",\"id\":6,\"status\":1},{\"code\":\"bnt.sysUser.add\",\"select\":false,\"level\":4,\"updateTime\":1653957062000,\"type\":2,\"parentId\":3,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"添加\",\"id\":7,\"status\":1},{\"code\":\"bnt.sysUser.update\",\"select\":false,\"level\":4,\"updateTime\":1653957062000,\"type\":2,\"parentId\":3,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"修改\",\"id\":8,\"status\":1},{\"code\":\"bnt.sysUser.remove\",\"select\":false,\"level\":4,\"updateTime\":1653957062000,\"type\":2,\"parentId\":3,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"删除\",\"id\":9,\"status\":1},{\"code\":\"bnt.sysUser.assignRole\",\"select\":false,\"level\":4,\"toCode\":\"\",\"updateTime\":1653957062000,\"type\":2,\"parentId\":3,\"isDeleted\":0,\"children\":[],\"createTime\":1653297272000,\"param\":{},\"name\":\"分配角色\",\"id\":18,\"status\":1}],\"createTime\":1622455537000,\"param\":{},\"name\":\"用户管理\",\"perms\":\"bnt.sysUser.list\",\"id\":3,\"status\":1}', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-31 09:14:26', NULL, 0);
INSERT INTO `sys_oper_log` VALUES (20, '菜单管理', 'UPDATE', 'com.gec.auth.controller.SysMenuController.updateById()', 'PUT', 'MANAGE', 'admin', '', '/admin/auth/sysMenu/update', '127.0.0.1', '{\"code\":\"sysRole\",\"select\":false,\"level\":3,\"updateTime\":1653957062000,\"type\":1,\"parentId\":2,\"path\":\"sysRole/list\",\"sortValue\":0,\"component\":\"auth/sysRole/list\",\"isDeleted\":0,\"children\":[{\"code\":\"bnt.sysRole.list\",\"select\":false,\"level\":4,\"updateTime\":1653959708000,\"type\":2,\"parentId\":4,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysRole.list\",\"id\":10,\"status\":1},{\"code\":\"bnt.sysRole.add\",\"select\":false,\"level\":4,\"updateTime\":1653959708000,\"type\":2,\"parentId\":4,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"添加\",\"perms\":\"bnt.sysRole.add\",\"id\":11,\"status\":1},{\"code\":\"bnt.sysRole.update\",\"select\":false,\"level\":4,\"updateTime\":1653959708000,\"type\":2,\"parentId\":4,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"修改\",\"perms\":\"bnt.sysRole.update\",\"id\":12,\"status\":1},{\"code\":\"bnt.sysRole.remove\",\"select\":false,\"level\":4,\"updateTime\":1653959708000,\"type\":2,\"parentId\":4,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"删除\",\"perms\":\"bnt.sysRole.remove\",\"id\":13,\"status\":1},{\"code\":\"bnt.sysRole.assignAuth\",\"select\":false,\"level\":4,\"toCode\":\"assignAuth\",\"updateTime\":1653959708000,\"type\":2,\"parentId\":4,\"isDeleted\":0,\"children\":[],\"createTime\":1653297494000,\"param\":{},\"name\":\"分配权限\",\"perms\":\"bnt.sysRole.assignAuth\",\"id\":19,\"status\":1}],\"createTime\":1622455537000,\"param\":{},\"name\":\"角色管理\",\"perms\":\" bnt.sysRole.list\",\"id\":4,\"status\":1}', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-31 09:18:12', NULL, 0);
INSERT INTO `sys_oper_log` VALUES (21, '菜单管理', 'UPDATE', 'com.gec.auth.controller.SysMenuController.updateById()', 'PUT', 'MANAGE', 'admin', '', '/admin/auth/sysMenu/update', '127.0.0.1', '{\"code\":\"sysMenu\",\"select\":false,\"level\":3,\"updateTime\":1653957062000,\"type\":1,\"parentId\":2,\"path\":\"sysMenu/list\",\"sortValue\":0,\"component\":\"auth/sysMenu/list\",\"isDeleted\":0,\"children\":[{\"code\":\"bnt.sysMenu.list\",\"select\":false,\"level\":4,\"updateTime\":1653959708000,\"type\":2,\"parentId\":5,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysMenu.list\",\"id\":14,\"status\":1},{\"code\":\"bnt.sysMenu.add\",\"select\":false,\"level\":4,\"updateTime\":1653959708000,\"type\":2,\"parentId\":5,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"添加\",\"perms\":\"bnt.sysMenu.add\",\"id\":15,\"status\":1},{\"code\":\"bnt.sysMenu.update\",\"select\":false,\"level\":4,\"updateTime\":1653959708000,\"type\":2,\"parentId\":5,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"修改\",\"perms\":\"bnt.sysMenu.update\",\"id\":16,\"status\":1},{\"code\":\"bnt.sysMenu.remove\",\"select\":false,\"level\":4,\"updateTime\":1653959708000,\"type\":2,\"parentId\":5,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"删除\",\"perms\":\"bnt.sysMenu.remove\",\"id\":17,\"status\":1}],\"createTime\":1622455537000,\"param\":{},\"name\":\"菜单管理\",\"perms\":\"bnt.sysMenu.list\",\"id\":5,\"status\":1}', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-31 09:18:37', NULL, 0);
INSERT INTO `sys_oper_log` VALUES (22, '菜单管理', 'UPDATE', 'com.gec.auth.controller.SysMenuController.updateById()', 'PUT', 'MANAGE', 'admin', '', '/admin/auth/sysMenu/update', '127.0.0.1', '{\"code\":\"sysDept\",\"select\":false,\"level\":3,\"toCode\":\"\",\"updateTime\":1653957062000,\"type\":1,\"parentId\":2,\"path\":\"sysDept/list\",\"sortValue\":0,\"component\":\"auth/sysDept/list\",\"isDeleted\":0,\"children\":[{\"code\":\"bnt.sysDept.list\",\"select\":false,\"level\":4,\"toCode\":\"\",\"updateTime\":1653959708000,\"type\":2,\"parentId\":20,\"isDeleted\":0,\"children\":[],\"createTime\":1653358064000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysDept.list\",\"id\":21,\"status\":1},{\"code\":\"bnt.sysDept.add\",\"select\":false,\"level\":4,\"toCode\":\"\",\"updateTime\":1653959708000,\"type\":2,\"parentId\":20,\"isDeleted\":0,\"children\":[],\"createTime\":1653463887000,\"param\":{},\"name\":\"添加\",\"perms\":\"bnt.sysDept.add\",\"id\":24,\"status\":1},{\"code\":\"bnt.sysDept.update\",\"select\":false,\"level\":4,\"toCode\":\"\",\"updateTime\":1653959708000,\"type\":2,\"parentId\":20,\"isDeleted\":0,\"children\":[],\"createTime\":1653463901000,\"param\":{},\"name\":\"修改\",\"perms\":\"bnt.sysDept.update\",\"id\":25,\"status\":1},{\"code\":\"bnt.sysDept.remove\",\"select\":false,\"level\":4,\"toCode\":\"\",\"updateTime\":1653959708000,\"type\":2,\"parentId\":20,\"isDeleted\":0,\"children\":[],\"createTime\":1653463919000,\"param\":{},\"name\":\"删除\",\"perms\":\"bnt.sysDept.remove\",\"id\":26,\"status\":1}],\"createTime\":1653358025000,\"param\":{},\"name\":\"部门管理\",\"perms\":\"bnt.sysDept.list\",\"id\":20,\"status\":1}', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-31 09:19:04', NULL, 0);
INSERT INTO `sys_oper_log` VALUES (23, '菜单管理', 'UPDATE', 'com.gec.auth.controller.SysMenuController.updateById()', 'PUT', 'MANAGE', 'admin', '', '/admin/auth/sysMenu/update', '127.0.0.1', '{\"code\":\"sysPost\",\"select\":false,\"level\":3,\"toCode\":\"\",\"updateTime\":1653957062000,\"type\":1,\"parentId\":2,\"path\":\"sysPost/list\",\"sortValue\":0,\"component\":\"auth/sysPost/list\",\"isDeleted\":0,\"children\":[{\"code\":\"bnt.sysPost.list\",\"select\":false,\"level\":4,\"toCode\":\"\",\"updateTime\":1653959708000,\"type\":2,\"parentId\":22,\"isDeleted\":0,\"children\":[],\"createTime\":1653359145000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysPost.list\",\"id\":23,\"status\":1},{\"code\":\"bnt.sysPost.add\",\"select\":false,\"level\":4,\"toCode\":\"\",\"updateTime\":1653959708000,\"type\":2,\"parentId\":22,\"isDeleted\":0,\"children\":[],\"createTime\":1653463964000,\"param\":{},\"name\":\"添加\",\"perms\":\"bnt.sysPost.add\",\"id\":27,\"status\":1},{\"code\":\"bnt.sysPost.update\",\"select\":false,\"level\":4,\"toCode\":\"\",\"updateTime\":1653959708000,\"type\":2,\"parentId\":22,\"isDeleted\":0,\"children\":[],\"createTime\":1653463978000,\"param\":{},\"name\":\"修改\",\"perms\":\"bnt.sysPost.update\",\"id\":28,\"status\":1},{\"code\":\"bnt.sysPost.remove\",\"select\":false,\"level\":4,\"toCode\":\"\",\"updateTime\":1653959708000,\"type\":2,\"parentId\":22,\"isDeleted\":0,\"children\":[],\"createTime\":1653463991000,\"param\":{},\"name\":\"删除\",\"perms\":\"bnt.sysPost.remove\",\"id\":29,\"status\":1}],\"createTime\":1653359130000,\"param\":{},\"name\":\"岗位管理\",\"perms\":\"bnt.sysPost.list\",\"id\":22,\"status\":1}', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-31 09:19:23', NULL, 0);
INSERT INTO `sys_oper_log` VALUES (24, '菜单管理', 'UPDATE', 'com.gec.auth.controller.SysMenuController.updateById()', 'PUT', 'MANAGE', 'admin', '', '/admin/auth/sysMenu/update', '127.0.0.1', '{\"code\":\"sysOperLog\",\"select\":false,\"level\":3,\"toCode\":\"\",\"updateTime\":1653957062000,\"type\":1,\"parentId\":2,\"path\":\"sysOperLog/list\",\"sortValue\":0,\"component\":\"auth/sysOperLog/list\",\"isDeleted\":0,\"children\":[{\"code\":\"bnt.sysOperLog.list\",\"select\":false,\"level\":4,\"toCode\":\"\",\"updateTime\":1653959708000,\"type\":2,\"parentId\":30,\"isDeleted\":0,\"children\":[],\"createTime\":1653552617000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysOperLog.list\",\"id\":31,\"status\":1}],\"createTime\":1653552599000,\"param\":{},\"name\":\"操作日志\",\"perms\":\"bnt.sysOperLog.list\",\"id\":30,\"status\":1}', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-31 09:19:40', NULL, 0);
INSERT INTO `sys_oper_log` VALUES (25, '菜单管理', 'UPDATE', 'com.gec.auth.controller.SysMenuController.updateById()', 'PUT', 'MANAGE', 'admin', '', '/admin/auth/sysMenu/update', '127.0.0.1', '{\"code\":\"sysLoginLog\",\"select\":false,\"level\":3,\"toCode\":\"\",\"updateTime\":1653957062000,\"type\":1,\"parentId\":2,\"path\":\"sysLoginLog/list\",\"sortValue\":0,\"component\":\"auth/sysLoginLog/list\",\"isDeleted\":0,\"children\":[{\"code\":\"bnt.sysLoginLog.list\",\"select\":false,\"level\":4,\"toCode\":\"\",\"updateTime\":1653957062000,\"type\":1,\"parentId\":32,\"isDeleted\":0,\"children\":[],\"createTime\":1653554191000,\"param\":{},\"name\":\"查看\",\"id\":33,\"status\":1}],\"createTime\":1653554173000,\"param\":{},\"name\":\"登录日志\",\"perms\":\" bnt.sysLoginLog.list\",\"id\":32,\"status\":1}', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-31 09:20:09', NULL, 0);
INSERT INTO `sys_oper_log` VALUES (26, '菜单管理', 'UPDATE', 'com.gec.auth.controller.SysMenuController.updateById()', 'PUT', 'MANAGE', 'admin', '', '/admin/auth/sysMenu/update', '127.0.0.1', '{\"code\":\"sysUser\",\"select\":false,\"level\":2,\"updateTime\":1653957062000,\"type\":1,\"parentId\":2,\"path\":\"sysUser\",\"sortValue\":1,\"component\":\"auth/sysUser/list\",\"isDeleted\":0,\"children\":[{\"code\":\"bnt.sysUser.list\",\"select\":false,\"level\":3,\"updateTime\":1653959708000,\"type\":2,\"parentId\":3,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysUser.list\",\"id\":6,\"status\":1},{\"code\":\"bnt.sysUser.add\",\"select\":false,\"level\":3,\"updateTime\":1653959708000,\"type\":2,\"parentId\":3,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"添加\",\"perms\":\"bnt.sysUser.add\",\"id\":7,\"status\":1},{\"code\":\"bnt.sysUser.update\",\"select\":false,\"level\":3,\"updateTime\":1653959708000,\"type\":2,\"parentId\":3,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"修改\",\"perms\":\"bnt.sysUser.update\",\"id\":8,\"status\":1},{\"code\":\"bnt.sysUser.remove\",\"select\":false,\"level\":3,\"updateTime\":1653959708000,\"type\":2,\"parentId\":3,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"删除\",\"perms\":\"bnt.sysUser.remove\",\"id\":9,\"status\":1},{\"code\":\"bnt.sysUser.assignRole\",\"select\":false,\"level\":3,\"toCode\":\"\",\"updateTime\":1653959708000,\"type\":2,\"parentId\":3,\"isDeleted\":0,\"children\":[],\"createTime\":1653297272000,\"param\":{},\"name\":\"分配角色\",\"perms\":\"bnt.sysUser.assignRole\",\"id\":18,\"status\":1}],\"createTime\":1622455537000,\"param\":{},\"name\":\"用户管理\",\"perms\":\"bnt.sysUser.list\",\"id\":3,\"status\":1}', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-31 09:41:35', NULL, 0);
INSERT INTO `sys_oper_log` VALUES (27, '菜单管理', 'UPDATE', 'com.gec.auth.controller.SysMenuController.updateById()', 'PUT', 'MANAGE', 'admin', '', '/admin/auth/sysMenu/update', '127.0.0.1', '{\"code\":\"sysRole\",\"select\":false,\"level\":2,\"updateTime\":1653957062000,\"type\":1,\"parentId\":2,\"path\":\"sysRole\",\"sortValue\":0,\"component\":\"auth/sysRole/list\",\"isDeleted\":0,\"children\":[{\"code\":\"bnt.sysRole.list\",\"select\":false,\"level\":3,\"updateTime\":1653959708000,\"type\":2,\"parentId\":4,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysRole.list\",\"id\":10,\"status\":1},{\"code\":\"bnt.sysRole.add\",\"select\":false,\"level\":3,\"updateTime\":1653959708000,\"type\":2,\"parentId\":4,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"添加\",\"perms\":\"bnt.sysRole.add\",\"id\":11,\"status\":1},{\"code\":\"bnt.sysRole.update\",\"select\":false,\"level\":3,\"updateTime\":1653959708000,\"type\":2,\"parentId\":4,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"修改\",\"perms\":\"bnt.sysRole.update\",\"id\":12,\"status\":1},{\"code\":\"bnt.sysRole.remove\",\"select\":false,\"level\":3,\"updateTime\":1653959708000,\"type\":2,\"parentId\":4,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"删除\",\"perms\":\"bnt.sysRole.remove\",\"id\":13,\"status\":1},{\"code\":\"bnt.sysRole.assignAuth\",\"select\":false,\"level\":3,\"toCode\":\"assignAuth\",\"updateTime\":1653959708000,\"type\":2,\"parentId\":4,\"isDeleted\":0,\"children\":[],\"createTime\":1653297494000,\"param\":{},\"name\":\"分配权限\",\"perms\":\"bnt.sysRole.assignAuth\",\"id\":19,\"status\":1}],\"createTime\":1622455537000,\"param\":{},\"name\":\"角色管理\",\"perms\":\" bnt.sysRole.list\",\"id\":4,\"status\":1}', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-31 09:41:42', NULL, 0);
INSERT INTO `sys_oper_log` VALUES (28, '菜单管理', 'UPDATE', 'com.gec.auth.controller.SysMenuController.updateById()', 'PUT', 'MANAGE', 'admin', '', '/admin/auth/sysMenu/update', '127.0.0.1', '{\"code\":\"sysMenu\",\"select\":false,\"level\":2,\"updateTime\":1653957062000,\"type\":1,\"parentId\":2,\"path\":\"sysMenu\",\"sortValue\":0,\"component\":\"auth/sysMenu/list\",\"isDeleted\":0,\"children\":[{\"code\":\"bnt.sysMenu.list\",\"select\":false,\"level\":3,\"updateTime\":1653959708000,\"type\":2,\"parentId\":5,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysMenu.list\",\"id\":14,\"status\":1},{\"code\":\"bnt.sysMenu.add\",\"select\":false,\"level\":3,\"updateTime\":1653959708000,\"type\":2,\"parentId\":5,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"添加\",\"perms\":\"bnt.sysMenu.add\",\"id\":15,\"status\":1},{\"code\":\"bnt.sysMenu.update\",\"select\":false,\"level\":3,\"updateTime\":1653959708000,\"type\":2,\"parentId\":5,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"修改\",\"perms\":\"bnt.sysMenu.update\",\"id\":16,\"status\":1},{\"code\":\"bnt.sysMenu.remove\",\"select\":false,\"level\":3,\"updateTime\":1653959708000,\"type\":2,\"parentId\":5,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"删除\",\"perms\":\"bnt.sysMenu.remove\",\"id\":17,\"status\":1}],\"createTime\":1622455537000,\"param\":{},\"name\":\"菜单管理\",\"perms\":\"bnt.sysMenu.list\",\"id\":5,\"status\":1}', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-31 09:41:51', NULL, 0);
INSERT INTO `sys_oper_log` VALUES (29, '菜单管理', 'UPDATE', 'com.gec.auth.controller.SysMenuController.updateById()', 'PUT', 'MANAGE', 'admin', '', '/admin/auth/sysMenu/update', '127.0.0.1', '{\"code\":\"sysDept\",\"select\":false,\"level\":2,\"toCode\":\"\",\"updateTime\":1653957062000,\"type\":1,\"parentId\":2,\"path\":\"sysDept\",\"sortValue\":0,\"component\":\"auth/sysDept/list\",\"isDeleted\":0,\"children\":[{\"code\":\"bnt.sysDept.list\",\"select\":false,\"level\":3,\"toCode\":\"\",\"updateTime\":1653959708000,\"type\":2,\"parentId\":20,\"isDeleted\":0,\"children\":[],\"createTime\":1653358064000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysDept.list\",\"id\":21,\"status\":1},{\"code\":\"bnt.sysDept.add\",\"select\":false,\"level\":3,\"toCode\":\"\",\"updateTime\":1653959708000,\"type\":2,\"parentId\":20,\"isDeleted\":0,\"children\":[],\"createTime\":1653463887000,\"param\":{},\"name\":\"添加\",\"perms\":\"bnt.sysDept.add\",\"id\":24,\"status\":1},{\"code\":\"bnt.sysDept.update\",\"select\":false,\"level\":3,\"toCode\":\"\",\"updateTime\":1653959708000,\"type\":2,\"parentId\":20,\"isDeleted\":0,\"children\":[],\"createTime\":1653463901000,\"param\":{},\"name\":\"修改\",\"perms\":\"bnt.sysDept.update\",\"id\":25,\"status\":1},{\"code\":\"bnt.sysDept.remove\",\"select\":false,\"level\":3,\"toCode\":\"\",\"updateTime\":1653959708000,\"type\":2,\"parentId\":20,\"isDeleted\":0,\"children\":[],\"createTime\":1653463919000,\"param\":{},\"name\":\"删除\",\"perms\":\"bnt.sysDept.remove\",\"id\":26,\"status\":1}],\"createTime\":1653358025000,\"param\":{},\"name\":\"部门管理\",\"perms\":\"bnt.sysDept.list\",\"id\":20,\"status\":1}', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-31 09:41:58', NULL, 0);
INSERT INTO `sys_oper_log` VALUES (30, '菜单管理', 'UPDATE', 'com.gec.auth.controller.SysMenuController.updateById()', 'PUT', 'MANAGE', 'admin', '', '/admin/auth/sysMenu/update', '127.0.0.1', '{\"code\":\"sysPost\",\"select\":false,\"level\":2,\"toCode\":\"\",\"updateTime\":1653957062000,\"type\":1,\"parentId\":2,\"path\":\"sysPost\",\"sortValue\":0,\"component\":\"auth/sysPost/list\",\"isDeleted\":0,\"children\":[{\"code\":\"bnt.sysPost.list\",\"select\":false,\"level\":3,\"toCode\":\"\",\"updateTime\":1653959708000,\"type\":2,\"parentId\":22,\"isDeleted\":0,\"children\":[],\"createTime\":1653359145000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysPost.list\",\"id\":23,\"status\":1},{\"code\":\"bnt.sysPost.add\",\"select\":false,\"level\":3,\"toCode\":\"\",\"updateTime\":1653959708000,\"type\":2,\"parentId\":22,\"isDeleted\":0,\"children\":[],\"createTime\":1653463964000,\"param\":{},\"name\":\"添加\",\"perms\":\"bnt.sysPost.add\",\"id\":27,\"status\":1},{\"code\":\"bnt.sysPost.update\",\"select\":false,\"level\":3,\"toCode\":\"\",\"updateTime\":1653959708000,\"type\":2,\"parentId\":22,\"isDeleted\":0,\"children\":[],\"createTime\":1653463978000,\"param\":{},\"name\":\"修改\",\"perms\":\"bnt.sysPost.update\",\"id\":28,\"status\":1},{\"code\":\"bnt.sysPost.remove\",\"select\":false,\"level\":3,\"toCode\":\"\",\"updateTime\":1653959708000,\"type\":2,\"parentId\":22,\"isDeleted\":0,\"children\":[],\"createTime\":1653463991000,\"param\":{},\"name\":\"删除\",\"perms\":\"bnt.sysPost.remove\",\"id\":29,\"status\":1}],\"createTime\":1653359130000,\"param\":{},\"name\":\"岗位管理\",\"perms\":\"bnt.sysPost.list\",\"id\":22,\"status\":1}', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-31 09:42:04', NULL, 0);
INSERT INTO `sys_oper_log` VALUES (31, '菜单管理', 'UPDATE', 'com.gec.auth.controller.SysMenuController.updateById()', 'PUT', 'MANAGE', 'admin', '', '/admin/auth/sysMenu/update', '127.0.0.1', '{\"code\":\"sysOperLog\",\"select\":false,\"level\":2,\"toCode\":\"\",\"updateTime\":1653957062000,\"type\":1,\"parentId\":2,\"path\":\"sysOperLog\",\"sortValue\":0,\"component\":\"auth/sysOperLog/list\",\"isDeleted\":0,\"children\":[{\"code\":\"bnt.sysOperLog.list\",\"select\":false,\"level\":3,\"toCode\":\"\",\"updateTime\":1653959708000,\"type\":2,\"parentId\":30,\"isDeleted\":0,\"children\":[],\"createTime\":1653552617000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysOperLog.list\",\"id\":31,\"status\":1}],\"createTime\":1653552599000,\"param\":{},\"name\":\"操作日志\",\"perms\":\"bnt.sysOperLog.list\",\"id\":30,\"status\":1}', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-31 09:42:09', NULL, 0);
INSERT INTO `sys_oper_log` VALUES (32, '菜单管理', 'UPDATE', 'com.gec.auth.controller.SysMenuController.updateById()', 'PUT', 'MANAGE', 'admin', '', '/admin/auth/sysMenu/update', '127.0.0.1', '{\"code\":\"sysLoginLog\",\"select\":false,\"level\":2,\"toCode\":\"\",\"updateTime\":1653957062000,\"type\":1,\"parentId\":2,\"path\":\"sysLoginLog\",\"sortValue\":0,\"component\":\"auth/sysLoginLog/list\",\"isDeleted\":0,\"children\":[{\"code\":\"bnt.sysLoginLog.list\",\"select\":false,\"level\":3,\"toCode\":\"\",\"updateTime\":1653957062000,\"type\":1,\"parentId\":32,\"isDeleted\":0,\"children\":[],\"createTime\":1653554191000,\"param\":{},\"name\":\"查看\",\"id\":33,\"status\":1}],\"createTime\":1653554173000,\"param\":{},\"name\":\"登录日志\",\"perms\":\" bnt.sysLoginLog.list\",\"id\":32,\"status\":1}', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-31 09:42:15', NULL, 0);
INSERT INTO `sys_oper_log` VALUES (33, '菜单管理', 'INSERT', 'com.gec.system.controller.SysMenuController.save()', 'POST', 'MANAGE', 'admin', '', '/admin/system/sysMenu/save', '127.0.0.1', '{\"select\":false,\"icon\":\"\",\"type\":0,\"parentId\":2,\"path\":\"log\",\"sortValue\":1,\"component\":\"\",\"param\":{},\"name\":\"日志管理\",\"perms\":\"\",\"id\":34,\"status\":1}', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-31 13:23:07', NULL, 0);
INSERT INTO `sys_oper_log` VALUES (34, '菜单管理', 'INSERT', 'com.gec.system.controller.SysMenuController.save()', 'POST', 'MANAGE', 'admin', '', '/admin/system/sysMenu/save', '127.0.0.1', '{\"select\":false,\"visible\":1,\"icon\":\"\",\"type\":0,\"parentId\":0,\"path\":\"order\",\"sortValue\":1,\"component\":\"Layout\",\"param\":{},\"name\":\"订单管理\",\"perms\":\"\",\"id\":35,\"status\":1}', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-31 13:57:50', NULL, 0);
INSERT INTO `sys_oper_log` VALUES (35, '菜单管理', 'INSERT', 'com.gec.system.controller.SysMenuController.save()', 'POST', 'MANAGE', 'admin', '', '/admin/system/sysMenu/save', '127.0.0.1', '{\"select\":false,\"visible\":1,\"icon\":\"\",\"type\":1,\"parentId\":35,\"path\":\"orderInfo\",\"sortValue\":1,\"component\":\"order/orderInfo/list\",\"param\":{},\"name\":\"订单列表\",\"perms\":\"bnt.orderInfo.list\",\"id\":36,\"status\":1}', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-05-31 13:58:37', NULL, 0);
INSERT INTO `sys_oper_log` VALUES (36, '岗位管理', 'INSERT', 'com.gec.system.controller.SysPostController.save()', 'POST', 'MANAGE', 'admin', '', '/admin/system/sysPost/save', '127.0.0.1', '{\"param\":{},\"name\":\"运营总监\",\"description\":\"\",\"postCode\":\"yyzj\",\"id\":8,\"status\":1}', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-06-08 17:14:21', NULL, 0);
INSERT INTO `sys_oper_log` VALUES (37, '角色管理', 'INSERT', 'com.gec.system.controller.SysRoleController.save()', 'POST', 'MANAGE', 'admin', '', '/admin/system/sysRole/save', '127.0.0.1', '{\"param\":{},\"roleCode\":\"\",\"roleName\":\"\",\"id\":8}', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-06-08 17:39:04', NULL, 0);
INSERT INTO `sys_oper_log` VALUES (38, '角色管理', 'UPDATE', 'com.gec.system.controller.SysRoleController.updateById()', 'PUT', 'MANAGE', 'admin', '', '/admin/system/sysRole/update', '127.0.0.1', '{\"isDeleted\":0,\"createTime\":1654681144000,\"param\":{},\"roleCode\":\"\",\"roleName\":\"\",\"updateTime\":1654681144000,\"id\":8}', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-06-08 17:39:08', NULL, 0);
INSERT INTO `sys_oper_log` VALUES (39, '角色管理', 'UPDATE', 'com.gec.system.controller.SysRoleController.updateById()', 'PUT', 'MANAGE', 'admin', '', '/admin/system/sysRole/update', '127.0.0.1', '{\"isDeleted\":0,\"createTime\":1654681144000,\"param\":{},\"roleCode\":\"\",\"roleName\":\"\",\"updateTime\":1654681144000,\"id\":8}', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-06-08 17:39:41', NULL, 0);
INSERT INTO `sys_oper_log` VALUES (40, '角色管理', 'UPDATE', 'com.gec.system.controller.SysRoleController.updateById()', 'PUT', 'MANAGE', 'admin', '', '/admin/system/sysRole/update', '127.0.0.1', '{\"isDeleted\":0,\"createTime\":1654681144000,\"param\":{},\"roleCode\":\"yhgly\",\"roleName\":\"用户管理员\",\"updateTime\":1654681144000,\"id\":8}', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-06-08 17:42:46', NULL, 0);
INSERT INTO `sys_oper_log` VALUES (41, '菜单管理', 'INSERT', 'com.gec.system.controller.SysMenuController.save()', 'POST', 'MANAGE', 'admin', '', '/admin/system/sysMenu/save', '127.0.0.1', '{\"select\":false,\"icon\":\"el-icon-phone\",\"type\":0,\"parentId\":0,\"path\":\"order\",\"sortValue\":1,\"component\":\"Layout\",\"param\":{},\"name\":\"订单管理\",\"perms\":\"\",\"id\":35,\"status\":1}', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-06-09 08:50:13', NULL, 0);
INSERT INTO `sys_oper_log` VALUES (42, '菜单管理', 'UPDATE', 'com.gec.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE', 'admin', '', '/admin/system/sysMenu/update', '127.0.0.1', '{\"select\":false,\"icon\":\"el-icon-phone\",\"updateTime\":1654735813000,\"type\":0,\"parentId\":0,\"path\":\"order\",\"sortValue\":1,\"component\":\"Layout\",\"isDeleted\":0,\"children\":[],\"createTime\":1654735813000,\"param\":{},\"name\":\"订单管理\",\"perms\":\"\",\"id\":35,\"status\":1}', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-06-09 08:50:22', NULL, 0);
INSERT INTO `sys_oper_log` VALUES (43, '菜单管理', 'INSERT', 'com.gec.system.controller.SysMenuController.save()', 'POST', 'MANAGE', 'admin', '', '/admin/system/sysMenu/save', '127.0.0.1', '{\"select\":false,\"icon\":\"el-icon-s-help\",\"type\":1,\"parentId\":35,\"path\":\"orderInfo\",\"sortValue\":1,\"component\":\"order/orderInfo/list\",\"param\":{},\"name\":\"订单列表\",\"perms\":\"bnt.orderInfo.list\",\"id\":36,\"status\":1}', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-06-09 08:51:22', NULL, 0);
INSERT INTO `sys_oper_log` VALUES (44, '菜单管理', 'INSERT', 'com.gec.system.controller.SysMenuController.save()', 'POST', 'MANAGE', 'admin', '', '/admin/system/sysMenu/save', '127.0.0.1', '{\"select\":false,\"icon\":\"\",\"type\":2,\"parentId\":36,\"path\":\"\",\"sortValue\":1,\"component\":\"\",\"param\":{},\"name\":\"添加\",\"perms\":\"bnt.add\",\"id\":37,\"status\":1}', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-06-09 08:52:37', NULL, 0);
INSERT INTO `sys_oper_log` VALUES (45, '菜单管理', 'DELETE', 'com.gec.system.controller.SysMenuController.remove()', 'DELETE', 'MANAGE', 'admin', '', '/admin/system/sysMenu/remove/37', '127.0.0.1', '', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-06-09 08:53:01', NULL, 0);
INSERT INTO `sys_oper_log` VALUES (46, '菜单管理', 'DELETE', 'com.gec.system.controller.SysMenuController.remove()', 'DELETE', 'MANAGE', 'admin', '', '/admin/system/sysMenu/remove/36', '127.0.0.1', '', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-06-09 08:53:04', NULL, 0);
INSERT INTO `sys_oper_log` VALUES (47, '菜单管理', 'DELETE', 'com.gec.system.controller.SysMenuController.remove()', 'DELETE', 'MANAGE', 'admin', '', '/admin/system/sysMenu/remove/35', '127.0.0.1', '', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-06-09 08:53:06', NULL, 0);
INSERT INTO `sys_oper_log` VALUES (48, '菜单管理', 'UPDATE', 'com.gec.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE', 'admin', '', '/admin/system/sysMenu/update', '127.0.0.1', '{\"select\":false,\"icon\":\"el-icon-s-custom\",\"updateTime\":1654737767000,\"type\":1,\"parentId\":2,\"path\":\"sysUser\",\"sortValue\":1,\"component\":\"system/sysUser/list\",\"isDeleted\":0,\"children\":[{\"select\":false,\"updateTime\":1654737758000,\"type\":2,\"parentId\":3,\"sortValue\":1,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysUser.list\",\"id\":6,\"status\":1},{\"select\":false,\"updateTime\":1654737758000,\"type\":2,\"parentId\":3,\"sortValue\":1,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"添加\",\"perms\":\"bnt.sysUser.add\",\"id\":7,\"status\":1},{\"select\":false,\"updateTime\":1654737758000,\"type\":2,\"parentId\":3,\"sortValue\":1,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"修改\",\"perms\":\"bnt.sysUser.update\",\"id\":8,\"status\":1},{\"select\":false,\"updateTime\":1654737758000,\"type\":2,\"parentId\":3,\"sortValue\":1,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"删除\",\"perms\":\"bnt.sysUser.remove\",\"id\":9,\"status\":1},{\"select\":false,\"updateTime\":1654737758000,\"type\":2,\"parentId\":3,\"sortValue\":1,\"isDeleted\":0,\"children\":[],\"createTime\":1653297272000,\"param\":{},\"name\":\"分配角色\",\"perms\":\"bnt.sysUser.assignRole\",\"id\":18,\"status\":1}],\"createTime\":1622455537000,\"param\":{},\"name\":\"用户管理\",\"perms\":\"\",\"id\":3,\"status\":1}', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-06-09 09:24:01', NULL, 0);
INSERT INTO `sys_oper_log` VALUES (49, '菜单管理', 'UPDATE', 'com.gec.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE', 'admin', '', '/admin/system/sysMenu/update', '127.0.0.1', '{\"select\":false,\"icon\":\"el-icon-ums-solid\",\"updateTime\":1654737768000,\"type\":1,\"parentId\":2,\"path\":\"sysRole\",\"sortValue\":1,\"component\":\"system/sysRole/list\",\"isDeleted\":0,\"children\":[{\"select\":false,\"updateTime\":1654737758000,\"type\":2,\"parentId\":4,\"sortValue\":1,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysRole.list\",\"id\":10,\"status\":1},{\"select\":false,\"updateTime\":1654737758000,\"type\":2,\"parentId\":4,\"sortValue\":1,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"添加\",\"perms\":\"bnt.sysRole.add\",\"id\":11,\"status\":1},{\"select\":false,\"updateTime\":1654737758000,\"type\":2,\"parentId\":4,\"sortValue\":1,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"修改\",\"perms\":\"bnt.sysRole.update\",\"id\":12,\"status\":1},{\"select\":false,\"updateTime\":1654737758000,\"type\":2,\"parentId\":4,\"sortValue\":1,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"删除\",\"perms\":\"bnt.sysRole.remove\",\"id\":13,\"status\":1},{\"select\":false,\"updateTime\":1654737758000,\"type\":2,\"parentId\":4,\"path\":\"\",\"sortValue\":1,\"component\":\"\",\"isDeleted\":0,\"children\":[],\"createTime\":1653297494000,\"param\":{},\"name\":\"分配权限\",\"perms\":\"bnt.sysRole.assignAuth\",\"id\":19,\"status\":1}],\"createTime\":1622455537000,\"param\":{},\"name\":\"角色管理\",\"perms\":\"\",\"id\":4,\"status\":1}', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-06-09 09:24:10', NULL, 0);
INSERT INTO `sys_oper_log` VALUES (50, '菜单管理', 'UPDATE', 'com.gec.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE', 'admin', '', '/admin/system/sysMenu/update', '127.0.0.1', '{\"select\":false,\"icon\":\"el-icon-s-unfold\",\"updateTime\":1654737769000,\"type\":1,\"parentId\":2,\"path\":\"sysMenu\",\"sortValue\":1,\"component\":\"system/sysMenu/list\",\"isDeleted\":0,\"children\":[{\"select\":false,\"updateTime\":1654737758000,\"type\":2,\"parentId\":5,\"sortValue\":1,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysMenu.list\",\"id\":14,\"status\":1},{\"select\":false,\"updateTime\":1654737758000,\"type\":2,\"parentId\":5,\"sortValue\":1,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"添加\",\"perms\":\"bnt.sysMenu.add\",\"id\":15,\"status\":1},{\"select\":false,\"updateTime\":1654737758000,\"type\":2,\"parentId\":5,\"sortValue\":1,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"修改\",\"perms\":\"bnt.sysMenu.update\",\"id\":16,\"status\":1},{\"select\":false,\"updateTime\":1654737758000,\"type\":2,\"parentId\":5,\"sortValue\":1,\"isDeleted\":0,\"children\":[],\"createTime\":1622455537000,\"param\":{},\"name\":\"删除\",\"perms\":\"bnt.sysMenu.remove\",\"id\":17,\"status\":1}],\"createTime\":1622455537000,\"param\":{},\"name\":\"菜单管理\",\"perms\":\"\",\"id\":5,\"status\":1}', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-06-09 09:24:21', NULL, 0);
INSERT INTO `sys_oper_log` VALUES (51, '菜单管理', 'UPDATE', 'com.gec.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE', 'admin', '', '/admin/system/sysMenu/update', '127.0.0.1', '{\"select\":false,\"icon\":\"el-icon-s-operation\",\"updateTime\":1654737776000,\"type\":1,\"parentId\":2,\"path\":\"sysDept\",\"sortValue\":1,\"component\":\"system/sysDept/list\",\"isDeleted\":0,\"children\":[{\"select\":false,\"updateTime\":1654737758000,\"type\":2,\"parentId\":20,\"sortValue\":1,\"isDeleted\":0,\"children\":[],\"createTime\":1653358064000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysDept.list\",\"id\":21,\"status\":1},{\"select\":false,\"updateTime\":1654737758000,\"type\":2,\"parentId\":20,\"sortValue\":1,\"isDeleted\":0,\"children\":[],\"createTime\":1653463887000,\"param\":{},\"name\":\"添加\",\"perms\":\"bnt.sysDept.add\",\"id\":24,\"status\":1},{\"select\":false,\"updateTime\":1654737758000,\"type\":2,\"parentId\":20,\"sortValue\":1,\"isDeleted\":0,\"children\":[],\"createTime\":1653463901000,\"param\":{},\"name\":\"修改\",\"perms\":\"bnt.sysDept.update\",\"id\":25,\"status\":1},{\"select\":false,\"updateTime\":1654737758000,\"type\":2,\"parentId\":20,\"sortValue\":1,\"isDeleted\":0,\"children\":[],\"createTime\":1653463919000,\"param\":{},\"name\":\"删除\",\"perms\":\"bnt.sysDept.remove\",\"id\":26,\"status\":1}],\"createTime\":1653358025000,\"param\":{},\"name\":\"部门管理\",\"perms\":\"\",\"id\":20,\"status\":1}', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-06-09 09:24:28', NULL, 0);
INSERT INTO `sys_oper_log` VALUES (52, '菜单管理', 'UPDATE', 'com.gec.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE', 'admin', '', '/admin/system/sysMenu/update', '127.0.0.1', '{\"select\":false,\"icon\":\"el-icon-more-outline\",\"updateTime\":1654737777000,\"type\":1,\"parentId\":2,\"path\":\"sysPost\",\"sortValue\":1,\"component\":\"system/sysPost/list\",\"isDeleted\":0,\"children\":[{\"select\":false,\"updateTime\":1654737758000,\"type\":2,\"parentId\":22,\"sortValue\":1,\"isDeleted\":0,\"children\":[],\"createTime\":1653359145000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysPost.list\",\"id\":23,\"status\":1},{\"select\":false,\"updateTime\":1654737758000,\"type\":2,\"parentId\":22,\"sortValue\":1,\"isDeleted\":0,\"children\":[],\"createTime\":1653463964000,\"param\":{},\"name\":\"添加\",\"perms\":\"bnt.sysPost.add\",\"id\":27,\"status\":1},{\"select\":false,\"updateTime\":1654737758000,\"type\":2,\"parentId\":22,\"sortValue\":1,\"isDeleted\":0,\"children\":[],\"createTime\":1653463978000,\"param\":{},\"name\":\"修改\",\"perms\":\"bnt.sysPost.update\",\"id\":28,\"status\":1},{\"select\":false,\"updateTime\":1654737758000,\"type\":2,\"parentId\":22,\"sortValue\":1,\"isDeleted\":0,\"children\":[],\"createTime\":1653463991000,\"param\":{},\"name\":\"删除\",\"perms\":\"bnt.sysPost.remove\",\"id\":29,\"status\":1}],\"createTime\":1653359130000,\"param\":{},\"name\":\"岗位管理\",\"perms\":\"\",\"id\":22,\"status\":1}', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-06-09 09:24:35', NULL, 0);
INSERT INTO `sys_oper_log` VALUES (53, '菜单管理', 'UPDATE', 'com.gec.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE', 'admin', '', '/admin/system/sysMenu/update', '127.0.0.1', '{\"select\":false,\"icon\":\"el-icon-tickets\",\"updateTime\":1653974966000,\"type\":0,\"parentId\":2,\"path\":\"log\",\"sortValue\":1,\"component\":\"ParentView\",\"isDeleted\":0,\"children\":[{\"select\":false,\"updateTime\":1654737785000,\"type\":1,\"parentId\":34,\"path\":\"sysOperLog\",\"sortValue\":1,\"component\":\"system/sysOperLog/list\",\"isDeleted\":0,\"children\":[{\"select\":false,\"updateTime\":1654737758000,\"type\":2,\"parentId\":30,\"sortValue\":1,\"isDeleted\":0,\"children\":[],\"createTime\":1653552617000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysOperLog.list\",\"id\":31,\"status\":1}],\"createTime\":1653552599000,\"param\":{},\"name\":\"操作日志\",\"perms\":\"\",\"id\":30,\"status\":1},{\"select\":false,\"updateTime\":1654737787000,\"type\":1,\"parentId\":34,\"path\":\"sysLoginLog\",\"sortValue\":1,\"component\":\"system/sysLoginLog/list\",\"isDeleted\":0,\"children\":[{\"select\":false,\"updateTime\":1654737758000,\"type\":2,\"parentId\":32,\"sortValue\":1,\"isDeleted\":0,\"children\":[],\"createTime\":1653554191000,\"param\":{},\"name\":\"查看\",\"id\":33,\"status\":1}],\"createTime\":1653554173000,\"param\":{},\"name\":\"登录日志\",\"perms\":\"\",\"id\":32,\"status\":1}],\"createTime\":1653974587000,\"param\":{},\"name\":\"日志管理\",\"perms\":\"\",\"id\":34,\"status\":1}', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-06-09 09:24:46', NULL, 0);
INSERT INTO `sys_oper_log` VALUES (54, '菜单管理', 'UPDATE', 'com.gec.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE', 'admin', '', '/admin/system/sysMenu/update', '127.0.0.1', '{\"select\":false,\"icon\":\"el-icon-document-remove\",\"updateTime\":1654737785000,\"type\":1,\"parentId\":34,\"path\":\"sysOperLog\",\"sortValue\":1,\"component\":\"system/sysOperLog/list\",\"isDeleted\":0,\"children\":[{\"select\":false,\"updateTime\":1654737758000,\"type\":2,\"parentId\":30,\"sortValue\":1,\"isDeleted\":0,\"children\":[],\"createTime\":1653552617000,\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.sysOperLog.list\",\"id\":31,\"status\":1}],\"createTime\":1653552599000,\"param\":{},\"name\":\"操作日志\",\"perms\":\"\",\"id\":30,\"status\":1}', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-06-09 09:24:55', NULL, 0);
INSERT INTO `sys_oper_log` VALUES (55, '菜单管理', 'UPDATE', 'com.gec.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE', 'admin', '', '/admin/system/sysMenu/update', '127.0.0.1', '{\"select\":false,\"icon\":\"el-icon-s-goods\",\"updateTime\":1654737787000,\"type\":1,\"parentId\":34,\"path\":\"sysLoginLog\",\"sortValue\":1,\"component\":\"system/sysLoginLog/list\",\"isDeleted\":0,\"children\":[{\"select\":false,\"updateTime\":1654737758000,\"type\":2,\"parentId\":32,\"sortValue\":1,\"isDeleted\":0,\"children\":[],\"createTime\":1653554191000,\"param\":{},\"name\":\"查看\",\"id\":33,\"status\":1}],\"createTime\":1653554173000,\"param\":{},\"name\":\"登录日志\",\"perms\":\"\",\"id\":32,\"status\":1}', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-06-09 09:25:07', NULL, 0);
INSERT INTO `sys_oper_log` VALUES (56, '用户管理', 'DELETE', 'com.gec.system.controller.SysUserController.remove()', 'DELETE', 'MANAGE', 'admin', '', '/admin/system/sysUser/remove/4', '127.0.0.1', '', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-06-09 09:25:21', NULL, 0);
INSERT INTO `sys_oper_log` VALUES (57, '菜单管理', 'UPDATE', 'com.gec.system.controller.SysMenuController.updateById()', 'PUT', 'MANAGE', 'admin', '', '/admin/system/sysMenu/update', '127.0.0.1', '{\"select\":false,\"updateTime\":1654737758000,\"type\":2,\"parentId\":4,\"path\":\"assignAuth\",\"sortValue\":1,\"component\":\"system/sysRole/assignAuth\",\"isDeleted\":0,\"children\":[],\"createTime\":1653297494000,\"param\":{},\"name\":\"分配权限\",\"perms\":\"bnt.sysRole.assignAuth\",\"id\":19,\"status\":1}', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-06-09 09:26:07', NULL, 0);
INSERT INTO `sys_oper_log` VALUES (58, '角色管理', 'ASSGIN', 'com.gec.system.controller.SysMenuController.doAssign()', 'POST', 'MANAGE', 'admin', '', '/admin/system/sysMenu/doAssign', '127.0.0.1', '{\"roleId\":2,\"menuIdList\":[2,3,6,7,8,5,14,20,21]}', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-06-09 09:26:34', NULL, 0);
INSERT INTO `sys_oper_log` VALUES (59, '菜单管理', 'INSERT', 'com.gec.system.controller.SysMenuController.save()', 'POST', 'MANAGE', 'admin', '', '/admin/system/sysMenu/save', '127.0.0.1', '{\"select\":false,\"icon\":\"el-icon-s-help\",\"type\":0,\"parentId\":0,\"path\":\"vod\",\"sortValue\":1,\"component\":\"Layout\",\"param\":{},\"name\":\"点播管理\",\"perms\":\"\",\"id\":35,\"status\":1}', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-06-10 15:26:53', NULL, 0);
INSERT INTO `sys_oper_log` VALUES (60, '菜单管理', 'INSERT', 'com.gec.system.controller.SysMenuController.save()', 'POST', 'MANAGE', 'admin', '', '/admin/system/sysMenu/save', '127.0.0.1', '{\"select\":false,\"icon\":\"el-icon-phone\",\"type\":1,\"parentId\":35,\"path\":\"teacher/list\",\"sortValue\":1,\"component\":\"vod/teacher/list\",\"param\":{},\"name\":\"讲师列表\",\"perms\":\"\",\"id\":36,\"status\":1}', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-06-10 15:27:38', NULL, 0);
INSERT INTO `sys_oper_log` VALUES (61, '菜单管理', 'INSERT', 'com.gec.system.controller.SysMenuController.save()', 'POST', 'MANAGE', 'admin', '', '/admin/system/sysMenu/save', '127.0.0.1', '{\"select\":false,\"icon\":\"\",\"type\":2,\"parentId\":36,\"path\":\"teacher/create\",\"sortValue\":1,\"component\":\"vod/teacher/form\",\"param\":{},\"name\":\"添加\",\"perms\":\"bnt.teacher.add\",\"id\":37,\"status\":1}', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-06-10 15:28:27', NULL, 0);
INSERT INTO `sys_oper_log` VALUES (62, '菜单管理', 'INSERT', 'com.gec.system.controller.SysMenuController.save()', 'POST', 'MANAGE', 'admin', '', '/admin/system/sysMenu/save', '127.0.0.1', '{\"select\":false,\"icon\":\"\",\"type\":2,\"parentId\":36,\"path\":\"teacher/edit/:id\",\"sortValue\":1,\"component\":\"vod/teacher/form\",\"param\":{},\"name\":\"修改\",\"perms\":\"bnt.teacher.update\",\"id\":38,\"status\":1}', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-06-10 15:29:13', NULL, 0);
INSERT INTO `sys_oper_log` VALUES (63, '菜单管理', 'INSERT', 'com.gec.system.controller.SysMenuController.save()', 'POST', 'MANAGE', 'admin', '', '/admin/system/sysMenu/save', '127.0.0.1', '{\"select\":false,\"icon\":\"\",\"type\":2,\"parentId\":36,\"path\":\"\",\"sortValue\":1,\"component\":\"\",\"param\":{},\"name\":\"查看\",\"perms\":\"bnt.teacher.list\",\"id\":39,\"status\":1}', '{\"code\":200,\"message\":\"成功\"}', 1, '', NULL, '2022-06-10 15:35:30', NULL, 0);

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
                             `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
                             `post_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '岗位编码',
                             `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '岗位名称',
                             `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '描述',
                             `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '状态（1正常 0停用）',
                             `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
                             `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
                             `is_deleted` tinyint(0) NOT NULL DEFAULT 0 COMMENT '删除标记（0:可用 1:已删除）',
                             PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '岗位信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (5, 'dsz', '董事长', '1', 1, '2022-05-24 10:33:53', NULL, 0);
INSERT INTO `sys_post` VALUES (6, 'zjl', '总经理', '2', 1, '2022-05-24 10:34:08', NULL, 0);
INSERT INTO `sys_post` VALUES (7, 'wz', '网咨', '', 1, '2022-05-27 08:56:41', '2022-05-27 08:56:41', 1);
INSERT INTO `sys_post` VALUES (8, 'yyzj', '运营总监', '', 1, '2022-06-08 17:14:21', NULL, 0);

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
                             `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '角色id',
                             `role_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '角色名称',
                             `role_code` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色编码',
                             `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
                             `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
                             `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
                             `is_deleted` tinyint(0) NOT NULL DEFAULT 0 COMMENT '删除标记（0:可用 1:已删除）',
                             PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, 'system管理员', 'SYSTEM', 'admin', '2021-05-31 18:09:18', '2022-12-27 10:18:47', 0);
INSERT INTO `sys_role` VALUES (2, '普通管理员', 'COMMON', '普通管理员', '2021-06-01 08:38:40', '2022-02-24 10:42:46', 0);
INSERT INTO `sys_role` VALUES (8, '用户管理员', 'yhgly', NULL, '2022-06-08 17:39:04', '2022-06-08 17:39:04', 0);
INSERT INTO `sys_role` VALUES (9, '大飞管理员', 'dafei', 'dafei', NULL, NULL, 0);
INSERT INTO `sys_role` VALUES (10, '大飞管理员2', 'dafei2', 'dafei2', '2022-12-26 15:53:38', NULL, 0);
INSERT INTO `sys_role` VALUES (11, '账务', 'caiwu', '测试账号', '2022-12-27 10:15:04', '2023-06-13 21:01:31', 0);
INSERT INTO `sys_role` VALUES (12, 'aa', 'aa', NULL, '2022-12-30 16:38:51', NULL, 0);
INSERT INTO `sys_role` VALUES (13, 'bb', 'bb', 'manager', '2022-12-30 16:39:06', '2023-06-12 00:27:54', 0);
INSERT INTO `sys_role` VALUES (14, '周杰伦', 'testadmin', '测试账号', '2023-06-12 00:25:30', '2023-06-12 23:32:32', 0);
INSERT INTO `sys_role` VALUES (15, '林俊杰', 'lingjunjie', '江南', '2023-06-12 23:36:32', NULL, 0);
INSERT INTO `sys_role` VALUES (16, '张译', 'zhangyi', '狂飙', '2023-06-12 23:38:04', '2023-06-14 22:11:40', 0);
INSERT INTO `sys_role` VALUES (17, '老板', 'bigboss', '雷军', '2023-06-13 20:39:51', '2023-06-14 22:20:05', 0);
INSERT INTO `sys_role` VALUES (18, '明星', '王心凌6', NULL, '2023-06-14 21:52:17', '2023-06-14 23:57:58', 0);
INSERT INTO `sys_role` VALUES (19, '11', '222', NULL, '2023-06-14 23:58:07', NULL, 0);
INSERT INTO `sys_role` VALUES (20, 'xixi', '300', '测试用的666', '2023-06-16 09:18:18', '2023-06-16 10:32:17', 0);
INSERT INTO `sys_role` VALUES (21, '测试2', '300', '测试用的2', '2023-06-16 10:29:23', NULL, 0);
INSERT INTO `sys_role` VALUES (22, '助理经理', 'zhuli', '测试经理', '2023-06-18 08:45:43', '2023-06-18 08:52:08', 0);
INSERT INTO `sys_role` VALUES (23, '账务', 'qian', NULL, '2023-06-19 08:48:36', '2023-06-19 08:59:02', 0);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
                                  `id` bigint(0) NOT NULL AUTO_INCREMENT,
                                  `role_id` bigint(0) NOT NULL DEFAULT 0,
                                  `menu_id` bigint(0) NOT NULL DEFAULT 0,
                                  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
                                  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
                                  `is_deleted` tinyint(0) NOT NULL DEFAULT 0 COMMENT '删除标记（0:可用 1:已删除）',
                                  PRIMARY KEY (`id`) USING BTREE,
                                  INDEX `idx_role_id`(`role_id`) USING BTREE,
                                  INDEX `idx_menu_id`(`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 235 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色菜单' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (1, 2, 2, '2022-06-02 16:11:27', '2022-06-02 16:16:10', 1);
INSERT INTO `sys_role_menu` VALUES (2, 2, 3, '2022-06-02 16:11:27', '2022-06-02 16:16:10', 1);
INSERT INTO `sys_role_menu` VALUES (3, 2, 6, '2022-06-02 16:11:27', '2022-06-02 16:16:10', 1);
INSERT INTO `sys_role_menu` VALUES (4, 2, 7, '2022-06-02 16:11:27', '2022-06-02 16:16:10', 1);
INSERT INTO `sys_role_menu` VALUES (5, 2, 8, '2022-06-02 16:11:27', '2022-06-02 16:16:10', 1);
INSERT INTO `sys_role_menu` VALUES (6, 2, 9, '2022-06-02 16:11:27', '2022-06-02 16:16:10', 1);
INSERT INTO `sys_role_menu` VALUES (7, 2, 18, '2022-06-02 16:11:27', '2022-06-02 16:16:10', 1);
INSERT INTO `sys_role_menu` VALUES (8, 2, 4, '2022-06-02 16:11:27', '2022-06-02 16:16:10', 1);
INSERT INTO `sys_role_menu` VALUES (9, 2, 10, '2022-06-02 16:11:27', '2022-06-02 16:16:10', 1);
INSERT INTO `sys_role_menu` VALUES (10, 2, 11, '2022-06-02 16:11:27', '2022-06-02 16:16:10', 1);
INSERT INTO `sys_role_menu` VALUES (11, 2, 12, '2022-06-02 16:11:27', '2022-06-02 16:16:10', 1);
INSERT INTO `sys_role_menu` VALUES (12, 2, 13, '2022-06-02 16:11:27', '2022-06-02 16:16:10', 1);
INSERT INTO `sys_role_menu` VALUES (13, 2, 19, '2022-06-02 16:11:27', '2022-06-02 16:16:10', 1);
INSERT INTO `sys_role_menu` VALUES (14, 2, 5, '2022-06-02 16:11:27', '2022-06-02 16:16:10', 1);
INSERT INTO `sys_role_menu` VALUES (15, 2, 14, '2022-06-02 16:11:27', '2022-06-02 16:16:10', 1);
INSERT INTO `sys_role_menu` VALUES (16, 2, 15, '2022-06-02 16:11:27', '2022-06-02 16:16:10', 1);
INSERT INTO `sys_role_menu` VALUES (17, 2, 16, '2022-06-02 16:11:27', '2022-06-02 16:16:10', 1);
INSERT INTO `sys_role_menu` VALUES (18, 2, 17, '2022-06-02 16:11:27', '2022-06-02 16:16:10', 1);
INSERT INTO `sys_role_menu` VALUES (19, 2, 2, '2022-06-02 16:16:10', '2022-06-09 09:26:34', 1);
INSERT INTO `sys_role_menu` VALUES (20, 2, 3, '2022-06-02 16:16:10', '2022-06-09 09:26:34', 1);
INSERT INTO `sys_role_menu` VALUES (21, 2, 6, '2022-06-02 16:16:10', '2022-06-09 09:26:34', 1);
INSERT INTO `sys_role_menu` VALUES (22, 2, 7, '2022-06-02 16:16:10', '2022-06-09 09:26:34', 1);
INSERT INTO `sys_role_menu` VALUES (23, 2, 8, '2022-06-02 16:16:10', '2022-06-09 09:26:34', 1);
INSERT INTO `sys_role_menu` VALUES (24, 2, 2, '2022-06-09 09:26:34', '2022-06-09 09:26:34', 1);
INSERT INTO `sys_role_menu` VALUES (25, 2, 3, '2022-06-09 09:26:34', '2022-06-09 09:26:34', 1);
INSERT INTO `sys_role_menu` VALUES (26, 2, 6, '2022-06-09 09:26:34', '2022-06-09 09:26:34', 1);
INSERT INTO `sys_role_menu` VALUES (27, 2, 7, '2022-06-09 09:26:34', '2022-06-09 09:26:34', 1);
INSERT INTO `sys_role_menu` VALUES (28, 2, 8, '2022-06-09 09:26:34', '2022-06-09 09:26:34', 1);
INSERT INTO `sys_role_menu` VALUES (29, 2, 5, '2022-06-09 09:26:34', '2022-06-09 09:26:34', 1);
INSERT INTO `sys_role_menu` VALUES (30, 2, 14, '2022-06-09 09:26:34', '2022-06-09 09:26:34', 1);
INSERT INTO `sys_role_menu` VALUES (31, 2, 20, '2022-06-09 09:26:34', '2022-06-09 09:26:34', 1);
INSERT INTO `sys_role_menu` VALUES (32, 2, 21, '2022-06-09 09:26:34', '2022-06-09 09:26:34', 1);
INSERT INTO `sys_role_menu` VALUES (33, 21, 2, '2023-01-06 17:47:58', NULL, 0);
INSERT INTO `sys_role_menu` VALUES (34, 21, 3, '2023-01-06 17:47:58', NULL, 0);
INSERT INTO `sys_role_menu` VALUES (35, 21, 6, '2023-01-06 17:47:58', NULL, 0);
INSERT INTO `sys_role_menu` VALUES (36, 21, 7, '2023-01-06 17:47:58', NULL, 0);
INSERT INTO `sys_role_menu` VALUES (37, 21, 8, '2023-01-06 17:47:58', NULL, 0);
INSERT INTO `sys_role_menu` VALUES (38, 21, 9, '2023-01-06 17:47:58', NULL, 0);
INSERT INTO `sys_role_menu` VALUES (39, 21, 18, '2023-01-06 17:47:58', NULL, 0);
INSERT INTO `sys_role_menu` VALUES (40, 22, 2, '2023-01-14 12:05:53', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (41, 22, 3, '2023-01-14 12:05:53', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (42, 22, 6, '2023-01-14 12:05:53', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (43, 22, 8, '2023-01-14 12:05:53', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (44, 22, 9, '2023-01-14 12:05:53', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (45, 22, 18, '2023-01-14 12:05:53', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (46, 22, 2, '2023-01-14 17:05:38', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (47, 22, 4, '2023-01-14 17:05:38', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (48, 22, 10, '2023-01-14 17:05:38', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (49, 22, 11, '2023-01-14 17:05:38', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (50, 22, 12, '2023-01-14 17:05:38', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (51, 22, 19, '2023-01-14 17:05:38', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (52, 22, 2, '2023-01-14 17:37:05', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (53, 22, 3, '2023-01-14 17:37:05', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (54, 22, 6, '2023-01-14 17:37:05', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (55, 22, 7, '2023-01-14 17:37:05', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (56, 22, 8, '2023-01-14 17:37:05', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (57, 22, 9, '2023-01-14 17:37:05', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (58, 22, 18, '2023-01-14 17:37:05', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (59, 22, 4, '2023-01-14 17:37:05', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (60, 22, 10, '2023-01-14 17:37:05', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (61, 22, 11, '2023-01-14 17:37:05', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (62, 22, 12, '2023-01-14 17:37:05', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (63, 22, 13, '2023-01-14 17:37:05', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (64, 22, 19, '2023-01-14 17:37:05', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (65, 22, 5, '2023-01-14 17:37:05', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (66, 22, 14, '2023-01-14 17:37:05', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (67, 22, 15, '2023-01-14 17:37:05', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (68, 22, 16, '2023-01-14 17:37:05', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (69, 22, 17, '2023-01-14 17:37:05', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (70, 22, 34, '2023-01-14 17:37:05', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (71, 22, 30, '2023-01-14 17:37:05', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (72, 22, 31, '2023-01-14 17:37:05', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (73, 22, 32, '2023-01-14 17:37:05', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (74, 22, 33, '2023-01-14 17:37:05', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (75, 22, 36, '2023-01-14 17:37:05', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (76, 22, 2, '2023-01-18 20:33:47', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (77, 22, 3, '2023-01-18 20:33:47', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (78, 22, 6, '2023-01-18 20:33:47', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (79, 22, 7, '2023-01-18 20:33:47', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (80, 22, 8, '2023-01-18 20:33:47', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (81, 22, 9, '2023-01-18 20:33:47', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (82, 22, 18, '2023-01-18 20:33:47', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (83, 22, 4, '2023-01-18 20:33:47', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (84, 22, 10, '2023-01-18 20:33:47', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (85, 22, 11, '2023-01-18 20:33:47', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (86, 22, 12, '2023-01-18 20:33:47', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (87, 22, 13, '2023-01-18 20:33:47', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (88, 22, 19, '2023-01-18 20:33:47', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (89, 22, 5, '2023-01-18 20:33:47', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (90, 22, 14, '2023-01-18 20:33:47', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (91, 22, 15, '2023-01-18 20:33:47', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (92, 22, 16, '2023-01-18 20:33:47', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (93, 22, 17, '2023-01-18 20:33:47', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (94, 22, 34, '2023-01-18 20:33:47', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (95, 22, 30, '2023-01-18 20:33:47', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (96, 22, 31, '2023-01-18 20:33:47', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (97, 22, 32, '2023-01-18 20:33:47', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (98, 22, 33, '2023-01-18 20:33:47', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (99, 22, 2, '2023-01-18 21:41:03', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (100, 22, 3, '2023-01-18 21:41:03', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (101, 22, 6, '2023-01-18 21:41:03', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (102, 22, 7, '2023-01-18 21:41:03', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (103, 22, 8, '2023-01-18 21:41:03', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (104, 22, 9, '2023-01-18 21:41:03', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (105, 22, 18, '2023-01-18 21:41:03', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (106, 22, 4, '2023-01-18 21:41:03', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (107, 22, 10, '2023-01-18 21:41:03', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (108, 22, 11, '2023-01-18 21:41:03', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (109, 22, 12, '2023-01-18 21:41:03', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (110, 22, 13, '2023-01-18 21:41:03', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (111, 22, 19, '2023-01-18 21:41:03', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (112, 22, 5, '2023-01-18 21:41:03', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (113, 22, 14, '2023-01-18 21:41:03', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (114, 22, 15, '2023-01-18 21:41:03', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (115, 22, 16, '2023-01-18 21:41:03', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (116, 22, 17, '2023-01-18 21:41:03', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (117, 22, 34, '2023-01-18 21:41:03', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (118, 22, 30, '2023-01-18 21:41:03', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (119, 22, 31, '2023-01-18 21:41:03', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (120, 22, 32, '2023-01-18 21:41:03', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (121, 22, 33, '2023-01-18 21:41:03', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (122, 22, 2, '2023-01-18 21:41:39', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (123, 22, 3, '2023-01-18 21:41:39', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (124, 22, 6, '2023-01-18 21:41:39', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (125, 22, 7, '2023-01-18 21:41:39', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (126, 22, 8, '2023-01-18 21:41:39', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (127, 22, 9, '2023-01-18 21:41:39', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (128, 22, 18, '2023-01-18 21:41:39', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (129, 22, 4, '2023-01-18 21:41:39', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (130, 22, 10, '2023-01-18 21:41:39', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (131, 22, 11, '2023-01-18 21:41:39', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (132, 22, 12, '2023-01-18 21:41:39', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (133, 22, 13, '2023-01-18 21:41:39', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (134, 22, 19, '2023-01-18 21:41:39', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (135, 22, 5, '2023-01-18 21:41:39', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (136, 22, 14, '2023-01-18 21:41:39', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (137, 22, 15, '2023-01-18 21:41:39', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (138, 22, 16, '2023-01-18 21:41:39', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (139, 22, 17, '2023-01-18 21:41:39', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (140, 22, 34, '2023-01-18 21:41:39', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (141, 22, 30, '2023-01-18 21:41:39', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (142, 22, 31, '2023-01-18 21:41:39', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (143, 22, 32, '2023-01-18 21:41:39', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (144, 22, 33, '2023-01-18 21:41:39', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (145, 22, 38, '2023-01-18 21:41:39', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (146, 22, 2, '2023-01-18 21:42:04', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (147, 22, 3, '2023-01-18 21:42:04', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (148, 22, 6, '2023-01-18 21:42:04', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (149, 22, 9, '2023-01-18 21:42:04', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (150, 22, 18, '2023-01-18 21:42:04', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (151, 22, 4, '2023-01-18 21:42:04', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (152, 22, 10, '2023-01-18 21:42:04', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (153, 22, 11, '2023-01-18 21:42:04', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (154, 22, 12, '2023-01-18 21:42:04', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (155, 22, 13, '2023-01-18 21:42:04', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (156, 22, 19, '2023-01-18 21:42:04', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (157, 22, 5, '2023-01-18 21:42:04', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (158, 22, 14, '2023-01-18 21:42:04', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (159, 22, 15, '2023-01-18 21:42:04', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (160, 22, 16, '2023-01-18 21:42:04', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (161, 22, 17, '2023-01-18 21:42:04', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (162, 22, 34, '2023-01-18 21:42:04', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (163, 22, 30, '2023-01-18 21:42:04', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (164, 22, 31, '2023-01-18 21:42:04', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (165, 22, 36, '2023-01-18 21:42:04', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (166, 22, 37, '2023-01-18 21:42:04', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (167, 22, 38, '2023-01-18 21:42:04', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (168, 22, 2, '2023-01-18 21:48:46', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (169, 22, 3, '2023-01-18 21:48:46', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (170, 22, 6, '2023-01-18 21:48:46', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (171, 22, 18, '2023-01-18 21:48:46', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (172, 22, 4, '2023-01-18 21:48:46', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (173, 22, 10, '2023-01-18 21:48:46', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (174, 22, 11, '2023-01-18 21:48:46', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (175, 22, 12, '2023-01-18 21:48:46', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (176, 22, 13, '2023-01-18 21:48:46', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (177, 22, 19, '2023-01-18 21:48:46', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (178, 22, 5, '2023-01-18 21:48:46', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (179, 22, 14, '2023-01-18 21:48:46', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (180, 22, 15, '2023-01-18 21:48:46', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (181, 22, 16, '2023-01-18 21:48:46', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (182, 22, 17, '2023-01-18 21:48:46', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (183, 22, 34, '2023-01-18 21:48:46', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (184, 22, 30, '2023-01-18 21:48:46', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (185, 22, 31, '2023-01-18 21:48:46', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (186, 22, 36, '2023-01-18 21:48:46', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (187, 22, 37, '2023-01-18 21:48:46', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (188, 22, 38, '2023-01-18 21:48:46', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (189, 2, 2, '2023-01-18 21:50:42', NULL, 0);
INSERT INTO `sys_role_menu` VALUES (190, 2, 3, '2023-01-18 21:50:42', NULL, 0);
INSERT INTO `sys_role_menu` VALUES (191, 2, 6, '2023-01-18 21:50:42', NULL, 0);
INSERT INTO `sys_role_menu` VALUES (192, 2, 7, '2023-01-18 21:50:42', NULL, 0);
INSERT INTO `sys_role_menu` VALUES (193, 22, 2, '2023-01-18 21:54:53', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (194, 22, 3, '2023-01-18 21:54:53', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (195, 22, 6, '2023-01-18 21:54:53', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (196, 22, 7, '2023-01-18 21:54:53', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (197, 22, 8, '2023-01-18 21:54:53', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (198, 22, 9, '2023-01-18 21:54:53', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (199, 22, 18, '2023-01-18 21:54:53', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (200, 22, 5, '2023-01-18 21:54:53', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (201, 22, 14, '2023-01-18 21:54:53', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (202, 22, 15, '2023-01-18 21:54:53', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (203, 22, 16, '2023-01-18 21:54:53', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (204, 22, 17, '2023-01-18 21:54:53', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (205, 22, 34, '2023-01-18 21:54:53', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (206, 22, 30, '2023-01-18 21:54:53', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (207, 22, 31, '2023-01-18 21:54:53', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (208, 22, 32, '2023-01-18 21:54:53', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (209, 22, 33, '2023-01-18 21:54:53', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (210, 22, 36, '2023-01-18 21:54:53', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (211, 22, 37, '2023-01-18 21:54:53', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (212, 22, 38, '2023-01-18 21:54:53', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (213, 22, 2, '2023-01-18 21:55:41', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (214, 22, 3, '2023-01-18 21:55:41', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (215, 22, 6, '2023-01-18 21:55:41', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (216, 22, 7, '2023-01-18 21:55:41', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (217, 22, 8, '2023-01-18 21:55:41', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (218, 22, 9, '2023-01-18 21:55:41', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (219, 22, 18, '2023-01-18 21:55:41', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (220, 22, 4, '2023-01-18 21:55:41', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (221, 22, 10, '2023-01-18 21:55:41', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (222, 22, 5, '2023-01-18 21:55:41', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (223, 22, 14, '2023-01-18 21:55:41', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (224, 22, 15, '2023-01-18 21:55:41', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (225, 22, 16, '2023-01-18 21:55:41', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (226, 22, 17, '2023-01-18 21:55:41', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (227, 22, 34, '2023-01-18 21:55:41', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (228, 22, 30, '2023-01-18 21:55:41', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (229, 22, 31, '2023-01-18 21:55:41', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (230, 22, 32, '2023-01-18 21:55:41', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (231, 22, 33, '2023-01-18 21:55:41', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (232, 22, 36, '2023-01-18 21:55:41', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (233, 22, 37, '2023-01-18 21:55:41', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (234, 22, 38, '2023-01-18 21:55:41', NULL, 1);
INSERT INTO `sys_role_menu` VALUES (235, 22, 2, '2023-06-19 06:24:57', NULL, 0);
INSERT INTO `sys_role_menu` VALUES (236, 22, 3, '2023-06-19 06:24:57', NULL, 0);
INSERT INTO `sys_role_menu` VALUES (237, 22, 7, '2023-06-19 06:24:57', NULL, 0);
INSERT INTO `sys_role_menu` VALUES (238, 22, 8, '2023-06-19 06:24:57', NULL, 0);
INSERT INTO `sys_role_menu` VALUES (239, 22, 18, '2023-06-19 06:24:57', NULL, 0);
INSERT INTO `sys_role_menu` VALUES (240, 22, 4, '2023-06-19 06:24:57', NULL, 0);
INSERT INTO `sys_role_menu` VALUES (241, 22, 10, '2023-06-19 06:24:57', NULL, 0);
INSERT INTO `sys_role_menu` VALUES (242, 22, 5, '2023-06-19 06:24:57', NULL, 0);
INSERT INTO `sys_role_menu` VALUES (243, 22, 14, '2023-06-19 06:24:57', NULL, 0);
INSERT INTO `sys_role_menu` VALUES (244, 22, 15, '2023-06-19 06:24:57', NULL, 0);
INSERT INTO `sys_role_menu` VALUES (245, 22, 16, '2023-06-19 06:24:57', NULL, 0);
INSERT INTO `sys_role_menu` VALUES (246, 22, 17, '2023-06-19 06:24:57', NULL, 0);
INSERT INTO `sys_role_menu` VALUES (247, 22, 36, '2023-06-19 06:24:57', NULL, 0);
INSERT INTO `sys_role_menu` VALUES (248, 22, 37, '2023-06-19 06:24:57', NULL, 0);
INSERT INTO `sys_role_menu` VALUES (249, 22, 38, '2023-06-19 06:24:57', NULL, 0);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
                             `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '会员id',
                             `username` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '用户名',
                             `password` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '密码',
                             `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '姓名',
                             `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '手机',
                             `head_url` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '头像地址',
                             `dept_id` bigint(0) NULL DEFAULT NULL COMMENT '部门id',
                             `post_id` bigint(0) NULL DEFAULT NULL COMMENT '岗位id',
                             `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '描述',
                             `status` tinyint(0) NULL DEFAULT 1 COMMENT '状态（1：正常 0：停用）',
                             `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
                             `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
                             `is_deleted` tinyint(0) NOT NULL DEFAULT 0 COMMENT '删除标记（0:可用 1:已删除）',
                             PRIMARY KEY (`id`) USING BTREE,
                             UNIQUE INDEX `idx_username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 'admin', '96e79218965eb72c92a549dd5a330112', '管理员', '15099909888', 'http://r61cnlsfq.hn-bkt.clouddn.com/7daa4595-dfde-45da-8513-c5c2b81d20cc', 1021, 5, NULL, 1, '2021-05-31 18:08:43', '2022-05-25 11:34:25', 0);
INSERT INTO `sys_user` VALUES (2, 'xiaoli', '96e79218965eb72c92a549dd5a330112', '小李', '15010546381', 'http://r61cnlsfq.hn-bkt.clouddn.com/b09b3467-3d99-437a-bd2e-dd8c9be92bb8', 1022, 6, NULL, 1, '2022-02-08 10:35:38', '2022-05-25 15:58:31', 0);
INSERT INTO `sys_user` VALUES (3, 'fengdagang', '96e79218965eb72c92a549dd5a330112', '冯大刚', '18909098909', NULL, 1024, 5, NULL, 1, '2022-05-24 11:05:40', '2022-06-02 10:19:25', 0);
INSERT INTO `sys_user` VALUES (4, 'huangdaxi', '96e79218965eb72c92a549dd5a330112', '黄大西', '15010546381', '', 1021, 3, '', 0, '2023-01-03 22:19:21', NULL, 0);
INSERT INTO `sys_user` VALUES (5, 'test用户2', '123456', '测试用户', '13212345678', NULL, NULL, NULL, NULL, 1, '2023-01-05 16:24:34', '2023-01-18 21:47:46', 0);
INSERT INTO `sys_user` VALUES (6, 'dafei2022', 'e10adc3949ba59abbe56e057f20f883e', 'dafei2022', '132', NULL, NULL, NULL, NULL, 1, '2023-01-14 12:04:53', '2023-01-18 21:49:13', 0);
INSERT INTO `sys_user` VALUES (7, 'ceshi123', '059d38a8c888d5109fa33a9815866013', '嘻嘻', '123456', NULL, NULL, NULL, NULL, 1, '2023-01-18 21:50:03', '2023-06-15 23:49:55', 0);
INSERT INTO `sys_user` VALUES (8, 'haha', '123456', '哈哈', '110', NULL, NULL, NULL, NULL, 0, '2023-06-15 23:29:23', '2023-06-16 00:31:16', 0);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
                                  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键id',
                                  `role_id` bigint(0) NOT NULL DEFAULT 0 COMMENT '角色id',
                                  `user_id` bigint(0) NOT NULL DEFAULT 0 COMMENT '用户id',
                                  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
                                  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
                                  `is_deleted` tinyint(0) NOT NULL DEFAULT 0 COMMENT '删除标记（0:可用 1:已删除）',
                                  PRIMARY KEY (`id`) USING BTREE,
                                  INDEX `idx_role_id`(`role_id`) USING BTREE,
                                  INDEX `idx_admin_id`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 48 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户角色' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (11, 2, 5, '2023-01-06 11:48:43', NULL, 1);
INSERT INTO `sys_user_role` VALUES (12, 1, 4, '2023-01-06 11:50:17', NULL, 1);
INSERT INTO `sys_user_role` VALUES (13, 2, 4, '2023-01-06 11:50:17', NULL, 1);
INSERT INTO `sys_user_role` VALUES (14, 8, 4, '2023-01-06 11:50:17', NULL, 1);
INSERT INTO `sys_user_role` VALUES (15, 9, 4, '2023-01-06 11:50:17', NULL, 1);
INSERT INTO `sys_user_role` VALUES (16, 10, 4, '2023-01-06 11:50:17', NULL, 1);
INSERT INTO `sys_user_role` VALUES (17, 11, 4, '2023-01-06 11:50:17', NULL, 1);
INSERT INTO `sys_user_role` VALUES (18, 12, 4, '2023-01-06 11:50:17', NULL, 1);
INSERT INTO `sys_user_role` VALUES (19, 2, 4, '2023-01-06 11:50:45', NULL, 1);
INSERT INTO `sys_user_role` VALUES (20, 8, 4, '2023-01-06 11:50:45', NULL, 1);
INSERT INTO `sys_user_role` VALUES (21, 9, 4, '2023-01-06 11:50:45', NULL, 1);
INSERT INTO `sys_user_role` VALUES (22, 10, 4, '2023-01-06 11:50:45', NULL, 1);
INSERT INTO `sys_user_role` VALUES (23, 11, 4, '2023-01-06 11:50:45', NULL, 1);
INSERT INTO `sys_user_role` VALUES (24, 12, 4, '2023-01-06 11:50:45', NULL, 1);
INSERT INTO `sys_user_role` VALUES (25, 22, 6, '2023-01-14 12:05:36', NULL, 1);
INSERT INTO `sys_user_role` VALUES (26, 1, 1, '2023-01-14 17:36:49', NULL, 0);
INSERT INTO `sys_user_role` VALUES (27, 2, 1, '2023-01-14 17:36:49', NULL, 0);
INSERT INTO `sys_user_role` VALUES (28, 8, 1, '2023-01-14 17:36:49', NULL, 0);
INSERT INTO `sys_user_role` VALUES (29, 9, 1, '2023-01-14 17:36:49', NULL, 0);
INSERT INTO `sys_user_role` VALUES (30, 10, 1, '2023-01-14 17:36:49', NULL, 0);
INSERT INTO `sys_user_role` VALUES (31, 11, 1, '2023-01-14 17:36:49', NULL, 0);
INSERT INTO `sys_user_role` VALUES (32, 12, 1, '2023-01-14 17:36:49', NULL, 0);
INSERT INTO `sys_user_role` VALUES (33, 21, 1, '2023-01-14 17:36:49', NULL, 0);
INSERT INTO `sys_user_role` VALUES (34, 22, 1, '2023-01-14 17:36:49', NULL, 0);
INSERT INTO `sys_user_role` VALUES (35, 22, 6, '2023-01-18 20:33:38', NULL, 1);
INSERT INTO `sys_user_role` VALUES (36, 22, 6, '2023-01-18 21:43:09', NULL, 0);
INSERT INTO `sys_user_role` VALUES (37, 2, 7, '2023-01-18 21:50:16', NULL, 1);
INSERT INTO `sys_user_role` VALUES (38, 2, 5, '2023-01-18 21:51:38', NULL, 0);
INSERT INTO `sys_user_role` VALUES (39, 22, 7, '2023-01-18 21:54:38', NULL, 1);
INSERT INTO `sys_user_role` VALUES (40, 22, 7, '2023-02-02 17:39:46', NULL, 0);
INSERT INTO `sys_user_role` VALUES (41, 2, 7, '2023-02-02 17:39:46', NULL, 0);
INSERT INTO `sys_user_role` VALUES (42, 21, 7, '2023-02-02 17:39:46', NULL, 0);
INSERT INTO `sys_user_role` VALUES (43, 2, 4, '2023-06-17 22:41:32', NULL, 0);
INSERT INTO `sys_user_role` VALUES (44, 8, 4, '2023-06-17 22:41:32', NULL, 0);
INSERT INTO `sys_user_role` VALUES (45, 9, 4, '2023-06-17 22:41:32', NULL, 0);
INSERT INTO `sys_user_role` VALUES (46, 10, 4, '2023-06-17 22:41:32', NULL, 0);
INSERT INTO `sys_user_role` VALUES (47, 11, 4, '2023-06-17 22:41:32', NULL, 0);
INSERT INTO `sys_user_role` VALUES (48, 18, 4, '2023-06-17 22:41:32', NULL, 0);

SET FOREIGN_KEY_CHECKS = 1;
