/*
 Navicat Premium Dump SQL

 Source Server         : MySQL@CentOS(Docker) Mall
 Source Server Type    : MySQL
 Source Server Version : 50744 (5.7.44-log)
 Source Host           : 192.168.11.4:3306
 Source Schema         : shop_goods

 Target Server Type    : MySQL
 Target Server Version : 50744 (5.7.44-log)
 File Encoding         : 65001

 Date: 01/04/2025 18:52:12
*/

-- 使用数据库 shop_goods
USE `shop_goods`;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for ad_items
-- ----------------------------
DROP TABLE IF EXISTS `ad_items`;
CREATE TABLE `ad_items`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `type` int(3) NULL DEFAULT NULL COMMENT '分类，1首页推广,2列表页推广',
  `sku_id` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '展示的产品',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 123 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ad_items
-- ----------------------------
INSERT INTO `ad_items` VALUES (4, 'ww', 2, '1319051488282112002', 5);
INSERT INTO `ad_items` VALUES (5, '33', 1, '1319051488298889217', 6);
INSERT INTO `ad_items` VALUES (6, '33', 1, '1318596430398562305', 7);
INSERT INTO `ad_items` VALUES (7, '11', 1, '1318596430360813570', 7);
INSERT INTO `ad_items` VALUES (11, '2324', 1, '1318594982227025922', 8);
INSERT INTO `ad_items` VALUES (122, '123', 1, '1318594982227025922', 11);

-- ----------------------------
-- Table structure for brand
-- ----------------------------
DROP TABLE IF EXISTS `brand`;
CREATE TABLE `brand`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '品牌id',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '品牌名称',
  `image` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '品牌图片地址',
  `initial` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '品牌的首字母',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '品牌表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of brand
