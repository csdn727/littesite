-- MySQL dump 10.13  Distrib 5.6.12, for Win64 (x86_64)
--
-- Host: localhost    Database: littersite
-- ------------------------------------------------------
-- Server version	5.6.12-enterprise-commercial-advanced

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`,`permission_id`),
  KEY `auth_group_permissions_5f412f9a` (`group_id`),
  KEY `auth_group_permissions_83d7f98b` (`permission_id`),
  CONSTRAINT `group_id_refs_id_f4b32aac` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `permission_id_refs_id_6ba0f519` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_type_id` (`content_type_id`,`codename`),
  KEY `auth_permission_37ef4eb4` (`content_type_id`),
  CONSTRAINT `content_type_id_refs_id_d043b34a` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add permission',1,'add_permission'),(2,'Can change permission',1,'change_permission'),(3,'Can delete permission',1,'delete_permission'),(4,'Can add group',2,'add_group'),(5,'Can change group',2,'change_group'),(6,'Can delete group',2,'delete_group'),(7,'Can add user',3,'add_user'),(8,'Can change user',3,'change_user'),(9,'Can delete user',3,'delete_user'),(10,'Can add content type',4,'add_contenttype'),(11,'Can change content type',4,'change_contenttype'),(12,'Can delete content type',4,'delete_contenttype'),(13,'Can add session',5,'add_session'),(14,'Can change session',5,'change_session'),(15,'Can delete session',5,'delete_session'),(16,'Can add site',6,'add_site'),(17,'Can change site',6,'change_site'),(18,'Can delete site',6,'delete_site'),(19,'Can add log entry',7,'add_logentry'),(20,'Can change log entry',7,'change_logentry'),(21,'Can delete log entry',7,'delete_logentry'),(22,'Can add class_info',8,'add_class_info'),(23,'Can change class_info',8,'change_class_info'),(24,'Can delete class_info',8,'delete_class_info'),(25,'Can add class_reg',9,'add_class_reg'),(26,'Can change class_reg',9,'change_class_reg'),(27,'Can delete class_reg',9,'delete_class_reg'),(28,'Can add user_info',10,'add_user_info'),(29,'Can change user_info',10,'change_user_info'),(30,'Can delete user_info',10,'delete_user_info'),(31,'Can add class_reg',11,'add_class_reg'),(32,'Can change class_reg',11,'change_class_reg'),(33,'Can delete class_reg',11,'delete_class_reg');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime NOT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(75) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$10000$jEVVuJAE3w2w$4SFmHdjgCtVpPzJJ1OdH9cymGLqfgXYsLRYBnH5Phg0=','2014-05-04 02:45:05',1,'admin','','','',0,1,'2014-05-04 02:45:05'),(2,'pbkdf2_sha256$10000$vlJJNqbd8a0w$GRwFnoP8mhsWjZ56TBE3W5/P0zPkLjVra+tITemWebg=','2014-05-09 18:11:24',1,'root','','','root@aaa.com',1,1,'2014-05-09 13:29:14');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`group_id`),
  KEY `auth_user_groups_6340c63c` (`user_id`),
  KEY `auth_user_groups_5f412f9a` (`group_id`),
  CONSTRAINT `group_id_refs_id_274b862c` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `user_id_refs_id_40c41112` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`permission_id`),
  KEY `auth_user_user_permissions_6340c63c` (`user_id`),
  KEY `auth_user_user_permissions_83d7f98b` (`permission_id`),
  CONSTRAINT `permission_id_refs_id_35d9ac25` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `user_id_refs_id_4dc23c39` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `class_info`
--

