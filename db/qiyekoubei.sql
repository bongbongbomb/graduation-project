-- --------------------------------------------------------
-- 主机:                           127.0.0.1
-- 服务器版本:                        8.0.42 - MySQL Community Server - GPL
-- 服务器操作系统:                      Win64
-- HeidiSQL 版本:                  12.10.0.7000
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- 导出 springboot8d6m43dj 的数据库结构
CREATE DATABASE IF NOT EXISTS `springboot8d6m43dj` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `springboot8d6m43dj`;

-- 导出  表 springboot8d6m43dj.aboutus 结构
CREATE TABLE IF NOT EXISTS `aboutus` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '标题',
  `subtitle` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '副标题',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '内容',
  `picture1` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '图片1',
  `picture2` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '图片2',
  `picture3` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '图片3',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='关于我们';

-- 正在导出表  springboot8d6m43dj.aboutus 的数据：~1 rows (大约)
INSERT INTO `aboutus` (`id`, `addtime`, `title`, `subtitle`, `content`, `picture1`, `picture2`, `picture3`) VALUES
	(1, '2025-04-20 14:08:15', '关于我们', 'ABOUT US', '大学生实习就业分析系统是一个综合性的信息管理平台，旨在为高校、在校生、毕业生及用人单位提供全链条的数据服务与决策支持。系统通过整合学生在校学习表现、实习经历、职业技能认证、求职意向等多维度数据，运用大数据分析与可视化技术，深度挖掘学生能力画像与就业市场的动态关联。', 'upload/aboutus_picture1.jpg', 'upload/aboutus_picture2.jpg', 'upload/aboutus_picture3.jpg');

-- 导出  表 springboot8d6m43dj.chatmessage 结构
CREATE TABLE IF NOT EXISTS `chatmessage` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `uid` bigint NOT NULL COMMENT '用户ID',
  `fid` bigint NOT NULL COMMENT '好友用户ID',
  `content` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '内容',
  `format` int DEFAULT NULL COMMENT '格式(1:文字，2:图片)',
  `isread` int DEFAULT '0' COMMENT '消息已读(0:未读，1:已读)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='消息表';

-- 正在导出表  springboot8d6m43dj.chatmessage 的数据：~0 rows (大约)

-- 导出  表 springboot8d6m43dj.config 结构
CREATE TABLE IF NOT EXISTS `config` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(100) NOT NULL COMMENT '配置参数名称',
  `value` varchar(100) DEFAULT NULL COMMENT '配置参数值',
  `url` varchar(500) DEFAULT NULL COMMENT 'url',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COMMENT='配置文件';

-- 正在导出表  springboot8d6m43dj.config 的数据：~3 rows (大约)
INSERT INTO `config` (`id`, `name`, `value`, `url`) VALUES
	(1, 'picture1', 'upload/picture1.jpg', NULL),
	(2, 'picture2', 'upload/picture2.jpg', NULL),
	(3, 'picture3', 'upload/picture3.jpg', NULL);

-- 导出  表 springboot8d6m43dj.friend 结构
CREATE TABLE IF NOT EXISTS `friend` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `uid` bigint NOT NULL COMMENT '用户ID',
  `fid` bigint NOT NULL COMMENT '好友用户ID',
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '名称',
  `picture` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '图片',
  `role` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '角色',
  `tablename` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '表名',
  `alias` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '别名',
  `type` int DEFAULT '0' COMMENT '类型(0:好友申请，1:好友，2:消息)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='好友表';

-- 正在导出表  springboot8d6m43dj.friend 的数据：~0 rows (大约)