-- ----------------------------
INSERT INTO `brand` VALUES (17, '苹果', 'http://192.168.11.4:9000/mall/20250315/cfd56467-5dcf-4b97-be36-568ba2094f82-574d36dbN262ef26d.jpg.avif', 'A', 0);
INSERT INTO `brand` VALUES (18, '小米', 'http://192.168.11.4:9000/mall/20250315/abafe635-eff9-489a-8c46-d0b2981ee2e4-e84d202cc34091a5.jpg.avif', 'X', 0);
INSERT INTO `brand` VALUES (19, '华为', 'http://192.168.11.4:9000/mall/20250315/27ec1c53-dc30-4369-b6c0-8ed76643a1f5-62b97e5188766c42.png.avif', 'H', 0);
INSERT INTO `brand` VALUES (20, 'OPPO', 'http://192.168.11.4:9000/mall/20250315/7f8ce156-faf5-49cd-8e1a-348e9c6c0d8f-33ffbca794e7b965.jpg.avif', 'O', 0);
INSERT INTO `brand` VALUES (21, 'VIVO', 'http://192.168.11.4:9000/mall/20250315/2bdeb184-cc7d-4a0d-9aa2-7eeaa1eaf5e8-0dfceda9f7809bb5.jpg.avif', 'V', 0);
INSERT INTO `brand` VALUES (22, '荣耀', 'http://192.168.11.4:9000/mall/20250315/9261dd97-41c6-4d01-85ba-0c88d0d82005-55af9759d5e9d78a.jpg.avif', 'R', 0);
INSERT INTO `brand` VALUES (23, '中兴', 'http://192.168.11.4:9000/mall/20250315/edd5dd35-0ced-4d50-bc04-709c66129e96-b9ea1c771f750731.png.avif', 'Z', 0);
INSERT INTO `brand` VALUES (24, '真我', 'http://192.168.11.4:9000/mall/20250315/1ea484a6-8288-4bdb-9f86-d896fbd35104-13726aee4db80304.jpg.avif', 'Z', 0);
INSERT INTO `brand` VALUES (25, 'IQOO', 'http://192.168.11.4:9000/mall/20250315/a75f0766-f036-49dc-8f4b-7146b54d0e8c-76e7e84ece7ea070.jpg.avif', 'I', 0);
INSERT INTO `brand` VALUES (26, '魅族', 'http://192.168.11.4:9000/mall/20250315/9ca19447-0355-4987-901b-c82dce35c847-a2a7699144c41515.png.avif', 'M', 0);
INSERT INTO `brand` VALUES (27, '一加', 'http://192.168.11.4:9000/mall/20250315/a8208507-2d29-4ffc-8eb2-6a38731318c4-a88c6da3ad04ffa5.jpg.avif', 'Y', 0);
INSERT INTO `brand` VALUES (28, '手机', 'http://192.168.11.4:9000/mall/20250401/059e0d9d-ebb2-4dbb-af66-50d9f30c7b8c-7a7b8771e3d6457686f0f10819c4f82c.png', 'S', 0);

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `id` int(20) NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分类名称',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序',
  `parent_id` int(20) NULL DEFAULT NULL COMMENT '上级ID',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `parent_id`(`parent_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11213 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商品类目' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (1081, '速干衣裤', 1, 1079);
INSERT INTO `category` VALUES (1082, '滑雪服', 1, 1079);
INSERT INTO `category` VALUES (1083, '羽绒服/棉服', 1, 1079);
INSERT INTO `category` VALUES (1084, '休闲衣裤', 1, 1079);
INSERT INTO `category` VALUES (1085, '抓绒衣裤', 1, 1079);
INSERT INTO `category` VALUES (1086, '软壳衣裤', 1, 1079);
INSERT INTO `category` VALUES (1087, 'T恤', 1, 1079);
INSERT INTO `category` VALUES (1088, '户外风衣', 1, 1079);
INSERT INTO `category` VALUES (1089, '功能内衣', 1, 1079);
INSERT INTO `category` VALUES (1090, '军迷服饰', 1, 1079);
INSERT INTO `category` VALUES (1091, '登山鞋', 1, 1079);
INSERT INTO `category` VALUES (1092, '雪地靴', 1, 1079);
INSERT INTO `category` VALUES (1093, '徒步鞋', 1, 1079);
INSERT INTO `category` VALUES (1094, '越野跑鞋', 1, 1079);
INSERT INTO `category` VALUES (1095, '休闲鞋', 1, 1079);
INSERT INTO `category` VALUES (1096, '工装鞋', 1, 1079);
INSERT INTO `category` VALUES (1097, '溯溪鞋', 1, 1079);
INSERT INTO `category` VALUES (1098, '沙滩/凉拖', 1, 1079);
INSERT INTO `category` VALUES (1099, '户外袜', 1, 1079);
INSERT INTO `category` VALUES (1100, '户外装备', 1, 1031);
INSERT INTO `category` VALUES (1101, '帐篷/垫子', 1, 1100);
INSERT INTO `category` VALUES (1102, '睡袋/吊床', 1, 1100);
INSERT INTO `category` VALUES (1103, '登山攀岩', 1, 1100);
INSERT INTO `category` VALUES (1104, '背包', 1, 1100);
INSERT INTO `category` VALUES (1105, '户外配饰', 1, 1100);
INSERT INTO `category` VALUES (1106, '户外照明', 1, 1100);
INSERT INTO `category` VALUES (1107, '户外仪表', 1, 1100);
INSERT INTO `category` VALUES (1108, '户外工具', 1, 1100);
INSERT INTO `category` VALUES (1109, '望远镜', 1, 1100);
INSERT INTO `category` VALUES (1110, '旅游用品', 1, 1100);
INSERT INTO `category` VALUES (1111, '便携桌椅床', 1, 1100);
INSERT INTO `category` VALUES (1112, '野餐烧烤', 1, 1100);
INSERT INTO `category` VALUES (1113, '军迷用品', 1, 1100);
INSERT INTO `category` VALUES (1114, '救援装备', 1, 1100);
INSERT INTO `category` VALUES (1115, '滑雪装备', 1, 1100);
INSERT INTO `category` VALUES (1116, '极限户外', 1, 1100);
INSERT INTO `category` VALUES (1117, '冲浪潜水', 1, 1100);
INSERT INTO `category` VALUES (1118, '健身训练', 1, 1031);
INSERT INTO `category` VALUES (1119, '综合训练器', 1, 1118);
INSERT INTO `category` VALUES (1120, '其他大型器械', 1, 1118);
INSERT INTO `category` VALUES (1121, '哑铃', 1, 1118);
INSERT INTO `category` VALUES (1122, '仰卧板/收腹机', 1, 1118);
INSERT INTO `category` VALUES (1123, '其他中小型器材', 1, 1118);
INSERT INTO `category` VALUES (1124, '瑜伽舞蹈', 1, 1118);
INSERT INTO `category` VALUES (1125, '武术搏击', 1, 1118);
INSERT INTO `category` VALUES (1126, '健身车/动感单车', 1, 1118);
INSERT INTO `category` VALUES (1127, '跑步机', 1, 1118);
INSERT INTO `category` VALUES (1128, '运动护具', 1, 1118);
INSERT INTO `category` VALUES (1129, '纤体瑜伽', 1, 1031);
INSERT INTO `category` VALUES (1130, '瑜伽垫', 1, 1129);
INSERT INTO `category` VALUES (1131, '瑜伽服', 1, 1129);
INSERT INTO `category` VALUES (1132, '瑜伽配件', 1, 1129);
INSERT INTO `category` VALUES (1133, '瑜伽套装', 1, 1129);
INSERT INTO `category` VALUES (1134, '舞蹈鞋服', 1, 1129);
INSERT INTO `category` VALUES (1135, '体育用品', 1, 1031);
INSERT INTO `category` VALUES (1136, '羽毛球', 1, 1135);
INSERT INTO `category` VALUES (1137, '乒乓球', 1, 1135);
INSERT INTO `category` VALUES (1138, '篮球', 1, 1135);
INSERT INTO `category` VALUES (1139, '足球', 1, 1135);
INSERT INTO `category` VALUES (1140, '网球', 1, 1135);
INSERT INTO `category` VALUES (1141, '排球', 1, 1135);
INSERT INTO `category` VALUES (1142, '高尔夫', 1, 1135);
INSERT INTO `category` VALUES (1143, '台球', 1, 1135);
INSERT INTO `category` VALUES (1144, '棋牌麻将', 1, 1135);
INSERT INTO `category` VALUES (1145, '轮滑滑板', 1, 1135);
INSERT INTO `category` VALUES (1146, '其他', 1, 1135);
INSERT INTO `category` VALUES (1148, '彩票', 1, 1147);
INSERT INTO `category` VALUES (1149, '双色球', 1, 1148);
INSERT INTO `category` VALUES (1150, '大乐透', 1, 1148);
INSERT INTO `category` VALUES (1151, '福彩3D', 1, 1148);
INSERT INTO `category` VALUES (1152, '排列三', 1, 1148);
INSERT INTO `category` VALUES (1153, '排列五', 1, 1148);
INSERT INTO `category` VALUES (1154, '七星彩', 1, 1148);
INSERT INTO `category` VALUES (1155, '七乐彩', 1, 1148);
INSERT INTO `category` VALUES (1156, '竞彩足球', 1, 1148);
INSERT INTO `category` VALUES (1157, '竞彩篮球', 1, 1148);
INSERT INTO `category` VALUES (1158, '新时时彩', 1, 1148);
INSERT INTO `category` VALUES (1159, '机票', 1, 1147);
INSERT INTO `category` VALUES (1160, '国内机票', 1, 1159);
INSERT INTO `category` VALUES (1161, '酒店', 1, 1147);
INSERT INTO `category` VALUES (1162, '国内酒店', 1, 1161);
INSERT INTO `category` VALUES (1163, '酒店团购', 1, 1161);
INSERT INTO `category` VALUES (1164, '旅行', 1, 1147);
INSERT INTO `category` VALUES (1165, '度假', 1, 1164);
INSERT INTO `category` VALUES (1166, '景点', 1, 1164);
INSERT INTO `category` VALUES (1167, '租车', 1, 1164);
INSERT INTO `category` VALUES (1168, '火车票', 1, 1164);
INSERT INTO `category` VALUES (1169, '旅游团购', 1, 1164);
INSERT INTO `category` VALUES (1170, '充值', 1, 1147);
INSERT INTO `category` VALUES (1171, '手机充值', 1, 1170);
INSERT INTO `category` VALUES (1172, '游戏', 1, 1147);
INSERT INTO `category` VALUES (1173, '游戏点卡', 1, 1172);
INSERT INTO `category` VALUES (1174, 'QQ充值', 1, 1172);
INSERT INTO `category` VALUES (1175, '票务', 1, 1147);
INSERT INTO `category` VALUES (1176, '电影票', 1, 1175);
INSERT INTO `category` VALUES (1177, '演唱会', 1, 1175);
INSERT INTO `category` VALUES (1178, '话剧歌剧', 1, 1175);
INSERT INTO `category` VALUES (1179, '音乐会', 1, 1175);
INSERT INTO `category` VALUES (1180, '体育赛事', 1, 1175);
INSERT INTO `category` VALUES (1181, '舞蹈芭蕾', 1, 1175);
INSERT INTO `category` VALUES (1182, '戏曲综艺', 1, 1175);
INSERT INTO `category` VALUES (1193, '英文小说', 1, 11);
INSERT INTO `category` VALUES (1194, '火锅涮锅', 1, 718);
INSERT INTO `category` VALUES (1195, '手电筒', 1, 1192);
INSERT INTO `category` VALUES (1196, '照妖镜', 1, 1192);
INSERT INTO `category` VALUES (1198, '蓝宝石', 1, 987);
INSERT INTO `category` VALUES (1199, '电子小说', 1, 2);
INSERT INTO `category` VALUES (1200, '上网本', 1, 162);
INSERT INTO `category` VALUES (1201, '婴儿礼服', 1, 341);
INSERT INTO `category` VALUES (1202, '电子漫画书', 1, 2);
INSERT INTO `category` VALUES (1203, '不移动软盘', 1, 186);
INSERT INTO `category` VALUES (1204, '购机送流量', 1, 562);
INSERT INTO `category` VALUES (1207, '电子教科书', 1, 2);
INSERT INTO `category` VALUES (1208, '儿童电脑', 1, 625);
INSERT INTO `category` VALUES (1213, '测试餐具', 1, 733);
INSERT INTO `category` VALUES (1215, '电子文学', 1, 2);
INSERT INTO `category` VALUES (1216, '电子画报', 101, 2);
INSERT INTO `category` VALUES (11156, '手机配件', 1, 1000);
INSERT INTO `category` VALUES (11157, '教育、培训', 1, 0);
INSERT INTO `category` VALUES (11158, '计算机培训', 1, 11157);
INSERT INTO `category` VALUES (11159, '软件研发', 1, 11158);
INSERT INTO `category` VALUES (11160, '小吃培训', 1, 11157);
INSERT INTO `category` VALUES (11161, '面食/小吃', 1, 11160);
INSERT INTO `category` VALUES (11162, '重庆特色小吃', 1, 11161);
INSERT INTO `category` VALUES (11163, '董秘培训', 1, 11157);
INSERT INTO `category` VALUES (11164, '金融董秘培训', 1, 11163);
INSERT INTO `category` VALUES (11165, '新三板方向', 1, 11163);
INSERT INTO `category` VALUES (11166, '公司融资方向', 1, 11163);
INSERT INTO `category` VALUES (11167, '人工智能', 1, 11158);
INSERT INTO `category` VALUES (11168, '物联网', 1, 11158);
INSERT INTO `category` VALUES (11169, 'Java就业班', 1, 11158);
INSERT INTO `category` VALUES (11170, '大数据', 1, 11158);
INSERT INTO `category` VALUES (11171, 'PHP', 1, 11158);
INSERT INTO `category` VALUES (11172, '嵌入式开发', 1, 11158);
INSERT INTO `category` VALUES (11173, '新媒体', 1, 11158);
INSERT INTO `category` VALUES (11174, '产品经理', 1, 11158);
INSERT INTO `category` VALUES (11175, 'DBA', 1, 11158);
INSERT INTO `category` VALUES (11176, '手机', 1, 559);
INSERT INTO `category` VALUES (11177, '家电', NULL, 0);
INSERT INTO `category` VALUES (11178, 'ces', NULL, NULL);
INSERT INTO `category` VALUES (11179, '礼品', NULL, 0);
INSERT INTO `category` VALUES (11180, 'rr', NULL, NULL);
INSERT INTO `category` VALUES (11181, 'fdf', NULL, NULL);
INSERT INTO `category` VALUES (11182, '手机、数码', 1, 0);
INSERT INTO `category` VALUES (11183, '手机通讯', 1, 11182);
INSERT INTO `category` VALUES (11184, '游戏手机', 1, 11183);
INSERT INTO `category` VALUES (11185, '拍照手机', 1, 11183);
INSERT INTO `category` VALUES (11186, '老年人手机', 1, 11183);
INSERT INTO `category` VALUES (11187, '性价比手机', 1, 11183);
INSERT INTO `category` VALUES (11188, '高端手机', 1, 11183);
INSERT INTO `category` VALUES (11189, '学生手机', 1, 11183);
INSERT INTO `category` VALUES (11190, '无人机', 0, 11182);
INSERT INTO `category` VALUES (11191, '农业无人机', 0, 11190);
INSERT INTO `category` VALUES (11192, '运货无人机', 0, 11190);
INSERT INTO `category` VALUES (11193, '玩具无人机', 0, 11190);
INSERT INTO `category` VALUES (11194, '摄影无人机', 0, 11190);
INSERT INTO `category` VALUES (11195, '专业无人机', 0, 11190);
INSERT INTO `category` VALUES (11196, '电脑', 0, 11182);
INSERT INTO `category` VALUES (11197, '台式机', 0, 11196);
INSERT INTO `category` VALUES (11198, '轻薄本', 0, 11196);
INSERT INTO `category` VALUES (11199, '游戏本', 0, 11196);
INSERT INTO `category` VALUES (11200, '二合一', 0, 11196);
INSERT INTO `category` VALUES (11201, '全能本', 0, 11196);
INSERT INTO `category` VALUES (11202, '上网本', 0, 11196);
INSERT INTO `category` VALUES (11203, '一体机', 0, 11196);
INSERT INTO `category` VALUES (11204, '手机模型', 0, 11183);
INSERT INTO `category` VALUES (11205, '相机', 0, 11182);
INSERT INTO `category` VALUES (11206, '拍立得', 0, 11205);
INSERT INTO `category` VALUES (11207, '复古相机', 0, 11205);
INSERT INTO `category` VALUES (11208, '数码相机', 0, 11205);
INSERT INTO `category` VALUES (11209, '云台相机', 0, 11205);
INSERT INTO `category` VALUES (11210, '胶卷相机', 0, 11205);
INSERT INTO `category` VALUES (11211, '摄影机', 0, 11205);
INSERT INTO `category` VALUES (11212, '普通手机', 0, 11183);

-- ----------------------------
-- Table structure for category_attr
-- ----------------------------
DROP TABLE IF EXISTS `category_attr`;
CREATE TABLE `category_attr`  (
  `category_id` int(11) NOT NULL,
  `attr_id` int(11) NOT NULL COMMENT '属性分类表',
  PRIMARY KEY (`category_id`, `attr_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of category_attr
-- ----------------------------
INSERT INTO `category_attr` VALUES (11159, 2);
INSERT INTO `category_attr` VALUES (11159, 3);
INSERT INTO `category_attr` VALUES (11159, 4);
INSERT INTO `category_attr` VALUES (11159, 5);
INSERT INTO `category_attr` VALUES (11167, 2);
INSERT INTO `category_attr` VALUES (11167, 3);
INSERT INTO `category_attr` VALUES (11167, 4);
INSERT INTO `category_attr` VALUES (11184, 19);
INSERT INTO `category_attr` VALUES (11184, 20);
INSERT INTO `category_attr` VALUES (11184, 21);
INSERT INTO `category_attr` VALUES (11184, 22);
INSERT INTO `category_attr` VALUES (11184, 23);
INSERT INTO `category_attr` VALUES (11184, 24);
INSERT INTO `category_attr` VALUES (11184, 25);
INSERT INTO `category_attr` VALUES (11185, 19);
INSERT INTO `category_attr` VALUES (11185, 20);
INSERT INTO `category_attr` VALUES (11185, 21);
INSERT INTO `category_attr` VALUES (11185, 22);
INSERT INTO `category_attr` VALUES (11185, 23);
INSERT INTO `category_attr` VALUES (11185, 24);
INSERT INTO `category_attr` VALUES (11185, 25);
INSERT INTO `category_attr` VALUES (11187, 19);
INSERT INTO `category_attr` VALUES (11187, 20);
INSERT INTO `category_attr` VALUES (11187, 21);
INSERT INTO `category_attr` VALUES (11187, 22);
INSERT INTO `category_attr` VALUES (11187, 23);
INSERT INTO `category_attr` VALUES (11187, 24);
INSERT INTO `category_attr` VALUES (11187, 25);
INSERT INTO `category_attr` VALUES (11188, 19);
INSERT INTO `category_attr` VALUES (11188, 20);
INSERT INTO `category_attr` VALUES (11188, 21);
INSERT INTO `category_attr` VALUES (11188, 22);
INSERT INTO `category_attr` VALUES (11188, 23);
INSERT INTO `category_attr` VALUES (11188, 24);
INSERT INTO `category_attr` VALUES (11188, 25);
INSERT INTO `category_attr` VALUES (11189, 19);
INSERT INTO `category_attr` VALUES (11189, 20);
INSERT INTO `category_attr` VALUES (11189, 21);
INSERT INTO `category_attr` VALUES (11189, 22);
INSERT INTO `category_attr` VALUES (11189, 23);
INSERT INTO `category_attr` VALUES (11189, 24);
INSERT INTO `category_attr` VALUES (11189, 25);
INSERT INTO `category_attr` VALUES (11211, 26);

-- ----------------------------
-- Table structure for category_brand
-- ----------------------------
DROP TABLE IF EXISTS `category_brand`;
CREATE TABLE `category_brand`  (
  `category_id` int(11) NOT NULL COMMENT '分类ID',
  `brand_id` int(11) NOT NULL COMMENT '品牌ID',
  PRIMARY KEY (`brand_id`, `category_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of category_brand
-- ----------------------------
INSERT INTO `category_brand` VALUES (11184, 11);
INSERT INTO `category_brand` VALUES (11185, 11);
INSERT INTO `category_brand` VALUES (11187, 11);
INSERT INTO `category_brand` VALUES (11188, 11);
INSERT INTO `category_brand` VALUES (11189, 11);
INSERT INTO `category_brand` VALUES (11159, 12);
INSERT INTO `category_brand` VALUES (11167, 12);
INSERT INTO `category_brand` VALUES (11159, 13);
INSERT INTO `category_brand` VALUES (11167, 13);
INSERT INTO `category_brand` VALUES (11168, 13);
INSERT INTO `category_brand` VALUES (11184, 15);
INSERT INTO `category_brand` VALUES (11185, 15);
INSERT INTO `category_brand` VALUES (11187, 15);
INSERT INTO `category_brand` VALUES (11188, 15);
INSERT INTO `category_brand` VALUES (11189, 15);
INSERT INTO `category_brand` VALUES (11184, 16);
INSERT INTO `category_brand` VALUES (11185, 16);
INSERT INTO `category_brand` VALUES (11187, 16);
INSERT INTO `category_brand` VALUES (11188, 16);
INSERT INTO `category_brand` VALUES (11189, 16);
INSERT INTO `category_brand` VALUES (11184, 17);
INSERT INTO `category_brand` VALUES (11185, 17);
INSERT INTO `category_brand` VALUES (11187, 17);
INSERT INTO `category_brand` VALUES (11188, 17);
INSERT INTO `category_brand` VALUES (11189, 17);
INSERT INTO `category_brand` VALUES (11184, 18);
INSERT INTO `category_brand` VALUES (11185, 18);
INSERT INTO `category_brand` VALUES (11187, 18);
INSERT INTO `category_brand` VALUES (11188, 18);
INSERT INTO `category_brand` VALUES (11189, 18);
INSERT INTO `category_brand` VALUES (11184, 19);
INSERT INTO `category_brand` VALUES (11185, 19);
INSERT INTO `category_brand` VALUES (11187, 19);
INSERT INTO `category_brand` VALUES (11188, 19);
INSERT INTO `category_brand` VALUES (11189, 19);
INSERT INTO `category_brand` VALUES (11184, 20);
INSERT INTO `category_brand` VALUES (11185, 20);
INSERT INTO `category_brand` VALUES (11187, 20);
INSERT INTO `category_brand` VALUES (11188, 20);
INSERT INTO `category_brand` VALUES (11189, 20);
INSERT INTO `category_brand` VALUES (11184, 21);
INSERT INTO `category_brand` VALUES (11185, 21);
INSERT INTO `category_brand` VALUES (11187, 21);
INSERT INTO `category_brand` VALUES (11188, 21);
INSERT INTO `category_brand` VALUES (11189, 21);
INSERT INTO `category_brand` VALUES (11184, 22);
INSERT INTO `category_brand` VALUES (11185, 22);
INSERT INTO `category_brand` VALUES (11187, 22);
INSERT INTO `category_brand` VALUES (11188, 22);
INSERT INTO `category_brand` VALUES (11189, 22);
INSERT INTO `category_brand` VALUES (11184, 23);
INSERT INTO `category_brand` VALUES (11185, 23);
INSERT INTO `category_brand` VALUES (11187, 23);
INSERT INTO `category_brand` VALUES (11188, 23);
INSERT INTO `category_brand` VALUES (11189, 23);
INSERT INTO `category_brand` VALUES (11184, 24);
INSERT INTO `category_brand` VALUES (11185, 24);
INSERT INTO `category_brand` VALUES (11187, 24);
INSERT INTO `category_brand` VALUES (11188, 24);
INSERT INTO `category_brand` VALUES (11189, 24);
INSERT INTO `category_brand` VALUES (11184, 25);
INSERT INTO `category_brand` VALUES (11185, 25);
INSERT INTO `category_brand` VALUES (11187, 25);
INSERT INTO `category_brand` VALUES (11188, 25);
INSERT INTO `category_brand` VALUES (11189, 25);
INSERT INTO `category_brand` VALUES (11184, 26);
INSERT INTO `category_brand` VALUES (11185, 26);
INSERT INTO `category_brand` VALUES (11187, 26);
INSERT INTO `category_brand` VALUES (11188, 26);
INSERT INTO `category_brand` VALUES (11189, 26);
INSERT INTO `category_brand` VALUES (11184, 27);
INSERT INTO `category_brand` VALUES (11185, 27);
INSERT INTO `category_brand` VALUES (11187, 27);
INSERT INTO `category_brand` VALUES (11188, 27);
INSERT INTO `category_brand` VALUES (11189, 27);
INSERT INTO `category_brand` VALUES (11184, 28);
INSERT INTO `category_brand` VALUES (11185, 28);
INSERT INTO `category_brand` VALUES (11186, 28);
INSERT INTO `category_brand` VALUES (11212, 28);

-- ----------------------------
-- Table structure for sku
-- ----------------------------
DROP TABLE IF EXISTS `sku`;
CREATE TABLE `sku`  (
  `id` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品id',
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'SKU名称',
  `price` int(20) NOT NULL DEFAULT 1 COMMENT '价格（分）',
  `num` int(10) NULL DEFAULT 100 COMMENT '库存数量',
  `image` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品图片',
  `images` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品图片列表',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `spu_id` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'SPUID',
  `category_id` int(10) NULL DEFAULT NULL COMMENT '类目ID',
  `category_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '类目名称',
  `brand_id` int(11) NULL DEFAULT NULL COMMENT '品牌id',
  `brand_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '品牌名称',
  `sku_attribute` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '规格',
  `status` int(1) NULL DEFAULT 1 COMMENT '商品状态 1-正常，2-下架，3-删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `cid`(`category_id`) USING BTREE,
  INDEX `status`(`status`) USING BTREE,
  INDEX `updated`(`update_time`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商品表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sku
-- ----------------------------
INSERT INTO `sku` VALUES ('1318594982227025922', '华为Mate40 Pro 32G 超高速风驰闪拍 第二代昆仑玻璃 华为鸿蒙智能手机', 5999, 1228, 'https://img12.360buyimg.com/n7/jfs/t1/178052/25/50495/92072/671b40c6F42f2d1e2/dd565093ee00384e.jpg.avif', 'https://sklll.oss-cn-beijing.aliyuncs.com/secby/a65bfbe4-21b7-42b2-b5cf-47a9730e0a16.jpg,https://sklll.oss-cn-beijing.aliyuncs.com/secby/fa52ef66-7724-4d6e-bece-15eba0f8f903.jpg,https://sklll.oss-cn-beijing.aliyuncs.com/secby/734f0f17-ac73-45d3-a6bf-83e1569ce887.jpg', '2020-10-20 16:48:37', '2020-10-20 16:48:37', '1318594982147334146', 11159, '软件研发', 11, '华为', '{\"就业薪资\":\"10K起\",\"学习费用\":\"2万\"}', 3);
INSERT INTO `sku` VALUES ('1318596430360813570', '华为Mate40 Pro 32G 1800万像素 超高速风驰闪拍 第二代昆仑玻璃 华为鸿蒙智能手机', 5199, 1227, 'https://img12.360buyimg.com/n7/jfs/t1/255988/37/6462/104450/67726bd5F455a3ca3/d12247c005b5cc90.jpg.avif', 'https://sklll.oss-cn-beijing.aliyuncs.com/secby/5f5b7435-6cf2-4797-8f65-d4abff181390.jpg', '2020-10-20 16:54:22', '2020-10-20 16:54:22', '1318596430293704706', 11159, '软件研发', 11, '华为', '{\"就业薪资\":\"10K起\",\"学习费用\":\"2万\"}', 3);
INSERT INTO `sku` VALUES ('1318596430398562305', '华为Mate40 Pro 128G 超高速风驰闪拍 第二代昆仑玻璃 华为鸿蒙智能手机', 6999, 1226, 'https://img14.360buyimg.com/n7/jfs/t1/230872/19/23681/39381/66a4a9a4F2b697409/86c1829beaab1387.jpg.avif', 'https://sklll.oss-cn-beijing.aliyuncs.com/secby/5f5b7435-6cf2-4797-8f65-d4abff181390.jpg', '2020-10-20 16:54:22', '2020-10-20 16:54:22', '1318596430293704706', 11159, '软件研发', 11, '华为', '{\"就业薪资\":\"10K起\",\"学习费用\":\"2万\"}', 3);
INSERT INTO `sku` VALUES ('1318599511605563394', '格力手机 5G手机 黑色 格力大松手机派工新款G0515D/G0615D原装5G手机 G7/G0615D', 100, 1225, 'https://img14.360buyimg.com/n7/jfs/t1/253096/26/28264/51972/67c504b0F523ad2c0/b725032773931f43.jpg.avif', 'https://sklll.oss-cn-beijing.aliyuncs.com/secby/ffc66a17-edfc-43bb-8f66-431b1e9bf606.jpg', '2020-10-20 17:06:37', '2020-10-20 17:06:37', '1318599511492317185', 11159, '软件研发', 11, '华为', '{\"就业薪资\":\"10K起\",\"学习费用\":\"2万\"}', 3);
INSERT INTO `sku` VALUES ('1318599511647506433', '格力手机 5G手机 红色 格力大松手机派工新款G0515D/G0615D原装5G手机 G7/G0615D', 789, 1224, 'https://img11.360buyimg.com/n7/jfs/t1/268879/40/22285/50389/67b6f337Ff6fdffb0/222ea28da2e5740d.jpg.avif', 'https://sklll.oss-cn-beijing.aliyuncs.com/secby/ffc66a17-edfc-43bb-8f66-431b1e9bf606.jpg', '2020-10-20 17:06:37', '2020-10-20 17:06:37', '1318599511492317185', 11159, '软件研发', 11, '华为', '{\"就业薪资\":\"10K起\",\"学习费用\":\"2万\"}', 3);
INSERT INTO `sku` VALUES ('1319051488240168961', '小米10促销活培训课  1万  6K起 徕卡可变光圈镜头 14Pro全网通5G双卡双待 澎湃OS 国行补贴机 ', 155, 1223, 'https://img12.360buyimg.com/n7/jfs/t1/265590/14/30115/92346/67cbe8dbFcfdacda8/8e08a8a73c99498b.jpg.avif', 'https://sklll.oss-cn-beijing.aliyuncs.com/secby/a65bfbe4-21b7-42b2-b5cf-47a9730e0a16.jpg,https://sklll.oss-cn-beijing.aliyuncs.com/secby/fa52ef66-7724-4d6e-bece-15eba0f8f903.jpg,https://sklll.oss-cn-beijing.aliyuncs.com/secby/734f0f17-ac73-45d3-a6bf-83e1569ce887.jpg', '2020-10-21 23:02:36', '2020-10-21 23:02:36', '1319051488177254401', 11159, '软件研发', 12, '中兴', '{\"就业薪资\":\"6K起\",\"学习费用\":\"1万\"}', 3);
INSERT INTO `sku` VALUES ('1319051488265334786', '小米10促销活培训课  2万  6K起 徕卡可变光圈镜头 14Pro全网通5G双卡双待 澎湃OS 国行补贴机 ', 1666, 1222, 'https://img14.360buyimg.com/n7/jfs/t1/266879/18/13938/81983/678e1626F0286cf1c/ab9495396d7d2a11.jpg.avif', 'https://sklll.oss-cn-beijing.aliyuncs.com/secby/a65bfbe4-21b7-42b2-b5cf-47a9730e0a16.jpg,https://sklll.oss-cn-beijing.aliyuncs.com/secby/fa52ef66-7724-4d6e-bece-15eba0f8f903.jpg,https://sklll.oss-cn-beijing.aliyuncs.com/secby/734f0f17-ac73-45d3-a6bf-83e1569ce887.jpg', '2020-10-21 23:02:36', '2020-10-21 23:02:36', '1319051488177254401', 11159, '软件研发', 12, '中兴', '{\"就业薪资\":\"6K起\",\"学习费用\":\"2万\"}', 3);
INSERT INTO `sku` VALUES ('1319051488282112002', '小米10促销活培训课  1万  10K起 徕卡可变光圈镜头 14Pro全网通5G双卡双待 澎湃OS 国行补贴机 ', 123, 12221, 'https://img12.360buyimg.com/n7/jfs/t1/258861/29/18876/60489/67ab2cc6Fa51d85a8/efee5a003cf57c91.jpg.avif', 'https://sklll.oss-cn-beijing.aliyuncs.com/secby/a65bfbe4-21b7-42b2-b5cf-47a9730e0a16.jpg,https://sklll.oss-cn-beijing.aliyuncs.com/secby/fa52ef66-7724-4d6e-bece-15eba0f8f903.jpg,https://sklll.oss-cn-beijing.aliyuncs.com/secby/734f0f17-ac73-45d3-a6bf-83e1569ce887.jpg', '2020-10-21 23:02:36', '2020-10-21 23:02:36', '1319051488177254401', 11159, '软件研发', 12, '中兴', '{\"就业薪资\":\"10K起\",\"学习费用\":\"1万\"}', 3);
INSERT INTO `sku` VALUES ('1319051488298889217', '小米10促销活培训课  2万  10K起 徕卡可变光圈镜头 14Pro全网通5G双卡双待 澎湃OS 国行补贴机 ', 114514, 12231, 'https://img11.360buyimg.com/n7/jfs/t1/263072/33/6365/36383/6774ce59F40a648a7/7a76bb43b5af2478.jpg.avif', 'https://sklll.oss-cn-beijing.aliyuncs.com/secby/a65bfbe4-21b7-42b2-b5cf-47a9730e0a16.jpg,https://sklll.oss-cn-beijing.aliyuncs.com/secby/fa52ef66-7724-4d6e-bece-15eba0f8f903.jpg,https://sklll.oss-cn-beijing.aliyuncs.com/secby/734f0f17-ac73-45d3-a6bf-83e1569ce887.jpg', '2020-10-21 23:02:36', '2020-10-21 23:02:36', '1319051488177254401', 11159, '软件研发', 12, '中兴', '{\"就业薪资\":\"10K起\",\"学习费用\":\"2万\"}', 3);
INSERT INTO `sku` VALUES ('1820820599467974658', '小米mate   软件研发   2万   10K起   培训 徕卡可变光圈镜头 14Pro全网通5G双卡双待 澎湃OS 国行补贴机 ', 100, 1, 'https://img14.360buyimg.com/n7/jfs/t1/257335/39/9663/54620/677d270bF15b15beb/ee900fb5940b4ebd.jpg.avif', '', '2024-08-06 13:53:55', '2024-08-06 13:53:55', '1820820599417643009', 11159, '软件研发', 11, '华为', '{\"类型\":\"培训\",\"就业薪资\":\"10K起\",\"学习费用\":\"2万\",\"应用场景\":\"软件研发\"}', 1);
INSERT INTO `sku` VALUES ('1820820599530889217', '小米mate   软件研发   9988   10K起   培训 徕卡可变光圈镜头 14Pro全网通5G双卡双待 澎湃OS 国行补贴机 ', 200, 2, 'https://img10.360buyimg.com/n7/jfs/t1/257541/16/29332/104438/67ca605bFf826db59/a154f89013987b43.jpg.avif', '', '2024-08-06 13:53:55', '2024-08-06 13:53:55', '1820820599417643009', 11159, '软件研发', 11, '华为', '{\"类型\":\"培训\",\"就业薪资\":\"10K起\",\"学习费用\":\"9988\",\"应用场景\":\"软件研发\"}', 1);
INSERT INTO `sku` VALUES ('1820820599530889218', '小米mate   软件研发   2万   10K起   市场管理 徕卡可变光圈镜头 14Pro全网通5G双卡双待 澎湃OS 国行补贴机 ', 300, 3, 'https://img13.360buyimg.com/n7/jfs/t1/266958/12/28424/83136/67cac72fFfbb50ce9/0139db7cc45790d1.jpg.avif', '', '2024-08-06 13:53:55', '2024-08-06 13:53:55', '1820820599417643009', 11159, '软件研发', 11, '华为', '{\"类型\":\"市场管理\",\"就业薪资\":\"10K起\",\"学习费用\":\"2万\",\"应用场景\":\"软件研发\"}', 1);
INSERT INTO `sku` VALUES ('1820820599660912642', '小米mate   软件研发   9988   10K起   市场管理 徕卡可变光圈镜头 14Pro全网通5G双卡双待 澎湃OS 国行补贴机 ', 400, 4, 'https://img13.360buyimg.com/n7/jfs/t1/234906/3/3747/97917/6582b8e0F68d0a7a4/2dec84f3313c1ef7.png.avif', '', '2024-08-06 13:53:55', '2024-08-06 13:53:55', '1820820599417643009', 11159, '软件研发', 11, '华为', '{\"类型\":\"市场管理\",\"就业薪资\":\"10K起\",\"学习费用\":\"9988\",\"应用场景\":\"软件研发\"}', 1);
INSERT INTO `sku` VALUES ('1896664805461278721', '小米 14 Pro 续航 6000毫安 颜色 黑色 处理器 高通 相机 1亿像素 前置6000万超广角人像 AI修图 北斗卫星图片消息鸿蒙智能手机', 5000, 1000, 'https://img13.360buyimg.com/n7/jfs/t1/259689/32/19719/82603/67af0a35F6d07bf95/bb7dec5aa2f76f8d.jpg.avif', 'http://192.168.11.4:9000/mall/20250304/b04af53c-2d12-4b0d-b75d-4fc016a501f7-Cleaner.png,http://192.168.11.4:9000/mall/20250304/db8693db-91e7-4bce-b285-5fd3f73bfc59-QQ图片20250226155713.jpg,http://192.168.11.4:9000/mall/20250304/7c3c995d-6993-4372-a940-cb5d7480b7ce-i59400.jpg', NULL, NULL, '1896664805398364161', 11188, '高端手机', 16, '小米', '{\"颜色\":\"黑色\",\"相机\":\"1亿像素\",\"处理器\":\"高通\",\"续航\":\"6000毫安\"}', 3);
INSERT INTO `sku` VALUES ('1896664805461278722', '小米 14 Pro 续航 6000毫安 颜色 黑色 处理器 联发科 相机 1亿像素 前置6000万超广角人像 AI修图 北斗卫星图片消息鸿蒙智能手机', 5000, 32, 'https://img12.360buyimg.com/n7/jfs/t1/244602/31/26473/84246/67485453F36bcfa57/e0ce64b1efd4b44d.png.avif', 'http://192.168.11.4:9000/mall/20250304/b04af53c-2d12-4b0d-b75d-4fc016a501f7-Cleaner.png,http://192.168.11.4:9000/mall/20250304/db8693db-91e7-4bce-b285-5fd3f73bfc59-QQ图片20250226155713.jpg,http://192.168.11.4:9000/mall/20250304/7c3c995d-6993-4372-a940-cb5d7480b7ce-i59400.jpg', NULL, NULL, '1896664805398364161', 11188, '高端手机', 16, '小米', '{\"颜色\":\"黑色\",\"相机\":\"1亿像素\",\"处理器\":\"联发科\",\"续航\":\"6000毫安\"}', 3);
INSERT INTO `sku` VALUES ('1896664805528387586', '小米 14 Pro 续航 6000毫安 颜色 白色 处理器 高通 相机 1亿像素 前置6000万超广角人像 AI修图 北斗卫星图片消息鸿蒙智能手机', 5000, 5312, 'https://img13.360buyimg.com/n7/jfs/t1/91178/25/46328/67709/66c817e7F21b29ee3/2b42ab082c3bc474.jpg.avif', 'http://192.168.11.4:9000/mall/20250304/b04af53c-2d12-4b0d-b75d-4fc016a501f7-Cleaner.png,http://192.168.11.4:9000/mall/20250304/db8693db-91e7-4bce-b285-5fd3f73bfc59-QQ图片20250226155713.jpg,http://192.168.11.4:9000/mall/20250304/7c3c995d-6993-4372-a940-cb5d7480b7ce-i59400.jpg', NULL, NULL, '1896664805398364161', 11188, '高端手机', 16, '小米', '{\"颜色\":\"白色\",\"相机\":\"1亿像素\",\"处理器\":\"高通\",\"续航\":\"6000毫安\"}', 3);
INSERT INTO `sku` VALUES ('1896664805528387587', '小米 14 Pro 续航 6000毫安 颜色 白色 处理器 联发科 相机 1亿像素 前置6000万超广角人像 AI修图 北斗卫星图片消息鸿蒙智能手机', 5000, 5232, 'https://img12.360buyimg.com/n7/jfs/t1/267490/25/21019/84781/67b2f712F1e20214d/72b0ff0d5fa5ace7.jpg.avif', 'http://192.168.11.4:9000/mall/20250304/b04af53c-2d12-4b0d-b75d-4fc016a501f7-Cleaner.png,http://192.168.11.4:9000/mall/20250304/db8693db-91e7-4bce-b285-5fd3f73bfc59-QQ图片20250226155713.jpg,http://192.168.11.4:9000/mall/20250304/7c3c995d-6993-4372-a940-cb5d7480b7ce-i59400.jpg', NULL, NULL, '1896664805398364161', 11188, '高端手机', 16, '小米', '{\"颜色\":\"白色\",\"相机\":\"1亿像素\",\"处理器\":\"联发科\",\"续航\":\"6000毫安\"}', 3);
INSERT INTO `sku` VALUES ('1896664805528387588', '小米 14 Pro 续航 6000毫安 颜色 绿色 处理器 高通 相机 1亿像素 前置6000万超广角人像 AI修图 北斗卫星图片消息鸿蒙智能手机', 5000, 32, 'https://img14.360buyimg.com/n7/jfs/t1/228124/28/37804/49994/676e003cF6691be7c/f39157d60f408f33.jpg.avif', 'http://192.168.11.4:9000/mall/20250304/b04af53c-2d12-4b0d-b75d-4fc016a501f7-Cleaner.png,http://192.168.11.4:9000/mall/20250304/db8693db-91e7-4bce-b285-5fd3f73bfc59-QQ图片20250226155713.jpg,http://192.168.11.4:9000/mall/20250304/7c3c995d-6993-4372-a940-cb5d7480b7ce-i59400.jpg', NULL, NULL, '1896664805398364161', 11188, '高端手机', 16, '小米', '{\"颜色\":\"绿色\",\"相机\":\"1亿像素\",\"处理器\":\"高通\",\"续航\":\"6000毫安\"}', 3);
INSERT INTO `sku` VALUES ('1896664805591302146', '小米 14 Pro 续航 6000毫安 颜色 绿色 处理器 联发科 相机 1亿像素 前置6000万超广角人像 AI修图 北斗卫星图片消息鸿蒙智能手机', 5000, 532, 'https://img14.360buyimg.com/n7/jfs/t1/271147/10/1211/69114/67cf2380Feacf0652/5a31bad9198bff87.jpg.avif', 'http://192.168.11.4:9000/mall/20250304/b04af53c-2d12-4b0d-b75d-4fc016a501f7-Cleaner.png,http://192.168.11.4:9000/mall/20250304/db8693db-91e7-4bce-b285-5fd3f73bfc59-QQ图片20250226155713.jpg,http://192.168.11.4:9000/mall/20250304/7c3c995d-6993-4372-a940-cb5d7480b7ce-i59400.jpg', NULL, NULL, '1896664805398364161', 11188, '高端手机', 16, '小米', '{\"颜色\":\"绿色\",\"相机\":\"1亿像素\",\"处理器\":\"联发科\",\"续航\":\"6000毫安\"}', 3);
INSERT INTO `sku` VALUES ('1896841641566695426', '华为Mate60Pro 续航 5100毫安 颜色 黑色 处理器 华为 相机 1亿像素 前置6000万超广角人像 AI修图 北斗卫星图片消息鸿蒙智能手机', 5999, 100, 'https://img10.360buyimg.com/n7/jfs/t1/255260/16/20738/31022/67b1e947Fc63cbbe3/3aa9f17d19dda323.jpg.avif', 'http://192.168.11.4:9000/mall/20250304/28436a01-015c-4100-beb7-2a7a06418867-QQ图片20250226155713.jpg,http://192.168.11.4:9000/mall/20250304/ed7c34d7-f065-485e-9cbd-af73e9b5a64a-stupidcar.jpg,http://192.168.11.4:9000/mall/20250304/4cb815f8-e418-4406-9f43-941cd5492fff-smt51.jpg', NULL, NULL, '1896662131890274305', 11188, '高端手机', 11, '华为', '{\"颜色\":\"黑色\",\"相机\":\"1亿像素\",\"处理器\":\"华为\",\"续航\":\"5100毫安\"}', 3);
INSERT INTO `sku` VALUES ('1896841641566695427', '华为Mate60Pro 续航 5100毫安 颜色 黑色 处理器 高通 相机 1亿像素 前置6000万超广角人像 AI修图 北斗卫星图片消息鸿蒙智能手机', 5899, 140, 'https://img11.360buyimg.com/n7/jfs/t1/260463/15/14968/175744/6792397cF7927fefb/1f0edde0df045cd9.jpg.avif', 'http://192.168.11.4:9000/mall/20250304/28436a01-015c-4100-beb7-2a7a06418867-QQ图片20250226155713.jpg,http://192.168.11.4:9000/mall/20250304/ed7c34d7-f065-485e-9cbd-af73e9b5a64a-stupidcar.jpg,http://192.168.11.4:9000/mall/20250304/4cb815f8-e418-4406-9f43-941cd5492fff-smt51.jpg', NULL, NULL, '1896662131890274305', 11188, '高端手机', 11, '华为', '{\"颜色\":\"黑色\",\"相机\":\"1亿像素\",\"处理器\":\"高通\",\"续航\":\"5100毫安\"}', 3);
INSERT INTO `sku` VALUES ('1896841641621221377', '华为Mate60Pro 续航 5100毫安 颜色 白色 处理器 华为 相机 1亿像素 前置6000万超广角人像 AI修图 北斗卫星图片消息鸿蒙智能手机', 6199, 49, 'https://img10.360buyimg.com/n7/jfs/t1/206440/38/51348/223653/67495f9bF9aa087e2/98ebde80549cd960.jpg.avif', 'http://192.168.11.4:9000/mall/20250304/28436a01-015c-4100-beb7-2a7a06418867-QQ图片20250226155713.jpg,http://192.168.11.4:9000/mall/20250304/ed7c34d7-f065-485e-9cbd-af73e9b5a64a-stupidcar.jpg,http://192.168.11.4:9000/mall/20250304/4cb815f8-e418-4406-9f43-941cd5492fff-smt51.jpg', NULL, NULL, '1896662131890274305', 11188, '高端手机', 11, '华为', '{\"颜色\":\"白色\",\"相机\":\"1亿像素\",\"处理器\":\"华为\",\"续航\":\"5100毫安\"}', 3);
INSERT INTO `sku` VALUES ('1896841641621221378', '华为Mate60Pro 续航 5100毫安 颜色 白色 处理器 高通 相机 1亿像素 前置6000万超广角人像 AI修图 北斗卫星图片消息鸿蒙智能手机', 5999, 32, 'https://img14.360buyimg.com/n7/jfs/t1/262029/31/11978/92738/678662b1Ff6fe1c87/1d1c747668d4ae78.jpg.avif', 'http://192.168.11.4:9000/mall/20250304/28436a01-015c-4100-beb7-2a7a06418867-QQ图片20250226155713.jpg,http://192.168.11.4:9000/mall/20250304/ed7c34d7-f065-485e-9cbd-af73e9b5a64a-stupidcar.jpg,http://192.168.11.4:9000/mall/20250304/4cb815f8-e418-4406-9f43-941cd5492fff-smt51.jpg', NULL, NULL, '1896662131890274305', 11188, '高端手机', 11, '华为', '{\"颜色\":\"白色\",\"相机\":\"1亿像素\",\"处理器\":\"高通\",\"续航\":\"5100毫安\"}', 3);
INSERT INTO `sku` VALUES ('1896841641684135937', '华为Mate60Pro 续航 5100毫安 颜色 红色 处理器 华为 相机 1亿像素 前置6000万超广角人像 AI修图 北斗卫星图片消息鸿蒙智能手机', 6499, 132, 'https://img10.360buyimg.com/n7/jfs/t1/259003/13/14597/126497/679239c5F8518fbcf/1d29eb35ea012af7.jpg.avif', 'http://192.168.11.4:9000/mall/20250304/28436a01-015c-4100-beb7-2a7a06418867-QQ图片20250226155713.jpg,http://192.168.11.4:9000/mall/20250304/ed7c34d7-f065-485e-9cbd-af73e9b5a64a-stupidcar.jpg,http://192.168.11.4:9000/mall/20250304/4cb815f8-e418-4406-9f43-941cd5492fff-smt51.jpg', NULL, NULL, '1896662131890274305', 11188, '高端手机', 11, '华为', '{\"颜色\":\"红色\",\"相机\":\"1亿像素\",\"处理器\":\"华为\",\"续航\":\"5100毫安\"}', 3);
INSERT INTO `sku` VALUES ('1896841641684135938', '华为Mate60Pro 续航 5100毫安 颜色 红色 处理器 高通 相机 1亿像素 前置6000万超广角人像 AI修图 北斗卫星图片消息鸿蒙智能手机', 6299, 24, 'https://img12.360buyimg.com/n7/jfs/t1/259865/40/14896/81031/679239b9Fa6c6715d/e6c9c7e3549a647c.jpg.avif', 'http://192.168.11.4:9000/mall/20250304/28436a01-015c-4100-beb7-2a7a06418867-QQ图片20250226155713.jpg,http://192.168.11.4:9000/mall/20250304/ed7c34d7-f065-485e-9cbd-af73e9b5a64a-stupidcar.jpg,http://192.168.11.4:9000/mall/20250304/4cb815f8-e418-4406-9f43-941cd5492fff-smt51.jpg', NULL, NULL, '1896662131890274305', 11188, '高端手机', 11, '华为', '{\"颜色\":\"红色\",\"相机\":\"1亿像素\",\"处理器\":\"高通\",\"续航\":\"5100毫安\"}', 3);
INSERT INTO `sku` VALUES ('1899285136990535682', 'OPPO Reno13续航 4500毫安 颜色 黑色 处理器 高通 相机 1亿像素 ', 2399, 1919, 'http://192.168.11.4:9000/mall/20250311/1fb033e4-9ab6-49bb-ae22-c4ebf61270fc-4ebb2a4a0551a4bf.jpg.avif', 'http://192.168.11.4:9000/mall/20250311/11e1198f-aa88-40b2-b3ba-4fa73b7ba0a1-20e298f85c16e529.jpg.jpg,http://192.168.11.4:9000/mall/20250311/b947c31d-95a1-488e-a865-c400e90aeba8-b836f8f17b946770.png,http://192.168.11.4:9000/mall/20250311/7d6d6e89-4fd7-4dbe-8b77-4e540bbae8fa-8e08a8a73c99498b.jpg', NULL, NULL, '1899285136856317953', 11185, '拍照手机', 15, 'OPPO', '{\"颜色\":\"黑色\",\"相机\":\"1亿像素\",\"处理器\":\"高通\",\"续航\":\"4500毫安\"}', 3);
INSERT INTO `sku` VALUES ('1899285137053450242', 'OPPO Reno13续航 4500毫安 颜色 黑色 处理器 联发科 相机 1亿像素 ', 2399, 1919, 'http://192.168.11.4:9000/mall/20250311/0405da7f-d5a5-493d-af12-3372116004ae-20e298f85c16e529.jpg.avif', 'http://192.168.11.4:9000/mall/20250311/11e1198f-aa88-40b2-b3ba-4fa73b7ba0a1-20e298f85c16e529.jpg.jpg,http://192.168.11.4:9000/mall/20250311/b947c31d-95a1-488e-a865-c400e90aeba8-b836f8f17b946770.png,http://192.168.11.4:9000/mall/20250311/7d6d6e89-4fd7-4dbe-8b77-4e540bbae8fa-8e08a8a73c99498b.jpg', NULL, NULL, '1899285136856317953', 11185, '拍照手机', 15, 'OPPO', '{\"颜色\":\"黑色\",\"相机\":\"1亿像素\",\"处理器\":\"联发科\",\"续航\":\"4500毫安\"}', 3);
INSERT INTO `sku` VALUES ('1899285137053450243', 'OPPO Reno13续航 4500毫安 颜色 黑色 处理器 高通 相机 4000万像素 ', 2399, 1919, 'http://192.168.11.4:9000/mall/20250311/cc04bec8-9c89-40a3-8a40-a53d307ef919-b836f8f17b946770.png.avif', 'http://192.168.11.4:9000/mall/20250311/11e1198f-aa88-40b2-b3ba-4fa73b7ba0a1-20e298f85c16e529.jpg.jpg,http://192.168.11.4:9000/mall/20250311/b947c31d-95a1-488e-a865-c400e90aeba8-b836f8f17b946770.png,http://192.168.11.4:9000/mall/20250311/7d6d6e89-4fd7-4dbe-8b77-4e540bbae8fa-8e08a8a73c99498b.jpg', NULL, NULL, '1899285136856317953', 11185, '拍照手机', 15, 'OPPO', '{\"颜色\":\"黑色\",\"相机\":\"4000万像素\",\"处理器\":\"高通\",\"续航\":\"4500毫安\"}', 3);
INSERT INTO `sku` VALUES ('1899285137116364802', 'OPPO Reno13续航 4500毫安 颜色 黑色 处理器 联发科 相机 4000万像素 ', 2399, 1919, 'http://192.168.11.4:9000/mall/20250311/124b9c84-fcfd-41af-aeb5-73da9abdf57d-4ebb2a4a0551a4bf.jpg.avif', 'http://192.168.11.4:9000/mall/20250311/11e1198f-aa88-40b2-b3ba-4fa73b7ba0a1-20e298f85c16e529.jpg.jpg,http://192.168.11.4:9000/mall/20250311/b947c31d-95a1-488e-a865-c400e90aeba8-b836f8f17b946770.png,http://192.168.11.4:9000/mall/20250311/7d6d6e89-4fd7-4dbe-8b77-4e540bbae8fa-8e08a8a73c99498b.jpg', NULL, NULL, '1899285136856317953', 11185, '拍照手机', 15, 'OPPO', '{\"颜色\":\"黑色\",\"相机\":\"4000万像素\",\"处理器\":\"联发科\",\"续航\":\"4500毫安\"}', 3);
INSERT INTO `sku` VALUES ('1899285137183473665', 'OPPO Reno13续航 4500毫安 颜色 黑色 处理器 高通 相机 1800万像素 ', 2399, 1919, 'http://192.168.11.4:9000/mall/20250311/755307ce-d847-4e02-bcb4-2b1699fecf9b-b451963abad0a43d.jpg.avif', 'http://192.168.11.4:9000/mall/20250311/11e1198f-aa88-40b2-b3ba-4fa73b7ba0a1-20e298f85c16e529.jpg.jpg,http://192.168.11.4:9000/mall/20250311/b947c31d-95a1-488e-a865-c400e90aeba8-b836f8f17b946770.png,http://192.168.11.4:9000/mall/20250311/7d6d6e89-4fd7-4dbe-8b77-4e540bbae8fa-8e08a8a73c99498b.jpg', NULL, NULL, '1899285136856317953', 11185, '拍照手机', 15, 'OPPO', '{\"颜色\":\"黑色\",\"相机\":\"1800万像素\",\"处理器\":\"高通\",\"续航\":\"4500毫安\"}', 3);
INSERT INTO `sku` VALUES ('1899285137183473666', 'OPPO Reno13续航 4500毫安 颜色 黑色 处理器 联发科 相机 1800万像素 ', 2399, 1919, 'http://192.168.11.4:9000/mall/20250311/1a0575da-5e3d-4d78-ba06-f090ec26d1d9-b836f8f17b946770.png.avif', 'http://192.168.11.4:9000/mall/20250311/11e1198f-aa88-40b2-b3ba-4fa73b7ba0a1-20e298f85c16e529.jpg.jpg,http://192.168.11.4:9000/mall/20250311/b947c31d-95a1-488e-a865-c400e90aeba8-b836f8f17b946770.png,http://192.168.11.4:9000/mall/20250311/7d6d6e89-4fd7-4dbe-8b77-4e540bbae8fa-8e08a8a73c99498b.jpg', NULL, NULL, '1899285136856317953', 11185, '拍照手机', 15, 'OPPO', '{\"颜色\":\"黑色\",\"相机\":\"1800万像素\",\"处理器\":\"联发科\",\"续航\":\"4500毫安\"}', 3);
INSERT INTO `sku` VALUES ('1899285137246388226', 'OPPO Reno13续航 4500毫安 颜色 白色 处理器 高通 相机 1亿像素 ', 3999, 1919, 'http://192.168.11.4:9000/mall/20250311/8b73e334-9ff8-4b1d-8095-f20ff9657349-8e08a8a73c99498b.jpg.avif', 'http://192.168.11.4:9000/mall/20250311/11e1198f-aa88-40b2-b3ba-4fa73b7ba0a1-20e298f85c16e529.jpg.jpg,http://192.168.11.4:9000/mall/20250311/b947c31d-95a1-488e-a865-c400e90aeba8-b836f8f17b946770.png,http://192.168.11.4:9000/mall/20250311/7d6d6e89-4fd7-4dbe-8b77-4e540bbae8fa-8e08a8a73c99498b.jpg', NULL, NULL, '1899285136856317953', 11185, '拍照手机', 15, 'OPPO', '{\"颜色\":\"白色\",\"相机\":\"1亿像素\",\"处理器\":\"高通\",\"续航\":\"4500毫安\"}', 3);
INSERT INTO `sku` VALUES ('1899285137309302786', 'OPPO Reno13续航 4500毫安 颜色 白色 处理器 联发科 相机 1亿像素 ', 3999, 1919, 'http://192.168.11.4:9000/mall/20250311/63295ce1-b5c6-48ea-8639-fe788a3063d6-4ebb2a4a0551a4bf.jpg.avif', 'http://192.168.11.4:9000/mall/20250311/11e1198f-aa88-40b2-b3ba-4fa73b7ba0a1-20e298f85c16e529.jpg.jpg,http://192.168.11.4:9000/mall/20250311/b947c31d-95a1-488e-a865-c400e90aeba8-b836f8f17b946770.png,http://192.168.11.4:9000/mall/20250311/7d6d6e89-4fd7-4dbe-8b77-4e540bbae8fa-8e08a8a73c99498b.jpg', NULL, NULL, '1899285136856317953', 11185, '拍照手机', 15, 'OPPO', '{\"颜色\":\"白色\",\"相机\":\"1亿像素\",\"处理器\":\"联发科\",\"续航\":\"4500毫安\"}', 3);
INSERT INTO `sku` VALUES ('1899285137309302787', 'OPPO Reno13续航 4500毫安 颜色 白色 处理器 高通 相机 4000万像素 ', 3999, 1919, 'http://192.168.11.4:9000/mall/20250311/ecbcbda5-62ed-4b15-ba4d-363824d172e6-b451963abad0a43d.jpg.avif', 'http://192.168.11.4:9000/mall/20250311/11e1198f-aa88-40b2-b3ba-4fa73b7ba0a1-20e298f85c16e529.jpg.jpg,http://192.168.11.4:9000/mall/20250311/b947c31d-95a1-488e-a865-c400e90aeba8-b836f8f17b946770.png,http://192.168.11.4:9000/mall/20250311/7d6d6e89-4fd7-4dbe-8b77-4e540bbae8fa-8e08a8a73c99498b.jpg', NULL, NULL, '1899285136856317953', 11185, '拍照手机', 15, 'OPPO', '{\"颜色\":\"白色\",\"相机\":\"4000万像素\",\"处理器\":\"高通\",\"续航\":\"4500毫安\"}', 3);
INSERT INTO `sku` VALUES ('1899285137376411650', 'OPPO Reno13续航 4500毫安 颜色 白色 处理器 联发科 相机 4000万像素 ', 3999, 1919, 'http://192.168.11.4:9000/mall/20250311/e47726ab-94b3-42a0-b2fa-bf8a9ed43810-b836f8f17b946770.png.avif', 'http://192.168.11.4:9000/mall/20250311/11e1198f-aa88-40b2-b3ba-4fa73b7ba0a1-20e298f85c16e529.jpg.jpg,http://192.168.11.4:9000/mall/20250311/b947c31d-95a1-488e-a865-c400e90aeba8-b836f8f17b946770.png,http://192.168.11.4:9000/mall/20250311/7d6d6e89-4fd7-4dbe-8b77-4e540bbae8fa-8e08a8a73c99498b.jpg', NULL, NULL, '1899285136856317953', 11185, '拍照手机', 15, 'OPPO', '{\"颜色\":\"白色\",\"相机\":\"4000万像素\",\"处理器\":\"联发科\",\"续航\":\"4500毫安\"}', 3);
INSERT INTO `sku` VALUES ('1899285137376411651', 'OPPO Reno13续航 4500毫安 颜色 白色 处理器 高通 相机 1800万像素 ', 3999, 1919, 'http://192.168.11.4:9000/mall/20250311/447a3c16-0ae3-4550-aeb4-9f48ece25550-8e08a8a73c99498b.jpg.avif', 'http://192.168.11.4:9000/mall/20250311/11e1198f-aa88-40b2-b3ba-4fa73b7ba0a1-20e298f85c16e529.jpg.jpg,http://192.168.11.4:9000/mall/20250311/b947c31d-95a1-488e-a865-c400e90aeba8-b836f8f17b946770.png,http://192.168.11.4:9000/mall/20250311/7d6d6e89-4fd7-4dbe-8b77-4e540bbae8fa-8e08a8a73c99498b.jpg', NULL, NULL, '1899285136856317953', 11185, '拍照手机', 15, 'OPPO', '{\"颜色\":\"白色\",\"相机\":\"1800万像素\",\"处理器\":\"高通\",\"续航\":\"4500毫安\"}', 3);
INSERT INTO `sku` VALUES ('1899285137439326209', 'OPPO Reno13续航 4500毫安 颜色 白色 处理器 联发科 相机 1800万像素 ', 3999, 1919, 'http://192.168.11.4:9000/mall/20250311/6f0cd9ba-c248-4138-b9d9-0d539cb58951-8e08a8a73c99498b.jpg.avif', 'http://192.168.11.4:9000/mall/20250311/11e1198f-aa88-40b2-b3ba-4fa73b7ba0a1-20e298f85c16e529.jpg.jpg,http://192.168.11.4:9000/mall/20250311/b947c31d-95a1-488e-a865-c400e90aeba8-b836f8f17b946770.png,http://192.168.11.4:9000/mall/20250311/7d6d6e89-4fd7-4dbe-8b77-4e540bbae8fa-8e08a8a73c99498b.jpg', NULL, NULL, '1899285136856317953', 11185, '拍照手机', 15, 'OPPO', '{\"颜色\":\"白色\",\"相机\":\"1800万像素\",\"处理器\":\"联发科\",\"续航\":\"4500毫安\"}', 3);
INSERT INTO `sku` VALUES ('1899285137502240769', 'OPPO Reno13续航 4500毫安 颜色 红色 处理器 高通 相机 1亿像素 ', 3999, 1919, 'http://192.168.11.4:9000/mall/20250311/222d6821-80cf-4f09-be12-fba6c05ac59d-b451963abad0a43d.jpg.avif', 'http://192.168.11.4:9000/mall/20250311/11e1198f-aa88-40b2-b3ba-4fa73b7ba0a1-20e298f85c16e529.jpg.jpg,http://192.168.11.4:9000/mall/20250311/b947c31d-95a1-488e-a865-c400e90aeba8-b836f8f17b946770.png,http://192.168.11.4:9000/mall/20250311/7d6d6e89-4fd7-4dbe-8b77-4e540bbae8fa-8e08a8a73c99498b.jpg', NULL, NULL, '1899285136856317953', 11185, '拍照手机', 15, 'OPPO', '{\"颜色\":\"红色\",\"相机\":\"1亿像素\",\"处理器\":\"高通\",\"续航\":\"4500毫安\"}', 3);
INSERT INTO `sku` VALUES ('1899285137502240770', 'OPPO Reno13续航 4500毫安 颜色 红色 处理器 联发科 相机 1亿像素 ', 3999, 1919, 'http://192.168.11.4:9000/mall/20250311/be2019ce-1a49-4556-8f72-8f647c8860d6-b836f8f17b946770.png.avif', 'http://192.168.11.4:9000/mall/20250311/11e1198f-aa88-40b2-b3ba-4fa73b7ba0a1-20e298f85c16e529.jpg.jpg,http://192.168.11.4:9000/mall/20250311/b947c31d-95a1-488e-a865-c400e90aeba8-b836f8f17b946770.png,http://192.168.11.4:9000/mall/20250311/7d6d6e89-4fd7-4dbe-8b77-4e540bbae8fa-8e08a8a73c99498b.jpg', NULL, NULL, '1899285136856317953', 11185, '拍照手机', 15, 'OPPO', '{\"颜色\":\"红色\",\"相机\":\"1亿像素\",\"处理器\":\"联发科\",\"续航\":\"4500毫安\"}', 3);
INSERT INTO `sku` VALUES ('1899285137569349634', 'OPPO Reno13续航 4500毫安 颜色 红色 处理器 高通 相机 4000万像素 ', 3999, 1919, 'http://192.168.11.4:9000/mall/20250311/478d8a15-f589-437b-ba9a-61f5bca0caf5-4ebb2a4a0551a4bf.jpg.avif', 'http://192.168.11.4:9000/mall/20250311/11e1198f-aa88-40b2-b3ba-4fa73b7ba0a1-20e298f85c16e529.jpg.jpg,http://192.168.11.4:9000/mall/20250311/b947c31d-95a1-488e-a865-c400e90aeba8-b836f8f17b946770.png,http://192.168.11.4:9000/mall/20250311/7d6d6e89-4fd7-4dbe-8b77-4e540bbae8fa-8e08a8a73c99498b.jpg', NULL, NULL, '1899285136856317953', 11185, '拍照手机', 15, 'OPPO', '{\"颜色\":\"红色\",\"相机\":\"4000万像素\",\"处理器\":\"高通\",\"续航\":\"4500毫安\"}', 3);
INSERT INTO `sku` VALUES ('1899285137569349635', 'OPPO Reno13续航 4500毫安 颜色 红色 处理器 联发科 相机 4000万像素 ', 3999, 1919, 'http://192.168.11.4:9000/mall/20250311/5ac4808f-6306-4551-855c-ec7e40529fb8-b836f8f17b946770.png.avif', 'http://192.168.11.4:9000/mall/20250311/11e1198f-aa88-40b2-b3ba-4fa73b7ba0a1-20e298f85c16e529.jpg.jpg,http://192.168.11.4:9000/mall/20250311/b947c31d-95a1-488e-a865-c400e90aeba8-b836f8f17b946770.png,http://192.168.11.4:9000/mall/20250311/7d6d6e89-4fd7-4dbe-8b77-4e540bbae8fa-8e08a8a73c99498b.jpg', NULL, NULL, '1899285136856317953', 11185, '拍照手机', 15, 'OPPO', '{\"颜色\":\"红色\",\"相机\":\"4000万像素\",\"处理器\":\"联发科\",\"续航\":\"4500毫安\"}', 3);
INSERT INTO `sku` VALUES ('1899285137632264193', 'OPPO Reno13续航 4500毫安 颜色 红色 处理器 高通 相机 1800万像素 ', 3999, 1919, 'http://192.168.11.4:9000/mall/20250311/6689cf5f-36e0-4ccc-a916-f0e962bb3ad4-b836f8f17b946770.png.avif', 'http://192.168.11.4:9000/mall/20250311/11e1198f-aa88-40b2-b3ba-4fa73b7ba0a1-20e298f85c16e529.jpg.jpg,http://192.168.11.4:9000/mall/20250311/b947c31d-95a1-488e-a865-c400e90aeba8-b836f8f17b946770.png,http://192.168.11.4:9000/mall/20250311/7d6d6e89-4fd7-4dbe-8b77-4e540bbae8fa-8e08a8a73c99498b.jpg', NULL, NULL, '1899285136856317953', 11185, '拍照手机', 15, 'OPPO', '{\"颜色\":\"红色\",\"相机\":\"1800万像素\",\"处理器\":\"高通\",\"续航\":\"4500毫安\"}', 3);
INSERT INTO `sku` VALUES ('1899285137632264194', 'OPPO Reno13续航 4500毫安 颜色 红色 处理器 联发科 相机 1800万像素 ', 3999, 1919, 'http://192.168.11.4:9000/mall/20250311/9b77e49b-5c64-44e5-a420-4833f3c60fb9-b451963abad0a43d.jpg.avif', 'http://192.168.11.4:9000/mall/20250311/11e1198f-aa88-40b2-b3ba-4fa73b7ba0a1-20e298f85c16e529.jpg.jpg,http://192.168.11.4:9000/mall/20250311/b947c31d-95a1-488e-a865-c400e90aeba8-b836f8f17b946770.png,http://192.168.11.4:9000/mall/20250311/7d6d6e89-4fd7-4dbe-8b77-4e540bbae8fa-8e08a8a73c99498b.jpg', NULL, NULL, '1899285136856317953', 11185, '拍照手机', 15, 'OPPO', '{\"颜色\":\"红色\",\"相机\":\"1800万像素\",\"处理器\":\"联发科\",\"续航\":\"4500毫安\"}', 3);
INSERT INTO `sku` VALUES ('1899285137699373057', 'OPPO Reno13续航 4500毫安 颜色 绿色 处理器 高通 相机 1亿像素 ', 3999, 1919, 'http://192.168.11.4:9000/mall/20250311/f73651f9-f2e6-4f4e-a4d5-4fa443dc8aa9-20e298f85c16e529.jpg.avif', 'http://192.168.11.4:9000/mall/20250311/11e1198f-aa88-40b2-b3ba-4fa73b7ba0a1-20e298f85c16e529.jpg.jpg,http://192.168.11.4:9000/mall/20250311/b947c31d-95a1-488e-a865-c400e90aeba8-b836f8f17b946770.png,http://192.168.11.4:9000/mall/20250311/7d6d6e89-4fd7-4dbe-8b77-4e540bbae8fa-8e08a8a73c99498b.jpg', NULL, NULL, '1899285136856317953', 11185, '拍照手机', 15, 'OPPO', '{\"颜色\":\"绿色\",\"相机\":\"1亿像素\",\"处理器\":\"高通\",\"续航\":\"4500毫安\"}', 3);
INSERT INTO `sku` VALUES ('1899285137762287617', 'OPPO Reno13续航 4500毫安 颜色 绿色 处理器 联发科 相机 1亿像素 ', 3999, 1919, 'http://192.168.11.4:9000/mall/20250311/100f1598-9dc6-4935-af7c-c3bf6ef7f8a2-b451963abad0a43d.jpg.avif', 'http://192.168.11.4:9000/mall/20250311/11e1198f-aa88-40b2-b3ba-4fa73b7ba0a1-20e298f85c16e529.jpg.jpg,http://192.168.11.4:9000/mall/20250311/b947c31d-95a1-488e-a865-c400e90aeba8-b836f8f17b946770.png,http://192.168.11.4:9000/mall/20250311/7d6d6e89-4fd7-4dbe-8b77-4e540bbae8fa-8e08a8a73c99498b.jpg', NULL, NULL, '1899285136856317953', 11185, '拍照手机', 15, 'OPPO', '{\"颜色\":\"绿色\",\"相机\":\"1亿像素\",\"处理器\":\"联发科\",\"续航\":\"4500毫安\"}', 3);
INSERT INTO `sku` VALUES ('1899285137762287618', 'OPPO Reno13续航 4500毫安 颜色 绿色 处理器 高通 相机 4000万像素 ', 5999, 1919, 'http://192.168.11.4:9000/mall/20250311/1272340d-eb78-4138-915b-8c5130fcd807-4ebb2a4a0551a4bf.jpg.avif', 'http://192.168.11.4:9000/mall/20250311/11e1198f-aa88-40b2-b3ba-4fa73b7ba0a1-20e298f85c16e529.jpg.jpg,http://192.168.11.4:9000/mall/20250311/b947c31d-95a1-488e-a865-c400e90aeba8-b836f8f17b946770.png,http://192.168.11.4:9000/mall/20250311/7d6d6e89-4fd7-4dbe-8b77-4e540bbae8fa-8e08a8a73c99498b.jpg', NULL, NULL, '1899285136856317953', 11185, '拍照手机', 15, 'OPPO', '{\"颜色\":\"绿色\",\"相机\":\"4000万像素\",\"处理器\":\"高通\",\"续航\":\"4500毫安\"}', 3);
INSERT INTO `sku` VALUES ('1899285137829396481', 'OPPO Reno13续航 4500毫安 颜色 绿色 处理器 联发科 相机 4000万像素 ', 5999, 1919, 'http://192.168.11.4:9000/mall/20250311/fff3388e-7e3a-4bb9-9741-457bfe921a72-20e298f85c16e529.jpg.avif', 'http://192.168.11.4:9000/mall/20250311/11e1198f-aa88-40b2-b3ba-4fa73b7ba0a1-20e298f85c16e529.jpg.jpg,http://192.168.11.4:9000/mall/20250311/b947c31d-95a1-488e-a865-c400e90aeba8-b836f8f17b946770.png,http://192.168.11.4:9000/mall/20250311/7d6d6e89-4fd7-4dbe-8b77-4e540bbae8fa-8e08a8a73c99498b.jpg', NULL, NULL, '1899285136856317953', 11185, '拍照手机', 15, 'OPPO', '{\"颜色\":\"绿色\",\"相机\":\"4000万像素\",\"处理器\":\"联发科\",\"续航\":\"4500毫安\"}', 3);
INSERT INTO `sku` VALUES ('1899285137829396482', 'OPPO Reno13续航 4500毫安 颜色 绿色 处理器 高通 相机 1800万像素 ', 5999, 1919, 'http://192.168.11.4:9000/mall/20250311/c3ea10fe-ba33-4b54-9b35-78674de69acf-b451963abad0a43d.jpg.avif', 'http://192.168.11.4:9000/mall/20250311/11e1198f-aa88-40b2-b3ba-4fa73b7ba0a1-20e298f85c16e529.jpg.jpg,http://192.168.11.4:9000/mall/20250311/b947c31d-95a1-488e-a865-c400e90aeba8-b836f8f17b946770.png,http://192.168.11.4:9000/mall/20250311/7d6d6e89-4fd7-4dbe-8b77-4e540bbae8fa-8e08a8a73c99498b.jpg', NULL, NULL, '1899285136856317953', 11185, '拍照手机', 15, 'OPPO', '{\"颜色\":\"绿色\",\"相机\":\"1800万像素\",\"处理器\":\"高通\",\"续航\":\"4500毫安\"}', 3);
INSERT INTO `sku` VALUES ('1899285137892311041', 'OPPO Reno13续航 4500毫安 颜色 绿色 处理器 联发科 相机 1800万像素 ', 5999, 1919, 'http://192.168.11.4:9000/mall/20250311/341cc6a9-9f4e-437d-8ced-4c83fb389364-b451963abad0a43d.jpg.avif', 'http://192.168.11.4:9000/mall/20250311/11e1198f-aa88-40b2-b3ba-4fa73b7ba0a1-20e298f85c16e529.jpg.jpg,http://192.168.11.4:9000/mall/20250311/b947c31d-95a1-488e-a865-c400e90aeba8-b836f8f17b946770.png,http://192.168.11.4:9000/mall/20250311/7d6d6e89-4fd7-4dbe-8b77-4e540bbae8fa-8e08a8a73c99498b.jpg', NULL, NULL, '1899285136856317953', 11185, '拍照手机', 15, 'OPPO', '{\"颜色\":\"绿色\",\"相机\":\"1800万像素\",\"处理器\":\"联发科\",\"续航\":\"4500毫安\"}', 3);
INSERT INTO `sku` VALUES ('1900468604265164801', '小米 Redmi Note13Pro续航 5100毫安 颜色 黑色 处理器 高通 相机 4000万像素 ', 2999, 114, 'http://192.168.11.4:9000/mall/20250314/ff3cf60a-8247-4111-b192-b1740eb7727a-54ab5caeba08dcf4.jpg', 'http://192.168.11.4:9000/mall/20250314/493dc3ec-2cc3-40da-a336-43ecbcbc4f34-54ab5caeba08dcf4.jpg,http://192.168.11.4:9000/mall/20250314/25d7613c-915f-49d7-8dd5-ce16fe278fb7-77df702b689ee3f4.jpg,http://192.168.11.4:9000/mall/20250314/0fdbd3e5-c53b-4f3a-8d09-ed5394ca14bd-7c5e1c461f70474b.jpg,http://192.168.11.4:9000/mall/20250314/6d57e43b-6a82-4000-b93a-c2c714cf07ad-1db775f8ac979bda.jpg', NULL, NULL, '1900468603992535042', 11185, '拍照手机', 16, '小米 Redmi Note13Pro', '{\"颜色\":\"黑色\",\"相机\":\"4000万像素\",\"处理器\":\"高通\",\"续航\":\"5100毫安\"}', 3);
INSERT INTO `sku` VALUES ('1900468604395188226', '小米 Redmi Note13Pro续航 5100毫安 颜色 黑色 处理器 高通 相机 1800万像素 ', 3199, 514, 'http://192.168.11.4:9000/mall/20250314/014fd218-9f54-42e6-bf2c-f95955a41414-54ab5caeba08dcf4.jpg', 'http://192.168.11.4:9000/mall/20250314/493dc3ec-2cc3-40da-a336-43ecbcbc4f34-54ab5caeba08dcf4.jpg,http://192.168.11.4:9000/mall/20250314/25d7613c-915f-49d7-8dd5-ce16fe278fb7-77df702b689ee3f4.jpg,http://192.168.11.4:9000/mall/20250314/0fdbd3e5-c53b-4f3a-8d09-ed5394ca14bd-7c5e1c461f70474b.jpg,http://192.168.11.4:9000/mall/20250314/6d57e43b-6a82-4000-b93a-c2c714cf07ad-1db775f8ac979bda.jpg', NULL, NULL, '1900468603992535042', 11185, '拍照手机', 16, '小米 Redmi Note13Pro', '{\"颜色\":\"黑色\",\"相机\":\"1800万像素\",\"处理器\":\"高通\",\"续航\":\"5100毫安\"}', 3);
INSERT INTO `sku` VALUES ('1900468604525211650', '小米 Redmi Note13Pro续航 5100毫安 颜色 白色 处理器 高通 相机 4000万像素 ', 2999, 1919, 'http://192.168.11.4:9000/mall/20250314/95431d48-987f-48b3-ab45-7b6a86f2f7f6-54ab5caeba08dcf4.jpg', 'http://192.168.11.4:9000/mall/20250314/493dc3ec-2cc3-40da-a336-43ecbcbc4f34-54ab5caeba08dcf4.jpg,http://192.168.11.4:9000/mall/20250314/25d7613c-915f-49d7-8dd5-ce16fe278fb7-77df702b689ee3f4.jpg,http://192.168.11.4:9000/mall/20250314/0fdbd3e5-c53b-4f3a-8d09-ed5394ca14bd-7c5e1c461f70474b.jpg,http://192.168.11.4:9000/mall/20250314/6d57e43b-6a82-4000-b93a-c2c714cf07ad-1db775f8ac979bda.jpg', NULL, NULL, '1900468603992535042', 11185, '拍照手机', 16, '小米 Redmi Note13Pro', '{\"颜色\":\"白色\",\"相机\":\"4000万像素\",\"处理器\":\"高通\",\"续航\":\"5100毫安\"}', 3);
INSERT INTO `sku` VALUES ('1900468604651040769', '小米 Redmi Note13Pro续航 5100毫安 颜色 白色 处理器 高通 相机 1800万像素 ', 3199, 810, 'http://192.168.11.4:9000/mall/20250314/f8d35f4f-5dce-46a7-9764-b1d7f0dd8b2a-54ab5caeba08dcf4.jpg', 'http://192.168.11.4:9000/mall/20250314/493dc3ec-2cc3-40da-a336-43ecbcbc4f34-54ab5caeba08dcf4.jpg,http://192.168.11.4:9000/mall/20250314/25d7613c-915f-49d7-8dd5-ce16fe278fb7-77df702b689ee3f4.jpg,http://192.168.11.4:9000/mall/20250314/0fdbd3e5-c53b-4f3a-8d09-ed5394ca14bd-7c5e1c461f70474b.jpg,http://192.168.11.4:9000/mall/20250314/6d57e43b-6a82-4000-b93a-c2c714cf07ad-1db775f8ac979bda.jpg', NULL, NULL, '1900468603992535042', 11185, '拍照手机', 16, '小米 Redmi Note13Pro', '{\"颜色\":\"白色\",\"相机\":\"1800万像素\",\"处理器\":\"高通\",\"续航\":\"5100毫安\"}', 3);
INSERT INTO `sku` VALUES ('1900468604713955329', '小米 Redmi Note13Pro续航 5100毫安 颜色 红色 处理器 高通 相机 4000万像素 ', 3199, 114, 'http://192.168.11.4:9000/mall/20250314/488c7d1c-bab7-48e5-8dd3-1f550e4c1a66-54ab5caeba08dcf4.jpg', 'http://192.168.11.4:9000/mall/20250314/493dc3ec-2cc3-40da-a336-43ecbcbc4f34-54ab5caeba08dcf4.jpg,http://192.168.11.4:9000/mall/20250314/25d7613c-915f-49d7-8dd5-ce16fe278fb7-77df702b689ee3f4.jpg,http://192.168.11.4:9000/mall/20250314/0fdbd3e5-c53b-4f3a-8d09-ed5394ca14bd-7c5e1c461f70474b.jpg,http://192.168.11.4:9000/mall/20250314/6d57e43b-6a82-4000-b93a-c2c714cf07ad-1db775f8ac979bda.jpg', NULL, NULL, '1900468603992535042', 11185, '拍照手机', 16, '小米 Redmi Note13Pro', '{\"颜色\":\"红色\",\"相机\":\"4000万像素\",\"处理器\":\"高通\",\"续航\":\"5100毫安\"}', 3);
INSERT INTO `sku` VALUES ('1900468604911087618', '小米 Redmi Note13Pro续航 5100毫安 颜色 红色 处理器 高通 相机 1800万像素 ', 3299, 514, 'http://192.168.11.4:9000/mall/20250314/a446634a-1a5b-4980-9dd0-19bbaf10ef08-54ab5caeba08dcf4.jpg', 'http://192.168.11.4:9000/mall/20250314/493dc3ec-2cc3-40da-a336-43ecbcbc4f34-54ab5caeba08dcf4.jpg,http://192.168.11.4:9000/mall/20250314/25d7613c-915f-49d7-8dd5-ce16fe278fb7-77df702b689ee3f4.jpg,http://192.168.11.4:9000/mall/20250314/0fdbd3e5-c53b-4f3a-8d09-ed5394ca14bd-7c5e1c461f70474b.jpg,http://192.168.11.4:9000/mall/20250314/6d57e43b-6a82-4000-b93a-c2c714cf07ad-1db775f8ac979bda.jpg', NULL, NULL, '1900468603992535042', 11185, '拍照手机', 16, '小米 Redmi Note13Pro', '{\"颜色\":\"红色\",\"相机\":\"1800万像素\",\"处理器\":\"高通\",\"续航\":\"5100毫安\"}', 3);
INSERT INTO `sku` VALUES ('1900832882943889409', '苹果 iPhone 16 手机相机像素 6400万像素 CPU型号 A18 运行内存 8GB 屏幕尺寸 6.3-6.59英寸 机身内存 256GB 电池容量 4000mAh 机身色系 黑色系 ', 5999, 113, 'http://192.168.11.4:9000/mall/20250315/333fdb84-ebe3-411d-b569-46e104309183-99a26a6bab464b4c.png', 'http://192.168.11.4:9000/mall/20250315/333fdb84-ebe3-411d-b569-46e104309183-99a26a6bab464b4c.png', NULL, NULL, '1900832882818060290', 11188, '高端手机', 17, '苹果 iPhone 16 智能手机', '{\"CPU型号\":\"A18\",\"屏幕尺寸\":\"6.3-6.59英寸\",\"运行内存\":\"8GB\",\"机身内存\":\"256GB\",\"电池容量\":\"4000mAh\",\"相机像素\":\"6400万像素\",\"机身色系\":\"黑色系\"}', 1);
INSERT INTO `sku` VALUES ('1900832883010998273', '苹果 iPhone 16 手机相机像素 6400万像素 CPU型号 A18 运行内存 8GB 屏幕尺寸 6.3-6.59英寸 机身内存 256GB 电池容量 4000mAh 机身色系 绿色系 ', 5999, 514, 'http://192.168.11.4:9000/mall/20250315/5b64c92a-1881-4937-8292-c7ce823dce1f-cfaf8b1ec9969572.png', 'http://192.168.11.4:9000/mall/20250315/5b64c92a-1881-4937-8292-c7ce823dce1f-cfaf8b1ec9969572.png', NULL, NULL, '1900832882818060290', 11188, '高端手机', 17, '苹果 iPhone 16 智能手机', '{\"CPU型号\":\"A18\",\"屏幕尺寸\":\"6.3-6.59英寸\",\"运行内存\":\"8GB\",\"机身内存\":\"256GB\",\"电池容量\":\"4000mAh\",\"相机像素\":\"6400万像素\",\"机身色系\":\"绿色系\"}', 1);
INSERT INTO `sku` VALUES ('1900832883010998274', '苹果 iPhone 16 手机相机像素 6400万像素 CPU型号 A18 运行内存 8GB 屏幕尺寸 6.3-6.59英寸 机身内存 256GB 电池容量 4000mAh 机身色系 白色系 ', 5999, 1918, 'http://192.168.11.4:9000/mall/20250315/01cfabec-e994-4d90-b546-522489a1e1d2-9b60a3453ead9718.png', 'http://192.168.11.4:9000/mall/20250315/01cfabec-e994-4d90-b546-522489a1e1d2-9b60a3453ead9718.png', NULL, NULL, '1900832882818060290', 11188, '高端手机', 17, '苹果 iPhone 16 智能手机', '{\"CPU型号\":\"A18\",\"屏幕尺寸\":\"6.3-6.59英寸\",\"运行内存\":\"8GB\",\"机身内存\":\"256GB\",\"电池容量\":\"4000mAh\",\"相机像素\":\"6400万像素\",\"机身色系\":\"白色系\"}', 1);
INSERT INTO `sku` VALUES ('1900832883073912833', '苹果 iPhone 16 手机相机像素 6400万像素 CPU型号 A18 运行内存 8GB 屏幕尺寸 6.3-6.59英寸 机身内存 128GB 电池容量 4000mAh 机身色系 黑色系 ', 5199, 807, 'http://192.168.11.4:9000/mall/20250315/333fdb84-ebe3-411d-b569-46e104309183-99a26a6bab464b4c.png', 'http://192.168.11.4:9000/mall/20250315/333fdb84-ebe3-411d-b569-46e104309183-99a26a6bab464b4c.png', NULL, NULL, '1900832882818060290', 11188, '高端手机', 17, '苹果 iPhone 16 智能手机', '{\"CPU型号\":\"A18\",\"屏幕尺寸\":\"6.3-6.59英寸\",\"运行内存\":\"8GB\",\"机身内存\":\"128GB\",\"电池容量\":\"4000mAh\",\"相机像素\":\"6400万像素\",\"机身色系\":\"黑色系\"}', 1);
INSERT INTO `sku` VALUES ('1900832883073912834', '苹果 iPhone 16 手机相机像素 6400万像素 CPU型号 A18 运行内存 8GB 屏幕尺寸 6.3-6.59英寸 机身内存 128GB 电池容量 4000mAh 机身色系 绿色系 ', 5199, 1145, 'http://192.168.11.4:9000/mall/20250315/5b64c92a-1881-4937-8292-c7ce823dce1f-cfaf8b1ec9969572.png', 'http://192.168.11.4:9000/mall/20250315/5b64c92a-1881-4937-8292-c7ce823dce1f-cfaf8b1ec9969572.png', NULL, NULL, '1900832882818060290', 11188, '高端手机', 17, '苹果 iPhone 16 智能手机', '{\"CPU型号\":\"A18\",\"屏幕尺寸\":\"6.3-6.59英寸\",\"运行内存\":\"8GB\",\"机身内存\":\"128GB\",\"电池容量\":\"4000mAh\",\"相机像素\":\"6400万像素\",\"机身色系\":\"绿色系\"}', 1);
INSERT INTO `sku` VALUES ('1900832883141021697', '苹果 iPhone 16 手机相机像素 6400万像素 CPU型号 A18 运行内存 8GB 屏幕尺寸 6.3-6.59英寸 机身内存 128GB 电池容量 4000mAh 机身色系 白色系 ', 5199, 8, 'http://192.168.11.4:9000/mall/20250315/01cfabec-e994-4d90-b546-522489a1e1d2-9b60a3453ead9718.png', 'http://192.168.11.4:9000/mall/20250315/01cfabec-e994-4d90-b546-522489a1e1d2-9b60a3453ead9718.png', NULL, NULL, '1900832882818060290', 11188, '高端手机', 17, '苹果 iPhone 16 智能手机', '{\"CPU型号\":\"A18\",\"屏幕尺寸\":\"6.3-6.59英寸\",\"运行内存\":\"8GB\",\"机身内存\":\"128GB\",\"电池容量\":\"4000mAh\",\"相机像素\":\"6400万像素\",\"机身色系\":\"白色系\"}', 1);
INSERT INTO `sku` VALUES ('1900832883141021698', '苹果 iPhone 16 手机相机像素 6400万像素 CPU型号 A18 运行内存 8GB 屏幕尺寸 6.3-6.59英寸 机身内存 512GB 电池容量 4000mAh 机身色系 黑色系 ', 7999, 191, 'http://192.168.11.4:9000/mall/20250315/333fdb84-ebe3-411d-b569-46e104309183-99a26a6bab464b4c.png', 'http://192.168.11.4:9000/mall/20250315/333fdb84-ebe3-411d-b569-46e104309183-99a26a6bab464b4c.png', NULL, NULL, '1900832882818060290', 11188, '高端手机', 17, '苹果 iPhone 16 智能手机', '{\"CPU型号\":\"A18\",\"屏幕尺寸\":\"6.3-6.59英寸\",\"运行内存\":\"8GB\",\"机身内存\":\"512GB\",\"电池容量\":\"4000mAh\",\"相机像素\":\"6400万像素\",\"机身色系\":\"黑色系\"}', 1);
INSERT INTO `sku` VALUES ('1900832883208130561', '苹果 iPhone 16 手机相机像素 6400万像素 CPU型号 A18 运行内存 8GB 屏幕尺寸 6.3-6.59英寸 机身内存 512GB 电池容量 4000mAh 机身色系 绿色系 ', 7999, 9804, 'http://192.168.11.4:9000/mall/20250315/5b64c92a-1881-4937-8292-c7ce823dce1f-cfaf8b1ec9969572.png', 'http://192.168.11.4:9000/mall/20250315/5b64c92a-1881-4937-8292-c7ce823dce1f-cfaf8b1ec9969572.png', NULL, NULL, '1900832882818060290', 11188, '高端手机', 17, '苹果 iPhone 16 智能手机', '{\"CPU型号\":\"A18\",\"屏幕尺寸\":\"6.3-6.59英寸\",\"运行内存\":\"8GB\",\"机身内存\":\"512GB\",\"电池容量\":\"4000mAh\",\"相机像素\":\"6400万像素\",\"机身色系\":\"绿色系\"}', 1);
INSERT INTO `sku` VALUES ('1900832883275239426', '苹果 iPhone 16 手机相机像素 6400万像素 CPU型号 A18 运行内存 8GB 屏幕尺寸 6.3-6.59英寸 机身内存 512GB 电池容量 4000mAh 机身色系 白色系 ', 7999, 91, 'http://192.168.11.4:9000/mall/20250315/01cfabec-e994-4d90-b546-522489a1e1d2-9b60a3453ead9718.png', 'http://192.168.11.4:9000/mall/20250315/01cfabec-e994-4d90-b546-522489a1e1d2-9b60a3453ead9718.png', NULL, NULL, '1900832882818060290', 11188, '高端手机', 17, '苹果 iPhone 16 智能手机', '{\"CPU型号\":\"A18\",\"屏幕尺寸\":\"6.3-6.59英寸\",\"运行内存\":\"8GB\",\"机身内存\":\"512GB\",\"电池容量\":\"4000mAh\",\"相机像素\":\"6400万像素\",\"机身色系\":\"白色系\"}', 1);
INSERT INTO `sku` VALUES ('1900839443506434050', '小米手机 Redmi Note13R 5G 120Hz LCD护眼屏幕相机像素 5400万像素 CPU型号 骁龙8 至尊版 运行内存 8GB 屏幕尺寸 6.6-6.79英寸 机身内存 256GB 电池容量 5000mAh 机身色系 白色系 ', 899, 108, 'http://192.168.11.4:9000/mall/20250315/2ee53602-0612-45a1-8629-69ceda94ebc6-352de3b3e9639440.jpg.avif', 'http://192.168.11.4:9000/mall/20250315/be27a163-76d1-4076-b88a-c811cfcd5526-352de3b3e9639440.jpg,http://192.168.11.4:9000/mall/20250315/89d01184-e136-478d-9864-fafaf1a879f0-60744893e89bd4d5.png,http://192.168.11.4:9000/mall/20250315/5a62542b-b20b-4f58-b11d-d66e5af9ca27-62bf551647410dfb.png', NULL, NULL, '1900839443372216322', 11187, '性价比手机', 18, '小米手机 Redmi Note13R 5G 120Hz LCD护眼屏幕', '{\"CPU型号\":\"骁龙8 至尊版\",\"屏幕尺寸\":\"6.6-6.79英寸\",\"运行内存\":\"8GB\",\"机身内存\":\"256GB\",\"电池容量\":\"5000mAh\",\"相机像素\":\"5400万像素\",\"机身色系\":\"白色系\"}', 1);
INSERT INTO `sku` VALUES ('1900839443506434051', '小米手机 Redmi Note13R 5G 120Hz LCD护眼屏幕相机像素 5400万像素 CPU型号 骁龙8 至尊版 运行内存 8GB 屏幕尺寸 6.6-6.79英寸 机身内存 256GB 电池容量 5000mAh 机身色系 黑色系 ', 899, 512, 'http://192.168.11.4:9000/mall/20250315/6fe6ba23-7bf8-487e-ae45-672f60eb3122-6dd09468682fc9e8.jpg.avif', 'http://192.168.11.4:9000/mall/20250315/be27a163-76d1-4076-b88a-c811cfcd5526-352de3b3e9639440.jpg,http://192.168.11.4:9000/mall/20250315/89d01184-e136-478d-9864-fafaf1a879f0-60744893e89bd4d5.png,http://192.168.11.4:9000/mall/20250315/5a62542b-b20b-4f58-b11d-d66e5af9ca27-62bf551647410dfb.png', NULL, NULL, '1900839443372216322', 11187, '性价比手机', 18, '小米手机 Redmi Note13R 5G 120Hz LCD护眼屏幕', '{\"CPU型号\":\"骁龙8 至尊版\",\"屏幕尺寸\":\"6.6-6.79英寸\",\"运行内存\":\"8GB\",\"机身内存\":\"256GB\",\"电池容量\":\"5000mAh\",\"相机像素\":\"5400万像素\",\"机身色系\":\"黑色系\"}', 1);
INSERT INTO `sku` VALUES ('1900839443569348609', '小米手机 Redmi Note13R 5G 120Hz LCD护眼屏幕相机像素 5400万像素 CPU型号 骁龙8 至尊版 运行内存 8GB 屏幕尺寸 6.6-6.79英寸 机身内存 128GB 电池容量 5000mAh 机身色系 白色系 ', 799, 1912, 'http://192.168.11.4:9000/mall/20250315/efd85c12-8648-4f8d-bc9d-f3ff02c5ff9c-352de3b3e9639440.jpg.avif', 'http://192.168.11.4:9000/mall/20250315/be27a163-76d1-4076-b88a-c811cfcd5526-352de3b3e9639440.jpg,http://192.168.11.4:9000/mall/20250315/89d01184-e136-478d-9864-fafaf1a879f0-60744893e89bd4d5.png,http://192.168.11.4:9000/mall/20250315/5a62542b-b20b-4f58-b11d-d66e5af9ca27-62bf551647410dfb.png', NULL, NULL, '1900839443372216322', 11187, '性价比手机', 18, '小米手机 Redmi Note13R 5G 120Hz LCD护眼屏幕', '{\"CPU型号\":\"骁龙8 至尊版\",\"屏幕尺寸\":\"6.6-6.79英寸\",\"运行内存\":\"8GB\",\"机身内存\":\"128GB\",\"电池容量\":\"5000mAh\",\"相机像素\":\"5400万像素\",\"机身色系\":\"白色系\"}', 1);
INSERT INTO `sku` VALUES ('1900839443569348610', '小米手机 Redmi Note13R 5G 120Hz LCD护眼屏幕相机像素 5400万像素 CPU型号 骁龙8 至尊版 运行内存 8GB 屏幕尺寸 6.6-6.79英寸 机身内存 128GB 电池容量 5000mAh 机身色系 黑色系 ', 799, 113, 'http://192.168.11.4:9000/mall/20250315/610fd827-7872-4561-9725-a37fbaa55d0d-6dd09468682fc9e8.jpg.avif', 'http://192.168.11.4:9000/mall/20250315/be27a163-76d1-4076-b88a-c811cfcd5526-352de3b3e9639440.jpg,http://192.168.11.4:9000/mall/20250315/89d01184-e136-478d-9864-fafaf1a879f0-60744893e89bd4d5.png,http://192.168.11.4:9000/mall/20250315/5a62542b-b20b-4f58-b11d-d66e5af9ca27-62bf551647410dfb.png', NULL, NULL, '1900839443372216322', 11187, '性价比手机', 18, '小米手机 Redmi Note13R 5G 120Hz LCD护眼屏幕', '{\"CPU型号\":\"骁龙8 至尊版\",\"屏幕尺寸\":\"6.6-6.79英寸\",\"运行内存\":\"8GB\",\"机身内存\":\"128GB\",\"电池容量\":\"5000mAh\",\"相机像素\":\"5400万像素\",\"机身色系\":\"黑色系\"}', 1);
INSERT INTO `sku` VALUES ('1900839443632263170', '小米手机 Redmi Note13R 5G 120Hz LCD护眼屏幕相机像素 5400万像素 CPU型号 骁龙8 至尊版 运行内存 12GB 屏幕尺寸 6.6-6.79英寸 机身内存 256GB 电池容量 5000mAh 机身色系 白色系 ', 1999, 510, 'http://192.168.11.4:9000/mall/20250315/ad54c031-5087-4044-b48a-c829691a1f3d-352de3b3e9639440.jpg.avif', 'http://192.168.11.4:9000/mall/20250315/be27a163-76d1-4076-b88a-c811cfcd5526-352de3b3e9639440.jpg,http://192.168.11.4:9000/mall/20250315/89d01184-e136-478d-9864-fafaf1a879f0-60744893e89bd4d5.png,http://192.168.11.4:9000/mall/20250315/5a62542b-b20b-4f58-b11d-d66e5af9ca27-62bf551647410dfb.png', NULL, NULL, '1900839443372216322', 11187, '性价比手机', 18, '小米手机 Redmi Note13R 5G 120Hz LCD护眼屏幕', '{\"CPU型号\":\"骁龙8 至尊版\",\"屏幕尺寸\":\"6.6-6.79英寸\",\"运行内存\":\"12GB\",\"机身内存\":\"256GB\",\"电池容量\":\"5000mAh\",\"相机像素\":\"5400万像素\",\"机身色系\":\"白色系\"}', 1);
INSERT INTO `sku` VALUES ('1900839443632263171', '小米手机 Redmi Note13R 5G 120Hz LCD护眼屏幕相机像素 5400万像素 CPU型号 骁龙8 至尊版 运行内存 12GB 屏幕尺寸 6.6-6.79英寸 机身内存 256GB 电池容量 5000mAh 机身色系 黑色系 ', 1999, 102, 'http://192.168.11.4:9000/mall/20250315/c4a67d3c-d184-4400-bec4-e5a3e46a1faa-6dd09468682fc9e8.jpg.avif', 'http://192.168.11.4:9000/mall/20250315/be27a163-76d1-4076-b88a-c811cfcd5526-352de3b3e9639440.jpg,http://192.168.11.4:9000/mall/20250315/89d01184-e136-478d-9864-fafaf1a879f0-60744893e89bd4d5.png,http://192.168.11.4:9000/mall/20250315/5a62542b-b20b-4f58-b11d-d66e5af9ca27-62bf551647410dfb.png', NULL, NULL, '1900839443372216322', 11187, '性价比手机', 18, '小米手机 Redmi Note13R 5G 120Hz LCD护眼屏幕', '{\"CPU型号\":\"骁龙8 至尊版\",\"屏幕尺寸\":\"6.6-6.79英寸\",\"运行内存\":\"12GB\",\"机身内存\":\"256GB\",\"电池容量\":\"5000mAh\",\"相机像素\":\"5400万像素\",\"机身色系\":\"黑色系\"}', 1);
INSERT INTO `sku` VALUES ('1900839443695177730', '小米手机 Redmi Note13R 5G 120Hz LCD护眼屏幕相机像素 5400万像素 CPU型号 骁龙8 至尊版 运行内存 12GB 屏幕尺寸 6.6-6.79英寸 机身内存 128GB 电池容量 5000mAh 机身色系 白色系 ', 1699, 510, 'http://192.168.11.4:9000/mall/20250315/563945e6-4ee1-40f0-8ac8-d73b5cb6e98a-352de3b3e9639440.jpg.avif', 'http://192.168.11.4:9000/mall/20250315/be27a163-76d1-4076-b88a-c811cfcd5526-352de3b3e9639440.jpg,http://192.168.11.4:9000/mall/20250315/89d01184-e136-478d-9864-fafaf1a879f0-60744893e89bd4d5.png,http://192.168.11.4:9000/mall/20250315/5a62542b-b20b-4f58-b11d-d66e5af9ca27-62bf551647410dfb.png', NULL, NULL, '1900839443372216322', 11187, '性价比手机', 18, '小米手机 Redmi Note13R 5G 120Hz LCD护眼屏幕', '{\"CPU型号\":\"骁龙8 至尊版\",\"屏幕尺寸\":\"6.6-6.79英寸\",\"运行内存\":\"12GB\",\"机身内存\":\"128GB\",\"电池容量\":\"5000mAh\",\"相机像素\":\"5400万像素\",\"机身色系\":\"白色系\"}', 1);
INSERT INTO `sku` VALUES ('1900839443695177731', '小米手机 Redmi Note13R 5G 120Hz LCD护眼屏幕相机像素 5400万像素 CPU型号 骁龙8 至尊版 运行内存 12GB 屏幕尺寸 6.6-6.79英寸 机身内存 128GB 电池容量 5000mAh 机身色系 黑色系 ', 1699, 98, 'http://192.168.11.4:9000/mall/20250315/cee963a9-10c1-47da-ba23-f80b10ed399d-6dd09468682fc9e8.jpg.avif', 'http://192.168.11.4:9000/mall/20250315/be27a163-76d1-4076-b88a-c811cfcd5526-352de3b3e9639440.jpg,http://192.168.11.4:9000/mall/20250315/89d01184-e136-478d-9864-fafaf1a879f0-60744893e89bd4d5.png,http://192.168.11.4:9000/mall/20250315/5a62542b-b20b-4f58-b11d-d66e5af9ca27-62bf551647410dfb.png', NULL, NULL, '1900839443372216322', 11187, '性价比手机', 18, '小米手机 Redmi Note13R 5G 120Hz LCD护眼屏幕', '{\"CPU型号\":\"骁龙8 至尊版\",\"屏幕尺寸\":\"6.6-6.79英寸\",\"运行内存\":\"12GB\",\"机身内存\":\"128GB\",\"电池容量\":\"5000mAh\",\"相机像素\":\"5400万像素\",\"机身色系\":\"黑色系\"}', 1);
INSERT INTO `sku` VALUES ('1907020261383745538', '华为手机1CPU型号 天玑9300  运行内存 6GB 屏幕尺寸 6.3-6.59英寸 机身色系 纯色 ', 1999, 100, 'http://192.168.11.4:9000/mall/20250401/9542d26d-0f59-42b0-9e7f-dd76ab0c12e0-7a7b8771e3d6457686f0f10819c4f82c.png', 'http://192.168.11.4:9000/mall/20250401/a0bc6cf3-5dd5-46e2-a17d-cc76c903195a-7a6e07fb952a410eb321bc6f58058762.jpg,http://192.168.11.4:9000/mall/20250401/8e7f28be-7748-4f70-a902-c8e62c2c2cdd-7b49edbb35c743c7ba8343011b3bba3d.jpg', NULL, NULL, '1907020261366968321', 11184, '游戏手机', 19, '华为手机1', '{\"CPU型号\":\"天玑9300 \",\"屏幕尺寸\":\"6.3-6.59英寸\",\"运行内存\":\"6GB\",\"机身色系\":\"纯色\"}', 1);
INSERT INTO `sku` VALUES ('1907020261450854402', '华为手机1CPU型号 天玑9300  运行内存 6GB 屏幕尺寸 6.3-6.59英寸 机身色系 黑色系 ', 1999, 100, 'http://192.168.11.4:9000/mall/20250401/a1161c6a-b332-4d41-8574-f7d4b9b75e78-7a7b8771e3d6457686f0f10819c4f82c.png', 'http://192.168.11.4:9000/mall/20250401/a0bc6cf3-5dd5-46e2-a17d-cc76c903195a-7a6e07fb952a410eb321bc6f58058762.jpg,http://192.168.11.4:9000/mall/20250401/8e7f28be-7748-4f70-a902-c8e62c2c2cdd-7b49edbb35c743c7ba8343011b3bba3d.jpg', NULL, NULL, '1907020261366968321', 11184, '游戏手机', 19, '华为手机1', '{\"CPU型号\":\"天玑9300 \",\"屏幕尺寸\":\"6.3-6.59英寸\",\"运行内存\":\"6GB\",\"机身色系\":\"黑色系\"}', 1);

-- ----------------------------
-- Table structure for sku_attribute
-- ----------------------------
DROP TABLE IF EXISTS `sku_attribute`;
CREATE TABLE `sku_attribute`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '属性名称',
  `options` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '属性选项',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sku_attribute
-- ----------------------------
INSERT INTO `sku_attribute` VALUES (19, 'CPU型号', '骁龙8 至尊版,第三代骁龙8 领先版,第三代骁龙8,第三代骁龙8s,第二代骁龙8 领先版,第二代骁龙8,第一代骁龙8+ ,第三代骁龙7+ ,第三代骁龙7s,第三代骁龙7,第二代骁龙7+,天玑9400,天玑9300+,天玑9300 ,天玑9200+,天玑9200,天玑8400-Ultra,天玑8400-MAX,天玑8300-Ultra,天玑8350,A18,A18 Pro ,A17 Pro,A16,A15,Apple A系列,麒麟9000,麒麟9000系列,麒麟990系列,麒麟98X,麒麟800系列,麒麟700系列,骁龙888+', NULL);
INSERT INTO `sku_attribute` VALUES (20, '屏幕尺寸', '7英寸以上,6.8-7.0英寸,6.6-6.79英寸,6.3-6.59英寸,6.0-6.29英寸,6.0英寸以下', NULL);
INSERT INTO `sku_attribute` VALUES (21, '运行内存', '24GB,18GB,16GB,12GB,8GB,6GB,4GB,3GB以下', NULL);
INSERT INTO `sku_attribute` VALUES (22, '机身内存', '1TB,512GB,256GB,128GB,64GB以下', NULL);
INSERT INTO `sku_attribute` VALUES (23, '电池容量', '7000mAh以上,6000mAh,5000mAh,4000mAh', NULL);
INSERT INTO `sku_attribute` VALUES (24, '相机像素', '2亿像素,1亿像素,6400万像素,5400万像素,5000万像素,4800万像素,4000万像素,1300万像素,1200万像素', NULL);
INSERT INTO `sku_attribute` VALUES (25, '机身色系', '纯色,黑色系,红色系,绿色系,白色系,蓝色系,紫色系,金色系,银色系,混合色系,浅蓝色系', NULL);
INSERT INTO `sku_attribute` VALUES (26, '像素', '10000万像素,20000万像素', NULL);

-- ----------------------------
-- Table structure for spu
-- ----------------------------
DROP TABLE IF EXISTS `spu`;
CREATE TABLE `spu`  (
  `id` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'SPU名',
  `intro` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '简介',
  `brand_id` int(11) NULL DEFAULT NULL COMMENT '品牌ID',
  `category_one_id` int(20) NULL DEFAULT NULL COMMENT '一级分类',
  `category_two_id` int(10) NULL DEFAULT NULL COMMENT '二级分类',
  `category_three_id` int(10) NULL DEFAULT NULL COMMENT '三级分类',
  `images` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片列表',
  `after_sales_service` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '售后服务',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '介绍',
  `attribute_list` varchar(3000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '规格列表',
  `is_marketable` int(1) NULL DEFAULT 0 COMMENT '是否上架,0已下架，1已上架',
  `is_delete` int(1) NULL DEFAULT 0 COMMENT '是否删除,0:未删除，1：已删除',
  `status` int(1) NULL DEFAULT 0 COMMENT '审核状态，0：未审核，1：已审核，2：审核不通过',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of spu
-- ----------------------------
INSERT INTO `spu` VALUES ('1318594982147334146', 'ces', 's', 11, 11157, 11158, 11159, 'https://img14.360buyimg.com/pop/jfs/t1/151337/18/23177/57248/641c1604F11e31ec4/daf39fbae31031b1.png', NULL, '', '{\"ds\":[\"d\"],\"fd\":[\"ff\"],\"大小\":[\"中\"]}', 1, 1, 1);
INSERT INTO `spu` VALUES ('1318596430293704706', 'ee', 'e', 11, 11157, 11158, 11159, 'https://img14.360buyimg.com/pop/jfs/t1/151337/18/23177/57248/641c1604F11e31ec4/daf39fbae31031b1.png', NULL, '<p>ces</p>', '{\"fd\":[\"ff\"],\"大小\":[\"大\",\"中\"]}', 1, 1, 1);
INSERT INTO `spu` VALUES ('1318599511492317185', 'ces2', 'ddes', 11, 11157, 11158, 11159, 'https://img14.360buyimg.com/pop/jfs/t1/151337/18/23177/57248/641c1604F11e31ec4/daf39fbae31031b1.png', NULL, '<p>gdfg</p>', '{\"ds\":[\"d\"],\"fd\":[\"ff\"],\"大小\":[\"大\",\"中\"]}', 1, 1, 1);
INSERT INTO `spu` VALUES ('1319051488177254401', '小米10促销活培训课', '双十一电销小米10大促销！最后三天！', 12, 11157, 11158, 11159, 'https://img14.360buyimg.com/pop/jfs/t1/151337/18/23177/57248/641c1604F11e31ec4/daf39fbae31031b1.png', NULL, '<p>促销课程！促销课程！促销课程！促销课程！促销课程！促销课程！促销课程！促销课程！促销课程！促销课程！促销课程！促销课程！促销课程！促销课程！促销课程！促销课程！促销课程！促销课程！促销课程！促销课程！促销课程！促销课程！促销课程！促销课程！促销课程！促销课程！促销课程！促销课程！促销课程！促销课程！促销课程！促销课程！促销课程！促销课程！促销课程！促销课程！促销课程！促销课程！促销课程！促销课程！促销课程！促销课程！促销课程！促销课程！促销课程！促销课程！促销课程！促销课程！促销课程！促销课程！促销课程！促销课程！促销课程！促销课程！促销课程！促销课程！</p>', '{\"就业薪资\":[\"6K起\",\"10K起\"],\"学习费用\":[\"1万\",\"2万\"]}', 1, 1, 1);
INSERT INTO `spu` VALUES ('1820820599417643009', '小米mate', '小米mate-测试', 11, 11157, 11158, 11159, 'https://img14.360buyimg.com/pop/jfs/t1/151337/18/23177/57248/641c1604F11e31ec4/daf39fbae31031b1.png', NULL, '<p>小米mate</p>', '{\"类型\":[\"培训\",\"市场管理\"],\"就业薪资\":[\"10K起\"],\"学习费用\":[\"2万\",\"9988\"],\"应用场景\":[\"软件研发\"]}', 1, 1, 1);
INSERT INTO `spu` VALUES ('1896616083079573505', '超值华为手机绝赞八折中，手慢无', '惠及新老客户，华厂大清仓', 11, 11182, 11183, 11184, 'http://192.168.11.4:9000/mall/20250304/f4b187f7-5985-4ba6-9a06-8d1d53bde7cd-Meituan.jpg,http://192.168.11.4:9000/mall/20250304/4eede9c9-4186-4a3c-abb8-e32c4b5c3e87-stm32.jpg,http://192.168.11.4:9000/mall/20250304/6183460e-5f89-4d05-92da-38f59aa9c2f7-stupidcar.jpg', NULL, '<h1>惠及新老客户，华厂大清仓</h1><p>原价9999的手机，现在只要998带回家</p>', '{}', 1, 1, 1);
INSERT INTO `spu` VALUES ('1896662131890274305', '华为Mate60Pro ', '好手机', 11, 11182, 11183, 11188, 'http://192.168.11.4:9000/mall/20250304/28436a01-015c-4100-beb7-2a7a06418867-QQ图片20250226155713.jpg,http://192.168.11.4:9000/mall/20250304/ed7c34d7-f065-485e-9cbd-af73e9b5a64a-stupidcar.jpg,http://192.168.11.4:9000/mall/20250304/4cb815f8-e418-4406-9f43-941cd5492fff-smt51.jpg', NULL, '<h1>华维新品，爆款手机，现货可自提，手慢无！</h1><p>好评率99.9%，买过的都说好！这已经是我买的第5台了 。</p><p><strong>(拒绝黄牛囤货加价，凭身份证购买，一人仅限一台)</strong></p>', '{\"颜色\":[\"黑色\",\"白色\",\"红色\"],\"相机\":[\"1亿像素\"],\"处理器\":[\"华为\",\"高通\"],\"续航\":[\"5100毫安\"]}', 1, 1, 1);
INSERT INTO `spu` VALUES ('1896664805398364161', '小米 14 Pro ', '好手机', 16, 11182, 11183, 11188, 'http://192.168.11.4:9000/mall/20250304/b04af53c-2d12-4b0d-b75d-4fc016a501f7-Cleaner.png,http://192.168.11.4:9000/mall/20250304/db8693db-91e7-4bce-b285-5fd3f73bfc59-QQ图片20250226155713.jpg,http://192.168.11.4:9000/mall/20250304/7c3c995d-6993-4372-a940-cb5d7480b7ce-i59400.jpg', NULL, '<h1>小米最新爆款手机绝赞首发，不买不是地球人</h1><p><br></p><h2>仅需5000元，外星科技统统带回家，这样捡漏的机会，</h2><h2>每1000年才会有一次，你还在等什么？赶快拿出你的早餐钱买一台</h2>', '{\"颜色\":[\"黑色\",\"白色\",\"绿色\"],\"相机\":[\"1亿像素\"],\"处理器\":[\"高通\",\"联发科\"],\"续航\":[\"6000毫安\"]}', 1, 1, 1);
INSERT INTO `spu` VALUES ('1899285136856317953', 'OPPO Reno13', '拍照效果也很出色，此外芯片和速度也足够快，非常满意的一次购物体验，还送耳机和手机壳，续航很抗打可以用两天，手也不会烫，所以上手就感觉很好，双芯抢网，昨天拿到的新手机，整体很满意，上手手感舒服，运行速度很快，颜色也非常好看', 15, 11182, 11183, 11185, 'http://192.168.11.4:9000/mall/20250311/11e1198f-aa88-40b2-b3ba-4fa73b7ba0a1-20e298f85c16e529.jpg.jpg,http://192.168.11.4:9000/mall/20250311/b947c31d-95a1-488e-a865-c400e90aeba8-b836f8f17b946770.png,http://192.168.11.4:9000/mall/20250311/7d6d6e89-4fd7-4dbe-8b77-4e540bbae8fa-8e08a8a73c99498b.jpg', NULL, '<p>关系型数据库（Relational Database Management System, RDBMS）是传统数据存储的核心技术，其基于<strong>关系模型</strong>（表结构）和<strong>SQL</strong>（结构化查询语言）的设计，广泛应用于事务处理、复杂查询等场景。以下是其核心优势和劣势的详细分析，结合具体示例说明。</p><h3><strong>一、关系型数据库的核心优势</strong></h3><h4>1.&nbsp;<strong>严格的数据一致性与完整性</strong></h4><ul><li><strong>ACID事务支持</strong>：通过原子性（Atomicity）、一致性（Consistency）、隔离性（Isolation）、持久性（Durability）保障数据操作的可靠性。</li><li class=\"ql-indent-1\"><strong>示例</strong>：银行转账操作中，事务确保从一个账户扣款和另一个账户入款同时成功或失败。</li><li><strong>约束机制</strong>：主键、外键、唯一性约束、非空约束等，防止脏数据。</li><li class=\"ql-indent-1\"><strong>示例</strong>：外键约束确保订单表中的用户ID必须存在于用户表中。</li></ul><h4>2.&nbsp;<strong>强大的复杂查询能力</strong></h4><ul><li><strong>SQL标准化</strong>：通过JOIN、子查询、聚合函数（SUM/AVG）等，灵活处理多表关联和复杂逻辑。</li><li><strong>示例</strong>：统计每个用户的订单总金额：</li><li>sql</li><li>复制</li></ul><pre class=\"ql-syntax\" spellcheck=\"false\">SELECT u.user_id, u.name, SUM(o.amount) \nFROM users u \nJOIN orders o ON u.user_id = o.user_id \nGROUP BY u.user_id;\n</pre><h4>3.&nbsp;<strong>结构化数据存储</strong></h4><ul><li><strong>明确的表结构</strong>：字段类型、长度、关系预先定义，适合业务规则固定的场景。</li><li class=\"ql-indent-1\"><strong>示例</strong>：电商平台的商品表（商品ID、名称、价格、库存）和订单表（订单ID、用户ID、商品ID、数量）。</li></ul><h4>4.&nbsp;<strong>成熟的生态系统</strong></h4><ul><li><strong>工具支持</strong>：可视化工具（如MySQL Workbench）、ORM框架（如Hibernate）、备份工具等。</li><li><strong>社区与文档</strong>：MySQL、PostgreSQL等主流数据库拥有庞大的开发者社区和丰富的学习资源。</li></ul><h4>5.&nbsp;<strong>适合事务型场景</strong></h4><ul><li><strong>高并发事务</strong>：如金融系统、库存管理，要求数据强一致性。</li><li class=\"ql-indent-1\"><strong>示例</strong>：航空订票系统中，事务确保同一座位不会被重复售出。</li></ul><h3><strong>二、关系型数据库的主要劣势</strong></h3><h4>1.&nbsp;<strong>扩展性限制</strong></h4><ul><li><strong>垂直扩展（Scale-Up）依赖硬件</strong>：通过提升单机性能（CPU、内存）扩展，成本高且有上限。</li><li><strong>水平扩展（Scale-Out）复杂</strong>：分库分表（如MySQL Sharding）需要手动管理，跨节点事务（如分布式事务）实现困难。</li><li class=\"ql-indent-1\"><strong>示例</strong>：社交平台用户量激增时，分库分表导致查询逻辑复杂化。</li></ul><h4>2.&nbsp;<strong>处理非结构化数据效率低</strong></h4><ul><li><strong>JSON/XML等半结构化数据支持有限</strong>：虽然现代数据库（如PostgreSQL）支持JSON字段，但查询性能不如文档型数据库（如MongoDB）。</li><li class=\"ql-indent-1\"><strong>示例</strong>：存储动态表单数据（字段可能频繁变化），关系型数据库需要频繁修改表结构。</li></ul><h4>3.&nbsp;<strong>高并发写入性能瓶颈</strong></h4><ul><li><strong>锁机制开销</strong>：行锁、表锁可能引发死锁或阻塞，影响写入吞吐量。</li><li class=\"ql-indent-1\"><strong>示例</strong>：秒杀场景中，大量并发扣减库存可能导致锁竞争。</li></ul><h4>4.&nbsp;<strong>复杂查询性能下降</strong></h4><ul><li><strong>多表JOIN成本高</strong>：大数据量下，JOIN操作可能导致性能骤降。</li><li class=\"ql-indent-1\"><strong>示例</strong>：分析用户行为日志（关联用户表、订单表、日志表）时查询缓慢。</li></ul><h4>5.&nbsp;<strong>模式变更不灵活</strong></h4><ul><li><strong>DDL操作风险</strong>：修改表结构（如新增字段）需要锁表，可能影响线上服务。</li><li class=\"ql-indent-1\"><strong>示例</strong>：给已有10亿条记录的表添加非空字段，需长时间停机维护。</li></ul><h3><strong>三、关系型数据库 vs. NoSQL 的典型场景对比</strong></h3><h3><strong>场景关系型数据库NoSQL数据结构</strong>固定模式（表结构）灵活模式（文档/键值）<strong>事务需求</strong>强一致性（ACID）最终一致性（BASE）<strong>查询复杂度</strong>复杂关联查询简单查询或聚合<strong>扩展性</strong>垂直扩展为主水平扩展（天然分布式）<strong>典型应用</strong>金融系统、ERP社交网络、物联网日志<strong>四、何时选择关系型数据库？</strong></h3><ol><li><strong>强一致性要求</strong>：如支付系统、库存管理。</li><li><strong>复杂业务逻辑</strong>：需多表关联和事务支持（如ERP系统）。</li><li><strong>成熟工具链依赖</strong>：需要ORM、BI工具等生态支持。</li><li><strong>数据模式稳定</strong>：表结构不会频繁变动。</li></ol><h3><strong>五、补充：现代关系型数据库的进化</strong></h3><p>为弥补传统劣势，现代关系型数据库（如&nbsp;<strong>PostgreSQL</strong>、<strong>TiDB</strong>）进行了改进：</p><ul><li><strong>JSON支持</strong>：PostgreSQL的JSONB类型支持高效查询半结构化数据。</li><li><strong>水平扩展</strong>：TiDB（分布式NewSQL）支持自动分片和分布式事务。</li><li><strong>分析优化</strong>：列式存储（如Amazon Redshift）提升大数据分析性能。</li></ul><h3><strong>总结</strong></h3><p>关系型数据库在<strong>数据一致性</strong>和<strong>复杂查询</strong>场景下不可替代，但在<strong>高并发写入</strong>、<strong>非结构化数据</strong>和<strong>水平扩展</strong>场景中需结合NoSQL或NewSQL使用。技术选型时，需根据业务需求权衡其优劣势。</p>', '{\"颜色\":[\"黑色\",\"白色\",\"红色\",\"绿色\"],\"相机\":[\"1亿像素\",\"4000万像素\",\"1800万像素\"],\"处理器\":[\"高通\",\"联发科\"],\"续航\":[\"4500毫安\"]}', 1, 1, 1);
INSERT INTO `spu` VALUES ('1900468603992535042', '小米 Redmi Note13Pro', '可配送全球 · 90天只换不修 · 7天价保 · 免费上门退换 · 365天原厂维修', 16, 11182, 11183, 11185, 'http://192.168.11.4:9000/mall/20250314/493dc3ec-2cc3-40da-a336-43ecbcbc4f34-54ab5caeba08dcf4.jpg,http://192.168.11.4:9000/mall/20250314/25d7613c-915f-49d7-8dd5-ce16fe278fb7-77df702b689ee3f4.jpg,http://192.168.11.4:9000/mall/20250314/0fdbd3e5-c53b-4f3a-8d09-ed5394ca14bd-7c5e1c461f70474b.jpg,http://192.168.11.4:9000/mall/20250314/6d57e43b-6a82-4000-b93a-c2c714cf07ad-1db775f8ac979bda.jpg', NULL, '<h1>17、主键使用自增ID还是UUID，为什么？</h1><p>如果是单机的话，选择自增ID；如果是分布式系统，优先考虑UUID，但还是最好公司自己有一套分布式唯一ID生产方案。自增ID：数据存储空间小，查询效率高。但是如果数据量过大,会超出自增长的值范围，多库合并，也有可能出现问题。uuid：适合大量数据的插入和更新操作，但它是无序的，插入数据效率慢，占用空间大。</p><h1>18、MySQL数据库cpu飙升的话，要怎么处理呢？</h1><p>排查过程：</p><p>使用top命令观察，确定是mysqld导致还是其他原因。</p><p>如果是mysqld导致的，show processlist，查看session情况，确定是不是有消耗资源的sql在运行。</p><p>找出消耗高的 sql，看看执行计划是否准确， 索引是否缺失，数据量是否太大。</p><p>处理：</p><p>kill掉这些线程(同时观察cpu使用率是否下降)，</p><p>进行相应的调整(比如说加索引、改sql、改内存参数)</p><p>重新跑SQL。</p><p>其他情况：</p><p>也有可能是每个sql消耗资源并不多，但是突然之间，有大量的session 连进来导致cpu飙升，这种情况就需要跟应用一起来分析为何连接数会激增，再做出相应的调整，比如说限制连接数等。</p><h1>19、什么是存储过程？有哪些优缺点？</h1><p>存储过程，就是一些编译好了的SQL语句，这些SQL语句代码像一个方法实现一些功能（对单表或多表的增删改查），然后给这些代码块取一个名字，在用到这个功能的时候调用即可。</p><p>优点：</p><p>存储过程是一个预编译的代码块，执行效率比较高，存储过程在服务器端运行，减少客户端的压力，允许模块化程序设计，只需要创建一次过程，以后在程序中就可以调用该过程任意次，类似方法的复用，一个存储过程替代大量SQL语句 ，可以降低网络通信量，提高通信速率，可以一定程度上确保数据安全。</p><p>缺点：</p><p>调试麻烦，可移植性不灵活，存在重新编译问题</p><h1>20、了解什么是表分区吗？表分区的好处有哪些？</h1><p>表分区，是指根据一定规则，将数据库中的一张表分解成多个更小的容易管理的部分。从逻辑上看，只有一张表，但是底层却是由多个物理分区组成。</p><p>存储更多数据。分区表的数据可以分布在不同的物理设备上，从而高效地利用多个硬件设备。和单个磁盘或者文件系统相比，可以存储更多数据。</p><p>优化查询。在where语句中包含分区条件时，可以只扫描一个或多个分区表来提高查询效率；涉及sum和count语句时，也可以在多个分区上并行处理，最后汇总结果。</p><p>分区表更容易维护。例如：想批量删除大量数据可以清除整个分区。</p><p>避免某些特殊的瓶颈，例如InnoDB的单个索引的互斥访问。</p><h1>21、MySQL主从同步原理</h1><p>MySQL主从同步的过程：</p><p>MySQL的主从复制中主要有三个线程： master（binlog dump thread）、slave（I/O thread 、SQLthread） ，Master一条线程和Slave中的两条线程。</p><p>主节点 binlog，主从复制的基础是主库记录数据库的所有变更记录到 binlog。binlog 是数据库服</p><p>务器启动的那一刻起，保存所有修改数据库结构或内容的一个文件。</p><p>主节点 log dump 线程，当 binlog 有变动时，log dump 线程读取其内容并发送给从节点。</p><p>从节点 I/O线程接收 binlog 内容，并将其写入到 relay log 文件中。</p><p>从节点的SQL 线程读取 relay log 文件内容对数据更新进行重放，最终保证主从数据库的一致性。</p><p>注：主从节点使用 binglog 文件 + position 偏移量来定位主从同步的位置，从节点会保存其已接收到的偏移量，如果从节点发生宕机重启，则会自动从 position 的位置发起同步。</p><p>由于MySQL默认的复制方式是异步的，主库把日志发送给从库后不关心从库是否已经处理，这样会产生一个问题就是假设主库挂了，从库处理失败了，这时候从库升为主库后，日志就丢失了。由此产生两个概念。</p><p><strong>全同步复制</strong></p><p>主库写入binlog后强制同步日志到从库，所有的从库都执行完成后才返回给客户端，但是很显然这个方式的话性能会受到严重影响。</p><p><strong>半同步复制</strong></p><p>和全同步不同的是，半同步复制的逻辑是这样，从库写入日志成功后返回ACK确认给主库，主库收到至少一个从库的确认就认为写操作完成。</p><h1>22、简述MyISAM和InnoDB的区别</h1><p><strong>MyISAM：</strong></p><p>1、不支持事务，但是每次查询都是原子的；</p><p>2、支持表级锁，即每次操作是对整个表加锁；</p><p>3、存储表的总行数；</p><p>4、一个MYISAM表有三个文件：索引文件、表结构文件、数据文件；</p><p>5、采用非聚集索引，索引文件的数据域存储指向数据文件的指针。辅索引与主索引基本一致，但是辅索引不用保证唯一性。</p><p><strong>InnoDB</strong>：</p><p>1、支持ACID的事务，支持事务的四种隔离级别；</p><p>2、支持行级锁及外键约束：因此可以支持写并发；</p><p>3、不存储总行数；</p><p>4、一个InnoDB引擎存储在一个文件空间（共享表空间，表大小不受操作系统控制，一个表可能分布在多个文件里），也有可能为多个（设置为独立表空，表大小受操作系统文件大小限制，一般为2G），受操作系统文件大小的限制；</p><p>5、主键索引采用聚集索引（索引的数据域存储数据文件本身），辅索引的数据域存储主键的值；因此从辅索引查找数据，需要先通过辅索引找到主键值，再访问主键索引树；索引最好使用自增主键，防止插入数据时，为维持B+树结构，文件的大调整。</p><h1>23、简述MySQL中索引类型及对数据库的性能的影响</h1><p><strong>普通索引</strong>：允许被索引的数据列包含重复的值。</p><p><strong>唯一索引</strong>：可以保证数据记录的唯一性。</p><p><strong>主键</strong>：是一种特殊的唯一索引，在一张表中只能定义一个主键索引，主键用于唯一标识一条记录，使用关键字 PRIMARY KEY 来创建。</p><p><strong>联合索引</strong>：索引可以覆盖多个数据列，如像INDEX(columnA, columnB)索引。</p><p><strong>全文索引</strong>：通过建立 倒排索引 ,可以极大的提升检索效率,解决判断字段是否包含的问题，是目前搜索引擎使用的一种关键技术。可以通过ALTER TABLE table_name ADD FULLTEXT (column);创建全文索引索引可以极大的提高数据的查询速度。</p><p>通过使用索引，可以在查询的过程中，使用优化隐藏器，提高系统的性能。</p><p>但是会降低插入、删除、更新表的速度，因为在执行这些写操作时，还要操作索引文件</p><p>索引需要占物理空间，除了数据表占数据空间之外，每一个索引还要占一定的物理空间，如果要建立聚簇索引，那么需要的空间就会更大，如果非聚集索引很多，一旦聚集索引改变，那么所有非聚集索引都会跟着变。</p><h1>24、MySQL执行计划怎么看</h1><p>执行计划就是sql的执行查询的顺序，以及如何使用索引查询，返回的结果集的行数</p><p>EXPLAIN SELECT * from A where X=? and Y=?</p><p>1 <strong>.id</strong> ：是一个有顺序的编号，是查询的顺序号，有几个 select 就显示几行。id的顺序是按 select 出现的顺序增长的。id列的值越大执行优先级越高越先执行，id列的值相同则从上往下执行，id列的值为NULL最后执行。</p><p><strong>2.selectType</strong> 表示查询中每个select子句的类型</p><p>SIMPLE： 表示此查询不包含 UNION 查询或子查询</p><p>PRIMARY： 表示此查询是最外层的查询（包含子查询）</p><p>SUBQUERY： 子查询中的第一个 SELECT</p><p>UNION： 表示此查询是 UNION 的第二或随后的查询</p><p>DEPENDENT UNION： UNION 中的第二个或后面的查询语句, 取决于外面的查询</p><p>UNION RESULT, UNION 的结果</p><p>DEPENDENT SUBQUERY: 子查询中的第一个 SELECT, 取决于外面的查询. 即子查询依赖于外层查</p><p>询的结果.</p><p>DERIVED：衍生，表示导出表的SELECT（FROM子句的子查询）</p><p><strong>3.table</strong>：表示该语句查询的表</p><p><strong>4.type：</strong> 优化sql的重要字段，也是我们判断sql性能和优化程度重要指标。他的取值类型范围：</p><p>const：通过索引一次命中，匹配一行数据</p><p>system: 表中只有一行记录，相当于系统表；</p><p>eq_ref：唯一性索引扫描，对于每个索引键，表中只有一条记录与之匹配</p><p>ref: 非唯一性索引扫描,返回匹配某个值的所有</p><p>range: 只检索给定范围的行，使用一个索引来选择行，一般用于between、&lt;、&gt;；</p><p>index: 只遍历索引树；</p><p>ALL: 表示全表扫描，这个类型的查询是性能最差的查询之一。 那么基本就是随着表的数量增多，</p><p>执行效率越慢。</p><p>执行效率：</p><p>**ALL &lt; index &lt; range&lt; ref &lt; eq_ref &lt; const &lt; system。**最好是避免ALL和index</p><p><strong>5.possible_keys</strong>：它表示Mysql在执行该sql语句的时候，可能用到的索引信息，仅仅是可能，实际不一定会用到。</p><p><strong>6.key：</strong> 此字段是 mysql 在当前查询时所真正使用到的索引。 他是possible_keys的子集</p><p><strong>7.key_len</strong>：表示查询优化器使用了索引的字节数，这个字段可以评估组合索引是否完全被使用，这也是我们优化sql时，评估索引的重要指标</p><p><strong>9.rows</strong>：mysql 查询优化器根据统计信息，估算该sql返回结果集需要扫描读取的行数，这个值相关重要，索引优化之后，扫描读取的行数越多，说明索引设置不对，或者字段传入的类型之类的问题，说明要优化空间越大。</p><p><strong>10.filtered：</strong> 返回结果的行占需要读到的行(rows列的值)的百分比，就是百分比越高，说明需要查询到数据越准确， 百分比越小，说明查询到的数据量大，而结果集很少</p><p><strong>11.extra</strong></p><p>using filesort ：表示 mysql 对结果集进行外部排序，不能通过索引顺序达到排序效果。一般有</p><p>using filesort都建议优化去掉，因为这样的查询 cpu 资源消耗大，延时大。</p><p>using index：覆盖索引扫描，表示查询在索引树中就可查找所需数据，不用扫描表数据文件，往</p><p>往说明性能不错。</p><p>using temporary：查询有使用临时表, 一般出现于排序， 分组和多表 join 的情况， 查询效率不</p><p>高，建议优化。</p><p>using where ：sql使用了where过滤,效率较高。</p><h1>25、MySQL常见优化手段</h1><p>（1）尽量选择较小的列</p><p>（2）将where中用的比较频繁的字段建立索引</p><p>（3）select子句中避免使用‘ *’</p><p>（4）避免在索引列上使用计算、not in 和&lt;&gt;等操作</p><p>（5）当只需要一行数据的时候使用limit 1</p><p>（6）保证单表数据不超过200W，适时分割表。针对查询较慢的语句，可以使用explain 来分析该语句具体的执行情况。</p><p>（7）避免改变索引列的类型。</p><p>（8）选择最有效的表名顺序，from字句中写在最后的表是基础表，将被最先处理，在from子句中包含多个表的情况下，你必须选择记录条数最少的表作为基础表。</p><p>（9）避免在索引列上面进行计算。</p><p>（10）能用关联查询的不要用子查询</p><p>（11）尽量缩小子查询的结果</p>', '{\"颜色\":[\"黑色\",\"白色\",\"红色\"],\"相机\":[\"4000万像素\",\"1800万像素\"],\"处理器\":[\"高通\"],\"续航\":[\"5100毫安\"]}', 1, 1, 1);
INSERT INTO `spu` VALUES ('1900832882818060290', '苹果 iPhone 16 手机', '支持7天无理由退货（防伪签、密封条损毁不支持）价格实惠，音质清晰，穿透力强，售后服务无虑无忧。快递发货神速。', 17, 11182, 11183, 11188, 'http://192.168.11.4:9000/mall/20250315/1f15d031-333e-4572-bef5-33ddf3684176-4bc591f0a5e9d172.jpg,http://192.168.11.4:9000/mall/20250315/9e6b394c-5dd2-42e6-9697-0e681f6f6f07-10919e801ade3cd7.jpg,http://192.168.11.4:9000/mall/20250315/88ff5eb9-d0b2-47ad-92a6-8ac26d077e78-f3335f73b140d988.jpg,http://192.168.11.4:9000/mall/20250315/05cc2f0f-7b3d-494d-b96d-0ee7858e9eed-75b3ce95f95f4f66.jpg,http://192.168.11.4:9000/mall/20250315/65257c4e-3727-49b0-8d29-a16ea6b841fb-4a054360bc39fbc3.jpg,http://192.168.11.4:9000/mall/20250315/ca272659-1ae2-4d2d-9bf0-acff8d6a1fbb-3b1e76427085fb6e.jpg,http://192.168.11.4:9000/mall/20250315/f38b2a0f-7421-49e6-948c-aa8941732dc9-e0bc6f4e0fc1b229.jpg,http://192.168.11.4:9000/mall/20250315/fc457fd4-e8fc-475d-8e5b-dce1ef65bf03-6d92edf00149a105.jpg', NULL, '<h3>iPhone 16：性能与体验的全面升级</h3><h4>1. 引言：iPhone 16的发布背景与市场定位</h4><p>2024年，苹果公司推出了备受期待的iPhone 16系列，这款手机不仅延续了苹果一贯的高品质设计，还在性能、摄影、续航等方面实现了显著提升。作为苹果在智能手机领域的最新力作，iPhone 16凭借其卓越的综合表现，再次巩固了其在高端市场的领导地位<span style=\"background-color: rgb(82, 82, 91);\">13</span>。</p><h4>2. 设计与屏幕：经典与创新的结合</h4><p>iPhone 16在外观设计上延续了苹果的简约风格，采用了6.1英寸的Super Retina XDR显示屏，支持高亮度和广色域，为用户带来更加清晰和生动的视觉体验。机身厚度仅为7.80mm，重量为170克，手感轻盈，适合日常携带<span style=\"background-color: rgb(82, 82, 91);\">25</span>。</p><h4>3. 性能：A18芯片的强大表现</h4><p>iPhone 16搭载了全新的A18芯片，采用3nm工艺制程，性能较前代提升了20%。无论是运行大型游戏还是进行多任务处理，iPhone 16都表现出色，机身发热量显著降低，确保了长时间使用的流畅性<span style=\"background-color: rgb(82, 82, 91);\">56</span>。</p><h4>4. 摄影系统：4800万像素主摄与AI技术的融合</h4><p>iPhone 16的摄影系统是其一大亮点。后置4800万像素主摄支持光学防抖和微距摄影，超广角镜头的光圈增大，显著提升了低光环境下的拍摄效果。此外，AI摄影功能的引入使得拍照更加智能，用户只需轻按快门即可获得高质量的照片<span style=\"background-color: rgb(82, 82, 91);\">37</span>。</p><h4>5. 续航与充电：超长电池寿命与快充支持</h4><p>iPhone 16配备了一块3561mAh的电池，结合A18芯片的高效能，续航表现显著提升。支持20W快充和无线充电，用户可以在短时间内快速补充电量，满足日常使用需求<span style=\"background-color: rgb(82, 82, 91);\">56</span>。</p><h4>6. 用户体验：iOS 18系统与隐私保护</h4><p>iOS 18系统为iPhone 16带来了更加流畅的操作体验和强大的隐私保护功能。新增的“需要面容ID”功能有效保护用户隐私，增强了设备的安全性<span style=\"background-color: rgb(82, 82, 91);\">28</span>。</p><h4>7. 市场表现与竞争对手分析</h4><p>在竞争激烈的智能手机市场中，iPhone 16凭借其卓越的性能和用户体验，成功吸引了大量消费者。尽管部分安卓旗舰机型在硬件配置上更具优势，但苹果的生态系统和品牌影响力依然使其占据领先地位<span style=\"background-color: rgb(82, 82, 91);\">47</span>。</p><h4>8. 总结：iPhone 16的综合评价与未来展望</h4><p>iPhone 16凭借其出色的设计、强大的性能、卓越的摄影系统和超长的续航表现，成为2024年最具代表性的智能手机之一。对于追求高品质体验的用户来说，iPhone 16无疑是一个值得入手的选择。未来，苹果将继续通过技术创新推动行业发展，为用户带来更多惊喜<span style=\"background-color: rgb(82, 82, 91);\">138</span>。</p>', '{\"CPU型号\":[\"A18\"],\"屏幕尺寸\":[\"6.3-6.59英寸\"],\"运行内存\":[\"8GB\"],\"机身内存\":[\"256GB\",\"128GB\",\"512GB\"],\"电池容量\":[\"4000mAh\"],\"相机像素\":[\"6400万像素\"],\"机身色系\":[\"黑色系\",\"绿色系\",\"白色系\"]}', 1, 0, 1);
INSERT INTO `spu` VALUES ('1900839443372216322', '小米手机 Redmi Note13R 5G 120Hz LCD护眼屏幕', '7天无理由退货（合约版不支持）配送全球 · 90天只换不修 · 7天价保 · 免费上门退换 · 365天原厂维修', 18, 11182, 11183, 11187, 'http://192.168.11.4:9000/mall/20250315/be27a163-76d1-4076-b88a-c811cfcd5526-352de3b3e9639440.jpg,http://192.168.11.4:9000/mall/20250315/89d01184-e136-478d-9864-fafaf1a879f0-60744893e89bd4d5.png,http://192.168.11.4:9000/mall/20250315/5a62542b-b20b-4f58-b11d-d66e5af9ca27-62bf551647410dfb.png', NULL, '<h3>红米Note13R：千元机市场的性价比之王</h3><h4>1. 设计与屏幕：护眼大屏与时尚外观</h4><p>红米Note13R配备了一块6.79英寸的LCD屏幕，分辨率为2460×1080像素，支持120Hz高刷新率和240Hz触控采样率，为用户提供了流畅的视觉体验。屏幕还通过了TÜV莱茵硬件级低蓝光认证、无频闪认证和节律友好认证，有效降低了长时间使用对眼睛的伤害<span style=\"background-color: rgb(82, 82, 91);\">16</span>。此外，机身采用双面玻璃设计，提供浅海蓝、冰晶银、子夜黑三款配色，整体风格时尚潮流<span style=\"background-color: rgb(82, 82, 91);\">16</span>。</p><h4>2. 性能：骁龙4 Gen 2领先版处理器</h4><p>红米Note13R搭载了第二代骁龙4处理器（骁龙4 Gen 2领先版），采用4nm工艺制程，主频高达2.3GHz。虽然定位入门级，但其性能足以应对日常使用和轻度游戏需求，跑分约为55万<span style=\"background-color: rgb(82, 82, 91);\">67</span>。配合小米澎湃OS系统，手机在36个月内仍能保持流畅运行，避免了卡顿问题<span style=\"background-color: rgb(82, 82, 91);\">36</span>。</p><h4>3. 摄影系统：5000万像素主摄与AI影像技术</h4><p>后置5000万像素主摄（三星JN1传感器）和200万像素微距镜头，支持小米影像大脑技术，显著提升了拍照速度和成像质量。无论是夜景、人像还是微距摄影，红米Note13R都能轻松应对，满足用户的日常拍摄需求<span style=\"background-color: rgb(82, 82, 91);\">16</span>。</p><h4>4. 续航与充电：5030mAh大电池与33W快充</h4><p>内置5030mAh大电池，支持33W快充，重度使用下可满足一天续航需求。快充技术让用户能够在短时间内迅速补充电量，彻底告别电量焦虑<span style=\"background-color: rgb(82, 82, 91);\">16</span>。</p><h4>5. 价格与市场定位：千元机中的性价比标杆</h4><p>红米Note13R的起售价仅为1090元（12GB+256GB版本），提供了从6GB+128GB到12GB+512GB的多种存储规格选择。其高性价比和全面配置使其成为预算有限用户的首选，尤其适合学生、老人或作为备用机使用<span style=\"background-color: rgb(82, 82, 91);\">248</span>。</p><h4>总结</h4><p>红米Note13R凭借其护眼大屏、强劲性能、出色摄影系统和超长续航，成为千元机市场的性价比标杆。无论是日常使用还是轻度娱乐，这款手机都能提供超乎预期的体验，是预算有限用户的理想选择<span style=\"background-color: rgb(82, 82, 91);\">168</span>。</p>', '{\"CPU型号\":[\"骁龙8 至尊版\"],\"屏幕尺寸\":[\"6.6-6.79英寸\"],\"运行内存\":[\"8GB\",\"12GB\"],\"机身内存\":[\"256GB\",\"128GB\"],\"电池容量\":[\"5000mAh\"],\"相机像素\":[\"5400万像素\"],\"机身色系\":[\"白色系\",\"黑色系\"]}', 1, 0, 1);
INSERT INTO `spu` VALUES ('1907020261366968321', '华为手机1', '华为', 19, 11182, 11183, 11184, 'http://192.168.11.4:9000/mall/20250401/a0bc6cf3-5dd5-46e2-a17d-cc76c903195a-7a6e07fb952a410eb321bc6f58058762.jpg,http://192.168.11.4:9000/mall/20250401/8e7f28be-7748-4f70-a902-c8e62c2c2cdd-7b49edbb35c743c7ba8343011b3bba3d.jpg', NULL, '<h1>111</h1>', '{\"CPU型号\":[\"天玑9300 \"],\"屏幕尺寸\":[\"6.3-6.59英寸\"],\"运行内存\":[\"6GB\"],\"机身色系\":[\"纯色\",\"黑色系\"]}', 1, 0, 0);

-- ----------------------------
-- Table structure for undo_log
-- ----------------------------
DROP TABLE IF EXISTS `undo_log`;
CREATE TABLE `undo_log`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `branch_id` bigint(20) NOT NULL,
  `xid` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `context` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `rollback_info` longblob NOT NULL,
  `log_status` int(11) NOT NULL,
  `log_created` datetime NOT NULL,
  `log_modified` datetime NOT NULL,
  `ext` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `ux_undo_log`(`xid`, `branch_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of undo_log
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