DROP TABLE IF EXISTS `class_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `class_info` (
  `classId` int(11) NOT NULL AUTO_INCREMENT,
  `className` varchar(50) NOT NULL,
  `classDesc` varchar(200) NOT NULL,
  `classMax` int(11) NOT NULL,
  `classPoint` decimal(11,1) NOT NULL,
  `classStart` datetime NOT NULL,
  `classTimes` int(11) NOT NULL,
  `classT` varchar(20) NOT NULL,
  PRIMARY KEY (`classId`),
  UNIQUE KEY `className` (`className`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `class_info`
--

LOCK TABLES `class_info` WRITE;
/*!40000 ALTER TABLE `class_info` DISABLE KEYS */;
INSERT INTO `class_info` VALUES (1,'奥尔夫音乐课 ','奥尔夫音乐教育体系是由20世纪德国著名音乐教育家、作曲家卡尔.奥尔夫（Karl Orff 1898-1982）所创，它以其原本性、综合性、即兴性的音乐教育理念，被誉为世界三大音乐教育体系之一。最初的创设是为了培养儿童的创造性思维能力，现在广泛应用于基础音乐教育、高等音乐教育、社区活动、音乐治疗等各个领域 ',20,2.0,'2014-05-08 22:23:36',5,'奥尔良'),(2,'博弈论','本课程通过案例教学向学生们介绍了博弈论的基本概念，在着重讲解博弈论在经济学中的应用的同时也涉及了与博弈论相关的多个领域，如法律、国际关系、社会学等等，拓宽了学生的眼界和思维。通过非技术性的手段（非数学手段）说明了如何运用博弈论的知识来看待和解决经济、管理和社会问题。',22,1.5,'2014-04-09 22:46:19',10,'孔明'),(3,'财经应用文写作','应用文写作是一门实用性强的专业写作课程。本门课程的教学目的，是使学生系统掌握常用的商务应用类文章的实际用途及其写作要领，获取高级应用型人材所必备的文案写作能力和分析处理能力，使学生的实际写作水平得到一定程度的提高，从而在今后工作中能解决商务活动中的实际问题。',15,2.0,'2014-05-21 22:47:18',7,'福布斯'),(4,'裁判理论与实践（1）','裁判理论与实践课程内容主要涵盖田径、足球、排球、篮球、乒乓球、羽毛球等项目。根据每学期学院竞赛安排，选取2-3个项目进行重点学习。本课程主要学习这些运动项目的比赛规则、裁判的基本手势与术语；通过具体的比赛录像分析与理论讲解，教会学生灵活掌握规则，如何判别犯规与违例，以及如何进行判罚。',20,1.6,'2014-05-15 22:50:16',6,'姚明'),(5,'传统体育养身学','中国传统养生学以传统哲学为理论指导，综合运用中医的理论与方法，采用行气、服食、药饵、房中等具体手段，通过提高自身健康水平、发展身体自我调节能力、提高生命和生存质量等途径达到延年益寿的功效。传统养生是在传统养生学指导下，进行的预防疾病、养护生命、延年益寿的实践活动。',20,1.0,'2014-04-29 22:51:09',8,'詹姆斯'),(6,'红楼万象','《红楼梦》是曹雪芹用中文里中最绚烂的语言构筑成的一个开放性文本世界。它就像是一个原始丛林，小说里面人性的参差多太，人物关系的明暗错综，作品里所包含的对中国传统文化的扬弃之态度，作者的叙事技巧、与其所用的各种文学形式，可谓尽态极妍，莫可名状。说《红楼梦》是中国古代社会生活与传统文化的百科全书毫不过分，读此书可以帮你识人省己。',20,3.0,'2014-05-11 22:51:46',9,'百晓生'),(7,'的说法','恩恩',33,3.0,'2013-05-06 16:00:00',2,'发大水');
/*!40000 ALTER TABLE `class_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `class_reg`
--

DROP TABLE IF EXISTS `class_reg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `class_reg` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `classId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `userName` varchar(50) NOT NULL,
  `className` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `class_reg`
--

