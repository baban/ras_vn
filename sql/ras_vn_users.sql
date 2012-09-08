-- MySQL dump 10.11
--
-- Host: localhost    Database: ras_vn_dev
-- ------------------------------------------------------
-- Server version	5.0.95

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
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL auto_increment,
  `email` varchar(255) collate utf8_unicode_ci NOT NULL default '',
  `encrypted_password` varchar(255) collate utf8_unicode_ci NOT NULL default '',
  `reset_password_token` varchar(255) collate utf8_unicode_ci default NULL,
  `reset_password_sent_at` datetime default NULL,
  `remember_created_at` datetime default NULL,
  `sign_in_count` int(11) default '0',
  `current_sign_in_at` datetime default NULL,
  `last_sign_in_at` datetime default NULL,
  `current_sign_in_ip` varchar(255) collate utf8_unicode_ci default NULL,
  `last_sign_in_ip` varchar(255) collate utf8_unicode_ci default NULL,
  `omniuser_id` int(11) default NULL,
  `confirmation_token` varchar(255) collate utf8_unicode_ci default NULL,
  `confirmed_at` datetime default NULL,
  `confirmation_sent_at` datetime default NULL,
  `unconfirmed_email` varchar(255) collate utf8_unicode_ci default NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `index_users_on_email` (`email`),
  UNIQUE KEY `index_users_on_reset_password_token` (`reset_password_token`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'babanba.n@gmail.com','$2a$10$SG0zqyARBSWAM6FRL5uo6OnPSBPUWi24IA3ir0lWxvIv7RGVUnqZ6',NULL,NULL,NULL,3,'2012-07-08 14:42:38','2012-07-08 07:02:36','127.0.0.1','127.0.0.1',NULL,'ftvk4eizqxjpuVsqhTee','2012-07-09 17:00:33','2012-07-02 15:55:50',NULL,'2012-07-02 15:55:50','2012-07-09 17:00:33'),(2,'1@test.jp','$2a$10$IbUu9y4oTZObacdTQhBwHOe49FfWb3kUAZNSIiCzgPxgwqqM56Uhq',NULL,NULL,NULL,1,'2012-06-05 00:24:47','2012-06-05 00:24:47','127.0.0.1','127.0.0.1',2012,'2012-06-05 00:24:47','2012-07-09 17:00:33',NULL,NULL,'0000-00-00 00:00:00','2012-07-09 17:00:33'),(3,'2@test.jp','$2a$10$HeUwWIYyBhoXc3IGdaWsteBDQyNPu1ACLDJrE1rsbtaLrrsw..t1W',NULL,NULL,NULL,1,'2012-06-05 00:25:09','2012-06-05 00:25:09','127.0.0.1','127.0.0.1',2012,'2012-06-05 00:25:09','2012-07-09 17:00:33',NULL,NULL,'0000-00-00 00:00:00','2012-07-09 17:00:33'),(4,'3@test.jp','$2a$10$4wQ/u6hpjgfauItR8mkgM.2zTIQGEhwV/ftPlnlyv0IES7H2SUq0u',NULL,NULL,NULL,1,'2012-06-05 00:25:30','2012-06-05 00:25:30','127.0.0.1','127.0.0.1',2012,'2012-06-05 00:25:30','2012-07-09 17:00:33',NULL,NULL,'0000-00-00 00:00:00','2012-07-09 17:00:33'),(5,'4@test.jp','$2a$10$eLPfr2j418KWTRtgTIdsbOlH.Fem4E.Tj2ROwORtPUq2yvg3lERUO',NULL,NULL,NULL,1,'2012-06-05 00:25:49','2012-06-05 00:25:49','127.0.0.1','127.0.0.1',2012,'2012-06-05 00:25:49','2012-07-09 17:00:33',NULL,NULL,'0000-00-00 00:00:00','2012-07-09 17:00:33'),(6,'5@test.jp','$2a$10$TJWRQanfpLUTfPrLdY3doudhLxI.81V/lRXgh.trW6UvJekfXKBFq',NULL,NULL,NULL,1,'2012-06-05 00:27:17','2012-06-05 00:27:17','127.0.0.1','127.0.0.1',2012,'2012-06-05 00:27:17','2012-07-09 17:00:33',NULL,NULL,'0000-00-00 00:00:00','2012-07-09 17:00:33'),(7,'6@test.jp','$2a$10$gw0nDAHGJ2m4FCMyXynTRuA2l24SsQpqwrfh/yhS6S2IKukmdT/BG',NULL,NULL,NULL,1,'2012-06-05 00:27:35','2012-06-05 00:27:35','127.0.0.1','127.0.0.1',2012,'2012-06-05 00:27:35','2012-07-09 17:00:33',NULL,NULL,'0000-00-00 00:00:00','2012-07-09 17:00:33'),(8,'7@test.jp','$2a$10$nOLdqofa/vN43UVbz32JNeSo1JSxN07a7QzX3qPCIb9rXUc5R8zKm',NULL,NULL,NULL,1,'2012-06-05 00:28:03','2012-06-05 00:28:03','127.0.0.1','127.0.0.1',2012,'2012-06-05 00:28:03','2012-07-09 17:00:33',NULL,NULL,'0000-00-00 00:00:00','2012-07-09 17:00:33'),(9,'8@test.jp','$2a$10$DM4JGN5kos09M80dIG.qZeG/yf6Plz5U.hxH.uLeFBdyE1qIenK72',NULL,NULL,NULL,1,'2012-06-05 00:28:24','2012-06-05 00:28:24','127.0.0.1','127.0.0.1',2012,'2012-06-05 00:28:24','2012-07-09 17:00:33',NULL,NULL,'0000-00-00 00:00:00','2012-07-09 17:00:33'),(10,'9@test.jp','$2a$10$fRG1ITFJQeDCr2xRqETvAeVj0GynYl0ug933/L198CkEXRDPYSQLS',NULL,NULL,NULL,1,'2012-06-05 00:28:38','2012-06-05 00:28:38','127.0.0.1','127.0.0.1',2012,'2012-06-05 00:28:38','2012-07-09 17:00:33',NULL,NULL,'0000-00-00 00:00:00','2012-07-09 17:00:33'),(11,'10@test.jp','$2a$10$Uvy7sPNLIflcxrHQC3r3IeFCgOFsI63IQdwvZtZVqvKM677EoTNDW',NULL,NULL,NULL,1,'2012-06-05 00:29:05','2012-06-05 00:29:05','127.0.0.1','127.0.0.1',2012,'2012-06-05 00:29:05','2012-07-09 17:00:33',NULL,NULL,'0000-00-00 00:00:00','2012-07-09 17:00:33'),(12,'11@test.jp','$2a$10$JyZDP4eQKVbU1c.id8EVjeNt2rx4Ja7nDCHPkZRxXUjZ7XpUv3d5O',NULL,NULL,NULL,1,'2012-06-05 12:19:45','2012-06-05 12:19:45','127.0.0.1','127.0.0.1',2012,'2012-06-05 12:19:45','2012-07-09 17:00:33',NULL,NULL,'0000-00-00 00:00:00','2012-07-09 17:00:33'),(13,'12@test.jp','$2a$10$DgaxP/pLSCfusLa7rkeva.JinAyTz.7IFrnoK4lNwsmhYrkhlxcJ6',NULL,NULL,NULL,1,'2012-06-05 12:20:03','2012-06-05 12:20:03','127.0.0.1','127.0.0.1',2012,'2012-06-05 12:20:03','2012-07-09 17:00:33',NULL,NULL,'0000-00-00 00:00:00','2012-07-09 17:00:33'),(14,'13@test.jp','$2a$10$5I215esVdz5Rk7XFfEAshOJCUhOeIBabRzsvIerphiMvXwkCooY1e',NULL,NULL,NULL,1,'2012-06-05 12:20:19','2012-06-05 12:20:19','127.0.0.1','127.0.0.1',2012,'2012-06-05 12:20:19','2012-07-09 17:00:33',NULL,NULL,'0000-00-00 00:00:00','2012-07-09 17:00:33'),(15,'14@test.jp','$2a$10$nw5UlnIIAwt0yjrNqZRIx.I8TWLmAvojQ8M50TruTLP5X9ZJoMOYO',NULL,NULL,NULL,1,'2012-06-05 12:20:38','2012-06-05 12:20:38','127.0.0.1','127.0.0.1',2012,'2012-06-05 12:20:38','2012-07-09 17:00:33',NULL,NULL,'0000-00-00 00:00:00','2012-07-09 17:00:33'),(16,'15@test.jp','$2a$10$Emds607SK8Nqy/GHGhQc3.rxIxi5RuUcbA8T.niDASYH.otqB2NLq',NULL,NULL,NULL,1,'2012-06-05 12:20:55','2012-06-05 12:20:55','127.0.0.1','127.0.0.1',2012,'2012-06-05 12:20:55','2012-07-09 17:00:33',NULL,NULL,'0000-00-00 00:00:00','2012-07-09 17:00:33'),(17,'16@test.jp','$2a$10$KTYk/gT9Q3hPh9JsB8lLIuqhmytvlcE4Loj.aOSZ..tKBmA5Wy47m',NULL,NULL,NULL,1,'2012-06-05 12:21:10','2012-06-05 12:21:10','127.0.0.1','127.0.0.1',2012,'2012-06-05 12:21:10','2012-07-09 17:00:33',NULL,NULL,'0000-00-00 00:00:00','2012-07-09 17:00:33'),(18,'17@test.jp','$2a$10$CE5/1Vh.sOYhU.FfVmMuKOMRHs8eSVaEkR6Rkc6T.7Wvzp/LTOB4O',NULL,NULL,NULL,1,'2012-06-05 12:21:25','2012-06-05 12:21:25','127.0.0.1','127.0.0.1',2012,'2012-06-05 12:21:25','2012-07-09 17:00:33',NULL,NULL,'0000-00-00 00:00:00','2012-07-09 17:00:33'),(19,'18@test.jp','$2a$10$tVi2AOmf3R/5sOQ1QEooKu7tkP8OrboWeibdIXT2njJU3Im20X0yW',NULL,NULL,NULL,1,'2012-06-05 12:21:39','2012-06-05 12:21:39','127.0.0.1','127.0.0.1',2012,'2012-06-05 12:21:39','2012-07-09 17:00:33',NULL,NULL,'0000-00-00 00:00:00','2012-07-09 17:00:33'),(20,'19@test.jp','$2a$10$gF4S79NeOlDt9YRt.ajPUO92i9p6JVSWRGqQppkiSFHixc32s5GcK',NULL,NULL,NULL,1,'2012-06-05 12:21:55','2012-06-05 12:21:55','127.0.0.1','127.0.0.1',2012,'2012-06-05 12:21:55','2012-07-09 17:00:33',NULL,NULL,'0000-00-00 00:00:00','2012-07-09 17:00:33'),(21,'20@test.jp','$2a$10$2/SD3u6NuO6vtmx3hcT7WOSRuG30yOLUziyoZsjnIG7xHSM6kTO3G',NULL,NULL,NULL,1,'2012-06-05 12:22:12','2012-06-05 12:22:12','127.0.0.1','127.0.0.1',2012,'2012-06-05 12:22:12','2012-07-09 17:00:33',NULL,NULL,'0000-00-00 00:00:00','2012-07-09 17:00:33');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_users`
--

DROP TABLE IF EXISTS `admin_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_users` (
  `id` int(11) NOT NULL auto_increment,
  `first_name` varchar(255) NOT NULL default '',
  `last_name` varchar(255) NOT NULL default '',
  `role` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `status` tinyint(1) default '0',
  `token` varchar(255) NOT NULL,
  `salt` varchar(255) NOT NULL,
  `crypted_password` varchar(255) NOT NULL,
  `preferences` varchar(255) default NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `index_admin_users_on_email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_users`
--

LOCK TABLES `admin_users` WRITE;
/*!40000 ALTER TABLE `admin_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `admin_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_profiles`
--