-- 导出  表 springboot8d6m43dj.gangweileixing 结构
CREATE TABLE IF NOT EXISTS `gangweileixing` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gangweileixing` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '岗位类型',
  PRIMARY KEY (`id`),
  UNIQUE KEY `gangweileixing` (`gangweileixing`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='岗位类型';

-- 正在导出表  springboot8d6m43dj.gangweileixing 的数据：~10 rows (大约)
INSERT INTO `gangweileixing` (`id`, `addtime`, `gangweileixing`) VALUES
	(9, '2026-03-04 07:25:17', '软件开发工程师'),
	(10, '2026-03-04 07:25:17', '数据分析师'),
	(11, '2026-03-04 07:25:17', '市场推广专员'),
	(12, '2026-03-04 07:25:18', '人力资源管理实习生'),
	(13, '2026-03-04 07:25:18', '新媒体运营'),
	(14, '2026-03-04 07:25:18', '财务会计助理'),
	(15, '2026-03-04 07:25:18', '产品经理助理'),
	(16, '2026-03-04 07:25:18', '硬件测试工程师'),
	(17, '2026-03-04 07:25:18', '平面设计师'),
	(18, '2026-03-04 07:25:18', '供应链管理实习生');

-- 导出  表 springboot8d6m43dj.luyongtongzhi 结构
CREATE TABLE IF NOT EXISTS `luyongtongzhi` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `xueshengzhanghao` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '学生账号',
  `xueshengxingming` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '学生姓名',
  `qiyemingcheng` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '企业名称',
  `shiximingcheng` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '实习名称',
  `gangweileixing` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '岗位类型',
  `fengmian` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '封面',
  `gongzuodidian` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '工作地点',
  `shangbanshijian` date DEFAULT NULL COMMENT '上班时间',
  `luyongzhuangtai` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '录用状态',
  `luyongshijian` date DEFAULT NULL COMMENT '录用时间',
  `luyongxiangqing` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '录用详情',
  `qiyezhanghao` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '企业账号',
  `fuzeren` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '负责人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='录用通知';

-- 正在导出表  springboot8d6m43dj.luyongtongzhi 的数据：~8 rows (大约)
INSERT INTO `luyongtongzhi` (`id`, `addtime`, `xueshengzhanghao`, `xueshengxingming`, `qiyemingcheng`, `shiximingcheng`, `gangweileixing`, `fengmian`, `gongzuodidian`, `shangbanshijian`, `luyongzhuangtai`, `luyongshijian`, `luyongxiangqing`, `qiyezhanghao`, `fuzeren`) VALUES
	(1, '2025-04-20 14:08:14', '学生账号1', '学生姓名1', '企业名称1', '实习名称1', '岗位类型1', 'upload/luyongtongzhi_fengmian1.jpg,upload/luyongtongzhi_fengmian2.jpg,upload/luyongtongzhi_fengmian3.jpg', '工作地点1', '2025-04-20', '已通过录用', '2025-04-20', '录用详情1', '企业账号1', '负责人1'),
	(2, '2025-04-20 14:08:14', '学生账号2', '学生姓名2', '企业名称2', '实习名称2', '岗位类型2', 'upload/luyongtongzhi_fengmian2.jpg,upload/luyongtongzhi_fengmian3.jpg,upload/luyongtongzhi_fengmian4.jpg', '工作地点2', '2025-04-20', '已通过录用', '2025-04-20', '录用详情2', '企业账号2', '负责人2'),
	(3, '2025-04-20 14:08:14', '学生账号3', '学生姓名3', '企业名称3', '实习名称3', '岗位类型3', 'upload/luyongtongzhi_fengmian3.jpg,upload/luyongtongzhi_fengmian4.jpg,upload/luyongtongzhi_fengmian5.jpg', '工作地点3', '2025-04-20', '已通过录用', '2025-04-20', '录用详情3', '企业账号3', '负责人3'),
	(4, '2025-04-20 14:08:14', '学生账号4', '学生姓名4', '企业名称4', '实习名称4', '岗位类型4', 'upload/luyongtongzhi_fengmian4.jpg,upload/luyongtongzhi_fengmian5.jpg,upload/luyongtongzhi_fengmian6.jpg', '工作地点4', '2025-04-20', '已通过录用', '2025-04-20', '录用详情4', '企业账号4', '负责人4'),
	(5, '2025-04-20 14:08:14', '学生账号5', '学生姓名5', '企业名称5', '实习名称5', '岗位类型5', 'upload/luyongtongzhi_fengmian5.jpg,upload/luyongtongzhi_fengmian6.jpg,upload/luyongtongzhi_fengmian7.jpg', '工作地点5', '2025-04-20', '已通过录用', '2025-04-20', '录用详情5', '企业账号5', '负责人5'),
	(6, '2025-04-20 14:08:14', '学生账号6', '学生姓名6', '企业名称6', '实习名称6', '岗位类型6', 'upload/luyongtongzhi_fengmian6.jpg,upload/luyongtongzhi_fengmian7.jpg,upload/luyongtongzhi_fengmian8.jpg', '工作地点6', '2025-04-20', '已通过录用', '2025-04-20', '录用详情6', '企业账号6', '负责人6'),
	(7, '2025-04-20 14:08:14', '学生账号7', '学生姓名7', '企业名称7', '实习名称7', '岗位类型7', 'upload/luyongtongzhi_fengmian7.jpg,upload/luyongtongzhi_fengmian8.jpg,upload/luyongtongzhi_fengmian1.jpg', '工作地点7', '2025-04-20', '已通过录用', '2025-04-20', '录用详情7', '企业账号7', '负责人7'),
	(8, '2025-04-20 14:08:14', '学生账号8', '学生姓名8', '企业名称8', '实习名称8', '岗位类型8', 'upload/luyongtongzhi_fengmian8.jpg,upload/luyongtongzhi_fengmian1.jpg,upload/luyongtongzhi_fengmian2.jpg', '工作地点8', '2025-04-20', '已通过录用', '2025-04-20', '录用详情8', '企业账号8', '负责人8');

-- 导出  表 springboot8d6m43dj.news 结构
CREATE TABLE IF NOT EXISTS `news` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '标题',
  `introduction` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '简介',
  `typename` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '分类名称',
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '发布人',
  `headportrait` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '头像',
  `clicknum` int DEFAULT '0' COMMENT '点击次数',
  `clicktime` datetime DEFAULT NULL COMMENT '最近点击时间',
  `thumbsupnum` int DEFAULT '0' COMMENT '赞',
  `crazilynum` int DEFAULT '0' COMMENT '踩',
  `storeupnum` int DEFAULT '0' COMMENT '收藏数',
  `picture` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '图片',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '内容',
  PRIMARY KEY (`id`),
  KEY `typename` (`typename`),
  CONSTRAINT `news_ibfk_1` FOREIGN KEY (`typename`) REFERENCES `newstype` (`typename`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='公告资讯';

-- 正在导出表  springboot8d6m43dj.news 的数据：~8 rows (大约)
INSERT INTO `news` (`id`, `addtime`, `title`, `introduction`, `typename`, `name`, `headportrait`, `clicknum`, `clicktime`, `thumbsupnum`, `crazilynum`, `storeupnum`, `picture`, `content`) VALUES
	(9, '2026-03-04 07:34:36', '重磅上线 | 大学生实习就业分析系统正式启用通知', '我校2026届毕业生就业服务数字化平台——大学生实习就业分析系统将于3月10日全面上线，助力学子精准就业。', '系统公告', '校就业指导中心', NULL, 325, '2026-02-20 09:15:00', 45, 2, 28, 'upload/aboutus_picture1.jpg', '为助力2026届毕业生顺利开启职业生涯，我校"大学生实习就业分析系统"将于2026年3月10日正式上线。该系统整合了校内生涯教育、实习管理与就业服务数据，为同学们提供从职业测评、实习岗位智能匹配到就业趋势预测的一站式服务。\n\n即日起，同学们可通过统一身份认证登录系统，完善个人简历与求职意向，提前锁定心仪实习机会。系统主要功能包括：智能岗位匹配、生涯规划仪表盘、实习过程管理、就业数据分析等。\n\n请各学院做好宣传推广工作，确保每位毕业生知晓并使用。'),
	(10, '2026-03-04 07:34:36', '2025-2026秋招季数据分析报告发布', '系统首份秋招数据报告出炉：新兴领域岗位热度飙升，面试邀约率提升18%。', '数据报告', '数据中心', NULL, 191, '2026-03-04 15:38:08', 32, 1, 15, 'upload/aboutus_picture2.jpg', '系统数据显示，在2025-2026学年秋招季，通过本系统投递简历的学生平均获得面试邀约率较往年提升18%。数据分析、人工智能、新能源等新兴领域岗位热度持续攀升，而传统制造业的数字化改造岗位需求也呈现显著增长。\n\n热门岗位TOP5：人工智能算法工程师、数据分析师、新能源电池研发工程师、数字化运营专员、集成电路设计工程师。建议同学们关注行业动态，在系统中及时更新技能标签，以便获得更精准的岗位推送。'),
	(11, '2026-03-04 07:34:36', '系统智能推荐引擎V2.0版本升级完成', '推荐算法重磅升级，新增项目经历匹配模型，让岗位推荐更精准。', '系统公告', '技术研发部', NULL, 142, '2026-02-15 11:20:00', 25, 0, 20, 'upload/aboutus_picture3.jpg', '为提升人岗匹配精度，本系统"智能推荐引擎"已于2026年2月14日完成V2.0版本升级。新版算法不仅依据专业和成绩，更深度融入了学生的项目经历、技能证书、社团活动、竞赛获奖等多元画像维度。\n\n升级亮点包括：项目经历匹配模型、技能标签细化、企业偏好学习。请同学们务必在"我的档案"模块中详尽填写参与过的课题或实践，描述您在项目中的具体职责和成果。'),
	(12, '2026-03-04 07:34:36', '"简历优化与AI面试"精准就业指导工作坊开放预约', '就业指导中心联合各学院推出系列工作坊，首期聚焦简历与AI面试，名额有限。', '就业活动', '就业指导中心', NULL, 298, '2026-02-22 16:45:00', 41, 1, 36, 'upload/aboutus_picture1.jpg', '新学期伊始，就业指导中心将联合各学院，依托本系统的数据分析报告，开展系列"精准就业指导工作坊"。\n\n首期工作坊详情：\n主题：简历优化与AI面试实战\n时间：2026年3月5日（周四）14:00-16:30\n地点：大学生活动中心302报告厅\n主讲人：李老师（资深就业指导专家）、王经理（某大厂HR）\n\n活动名额限80人，可通过系统首页"就业活动"板块在线预约，先到先得。预约成功后，系统将自动同步至个人日程。'),
	(13, '2026-03-04 07:34:36', '合作企业HR调研：除了专业成绩，他们最看重什么？', '75%的HR经理强调"项目解决能力"和"团队协作素养"是重要录用标准。', '求职技巧', '校企合作部', NULL, 176, '2026-02-12 10:10:00', 28, 3, 22, 'upload/aboutus_picture2.jpg', '近期，就业指导中心通过本系统向合作企业发放了匿名调研问卷，共回收有效问卷152份。调研结果显示，超过75%的HR经理认为，"项目解决能力"和"团队协作素养"是除专业成绩外最重要的录用考量因素。\n\n企业最看重的软技能TOP5：问题解决与创新能力、沟通与团队协作能力、学习与适应能力、责任感与执行力、时间管理与多任务处理能力。\n\n在寻求实习机会时，请在系统中重点展示课程设计、学科竞赛或社会实践中的具体成果与个人贡献。'),
	(14, '2026-03-04 07:34:36', '关于全面启用系统"实习过程管理"模块的通知', '实习申请、签到、周志、评价全流程线上化，实习报告自动生成。', '系统公告', '教务处', NULL, 231, '2026-02-25 13:50:00', 19, 0, 31, 'upload/aboutus_picture3.jpg', '为保障2026届毕业生实习过程顺利、规范管理、有效评估，自2026年3月1日起，系统"实习管理"模块将全面启用，实习全过程实行线上化管理。\n\n模块主要功能与流程：实习申请、每日签到、周志/月报、过程检查、实习评价。\n\n重要提示：实习综合评估报告将作为学生实习成绩评定、就业推荐及优秀实习生评选的重要依据。请相关同学、校内导师、企业导师密切关注系统通知和待办事项。'),
	(15, '2026-03-04 07:34:36', '【功能指南】如何利用"生涯规划仪表盘"规划你的大学成长路径', '个性化成长视角，可视化呈现能力差距，智能推荐提升计划。', '使用指南', '学生发展中心', NULL, 165, '2026-02-10 15:30:00', 37, 0, 40, 'upload/aboutus_picture1.jpg', '"生涯规划仪表盘"是本系统为各位同学打造的个性化成长视角与规划工具。它通过直观的可视化图表，帮助您清晰认知自我，明确发展方向。\n\n核心功能包括：能力雷达图、职业兴趣探索、成长路径图、目标进度追踪。\n\n使用建议：低年级同学每学期初利用此功能进行一次全面的自我评估和目标设定，高年级同学可重点利用"能力差距分析"，针对性地查漏补缺，为求职做最后冲刺。'),
	(16, '2026-03-04 07:34:36', '致2026届毕业生：积极主动，把握春招黄金期', '系统数据显示部分同学投递活跃度较低，请善用系统功能，主动出击。', '就业提醒', '就业指导中心', NULL, 203, '2026-02-28 09:00:00', 22, 5, 18, 'upload/aboutus_picture2.jpg', '各位2026届毕业生同学：新春伊始，春招的黄金窗口期已经到来。近期数据监测发现，仍有部分同学简历完整度低于60%，或累计岗位投递次数较少。就业是双向选择的过程，积极主动是成功的关键。\n\n行动建议：完善档案、善用工具（一键海投、职位订阅、招聘会日历）、主动联系。目前系统内已汇集超过5000家企业的春招岗位，请同学们立即行动起来，为自己赢得一个光明的未来！');

-- 导出  表 springboot8d6m43dj.newstype 结构
CREATE TABLE IF NOT EXISTS `newstype` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `typename` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '分类名称',
  PRIMARY KEY (`id`),
  KEY `newstype_7d60` (`typename`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='公告资讯分类';

-- 正在导出表  springboot8d6m43dj.newstype 的数据：~8 rows (大约)
INSERT INTO `newstype` (`id`, `addtime`, `typename`) VALUES
	(9, '2026-03-04 07:31:53', '系统公告'),
	(10, '2026-03-04 07:31:53', '数据报告'),
	(11, '2026-03-04 07:31:53', '求职技巧'),
	(12, '2026-03-04 07:31:53', '就业活动'),
	(13, '2026-03-04 07:31:53', '使用指南'),
	(14, '2026-03-04 07:31:53', '就业提醒'),
	(15, '2026-03-04 07:31:53', '行业动态'),
	(16, '2026-03-04 07:31:53', '政策通知');

-- 导出  表 springboot8d6m43dj.qiye 结构
CREATE TABLE IF NOT EXISTS `qiye` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `qiyezhanghao` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '企业账号',
  `mima` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码',
  `fuzeren` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '负责人',
  `xingbie` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '性别',
  `shoujihaoma` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '手机号码',
  `touxiang` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '头像',
  `qiyemingcheng` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '企业名称',
  `sfsh` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '待审核' COMMENT '是否审核',
  `shhf` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '审核回复',
  PRIMARY KEY (`id`),
  UNIQUE KEY `qiyezhanghao` (`qiyezhanghao`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='企业';

-- 正在导出表  springboot8d6m43dj.qiye 的数据：~8 rows (大约)
INSERT INTO `qiye` (`id`, `addtime`, `qiyezhanghao`, `mima`, `fuzeren`, `xingbie`, `shoujihaoma`, `touxiang`, `qiyemingcheng`, `sfsh`, `shhf`) VALUES
	(21, '2025-04-20 14:08:14', '企业账号1', '123456', '负责人1', '男', '13823888881', 'upload/qiye_touxiang1.jpg', '企业名称1', '是', ''),
	(22, '2025-04-20 14:08:14', '企业账号2', '123456', '负责人2', '男', '13823888882', 'upload/qiye_touxiang2.jpg', '企业名称2', '是', ''),
	(23, '2025-04-20 14:08:14', '企业账号3', '123456', '负责人3', '男', '13823888883', 'upload/qiye_touxiang3.jpg', '企业名称3', '是', ''),
	(24, '2025-04-20 14:08:14', '企业账号4', '123456', '负责人4', '男', '13823888884', 'upload/qiye_touxiang4.jpg', '企业名称4', '是', ''),
	(25, '2025-04-20 14:08:14', '企业账号5', '123456', '负责人5', '男', '13823888885', 'upload/qiye_touxiang5.jpg', '企业名称5', '是', ''),
	(26, '2025-04-20 14:08:14', '企业账号6', '123456', '负责人6', '男', '13823888886', 'upload/qiye_touxiang6.jpg', '企业名称6', '是', ''),
	(27, '2025-04-20 14:08:14', '企业账号7', '123456', '负责人7', '男', '13823888887', 'upload/qiye_touxiang7.jpg', '企业名称7', '是', ''),
	(28, '2025-04-20 14:08:14', '企业账号8', '123456', '负责人8', '男', '13823888888', 'upload/qiye_touxiang8.jpg', '企业名称8', '是', '');

-- 导出  表 springboot8d6m43dj.shixigangwei 结构
CREATE TABLE IF NOT EXISTS `shixigangwei` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `qiyemingcheng` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '企业名称',
  `shiximingcheng` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '实习名称',
  `gangweileixing` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '岗位类型',
  `fengmian` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '封面',
  `shixigangwei` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '实习岗位',
  `gangweiyaoqiu` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '岗位要求',
  `xinzidaiyu` double DEFAULT NULL COMMENT '薪资待遇',
  `gongzuodidian` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '工作地点',
  `gangweijianjie` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '岗位简介',
  `qiyezhanghao` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '企业账号',
  `fuzeren` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '负责人',
  `sfsh` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '待审核' COMMENT '是否审核',
  `shhf` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '审核回复',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='实习岗位';

-- 正在导出表  springboot8d6m43dj.shixigangwei 的数据：~8 rows (大约)
INSERT INTO `shixigangwei` (`id`, `addtime`, `qiyemingcheng`, `shiximingcheng`, `gangweileixing`, `fengmian`, `shixigangwei`, `gangweiyaoqiu`, `xinzidaiyu`, `gongzuodidian`, `gangweijianjie`, `qiyezhanghao`, `fuzeren`, `sfsh`, `shhf`) VALUES
	(1, '2025-04-20 14:08:14', '企业名称1', '实习名称1', '数据分析师', 'upload/shixigangwei_fengmian1.jpg,upload/shixigangwei_fengmian2.jpg,upload/shixigangwei_fengmian3.jpg', '实习岗位1', '岗位要求1', 1, '工作地点1', '岗位简介1', '企业账号1', '负责人1', '是', ''),
	(2, '2025-04-20 14:08:14', '企业名称2', '实习名称2', '人力资源管理实习生', 'upload/shixigangwei_fengmian2.jpg,upload/shixigangwei_fengmian3.jpg,upload/shixigangwei_fengmian4.jpg', '实习岗位2', '岗位要求2', 2, '工作地点2', '岗位简介2', '企业账号2', '负责人2', '是', ''),
	(3, '2025-04-20 14:08:14', '企业名称3', '实习名称3', '市场推广专员', 'upload/shixigangwei_fengmian3.jpg,upload/shixigangwei_fengmian4.jpg,upload/shixigangwei_fengmian5.jpg', '实习岗位3', '岗位要求3', 3, '工作地点3', '岗位简介3', '企业账号3', '负责人3', '是', ''),
	(4, '2025-04-20 14:08:14', '企业名称4', '实习名称4', '数据分析师', 'upload/shixigangwei_fengmian4.jpg,upload/shixigangwei_fengmian5.jpg,upload/shixigangwei_fengmian6.jpg', '实习岗位4', '岗位要求4', 4, '工作地点4', '岗位简介4', '企业账号4', '负责人4', '是', ''),
	(5, '2025-04-20 14:08:14', '企业名称5', '实习名称5', '人力资源管理实习生', 'upload/shixigangwei_fengmian5.jpg,upload/shixigangwei_fengmian6.jpg,upload/shixigangwei_fengmian7.jpg', '实习岗位5', '岗位要求5', 5, '工作地点5', '岗位简介5', '企业账号5', '负责人5', '是', ''),
	(6, '2025-04-20 14:08:14', '企业名称6', '实习名称6', '市场推广专员', 'upload/shixigangwei_fengmian6.jpg,upload/shixigangwei_fengmian7.jpg,upload/shixigangwei_fengmian8.jpg', '实习岗位6', '岗位要求6', 6, '工作地点6', '岗位简介6', '企业账号6', '负责人6', '是', ''),
	(7, '2025-04-20 14:08:14', '企业名称7', '实习名称7', '数据分析师', 'upload/shixigangwei_fengmian7.jpg,upload/shixigangwei_fengmian8.jpg,upload/shixigangwei_fengmian1.jpg', '实习岗位7', '岗位要求7', 7, '工作地点7', '岗位简介7', '企业账号7', '负责人7', '是', ''),
	(8, '2025-04-20 14:08:14', '企业名称8', '实习名称8', '数据分析师', 'upload/shixigangwei_fengmian8.jpg,upload/shixigangwei_fengmian1.jpg,upload/shixigangwei_fengmian2.jpg', '实习岗位8', '岗位要求8', 8, '工作地点8', '岗位简介8', '企业账号8', '负责人8', '是', '');

-- 导出  表 springboot8d6m43dj.shixipingjia 结构
CREATE TABLE IF NOT EXISTS `shixipingjia` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `qiyemingcheng` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '企业名称',
  `xueshengzhanghao` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '学生账号',
  `xueshengxingming` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '学生姓名',
  `gangweileixing` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '实习岗位',
  `shixitupian` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '实习图片',
  `shixipingfen` double DEFAULT NULL COMMENT '实习评分',
  `pingjianeirong` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '评价内容',
  `pingjiashijian` datetime DEFAULT NULL COMMENT '评价时间',
  `qiyezhanghao` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '企业账号',
  `fuzeren` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '评价人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='实习评价';

-- 正在导出表  springboot8d6m43dj.shixipingjia 的数据：~8 rows (大约)
INSERT INTO `shixipingjia` (`id`, `addtime`, `qiyemingcheng`, `xueshengzhanghao`, `xueshengxingming`, `gangweileixing`, `shixitupian`, `shixipingfen`, `pingjianeirong`, `pingjiashijian`, `qiyezhanghao`, `fuzeren`) VALUES
	(1, '2025-04-20 14:08:14', '企业名称1', '学生账号1', '学生姓名1', '数据分析师', 'upload/shixipingjia_shixitupian1.jpg,upload/shixipingjia_shixitupian2.jpg,upload/shixipingjia_shixitupian3.jpg', 1, '评价内容1', '2025-04-20 22:08:14', '企业账号1', '评价人1'),
	(2, '2025-04-20 14:08:14', '企业名称2', '学生账号2', '学生姓名2', '市场推广专员', 'upload/shixipingjia_shixitupian2.jpg,upload/shixipingjia_shixitupian3.jpg,upload/shixipingjia_shixitupian4.jpg', 2, '评价内容2', '2025-04-20 22:08:14', '企业账号2', '评价人2'),
	(3, '2025-04-20 14:08:14', '企业名称3', '学生账号3', '学生姓名3', '新媒体运营', 'upload/shixipingjia_shixitupian3.jpg,upload/shixipingjia_shixitupian4.jpg,upload/shixipingjia_shixitupian5.jpg', 3, '评价内容3', '2025-04-20 22:08:14', '企业账号3', '评价人3'),
	(4, '2025-04-20 14:08:14', '企业名称4', '学生账号4', '学生姓名4', '市场推广专员', 'upload/shixipingjia_shixitupian4.jpg,upload/shixipingjia_shixitupian5.jpg,upload/shixipingjia_shixitupian6.jpg', 4, '评价内容4', '2025-04-20 22:08:14', '企业账号4', '评价人4'),
	(5, '2025-04-20 14:08:14', '企业名称5', '学生账号5', '学生姓名5', '财务会计助理', 'upload/shixipingjia_shixitupian5.jpg,upload/shixipingjia_shixitupian6.jpg,upload/shixipingjia_shixitupian7.jpg', 5, '评价内容5', '2025-04-20 22:08:14', '企业账号5', '评价人5'),
	(6, '2025-04-20 14:08:14', '企业名称6', '学生账号6', '学生姓名6', '新媒体运营', 'upload/shixipingjia_shixitupian6.jpg,upload/shixipingjia_shixitupian7.jpg,upload/shixipingjia_shixitupian8.jpg', 6, '评价内容6', '2025-04-20 22:08:14', '企业账号6', '评价人6'),
	(7, '2025-04-20 14:08:14', '企业名称7', '学生账号7', '学生姓名7', '数据分析师', 'upload/shixipingjia_shixitupian7.jpg,upload/shixipingjia_shixitupian8.jpg,upload/shixipingjia_shixitupian1.jpg', 7, '评价内容7', '2025-04-20 22:08:14', '企业账号7', '评价人7'),
	(8, '2025-04-20 14:08:14', '企业名称8', '学生账号8', '学生姓名8', '财务会计助理', 'upload/shixipingjia_shixitupian8.jpg,upload/shixipingjia_shixitupian1.jpg,upload/shixipingjia_shixitupian2.jpg', 8, '评价内容8', '2025-04-20 22:08:14', '企业账号8', '评价人8');

-- 导出  表 springboot8d6m43dj.shixiqingkuang 结构
CREATE TABLE IF NOT EXISTS `shixiqingkuang` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `qiyezhanghao` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '企业账号',
  `qiyemingcheng` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '企业名称',
  `gangweileixing` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '实习岗位',
  `gongzuodidian` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '工作地点',
  `shixitupian` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '实习图片',
  `shixibaogao` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '实习报告',
  `shixineirong` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '实习内容',
  `dengjishijian` datetime DEFAULT NULL COMMENT '登记时间',
  `xueshengzhanghao` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '学生账号',
  `xueshengxingming` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '学生姓名',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='实习情况';

-- 正在导出表  springboot8d6m43dj.shixiqingkuang 的数据：~8 rows (大约)
INSERT INTO `shixiqingkuang` (`id`, `addtime`, `qiyezhanghao`, `qiyemingcheng`, `gangweileixing`, `gongzuodidian`, `shixitupian`, `shixibaogao`, `shixineirong`, `dengjishijian`, `xueshengzhanghao`, `xueshengxingming`) VALUES
	(1, '2025-04-20 14:08:14', '企业账号1', '企业名称1', '新媒体运营', '北京', 'upload/shixiqingkuang_shixitupian1.jpg,upload/shixiqingkuang_shixitupian2.jpg,upload/shixiqingkuang_shixitupian3.jpg', '', '实习内容1', '2025-04-20 22:08:14', '学生账号1', '学生姓名1'),
	(2, '2025-04-20 14:08:14', '企业账号2', '企业名称2', '平面设计师', '上海', 'upload/shixiqingkuang_shixitupian2.jpg,upload/shixiqingkuang_shixitupian3.jpg,upload/shixiqingkuang_shixitupian4.jpg', '', '实习内容2', '2025-04-20 22:08:14', '学生账号2', '学生姓名2'),
	(3, '2025-04-20 14:08:14', '企业账号3', '企业名称3', '硬件测试工程师', '天津', 'upload/shixiqingkuang_shixitupian3.jpg,upload/shixiqingkuang_shixitupian4.jpg,upload/shixiqingkuang_shixitupian5.jpg', '', '实习内容3', '2025-04-20 22:08:14', '学生账号3', '学生姓名3'),
	(4, '2025-04-20 14:08:14', '企业账号4', '企业名称4', '数据分析师', '北京', 'upload/shixiqingkuang_shixitupian4.jpg,upload/shixiqingkuang_shixitupian5.jpg,upload/shixiqingkuang_shixitupian6.jpg', '', '实习内容4', '2025-04-20 22:08:14', '学生账号4', '学生姓名4'),
	(5, '2025-04-20 14:08:14', '企业账号5', '企业名称5', '硬件测试工程师', '杭州', 'upload/shixiqingkuang_shixitupian5.jpg,upload/shixiqingkuang_shixitupian6.jpg,upload/shixiqingkuang_shixitupian7.jpg', '', '实习内容5', '2025-04-20 22:08:14', '学生账号5', '学生姓名5'),
	(6, '2025-04-20 14:08:14', '企业账号6', '企业名称6', '新媒体运营', '上海', 'upload/shixiqingkuang_shixitupian6.jpg,upload/shixiqingkuang_shixitupian7.jpg,upload/shixiqingkuang_shixitupian8.jpg', '', '实习内容6', '2025-04-20 22:08:14', '学生账号6', '学生姓名6'),
	(7, '2025-04-20 14:08:14', '企业账号7', '企业名称7', '平面设计师', '厦门', 'upload/shixiqingkuang_shixitupian7.jpg,upload/shixiqingkuang_shixitupian8.jpg,upload/shixiqingkuang_shixitupian1.jpg', '', '实习内容7', '2025-04-20 22:08:14', '学生账号7', '学生姓名7'),
	(8, '2025-04-20 14:08:14', '企业账号8', '企业名称8', '平面设计师', '天津', 'upload/shixiqingkuang_shixitupian8.jpg,upload/shixiqingkuang_shixitupian1.jpg,upload/shixiqingkuang_shixitupian2.jpg', '', '实习内容8', '2025-04-20 22:08:14', '学生账号8', '学生姓名8');

-- 导出  表 springboot8d6m43dj.shixishenqing 结构
CREATE TABLE IF NOT EXISTS `shixishenqing` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `qiyezhanghao` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '企业账号',
  `qiyemingcheng` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '企业名称',
  `shiximingcheng` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '实习名称',
  `gangweileixing` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '岗位类型',
  `fengmian` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '封面',
  `xinzidaiyu` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '薪资待遇',
  `gongzuodidian` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '工作地点',
  `shenqingfujian` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '申请附件',
  `shenqingshijian` date DEFAULT NULL COMMENT '申请时间',
  `shenqingxiangqing` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '申请详情',
  `xueshengzhanghao` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '学生账号',
  `xueshengxingming` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '学生姓名',
  `shoujihao` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '手机号',
  `crossuserid` bigint DEFAULT NULL COMMENT '跨表用户id',
  `crossrefid` bigint DEFAULT NULL COMMENT '跨表主键id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='实习申请';

-- 正在导出表  springboot8d6m43dj.shixishenqing 的数据：~8 rows (大约)
INSERT INTO `shixishenqing` (`id`, `addtime`, `qiyezhanghao`, `qiyemingcheng`, `shiximingcheng`, `gangweileixing`, `fengmian`, `xinzidaiyu`, `gongzuodidian`, `shenqingfujian`, `shenqingshijian`, `shenqingxiangqing`, `xueshengzhanghao`, `xueshengxingming`, `shoujihao`, `crossuserid`, `crossrefid`) VALUES
	(1, '2025-04-20 14:08:14', '企业账号1', '企业名称1', '实习名称1', '财务会计助理', 'upload/shixishenqing_fengmian1.jpg,upload/shixishenqing_fengmian2.jpg,upload/shixishenqing_fengmian3.jpg', '薪资待遇1', '工作地点1', '', '2025-04-20', '申请详情1', '学生账号1', '学生姓名1', '手机号1', 1, 1),
	(2, '2025-04-20 14:08:14', '企业账号2', '企业名称2', '实习名称2', '供应链管理实习生', 'upload/shixishenqing_fengmian2.jpg,upload/shixishenqing_fengmian3.jpg,upload/shixishenqing_fengmian4.jpg', '薪资待遇2', '工作地点2', '', '2025-04-20', '申请详情2', '学生账号2', '学生姓名2', '手机号2', 2, 2),
	(3, '2025-04-20 14:08:14', '企业账号3', '企业名称3', '实习名称3', '人力资源管理实习生', 'upload/shixishenqing_fengmian3.jpg,upload/shixishenqing_fengmian4.jpg,upload/shixishenqing_fengmian5.jpg', '薪资待遇3', '工作地点3', '', '2025-04-20', '申请详情3', '学生账号3', '学生姓名3', '手机号3', 3, 3),
	(4, '2025-04-20 14:08:14', '企业账号4', '企业名称4', '实习名称4', '新媒体运营', 'upload/shixishenqing_fengmian4.jpg,upload/shixishenqing_fengmian5.jpg,upload/shixishenqing_fengmian6.jpg', '薪资待遇4', '工作地点4', '', '2025-04-20', '申请详情4', '学生账号4', '学生姓名4', '手机号4', 4, 4),
	(5, '2025-04-20 14:08:14', '企业账号5', '企业名称5', '实习名称5', '人力资源管理实习生', 'upload/shixishenqing_fengmian5.jpg,upload/shixishenqing_fengmian6.jpg,upload/shixishenqing_fengmian7.jpg', '薪资待遇5', '工作地点5', '', '2025-04-20', '申请详情5', '学生账号5', '学生姓名5', '手机号5', 5, 5),
	(6, '2025-04-20 14:08:14', '企业账号6', '企业名称6', '实习名称6', '财务会计助理', 'upload/shixishenqing_fengmian6.jpg,upload/shixishenqing_fengmian7.jpg,upload/shixishenqing_fengmian8.jpg', '薪资待遇6', '工作地点6', '', '2025-04-20', '申请详情6', '学生账号6', '学生姓名6', '手机号6', 6, 6),
	(7, '2025-04-20 14:08:14', '企业账号7', '企业名称7', '实习名称7', '新媒体运营', 'upload/shixishenqing_fengmian7.jpg,upload/shixishenqing_fengmian8.jpg,upload/shixishenqing_fengmian1.jpg', '薪资待遇7', '工作地点7', '', '2025-04-20', '申请详情7', '学生账号7', '学生姓名7', '手机号7', 7, 7),
	(8, '2025-04-20 14:08:14', '企业账号8', '企业名称8', '实习名称8', '供应链管理实习生', 'upload/shixishenqing_fengmian8.jpg,upload/shixishenqing_fengmian1.jpg,upload/shixishenqing_fengmian2.jpg', '薪资待遇8', '工作地点8', '', '2025-04-20', '申请详情8', '学生账号8', '学生姓名8', '手机号8', 8, 8);

-- 导出  表 springboot8d6m43dj.storeup 结构
CREATE TABLE IF NOT EXISTS `storeup` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `userid` bigint NOT NULL COMMENT '用户id',
  `refid` bigint DEFAULT NULL COMMENT '商品id',
  `tablename` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '表名',
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '名称',
  `picture` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '图片',
  `type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '1' COMMENT '类型',
  `inteltype` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '推荐类型',
  `remark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='收藏表';

-- 正在导出表  springboot8d6m43dj.storeup 的数据：~0 rows (大约)

-- 导出  表 springboot8d6m43dj.syslog 结构
CREATE TABLE IF NOT EXISTS `syslog` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `username` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
  `operation` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户操作',
  `method` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '请求方法',
  `params` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '请求参数',
  `time` bigint DEFAULT NULL COMMENT '请求时长(毫秒)',
  `ip` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'IP地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统日志';

-- 正在导出表  springboot8d6m43dj.syslog 的数据：~0 rows (大约)

-- 导出  表 springboot8d6m43dj.token 结构
CREATE TABLE IF NOT EXISTS `token` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `userid` bigint NOT NULL COMMENT '用户id',
  `username` varchar(100) NOT NULL COMMENT '用户名',
  `tablename` varchar(100) DEFAULT NULL COMMENT '表名',
  `role` varchar(100) DEFAULT NULL COMMENT '角色',
  `token` varchar(200) NOT NULL COMMENT '密码',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `expiratedtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '过期时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COMMENT='token表';