LOCK TABLES `class_reg` WRITE;
/*!40000 ALTER TABLE `class_reg` DISABLE KEYS */;
INSERT INTO `class_reg` VALUES (56,1,1,'张明','奥尔夫音乐课 '),(57,1,2,'李强','奥尔夫音乐课'),(58,1,4,'王武','奥尔夫音乐课'),(59,1,23,'张鑫','奥尔夫音乐课'),(60,1,12,'赵娜','奥尔夫音乐课'),(61,1,11,'顾美可','奥尔夫音乐课');
/*!40000 ALTER TABLE `class_reg` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_6340c63c` (`user_id`),
  KEY `django_admin_log_37ef4eb4` (`content_type_id`),
  CONSTRAINT `content_type_id_refs_id_93d2d1f8` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `user_id_refs_id_c0d12874` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_label` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'permission','auth','permission'),(2,'group','auth','group'),(3,'user','auth','user'),(4,'content type','contenttypes','contenttype'),(5,'session','sessions','session'),(6,'site','sites','site'),(7,'log entry','admin','logentry'),(8,'class_info','classinfo','class_info'),(9,'class_reg','classreg','class_reg'),(10,'user_info','userinfo','user_info'),(11,'class_reg','classinfo','class_reg');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_b7b81f0c` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('00dm5h1z915tinan4xx9plodahyold6t','ZTUzNjc5MmIyN2ZjYTMzZGM5ZjJjMGU2MGIyNzFiZjYyMjFiMjA0ZjqAAn1xAShVDV9hdXRoX3VzZXJfaWSKAQJVEl9hdXRoX3VzZXJfYmFja2VuZFUpZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmRVBHVzZXJxAmNjb3B5X3JlZwpfcmVjb25zdHJ1Y3RvcgpxA2N1c2VyaW5mby5tb2RlbHMKdXNlcl9pbmZvCnEEY19fYnVpbHRpbl9fCm9iamVjdApxBU6HUnEGfXEHKFUIdXNlck5hbWVxCFgBAAAAMlUGdXNlcklkcQmKAQdVBl9zdGF0ZXEKY2RqYW5nby5kYi5tb2RlbHMuYmFzZQpNb2RlbFN0YXRlCnELKYFxDH1xDShVBmFkZGluZ3EOiVUCZGJxD1UHZGVmYXVsdHEQdWJVB3VzZXJQc2RxEVgBAAAAMlUIdXNlclR5cGVxEooBAXVidS4=','2014-05-23 18:19:28'),('h3jlzj8t5m92i95aapfniuke4woz811a','OTA2OTgyNmZlMGE5ZjY1ZjkwOGQ1OWJlNmQ3ODEyZjM3NjBkOTY0MjqAAn1xAVUEdXNlcmNjb3B5X3JlZwpfcmVjb25zdHJ1Y3RvcgpxAmN1c2VyaW5mby5tb2RlbHMKdXNlcl9pbmZvCnEDY19fYnVpbHRpbl9fCm9iamVjdApxBE6HUnEFfXEGKFUIdXNlck5hbWVxB1gBAAAAMlUGdXNlcklkcQiKAQdVBl9zdGF0ZXEJY2RqYW5nby5kYi5tb2RlbHMuYmFzZQpNb2RlbFN0YXRlCnEKKYFxC31xDChVBmFkZGluZ3ENiVUCZGJxDlUHZGVmYXVsdHEPdWJVB3VzZXJQc2RxEFgBAAAAMlUIdXNlclR5cGVxEYoBAXVicy4=','2014-02-19 16:18:00'),('hj1n2hgsfibldv54wprrmy8t84vkh7hl','OTA2OTgyNmZlMGE5ZjY1ZjkwOGQ1OWJlNmQ3ODEyZjM3NjBkOTY0MjqAAn1xAVUEdXNlcmNjb3B5X3JlZwpfcmVjb25zdHJ1Y3RvcgpxAmN1c2VyaW5mby5tb2RlbHMKdXNlcl9pbmZvCnEDY19fYnVpbHRpbl9fCm9iamVjdApxBE6HUnEFfXEGKFUIdXNlck5hbWVxB1gBAAAAMlUGdXNlcklkcQiKAQdVBl9zdGF0ZXEJY2RqYW5nby5kYi5tb2RlbHMuYmFzZQpNb2RlbFN0YXRlCnEKKYFxC31xDChVBmFkZGluZ3ENiVUCZGJxDlUHZGVmYXVsdHEPdWJVB3VzZXJQc2RxEFgBAAAAMlUIdXNlclR5cGVxEYoBAXVicy4=','2014-02-19 15:12:18'),('lu8qoopsa6efk41wzfrhe9ko9wu1t8n2','MWViYThiZTRkYzE1OTk0NWM4MGIzY2QzZDM2YjQzZjdmOTkzNzEwODqAAn1xAVUEdXNlcnECY2NvcHlfcmVnCl9yZWNvbnN0cnVjdG9yCnEDY3VzZXJpbmZvLm1vZGVscwp1c2VyX2luZm8KcQRjX19idWlsdGluX18Kb2JqZWN0CnEFTodScQZ9cQcoVQh1c2VyTmFtZXEIWAEAAAAyVQZ1c2VySWRxCYoBB1UGX3N0YXRlcQpjZGphbmdvLmRiLm1vZGVscy5iYXNlCk1vZGVsU3RhdGUKcQspgXEMfXENKFUGYWRkaW5ncQ6JVQJkYnEPVQdkZWZhdWx0cRB1YlUHdXNlclBzZHERWAEAAAAyVQh1c2VyVHlwZXESigEBdWJzLg==','2014-05-17 02:23:45'),('w9mwqns0hwrnpdtt951lvnxom3o0cnm4','ZTM3MGJlMTYxNDI0ZDkxNTkyZmNkNGVmNjRkZmJmYmZjYjQ2OWFkMTqAAn1xAShYCgAAAHRlc3Rjb29raWVYBgAAAHdvcmtlZHECVQR1c2VyY2NvcHlfcmVnCl9yZWNvbnN0cnVjdG9yCnEDY3VzZXJpbmZvLm1vZGVscwp1c2VyX2luZm8KcQRjX19idWlsdGluX18Kb2JqZWN0CnEFTodScQZ9cQcoVQh1c2VyTmFtZXEIWAEAAABxVQZ1c2VySWRxCYoBCVUGX3N0YXRlcQpjZGphbmdvLmRiLm1vZGVscy5iYXNlCk1vZGVsU3RhdGUKcQspgXEMfXENKFUGYWRkaW5ncQ6JVQJkYnEPVQdkZWZhdWx0dWJVB3VzZXJQc2RxEFgBAAAAcVUIdXNlclR5cGVxEYoBA3VidS4=','2014-05-18 04:02:46');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_site`
--

DROP TABLE IF EXISTS `django_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_site` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_site`
--

LOCK TABLES `django_site` WRITE;
/*!40000 ALTER TABLE `django_site` DISABLE KEYS */;
INSERT INTO `django_site` VALUES (1,'example.com','example.com');
/*!40000 ALTER TABLE `django_site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_info`
--

DROP TABLE IF EXISTS `user_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_info` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `userName` varchar(50) NOT NULL,
  `userPsd` varchar(20) NOT NULL,
  `userType` int(11) NOT NULL,
  PRIMARY KEY (`userId`),
  UNIQUE KEY `userName` (`userName`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_info`
--

LOCK TABLES `user_info` WRITE;
/*!40000 ALTER TABLE `user_info` DISABLE KEYS */;
INSERT INTO `user_info` VALUES (1,'3','3',1),(2,'1','2',1),(7,'2','2',1),(8,'t','t',2),(9,'q','q',3),(10,'h','h',3),(14,'w','w',3),(15,'e','e',3),(16,'a','a',2),(20,'f','f',1),(21,'c','c',1),(22,'n','n',1),(24,'m','m',1),(25,'nn','nn',1),(26,'bb','bb',1),(27,'dfg','dfg',1),(28,'vv','vv',1),(29,'GGGG','2',1),(30,'GFDGDFG','2',1),(31,'DSADASXZ','2',1),(32,'SDFXCV','2',1),(33,'SDFXCVHGFH','',1),(35,'2YIHGNBV','2',1),(36,'2DSFSD','2',1),(37,'','',2),(42,'bdf','',2);
/*!40000 ALTER TABLE `user_info` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-06-02 11:51:07
