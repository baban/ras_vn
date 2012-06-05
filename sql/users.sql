-- MySQL dump 10.13  Distrib 5.5.24, for osx10.6 (i386)
--
-- Host: localhost    Database: ras_vn_dev
-- ------------------------------------------------------
-- Server version	5.5.15

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
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `encrypted_password` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `reset_password_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reset_password_sent_at` datetime DEFAULT NULL,
  `remember_created_at` datetime DEFAULT NULL,
  `sign_in_count` int(11) DEFAULT '0',
  `current_sign_in_at` datetime DEFAULT NULL,
  `last_sign_in_at` datetime DEFAULT NULL,
  `current_sign_in_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_sign_in_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `uid` int(11) DEFAULT NULL,
  `screen_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `access_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `access_secret` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_users_on_email` (`email`),
  UNIQUE KEY `index_users_on_reset_password_token` (`reset_password_token`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'babanba.n@gmail.com','$2a$10$DuVMagXbgW5Rk3Yu0fJXP.021NuesP.vsAs3fgMKMmfmKmOvli0PS',NULL,NULL,NULL,2,'2012-06-04 15:47:08','2012-05-26 00:36:40','127.0.0.1','127.0.0.1','2012-05-26 00:36:40','2012-06-05 00:24:09',NULL,NULL,NULL,NULL),(2,'1@test.jp','$2a$10$IbUu9y4oTZObacdTQhBwHOe49FfWb3kUAZNSIiCzgPxgwqqM56Uhq',NULL,NULL,NULL,1,'2012-06-05 00:24:47','2012-06-05 00:24:47','127.0.0.1','127.0.0.1','2012-06-05 00:24:47','2012-06-05 00:24:47',NULL,NULL,NULL,NULL),(3,'2@test.jp','$2a$10$HeUwWIYyBhoXc3IGdaWsteBDQyNPu1ACLDJrE1rsbtaLrrsw..t1W',NULL,NULL,NULL,1,'2012-06-05 00:25:09','2012-06-05 00:25:09','127.0.0.1','127.0.0.1','2012-06-05 00:25:09','2012-06-05 00:25:09',NULL,NULL,NULL,NULL),(4,'3@test.jp','$2a$10$4wQ/u6hpjgfauItR8mkgM.2zTIQGEhwV/ftPlnlyv0IES7H2SUq0u',NULL,NULL,NULL,1,'2012-06-05 00:25:30','2012-06-05 00:25:30','127.0.0.1','127.0.0.1','2012-06-05 00:25:30','2012-06-05 00:25:30',NULL,NULL,NULL,NULL),(5,'4@test.jp','$2a$10$eLPfr2j418KWTRtgTIdsbOlH.Fem4E.Tj2ROwORtPUq2yvg3lERUO',NULL,NULL,NULL,1,'2012-06-05 00:25:49','2012-06-05 00:25:49','127.0.0.1','127.0.0.1','2012-06-05 00:25:49','2012-06-05 00:25:49',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-06-05  9:26:41