-- 正在导出表  springboot8d6m43dj.token 的数据：~2 rows (大约)
INSERT INTO `token` (`id`, `userid`, `username`, `tablename`, `role`, `token`, `addtime`, `expiratedtime`) VALUES
	(1, 1, 'admin', 'users', '管理员', 'a279a67yf5l5kgeedyyds5l5pukeaf4b', '2026-03-04 03:09:23', '2026-03-04 10:08:52'),
	(2, 11, '学生账号1', 'xuesheng', '学生', 'jxbnnj0vb4dggyv0nhjarr61jvfr51yv', '2026-03-04 03:29:08', '2026-03-04 10:11:37'),
	(3, 21, '企业账号1', 'qiye', '企业', 'gvjrgclrsd4n883rypji0rpdccjzzvbz', '2026-03-04 09:10:41', '2026-03-04 10:10:42');

-- 导出  表 springboot8d6m43dj.users 结构
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(100) NOT NULL COMMENT '用户名',
  `password` varchar(100) NOT NULL COMMENT '密码',
  `image` varchar(200) DEFAULT NULL COMMENT '头像',
  `role` varchar(100) DEFAULT '管理员' COMMENT '角色',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COMMENT='管理员表';

-- 正在导出表  springboot8d6m43dj.users 的数据：~1 rows (大约)
INSERT INTO `users` (`id`, `username`, `password`, `image`, `role`, `addtime`) VALUES
	(1, 'admin', 'admin', 'upload/image1.jpg', '管理员', '2025-04-20 14:08:15');

