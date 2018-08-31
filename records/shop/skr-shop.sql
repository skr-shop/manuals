/*
 Navicat MySQL Data Transfer

 Source Server         : phpStudy_localhost
 Source Server Type    : MySQL
 Source Server Version : 50553
 Source Host           : localhost:3306
 Source Schema         : skr-shop

 Target Server Type    : MySQL
 Target Server Version : 50553
 File Encoding         : 65001

 Date: 31/08/2018 11:44:40
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for shop
-- ----------------------------
DROP TABLE IF EXISTS `shop`;
CREATE TABLE `shop`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户uid',
  `type` tinyint(2) UNSIGNED NOT NULL DEFAULT 0 COMMENT '店铺类型：0-个人类型，1-企业类型',
  `industry_ids` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '对应的行业，逗号隔开',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '店铺名称',
  `logo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '店铺Logo地址',
  `intro` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '店铺简介',
  `area_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '店铺最下级地址id',
  `area_address` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '店铺详细地址，不包含省市区的信息',
  `shop_note` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '店铺留言，如休息中留言',
  `status` tinyint(2) UNSIGNED NOT NULL DEFAULT 0 COMMENT '店铺状态：默认0-新申请，10-审核通过，11-审核中，20-审核失败，30-营业中，40-休息中',
  `sort` mediumint(5) UNSIGNED NOT NULL DEFAULT 0 COMMENT '排序值',
  `last_verify_time` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '最后审核时间',
  `create_time` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '添加时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '店铺基本信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for shop_certificate
-- ----------------------------
DROP TABLE IF EXISTS `shop_certificate`;
CREATE TABLE `shop_certificate`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `shop_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '店铺id',
  `identity_card` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '店主身份证信息，json格式存正反面地址',
  `other_card` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '其他证件信息，json格式存多张图片地址',
  `verify_memo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '提交审核留言',
  `create_time` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '添加时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '店铺相关证件信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for shop_goods_category
-- ----------------------------
DROP TABLE IF EXISTS `shop_goods_category`;
CREATE TABLE `shop_goods_category`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '父id，一级分类pid为0',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '分类名称',
  `icon_url` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '分类图标地址',
  `status` tinyint(2) UNSIGNED NOT NULL DEFAULT 0 COMMENT '有效状态：默认0-有效，1-无效',
  `sort` mediumint(5) UNSIGNED NOT NULL DEFAULT 0 COMMENT '排序值',
  `create_time` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '添加时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '店铺自定义商品分类表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for shop_industry
-- ----------------------------
DROP TABLE IF EXISTS `shop_industry`;
CREATE TABLE `shop_industry`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '行业名称',
  `intro` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '行业简介',
  `status` tinyint(2) UNSIGNED NOT NULL DEFAULT 0 COMMENT '有效状态：默认0-有效，1-无效',
  `sort` mediumint(5) UNSIGNED NOT NULL DEFAULT 0 COMMENT '排序值',
  `create_time` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '添加时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '店铺行业表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for shop_verify
-- ----------------------------
DROP TABLE IF EXISTS `shop_verify`;
CREATE TABLE `shop_verify`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `shop_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '店铺id',
  `verify_info` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '审核时对应的店铺信息，json存店铺图片/留言等',
  `verify_note` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '审核备注',
  `operator_staffid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '审核人后台staffid',
  `operator_staffname` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '审核人信息',
  `verify_time` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '最后审核时间',
  `create_time` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '添加时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '店铺审核记录表' ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
