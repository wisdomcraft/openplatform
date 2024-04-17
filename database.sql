/*
 Navicat Premium Data Transfer

 Source Server         : 8.141.72.197_属意web_开放平台_docker
 Source Server Type    : MySQL
 Source Server Version : 100603
 Source Host           : localhost:3306
 Source Schema         : emotion

 Target Server Type    : MySQL
 Target Server Version : 100603
 File Encoding         : 65001

 Date: 25/10/2021 23:32:48
*/


create user 'emotion'@'%' identified by '00bee1027c2b11ebbd5600163e16e4df';
grant all on emotion.* to 'emotion'@'%';
flush privileges;


create database `emotion`;
use `emotion`;


SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for emotion_coefficient
-- ----------------------------
DROP TABLE IF EXISTS `emotion_coefficient`;
CREATE TABLE `emotion_coefficient`  (
  `coefficient_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `coefficient_no` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `coefficient_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `coefficient1` double NOT NULL DEFAULT 0,
  `coefficient2` double NOT NULL DEFAULT 0,
  `coefficient3` double NOT NULL DEFAULT 0,
  `coefficient4` double NOT NULL DEFAULT 0,
  `coefficient5` double NOT NULL DEFAULT 0,
  `coefficient6` double NOT NULL DEFAULT 0,
  `coefficient7` double NOT NULL DEFAULT 0,
  `coefficient8` double NOT NULL DEFAULT 0,
  `coefficient9` double NOT NULL DEFAULT 0,
  `coefficient10` double NOT NULL DEFAULT 0,
  `status` int(10) UNSIGNED NOT NULL DEFAULT 1,
  PRIMARY KEY (`coefficient_id`) USING BTREE,
  UNIQUE INDEX `coefficient_no`(`coefficient_no`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

INSERT INTO `emotion_coefficient` VALUES (1, 'P7', '攻击性', 4.83583, 4.94541, 4.72049, 5.2428, 5.11197, 4.67601, 4.64819, 5.05514, 5.90134, 4.33339, 1);
INSERT INTO `emotion_coefficient` VALUES (2, 'P6', '压力', 3.46341, 3.73655, 3.74799, 3.63359, 3.21305, 3.44886, 3.69949, 3.96145, 3.65757, 3.97333, 1);
INSERT INTO `emotion_coefficient` VALUES (3, 'F5X', '焦虑', 1.28386, 1.37843, 1.48383, 1.30581, 1.08253, 2.37828, 1.40006, 1.47811, 1.4652, 1.61499, 1);
INSERT INTO `emotion_coefficient` VALUES (4, 'P16', '平衡', 1.56219, 1.59449, 1.59062, 1.48195, 1.37135, 1.15068, 1.28886, 1.50612, 1.2965, 1.28067, 1);
INSERT INTO `emotion_coefficient` VALUES (5, 'P17', '魅力', 2.44942, 2.35183, 2.28071, 2.3795, 2.39345, 2.38876, 2.404, 2.15252, 2.25594, 1.90804, 1);
INSERT INTO `emotion_coefficient` VALUES (6, 'P8', '活力', -1.22029, -1.58434, -1.93519, -1.26316, -0.58568, -1.28082, -1.8498, -1.78331, -1.73859, -1.83876, 1);
INSERT INTO `emotion_coefficient` VALUES (7, 'concentrate', '集中力', 0.75484, 0.72914, 0.80164, 0.70327, 0.71766, 0.7929, 0.69657, 0.68639, 0.70676, 0.70978, 1);
INSERT INTO `emotion_coefficient` VALUES (8, 'constant', '常量', -311.81368, -312.45296, -302.88388, -318.44382, -309.29522, -318.08924, -280.3456, -304.49337, -324.97625, -260.65123, 1);


-- ----------------------------
-- Table structure for emotion_coord
-- ----------------------------
DROP TABLE IF EXISTS `emotion_coord`;
CREATE TABLE `emotion_coord`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `x1` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `y1` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `x2` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `y2` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `x3` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `y3` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `x4` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `y4` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 152 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of emotion_coord
-- ----------------------------
INSERT INTO `emotion_coord` VALUES (1, '-10.0', '0.0', '0.0', '1.2', '0.00', '0.0', '0', '0.0 ');
INSERT INTO `emotion_coord` VALUES (2, '-9.9', '0.0', '1.0', '1.4', '0.05', '0.0', '1', '0.0 ');
INSERT INTO `emotion_coord` VALUES (3, '-9.8', '0.0', '2.0', '1.5', '0.10', '0.0', '2', '0.0 ');
INSERT INTO `emotion_coord` VALUES (4, '-9.7', '0.0', '3.0', '1.7', '0.15', '0.0', '3', '0.0 ');
INSERT INTO `emotion_coord` VALUES (5, '-9.6', '0.0', '4.0', '1.9', '0.20', '0.0', '4', '0.0 ');
INSERT INTO `emotion_coord` VALUES (6, '-9.5', '0.0', '5.0', '2.1', '0.25', '0.0', '5', '0.0 ');
INSERT INTO `emotion_coord` VALUES (7, '-9.4', '0.0', '6.0', '2.4', '0.30', '0.1', '6', '0.0 ');
INSERT INTO `emotion_coord` VALUES (8, '-9.3', '0.0', '7.0', '2.6', '0.35', '0.1', '7', '0.0 ');
INSERT INTO `emotion_coord` VALUES (9, '-9.2', '0.0', '8.0', '2.9', '0.40', '0.2', '8', '0.0 ');
INSERT INTO `emotion_coord` VALUES (10, '-9.1', '0.0', '9.0', '3.2', '0.45', '0.3', '9', '0.0 ');
INSERT INTO `emotion_coord` VALUES (11, '-9.0', '0.0', '10.0', '3.6', '0.50', '0.4', '10', '0.0 ');
INSERT INTO `emotion_coord` VALUES (12, '-8.9', '0.0', '11.0', '3.9', '0.55', '0.6', '11', '0.0 ');
INSERT INTO `emotion_coord` VALUES (13, '-8.8', '0.0', '12.0', '4.3', '0.60', '0.9', '12', '0.0 ');
INSERT INTO `emotion_coord` VALUES (14, '-8.7', '0.0', '13.0', '4.8', '0.65', '1.3', '13', '0.0 ');
INSERT INTO `emotion_coord` VALUES (15, '-8.6', '0.0', '14.0', '5.2', '0.70', '1.8', '14', '0.0 ');
INSERT INTO `emotion_coord` VALUES (16, '-8.5', '0.0', '15.0', '5.7', '0.75', '2.6', '15', '0.0 ');
INSERT INTO `emotion_coord` VALUES (17, '-8.4', '0.0', '16.0', '6.3', '0.80', '3.5', '16', '0.0 ');
INSERT INTO `emotion_coord` VALUES (18, '-8.3', '0.0', '17.0', '6.9', '0.85', '4.7', '17', '0.1 ');
INSERT INTO `emotion_coord` VALUES (19, '-8.2', '0.0', '18.0', '7.5', '0.90', '6.2', '18', '0.1 ');
INSERT INTO `emotion_coord` VALUES (20, '-8.1', '0.0', '19.0', '8.1', '0.95', '8.1', '19', '0.3 ');
INSERT INTO `emotion_coord` VALUES (21, '-8.0', '0.0', '20.0', '8.8', '1.00', '10.3', '20', '0.6 ');
INSERT INTO `emotion_coord` VALUES (22, '-7.9', '0.0', '21.0', '9.6', '1.05', '13.0', '21', '1.2 ');
INSERT INTO `emotion_coord` VALUES (23, '-7.8', '0.0', '22.0', '10.4', '1.10', '16.1', '22', '2.3 ');
INSERT INTO `emotion_coord` VALUES (24, '-7.7', '0.0', '23.0', '11.2', '1.15', '19.7', '23', '4.0 ');
INSERT INTO `emotion_coord` VALUES (25, '-7.6', '0.0', '24.0', '12.1', '1.20', '23.8', '24', '6.7 ');
INSERT INTO `emotion_coord` VALUES (26, '-7.5', '0.0', '25.0', '13.0', '1.25', '28.2', '25', '10.6');
INSERT INTO `emotion_coord` VALUES (27, '-7.4', '0.0', '26.0', '14.0', '1.30', '33.0', '26', '15.9');
INSERT INTO `emotion_coord` VALUES (28, '-7.3', '0.0', '27.0', '15.0', '1.35', '38.1', '27', '22.7 ');
INSERT INTO `emotion_coord` VALUES (29, '-7.2', '0.0', '28.0', '16.1', '1.40', '43.5', '28', '30.9 ');
INSERT INTO `emotion_coord` VALUES (30, '-7.1', '0.0', '29.0', '17.2', '1.45', '48.9', '29', '40.1 ');
INSERT INTO `emotion_coord` VALUES (31, '-7.0', '0.1', '30.0', '18.4', '1.50', '54.4', '30', '50.0 ');
INSERT INTO `emotion_coord` VALUES (32, '-6.9', '0.1', '31.0', '19.6', '1.55', '59.8', '31', '59.9 ');
INSERT INTO `emotion_coord` VALUES (33, '-6.8', '0.1', '32.0', '20.9', '1.60', '65.0', '32', '69.1 ');
INSERT INTO `emotion_coord` VALUES (34, '-6.7', '0.1', '33.0', '22.2', '1.65', '69.9', '33', '77.3 ');
INSERT INTO `emotion_coord` VALUES (35, '-6.6', '0.1', '34.0', '23.6', '1.70', '74.5', '34', '84.1 ');
INSERT INTO `emotion_coord` VALUES (36, '-6.5', '0.1', '35.0', '25.0', '1.75', '78.7', '35', '89.4 ');
INSERT INTO `emotion_coord` VALUES (37, '-6.4', '0.1', '36.0', '26.4', '1.80', '82.5', '36', '93.3 ');
INSERT INTO `emotion_coord` VALUES (38, '-6.3', '0.2', '37.0', '27.9', '1.85', '85.8', '37', '96.0 ');
INSERT INTO `emotion_coord` VALUES (39, '-6.2', '0.2', '38.0', '29.4', '1.90', '88.7', '38', '97.7 ');
INSERT INTO `emotion_coord` VALUES (40, '-6.1', '0.2', '39.0', '31.0', '1.95', '91.1', '39', '98.8 ');
INSERT INTO `emotion_coord` VALUES (41, '-6.0', '0.3', '40.0', '32.6', '2.00', '93.1', '40', '99.4 ');
INSERT INTO `emotion_coord` VALUES (42, '-5.9', '0.3', '41.0', '34.3', '2.05', '94.7', '41', '99.7 ');
INSERT INTO `emotion_coord` VALUES (43, '-5.8', '0.4', '42.0', '35.9', '2.10', '96.1', '42', '99.9 ');
INSERT INTO `emotion_coord` VALUES (44, '-5.7', '0.4', '43.0', '37.6', '2.15', '97.1', '43', '99.9 ');
INSERT INTO `emotion_coord` VALUES (45, '-5.6', '0.5', '44.0', '39.3', '2.20', '97.9', '44', '99.9 ');
INSERT INTO `emotion_coord` VALUES (46, '-5.5', '0.6', '45.0', '41.1', '2.25', '98.5', '45', '99.9');
INSERT INTO `emotion_coord` VALUES (47, '-5.4', '0.7', '46.0', '42.9', '2.30', '98.9', '46', '100.0 ');
INSERT INTO `emotion_coord` VALUES (48, '-5.3', '0.8', '47.0', '44.6', '2.35', '99.3', '47', '100.0 ');
INSERT INTO `emotion_coord` VALUES (49, '-5.2', '0.9', '48.0', '46.4', '2.40', '99.5', '48', '100.0 ');
INSERT INTO `emotion_coord` VALUES (50, '-5.1', '1.0', '49.0', '48.2', '2.45', '99.7', '49', '100.0 ');
INSERT INTO `emotion_coord` VALUES (51, '-5.0', '1.2', '50.0', '50.0', '2.50', '99.8', '50', '100.0 ');
INSERT INTO `emotion_coord` VALUES (52, '-4.9', '1.3', '51.0', '51.8', '2.55', '99.9', '51', '100.0 ');
INSERT INTO `emotion_coord` VALUES (53, '-4.8', '1.5', '52.0', '53.6', '2.60', '99.9', '52', '100.0 ');
INSERT INTO `emotion_coord` VALUES (54, '-4.7', '1.7', '53.0', '55.4', '2.65', '99.9', '53', '100.0 ');
INSERT INTO `emotion_coord` VALUES (55, '-4.6', '2.0', '54.0', '57.1', '2.70', '100.0', '54', '100.0 ');
INSERT INTO `emotion_coord` VALUES (56, '-4.5', '2.2', '55.0', '58.9', '2.75', '100.0', '55', '100.0 ');
INSERT INTO `emotion_coord` VALUES (57, '-4.4', '2.5', '56.0', '60.7', '2.80', '100.0', '56', '100.0 ');
INSERT INTO `emotion_coord` VALUES (58, '-4.3', '2.8', '57.0', '62.4', '2.85', '100.0', '57', '100.0 ');
INSERT INTO `emotion_coord` VALUES (59, '-4.2', '3.2', '58.0', '64.1', '2.90', '100.0', '58', '100.0 ');
INSERT INTO `emotion_coord` VALUES (60, '-4.1', '3.6', '59.0', '65.7', '2.95', '100.0', '59', '100.0 ');
INSERT INTO `emotion_coord` VALUES (61, '-4.0', '4.0', '60.0', '67.4', '3.00', '100.0', '60', '100.0 ');
INSERT INTO `emotion_coord` VALUES (62, '-3.9', '4.5', '61.0', '69.0', '3.05', '100.0', '61', '100.0 ');
INSERT INTO `emotion_coord` VALUES (63, '-3.8', '5.0', '62.0', '70.6', '3.10', '100.0', '62', '100.0 ');
INSERT INTO `emotion_coord` VALUES (64, '-3.7', '5.5', '63.0', '72.1', '3.15', '100.0', '63', '100.0 ');
INSERT INTO `emotion_coord` VALUES (65, '-3.6', '6.1', '64.0', '73.6', '3.20', '100.0', '64', '100.0 ');
INSERT INTO `emotion_coord` VALUES (66, '-3.5', '6.7', '65.0', '75.0', '3.25', '100.0', '65', '100.0 ');
INSERT INTO `emotion_coord` VALUES (67, '-3.4', '7.4', '66.0', '76.4', '3.30', '100.0', '66', '100.0 ');
INSERT INTO `emotion_coord` VALUES (68, '-3.3', '8.2', '67.0', '77.8', '3.35', '100.0', '67', '100.0 ');
INSERT INTO `emotion_coord` VALUES (69, '-3.2', '9.0', '68.0', '79.1', '3.40', '100.0', '68', '100.0 ');
INSERT INTO `emotion_coord` VALUES (70, '-3.1', '9.8', '69.0', '80.4', '3.45', '100.0', '69', '100.0 ');
INSERT INTO `emotion_coord` VALUES (71, '-3.0', '10.8', '70.0', '81.6', '3.50', '100.0', '70', '100.0 ');
INSERT INTO `emotion_coord` VALUES (72, '-2.9', '11.7', '71.0', '82.8', '3.55', '100.0', '71', '100.0 ');
INSERT INTO `emotion_coord` VALUES (73, '-2.8', '12.8', '72.0', '83.9', '3.60', '100.0', '72', '100.0 ');
INSERT INTO `emotion_coord` VALUES (74, '-2.7', '13.9', '73.0', '85.0', '3.65', '100.0', '73', '100.0 ');
INSERT INTO `emotion_coord` VALUES (75, '-2.6', '15.0', '74.0', '86.0', '3.70', '100.0', '74', '100.0 ');
INSERT INTO `emotion_coord` VALUES (76, '-2.5', '16.3', '75.0', '87.0', '3.75', '100.0', '75', '100.0 ');
INSERT INTO `emotion_coord` VALUES (77, '-2.4', '17.6', '76.0', '87.9', '3.80', '100.0', '76', '100.0 ');
INSERT INTO `emotion_coord` VALUES (78, '-2.3', '18.9', '77.0', '88.8', '3.85', '100.0', '77', '100.0 ');
INSERT INTO `emotion_coord` VALUES (79, '-2.2', '20.3', '78.0', '89.6', '3.90', '100.0', '78', '100.0 ');
INSERT INTO `emotion_coord` VALUES (80, '-2.1', '21.8', '79.0', '90.4', '3.95', '100.0', '79', '100.0 ');
INSERT INTO `emotion_coord` VALUES (81, '-2.0', '23.3', '80.0', '91.2', '4.00', '100.0', '80', '100.0 ');
INSERT INTO `emotion_coord` VALUES (82, '-1.9', '24.9', '81.0', '91.9', '4.05', '100.0', '81', '100.0 ');
INSERT INTO `emotion_coord` VALUES (83, '-1.8', '26.6', '82.0', '92.5', '4.10', '100.0', '82', '100.0 ');
INSERT INTO `emotion_coord` VALUES (84, '-1.7', '28.3', '83.0', '93.1', '4.15', '100.0', '83', '100.0 ');
INSERT INTO `emotion_coord` VALUES (85, '-1.6', '30.0', '84.0', '93.7', '4.20', '100.0', '84', '100.0 ');
INSERT INTO `emotion_coord` VALUES (86, '-1.5', '31.9', '85.0', '94.3', '4.25', '100.0', '85', '100.0 ');
INSERT INTO `emotion_coord` VALUES (87, '-1.4', '33.7', '86.0', '94.8', '4.30', '100.0', '86', '100.0 ');
INSERT INTO `emotion_coord` VALUES (88, '-1.3', '35.6', '87.0', '95.2', '4.35', '100.0', '87', '100.0 ');
INSERT INTO `emotion_coord` VALUES (89, '-1.2', '37.5', '88.0', '95.7', '4.40', '100.0', '88', '100.0 ');
INSERT INTO `emotion_coord` VALUES (90, '-1.1', '39.5', '89.0', '96.1', '4.45', '100.0', '89', '100.0 ');
INSERT INTO `emotion_coord` VALUES (91, '-1.0', '41.5', '90.0', '96.4', '4.50', '100.0', '90', '100.0 ');
INSERT INTO `emotion_coord` VALUES (92, '-0.9', '43.5', '91.0', '96.8', '4.55', '100.0', '91', '100.0 ');
INSERT INTO `emotion_coord` VALUES (93, '-0.8', '45.5', '92.0', '97.1', '4.60', '100.0', '92', '100.0 ');
INSERT INTO `emotion_coord` VALUES (94, '-0.7', '47.5', '93.0', '97.4', '4.65', '100.0', '93', '100.0 ');
INSERT INTO `emotion_coord` VALUES (95, '-0.6', '49.6', '94.0', '97.6', '4.70', '100.0', '94', '100.0 ');
INSERT INTO `emotion_coord` VALUES (96, '-0.5', '51.6', '95.0', '97.9', '4.75', '100.0', '95', '100.0 ');
INSERT INTO `emotion_coord` VALUES (97, '-0.4', '53.6', '96.0', '98.1', '4.80', '100.0', '96', '100.0 ');
INSERT INTO `emotion_coord` VALUES (98, '-0.3', '55.7', '97.0', '98.3', '4.85', '100.0', '97', '100.0 ');
INSERT INTO `emotion_coord` VALUES (99, '-0.2', '57.7', '98.0', '98.5', '4.90', '100.0', '98', '100.0 ');
INSERT INTO `emotion_coord` VALUES (100, '-0.1', '59.7', '99.0', '98.6', '4.95', '100.0', '99', '100.0 ');
INSERT INTO `emotion_coord` VALUES (101, '0.0', '61.6', '100.0', '98.8', '5.00', '100.0', '100', '100.0');
INSERT INTO `emotion_coord` VALUES (102, '0.1', '63.6', '0', '0', '0', '0', NULL, NULL);
INSERT INTO `emotion_coord` VALUES (103, '0.2', '65.5', '0', '0', '0', '0', NULL, NULL);
INSERT INTO `emotion_coord` VALUES (104, '0.3', '67.3', '0', '0', '0', '0', NULL, NULL);
INSERT INTO `emotion_coord` VALUES (105, '0.4', '69.2', '0', '0', '0', '0', NULL, NULL);
INSERT INTO `emotion_coord` VALUES (106, '0.5', '70.9', '0', '0', '0', '0', NULL, NULL);
INSERT INTO `emotion_coord` VALUES (107, '0.6', '72.7', '0', '0', '0', '0', NULL, NULL);
INSERT INTO `emotion_coord` VALUES (108, '0.7', '74.3', '0', '0', '0', '0', NULL, NULL);
INSERT INTO `emotion_coord` VALUES (109, '0.8', '76.0', '0', '0', '0', '0', NULL, NULL);
INSERT INTO `emotion_coord` VALUES (110, '0.9', '77.5', '0', '0', '0', '0', NULL, NULL);
INSERT INTO `emotion_coord` VALUES (111, '1.0', '79.0', '0', '0', '0', '0', NULL, NULL);
INSERT INTO `emotion_coord` VALUES (112, '1.1', '80.5', '0', '0', '0', '0', NULL, NULL);
INSERT INTO `emotion_coord` VALUES (113, '1.2', '81.9', '0', '0', '0', '0', NULL, NULL);
INSERT INTO `emotion_coord` VALUES (114, '1.3', '83.2', '0', '0', '0', '0', NULL, NULL);
INSERT INTO `emotion_coord` VALUES (115, '1.4', '84.4', '0', '0', '0', '0', NULL, NULL);
INSERT INTO `emotion_coord` VALUES (116, '1.5', '85.6', '0', '0', '0', '0', NULL, NULL);
INSERT INTO `emotion_coord` VALUES (117, '1.6', '86.7', '0', '0', '0', '0', NULL, NULL);
INSERT INTO `emotion_coord` VALUES (118, '1.7', '87.8', '0', '0', '0', '0', NULL, NULL);
INSERT INTO `emotion_coord` VALUES (119, '1.8', '88.8', '0', '0', '0', '0', NULL, NULL);
INSERT INTO `emotion_coord` VALUES (120, '1.9', '89.8', '0', '0', '0', '0', NULL, NULL);
INSERT INTO `emotion_coord` VALUES (121, '2.0', '90.6', '0', '0', '0', '0', NULL, NULL);
INSERT INTO `emotion_coord` VALUES (122, '2.1', '91.5', '0', '0', '0', '0', NULL, NULL);
INSERT INTO `emotion_coord` VALUES (123, '2.2', '92.2', '0', '0', '0', '0', NULL, NULL);
INSERT INTO `emotion_coord` VALUES (124, '2.3', '93.0', '0', '0', '0', '0', NULL, NULL);
INSERT INTO `emotion_coord` VALUES (125, '2.4', '93.6', '0', '0', '0', '0', NULL, NULL);
INSERT INTO `emotion_coord` VALUES (126, '2.5', '94.2', '0', '0', '0', '0', NULL, NULL);
INSERT INTO `emotion_coord` VALUES (127, '2.6', '94.8', '0', '0', '0', '0', NULL, NULL);
INSERT INTO `emotion_coord` VALUES (128, '2.7', '95.3', '0', '0', '0', '0', NULL, NULL);
INSERT INTO `emotion_coord` VALUES (129, '2.8', '95.8', '0', '0', '0', '0', NULL, NULL);
INSERT INTO `emotion_coord` VALUES (130, '2.9', '96.2', '0', '0', '0', '0', NULL, NULL);
INSERT INTO `emotion_coord` VALUES (131, '3.0', '96.6', '0', '0', '0', '0', NULL, NULL);
INSERT INTO `emotion_coord` VALUES (132, '3.1', '97.0', '0', '0', '0', '0', NULL, NULL);
INSERT INTO `emotion_coord` VALUES (133, '3.2', '97.3', '0', '0', '0', '0', NULL, NULL);
INSERT INTO `emotion_coord` VALUES (134, '3.3', '97.6', '0', '0', '0', '0', NULL, NULL);
INSERT INTO `emotion_coord` VALUES (135, '3.4', '97.9', '0', '0', '0', '0', NULL, NULL);
INSERT INTO `emotion_coord` VALUES (136, '3.5', '98.2', '0', '0', '0', '0', NULL, NULL);
INSERT INTO `emotion_coord` VALUES (137, '3.6', '98.4', '0', '0', '0', '0', NULL, NULL);
INSERT INTO `emotion_coord` VALUES (138, '3.7', '98.6', '0', '0', '0', '0', NULL, NULL);
INSERT INTO `emotion_coord` VALUES (139, '3.8', '98.7', '0', '0', '0', '0', NULL, NULL);
INSERT INTO `emotion_coord` VALUES (140, '3.9', '98.9', '0', '0', '0', '0', NULL, NULL);
INSERT INTO `emotion_coord` VALUES (141, '4.0', '99.0', '0', '0', '0', '0', NULL, NULL);
INSERT INTO `emotion_coord` VALUES (142, '4.1', '99.2', '0', '0', '0', '0', NULL, NULL);
INSERT INTO `emotion_coord` VALUES (143, '4.2', '99.3', '0', '0', '0', '0', NULL, NULL);
INSERT INTO `emotion_coord` VALUES (144, '4.3', '99.4', '0', '0', '0', '0', NULL, NULL);
INSERT INTO `emotion_coord` VALUES (145, '4.4', '99.5', '0', '0', '0', '0', NULL, NULL);
INSERT INTO `emotion_coord` VALUES (146, '4.5', '99.5', '0', '0', '0', '0', NULL, NULL);
INSERT INTO `emotion_coord` VALUES (147, '4.6', '99.6', '0', '0', '0', '0', NULL, NULL);
INSERT INTO `emotion_coord` VALUES (148, '4.7', '99.7', '0', '0', '0', '0', NULL, NULL);
INSERT INTO `emotion_coord` VALUES (149, '4.8', '99.7', '0', '0', '0', '0', NULL, NULL);
INSERT INTO `emotion_coord` VALUES (150, '4.9', '99.7', '0', '0', '0', '0', NULL, NULL);
INSERT INTO `emotion_coord` VALUES (151, '5.0', '99.8', '0', '0', '0', '0', NULL, NULL);


-- ----------------------------
-- Table structure for emotion_correlation
-- ----------------------------
DROP TABLE IF EXISTS `emotion_correlation`;
CREATE TABLE `emotion_correlation`  (
  `correlation_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `video_id` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `record_id` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `report_id` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `correlation_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `aggression` double NOT NULL,
  `stress` double NOT NULL,
  `tension` double NOT NULL,
  `suspect` double NOT NULL,
  `balance` double NOT NULL,
  `charm` double NOT NULL,
  `energy` double NOT NULL,
  `regulation` double NOT NULL,
  `inhibition` double NOT NULL,
  `neuroticism` double NOT NULL,
  `depression` double NOT NULL,
  `happiness` double NOT NULL,
  `i` double NOT NULL,
  `e` double NOT NULL,
  `hm` double NOT NULL,
  `hs` double NOT NULL,
  `status` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NULL DEFAULT NULL,
  PRIMARY KEY (`correlation_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for emotion_delta
-- ----------------------------
DROP TABLE IF EXISTS `emotion_delta`;
CREATE TABLE `emotion_delta`  (
  `delta_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `video_id` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `record_id` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `report_id` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `aggression` double NOT NULL,
  `stress` double NOT NULL,
  `tension` double NOT NULL,
  `suspect` double NOT NULL,
  `balance` double NOT NULL,
  `charm` double NOT NULL,
  `energy` double NOT NULL,
  `regulation` double NOT NULL,
  `inhibition` double NOT NULL,
  `neuroticism` double NOT NULL,
  `depression` double NOT NULL,
  `happiness` double NOT NULL,
  `extroversion` double NOT NULL DEFAULT 0,
  `stability` double NOT NULL DEFAULT 0,
  `i` double NOT NULL,
  `e` double NOT NULL,
  `hm` double NOT NULL,
  `hs` double NOT NULL,
  `status` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NULL DEFAULT NULL,
  PRIMARY KEY (`delta_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for emotion_fh
-- ----------------------------
DROP TABLE IF EXISTS `emotion_fh`;
CREATE TABLE `emotion_fh`  (
  `fh_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `video_id` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `record_id` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `report_id` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `h` double NOT NULL,
  `ha` double NOT NULL,
  `status` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NULL DEFAULT NULL,
  PRIMARY KEY (`fh_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for emotion_ft
-- ----------------------------
DROP TABLE IF EXISTS `emotion_ft`;
CREATE TABLE `emotion_ft`  (
  `ft_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `video_id` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `record_id` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `report_id` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `e` double NOT NULL,
  `ph` double NOT NULL,
  `dt` double NOT NULL,
  `status` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NULL DEFAULT NULL,
  PRIMARY KEY (`ft_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;


-- ----------------------------
-- Table structure for emotion_group
-- ----------------------------
DROP TABLE IF EXISTS `emotion_group`;
CREATE TABLE `emotion_group`  (
  `group_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `group_no` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `group_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `group_status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `group_remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `group_feature` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `group_process` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `status` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `created_at` datetime(0) NOT NULL DEFAULT current_timestamp(0),
  `updated_at` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`group_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of emotion_group
-- ----------------------------
INSERT INTO `emotion_group` VALUES (1, 'A1', '最佳/均衡群', '最佳状态', '最佳状态', '整体状态极佳，心态非常平和，能够主动地对情绪进行自我管理，能够经常感受到轻松和幸福，知道如何享受当下，时刻准备着尝试新的挑战。几乎没有压力，即便有也能轻松克服。', '每天管理好自己的心态，继续维持该状态。', 1, '2020-03-13 17:57:33', NULL);
INSERT INTO `emotion_group` VALUES (2, 'A2', '最佳/均衡群', '均衡状态', '均衡状态', '整体状态处于健康，情绪较为稳定，虽有一点压力，但拥有抗压能力。集中度和活力度可能会受到一定影响，但总体上状态比较均衡。', '可以多做一些自己喜欢的事情，或有氧运动，快乐和激发活力让自己更能够专注于眼前的工作，越专注对自己的生活和幸福的满足感越强。', 1, '2020-03-13 17:58:53', NULL);
INSERT INTO `emotion_group` VALUES (3, 'A3', '最佳/均衡群', '安静状态', '安静状态', '整体状态处于健康，感觉自己处于一种平静无压力，无欲无求的状态，对当前所做的事情能够很好的集中精力去做。因平时能够更专注，所以如果从事有创意的项目，可期待能有良好的结果。', '可以选择自己喜欢的运动，或者多做一些有氧运动比如跳舞、踢足球等，以提高身体的活力，运动过后身体会有神清气爽的愉悦感。也可以对当下所做的事赋予更多积极意义，以便能够提高自己做事的满足感。', 1, '2020-03-13 17:59:57', NULL);
INSERT INTO `emotion_group` VALUES (4, 'A4', '最佳/均衡群', '活力/积极', '有活力/积极状态', '整体状态处于健康，情绪较为愉快，能够积极主动地参与所有活动和表达自己的意见，并且不觉得疲倦。注意的集中度有所下降，是做体育活动的好时机，但长时间运动的话还是会累，所以适当且始终如一地坚持运动会更好。', '可以多做一些体育活动，但要注意过度的活动会导致晚上疲惫。比起一个人享受的兴趣活动，推荐多参与互动，并且能够建立关系的兴趣活动更为适宜。', 1, '2020-03-13 18:01:30', NULL);
INSERT INTO `emotion_group` VALUES (5, 'B1', '保养/休息群', '兴奋/冲动', '兴奋/冲动状态', '现在处于一种情绪高涨的状态，对外界环境敏感性降低，压力较低，情绪较为激动，可能是外部刺激所引起，也可能是本身情绪就容易激动。需要注意过度兴奋可能会导致冲动和过激行为，身体易疲劳。', '为了能够调节情绪，也是为消除兴奋状态，推荐园艺治疗、自然疗法、瑜伽、心理调节、音乐疗法、正念疗法、色彩疗法等，以静息运动平复情绪。让身心平静获得充分的休息，从而达到均衡状态。推荐参与组织、团体成果/成就的活动，并且对他人给予帮助的关怀、捐赠等活动。', 1, '2020-03-13 18:05:44', NULL);
INSERT INTO `emotion_group` VALUES (6, 'B2', '保养/休息群', '不安', '不安状态', '很小的外部刺激也可能会导致紧张、焦虑和不安。不安的心态会让自己谨小慎微，缺乏安全感。适当的焦虑是为了避免不好的事情发生，可以提醒我们对可能发生的事情做更加充分的准备，而过度的焦虑只会使人深陷内耗之中，降低工作效率和生活幸福感。', '推荐以消除不安感为主的活动（冥想、森林疗法、歌唱、声音疗法、专家咨询），或找寻最适合自己的健康疗法。做冥想可以使人更客观地认识到自己。歌舞体验可以净化自身的焦虑和不安，达到治愈自我的效果。森林体验中身体产生的血清素能够调节不安的情绪。', 1, '2020-03-13 18:06:06', NULL);
INSERT INTO `emotion_group` VALUES (7, 'B3', '保养/休息群', '疲倦', '疲倦状态', '经历高强度的工作任务或持续高压的紧张心理之后，感觉身体疲倦无力和心情懒散，很难提起精神和集中注意力，思考能力和工作效率明显降低。', '坚持做适合身体能力范围内的运动，推荐爬楼梯、慢跑、散步、伸展运动、瑜伽、普拉提等。如果每天坚持做提高心肺功能的运动，早上会因为新的期待感而变得积极、充满活力。当体力和耐力变好，身体机能有所改善时，积极的脑回路会自动激活，提高睡眠质量，快速恢复身心疲劳。也可以适当地按摩、泡澡，早点入睡并睡个好觉以缓解大脑疲劳。', 1, '2020-03-13 18:06:20', NULL);
INSERT INTO `emotion_group` VALUES (8, 'B4', '保养/休息群', '压力', '压力状态', '对压力非常敏感，感觉事与愿违又没有办法改变，心情沉重，集中力下降，幸福感弱，需要找到消除压力的自我途径。', '寻找适合自己的解压方法，推荐看电影、听音乐、冥想、瑜伽、散步、享受日光浴、旅行、泡澡、按摩、美食（治愈食品）、与熟人聊天、异国风情、森林疗法、芳香疗法、色彩疗法、骑自行车、登山、健身球等。多做出汗的运动会很减压。平时也可以经常做脖子和后背的伸展运动，尽可能去尝试和坚持，没必要追求完美。', 1, '2020-03-13 18:06:23', NULL);
INSERT INTO `emotion_group` VALUES (9, 'C1', '关注/治疗群', '生气/不快', '生气/不快状态', '经常感到内心不安，很难体验到幸福感，很难说出自己的感受，即使是很小的事情也可能导致被压抑的情绪瞬间爆发。心情烦躁、不愉快，集中力下降，不能安心做事情。想刻意集中精力，也经常会事与愿违反而变得更加不适。', '当享受并沉浸在自己真正喜欢的事情中时，不适感会消失，慢慢感觉到幸福。比如可以通过打高尔夫球、爬山、骑自行车、冥想、踢足球等融化这种不愉快的心情。深呼吸会暂时抑制负面情绪的快速上升，能够有时间调节自己内心的情绪。为避免负面情绪的过多累积，必要时可以向自己信任的人倾诉，以此来疏解不良情绪。', 1, '2020-03-13 18:06:44', NULL);
INSERT INTO `emotion_group` VALUES (10, 'C2', '关注/治疗群', '无力/抑郁症状', '无力/抑郁状态', '自信心和活力度低，内心空虚，无论做什么都没有动力，即使偶尔有所好转但很快又会再次感到无力。是长期压力大、非常疲劳而又缺乏有效的调节方式导致的状态。', '做自己喜欢的事情，尤其是自己感到自信和最擅长的事情，这样大脑也会感受到幸福。也可以适当尝试新的事情，比如登山、打高尔夫、跳舞、练瑜伽、养宠物、打理园艺、画水彩画、踢足球、钓鱼等，以锻炼现在疲惫的身体和心灵。也可以适当地进行冥想放松，缓解疲劳的同时增加心情的愉悦感。重要的是培养积极乐观的心态，多采用积极的视角看待事物。', 1, '2020-03-13 18:06:48', NULL);


-- ----------------------------
-- Table structure for emotion_info
-- ----------------------------
DROP TABLE IF EXISTS `emotion_info`;
CREATE TABLE `emotion_info`  (
  `info_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `video_id` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `record_id` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `report_id` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `start_time` datetime(6) NOT NULL,
  `end_time` datetime(6) NOT NULL,
  `fps_max` double NOT NULL,
  `m` double NOT NULL,
  `s` double NOT NULL,
  `v_min` double NOT NULL,
  `v_max` double NOT NULL,
  `x_max` double NOT NULL,
  `x_maxa` double NOT NULL,
  `status` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NULL DEFAULT NULL,
  PRIMARY KEY (`info_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for emotion_m
-- ----------------------------
DROP TABLE IF EXISTS `emotion_m`;
CREATE TABLE `emotion_m`  (
  `m_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `video_id` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `record_id` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `report_id` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `vi` double NOT NULL,
  `aggression_m` double NOT NULL,
  `aggression_s` double NOT NULL,
  `aggression_vi` double NOT NULL,
  `aggression_bmin` double NOT NULL,
  `aggression_cmin` double NOT NULL,
  `aggression_bmax` double NOT NULL,
  `aggression_cmax` double NOT NULL,
  `stress_m` double NOT NULL,
  `stress_s` double NOT NULL,
  `stress_vi` double NOT NULL,
  `stress_bmin` double NOT NULL,
  `stress_cmin` double NOT NULL,
  `stress_bmax` double NOT NULL,
  `stress_cmax` double NOT NULL,
  `tension_m` double NOT NULL,
  `tension_s` double NOT NULL,
  `tension_vi` double NOT NULL,
  `tension_bmin` double NOT NULL,
  `tension_cmin` double NOT NULL,
  `tension_bmax` double NOT NULL,
  `tension_cmax` double NOT NULL,
  `suspect_m` double NOT NULL,
  `suspect_s` double NOT NULL,
  `suspect_vi` double NOT NULL,
  `suspect_bmin` double NOT NULL,
  `suspect_cmin` double NOT NULL,
  `suspect_bmax` double NOT NULL,
  `suspect_cmax` double NOT NULL,
  `balance_m` double NOT NULL,
  `balance_s` double NOT NULL,
  `balance_vi` double NOT NULL,
  `balance_bmin` double NOT NULL,
  `balance_cmin` double NOT NULL,
  `balance_bmax` double NOT NULL,
  `balance_cmax` double NOT NULL,
  `charm_m` double NOT NULL,
  `charm_s` double NOT NULL,
  `charm_vi` double NOT NULL,
  `charm_bmin` double NOT NULL,
  `charm_cmin` double NOT NULL,
  `charm_bmax` double NOT NULL,
  `charm_cmax` double NOT NULL,
  `energy_m` double NOT NULL,
  `energy_s` double NOT NULL,
  `energy_vi` double NOT NULL,
  `energy_bmin` double NOT NULL,
  `energy_cmin` double NOT NULL,
  `energy_bmax` double NOT NULL,
  `energy_cmax` double NOT NULL,
  `regulation_m` double NOT NULL,
  `regulation_s` double NOT NULL,
  `regulation_vi` double NOT NULL,
  `regulation_bmin` double NOT NULL,
  `regulation_cmin` double NOT NULL,
  `regulation_bmax` double NOT NULL,
  `regulation_cmax` double NOT NULL,
  `inhibition_m` double NOT NULL,
  `inhibition_s` double NOT NULL,
  `inhibition_vi` double NOT NULL,
  `inhibition_bmin` double NOT NULL,
  `inhibition_cmin` double NOT NULL,
  `inhibition_bmax` double NOT NULL,
  `inhibition_cmax` double NOT NULL,
  `neuroticism_m` double NOT NULL,
  `neuroticism_s` double NOT NULL,
  `neuroticism_vi` double NOT NULL,
  `neuroticism_bmin` double NOT NULL,
  `neuroticism_cmin` double NOT NULL,
  `neuroticism_bmax` double NOT NULL,
  `neuroticism_cmax` double NOT NULL,
  `health_m` double NOT NULL,
  `health_s` double NOT NULL,
  `health_vi` double NOT NULL,
  `health_bmin` double NOT NULL,
  `health_cmin` double NOT NULL,
  `health_bmax` double NOT NULL,
  `health_cmax` double NOT NULL,
  `health1_m` double NOT NULL,
  `health1_s` double NOT NULL,
  `health1_vi` double NOT NULL,
  `health1_bmin` double NOT NULL,
  `health1_cmin` double NOT NULL,
  `health1_bmax` double NOT NULL,
  `health1_cmax` double NOT NULL,
  `extroversion_m` double NOT NULL,
  `extroversion_s` double NOT NULL,
  `extroversion_vi` double NOT NULL,
  `extroversion_bmin` double NOT NULL,
  `extroversion_cmin` double NOT NULL,
  `extroversion_bmax` double NOT NULL,
  `extroversion_cmax` double NOT NULL,
  `stability_m` double NOT NULL,
  `stability_s` double NOT NULL,
  `stability_vi` double NOT NULL,
  `stability_bmin` double NOT NULL,
  `stability_cmin` double NOT NULL,
  `stability_bmax` double NOT NULL,
  `stability_cmax` double NOT NULL,
  `status` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NULL DEFAULT NULL,
  PRIMARY KEY (`m_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for emotion_record
-- ----------------------------
DROP TABLE IF EXISTS `emotion_record`;
CREATE TABLE `emotion_record`  (
  `record_id` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `user_id` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `video_id` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `aggression` double NOT NULL,
  `stress` double NOT NULL,
  `tension` double NOT NULL,
  `neuroticism` double NOT NULL,
  `inhibition` double NOT NULL,
  `regulation` double NOT NULL,
  `charm` double NOT NULL,
  `energy` double NOT NULL,
  `balance` double NOT NULL,
  `suspect` double NOT NULL,
  `vi` double NOT NULL,
  `health` double NOT NULL,
  `health1` double NOT NULL,
  `extroversion` double NOT NULL DEFAULT 0,
  `stability` double NOT NULL,
  `status` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NULL DEFAULT NULL,
  PRIMARY KEY (`record_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for emotion_report
-- ----------------------------
DROP TABLE IF EXISTS `emotion_report`;
CREATE TABLE `emotion_report`  (
  `report_id` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `record_id` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `video_id` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `user_id` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `aggression` double NOT NULL,
  `aggression_min` double NOT NULL,
  `aggression_max` double NOT NULL,
  `stress` double NOT NULL,
  `stress_min` double NOT NULL,
  `stress_max` double NOT NULL,
  `tension` double NOT NULL,
  `tension_min` double NOT NULL,
  `tension_max` double NOT NULL,
  `suspect` double NOT NULL,
  `suspect_min` double NOT NULL,
  `suspect_max` double NOT NULL,
  `balance` double NOT NULL,
  `balance_min` double NOT NULL,
  `balance_max` double NOT NULL,
  `charm` double NOT NULL,
  `charm_min` double NOT NULL,
  `charm_max` double NOT NULL,
  `energy` double NOT NULL,
  `energy_min` double NOT NULL,
  `energy_max` double NOT NULL,
  `regulation` double NOT NULL,
  `regulation_min` double NOT NULL,
  `regulation_max` double NOT NULL,
  `inhibition` double NOT NULL,
  `inhibition_min` double NOT NULL,
  `inhibition_max` double NOT NULL,
  `neuroticism` double NOT NULL,
  `neuroticism_min` double NOT NULL,
  `neuroticism_max` double NOT NULL,
  `vi` double NOT NULL,
  `vitality` double NOT NULL,
  `concentration` double NOT NULL,
  `group_id` int(10) UNSIGNED NOT NULL,
  `brain_state` double NOT NULL,
  `brain_fatigue` double NOT NULL,
  `brain_emotion` double NOT NULL,
  `brain_energy` double NOT NULL,
  `health_state` int(10) UNSIGNED NOT NULL,
  `health_correlation` double NOT NULL,
  `health_delta` double NOT NULL,
  `spirit_x1` double NOT NULL,
  `spirit_y1` double NOT NULL,
  `spirit_x2` double NOT NULL,
  `spirit_y2` double NOT NULL,
  `remark` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL,
  `content` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL,
  `status` int(10) NOT NULL DEFAULT 1,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NULL DEFAULT NULL,
  PRIMARY KEY (`report_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for emotion_user_video
-- ----------------------------
DROP TABLE IF EXISTS `emotion_user_video`;
CREATE TABLE `emotion_user_video`  (
  `rid` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `video_id` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `kid_id` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `video_status` int(10) UNSIGNED NOT NULL COMMENT '1为待下载视频, 2为分析中, 3和4为分析失败, 5为分析完成',
  `status` int(10) UNSIGNED NOT NULL COMMENT '一直为1',
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NULL DEFAULT NULL,
  PRIMARY KEY (`rid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for emotion_video
-- ----------------------------
DROP TABLE IF EXISTS `emotion_video`;
CREATE TABLE `emotion_video`  (
  `video_id` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `video_photo` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `video_path` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `video_origin` int(10) UNSIGNED NOT NULL COMMENT '1为本地下载, 2为阿里云外网下载, 3为阿里云内网下载',
  `status` int(10) UNSIGNED NOT NULL COMMENT '一直为1',
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NULL DEFAULT NULL,
  PRIMARY KEY (`video_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for platform_developer
-- ----------------------------
DROP TABLE IF EXISTS `platform_developer`;
CREATE TABLE `platform_developer`  (
  `developer_id` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '开发者id',
  `developer_contact_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '开发者联系人',
  `developer_contact_phone` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '' COMMENT '开发者电话',
  `developer_inserttime` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建时间, unix时间戳',
  `developer_inserttime_datetime` datetime(0) NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间, 格式化时间',
  PRIMARY KEY (`developer_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '开发者' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for platform_developer_app
-- ----------------------------
DROP TABLE IF EXISTS `platform_developer_app`;
CREATE TABLE `platform_developer_app`  (
  `app_id` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '应用id',
  `app_developer_id` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '应用的开发者id',
  `app_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '应用名称',
  `app_inserttime` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建时间, unix时间戳',
  `app_inserttime_datetime` datetime(0) NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间, 格式化时间',
  PRIMARY KEY (`app_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '开发者的应用' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for platform_session
-- ----------------------------
DROP TABLE IF EXISTS `platform_session`;
CREATE TABLE `platform_session`  (
  `session_token` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'session id, 用于Authentication Bearer token',
  `session_developer_id` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '开发者id',
  `session_app_id` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '应用id',
  `session_inserttime` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建时间, unix时间戳',
  `session_inserttime_datetime` datetime(0) NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间, 格式化时间',
  `session_expiretime` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '过期时间, unix时间戳',
  `session_expiretime_datetime` datetime(0) NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '过期时间, 格式化时间',
  PRIMARY KEY (`session_token`) USING BTREE,
  INDEX `session_app_id`(`session_app_id`) USING BTREE,
  INDEX `session_expiretime`(`session_expiretime`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '服务器session' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for platform_task
-- ----------------------------
DROP TABLE IF EXISTS `platform_task`;
CREATE TABLE `platform_task`  (
  `task_id` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '任务id',
  `task_video_md5` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '视频文件md5',
  `task_video_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '视频名称',
  `task_video_uri` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '视频URI, 即相对于站点根目录的路径',
  `task_video_path` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '视频路径',
  `task_state_code` tinyint(4) NOT NULL DEFAULT 0 COMMENT '任务状态编码',
  `task_state_remark` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '' COMMENT '任务状态备注',
  `task_inserttime` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建时间, unix时间戳',
  `task_inserttime_datetime` datetime(0) NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间, 格式化时间',
  `task_updatetime` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '更新时间, unix时间戳',
  `task_updatetime_datetime` datetime(0) NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间, 格式化时间',
  PRIMARY KEY (`task_id`) USING BTREE,
  UNIQUE INDEX `task_video_md5`(`task_video_md5`) USING BTREE,
  INDEX `task_state_code`(`task_state_code`) USING BTREE,
  INDEX `task_inserttime`(`task_inserttime`) USING BTREE,
  INDEX `task_updatetime`(`task_updatetime`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '任务队列' ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;