-- 导出  表 springboot8d6m43dj.xuesheng 结构
CREATE TABLE IF NOT EXISTS `xuesheng` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `xueshengzhanghao` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '学生账号',
  `mima` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码',
  `xueshengxingming` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '学生姓名',
  `xingbie` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '性别',
  `shoujihao` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '手机号',
  `touxiang` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '头像',
  PRIMARY KEY (`id`),
  UNIQUE KEY `xueshengzhanghao` (`xueshengzhanghao`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='学生';

-- 正在导出表  springboot8d6m43dj.xuesheng 的数据：~8 rows (大约)
INSERT INTO `xuesheng` (`id`, `addtime`, `xueshengzhanghao`, `mima`, `xueshengxingming`, `xingbie`, `shoujihao`, `touxiang`) VALUES
	(11, '2025-04-20 14:08:14', '学生账号1', '123456', '学生姓名1', '男', '13823888881', 'upload/xuesheng_touxiang1.jpg'),
	(12, '2025-04-20 14:08:14', '学生账号2', '123456', '学生姓名2', '男', '13823888882', 'upload/xuesheng_touxiang2.jpg'),
	(13, '2025-04-20 14:08:14', '学生账号3', '123456', '学生姓名3', '男', '13823888883', 'upload/xuesheng_touxiang3.jpg'),
	(14, '2025-04-20 14:08:14', '学生账号4', '123456', '学生姓名4', '男', '13823888884', 'upload/xuesheng_touxiang4.jpg'),
	(15, '2025-04-20 14:08:14', '学生账号5', '123456', '学生姓名5', '男', '13823888885', 'upload/xuesheng_touxiang5.jpg'),
	(16, '2025-04-20 14:08:14', '学生账号6', '123456', '学生姓名6', '男', '13823888886', 'upload/xuesheng_touxiang6.jpg'),
	(17, '2025-04-20 14:08:14', '学生账号7', '123456', '学生姓名7', '男', '13823888887', 'upload/xuesheng_touxiang7.jpg'),
	(18, '2025-04-20 14:08:14', '学生账号8', '123456', '学生姓名8', '男', '13823888888', 'upload/xuesheng_touxiang8.jpg');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
