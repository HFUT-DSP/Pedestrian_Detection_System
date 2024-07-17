/*
 Navicat Premium Data Transfer

 Source Server         : connectLan
 Source Server Type    : MySQL
 Source Server Version : 80037
 Source Host           : localhost:3306
 Source Schema         : youlai_boot

 Target Server Type    : MySQL
 Target Server Version : 80037
 File Encoding         : 65001

 Date: 17/07/2024 22:17:56
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '部门名称',
  `code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '部门编号',
  `parent_id` bigint NOT NULL DEFAULT 0 COMMENT '父节点id',
  `tree_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '父节点id路径',
  `sort` smallint NULL DEFAULT 0 COMMENT '显示顺序',
  `status` tinyint NOT NULL DEFAULT 1 COMMENT '状态(1-正常 0-禁用)',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建人ID',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '修改人ID',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `is_deleted` tinyint NOT NULL DEFAULT 0 COMMENT '逻辑删除标识(1-已删除 0-未删除)',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_code`(`code`) USING BTREE COMMENT '部门编号唯一索引'
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '部门表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (1, '项目开发', 'DSP', 0, '0', 1, 1, 1, NULL, 1, '2024-07-05 10:33:33', 0);
INSERT INTO `sys_dept` VALUES (2, '前端开发', 'Q001', 1, '0,1', 2, 1, 2, NULL, 2, '2024-07-05 14:56:19', 0);
INSERT INTO `sys_dept` VALUES (3, '后端开发', 'Q002', 1, '0,1', 3, 1, 2, NULL, 2, '2024-07-05 14:56:25', 0);
INSERT INTO `sys_dept` VALUES (6, '测试部门', 'Q003', 1, '0,1', 4, 1, NULL, '2024-07-05 10:44:57', NULL, '2024-07-05 14:56:34', 0);
INSERT INTO `sys_dept` VALUES (8, '物业公司', 'WY', 0, '0', 1, 1, NULL, '2024-07-05 14:45:09', NULL, '2024-07-05 15:35:34', 0);
INSERT INTO `sys_dept` VALUES (9, '管理部门', 'W001', 8, '0,8', 1, 1, NULL, '2024-07-05 15:35:24', NULL, '2024-07-05 15:35:24', 0);
INSERT INTO `sys_dept` VALUES (10, '保安', 'W002', 8, '0,8', 1, 1, NULL, '2024-07-05 15:36:12', NULL, '2024-07-05 15:36:12', 0);

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键 ',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '类型名称',
  `code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '类型编码',
  `status` tinyint(1) NULL DEFAULT 0 COMMENT '状态(0:正常;1:禁用)',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `is_deleted` tinyint NULL DEFAULT 0 COMMENT '是否删除(1-删除，0-未删除)',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_code`(`code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典类型表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
INSERT INTO `sys_dict` VALUES (1, '性别', 'gender', 1, NULL, '2019-12-06 19:03:32', '2024-06-22 21:14:47', 0);

-- ----------------------------
-- Table structure for sys_dict_item
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_item`;
CREATE TABLE `sys_dict_item`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `dict_id` bigint NULL DEFAULT NULL COMMENT '字典ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典项名称',
  `value` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典项值',
  `status` tinyint NULL DEFAULT 0 COMMENT '状态（1-正常，0-禁用）',
  `sort` int NULL DEFAULT 0 COMMENT '排序',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典数据表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_item
-- ----------------------------
INSERT INTO `sys_dict_item` VALUES (1, 1, '男', '1', 1, 1, NULL, '2019-05-05 13:07:52', '2022-06-12 23:20:39');
INSERT INTO `sys_dict_item` VALUES (2, 1, '女', '2', 1, 2, NULL, '2019-04-19 11:33:00', '2019-07-02 14:23:05');
INSERT INTO `sys_dict_item` VALUES (3, 1, '保密', '0', 1, 3, NULL, '2020-10-17 08:09:31', '2020-10-17 08:09:31');

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `module` enum('LOGIN','USER','ROLE','DEPT','MENU','DICT','OTHER') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '日志模块',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '日志内容',
  `request_uri` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '请求路径',
  `ip` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'IP地址',
  `province` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '省份',
  `city` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '城市',
  `execution_time` bigint NULL DEFAULT NULL COMMENT '执行时间(ms)',
  `browser` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '浏览器',
  `browser_version` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '浏览器版本',
  `os` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '终端系统',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建人ID',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `is_deleted` tinyint NOT NULL DEFAULT 0 COMMENT '逻辑删除标识(1-已删除 0-未删除)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 688 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统日志表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_log
-- ----------------------------
INSERT INTO `sys_log` VALUES (1, 'LOGIN', '注销', '/api/v1/auth/logout', '114.213.211.68', '安徽省', '合肥市', 2, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-03 15:57:20', 0);
INSERT INTO `sys_log` VALUES (2, 'LOGIN', '登录', '/api/v1/auth/login', '114.213.211.68', '安徽省', '合肥市', 141, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-03 15:57:41', 0);
INSERT INTO `sys_log` VALUES (3, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 19, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-03 15:59:14', 0);
INSERT INTO `sys_log` VALUES (4, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 10, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-03 16:01:23', 0);
INSERT INTO `sys_log` VALUES (5, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 9, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-03 16:01:34', 0);
INSERT INTO `sys_log` VALUES (6, 'LOGIN', '注销', '/api/v1/auth/logout', '114.213.211.68', '安徽省', '合肥市', 0, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-03 16:01:49', 0);
INSERT INTO `sys_log` VALUES (7, 'LOGIN', '登录', '/api/v1/auth/login', '114.213.211.68', '安徽省', '合肥市', 69, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-03 16:02:54', 0);
INSERT INTO `sys_log` VALUES (8, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 8, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-03 16:02:55', 0);
INSERT INTO `sys_log` VALUES (9, 'LOGIN', '注销', '/api/v1/auth/logout', '114.213.211.68', '安徽省', '合肥市', 0, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-03 16:03:20', 0);
INSERT INTO `sys_log` VALUES (10, 'LOGIN', '登录', '/api/v1/auth/login', '114.213.211.68', '安徽省', '合肥市', 617, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 10:41:12', 0);
INSERT INTO `sys_log` VALUES (11, 'LOGIN', '注销', '/api/v1/auth/logout', '114.213.211.68', '安徽省', '合肥市', 1, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 10:41:21', 0);
INSERT INTO `sys_log` VALUES (12, 'LOGIN', '登录', '/api/v1/auth/login', '114.213.211.68', '安徽省', '合肥市', 82, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 11:13:49', 0);
INSERT INTO `sys_log` VALUES (13, 'LOGIN', '登录', '/api/v1/auth/login', '114.213.211.68', '安徽省', '合肥市', 75, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 11:14:02', 0);
INSERT INTO `sys_log` VALUES (14, 'LOGIN', '登录', '/api/v1/auth/login', '114.213.211.68', '安徽省', '合肥市', 69, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 11:14:29', 0);
INSERT INTO `sys_log` VALUES (15, 'LOGIN', '登录', '/api/v1/auth/login', '114.213.211.68', '安徽省', '合肥市', 67, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 11:15:20', 0);
INSERT INTO `sys_log` VALUES (16, 'LOGIN', '注销', '/api/v1/auth/logout', '114.213.211.68', '安徽省', '合肥市', 0, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 11:15:33', 0);
INSERT INTO `sys_log` VALUES (17, 'LOGIN', '登录', '/api/v1/auth/login', '114.213.211.68', '安徽省', '合肥市', 69, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 11:15:40', 0);
INSERT INTO `sys_log` VALUES (18, 'LOGIN', '注销', '/api/v1/auth/logout', '114.213.211.68', '安徽省', '合肥市', 0, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 11:15:57', 0);
INSERT INTO `sys_log` VALUES (19, 'LOGIN', '登录', '/api/v1/auth/login', '114.213.211.68', '安徽省', '合肥市', 68, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 11:16:19', 0);
INSERT INTO `sys_log` VALUES (20, 'LOGIN', '注销', '/api/v1/auth/logout', '114.213.211.68', '安徽省', '合肥市', 1, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 11:16:29', 0);
INSERT INTO `sys_log` VALUES (21, 'LOGIN', '登录', '/api/v1/auth/login', '114.213.211.68', '安徽省', '合肥市', 597, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 14:26:47', 0);
INSERT INTO `sys_log` VALUES (22, 'LOGIN', '注销', '/api/v1/auth/logout', '114.213.211.68', '安徽省', '合肥市', 0, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 14:27:06', 0);
INSERT INTO `sys_log` VALUES (23, 'LOGIN', '登录', '/api/v1/auth/login', '114.213.211.68', '安徽省', '合肥市', 73, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 14:53:52', 0);
INSERT INTO `sys_log` VALUES (24, 'LOGIN', '登录', '/api/v1/auth/login', '114.213.211.68', '安徽省', '合肥市', 69, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 15:07:23', 0);
INSERT INTO `sys_log` VALUES (25, 'LOGIN', '注销', '/api/v1/auth/logout', '114.213.211.68', '安徽省', '合肥市', 0, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 15:21:24', 0);
INSERT INTO `sys_log` VALUES (26, 'LOGIN', '登录', '/api/v1/auth/login', '114.213.211.68', '安徽省', '合肥市', 70, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 15:32:31', 0);
INSERT INTO `sys_log` VALUES (27, 'LOGIN', '登录', '/api/v1/auth/login', '114.213.211.68', '安徽省', '合肥市', 79, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 16:11:48', 0);
INSERT INTO `sys_log` VALUES (28, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 65, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 16:11:56', 0);
INSERT INTO `sys_log` VALUES (29, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 9, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 16:12:09', 0);
INSERT INTO `sys_log` VALUES (30, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 12, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 16:12:31', 0);
INSERT INTO `sys_log` VALUES (31, 'DEPT', '部门列表', '/api/v1/dept', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 16:13:02', 0);
INSERT INTO `sys_log` VALUES (32, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 7, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 16:17:10', 0);
INSERT INTO `sys_log` VALUES (33, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 16:18:43', 0);
INSERT INTO `sys_log` VALUES (34, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 7, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 16:18:58', 0);
INSERT INTO `sys_log` VALUES (35, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 16:19:00', 0);
INSERT INTO `sys_log` VALUES (36, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 16:19:03', 0);
INSERT INTO `sys_log` VALUES (37, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 16:19:05', 0);
INSERT INTO `sys_log` VALUES (38, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 16:21:55', 0);
INSERT INTO `sys_log` VALUES (39, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 16:23:58', 0);
INSERT INTO `sys_log` VALUES (40, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 16:24:07', 0);
INSERT INTO `sys_log` VALUES (41, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 16:24:17', 0);
INSERT INTO `sys_log` VALUES (42, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 16:24:19', 0);
INSERT INTO `sys_log` VALUES (43, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 16:24:21', 0);
INSERT INTO `sys_log` VALUES (44, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 16:24:32', 0);
INSERT INTO `sys_log` VALUES (45, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 16:24:33', 0);
INSERT INTO `sys_log` VALUES (46, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 16:24:35', 0);
INSERT INTO `sys_log` VALUES (47, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 16:24:36', 0);
INSERT INTO `sys_log` VALUES (48, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 16:24:38', 0);
INSERT INTO `sys_log` VALUES (49, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 16:24:40', 0);
INSERT INTO `sys_log` VALUES (50, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 16:24:42', 0);
INSERT INTO `sys_log` VALUES (51, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 16:24:46', 0);
INSERT INTO `sys_log` VALUES (52, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 16:24:58', 0);
INSERT INTO `sys_log` VALUES (53, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 16:25:03', 0);
INSERT INTO `sys_log` VALUES (54, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 16:25:05', 0);
INSERT INTO `sys_log` VALUES (55, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 16:25:10', 0);
INSERT INTO `sys_log` VALUES (56, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 16:25:11', 0);
INSERT INTO `sys_log` VALUES (57, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 16:25:13', 0);
INSERT INTO `sys_log` VALUES (58, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 16:25:14', 0);
INSERT INTO `sys_log` VALUES (59, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 16:25:16', 0);
INSERT INTO `sys_log` VALUES (60, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 16:25:17', 0);
INSERT INTO `sys_log` VALUES (61, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 16:25:19', 0);
INSERT INTO `sys_log` VALUES (62, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 16:28:56', 0);
INSERT INTO `sys_log` VALUES (63, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 16:28:59', 0);
INSERT INTO `sys_log` VALUES (64, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 16:29:00', 0);
INSERT INTO `sys_log` VALUES (65, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 16:29:02', 0);
INSERT INTO `sys_log` VALUES (66, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 10, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 16:29:04', 0);
INSERT INTO `sys_log` VALUES (67, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 16:29:49', 0);
INSERT INTO `sys_log` VALUES (68, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 16:29:50', 0);
INSERT INTO `sys_log` VALUES (69, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 16:29:51', 0);
INSERT INTO `sys_log` VALUES (70, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 16:29:52', 0);
INSERT INTO `sys_log` VALUES (71, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 16:29:52', 0);
INSERT INTO `sys_log` VALUES (72, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 16:29:53', 0);
INSERT INTO `sys_log` VALUES (73, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 16:29:54', 0);
INSERT INTO `sys_log` VALUES (74, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 16:30:40', 0);
INSERT INTO `sys_log` VALUES (75, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 16:30:41', 0);
INSERT INTO `sys_log` VALUES (76, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 16:31:20', 0);
INSERT INTO `sys_log` VALUES (77, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 16:42:25', 0);
INSERT INTO `sys_log` VALUES (78, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 3, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 16:42:26', 0);
INSERT INTO `sys_log` VALUES (79, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 16:42:28', 0);
INSERT INTO `sys_log` VALUES (80, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 3, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 16:42:29', 0);
INSERT INTO `sys_log` VALUES (81, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 3, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 16:44:11', 0);
INSERT INTO `sys_log` VALUES (82, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 3, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 16:53:42', 0);
INSERT INTO `sys_log` VALUES (83, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 16:53:58', 0);
INSERT INTO `sys_log` VALUES (84, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 16:54:00', 0);
INSERT INTO `sys_log` VALUES (85, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 54, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 16:55:26', 0);
INSERT INTO `sys_log` VALUES (86, 'LOGIN', '注销', '/api/v1/auth/logout', '114.213.211.68', NULL, NULL, 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 17:00:25', 0);
INSERT INTO `sys_log` VALUES (87, 'LOGIN', '注销', '/api/v1/auth/logout', '114.213.211.68', NULL, NULL, 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-04 17:00:25', 0);
INSERT INTO `sys_log` VALUES (88, 'LOGIN', '登录', '/api/v1/auth/login', '114.213.211.68', '安徽省', '合肥市', 617, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 10:19:45', 0);
INSERT INTO `sys_log` VALUES (89, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 16, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 10:19:51', 0);
INSERT INTO `sys_log` VALUES (90, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 12, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 10:21:52', 0);
INSERT INTO `sys_log` VALUES (91, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 9, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 10:26:41', 0);
INSERT INTO `sys_log` VALUES (92, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 8, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 10:26:42', 0);
INSERT INTO `sys_log` VALUES (93, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 7, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 10:26:43', 0);
INSERT INTO `sys_log` VALUES (94, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 10:31:43', 0);
INSERT INTO `sys_log` VALUES (95, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 10:31:48', 0);
INSERT INTO `sys_log` VALUES (96, 'DEPT', '部门列表', '/api/v1/dept', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 10:32:03', 0);
INSERT INTO `sys_log` VALUES (97, 'DEPT', '部门列表', '/api/v1/dept', '114.213.211.68', '安徽省', '合肥市', 3, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 10:32:24', 0);
INSERT INTO `sys_log` VALUES (98, 'DEPT', '部门列表', '/api/v1/dept', '114.213.211.68', '安徽省', '合肥市', 2, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 10:32:42', 0);
INSERT INTO `sys_log` VALUES (99, 'DEPT', '部门列表', '/api/v1/dept', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 10:33:33', 0);
INSERT INTO `sys_log` VALUES (100, 'DEPT', '部门列表', '/api/v1/dept', '114.213.211.68', '安徽省', '合肥市', 3, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 10:33:48', 0);
INSERT INTO `sys_log` VALUES (101, 'DEPT', '部门列表', '/api/v1/dept', '114.213.211.68', '安徽省', '合肥市', 3, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 10:34:43', 0);
INSERT INTO `sys_log` VALUES (102, 'DEPT', '部门列表', '/api/v1/dept', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 10:34:51', 0);
INSERT INTO `sys_log` VALUES (103, 'DEPT', '部门列表', '/api/v1/dept', '114.213.211.68', '安徽省', '合肥市', 3, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 10:36:26', 0);
INSERT INTO `sys_log` VALUES (104, 'DEPT', '部门列表', '/api/v1/dept', '114.213.211.68', '安徽省', '合肥市', 2, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 10:37:15', 0);
INSERT INTO `sys_log` VALUES (105, 'DEPT', '部门列表', '/api/v1/dept', '114.213.211.68', '安徽省', '合肥市', 3, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 10:37:31', 0);
INSERT INTO `sys_log` VALUES (106, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 7, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 10:37:35', 0);
INSERT INTO `sys_log` VALUES (107, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 10:37:35', 0);
INSERT INTO `sys_log` VALUES (108, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 10:37:36', 0);
INSERT INTO `sys_log` VALUES (109, 'DEPT', '部门列表', '/api/v1/dept', '114.213.211.68', '安徽省', '合肥市', 3, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 10:37:54', 0);
INSERT INTO `sys_log` VALUES (110, 'DICT', '字典分页列表', '/api/v1/dict/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 10:38:36', 0);
INSERT INTO `sys_log` VALUES (111, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 10:39:16', 0);
INSERT INTO `sys_log` VALUES (112, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 10:39:42', 0);
INSERT INTO `sys_log` VALUES (113, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 10:39:44', 0);
INSERT INTO `sys_log` VALUES (114, 'DEPT', '部门列表', '/api/v1/dept', '114.213.211.68', '安徽省', '合肥市', 3, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 10:40:32', 0);
INSERT INTO `sys_log` VALUES (115, 'DEPT', '部门列表', '/api/v1/dept', '114.213.211.68', '安徽省', '合肥市', 2, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 10:41:19', 0);
INSERT INTO `sys_log` VALUES (116, 'DEPT', '部门列表', '/api/v1/dept', '114.213.211.68', '安徽省', '合肥市', 3, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 10:41:25', 0);
INSERT INTO `sys_log` VALUES (117, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 10:42:01', 0);
INSERT INTO `sys_log` VALUES (118, 'DEPT', '部门列表', '/api/v1/dept', '114.213.211.68', '安徽省', '合肥市', 2, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 10:44:57', 0);
INSERT INTO `sys_log` VALUES (119, 'DEPT', '部门列表', '/api/v1/dept', '114.213.211.68', '安徽省', '合肥市', 3, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 10:50:23', 0);
INSERT INTO `sys_log` VALUES (120, 'DEPT', '部门列表', '/api/v1/dept', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 10:51:09', 0);
INSERT INTO `sys_log` VALUES (121, 'DEPT', '部门列表', '/api/v1/dept', '114.213.211.68', '安徽省', '合肥市', 3, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 11:07:46', 0);
INSERT INTO `sys_log` VALUES (122, 'DEPT', '部门列表', '/api/v1/dept', '114.213.211.68', '安徽省', '合肥市', 3, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 11:08:40', 0);
INSERT INTO `sys_log` VALUES (123, 'DEPT', '部门列表', '/api/v1/dept', '114.213.211.68', '安徽省', '合肥市', 3, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 11:08:53', 0);
INSERT INTO `sys_log` VALUES (124, 'DEPT', '部门列表', '/api/v1/dept', '114.213.211.68', '安徽省', '合肥市', 2, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 11:08:59', 0);
INSERT INTO `sys_log` VALUES (125, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 11:09:19', 0);
INSERT INTO `sys_log` VALUES (126, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 3, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 11:12:25', 0);
INSERT INTO `sys_log` VALUES (127, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 8, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 11:13:50', 0);
INSERT INTO `sys_log` VALUES (128, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 11:14:27', 0);
INSERT INTO `sys_log` VALUES (129, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 10, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 11:14:29', 0);
INSERT INTO `sys_log` VALUES (130, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 11:14:34', 0);
INSERT INTO `sys_log` VALUES (131, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 11:15:08', 0);
INSERT INTO `sys_log` VALUES (132, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 11:16:01', 0);
INSERT INTO `sys_log` VALUES (133, 'LOGIN', '登录', '/api/v1/auth/login', '114.213.211.68', '安徽省', '合肥市', 67, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 11:20:21', 0);
INSERT INTO `sys_log` VALUES (134, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 11:20:21', 0);
INSERT INTO `sys_log` VALUES (135, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 11:20:25', 0);
INSERT INTO `sys_log` VALUES (136, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 11:20:26', 0);
INSERT INTO `sys_log` VALUES (137, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 11:20:27', 0);
INSERT INTO `sys_log` VALUES (138, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 11:20:28', 0);
INSERT INTO `sys_log` VALUES (139, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 11:20:32', 0);
INSERT INTO `sys_log` VALUES (140, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 11:20:34', 0);
INSERT INTO `sys_log` VALUES (141, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 11:25:29', 0);
INSERT INTO `sys_log` VALUES (142, 'DEPT', '部门列表', '/api/v1/dept', '114.213.211.68', '安徽省', '合肥市', 3, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 11:26:32', 0);
INSERT INTO `sys_log` VALUES (143, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 11:27:53', 0);
INSERT INTO `sys_log` VALUES (144, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 11:27:54', 0);
INSERT INTO `sys_log` VALUES (145, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 11:27:55', 0);
INSERT INTO `sys_log` VALUES (146, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 11:27:59', 0);
INSERT INTO `sys_log` VALUES (147, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 11:28:00', 0);
INSERT INTO `sys_log` VALUES (148, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 11:28:02', 0);
INSERT INTO `sys_log` VALUES (149, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 11:28:03', 0);
INSERT INTO `sys_log` VALUES (150, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 11:28:05', 0);
INSERT INTO `sys_log` VALUES (151, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 11:28:06', 0);
INSERT INTO `sys_log` VALUES (152, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 11:28:13', 0);
INSERT INTO `sys_log` VALUES (153, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 11:28:21', 0);
INSERT INTO `sys_log` VALUES (154, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 11:28:26', 0);
INSERT INTO `sys_log` VALUES (155, 'DEPT', '部门列表', '/api/v1/dept', '114.213.211.68', '安徽省', '合肥市', 2, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 11:28:29', 0);
INSERT INTO `sys_log` VALUES (156, 'DEPT', '部门列表', '/api/v1/dept', '114.213.211.68', '安徽省', '合肥市', 3, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 11:28:39', 0);
INSERT INTO `sys_log` VALUES (157, 'DICT', '字典分页列表', '/api/v1/dict/page', '114.213.211.68', '安徽省', '合肥市', 3, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 11:28:42', 0);
INSERT INTO `sys_log` VALUES (158, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 11:28:56', 0);
INSERT INTO `sys_log` VALUES (159, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 3, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 11:29:06', 0);
INSERT INTO `sys_log` VALUES (160, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 11:29:09', 0);
INSERT INTO `sys_log` VALUES (161, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 11:29:18', 0);
INSERT INTO `sys_log` VALUES (162, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 11:29:19', 0);
INSERT INTO `sys_log` VALUES (163, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 11:29:20', 0);
INSERT INTO `sys_log` VALUES (164, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 11:29:21', 0);
INSERT INTO `sys_log` VALUES (165, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 11:29:24', 0);
INSERT INTO `sys_log` VALUES (166, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 11:29:25', 0);
INSERT INTO `sys_log` VALUES (167, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 26, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 11:29:43', 0);
INSERT INTO `sys_log` VALUES (168, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 8, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 11:29:55', 0);
INSERT INTO `sys_log` VALUES (169, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 19, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 11:29:57', 0);
INSERT INTO `sys_log` VALUES (170, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 11:31:09', 0);
INSERT INTO `sys_log` VALUES (171, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 11:31:16', 0);
INSERT INTO `sys_log` VALUES (172, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 7, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 11:33:17', 0);
INSERT INTO `sys_log` VALUES (173, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 7, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 11:33:48', 0);
INSERT INTO `sys_log` VALUES (174, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 11:37:39', 0);
INSERT INTO `sys_log` VALUES (175, 'DEPT', '部门列表', '/api/v1/dept', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 11:37:54', 0);
INSERT INTO `sys_log` VALUES (176, 'DEPT', '部门列表', '/api/v1/dept', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 11:38:27', 0);
INSERT INTO `sys_log` VALUES (177, 'DEPT', '部门列表', '/api/v1/dept', '114.213.211.68', '安徽省', '合肥市', 3, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 11:38:32', 0);
INSERT INTO `sys_log` VALUES (178, 'LOGIN', '登录', '/api/v1/auth/login', '114.213.211.68', '安徽省', '合肥市', 146, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 14:43:42', 0);
INSERT INTO `sys_log` VALUES (179, 'DEPT', '部门列表', '/api/v1/dept', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 14:43:43', 0);
INSERT INTO `sys_log` VALUES (180, 'DEPT', '部门列表', '/api/v1/dept', '114.213.211.68', '安徽省', '合肥市', 15, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 14:44:40', 0);
INSERT INTO `sys_log` VALUES (181, 'DEPT', '部门列表', '/api/v1/dept', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 14:45:10', 0);
INSERT INTO `sys_log` VALUES (182, 'DEPT', '部门列表', '/api/v1/dept', '114.213.211.68', '安徽省', '合肥市', 7, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 14:45:27', 0);
INSERT INTO `sys_log` VALUES (183, 'DEPT', '部门列表', '/api/v1/dept', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 14:46:13', 0);
INSERT INTO `sys_log` VALUES (184, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 17, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 14:52:17', 0);
INSERT INTO `sys_log` VALUES (185, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 7, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 14:52:32', 0);
INSERT INTO `sys_log` VALUES (186, 'DEPT', '部门列表', '/api/v1/dept', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 14:56:11', 0);
INSERT INTO `sys_log` VALUES (187, 'DEPT', '部门列表', '/api/v1/dept', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 14:56:20', 0);
INSERT INTO `sys_log` VALUES (188, 'DEPT', '部门列表', '/api/v1/dept', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 14:56:25', 0);
INSERT INTO `sys_log` VALUES (189, 'DEPT', '部门列表', '/api/v1/dept', '114.213.211.68', '安徽省', '合肥市', 3, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 14:56:34', 0);
INSERT INTO `sys_log` VALUES (190, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 14:57:35', 0);
INSERT INTO `sys_log` VALUES (191, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 28, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 15:34:42', 0);
INSERT INTO `sys_log` VALUES (192, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 8, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 15:34:46', 0);
INSERT INTO `sys_log` VALUES (193, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 20, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 15:34:48', 0);
INSERT INTO `sys_log` VALUES (194, 'DEPT', '部门列表', '/api/v1/dept', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 15:34:49', 0);
INSERT INTO `sys_log` VALUES (195, 'DEPT', '部门列表', '/api/v1/dept', '114.213.211.68', '安徽省', '合肥市', 2, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 15:35:24', 0);
INSERT INTO `sys_log` VALUES (196, 'DEPT', '部门列表', '/api/v1/dept', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 15:35:34', 0);
INSERT INTO `sys_log` VALUES (197, 'DEPT', '部门列表', '/api/v1/dept', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 15:36:12', 0);
INSERT INTO `sys_log` VALUES (198, 'LOGIN', '登录', '/api/v1/auth/login', '114.213.211.68', '安徽省', '合肥市', 141, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 15:45:27', 0);
INSERT INTO `sys_log` VALUES (199, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 15:45:28', 0);
INSERT INTO `sys_log` VALUES (200, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 15:45:59', 0);
INSERT INTO `sys_log` VALUES (201, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 9, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 15:46:43', 0);
INSERT INTO `sys_log` VALUES (202, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 15:46:47', 0);
INSERT INTO `sys_log` VALUES (203, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 15:46:47', 0);
INSERT INTO `sys_log` VALUES (204, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 7, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 15:46:57', 0);
INSERT INTO `sys_log` VALUES (205, 'DEPT', '部门列表', '/api/v1/dept', '114.213.211.68', '安徽省', '合肥市', 3, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 15:47:38', 0);
INSERT INTO `sys_log` VALUES (206, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 3, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 15:48:45', 0);
INSERT INTO `sys_log` VALUES (207, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 3, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 15:48:56', 0);
INSERT INTO `sys_log` VALUES (208, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 3, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 15:48:58', 0);
INSERT INTO `sys_log` VALUES (209, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 3, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 15:49:03', 0);
INSERT INTO `sys_log` VALUES (210, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 3, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 15:49:10', 0);
INSERT INTO `sys_log` VALUES (211, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 15:49:17', 0);
INSERT INTO `sys_log` VALUES (212, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 15:49:18', 0);
INSERT INTO `sys_log` VALUES (213, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 15:49:47', 0);
INSERT INTO `sys_log` VALUES (214, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 15:49:53', 0);
INSERT INTO `sys_log` VALUES (215, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 15:49:57', 0);
INSERT INTO `sys_log` VALUES (216, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 15:55:09', 0);
INSERT INTO `sys_log` VALUES (217, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 3, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 15:56:20', 0);
INSERT INTO `sys_log` VALUES (218, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 20, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:11:09', 0);
INSERT INTO `sys_log` VALUES (219, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 7, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:11:16', 0);
INSERT INTO `sys_log` VALUES (220, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:11:33', 0);
INSERT INTO `sys_log` VALUES (221, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 9, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:11:36', 0);
INSERT INTO `sys_log` VALUES (222, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:11:39', 0);
INSERT INTO `sys_log` VALUES (223, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:11:42', 0);
INSERT INTO `sys_log` VALUES (224, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:11:44', 0);
INSERT INTO `sys_log` VALUES (225, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:11:48', 0);
INSERT INTO `sys_log` VALUES (226, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 14, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:12:40', 0);
INSERT INTO `sys_log` VALUES (227, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:14:05', 0);
INSERT INTO `sys_log` VALUES (228, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:14:24', 0);
INSERT INTO `sys_log` VALUES (229, 'DEPT', '部门列表', '/api/v1/dept', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:14:50', 0);
INSERT INTO `sys_log` VALUES (230, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:18:38', 0);
INSERT INTO `sys_log` VALUES (231, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:18:42', 0);
INSERT INTO `sys_log` VALUES (232, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:18:43', 0);
INSERT INTO `sys_log` VALUES (233, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 8, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:18:46', 0);
INSERT INTO `sys_log` VALUES (234, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:19:49', 0);
INSERT INTO `sys_log` VALUES (235, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:19:51', 0);
INSERT INTO `sys_log` VALUES (236, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:19:53', 0);
INSERT INTO `sys_log` VALUES (237, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:19:53', 0);
INSERT INTO `sys_log` VALUES (238, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:19:54', 0);
INSERT INTO `sys_log` VALUES (239, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:21:22', 0);
INSERT INTO `sys_log` VALUES (240, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 3, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:22:16', 0);
INSERT INTO `sys_log` VALUES (241, 'DEPT', '部门列表', '/api/v1/dept', '114.213.211.68', '安徽省', '合肥市', 3, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:24:58', 0);
INSERT INTO `sys_log` VALUES (242, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:26:50', 0);
INSERT INTO `sys_log` VALUES (243, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:26:53', 0);
INSERT INTO `sys_log` VALUES (244, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:26:54', 0);
INSERT INTO `sys_log` VALUES (245, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:26:55', 0);
INSERT INTO `sys_log` VALUES (246, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:26:56', 0);
INSERT INTO `sys_log` VALUES (247, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:26:57', 0);
INSERT INTO `sys_log` VALUES (248, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:26:58', 0);
INSERT INTO `sys_log` VALUES (249, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:26:58', 0);
INSERT INTO `sys_log` VALUES (250, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 3, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:26:59', 0);
INSERT INTO `sys_log` VALUES (251, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:26:59', 0);
INSERT INTO `sys_log` VALUES (252, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:27:00', 0);
INSERT INTO `sys_log` VALUES (253, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:27:01', 0);
INSERT INTO `sys_log` VALUES (254, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:27:02', 0);
INSERT INTO `sys_log` VALUES (255, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:27:03', 0);
INSERT INTO `sys_log` VALUES (256, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 7, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:27:04', 0);
INSERT INTO `sys_log` VALUES (257, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:27:05', 0);
INSERT INTO `sys_log` VALUES (258, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:27:07', 0);
INSERT INTO `sys_log` VALUES (259, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:27:11', 0);
INSERT INTO `sys_log` VALUES (260, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:27:12', 0);
INSERT INTO `sys_log` VALUES (261, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:27:13', 0);
INSERT INTO `sys_log` VALUES (262, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:27:14', 0);
INSERT INTO `sys_log` VALUES (263, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:27:15', 0);
INSERT INTO `sys_log` VALUES (264, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:27:15', 0);
INSERT INTO `sys_log` VALUES (265, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:29:22', 0);
INSERT INTO `sys_log` VALUES (266, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:29:23', 0);
INSERT INTO `sys_log` VALUES (267, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:29:24', 0);
INSERT INTO `sys_log` VALUES (268, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:29:24', 0);
INSERT INTO `sys_log` VALUES (269, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 9, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:29:37', 0);
INSERT INTO `sys_log` VALUES (270, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 31, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:30:59', 0);
INSERT INTO `sys_log` VALUES (271, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 9, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:31:03', 0);
INSERT INTO `sys_log` VALUES (272, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 9, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:31:05', 0);
INSERT INTO `sys_log` VALUES (273, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 9, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:31:06', 0);
INSERT INTO `sys_log` VALUES (274, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:31:08', 0);
INSERT INTO `sys_log` VALUES (275, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:31:09', 0);
INSERT INTO `sys_log` VALUES (276, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 7, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:31:12', 0);
INSERT INTO `sys_log` VALUES (277, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:31:13', 0);
INSERT INTO `sys_log` VALUES (278, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 27, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:36:11', 0);
INSERT INTO `sys_log` VALUES (279, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 8, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:36:14', 0);
INSERT INTO `sys_log` VALUES (280, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:36:15', 0);
INSERT INTO `sys_log` VALUES (281, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 8, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:36:53', 0);
INSERT INTO `sys_log` VALUES (282, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 8, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:36:54', 0);
INSERT INTO `sys_log` VALUES (283, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:36:56', 0);
INSERT INTO `sys_log` VALUES (284, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:36:57', 0);
INSERT INTO `sys_log` VALUES (285, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:36:58', 0);
INSERT INTO `sys_log` VALUES (286, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:37:00', 0);
INSERT INTO `sys_log` VALUES (287, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:37:01', 0);
INSERT INTO `sys_log` VALUES (288, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:37:03', 0);
INSERT INTO `sys_log` VALUES (289, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:37:08', 0);
INSERT INTO `sys_log` VALUES (290, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:37:09', 0);
INSERT INTO `sys_log` VALUES (291, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:37:13', 0);
INSERT INTO `sys_log` VALUES (292, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:37:15', 0);
INSERT INTO `sys_log` VALUES (293, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:37:54', 0);
INSERT INTO `sys_log` VALUES (294, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:38:37', 0);
INSERT INTO `sys_log` VALUES (295, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:38:55', 0);
INSERT INTO `sys_log` VALUES (296, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:39:01', 0);
INSERT INTO `sys_log` VALUES (297, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:39:02', 0);
INSERT INTO `sys_log` VALUES (298, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:39:06', 0);
INSERT INTO `sys_log` VALUES (299, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:39:08', 0);
INSERT INTO `sys_log` VALUES (300, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:39:09', 0);
INSERT INTO `sys_log` VALUES (301, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:39:09', 0);
INSERT INTO `sys_log` VALUES (302, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:39:10', 0);
INSERT INTO `sys_log` VALUES (303, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:39:11', 0);
INSERT INTO `sys_log` VALUES (304, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:39:12', 0);
INSERT INTO `sys_log` VALUES (305, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:39:14', 0);
INSERT INTO `sys_log` VALUES (306, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:39:14', 0);
INSERT INTO `sys_log` VALUES (307, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:39:16', 0);
INSERT INTO `sys_log` VALUES (308, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:39:16', 0);
INSERT INTO `sys_log` VALUES (309, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:39:17', 0);
INSERT INTO `sys_log` VALUES (310, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:39:19', 0);
INSERT INTO `sys_log` VALUES (311, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:39:19', 0);
INSERT INTO `sys_log` VALUES (312, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:39:20', 0);
INSERT INTO `sys_log` VALUES (313, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:39:21', 0);
INSERT INTO `sys_log` VALUES (314, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:41:55', 0);
INSERT INTO `sys_log` VALUES (315, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:41:58', 0);
INSERT INTO `sys_log` VALUES (316, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:41:59', 0);
INSERT INTO `sys_log` VALUES (317, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:42:13', 0);
INSERT INTO `sys_log` VALUES (318, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:42:15', 0);
INSERT INTO `sys_log` VALUES (319, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:42:16', 0);
INSERT INTO `sys_log` VALUES (320, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:42:17', 0);
INSERT INTO `sys_log` VALUES (321, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:42:18', 0);
INSERT INTO `sys_log` VALUES (322, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:42:24', 0);
INSERT INTO `sys_log` VALUES (323, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:42:26', 0);
INSERT INTO `sys_log` VALUES (324, 'LOGIN', '登录', '/api/v1/auth/login', '114.213.211.68', '安徽省', '合肥市', 135, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:45:59', 0);
INSERT INTO `sys_log` VALUES (325, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:46:00', 0);
INSERT INTO `sys_log` VALUES (326, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:47:23', 0);
INSERT INTO `sys_log` VALUES (327, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 28, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:47:52', 0);
INSERT INTO `sys_log` VALUES (328, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 8, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:47:55', 0);
INSERT INTO `sys_log` VALUES (329, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 9, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:48:51', 0);
INSERT INTO `sys_log` VALUES (330, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 9, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:49:28', 0);
INSERT INTO `sys_log` VALUES (331, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:49:58', 0);
INSERT INTO `sys_log` VALUES (332, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:50:00', 0);
INSERT INTO `sys_log` VALUES (333, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:50:01', 0);
INSERT INTO `sys_log` VALUES (334, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:50:02', 0);
INSERT INTO `sys_log` VALUES (335, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:50:03', 0);
INSERT INTO `sys_log` VALUES (336, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:50:05', 0);
INSERT INTO `sys_log` VALUES (337, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:50:16', 0);
INSERT INTO `sys_log` VALUES (338, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:50:18', 0);
INSERT INTO `sys_log` VALUES (339, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:50:21', 0);
INSERT INTO `sys_log` VALUES (340, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:52:40', 0);
INSERT INTO `sys_log` VALUES (341, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:52:43', 0);
INSERT INTO `sys_log` VALUES (342, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:52:45', 0);
INSERT INTO `sys_log` VALUES (343, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:52:48', 0);
INSERT INTO `sys_log` VALUES (344, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:53:43', 0);
INSERT INTO `sys_log` VALUES (345, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:56:11', 0);
INSERT INTO `sys_log` VALUES (346, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:56:12', 0);
INSERT INTO `sys_log` VALUES (347, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:56:13', 0);
INSERT INTO `sys_log` VALUES (348, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:56:14', 0);
INSERT INTO `sys_log` VALUES (349, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:56:16', 0);
INSERT INTO `sys_log` VALUES (350, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:56:16', 0);
INSERT INTO `sys_log` VALUES (351, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:56:18', 0);
INSERT INTO `sys_log` VALUES (352, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:56:18', 0);
INSERT INTO `sys_log` VALUES (353, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 3, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-05 16:56:19', 0);
INSERT INTO `sys_log` VALUES (354, 'LOGIN', '登录', '/api/v1/auth/login', '114.213.211.68', '安徽省', '合肥市', 618, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-06 09:55:44', 0);
INSERT INTO `sys_log` VALUES (355, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 23, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-06 09:56:44', 0);
INSERT INTO `sys_log` VALUES (356, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 14, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-06 09:58:11', 0);
INSERT INTO `sys_log` VALUES (357, 'LOGIN', '注销', '/api/v1/auth/logout', '114.213.211.68', '安徽省', '合肥市', 1, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-06 09:59:21', 0);
INSERT INTO `sys_log` VALUES (358, 'LOGIN', '登录', '/api/v1/auth/login', '114.213.211.68', '安徽省', '合肥市', 143, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-06 09:59:30', 0);
INSERT INTO `sys_log` VALUES (359, 'LOGIN', '注销', '/api/v1/auth/logout', '114.213.211.68', '安徽省', '合肥市', 0, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-06 10:04:23', 0);
INSERT INTO `sys_log` VALUES (360, 'LOGIN', '登录', '/api/v1/auth/login', '114.213.211.68', '安徽省', '合肥市', 73, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-06 10:05:34', 0);
INSERT INTO `sys_log` VALUES (361, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 16, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-06 10:05:57', 0);
INSERT INTO `sys_log` VALUES (362, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 8, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-06 10:06:21', 0);
INSERT INTO `sys_log` VALUES (363, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-06 10:06:23', 0);
INSERT INTO `sys_log` VALUES (364, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 7, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-06 10:06:24', 0);
INSERT INTO `sys_log` VALUES (365, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 11, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-06 10:06:33', 0);
INSERT INTO `sys_log` VALUES (366, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 7, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-06 10:08:29', 0);
INSERT INTO `sys_log` VALUES (367, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-06 10:08:37', 0);
INSERT INTO `sys_log` VALUES (368, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 9, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-06 10:08:38', 0);
INSERT INTO `sys_log` VALUES (369, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 7, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-06 10:08:42', 0);
INSERT INTO `sys_log` VALUES (370, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-06 10:08:44', 0);
INSERT INTO `sys_log` VALUES (371, 'LOGIN', '注销', '/api/v1/auth/logout', '114.213.211.68', '安徽省', '合肥市', 0, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-06 10:25:02', 0);
INSERT INTO `sys_log` VALUES (372, 'LOGIN', '登录', '/api/v1/auth/login', '114.213.211.68', '安徽省', '合肥市', 592, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-08 19:54:55', 0);
INSERT INTO `sys_log` VALUES (373, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 37, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-08 19:55:02', 0);
INSERT INTO `sys_log` VALUES (374, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 14, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-08 19:55:05', 0);
INSERT INTO `sys_log` VALUES (375, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 12, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-08 19:55:06', 0);
INSERT INTO `sys_log` VALUES (376, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 15, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-08 19:55:08', 0);
INSERT INTO `sys_log` VALUES (377, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 12, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-08 19:55:12', 0);
INSERT INTO `sys_log` VALUES (378, 'LOGIN', '登录', '/api/v1/auth/login', '114.213.211.68', '安徽省', '合肥市', 588, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-09 10:16:04', 0);
INSERT INTO `sys_log` VALUES (379, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 37, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-09 10:16:33', 0);
INSERT INTO `sys_log` VALUES (380, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 13, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-09 10:16:40', 0);
INSERT INTO `sys_log` VALUES (381, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 23, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-09 10:28:47', 0);
INSERT INTO `sys_log` VALUES (382, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 21, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-09 10:29:39', 0);
INSERT INTO `sys_log` VALUES (383, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 12, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-09 10:35:26', 0);
INSERT INTO `sys_log` VALUES (384, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 13, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-09 10:35:33', 0);
INSERT INTO `sys_log` VALUES (385, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 11, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-09 10:35:39', 0);
INSERT INTO `sys_log` VALUES (386, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 16, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-09 10:35:44', 0);
INSERT INTO `sys_log` VALUES (387, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 11, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-09 10:35:48', 0);
INSERT INTO `sys_log` VALUES (388, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 10, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-09 10:35:54', 0);
INSERT INTO `sys_log` VALUES (389, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 9, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-09 10:35:59', 0);
INSERT INTO `sys_log` VALUES (390, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 11, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-09 10:36:05', 0);
INSERT INTO `sys_log` VALUES (391, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 11, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-09 10:36:10', 0);
INSERT INTO `sys_log` VALUES (392, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 14, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-09 10:36:15', 0);
INSERT INTO `sys_log` VALUES (393, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 14, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-09 10:36:27', 0);
INSERT INTO `sys_log` VALUES (394, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 11, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-09 10:36:29', 0);
INSERT INTO `sys_log` VALUES (395, 'LOGIN', '注销', '/api/v1/auth/logout', '114.213.211.68', '安徽省', '合肥市', 1, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-09 10:37:21', 0);
INSERT INTO `sys_log` VALUES (396, 'LOGIN', '登录', '/api/v1/auth/login', '114.213.211.68', '安徽省', '合肥市', 587, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-09 14:06:48', 0);
INSERT INTO `sys_log` VALUES (397, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 25, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-09 14:07:02', 0);
INSERT INTO `sys_log` VALUES (398, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 16, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-09 14:07:03', 0);
INSERT INTO `sys_log` VALUES (399, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 36, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-09 14:08:37', 0);
INSERT INTO `sys_log` VALUES (400, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 34, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-09 14:08:40', 0);
INSERT INTO `sys_log` VALUES (401, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 9, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-09 14:09:53', 0);
INSERT INTO `sys_log` VALUES (402, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 7, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-09 14:10:55', 0);
INSERT INTO `sys_log` VALUES (403, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 8, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-09 14:10:57', 0);
INSERT INTO `sys_log` VALUES (404, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 7, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-09 14:10:59', 0);
INSERT INTO `sys_log` VALUES (405, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 18, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-09 14:11:48', 0);
INSERT INTO `sys_log` VALUES (406, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 13, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-09 14:11:54', 0);
INSERT INTO `sys_log` VALUES (407, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 15, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-09 14:12:02', 0);
INSERT INTO `sys_log` VALUES (408, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 12, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-09 14:12:07', 0);
INSERT INTO `sys_log` VALUES (409, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 12, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-09 14:12:12', 0);
INSERT INTO `sys_log` VALUES (410, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 11, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-09 14:12:17', 0);
INSERT INTO `sys_log` VALUES (411, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 10, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-09 14:12:22', 0);
INSERT INTO `sys_log` VALUES (412, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 9, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-09 14:12:27', 0);
INSERT INTO `sys_log` VALUES (413, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 10, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-09 14:12:32', 0);
INSERT INTO `sys_log` VALUES (414, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 13, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-09 14:12:39', 0);
INSERT INTO `sys_log` VALUES (415, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 17, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-09 14:15:06', 0);
INSERT INTO `sys_log` VALUES (416, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 10, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-09 14:17:33', 0);
INSERT INTO `sys_log` VALUES (417, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 13, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-09 14:17:47', 0);
INSERT INTO `sys_log` VALUES (418, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 7, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-09 14:17:49', 0);
INSERT INTO `sys_log` VALUES (419, 'LOGIN', '注销', '/api/v1/auth/logout', '114.213.211.68', '安徽省', '合肥市', 1, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-09 14:18:47', 0);
INSERT INTO `sys_log` VALUES (420, 'LOGIN', '登录', '/api/v1/auth/login', '114.213.211.68', '安徽省', '合肥市', 61, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 302, '2024-07-09 14:19:05', 0);
INSERT INTO `sys_log` VALUES (421, 'LOGIN', '登录', '/api/v1/auth/login', '114.213.211.68', '安徽省', '合肥市', 59, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 302, '2024-07-09 14:19:21', 0);
INSERT INTO `sys_log` VALUES (422, 'LOGIN', '登录', '/api/v1/auth/login', '114.213.211.68', '安徽省', '合肥市', 60, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 302, '2024-07-09 14:19:58', 0);
INSERT INTO `sys_log` VALUES (423, 'LOGIN', '登录', '/api/v1/auth/login', '114.213.211.68', '安徽省', '合肥市', 69, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 290, '2024-07-09 14:21:10', 0);
INSERT INTO `sys_log` VALUES (424, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 13, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 290, '2024-07-09 14:21:11', 0);
INSERT INTO `sys_log` VALUES (425, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 7, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 290, '2024-07-09 14:21:36', 0);
INSERT INTO `sys_log` VALUES (426, 'LOGIN', '注销', '/api/v1/auth/logout', '114.213.211.68', '安徽省', '合肥市', 0, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 290, '2024-07-09 14:21:47', 0);
INSERT INTO `sys_log` VALUES (427, 'LOGIN', '登录', '/api/v1/auth/login', '114.213.211.68', '安徽省', '合肥市', 60, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 295, '2024-07-09 14:22:09', 0);
INSERT INTO `sys_log` VALUES (428, 'LOGIN', '登录', '/api/v1/auth/login', '114.213.211.68', '安徽省', '合肥市', 63, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 290, '2024-07-09 14:26:45', 0);
INSERT INTO `sys_log` VALUES (429, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 9, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 290, '2024-07-09 14:26:46', 0);
INSERT INTO `sys_log` VALUES (430, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 8, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 290, '2024-07-09 14:26:52', 0);
INSERT INTO `sys_log` VALUES (431, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 7, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 290, '2024-07-09 14:26:53', 0);
INSERT INTO `sys_log` VALUES (432, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 10, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 290, '2024-07-09 14:26:59', 0);
INSERT INTO `sys_log` VALUES (433, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 10, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 290, '2024-07-09 14:27:29', 0);
INSERT INTO `sys_log` VALUES (434, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 7, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 290, '2024-07-09 14:27:43', 0);
INSERT INTO `sys_log` VALUES (435, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 290, '2024-07-09 14:27:53', 0);
INSERT INTO `sys_log` VALUES (436, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 290, '2024-07-09 14:28:02', 0);
INSERT INTO `sys_log` VALUES (437, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 8, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 290, '2024-07-09 14:28:07', 0);
INSERT INTO `sys_log` VALUES (438, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 7, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 290, '2024-07-09 14:28:23', 0);
INSERT INTO `sys_log` VALUES (439, 'LOGIN', '注销', '/api/v1/auth/logout', '114.213.211.68', '安徽省', '合肥市', 1, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 290, '2024-07-09 14:28:33', 0);
INSERT INTO `sys_log` VALUES (440, 'LOGIN', '登录', '/api/v1/auth/login', '114.213.211.68', '安徽省', '合肥市', 63, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 295, '2024-07-09 14:28:52', 0);
INSERT INTO `sys_log` VALUES (441, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 10, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 295, '2024-07-09 14:29:01', 0);
INSERT INTO `sys_log` VALUES (442, 'DEPT', '部门列表', '/api/v1/dept', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 295, '2024-07-09 14:29:02', 0);
INSERT INTO `sys_log` VALUES (443, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 8, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 295, '2024-07-09 14:29:56', 0);
INSERT INTO `sys_log` VALUES (444, 'LOGIN', '注销', '/api/v1/auth/logout', '114.213.211.68', '安徽省', '合肥市', 0, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 295, '2024-07-09 14:30:13', 0);
INSERT INTO `sys_log` VALUES (445, 'LOGIN', '登录', '/api/v1/auth/login', '114.213.211.68', '安徽省', '合肥市', 62, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 295, '2024-07-09 14:30:20', 0);
INSERT INTO `sys_log` VALUES (446, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 8, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 295, '2024-07-09 14:30:24', 0);
INSERT INTO `sys_log` VALUES (447, 'LOGIN', '登录', '/api/v1/auth/login', '114.213.211.68', '安徽省', '合肥市', 554, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-10 15:00:31', 0);
INSERT INTO `sys_log` VALUES (448, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 47, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-10 15:52:04', 0);
INSERT INTO `sys_log` VALUES (449, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 23, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-10 15:52:17', 0);
INSERT INTO `sys_log` VALUES (450, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 12, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-10 15:52:24', 0);
INSERT INTO `sys_log` VALUES (451, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 13, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-10 15:52:30', 0);
INSERT INTO `sys_log` VALUES (452, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 12, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-10 15:52:38', 0);
INSERT INTO `sys_log` VALUES (453, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 11, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-10 15:52:47', 0);
INSERT INTO `sys_log` VALUES (454, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 12, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-10 15:52:55', 0);
INSERT INTO `sys_log` VALUES (455, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 12, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-10 15:53:02', 0);
INSERT INTO `sys_log` VALUES (456, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 12, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-10 15:53:06', 0);
INSERT INTO `sys_log` VALUES (457, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 15, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-10 15:53:15', 0);
INSERT INTO `sys_log` VALUES (458, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 11, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-10 15:53:19', 0);
INSERT INTO `sys_log` VALUES (459, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 18, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-10 15:53:20', 0);
INSERT INTO `sys_log` VALUES (460, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 13, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-10 15:55:36', 0);
INSERT INTO `sys_log` VALUES (461, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 12, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-10 15:58:07', 0);
INSERT INTO `sys_log` VALUES (462, 'LOGIN', '登录', '/api/v1/auth/login', '114.213.211.68', '安徽省', '合肥市', 65, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-10 16:01:03', 0);
INSERT INTO `sys_log` VALUES (463, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 12, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-10 16:01:04', 0);
INSERT INTO `sys_log` VALUES (464, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 10, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-10 16:01:24', 0);
INSERT INTO `sys_log` VALUES (465, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 80, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-10 16:02:01', 0);
INSERT INTO `sys_log` VALUES (466, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 21, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-10 16:03:53', 0);
INSERT INTO `sys_log` VALUES (467, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 17, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-10 16:04:19', 0);
INSERT INTO `sys_log` VALUES (468, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 24, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-10 16:05:47', 0);
INSERT INTO `sys_log` VALUES (469, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 13, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-10 16:05:48', 0);
INSERT INTO `sys_log` VALUES (470, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 17, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-10 16:08:12', 0);
INSERT INTO `sys_log` VALUES (471, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 14, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-10 16:09:45', 0);
INSERT INTO `sys_log` VALUES (472, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 10, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-10 16:09:47', 0);
INSERT INTO `sys_log` VALUES (473, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 14, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-10 16:14:15', 0);
INSERT INTO `sys_log` VALUES (474, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 15, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-10 16:16:54', 0);
INSERT INTO `sys_log` VALUES (475, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 12, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-10 16:17:22', 0);
INSERT INTO `sys_log` VALUES (476, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 15, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-10 16:25:04', 0);
INSERT INTO `sys_log` VALUES (477, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 11, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-10 16:35:02', 0);
INSERT INTO `sys_log` VALUES (478, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 14, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-10 16:35:11', 0);
INSERT INTO `sys_log` VALUES (479, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 11, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-10 16:40:52', 0);
INSERT INTO `sys_log` VALUES (480, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 15, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-10 16:42:52', 0);
INSERT INTO `sys_log` VALUES (481, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 13, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-10 16:48:27', 0);
INSERT INTO `sys_log` VALUES (482, 'LOGIN', '登录', '/api/v1/auth/login', '114.213.211.68', '安徽省', '合肥市', 163, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-10 19:35:39', 0);
INSERT INTO `sys_log` VALUES (483, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 41, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-10 19:35:40', 0);
INSERT INTO `sys_log` VALUES (484, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 22, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-10 19:48:58', 0);
INSERT INTO `sys_log` VALUES (485, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 12, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-10 19:49:30', 0);
INSERT INTO `sys_log` VALUES (486, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 14, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-10 19:49:40', 0);
INSERT INTO `sys_log` VALUES (487, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 18, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-10 19:51:04', 0);
INSERT INTO `sys_log` VALUES (488, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 11, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-10 19:51:17', 0);
INSERT INTO `sys_log` VALUES (489, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 13, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-10 19:57:58', 0);
INSERT INTO `sys_log` VALUES (490, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 11, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-10 20:08:04', 0);
INSERT INTO `sys_log` VALUES (491, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 11, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-10 20:14:17', 0);
INSERT INTO `sys_log` VALUES (492, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 15, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-10 20:14:30', 0);
INSERT INTO `sys_log` VALUES (493, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 12, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-10 20:15:10', 0);
INSERT INTO `sys_log` VALUES (494, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 15, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-10 20:15:19', 0);
INSERT INTO `sys_log` VALUES (495, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 13, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-10 20:20:29', 0);
INSERT INTO `sys_log` VALUES (496, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 13, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-10 20:20:35', 0);
INSERT INTO `sys_log` VALUES (497, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 11, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-10 20:22:44', 0);
INSERT INTO `sys_log` VALUES (498, 'LOGIN', '注销', '/api/v1/auth/logout', '114.213.211.68', '安徽省', '合肥市', 0, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-10 20:23:29', 0);
INSERT INTO `sys_log` VALUES (499, 'LOGIN', '登录', '/api/v1/auth/login', '114.213.211.68', '安徽省', '合肥市', 66, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-10 20:23:36', 0);
INSERT INTO `sys_log` VALUES (500, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 11, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-10 20:23:36', 0);
INSERT INTO `sys_log` VALUES (501, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 13, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-10 20:27:45', 0);
INSERT INTO `sys_log` VALUES (502, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 12, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-10 20:34:46', 0);
INSERT INTO `sys_log` VALUES (503, 'LOGIN', '登录', '/api/v1/auth/login', '114.213.211.68', '安徽省', '合肥市', 629, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-10 21:40:05', 0);
INSERT INTO `sys_log` VALUES (504, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 35, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-10 21:40:05', 0);
INSERT INTO `sys_log` VALUES (505, 'LOGIN', '登录', '/api/v1/auth/login', '114.213.211.68', '安徽省', '合肥市', 604, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 14:22:07', 0);
INSERT INTO `sys_log` VALUES (506, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 33, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 14:22:17', 0);
INSERT INTO `sys_log` VALUES (507, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 33, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 14:22:34', 0);
INSERT INTO `sys_log` VALUES (508, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 28, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 14:51:10', 0);
INSERT INTO `sys_log` VALUES (509, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 14, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 14:51:13', 0);
INSERT INTO `sys_log` VALUES (510, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 96, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 14:57:10', 0);
INSERT INTO `sys_log` VALUES (511, 'LOGIN', '登录', '/api/v1/auth/login', '114.213.211.68', '安徽省', '合肥市', 153, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 16:25:12', 0);
INSERT INTO `sys_log` VALUES (512, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 13, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 16:34:02', 0);
INSERT INTO `sys_log` VALUES (513, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 3, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 16:35:26', 0);
INSERT INTO `sys_log` VALUES (514, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 0, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 16:35:53', 0);
INSERT INTO `sys_log` VALUES (515, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 16:35:59', 0);
INSERT INTO `sys_log` VALUES (516, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 7, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 16:36:27', 0);
INSERT INTO `sys_log` VALUES (517, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 16:39:44', 0);
INSERT INTO `sys_log` VALUES (518, 'LOGIN', '登录', '/api/v1/auth/login', '114.213.211.68', '安徽省', '合肥市', 631, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 19:55:29', 0);
INSERT INTO `sys_log` VALUES (519, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 18, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 20:54:22', 0);
INSERT INTO `sys_log` VALUES (520, 'LOGIN', '登录', '/api/v1/auth/login', '114.213.211.68', '安徽省', '合肥市', 69, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 20:55:34', 0);
INSERT INTO `sys_log` VALUES (521, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 9, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 20:55:35', 0);
INSERT INTO `sys_log` VALUES (522, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 28, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 20:56:50', 0);
INSERT INTO `sys_log` VALUES (523, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 7, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 20:57:30', 0);
INSERT INTO `sys_log` VALUES (524, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 20:58:30', 0);
INSERT INTO `sys_log` VALUES (525, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 7, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 20:58:36', 0);
INSERT INTO `sys_log` VALUES (526, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 8, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 21:30:55', 0);
INSERT INTO `sys_log` VALUES (527, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 9, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 21:32:48', 0);
INSERT INTO `sys_log` VALUES (528, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 15, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 21:32:50', 0);
INSERT INTO `sys_log` VALUES (529, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 8, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 21:33:31', 0);
INSERT INTO `sys_log` VALUES (530, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 21:33:41', 0);
INSERT INTO `sys_log` VALUES (531, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 10, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 21:33:44', 0);
INSERT INTO `sys_log` VALUES (532, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 21:42:53', 0);
INSERT INTO `sys_log` VALUES (533, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 8, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 21:42:54', 0);
INSERT INTO `sys_log` VALUES (534, 'LOGIN', '注销', '/api/v1/auth/logout', '114.213.211.68', '安徽省', '合肥市', 2, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 21:54:15', 0);
INSERT INTO `sys_log` VALUES (535, 'LOGIN', '登录', '/api/v1/auth/login', '114.213.211.68', '安徽省', '合肥市', 138, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 21:54:20', 0);
INSERT INTO `sys_log` VALUES (536, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 21:54:40', 0);
INSERT INTO `sys_log` VALUES (537, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 7, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 21:54:44', 0);
INSERT INTO `sys_log` VALUES (538, 'LOGIN', '登录', '/api/v1/auth/login', '114.213.211.68', '安徽省', '合肥市', 602, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 21:58:25', 0);
INSERT INTO `sys_log` VALUES (539, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 25, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 21:58:26', 0);
INSERT INTO `sys_log` VALUES (540, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 20, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 21:58:28', 0);
INSERT INTO `sys_log` VALUES (541, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 7, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 21:58:35', 0);
INSERT INTO `sys_log` VALUES (542, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 8, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 21:58:38', 0);
INSERT INTO `sys_log` VALUES (543, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 202, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 22:16:04', 0);
INSERT INTO `sys_log` VALUES (544, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 104, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 22:17:11', 0);
INSERT INTO `sys_log` VALUES (545, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 22:18:02', 0);
INSERT INTO `sys_log` VALUES (546, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 9, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 22:18:10', 0);
INSERT INTO `sys_log` VALUES (547, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 11, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 22:18:11', 0);
INSERT INTO `sys_log` VALUES (548, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 18, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 22:19:47', 0);
INSERT INTO `sys_log` VALUES (549, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 13, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 22:19:48', 0);
INSERT INTO `sys_log` VALUES (550, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 29, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 22:26:02', 0);
INSERT INTO `sys_log` VALUES (551, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 85, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 22:36:16', 0);
INSERT INTO `sys_log` VALUES (552, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 26, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 22:37:37', 0);
INSERT INTO `sys_log` VALUES (553, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 142, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 22:37:44', 0);
INSERT INTO `sys_log` VALUES (554, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 9, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 22:39:30', 0);
INSERT INTO `sys_log` VALUES (555, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 8, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 22:40:07', 0);
INSERT INTO `sys_log` VALUES (556, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 17, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 22:40:49', 0);
INSERT INTO `sys_log` VALUES (557, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 7, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 22:40:55', 0);
INSERT INTO `sys_log` VALUES (558, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 10, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 22:40:57', 0);
INSERT INTO `sys_log` VALUES (559, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 22:41:08', 0);
INSERT INTO `sys_log` VALUES (560, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 9, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 22:41:11', 0);
INSERT INTO `sys_log` VALUES (561, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 11, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 22:44:35', 0);
INSERT INTO `sys_log` VALUES (562, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 21, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 22:45:41', 0);
INSERT INTO `sys_log` VALUES (563, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 15, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 22:45:52', 0);
INSERT INTO `sys_log` VALUES (564, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 12, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 22:46:51', 0);
INSERT INTO `sys_log` VALUES (565, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 8, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 22:47:52', 0);
INSERT INTO `sys_log` VALUES (566, 'LOGIN', '登录', '/api/v1/auth/login', '114.213.211.68', '安徽省', '合肥市', 93, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 295, '2024-07-12 22:54:52', 0);
INSERT INTO `sys_log` VALUES (567, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 13, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 295, '2024-07-12 22:54:57', 0);
INSERT INTO `sys_log` VALUES (568, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 72, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 295, '2024-07-12 22:56:15', 0);
INSERT INTO `sys_log` VALUES (569, 'LOGIN', '注销', '/api/v1/auth/logout', '114.213.211.68', '安徽省', '合肥市', 2, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 295, '2024-07-12 22:56:55', 0);
INSERT INTO `sys_log` VALUES (570, 'LOGIN', '登录', '/api/v1/auth/login', '114.213.211.68', '安徽省', '合肥市', 198, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 22:57:05', 0);
INSERT INTO `sys_log` VALUES (571, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 131, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 22:57:49', 0);
INSERT INTO `sys_log` VALUES (572, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 403, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 22:58:00', 0);
INSERT INTO `sys_log` VALUES (573, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 47, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 22:58:15', 0);
INSERT INTO `sys_log` VALUES (574, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 22:58:58', 0);
INSERT INTO `sys_log` VALUES (575, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 17, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 22:59:49', 0);
INSERT INTO `sys_log` VALUES (576, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 15, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 23:00:38', 0);
INSERT INTO `sys_log` VALUES (577, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 16, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 23:01:04', 0);
INSERT INTO `sys_log` VALUES (578, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 18, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 23:01:06', 0);
INSERT INTO `sys_log` VALUES (579, 'LOGIN', '注销', '/api/v1/auth/logout', '114.213.211.68', '安徽省', '合肥市', 1, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 23:15:09', 0);
INSERT INTO `sys_log` VALUES (580, 'LOGIN', '登录', '/api/v1/auth/login', '114.213.211.68', '安徽省', '合肥市', 157, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 23:15:17', 0);
INSERT INTO `sys_log` VALUES (581, 'LOGIN', '注销', '/api/v1/auth/logout', '114.213.211.68', '安徽省', '合肥市', 0, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 23:15:24', 0);
INSERT INTO `sys_log` VALUES (582, 'LOGIN', '登录', '/api/v1/auth/login', '114.213.211.68', '安徽省', '合肥市', 76, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 295, '2024-07-12 23:15:41', 0);
INSERT INTO `sys_log` VALUES (583, 'LOGIN', '注销', '/api/v1/auth/logout', '114.213.211.68', '安徽省', '合肥市', 0, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 295, '2024-07-12 23:16:08', 0);
INSERT INTO `sys_log` VALUES (584, 'LOGIN', '登录', '/api/v1/auth/login', '114.213.211.68', '安徽省', '合肥市', 79, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 23:16:16', 0);
INSERT INTO `sys_log` VALUES (585, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 32, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 23:16:23', 0);
INSERT INTO `sys_log` VALUES (586, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 38, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 23:16:27', 0);
INSERT INTO `sys_log` VALUES (587, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 16, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 23:16:46', 0);
INSERT INTO `sys_log` VALUES (588, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 22, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 23:16:48', 0);
INSERT INTO `sys_log` VALUES (589, 'LOGIN', '注销', '/api/v1/auth/logout', '114.213.211.68', '安徽省', '合肥市', 1, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 23:16:59', 0);
INSERT INTO `sys_log` VALUES (590, 'LOGIN', '登录', '/api/v1/auth/login', '114.213.211.68', '安徽省', '合肥市', 77, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 23:17:03', 0);
INSERT INTO `sys_log` VALUES (591, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 24, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 23:17:03', 0);
INSERT INTO `sys_log` VALUES (592, 'LOGIN', '登录', '/api/v1/auth/login', '114.213.211.68', '安徽省', '合肥市', 649, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 23:32:58', 0);
INSERT INTO `sys_log` VALUES (593, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 22, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 23:33:08', 0);
INSERT INTO `sys_log` VALUES (594, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 7, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 23:33:17', 0);
INSERT INTO `sys_log` VALUES (595, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 9, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 23:33:19', 0);
INSERT INTO `sys_log` VALUES (596, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 9, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 23:33:23', 0);
INSERT INTO `sys_log` VALUES (597, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-12 23:33:46', 0);
INSERT INTO `sys_log` VALUES (598, 'LOGIN', '登录', '/api/v1/auth/login', '114.213.211.68', '安徽省', '合肥市', 155, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-13 09:54:17', 0);
INSERT INTO `sys_log` VALUES (599, 'LOGIN', '注销', '/api/v1/auth/logout', '114.213.211.68', '安徽省', '合肥市', 1, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-13 09:54:32', 0);
INSERT INTO `sys_log` VALUES (600, 'LOGIN', '登录', '/api/v1/auth/login', '114.213.211.68', '安徽省', '合肥市', 72, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-13 10:13:02', 0);
INSERT INTO `sys_log` VALUES (601, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 24, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-13 10:13:36', 0);
INSERT INTO `sys_log` VALUES (602, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 8, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-13 10:14:26', 0);
INSERT INTO `sys_log` VALUES (603, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-13 10:14:28', 0);
INSERT INTO `sys_log` VALUES (604, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-13 10:14:29', 0);
INSERT INTO `sys_log` VALUES (605, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-13 10:14:30', 0);
INSERT INTO `sys_log` VALUES (606, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 12, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-13 10:14:45', 0);
INSERT INTO `sys_log` VALUES (607, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-13 10:14:47', 0);
INSERT INTO `sys_log` VALUES (608, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 7, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-13 10:14:59', 0);
INSERT INTO `sys_log` VALUES (609, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 9, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-13 10:15:26', 0);
INSERT INTO `sys_log` VALUES (610, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-13 10:18:39', 0);
INSERT INTO `sys_log` VALUES (611, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-13 10:18:44', 0);
INSERT INTO `sys_log` VALUES (612, 'LOGIN', '注销', '/api/v1/auth/logout', '114.213.211.68', '安徽省', '合肥市', 0, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-13 10:18:51', 0);
INSERT INTO `sys_log` VALUES (613, 'LOGIN', '登录', '/api/v1/auth/login', '114.213.211.68', '安徽省', '合肥市', 70, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 295, '2024-07-13 10:19:11', 0);
INSERT INTO `sys_log` VALUES (614, 'LOGIN', '注销', '/api/v1/auth/logout', '114.213.211.68', '安徽省', '合肥市', 1, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 295, '2024-07-13 10:20:00', 0);
INSERT INTO `sys_log` VALUES (615, 'LOGIN', '登录', '/api/v1/auth/login', '114.213.211.68', '安徽省', '合肥市', 68, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-13 10:20:08', 0);
INSERT INTO `sys_log` VALUES (616, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 9, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-13 10:20:25', 0);
INSERT INTO `sys_log` VALUES (617, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 10, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-13 10:39:17', 0);
INSERT INTO `sys_log` VALUES (618, 'LOGIN', '登录', '/api/v1/auth/login', '114.213.211.68', '安徽省', '合肥市', 157, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 13:37:06', 0);
INSERT INTO `sys_log` VALUES (619, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 19, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 13:43:57', 0);
INSERT INTO `sys_log` VALUES (620, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 8, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 13:44:31', 0);
INSERT INTO `sys_log` VALUES (621, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 11, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 13:44:38', 0);
INSERT INTO `sys_log` VALUES (622, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 13:53:27', 0);
INSERT INTO `sys_log` VALUES (623, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 7, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 13:59:08', 0);
INSERT INTO `sys_log` VALUES (624, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 13:59:55', 0);
INSERT INTO `sys_log` VALUES (625, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 14:01:32', 0);
INSERT INTO `sys_log` VALUES (626, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 8, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 14:01:38', 0);
INSERT INTO `sys_log` VALUES (627, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 11, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 14:01:39', 0);
INSERT INTO `sys_log` VALUES (628, 'DEPT', '部门列表', '/api/v1/dept', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 14:01:39', 0);
INSERT INTO `sys_log` VALUES (629, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 9, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 14:01:46', 0);
INSERT INTO `sys_log` VALUES (630, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 7, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 14:01:51', 0);
INSERT INTO `sys_log` VALUES (631, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 14:01:59', 0);
INSERT INTO `sys_log` VALUES (632, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 14:02:01', 0);
INSERT INTO `sys_log` VALUES (633, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 14:03:32', 0);
INSERT INTO `sys_log` VALUES (634, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 14:04:06', 0);
INSERT INTO `sys_log` VALUES (635, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 14:06:28', 0);
INSERT INTO `sys_log` VALUES (636, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 14:11:40', 0);
INSERT INTO `sys_log` VALUES (637, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 14:14:33', 0);
INSERT INTO `sys_log` VALUES (638, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 14:16:17', 0);
INSERT INTO `sys_log` VALUES (639, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 9, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 14:16:20', 0);
INSERT INTO `sys_log` VALUES (640, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 14:16:52', 0);
INSERT INTO `sys_log` VALUES (641, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 14:17:17', 0);
INSERT INTO `sys_log` VALUES (642, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 14:17:38', 0);
INSERT INTO `sys_log` VALUES (643, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 14:17:41', 0);
INSERT INTO `sys_log` VALUES (644, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 14:20:38', 0);
INSERT INTO `sys_log` VALUES (645, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 14:20:44', 0);
INSERT INTO `sys_log` VALUES (646, 'DEPT', '部门列表', '/api/v1/dept', '114.213.211.68', '安徽省', '合肥市', 3, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 14:21:55', 0);
INSERT INTO `sys_log` VALUES (647, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 14:23:12', 0);
INSERT INTO `sys_log` VALUES (648, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 14:23:25', 0);
INSERT INTO `sys_log` VALUES (649, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 14:25:46', 0);
INSERT INTO `sys_log` VALUES (650, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 14:25:53', 0);
INSERT INTO `sys_log` VALUES (651, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 14:27:16', 0);
INSERT INTO `sys_log` VALUES (652, 'DEPT', '部门列表', '/api/v1/dept', '114.213.211.68', '安徽省', '合肥市', 3, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 14:29:58', 0);
INSERT INTO `sys_log` VALUES (653, 'LOGIN', '登录', '/api/v1/auth/login', '114.213.211.68', '安徽省', '合肥市', 608, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 14:45:01', 0);
INSERT INTO `sys_log` VALUES (654, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 27, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 14:45:01', 0);
INSERT INTO `sys_log` VALUES (655, 'LOGIN', '登录', '/api/v1/auth/login', '114.213.211.68', '安徽省', '合肥市', 630, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 16:20:42', 0);
INSERT INTO `sys_log` VALUES (656, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 36, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 16:20:43', 0);
INSERT INTO `sys_log` VALUES (657, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 17, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 16:41:10', 0);
INSERT INTO `sys_log` VALUES (658, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 18, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 16:41:17', 0);
INSERT INTO `sys_log` VALUES (659, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 12, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 16:49:36', 0);
INSERT INTO `sys_log` VALUES (660, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 16, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 16:56:54', 0);
INSERT INTO `sys_log` VALUES (661, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 18, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 16:56:55', 0);
INSERT INTO `sys_log` VALUES (662, 'DEPT', '部门列表', '/api/v1/dept', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 16:56:57', 0);
INSERT INTO `sys_log` VALUES (663, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 7, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 17:05:43', 0);
INSERT INTO `sys_log` VALUES (664, 'LOGIN', '登录', '/api/v1/auth/login', '114.213.211.68', '安徽省', '合肥市', 615, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 18:55:52', 0);
INSERT INTO `sys_log` VALUES (665, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 24, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 18:55:53', 0);
INSERT INTO `sys_log` VALUES (666, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 19, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 19:05:40', 0);
INSERT INTO `sys_log` VALUES (667, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 7, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 19:07:49', 0);
INSERT INTO `sys_log` VALUES (668, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 8, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 19:07:51', 0);
INSERT INTO `sys_log` VALUES (669, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 21, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 19:19:41', 0);
INSERT INTO `sys_log` VALUES (670, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 12, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 19:22:37', 0);
INSERT INTO `sys_log` VALUES (671, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 11, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 19:23:12', 0);
INSERT INTO `sys_log` VALUES (672, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 7, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 19:23:47', 0);
INSERT INTO `sys_log` VALUES (673, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 7, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 19:23:51', 0);
INSERT INTO `sys_log` VALUES (674, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 8, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 19:45:05', 0);
INSERT INTO `sys_log` VALUES (675, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 10, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 19:45:14', 0);
INSERT INTO `sys_log` VALUES (676, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 19:46:05', 0);
INSERT INTO `sys_log` VALUES (677, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 14, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 19:46:41', 0);
INSERT INTO `sys_log` VALUES (678, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 19:46:51', 0);
INSERT INTO `sys_log` VALUES (679, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 19:46:54', 0);
INSERT INTO `sys_log` VALUES (680, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 4, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 19:47:40', 0);
INSERT INTO `sys_log` VALUES (681, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 19:47:50', 0);
INSERT INTO `sys_log` VALUES (682, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 19:47:56', 0);
INSERT INTO `sys_log` VALUES (683, 'LOGIN', '登录', '/api/v1/auth/login', '114.213.211.68', '安徽省', '合肥市', 622, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 19:55:48', 0);
INSERT INTO `sys_log` VALUES (684, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 27, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 19:55:48', 0);
INSERT INTO `sys_log` VALUES (685, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 34, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-15 20:03:40', 0);
INSERT INTO `sys_log` VALUES (686, 'LOGIN', '登录', '/api/v1/auth/login', '114.213.211.68', '安徽省', '合肥市', 156, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-16 11:58:07', 0);
INSERT INTO `sys_log` VALUES (687, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 20, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-16 12:00:50', 0);
INSERT INTO `sys_log` VALUES (688, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 8, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-16 12:00:51', 0);
INSERT INTO `sys_log` VALUES (689, 'LOGIN', '登录', '/api/v1/auth/login', '114.213.211.68', '安徽省', '合肥市', 649, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-17 21:58:30', 0);
INSERT INTO `sys_log` VALUES (690, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 21, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-17 21:58:31', 0);
INSERT INTO `sys_log` VALUES (691, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 22, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-17 21:58:36', 0);
INSERT INTO `sys_log` VALUES (692, 'USER', '用户分页列表', '/api/v1/users/page', '114.213.211.68', '安徽省', '合肥市', 19, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-17 22:09:18', 0);
INSERT INTO `sys_log` VALUES (693, 'DEPT', '部门列表', '/api/v1/dept', '114.213.211.68', '安徽省', '合肥市', 12, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-17 22:09:26', 0);
INSERT INTO `sys_log` VALUES (694, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 17, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-17 22:09:28', 0);
INSERT INTO `sys_log` VALUES (695, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 10, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-17 22:11:29', 0);
INSERT INTO `sys_log` VALUES (696, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-17 22:13:13', 0);
INSERT INTO `sys_log` VALUES (697, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 8, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-17 22:13:54', 0);
INSERT INTO `sys_log` VALUES (698, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-17 22:14:28', 0);
INSERT INTO `sys_log` VALUES (699, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-17 22:15:52', 0);
INSERT INTO `sys_log` VALUES (700, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-17 22:16:24', 0);
INSERT INTO `sys_log` VALUES (701, 'MENU', '菜单列表', '/api/v1/menus', '114.213.211.68', '安徽省', '合肥市', 8, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-17 22:16:39', 0);
INSERT INTO `sys_log` VALUES (702, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-17 22:16:42', 0);
INSERT INTO `sys_log` VALUES (703, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 5, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-17 22:16:49', 0);
INSERT INTO `sys_log` VALUES (704, 'ROLE', '角色分页列表', '/api/v1/roles/page', '114.213.211.68', '安徽省', '合肥市', 6, 'MSEdge', '126.0.0.0', 'Windows 10 or Windows Server 2016', 2, '2024-07-17 22:16:51', 0);

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `parent_id` bigint NOT NULL COMMENT '父菜单ID',
  `tree_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '父节点ID路径',
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '菜单名称',
  `type` tinyint NOT NULL COMMENT '菜单类型（1-菜单 2-目录 3-外链 4-按钮）',
  `route_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '路由名称（Vue Router 中用于命名路由）',
  `route_path` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '路由路径（Vue Router 中定义的 URL 路径）',
  `component` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '组件路径（组件页面完整路径，相对于 src/views/，缺省后缀 .vue）',
  `perm` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '【按钮】权限标识',
  `always_show` tinyint NULL DEFAULT NULL COMMENT '【目录】只有一个子路由是否始终显示（1-是 0-否）',
  `keep_alive` tinyint NULL DEFAULT NULL COMMENT '【菜单】是否开启页面缓存（1-是 0-否）',
  `visible` tinyint(1) NOT NULL DEFAULT 1 COMMENT '显示状态（1-显示 0-隐藏）',
  `sort` int NULL DEFAULT 0 COMMENT '排序',
  `icon` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '菜单图标',
  `redirect` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '跳转路径',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `params` json NULL COMMENT '路由参数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 131 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '菜单管理' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, 0, '0', '系统管理', 2, '', '/system', 'Layout', NULL, NULL, NULL, 1, 1, 'system', '/system/user', '2021-08-28 09:12:21', '2024-06-24 23:49:04', NULL);
INSERT INTO `sys_menu` VALUES (2, 1, '0,1', '用户管理', 1, 'User', 'user', 'system/user/index', NULL, NULL, 1, 1, 1, 'user', NULL, '2021-08-28 09:12:21', '2021-08-28 09:12:21', NULL);
INSERT INTO `sys_menu` VALUES (3, 1, '0,1', '角色管理', 1, 'Role', 'role', 'system/role/index', NULL, NULL, 1, 1, 2, 'role', NULL, '2021-08-28 09:12:21', '2021-08-28 09:12:21', NULL);
INSERT INTO `sys_menu` VALUES (4, 1, '0,1', '菜单管理', 1, 'Menu', 'menu', 'system/menu/index', NULL, NULL, 1, 1, 3, 'menu', NULL, '2021-08-28 09:12:21', '2024-07-12 23:33:17', NULL);
INSERT INTO `sys_menu` VALUES (5, 1, '0,1', '部门管理', 1, 'Dept', 'dept', 'system/dept/index', NULL, NULL, 1, 1, 4, 'tree', NULL, '2021-08-28 09:12:21', '2024-07-15 13:44:31', NULL);
INSERT INTO `sys_menu` VALUES (6, 1, '0,1', '字典管理', 1, 'Dict', 'dict', 'system/dict/index', NULL, NULL, 1, 0, 5, 'dict', NULL, '2021-08-28 09:12:21', '2024-07-10 15:52:23', NULL);
INSERT INTO `sys_menu` VALUES (20, 0, '0', '多级菜单', 2, NULL, '/multi-level', 'Layout', NULL, 1, NULL, 0, 9, 'menu', '', '2022-02-16 23:11:00', '2024-07-12 22:18:01', NULL);
INSERT INTO `sys_menu` VALUES (21, 20, '0,20', '菜单一级', 1, NULL, 'multi-level1', 'demo/multi-level/level1', NULL, 1, NULL, 1, 1, '', '', '2022-02-16 23:13:38', '2022-02-16 23:13:38', NULL);
INSERT INTO `sys_menu` VALUES (22, 21, '0,20,21', '菜单二级', 1, NULL, 'multi-level2', 'demo/multi-level/children/level2', NULL, 0, NULL, 1, 1, '', NULL, '2022-02-16 23:14:23', '2022-02-16 23:14:23', NULL);
INSERT INTO `sys_menu` VALUES (23, 22, '0,20,21,22', '菜单三级-1', 1, NULL, 'multi-level3-1', 'demo/multi-level/children/children/level3-1', NULL, 0, 1, 1, 1, '', '', '2022-02-16 23:14:51', '2022-02-16 23:14:51', NULL);
INSERT INTO `sys_menu` VALUES (24, 22, '0,20,21,22', '菜单三级-2', 1, NULL, 'multi-level3-2', 'demo/multi-level/children/children/level3-2', NULL, 0, 1, 1, 2, '', '', '2022-02-16 23:15:08', '2022-02-16 23:15:08', NULL);
INSERT INTO `sys_menu` VALUES (26, 0, '0', '平台文档', 2, NULL, '/doc', 'Layout', NULL, NULL, NULL, 0, 8, 'document', 'https://juejin.cn/post/7228990409909108793', '2022-02-17 22:51:20', '2024-07-10 15:52:46', NULL);
INSERT INTO `sys_menu` VALUES (30, 26, '0,26', '平台文档(外链)', 3, NULL, 'https://juejin.cn/post/7228990409909108793', '', NULL, NULL, NULL, 1, 2, 'link', '', '2022-02-18 00:01:40', '2022-02-18 00:01:40', NULL);
INSERT INTO `sys_menu` VALUES (31, 2, '0,1,2', '用户新增', 4, NULL, '', NULL, 'sys:user:add', NULL, NULL, 1, 1, '', '', '2022-10-23 11:04:08', '2022-10-23 11:04:11', NULL);
INSERT INTO `sys_menu` VALUES (32, 2, '0,1,2', '用户编辑', 4, NULL, '', NULL, 'sys:user:edit', NULL, NULL, 1, 2, '', '', '2022-10-23 11:04:08', '2022-10-23 11:04:11', NULL);
INSERT INTO `sys_menu` VALUES (33, 2, '0,1,2', '用户删除', 4, NULL, '', NULL, 'sys:user:delete', NULL, NULL, 1, 3, '', '', '2022-10-23 11:04:08', '2022-10-23 11:04:11', NULL);
INSERT INTO `sys_menu` VALUES (36, 0, '0', '组件封装', 2, NULL, '/component', 'Layout', NULL, NULL, NULL, 0, 10, 'menu', '', '2022-10-31 09:18:44', '2024-07-10 15:52:55', NULL);
INSERT INTO `sys_menu` VALUES (37, 36, '0,36', '富文本编辑器', 1, NULL, 'wang-editor', 'demo/wang-editor', NULL, NULL, 1, 1, 2, '', '', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (38, 36, '0,36', '图片上传', 1, NULL, 'upload', 'demo/upload', NULL, NULL, 1, 1, 3, '', '', '2022-11-20 23:16:30', '2022-11-20 23:16:32', NULL);
INSERT INTO `sys_menu` VALUES (39, 36, '0,36', '图标选择器', 1, NULL, 'icon-selector', 'demo/icon-selector', NULL, NULL, 1, 1, 4, '', '', '2022-11-20 23:16:30', '2022-11-20 23:16:32', NULL);
INSERT INTO `sys_menu` VALUES (40, 0, '0', '接口文档', 2, NULL, '/api', 'Layout', NULL, 1, NULL, 0, 7, 'api', '', '2022-02-17 22:51:20', '2024-07-10 15:52:37', NULL);
INSERT INTO `sys_menu` VALUES (41, 40, '0,40', 'Apifox', 1, NULL, 'apifox', 'demo/api/apifox', NULL, NULL, 1, 1, 1, 'api', '', '2022-02-17 22:51:20', '2022-02-17 22:51:20', NULL);
INSERT INTO `sys_menu` VALUES (70, 3, '0,1,3', '角色新增', 4, NULL, '', NULL, 'sys:role:add', NULL, NULL, 1, 1, '', NULL, '2023-05-20 23:39:09', '2023-05-20 23:39:09', NULL);
INSERT INTO `sys_menu` VALUES (71, 3, '0,1,3', '角色编辑', 4, NULL, '', NULL, 'sys:role:edit', NULL, NULL, 1, 2, '', NULL, '2023-05-20 23:40:31', '2023-05-20 23:40:31', NULL);
INSERT INTO `sys_menu` VALUES (72, 3, '0,1,3', '角色删除', 4, NULL, '', NULL, 'sys:role:delete', NULL, NULL, 1, 3, '', NULL, '2023-05-20 23:41:08', '2023-05-20 23:41:08', NULL);
INSERT INTO `sys_menu` VALUES (73, 4, '0,1,4', '菜单新增', 4, NULL, '', NULL, 'sys:menu:add', NULL, NULL, 1, 1, '', NULL, '2023-05-20 23:41:35', '2023-05-20 23:41:35', NULL);
INSERT INTO `sys_menu` VALUES (74, 4, '0,1,4', '菜单编辑', 4, NULL, '', NULL, 'sys:menu:edit', NULL, NULL, 1, 3, '', NULL, '2023-05-20 23:41:58', '2023-05-20 23:41:58', NULL);
INSERT INTO `sys_menu` VALUES (75, 4, '0,1,4', '菜单删除', 4, NULL, '', NULL, 'sys:menu:delete', NULL, NULL, 1, 3, '', NULL, '2023-05-20 23:44:18', '2023-05-20 23:44:18', NULL);
INSERT INTO `sys_menu` VALUES (76, 5, '0,1,5', '部门新增', 4, NULL, '', NULL, 'sys:dept:add', NULL, NULL, 1, 1, '', NULL, '2023-05-20 23:45:00', '2023-05-20 23:45:00', NULL);
INSERT INTO `sys_menu` VALUES (77, 5, '0,1,5', '部门编辑', 4, NULL, '', NULL, 'sys:dept:edit', NULL, NULL, 1, 2, '', NULL, '2023-05-20 23:46:16', '2023-05-20 23:46:16', NULL);
INSERT INTO `sys_menu` VALUES (78, 5, '0,1,5', '部门删除', 4, NULL, '', NULL, 'sys:dept:delete', NULL, NULL, 1, 3, '', NULL, '2023-05-20 23:46:36', '2023-05-20 23:46:36', NULL);
INSERT INTO `sys_menu` VALUES (79, 6, '0,1,6', '字典类型新增', 4, NULL, '', NULL, 'sys:dict_type:add', NULL, NULL, 1, 1, '', NULL, '2023-05-21 00:16:06', '2023-05-21 00:16:06', NULL);
INSERT INTO `sys_menu` VALUES (81, 6, '0,1,6', '字典类型编辑', 4, NULL, '', NULL, 'sys:dict_type:edit', NULL, NULL, 1, 2, '', NULL, '2023-05-21 00:27:37', '2023-05-21 00:27:37', NULL);
INSERT INTO `sys_menu` VALUES (84, 6, '0,1,6', '字典类型删除', 4, NULL, '', NULL, 'sys:dict_type:delete', NULL, NULL, 1, 3, '', NULL, '2023-05-21 00:29:39', '2023-05-21 00:29:39', NULL);
INSERT INTO `sys_menu` VALUES (85, 6, '0,1,6', '字典数据新增', 4, NULL, '', NULL, 'sys:dict:add', NULL, NULL, 1, 4, '', NULL, '2023-05-21 00:46:56', '2023-05-21 00:47:06', NULL);
INSERT INTO `sys_menu` VALUES (86, 6, '0,1,6', '字典数据编辑', 4, NULL, '', NULL, 'sys:dict:edit', NULL, NULL, 1, 5, '', NULL, '2023-05-21 00:47:36', '2023-05-21 00:47:36', NULL);
INSERT INTO `sys_menu` VALUES (87, 6, '0,1,6', '字典数据删除', 4, NULL, '', NULL, 'sys:dict:delete', NULL, NULL, 1, 6, '', NULL, '2023-05-21 00:48:10', '2023-05-21 00:48:20', NULL);
INSERT INTO `sys_menu` VALUES (88, 2, '0,1,2', '重置密码', 4, NULL, '', NULL, 'sys:user:password:reset', NULL, NULL, 1, 4, '', NULL, '2023-05-21 00:49:18', '2024-04-28 00:38:22', NULL);
INSERT INTO `sys_menu` VALUES (89, 0, '0', '功能演示', 2, NULL, '/function', 'Layout', NULL, NULL, NULL, 0, 12, 'menu', '', '2022-10-31 09:18:44', '2024-07-10 15:53:06', NULL);
INSERT INTO `sys_menu` VALUES (90, 89, '0,89', 'Websocket', 1, NULL, '/function/websocket', 'demo/websocket', NULL, NULL, 1, 1, 3, '', '', '2022-11-20 23:16:30', '2022-11-20 23:16:32', NULL);
INSERT INTO `sys_menu` VALUES (91, 89, '0,89', '敬请期待...', 2, NULL, 'other/:id', 'demo/other', NULL, NULL, NULL, 1, 4, '', '', '2022-11-20 23:16:30', '2022-11-20 23:16:32', NULL);
INSERT INTO `sys_menu` VALUES (95, 36, '0,36', '字典组件', 1, NULL, 'dict-demo', 'demo/dict', NULL, NULL, 1, 1, 4, '', '', '2022-11-20 23:16:30', '2022-11-20 23:16:32', NULL);
INSERT INTO `sys_menu` VALUES (97, 89, '0,89', 'Icons', 1, NULL, 'icon-demo', 'demo/icons', NULL, NULL, 1, 1, 2, 'el-icon-Notification', '', '2022-11-20 23:16:30', '2022-11-20 23:16:32', NULL);
INSERT INTO `sys_menu` VALUES (102, 26, '0,26', '平台文档(内嵌)', 3, NULL, 'internal-doc', 'demo/internal-doc', NULL, NULL, NULL, 1, 1, 'document', '', '2022-02-18 00:01:40', '2022-02-18 00:01:40', NULL);
INSERT INTO `sys_menu` VALUES (105, 2, '0,1,2', '用户查询', 4, NULL, '', NULL, 'sys:user:query', 0, 0, 1, 0, '', NULL, '2024-04-28 00:37:34', '2024-04-28 00:37:34', NULL);
INSERT INTO `sys_menu` VALUES (106, 2, '0,1,2', '用户导入', 4, NULL, '', NULL, 'sys:user:import', NULL, NULL, 1, 5, '', NULL, '2024-04-28 00:39:15', '2024-04-28 00:39:15', NULL);
INSERT INTO `sys_menu` VALUES (107, 2, '0,1,2', '用户导出', 4, NULL, '', NULL, 'sys:user:export', NULL, NULL, 1, 6, '', NULL, '2024-04-28 00:39:43', '2024-04-28 00:39:43', NULL);
INSERT INTO `sys_menu` VALUES (108, 36, '0,36', '增删改查', 1, NULL, 'curd', 'demo/curd/index', NULL, NULL, 1, 1, 0, '', '', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (109, 36, '0,36', '列表选择器', 1, NULL, 'table-select', 'demo/table-select/index', NULL, NULL, 1, 1, 1, '', '', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (110, 0, '0', '路由参数', 2, NULL, '/route-param', 'Layout', NULL, 1, 1, 0, 11, 'el-icon-ElementPlus', NULL, '2024-05-26 21:05:09', '2024-07-10 15:53:02', NULL);
INSERT INTO `sys_menu` VALUES (111, 110, '0,110', '参数(type=1)', 1, NULL, 'route-param-type1', 'demo/route-param', NULL, 0, 1, 1, 1, 'el-icon-Star', NULL, '2024-05-26 21:59:24', '2024-05-26 21:59:37', '{\"type\": \"1\"}');
INSERT INTO `sys_menu` VALUES (112, 110, '0,110', '参数(type=2)', 1, NULL, 'route-param-type2', 'demo/route-param', NULL, 0, 1, 1, 2, 'el-icon-StarFilled', NULL, '2024-05-26 21:46:55', '2024-05-26 21:59:45', '{\"type\": \"2\"}');
INSERT INTO `sys_menu` VALUES (117, 1, '0,1', '系统日志', 1, 'Log', 'log', 'system/log/index', NULL, 0, 1, 0, 6, 'document', NULL, '2024-06-28 07:43:16', '2024-07-10 15:52:30', NULL);
INSERT INTO `sys_menu` VALUES (121, 0, '0', '行人识别', 2, NULL, '/recognition', 'Layout', NULL, 1, 1, 1, 1, 'monitor', '', '2024-07-12 22:37:37', '2024-07-12 23:16:45', NULL);
INSERT INTO `sys_menu` VALUES (122, 121, '0,121', '实时监控', 1, 'Monitor', 'monitor', 'recognition/monitor/index', NULL, 0, 1, 1, 1, 'eye-open', NULL, '2024-07-12 22:39:30', '2024-07-12 23:01:04', NULL);
INSERT INTO `sys_menu` VALUES (123, 1, '0,1', '设备管理', 1, 'Camera', 'camera', 'system/camera/index', NULL, 0, 1, 1, 3, 'client', NULL, '2024-07-15 13:53:26', '2024-07-15 14:17:38', NULL);
INSERT INTO `sys_menu` VALUES (124, 123, '0,1,123', '设备查询', 4, NULL, '', NULL, 'sys:camera:query', 0, 1, 1, 0, '', NULL, '2024-07-15 13:59:08', '2024-07-15 14:16:51', NULL);
INSERT INTO `sys_menu` VALUES (125, 123, '0,1,123', '设备新增', 4, NULL, '', NULL, 'sys:camera:add', 0, 1, 1, 1, '', NULL, '2024-07-15 13:59:55', '2024-07-15 13:59:55', NULL);
INSERT INTO `sys_menu` VALUES (126, 123, '0,1,123', '设备编辑', 4, NULL, '', NULL, 'sys:camera:edit', 0, 1, 1, 2, '', NULL, '2024-07-15 14:01:32', '2024-07-15 14:17:17', NULL);
INSERT INTO `sys_menu` VALUES (128, 123, '0,1,123', '实时监控', 4, NULL, '', NULL, 'sys:camera:video', 0, 1, 1, 1, '', NULL, '2024-07-15 14:11:40', '2024-07-15 14:11:40', NULL);
INSERT INTO `sys_menu` VALUES (131, 123, '0,1,123', '设备删除', 4, NULL, '', NULL, 'sys:camera:delete', 0, 1, 1, 1, '', NULL, '2024-07-15 19:46:05', '2024-07-15 19:46:05', NULL);
INSERT INTO `sys_menu` VALUES (132, 1, '0,1', '模型管理', 1, 'Model', 'model', 'system/model/index', NULL, 0, 1, 1, 1, 'edit', NULL, '2024-07-17 22:11:28', '2024-07-17 22:11:28', NULL);
INSERT INTO `sys_menu` VALUES (133, 132, '0,1,132', '模型新增', 4, NULL, '', NULL, 'sys:model:add', 0, 1, 1, 1, '', NULL, '2024-07-17 22:13:13', '2024-07-17 22:15:52', NULL);
INSERT INTO `sys_menu` VALUES (134, 132, '0,1,132', '模型删除', 4, NULL, '', NULL, 'sys:model:delete', 0, 1, 1, 1, '', NULL, '2024-07-17 22:13:54', '2024-07-17 22:13:54', NULL);
INSERT INTO `sys_menu` VALUES (135, 132, '0,1,132', '模型查询', 4, NULL, '', NULL, 'sys:model:query', 0, 1, 1, 1, '', NULL, '2024-07-17 22:14:27', '2024-07-17 22:14:27', NULL);
INSERT INTO `sys_menu` VALUES (136, 132, '0,1,132', '模型编辑', 4, NULL, '', NULL, 'sys:model:edit', 0, 1, 1, 1, '', NULL, '2024-07-17 22:16:24', '2024-07-17 22:16:24', NULL);

-- ----------------------------
-- Table structure for sys_message
-- ----------------------------
DROP TABLE IF EXISTS `sys_message`;
CREATE TABLE `sys_message`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建人ID',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '修改人ID',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `is_deleted` tinyint NOT NULL DEFAULT 0 COMMENT '逻辑删除标识(1-已删除 0-未删除)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统消息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_message
-- ----------------------------

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '角色名称',
  `code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色编码',
  `sort` int NULL DEFAULT NULL COMMENT '显示顺序',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '角色状态(1-正常 0-停用)',
  `data_scope` tinyint NULL DEFAULT NULL COMMENT '数据权限(0-所有数据 1-部门及子部门数据 2-本部门数据3-本人数据)',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建人 ID',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新人ID',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '逻辑删除标识(0-未删除 1-已删除)',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_name`(`name`) USING BTREE COMMENT '角色名称唯一索引',
  UNIQUE INDEX `uk_code`(`code`) USING BTREE COMMENT '角色编码唯一索引'
) ENGINE = InnoDB AUTO_INCREMENT = 128 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'ROOT', 1, 1, 0, NULL, '2021-05-21 14:56:51', NULL, '2018-12-23 16:00:00', 0);
INSERT INTO `sys_role` VALUES (2, '系统管理员', 'ADMIN', 2, 1, 1, NULL, '2021-03-25 12:39:54', NULL, NULL, 0);
INSERT INTO `sys_role` VALUES (3, '访问游客', 'GUEST', 3, 1, 2, NULL, '2021-05-26 15:49:05', NULL, '2019-05-05 16:00:00', 0);
INSERT INTO `sys_role` VALUES (4, '系统管理员1', 'ADMIN1', 4, 1, 1, NULL, '2021-03-25 12:39:54', NULL, NULL, 0);
INSERT INTO `sys_role` VALUES (5, '系统管理员2', 'ADMIN2', 5, 1, 1, NULL, '2021-03-25 12:39:54', NULL, NULL, 0);
INSERT INTO `sys_role` VALUES (6, '系统管理员3', 'ADMIN3', 6, 1, 1, NULL, '2021-03-25 12:39:54', NULL, '2024-07-05 16:11:47', 1);
INSERT INTO `sys_role` VALUES (7, '系统管理员4', 'ADMIN4', 7, 1, 1, NULL, '2021-03-25 12:39:54', NULL, '2024-07-05 16:11:44', 1);
INSERT INTO `sys_role` VALUES (8, '系统管理员5', 'ADMIN5', 8, 1, 1, NULL, '2021-03-25 12:39:54', NULL, '2024-07-05 16:11:42', 1);
INSERT INTO `sys_role` VALUES (9, '系统管理员6', 'ADMIN6', 9, 1, 1, NULL, '2021-03-25 12:39:54', NULL, '2024-07-05 16:11:39', 1);
INSERT INTO `sys_role` VALUES (10, '系统管理员7', 'ADMIN7', 10, 1, 1, NULL, '2021-03-25 12:39:54', NULL, '2024-07-05 16:11:36', 1);
INSERT INTO `sys_role` VALUES (11, '系统管理员8', 'ADMIN8', 11, 1, 1, NULL, '2021-03-25 12:39:54', NULL, '2024-07-05 16:11:32', 1);
INSERT INTO `sys_role` VALUES (12, '系统管理员9', 'ADMIN9', 12, 1, 1, NULL, '2021-03-25 12:39:54', NULL, '2024-07-05 16:11:16', 1);
INSERT INTO `sys_role` VALUES (128, '保安用户', 'BAOAN', 1, 1, 1, NULL, '2024-07-05 16:14:05', NULL, '2024-07-05 16:14:05', 0);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  UNIQUE INDEX `uk_roleid_menuid`(`role_id`, `menu_id`) USING BTREE COMMENT '角色菜单唯一索引'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (2, 1);
INSERT INTO `sys_role_menu` VALUES (2, 2);
INSERT INTO `sys_role_menu` VALUES (2, 3);
INSERT INTO `sys_role_menu` VALUES (2, 4);
INSERT INTO `sys_role_menu` VALUES (2, 5);
INSERT INTO `sys_role_menu` VALUES (2, 6);
INSERT INTO `sys_role_menu` VALUES (2, 20);
INSERT INTO `sys_role_menu` VALUES (2, 21);
INSERT INTO `sys_role_menu` VALUES (2, 22);
INSERT INTO `sys_role_menu` VALUES (2, 23);
INSERT INTO `sys_role_menu` VALUES (2, 24);
INSERT INTO `sys_role_menu` VALUES (2, 26);
INSERT INTO `sys_role_menu` VALUES (2, 30);
INSERT INTO `sys_role_menu` VALUES (2, 31);
INSERT INTO `sys_role_menu` VALUES (2, 32);
INSERT INTO `sys_role_menu` VALUES (2, 33);
INSERT INTO `sys_role_menu` VALUES (2, 36);
INSERT INTO `sys_role_menu` VALUES (2, 37);
INSERT INTO `sys_role_menu` VALUES (2, 38);
INSERT INTO `sys_role_menu` VALUES (2, 39);
INSERT INTO `sys_role_menu` VALUES (2, 40);
INSERT INTO `sys_role_menu` VALUES (2, 41);
INSERT INTO `sys_role_menu` VALUES (2, 70);
INSERT INTO `sys_role_menu` VALUES (2, 71);
INSERT INTO `sys_role_menu` VALUES (2, 72);
INSERT INTO `sys_role_menu` VALUES (2, 73);
INSERT INTO `sys_role_menu` VALUES (2, 74);
INSERT INTO `sys_role_menu` VALUES (2, 75);
INSERT INTO `sys_role_menu` VALUES (2, 76);
INSERT INTO `sys_role_menu` VALUES (2, 77);
INSERT INTO `sys_role_menu` VALUES (2, 78);
INSERT INTO `sys_role_menu` VALUES (2, 79);
INSERT INTO `sys_role_menu` VALUES (2, 81);
INSERT INTO `sys_role_menu` VALUES (2, 84);
INSERT INTO `sys_role_menu` VALUES (2, 85);
INSERT INTO `sys_role_menu` VALUES (2, 86);
INSERT INTO `sys_role_menu` VALUES (2, 87);
INSERT INTO `sys_role_menu` VALUES (2, 88);
INSERT INTO `sys_role_menu` VALUES (2, 89);
INSERT INTO `sys_role_menu` VALUES (2, 90);
INSERT INTO `sys_role_menu` VALUES (2, 91);
INSERT INTO `sys_role_menu` VALUES (2, 95);
INSERT INTO `sys_role_menu` VALUES (2, 97);
INSERT INTO `sys_role_menu` VALUES (2, 102);
INSERT INTO `sys_role_menu` VALUES (2, 105);
INSERT INTO `sys_role_menu` VALUES (2, 106);
INSERT INTO `sys_role_menu` VALUES (2, 107);
INSERT INTO `sys_role_menu` VALUES (2, 108);
INSERT INTO `sys_role_menu` VALUES (2, 109);
INSERT INTO `sys_role_menu` VALUES (2, 110);
INSERT INTO `sys_role_menu` VALUES (2, 111);
INSERT INTO `sys_role_menu` VALUES (2, 112);
INSERT INTO `sys_role_menu` VALUES (2, 117);
INSERT INTO `sys_role_menu` VALUES (2, 121);
INSERT INTO `sys_role_menu` VALUES (2, 122);
INSERT INTO `sys_role_menu` VALUES (2, 123);
INSERT INTO `sys_role_menu` VALUES (2, 124);
INSERT INTO `sys_role_menu` VALUES (2, 125);
INSERT INTO `sys_role_menu` VALUES (2, 126);
INSERT INTO `sys_role_menu` VALUES (2, 128);
INSERT INTO `sys_role_menu` VALUES (2, 131);
INSERT INTO `sys_role_menu` VALUES (2, 132);
INSERT INTO `sys_role_menu` VALUES (2, 133);
INSERT INTO `sys_role_menu` VALUES (2, 134);
INSERT INTO `sys_role_menu` VALUES (2, 135);
INSERT INTO `sys_role_menu` VALUES (2, 136);
INSERT INTO `sys_role_menu` VALUES (12, 36);
INSERT INTO `sys_role_menu` VALUES (12, 37);
INSERT INTO `sys_role_menu` VALUES (12, 38);
INSERT INTO `sys_role_menu` VALUES (12, 39);
INSERT INTO `sys_role_menu` VALUES (12, 95);
INSERT INTO `sys_role_menu` VALUES (12, 108);
INSERT INTO `sys_role_menu` VALUES (12, 109);
INSERT INTO `sys_role_menu` VALUES (128, 121);
INSERT INTO `sys_role_menu` VALUES (128, 122);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `nickname` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '昵称',
  `gender` tinyint(1) NULL DEFAULT 1 COMMENT '性别((1-男 2-女 0-保密)',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '密码',
  `dept_id` int NULL DEFAULT NULL COMMENT '部门ID',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户头像',
  `mobile` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系方式',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '状态((1-正常 0-禁用)',
  `email` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户邮箱',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建人ID',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '修改人ID',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '逻辑删除标识(0-未删除 1-已删除)',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `login_name`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 304 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (2, 'admin', '系统管理员', 2, '$2a$10$xVWsNOhHrCxh5UbpCE7/HuJ.PAOKcYAqRxD2CO2nVnJS.IAXkr5aq', 1, 'https://oss.youlai.tech/youlai-boot/2023/05/16/811270ef31f548af9cffc026dfc3777b.gif', '17621210366', 1, '', '2024-07-03 13:41:22', NULL, '2024-07-03 16:01:33', NULL, 0);
INSERT INTO `sys_user` VALUES (3, '王静', '测试小用户', 1, '$2a$10$xVWsNOhHrCxh5UbpCE7/HuJ.PAOKcYAqRxD2CO2nVnJS.IAXkr5aq', 3, 'https://oss.youlai.tech/youlai-boot/2023/05/16/811270ef31f548af9cffc026dfc3777b.gif', '17621210366', 1, 'youlaitech@163.com', '2024-07-03 13:42:29', NULL, '2021-06-05 01:31:29', NULL, 0);
INSERT INTO `sys_user` VALUES (290, '兰翔', '小兰', 1, '$2a$10$LvMSctan0FYLuTcdEGNvX.XwqxlTXeBTnOCgO2nR0S3EGlexDUWzu', 2, 'https://oss.youlai.tech/youlai-boot/2023/05/16/811270ef31f548af9cffc026dfc3777b.gif', '17892345873', 1, '2339456286@qq.com', '2024-07-05 11:31:08', NULL, '2024-07-09 14:21:36', NULL, 0);
INSERT INTO `sys_user` VALUES (292, 'ses', 'ses', 1, '$2a$10$LvMSctan0FYLuTcdEGNvX.XwqxlTXeBTnOCgO2nR0S3EGlexDUWzu', 3, '', NULL, 1, NULL, NULL, NULL, '2024-07-05 14:52:32', NULL, 1);
INSERT INTO `sys_user` VALUES (293, '涂玉华', '小涂', 1, '$2a$10$GfzpyyIr1xr/ndCH0MG5vu6eHtexVKh1H/rDC33CvaWptvRgCf0iy', 3, '', '15000000111', 1, '23394@qq.com', '2024-07-05 14:57:35', NULL, '2024-07-05 14:57:35', NULL, 0);
INSERT INTO `sys_user` VALUES (294, '朱子建', '小朱', 1, '$2a$10$9e0WDA/o1OTMfMAQ9MEltOD4HaTXTzG5lrQrgFO/s2CPvGSVoaO5O', 2, '', '15000000111', 1, '23394@qq.com', '2024-07-05 14:57:35', NULL, '2024-07-05 14:57:35', NULL, 0);
INSERT INTO `sys_user` VALUES (295, '保安1号', '老王', 1, '$2a$10$gFFYbEDTBw8zZeiKhjMtwuT9YTIEbtYJmHvwYVtjD8i3OhodfPOYe', 10, '', '15000000111', 1, '23394@qq.com', '2024-07-05 16:18:38', NULL, '2024-07-09 14:27:43', NULL, 0);
INSERT INTO `sys_user` VALUES (297, '裴跃', '小裴', 2, '$2a$10$UOAR/FaNhJ2iQOH1Xs7HtOzD5wfydaEWS41q0oDOteyWgDqf6ziNK', 6, '', '15090971111', 1, '2339456286@qq.com', '2024-07-05 16:37:54', NULL, '2024-07-05 16:38:37', NULL, 0);
INSERT INTO `sys_user` VALUES (298, '彭景', '小彭', 2, '$2a$10$KS/Cmu8pO9bxlT2yHQE2PuUMv/h.ijqw5zBelJq5hTfouWn3c4W5m', 6, '', '15092748929', 1, '2339456286@qq.com', '2024-07-05 16:48:51', NULL, '2024-07-05 16:48:51', NULL, 0);
INSERT INTO `sys_user` VALUES (302, '保安2号', '老李', 1, '$2a$10$fLv1BTI.Vw.kpTeNGkc/p.pOH0AArWLp4gWSryvACUgIy/6CHsHtm', 10, '', '15000000112', 1, '23394@qq.com', '2024-07-06 10:08:29', NULL, '2024-07-09 14:27:53', NULL, 0);
INSERT INTO `sys_user` VALUES (303, '刘一敏', '刘经理', 1, '$2a$10$9qTXZ.3nnLX.b0SUBYQlJumwm7W6dEuAY9sMZ0kOQozH6gLkpk4l.', 9, '', '15000000113', 1, '23394@qq.com', '2024-07-06 10:08:29', NULL, '2024-07-06 10:08:29', NULL, 0);
INSERT INTO `sys_user` VALUES (304, '李坤袁', '李经理', 1, '$2a$10$edIJtUpwvJr6VwLu2q.QR.rPcWKefitXZE5bw1HHTISbP4HfxSlGe', 9, '', '15000000114', 1, '23394@qq.com', '2024-07-06 10:08:29', NULL, '2024-07-06 10:08:29', NULL, 0);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE,
  UNIQUE INDEX `uk_userid_roleid`(`user_id`, `role_id`) USING BTREE COMMENT '用户角色唯一索引'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户和角色关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (2, 2);
INSERT INTO `sys_user_role` VALUES (3, 3);
INSERT INTO `sys_user_role` VALUES (290, 2);
INSERT INTO `sys_user_role` VALUES (295, 128);
INSERT INTO `sys_user_role` VALUES (297, 2);
INSERT INTO `sys_user_role` VALUES (298, 2);
INSERT INTO `sys_user_role` VALUES (302, 128);

SET FOREIGN_KEY_CHECKS = 1;