DROP TABLE IF EXISTS `user_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_profiles` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) default NULL,
  `image` varchar(255) default NULL,
  `nickname` varchar(255) NOT NULL default '',
  `sex` int(11) default NULL,
  `first_name` varchar(255) default '',
  `family_name` varchar(255) default '',
  `birthday` date default NULL,
  `email` varchar(255) default NULL,
  `prefecture_id` int(11) NOT NULL default '1',
  `distinct_id` int(11) NOT NULL default '1',
  `comment` text NOT NULL,
  `recipe_count` int(11) NOT NULL default '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `index_user_profiles_on_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_profiles`
--

LOCK TABLES `user_profiles` WRITE;
/*!40000 ALTER TABLE `user_profiles` DISABLE KEYS */;
INSERT INTO `user_profiles` VALUES (1,1,'368710_100002130858178_1160751390_n.jpg','baban',1,'','',NULL,NULL,0,0,'',0,'2012-05-12 15:27:00','2012-06-24 09:05:59'),(2,2,NULL,'ma2003co',1,'','',NULL,NULL,0,0,'',0,'2012-05-12 15:27:00','2012-05-12 15:27:00'),(3,3,NULL,'じゅんばあ',1,'','',NULL,NULL,0,0,'',0,'2012-05-12 15:27:00','2012-05-12 15:27:00'),(4,4,NULL,'春茶丸',1,'','',NULL,NULL,0,0,'',0,'2012-05-12 15:27:00','2012-05-12 15:27:00'),(5,5,NULL,'kajinのだんな',1,'','',NULL,NULL,0,0,'',0,'2012-05-12 15:27:00','2012-05-12 15:27:00'),(6,6,NULL,'☆まきりん☆',1,'','',NULL,NULL,0,0,'',0,'2012-05-12 15:27:00','2012-05-12 15:27:00'),(7,7,NULL,'うまかっぺ ',1,'','',NULL,NULL,0,0,'',0,'2012-05-12 15:27:00','2012-05-12 15:27:00'),(8,8,NULL,'makoron',1,'','',NULL,NULL,0,0,'',0,'2012-05-12 15:27:00','2012-05-12 15:27:00'),(9,9,NULL,'FarmersK',1,'','',NULL,NULL,0,0,'',0,'2012-05-12 15:27:00','2012-05-12 15:27:00'),(10,10,NULL,'てんちょー',1,'','',NULL,NULL,0,0,'',0,'2012-05-12 15:27:00','2012-05-12 15:27:00'),(11,11,NULL,'komomoもも',1,'','',NULL,NULL,0,0,'',0,'2012-05-12 15:27:00','2012-05-12 15:27:00'),(12,12,NULL,'tinkpi',1,'','',NULL,NULL,0,0,'',0,'2012-05-12 15:27:00','2012-05-12 15:27:00'),(13,13,NULL,'JessieMom',1,'','',NULL,NULL,0,0,'',0,'2012-05-12 15:27:00','2012-05-12 15:27:00'),(14,14,NULL,'☆RUN☆',1,'','',NULL,NULL,0,0,'',0,'2012-05-12 15:27:00','2012-05-12 15:27:00'),(15,15,NULL,'usakohime',1,'','',NULL,NULL,0,0,'',0,'2012-05-12 15:27:00','2012-05-12 15:27:00'),(16,16,NULL,'スマイルメグ',1,'','',NULL,NULL,0,0,'',0,'2012-05-12 15:27:00','2012-05-12 15:27:00'),(17,17,NULL,'みーみーさんさん',1,'','',NULL,NULL,0,0,'',0,'2012-05-12 15:27:00','2012-05-12 15:27:00'),(18,18,NULL,'Keit3',1,'','',NULL,NULL,0,0,'',0,'2012-05-12 15:27:00','2012-05-12 15:27:00'),(19,19,NULL,'ゆみらい♪',1,'','',NULL,NULL,0,0,'',0,'2012-05-12 15:27:00','2012-05-12 15:27:00');
/*!40000 ALTER TABLE `user_profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_profile_visibilities`
--

DROP TABLE IF EXISTS `user_profile_visibilities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_profile_visibilities` (
  `id` int(11) NOT NULL auto_increment,
  `user_profile_id` int(11) default '1',
  `nickname` tinyint(1) NOT NULL default '1',
  `sex` tinyint(1) NOT NULL default '1',
  `first_name` tinyint(1) default '1',
  `family_name` tinyint(1) default '1',
  `blood_type` tinyint(1) NOT NULL default '1',
  `birthday` tinyint(1) NOT NULL default '1',
  `email` tinyint(1) NOT NULL default '1',
  `postcode` tinyint(1) NOT NULL default '1',
  `address` tinyint(1) NOT NULL default '1',
  `address_point` tinyint(1) NOT NULL default '1',
  `comment` tinyint(1) NOT NULL default '1',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `index_user_profile_visibilities_on_user_profile_id` (`user_profile_id`)
) ENGINE=InnoDB AUTO_INCREMENT=248 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_profile_visibilities`
--

LOCK TABLES `user_profile_visibilities` WRITE;
/*!40000 ALTER TABLE `user_profile_visibilities` DISABLE KEYS */;
INSERT INTO `user_profile_visibilities` VALUES (1,1,1,1,1,1,1,1,1,1,1,1,1,'2012-06-18 15:16:43','2012-06-18 15:16:43'),(2,2,1,1,1,1,1,1,1,1,1,1,1,'2012-06-18 15:16:43','2012-06-18 15:16:43'),(3,3,1,1,1,1,1,1,1,1,1,1,1,'2012-06-18 15:16:43','2012-06-18 15:16:43'),(4,4,1,1,1,1,1,1,1,1,1,1,1,'2012-06-18 15:16:43','2012-06-18 15:16:43'),(5,5,1,1,1,1,1,1,1,1,1,1,1,'2012-06-18 15:16:43','2012-06-18 15:16:43'),(6,6,1,1,1,1,1,1,1,1,1,1,1,'2012-06-18 15:16:43','2012-06-18 15:16:43'),(7,7,1,1,1,1,1,1,1,1,1,1,1,'2012-06-18 15:16:43','2012-06-18 15:16:43'),(8,8,1,1,1,1,1,1,1,1,1,1,1,'2012-06-18 15:16:43','2012-06-18 15:16:43'),(9,9,1,1,1,1,1,1,1,1,1,1,1,'2012-06-18 15:16:43','2012-06-18 15:16:43'),(10,10,1,1,1,1,1,1,1,1,1,1,1,'2012-06-18 15:16:43','2012-06-18 15:16:43'),(11,11,1,1,1,1,1,1,1,1,1,1,1,'2012-06-18 15:16:43','2012-06-18 15:16:43'),(12,12,1,1,1,1,1,1,1,1,1,1,1,'2012-06-18 15:16:43','2012-06-18 15:16:43'),(13,13,1,1,1,1,1,1,1,1,1,1,1,'2012-06-18 15:16:43','2012-06-18 15:16:43'),(14,14,1,1,1,1,1,1,1,1,1,1,1,'2012-06-18 15:16:43','2012-06-18 15:16:43'),(15,15,1,1,1,1,1,1,1,1,1,1,1,'2012-06-18 15:16:43','2012-06-18 15:16:43'),(16,16,1,1,1,1,1,1,1,1,1,1,1,'2012-06-18 15:16:43','2012-06-18 15:16:43'),(17,17,1,1,1,1,1,1,1,1,1,1,1,'2012-06-18 15:16:43','2012-06-18 15:16:43'),(18,18,1,1,1,1,1,1,1,1,1,1,1,'2012-06-18 15:16:43','2012-06-18 15:16:43'),(19,19,1,1,1,1,1,1,1,1,1,1,1,'2012-06-18 15:16:43','2012-06-18 15:16:43'),(20,1,1,1,1,1,1,1,1,1,1,1,1,'2012-06-25 15:55:05','2012-06-25 15:55:05'),(21,2,1,1,1,1,1,1,1,1,1,1,1,'2012-06-25 15:55:05','2012-06-25 15:55:05'),(22,3,1,1,1,1,1,1,1,1,1,1,1,'2012-06-25 15:55:05','2012-06-25 15:55:05'),(23,4,1,1,1,1,1,1,1,1,1,1,1,'2012-06-25 15:55:05','2012-06-25 15:55:05'),(24,5,1,1,1,1,1,1,1,1,1,1,1,'2012-06-25 15:55:05','2012-06-25 15:55:05'),(25,6,1,1,1,1,1,1,1,1,1,1,1,'2012-06-25 15:55:05','2012-06-25 15:55:05'),(26,7,1,1,1,1,1,1,1,1,1,1,1,'2012-06-25 15:55:05','2012-06-25 15:55:05'),(27,8,1,1,1,1,1,1,1,1,1,1,1,'2012-06-25 15:55:05','2012-06-25 15:55:05'),(28,9,1,1,1,1,1,1,1,1,1,1,1,'2012-06-25 15:55:05','2012-06-25 15:55:05'),(29,10,1,1,1,1,1,1,1,1,1,1,1,'2012-06-25 15:55:05','2012-06-25 15:55:05'),(30,11,1,1,1,1,1,1,1,1,1,1,1,'2012-06-25 15:55:05','2012-06-25 15:55:05'),(31,12,1,1,1,1,1,1,1,1,1,1,1,'2012-06-25 15:55:05','2012-06-25 15:55:05'),(32,13,1,1,1,1,1,1,1,1,1,1,1,'2012-06-25 15:55:05','2012-06-25 15:55:05'),(33,14,1,1,1,1,1,1,1,1,1,1,1,'2012-06-25 15:55:05','2012-06-25 15:55:05'),(34,15,1,1,1,1,1,1,1,1,1,1,1,'2012-06-25 15:55:05','2012-06-25 15:55:05'),(35,16,1,1,1,1,1,1,1,1,1,1,1,'2012-06-25 15:55:05','2012-06-25 15:55:05'),(36,17,1,1,1,1,1,1,1,1,1,1,1,'2012-06-25 15:55:05','2012-06-25 15:55:05'),(37,18,1,1,1,1,1,1,1,1,1,1,1,'2012-06-25 15:55:05','2012-06-25 15:55:05'),(38,19,1,1,1,1,1,1,1,1,1,1,1,'2012-06-25 15:55:05','2012-06-25 15:55:05'),(153,1,1,1,1,1,1,1,1,1,1,1,1,'2012-08-28 14:01:27','2012-08-28 14:01:27'),(154,2,1,1,1,1,1,1,1,1,1,1,1,'2012-08-28 14:01:27','2012-08-28 14:01:27'),(155,3,1,1,1,1,1,1,1,1,1,1,1,'2012-08-28 14:01:27','2012-08-28 14:01:27'),(156,4,1,1,1,1,1,1,1,1,1,1,1,'2012-08-28 14:01:27','2012-08-28 14:01:27'),(157,5,1,1,1,1,1,1,1,1,1,1,1,'2012-08-28 14:01:27','2012-08-28 14:01:27'),(158,6,1,1,1,1,1,1,1,1,1,1,1,'2012-08-28 14:01:27','2012-08-28 14:01:27'),(159,7,1,1,1,1,1,1,1,1,1,1,1,'2012-08-28 14:01:27','2012-08-28 14:01:27'),(160,8,1,1,1,1,1,1,1,1,1,1,1,'2012-08-28 14:01:27','2012-08-28 14:01:27'),(161,9,1,1,1,1,1,1,1,1,1,1,1,'2012-08-28 14:01:27','2012-08-28 14:01:27'),(162,10,1,1,1,1,1,1,1,1,1,1,1,'2012-08-28 14:01:27','2012-08-28 14:01:27'),(163,11,1,1,1,1,1,1,1,1,1,1,1,'2012-08-28 14:01:27','2012-08-28 14:01:27'),(164,12,1,1,1,1,1,1,1,1,1,1,1,'2012-08-28 14:01:27','2012-08-28 14:01:27'),(165,13,1,1,1,1,1,1,1,1,1,1,1,'2012-08-28 14:01:27','2012-08-28 14:01:27'),(166,14,1,1,1,1,1,1,1,1,1,1,1,'2012-08-28 14:01:27','2012-08-28 14:01:27'),(167,15,1,1,1,1,1,1,1,1,1,1,1,'2012-08-28 14:01:27','2012-08-28 14:01:27'),(168,16,1,1,1,1,1,1,1,1,1,1,1,'2012-08-28 14:01:27','2012-08-28 14:01:27'),(169,17,1,1,1,1,1,1,1,1,1,1,1,'2012-08-28 14:01:27','2012-08-28 14:01:27'),(170,18,1,1,1,1,1,1,1,1,1,1,1,'2012-08-28 14:01:27','2012-08-28 14:01:27'),(171,19,1,1,1,1,1,1,1,1,1,1,1,'2012-08-28 14:01:27','2012-08-28 14:01:27'),(172,1,1,1,1,1,1,1,1,1,1,1,1,'2012-09-01 13:23:18','2012-09-01 13:23:18'),(173,2,1,1,1,1,1,1,1,1,1,1,1,'2012-09-01 13:23:18','2012-09-01 13:23:18'),(174,3,1,1,1,1,1,1,1,1,1,1,1,'2012-09-01 13:23:18','2012-09-01 13:23:18'),(175,4,1,1,1,1,1,1,1,1,1,1,1,'2012-09-01 13:23:18','2012-09-01 13:23:18'),(176,5,1,1,1,1,1,1,1,1,1,1,1,'2012-09-01 13:23:18','2012-09-01 13:23:18'),(177,6,1,1,1,1,1,1,1,1,1,1,1,'2012-09-01 13:23:18','2012-09-01 13:23:18'),(178,7,1,1,1,1,1,1,1,1,1,1,1,'2012-09-01 13:23:18','2012-09-01 13:23:18'),(179,8,1,1,1,1,1,1,1,1,1,1,1,'2012-09-01 13:23:18','2012-09-01 13:23:18'),(180,9,1,1,1,1,1,1,1,1,1,1,1,'2012-09-01 13:23:18','2012-09-01 13:23:18'),(181,10,1,1,1,1,1,1,1,1,1,1,1,'2012-09-01 13:23:18','2012-09-01 13:23:18'),(182,11,1,1,1,1,1,1,1,1,1,1,1,'2012-09-01 13:23:18','2012-09-01 13:23:18'),(183,12,1,1,1,1,1,1,1,1,1,1,1,'2012-09-01 13:23:18','2012-09-01 13:23:18'),(184,13,1,1,1,1,1,1,1,1,1,1,1,'2012-09-01 13:23:18','2012-09-01 13:23:18'),(185,14,1,1,1,1,1,1,1,1,1,1,1,'2012-09-01 13:23:18','2012-09-01 13:23:18'),(186,15,1,1,1,1,1,1,1,1,1,1,1,'2012-09-01 13:23:18','2012-09-01 13:23:18'),(187,16,1,1,1,1,1,1,1,1,1,1,1,'2012-09-01 13:23:18','2012-09-01 13:23:18'),(188,17,1,1,1,1,1,1,1,1,1,1,1,'2012-09-01 13:23:18','2012-09-01 13:23:18'),(189,18,1,1,1,1,1,1,1,1,1,1,1,'2012-09-01 13:23:18','2012-09-01 13:23:18'),(190,19,1,1,1,1,1,1,1,1,1,1,1,'2012-09-01 13:23:18','2012-09-01 13:23:18'),(191,1,1,1,1,1,1,1,1,1,1,1,1,'2012-09-03 23:41:57','2012-09-03 23:41:57'),(192,2,1,1,1,1,1,1,1,1,1,1,1,'2012-09-03 23:41:57','2012-09-03 23:41:57'),(193,3,1,1,1,1,1,1,1,1,1,1,1,'2012-09-03 23:41:57','2012-09-03 23:41:57'),(194,4,1,1,1,1,1,1,1,1,1,1,1,'2012-09-03 23:41:57','2012-09-03 23:41:57'),(195,5,1,1,1,1,1,1,1,1,1,1,1,'2012-09-03 23:41:57','2012-09-03 23:41:57'),(196,6,1,1,1,1,1,1,1,1,1,1,1,'2012-09-03 23:41:57','2012-09-03 23:41:57'),(197,7,1,1,1,1,1,1,1,1,1,1,1,'2012-09-03 23:41:57','2012-09-03 23:41:57'),(198,8,1,1,1,1,1,1,1,1,1,1,1,'2012-09-03 23:41:57','2012-09-03 23:41:57'),(199,9,1,1,1,1,1,1,1,1,1,1,1,'2012-09-03 23:41:57','2012-09-03 23:41:57'),(200,10,1,1,1,1,1,1,1,1,1,1,1,'2012-09-03 23:41:57','2012-09-03 23:41:57'),(201,11,1,1,1,1,1,1,1,1,1,1,1,'2012-09-03 23:41:57','2012-09-03 23:41:57'),(202,12,1,1,1,1,1,1,1,1,1,1,1,'2012-09-03 23:41:57','2012-09-03 23:41:57'),(203,13,1,1,1,1,1,1,1,1,1,1,1,'2012-09-03 23:41:57','2012-09-03 23:41:57'),(204,14,1,1,1,1,1,1,1,1,1,1,1,'2012-09-03 23:41:57','2012-09-03 23:41:57'),(205,15,1,1,1,1,1,1,1,1,1,1,1,'2012-09-03 23:41:58','2012-09-03 23:41:58'),(206,16,1,1,1,1,1,1,1,1,1,1,1,'2012-09-03 23:41:58','2012-09-03 23:41:58'),(207,17,1,1,1,1,1,1,1,1,1,1,1,'2012-09-03 23:41:58','2012-09-03 23:41:58'),(208,18,1,1,1,1,1,1,1,1,1,1,1,'2012-09-03 23:41:58','2012-09-03 23:41:58'),(209,19,1,1,1,1,1,1,1,1,1,1,1,'2012-09-03 23:41:58','2012-09-03 23:41:58'),(210,1,1,1,1,1,1,1,1,1,1,1,1,'2012-09-08 06:47:49','2012-09-08 06:47:49'),(211,2,1,1,1,1,1,1,1,1,1,1,1,'2012-09-08 06:47:49','2012-09-08 06:47:49'),(212,3,1,1,1,1,1,1,1,1,1,1,1,'2012-09-08 06:47:49','2012-09-08 06:47:49'),(213,4,1,1,1,1,1,1,1,1,1,1,1,'2012-09-08 06:47:49','2012-09-08 06:47:49'),(214,5,1,1,1,1,1,1,1,1,1,1,1,'2012-09-08 06:47:49','2012-09-08 06:47:49'),(215,6,1,1,1,1,1,1,1,1,1,1,1,'2012-09-08 06:47:49','2012-09-08 06:47:49'),(216,7,1,1,1,1,1,1,1,1,1,1,1,'2012-09-08 06:47:49','2012-09-08 06:47:49'),(217,8,1,1,1,1,1,1,1,1,1,1,1,'2012-09-08 06:47:49','2012-09-08 06:47:49'),(218,9,1,1,1,1,1,1,1,1,1,1,1,'2012-09-08 06:47:49','2012-09-08 06:47:49'),(219,10,1,1,1,1,1,1,1,1,1,1,1,'2012-09-08 06:47:49','2012-09-08 06:47:49'),(220,11,1,1,1,1,1,1,1,1,1,1,1,'2012-09-08 06:47:49','2012-09-08 06:47:49'),(221,12,1,1,1,1,1,1,1,1,1,1,1,'2012-09-08 06:47:49','2012-09-08 06:47:49'),(222,13,1,1,1,1,1,1,1,1,1,1,1,'2012-09-08 06:47:49','2012-09-08 06:47:49'),(223,14,1,1,1,1,1,1,1,1,1,1,1,'2012-09-08 06:47:49','2012-09-08 06:47:49'),(224,15,1,1,1,1,1,1,1,1,1,1,1,'2012-09-08 06:47:49','2012-09-08 06:47:49'),(225,16,1,1,1,1,1,1,1,1,1,1,1,'2012-09-08 06:47:49','2012-09-08 06:47:49'),(226,17,1,1,1,1,1,1,1,1,1,1,1,'2012-09-08 06:47:49','2012-09-08 06:47:49'),(227,18,1,1,1,1,1,1,1,1,1,1,1,'2012-09-08 06:47:49','2012-09-08 06:47:49'),(228,19,1,1,1,1,1,1,1,1,1,1,1,'2012-09-08 06:47:49','2012-09-08 06:47:49'),(229,1,1,1,1,1,1,1,1,1,1,1,1,'2012-09-08 09:03:37','2012-09-08 09:03:37'),(230,2,1,1,1,1,1,1,1,1,1,1,1,'2012-09-08 09:03:37','2012-09-08 09:03:37'),(231,3,1,1,1,1,1,1,1,1,1,1,1,'2012-09-08 09:03:37','2012-09-08 09:03:37'),(232,4,1,1,1,1,1,1,1,1,1,1,1,'2012-09-08 09:03:37','2012-09-08 09:03:37'),(233,5,1,1,1,1,1,1,1,1,1,1,1,'2012-09-08 09:03:37','2012-09-08 09:03:37'),(234,6,1,1,1,1,1,1,1,1,1,1,1,'2012-09-08 09:03:37','2012-09-08 09:03:37'),(235,7,1,1,1,1,1,1,1,1,1,1,1,'2012-09-08 09:03:37','2012-09-08 09:03:37'),(236,8,1,1,1,1,1,1,1,1,1,1,1,'2012-09-08 09:03:37','2012-09-08 09:03:37'),(237,9,1,1,1,1,1,1,1,1,1,1,1,'2012-09-08 09:03:37','2012-09-08 09:03:37'),(238,10,1,1,1,1,1,1,1,1,1,1,1,'2012-09-08 09:03:37','2012-09-08 09:03:37'),(239,11,1,1,1,1,1,1,1,1,1,1,1,'2012-09-08 09:03:37','2012-09-08 09:03:37'),(240,12,1,1,1,1,1,1,1,1,1,1,1,'2012-09-08 09:03:37','2012-09-08 09:03:37'),(241,13,1,1,1,1,1,1,1,1,1,1,1,'2012-09-08 09:03:37','2012-09-08 09:03:37'),(242,14,1,1,1,1,1,1,1,1,1,1,1,'2012-09-08 09:03:37','2012-09-08 09:03:37'),(243,15,1,1,1,1,1,1,1,1,1,1,1,'2012-09-08 09:03:37','2012-09-08 09:03:37'),(244,16,1,1,1,1,1,1,1,1,1,1,1,'2012-09-08 09:03:37','2012-09-08 09:03:37'),(245,17,1,1,1,1,1,1,1,1,1,1,1,'2012-09-08 09:03:37','2012-09-08 09:03:37'),(246,18,1,1,1,1,1,1,1,1,1,1,1,'2012-09-08 09:03:37','2012-09-08 09:03:37'),(247,19,1,1,1,1,1,1,1,1,1,1,1,'2012-09-08 09:03:37','2012-09-08 09:03:37');
/*!40000 ALTER TABLE `user_profile_visibilities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `distincts`
--

DROP TABLE IF EXISTS `distincts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `distincts` (
  `id` int(11) NOT NULL auto_increment,
  `prefecture_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `public` tinyint(1) NOT NULL default '1',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `index_distincts_on_prefecture_id` (`prefecture_id`)
) ENGINE=InnoDB AUTO_INCREMENT=92 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `distincts`
--

LOCK TABLES `distincts` WRITE;
/*!40000 ALTER TABLE `distincts` DISABLE KEYS */;
INSERT INTO `distincts` VALUES (1,1,'ソンラ市',1,'2012-06-30 15:08:12','2012-08-09 16:44:16'),(2,2,'ホアビン',1,'2012-06-30 15:08:12','2012-08-09 16:47:00'),(3,3,'ディエンビエンフー',1,'2012-06-30 15:08:12','2012-08-09 16:47:21'),(4,4,'ライチャウ市',1,'2012-06-30 15:08:12','2012-08-09 16:49:18'),(5,5,'ラオカイ市',1,'2012-06-30 15:08:12','2012-08-09 16:50:32'),(6,6,'ハザン市',1,'2012-06-30 15:08:12','2012-08-09 16:52:59'),(7,7,'カオバン',1,'2012-06-30 15:08:12','2012-08-09 16:53:40'),(8,8,'イェンバイ市',1,'2012-06-30 15:08:12','2012-08-09 16:54:12'),(9,9,'トゥエンクアン市',1,'2012-06-30 15:08:12','2012-08-09 16:54:41'),(10,10,'ランソン市',1,'2012-06-30 15:08:12','2012-08-09 16:55:10'),(11,11,'ハロン市',1,'2012-06-30 15:08:12','2012-08-09 16:55:36'),(12,12,'千葉県 ',1,'2012-06-30 15:08:12','2012-06-30 15:08:12'),(13,13,'バックカン市',1,'2012-06-30 15:08:12','2012-08-09 16:56:26'),(14,14,'フート市',1,'2012-06-30 15:08:12','2012-08-09 16:57:25'),(15,15,'タイグエン市',1,'2012-06-30 15:08:12','2012-08-09 16:57:49'),(16,16,'ニンビン市',1,'2012-06-30 15:08:12','2012-08-13 15:21:28'),(17,17,'タイビン市',1,'2012-06-30 15:08:12','2012-08-13 15:22:07'),(18,18,'ハイズオン市',1,'2012-06-30 15:08:12','2012-08-13 15:22:31'),(19,19,'ハナム',1,'2012-06-30 15:08:12','2012-08-13 15:23:03'),(20,20,'フンイエン市',1,'2012-06-30 15:08:12','2012-08-13 15:23:26'),(21,21,'ナムディン市',1,'2012-06-30 15:08:12','2012-08-13 15:24:30'),(22,22,'バクニン市',1,'2012-06-30 15:08:12','2012-08-13 15:24:50'),(23,23,'ヴィンフック',1,'2012-06-30 15:08:12','2012-08-13 15:25:10'),(24,24,'タインホア市',1,'2012-06-30 15:08:12','2012-08-13 15:25:33'),(25,25,'ヴィン市',1,'2012-06-30 15:08:12','2012-08-13 15:26:02'),(26,26,'ハティン市',1,'2012-06-30 15:08:12','2012-08-13 15:26:27'),(27,27,'ドンホイ',1,'2012-06-30 15:08:12','2012-08-13 15:27:08'),(28,28,'クアンチ',1,'2012-06-30 15:08:12','2012-08-13 15:27:43'),(29,29,'フエ',1,'2012-06-30 15:08:12','2012-08-13 15:28:25'),(30,30,'タムキー市',1,'2012-06-30 15:08:12','2012-08-13 15:29:06'),(31,31,'クアンガイ市',1,'2012-06-30 15:08:12','2012-08-13 15:30:35'),(32,32,'島根県',1,'2012-06-30 15:08:12','2012-06-30 15:08:12'),(33,33,'岡山県',1,'2012-06-30 15:08:12','2012-06-30 15:08:12'),(34,34,'ニャチャン',1,'2012-06-30 15:08:12','2012-08-13 15:35:38'),(35,35,'コントゥム市',1,'2012-06-30 15:08:12','2012-08-13 15:35:58'),(36,36,'ザライ',1,'2012-06-30 15:08:12','2012-08-13 15:36:34'),(37,37,'バンメトート市',1,'2012-06-30 15:08:12','2012-08-13 15:37:05'),(38,38,'ダクノン',1,'2012-06-30 15:08:12','2012-08-13 15:38:46'),(39,39,'ダラット',1,'2012-06-30 15:08:12','2012-08-13 15:39:17'),(40,40,'ニントゥアン省',1,'2012-06-30 15:08:12','2012-08-13 15:40:23'),(41,41,'タイニン市',1,'2012-06-30 15:08:12','2012-08-13 15:40:44'),(42,42,'ドンナイ',1,'2012-06-30 15:08:12','2012-08-13 15:43:42'),(43,43,'ファンティエット市',1,'2012-06-30 15:08:12','2012-08-13 15:44:15'),(44,44,'ブンタウ',1,'2012-06-30 15:08:12','2012-08-13 15:44:37'),(45,45,'ビンズオン',1,'2012-06-30 15:08:12','2012-08-13 15:44:58'),(46,46,'ビンフオック',1,'2012-06-30 15:08:12','2012-08-13 15:45:30'),(47,47,'沖縄県',1,'2012-06-30 15:08:12','2012-06-30 15:08:12'),(48,1,'クインニャイ県',1,'2012-08-09 16:44:30','2012-08-09 16:44:30'),(49,1,'ムオンラー県',1,'2012-08-09 16:44:46','2012-08-09 16:44:46'),(50,1,'トゥアンチャウ県',1,'2012-08-09 16:45:00','2012-08-09 16:45:00'),(51,1,'フーイエン県',1,'2012-08-09 16:45:10','2012-08-09 16:45:10'),(52,1,'バクイエン県',1,'2012-08-09 16:45:22','2012-08-09 16:45:22'),(53,1,'マイソン県',1,'2012-08-09 16:45:33','2012-08-09 16:45:33'),(54,1,'ソンマー県',1,'2012-08-09 16:45:44','2012-08-09 16:45:44'),(55,1,'イエンチャウ県',1,'2012-08-09 16:45:54','2012-08-09 16:45:54'),(56,1,'モクチャウ県',1,'2012-08-09 16:46:07','2012-08-09 16:46:07'),(57,1,'ソップコップ県',1,'2012-08-09 16:46:17','2012-08-09 16:46:17'),(58,3,'ムオンレイ',1,'2012-08-09 16:47:32','2012-08-09 16:47:32'),(59,3,'ディエンビエン県',1,'2012-08-09 16:47:43','2012-09-06 12:50:10'),(60,3,'ディエンビエンドン県',1,'2012-08-09 16:47:54','2012-08-09 16:47:54'),(61,3,'ムオンアン県',1,'2012-08-09 16:48:04','2012-09-06 12:50:20'),(62,3,'ムオンチャ県',1,'2012-08-09 16:48:16','2012-08-09 16:48:16'),(63,3,'ムオンニェ県',1,'2012-08-09 16:48:26','2012-08-09 16:48:26'),(64,3,'トゥアチュア県',1,'2012-08-09 16:48:37','2012-08-09 16:48:37'),(65,3,'トゥアンジャオ県',1,'2012-08-09 16:48:47','2012-08-09 16:48:47'),(66,4,'ムオンテ県',1,'2012-08-09 16:49:29','2012-08-09 16:49:29'),(67,4,'フォントー県',1,'2012-08-09 16:49:40','2012-08-09 16:49:40'),(68,4,'シンホー県',1,'2012-08-09 16:49:50','2012-08-09 16:49:50'),(69,4,'タムドゥオン県',1,'2012-08-09 16:49:59','2012-08-09 16:49:59'),(70,4,'タンユエン県',1,'2012-08-09 16:50:08','2012-08-09 16:50:08'),(71,5,'Bảo Thắng 県',1,'2012-08-09 16:50:47','2012-08-09 16:50:47'),(72,5,'Bảo Yên 県',1,'2012-08-09 16:50:58','2012-08-09 16:50:58'),(73,5,'Bát Xát 県',1,'2012-08-09 16:51:11','2012-08-09 16:51:11'),(74,5,'バックハー県',1,'2012-08-09 16:51:23','2012-08-09 16:51:23'),(75,5,'Mường Khương',1,'2012-08-09 16:51:34','2012-08-09 16:51:34'),(76,5,'サパ県',1,'2012-08-09 16:51:46','2012-08-09 16:51:46'),(77,5,'Si Ma Cai 県',1,'2012-08-09 16:51:56','2012-08-09 16:51:56'),(78,5,'Văn Bàn 県',1,'2012-08-09 16:52:05','2012-08-09 16:52:05'),(79,31,'Ba Tơ',1,'2012-08-13 15:30:45','2012-08-13 15:30:45'),(80,31,'Bình Sơn',1,'2012-08-13 15:30:54','2012-08-13 15:30:54'),(81,31,'Đức Phổ',1,'2012-08-13 15:31:05','2012-08-13 15:31:05'),(82,31,'Minh Long',1,'2012-08-13 15:31:23','2012-08-13 15:31:23'),(83,31,'Mộ Đức',1,'2012-08-13 15:31:36','2012-08-13 15:31:36'),(84,31,'Nghĩa Hành',1,'2012-08-13 15:31:50','2012-08-13 15:31:50'),(85,31,'Sơn Hà',1,'2012-08-13 15:32:01','2012-08-13 15:32:01'),(86,31,'Sơn Tây',1,'2012-08-13 15:32:15','2012-08-13 15:32:15'),(87,31,'ソン・ティン県',1,'2012-08-13 15:32:26','2012-08-13 15:32:26'),(88,31,'Tây Trà',1,'2012-08-13 15:32:36','2012-08-13 15:32:36'),(89,31,'Trà Bồng',1,'2012-08-13 15:32:56','2012-08-13 15:32:56'),(90,31,' Tư Nghĩa',1,'2012-08-13 15:33:10','2012-08-13 15:33:10'),(91,31,'Lý Sơn ',1,'2012-08-13 15:33:25','2012-08-13 15:33:25');
/*!40000 ALTER TABLE `distincts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prefectures`
--

DROP TABLE IF EXISTS `prefectures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prefectures` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  `public` tinyint(1) NOT NULL default '1',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prefectures`
--

LOCK TABLES `prefectures` WRITE;
/*!40000 ALTER TABLE `prefectures` DISABLE KEYS */;
INSERT INTO `prefectures` VALUES (1,'Sơn La',1,'2012-04-30 13:40:29','2012-04-30 13:40:29'),(2,'Hoà Bình',1,'2012-04-30 13:40:29','2012-09-06 12:48:49'),(3,'Điện Biên',1,'2012-04-30 13:40:29','2012-04-30 13:40:29'),(4,'Lai Châu',1,'2012-04-30 13:40:29','2012-04-30 13:40:29'),(5,'Lào Cai,',1,'2012-04-30 13:40:29','2012-04-30 13:40:29'),(6,'Hà Giang',1,'2012-04-30 13:40:29','2012-04-30 13:40:29'),(7,'Cao Bằng',1,'2012-04-30 13:40:29','2012-04-30 13:40:29'),(8,'Yên Bái,',1,'2012-04-30 13:40:29','2012-04-30 13:40:29'),(9,'Tuyên Quang',1,'2012-04-30 13:40:29','2012-04-30 13:40:29'),(10,'Lạng Sơn,',1,'2012-04-30 13:40:29','2012-04-30 13:40:29'),(11,'Quảng Ninh',1,'2012-04-30 13:40:29','2012-04-30 13:40:29'),(12,'Bắc Kạn',1,'2012-04-30 13:40:29','2012-04-30 13:40:29'),(13,'Bắc Giang',1,'2012-04-30 13:40:29','2012-04-30 13:40:29'),(14,'Phú Thọ',1,'2012-04-30 13:40:29','2012-04-30 13:40:29'),(15,'Thái Nguyên',1,'2012-04-30 13:40:29','2012-04-30 13:40:29'),(16,'Ninh Bình',1,'2012-04-30 13:40:29','2012-04-30 13:40:29'),(17,'Thái Bình',1,'2012-04-30 13:40:29','2012-04-30 13:40:29'),(18,'Hải Dương',1,'2012-04-30 13:40:29','2012-04-30 13:40:29'),(19,'Hà Nam',1,'2012-04-30 13:40:29','2012-04-30 13:40:29'),(20,'Hưng Yên,',1,'2012-04-30 13:40:29','2012-04-30 13:40:29'),(21,'Nam Định',1,'2012-04-30 13:40:29','2012-04-30 13:40:29'),(22,'Bắc Ninh',1,'2012-04-30 13:40:29','2012-04-30 13:40:29'),(23,'Vĩnh Phúc',1,'2012-04-30 13:40:29','2012-04-30 13:40:29'),(24,'Thanh Hóa',1,'2012-04-30 13:40:29','2012-04-30 13:40:29'),(25,'Nghệ An',1,'2012-04-30 13:40:29','2012-04-30 13:40:29'),(26,'Hà Tĩnh',1,'2012-04-30 13:40:29','2012-04-30 13:40:29'),(27,'Quảng Bình',1,'2012-04-30 13:40:29','2012-04-30 13:40:29'),(28,'Quảng Trị',1,'2012-04-30 13:40:29','2012-04-30 13:40:29'),(29,'Thừa Thiên–Huế,',1,'2012-04-30 13:40:29','2012-04-30 13:40:29'),(30,'Quảng Nam',1,'2012-04-30 13:40:29','2012-04-30 13:40:29'),(31,'Quảng Ngãi,',1,'2012-04-30 13:40:29','2012-04-30 13:40:29'),(32,'Bình Định',1,'2012-04-30 13:40:29','2012-04-30 13:40:29'),(33,'Phú Yên',1,'2012-04-30 13:40:29','2012-04-30 13:40:29'),(34,'Khánh Hòa',1,'2012-04-30 13:40:29','2012-04-30 13:40:29'),(35,'Kon Tum',1,'2012-04-30 13:40:29','2012-04-30 13:40:29'),(36,'Gia Lai,',1,'2012-04-30 13:40:29','2012-04-30 13:40:29'),(37,'Đăk Lăk',1,'2012-04-30 13:40:29','2012-04-30 13:40:29'),(38,'Đăk Nông',1,'2012-04-30 13:40:29','2012-04-30 13:40:29'),(39,'Lâm Đồng',1,'2012-04-30 13:40:29','2012-04-30 13:40:29'),(40,'Ninh Thuận',1,'2012-04-30 13:40:29','2012-04-30 13:40:29'),(41,'Tây Ninh,',1,'2012-04-30 13:40:29','2012-04-30 13:40:29'),(42,'Đồng Nai,',1,'2012-04-30 13:40:29','2012-04-30 13:40:29'),(43,'Bình Thuận',1,'2012-04-30 13:40:29','2012-04-30 13:40:29'),(44,'Bà Rịa-Vũng Tàu',1,'2012-04-30 13:40:29','2012-04-30 13:40:29'),(45,'Bình Dương',1,'2012-04-30 13:40:29','2012-04-30 13:40:29'),(46,'Bình Phước',1,'2012-04-30 13:40:29','2012-04-30 13:40:29'),(47,'Long An',1,'2012-04-30 13:40:29','2012-04-30 13:40:29'),(48,'An Giang',1,'2012-04-30 13:40:29','2012-04-30 13:40:29'),(49,'Đồng Tháp',1,'2012-04-30 13:40:29','2012-04-30 13:40:29'),(50,'Tiền Giang',1,'2012-04-30 13:40:30','2012-04-30 13:40:30'),(51,'Kiên Giang',1,'2012-04-30 13:40:30','2012-04-30 13:40:30'),(52,'Vĩnh Long',1,'2012-04-30 13:40:30','2012-04-30 13:40:30'),(53,'Bến Tre',1,'2012-04-30 13:40:30','2012-04-30 13:40:30'),(54,'Trà Vinh,',1,'2012-04-30 13:40:30','2012-04-30 13:40:30'),(55,'Sóc Trăng',1,'2012-04-30 13:40:30','2012-04-30 13:40:30'),(56,'Hậu Giang',1,'2012-04-30 13:40:30','2012-04-30 13:40:30'),(57,'Bạc Liêu',1,'2012-04-30 13:40:30','2012-04-30 13:40:30'),(58,'Cà Mau',1,'2012-04-30 13:40:30','2012-04-30 13:40:30'),(59,'Hà Nội,',1,'2012-08-09 16:41:24','2012-08-09 16:41:24'),(60,'Hồ Chí Minh',1,'2012-08-09 16:41:41','2012-08-09 16:41:41'),(61,'Đà Nẵng',1,'2012-08-09 16:41:57','2012-08-09 16:41:57'),(62,'Hải Phòng,',1,'2012-08-09 16:42:10','2012-08-09 16:42:10'),(63,'Cần Thơ',1,'2012-08-09 16:42:23','2012-08-09 16:42:23');
/*!40000 ALTER TABLE `prefectures` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `omniusers`
--

DROP TABLE IF EXISTS `omniusers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `omniusers` (
  `id` int(11) NOT NULL auto_increment,
  `provider` varchar(255) default NULL,
  `uid` varchar(255) default NULL,
  `name` varchar(255) default NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `omniusers`
--

LOCK TABLES `omniusers` WRITE;
/*!40000 ALTER TABLE `omniusers` DISABLE KEYS */;
/*!40000 ALTER TABLE `omniusers` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-09-08 22:01:42
