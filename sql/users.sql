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
  `omniuser_id` int(11) DEFAULT NULL,
  `confirmation_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `confirmed_at` datetime DEFAULT NULL,
  `confirmation_sent_at` datetime DEFAULT NULL,
  `unconfirmed_email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_users_on_email` (`email`),
  UNIQUE KEY `index_users_on_reset_password_token` (`reset_password_token`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'babanba.n@gmail.com','$2a$10$SG0zqyARBSWAM6FRL5uo6OnPSBPUWi24IA3ir0lWxvIv7RGVUnqZ6',NULL,NULL,NULL,1,'2012-07-02 16:00:47','2012-07-02 16:00:47','127.0.0.1','127.0.0.1',NULL,'ftvk4eizqxjpuVsqhTee','2012-07-02 16:00:27','2012-07-02 15:55:50',NULL,'2012-07-02 15:55:50','2012-07-02 16:00:47'),(2,'1@test.jp','$2a$10$IbUu9y4oTZObacdTQhBwHOe49FfWb3kUAZNSIiCzgPxgwqqM56Uhq',NULL,NULL,NULL,1,'2012-06-05 00:24:47','2012-06-05 00:24:47','127.0.0.1','127.0.0.1',2012,'2012-06-05 00:24:47',NULL,NULL,NULL,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(3,'2@test.jp','$2a$10$HeUwWIYyBhoXc3IGdaWsteBDQyNPu1ACLDJrE1rsbtaLrrsw..t1W',NULL,NULL,NULL,1,'2012-06-05 00:25:09','2012-06-05 00:25:09','127.0.0.1','127.0.0.1',2012,'2012-06-05 00:25:09',NULL,NULL,NULL,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(4,'3@test.jp','$2a$10$4wQ/u6hpjgfauItR8mkgM.2zTIQGEhwV/ftPlnlyv0IES7H2SUq0u',NULL,NULL,NULL,1,'2012-06-05 00:25:30','2012-06-05 00:25:30','127.0.0.1','127.0.0.1',2012,'2012-06-05 00:25:30',NULL,NULL,NULL,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(5,'4@test.jp','$2a$10$eLPfr2j418KWTRtgTIdsbOlH.Fem4E.Tj2ROwORtPUq2yvg3lERUO',NULL,NULL,NULL,1,'2012-06-05 00:25:49','2012-06-05 00:25:49','127.0.0.1','127.0.0.1',2012,'2012-06-05 00:25:49',NULL,NULL,NULL,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(6,'5@test.jp','$2a$10$TJWRQanfpLUTfPrLdY3doudhLxI.81V/lRXgh.trW6UvJekfXKBFq',NULL,NULL,NULL,1,'2012-06-05 00:27:17','2012-06-05 00:27:17','127.0.0.1','127.0.0.1',2012,'2012-06-05 00:27:17',NULL,NULL,NULL,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(7,'6@test.jp','$2a$10$gw0nDAHGJ2m4FCMyXynTRuA2l24SsQpqwrfh/yhS6S2IKukmdT/BG',NULL,NULL,NULL,1,'2012-06-05 00:27:35','2012-06-05 00:27:35','127.0.0.1','127.0.0.1',2012,'2012-06-05 00:27:35',NULL,NULL,NULL,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(8,'7@test.jp','$2a$10$nOLdqofa/vN43UVbz32JNeSo1JSxN07a7QzX3qPCIb9rXUc5R8zKm',NULL,NULL,NULL,1,'2012-06-05 00:28:03','2012-06-05 00:28:03','127.0.0.1','127.0.0.1',2012,'2012-06-05 00:28:03',NULL,NULL,NULL,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(9,'8@test.jp','$2a$10$DM4JGN5kos09M80dIG.qZeG/yf6Plz5U.hxH.uLeFBdyE1qIenK72',NULL,NULL,NULL,1,'2012-06-05 00:28:24','2012-06-05 00:28:24','127.0.0.1','127.0.0.1',2012,'2012-06-05 00:28:24',NULL,NULL,NULL,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(10,'9@test.jp','$2a$10$fRG1ITFJQeDCr2xRqETvAeVj0GynYl0ug933/L198CkEXRDPYSQLS',NULL,NULL,NULL,1,'2012-06-05 00:28:38','2012-06-05 00:28:38','127.0.0.1','127.0.0.1',2012,'2012-06-05 00:28:38',NULL,NULL,NULL,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(11,'10@test.jp','$2a$10$Uvy7sPNLIflcxrHQC3r3IeFCgOFsI63IQdwvZtZVqvKM677EoTNDW',NULL,NULL,NULL,1,'2012-06-05 00:29:05','2012-06-05 00:29:05','127.0.0.1','127.0.0.1',2012,'2012-06-05 00:29:05',NULL,NULL,NULL,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(12,'11@test.jp','$2a$10$JyZDP4eQKVbU1c.id8EVjeNt2rx4Ja7nDCHPkZRxXUjZ7XpUv3d5O',NULL,NULL,NULL,1,'2012-06-05 12:19:45','2012-06-05 12:19:45','127.0.0.1','127.0.0.1',2012,'2012-06-05 12:19:45',NULL,NULL,NULL,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(13,'12@test.jp','$2a$10$DgaxP/pLSCfusLa7rkeva.JinAyTz.7IFrnoK4lNwsmhYrkhlxcJ6',NULL,NULL,NULL,1,'2012-06-05 12:20:03','2012-06-05 12:20:03','127.0.0.1','127.0.0.1',2012,'2012-06-05 12:20:03',NULL,NULL,NULL,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(14,'13@test.jp','$2a$10$5I215esVdz5Rk7XFfEAshOJCUhOeIBabRzsvIerphiMvXwkCooY1e',NULL,NULL,NULL,1,'2012-06-05 12:20:19','2012-06-05 12:20:19','127.0.0.1','127.0.0.1',2012,'2012-06-05 12:20:19',NULL,NULL,NULL,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(15,'14@test.jp','$2a$10$nw5UlnIIAwt0yjrNqZRIx.I8TWLmAvojQ8M50TruTLP5X9ZJoMOYO',NULL,NULL,NULL,1,'2012-06-05 12:20:38','2012-06-05 12:20:38','127.0.0.1','127.0.0.1',2012,'2012-06-05 12:20:38',NULL,NULL,NULL,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(16,'15@test.jp','$2a$10$Emds607SK8Nqy/GHGhQc3.rxIxi5RuUcbA8T.niDASYH.otqB2NLq',NULL,NULL,NULL,1,'2012-06-05 12:20:55','2012-06-05 12:20:55','127.0.0.1','127.0.0.1',2012,'2012-06-05 12:20:55',NULL,NULL,NULL,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(17,'16@test.jp','$2a$10$KTYk/gT9Q3hPh9JsB8lLIuqhmytvlcE4Loj.aOSZ..tKBmA5Wy47m',NULL,NULL,NULL,1,'2012-06-05 12:21:10','2012-06-05 12:21:10','127.0.0.1','127.0.0.1',2012,'2012-06-05 12:21:10',NULL,NULL,NULL,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(18,'17@test.jp','$2a$10$CE5/1Vh.sOYhU.FfVmMuKOMRHs8eSVaEkR6Rkc6T.7Wvzp/LTOB4O',NULL,NULL,NULL,1,'2012-06-05 12:21:25','2012-06-05 12:21:25','127.0.0.1','127.0.0.1',2012,'2012-06-05 12:21:25',NULL,NULL,NULL,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(19,'18@test.jp','$2a$10$tVi2AOmf3R/5sOQ1QEooKu7tkP8OrboWeibdIXT2njJU3Im20X0yW',NULL,NULL,NULL,1,'2012-06-05 12:21:39','2012-06-05 12:21:39','127.0.0.1','127.0.0.1',2012,'2012-06-05 12:21:39',NULL,NULL,NULL,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(20,'19@test.jp','$2a$10$gF4S79NeOlDt9YRt.ajPUO92i9p6JVSWRGqQppkiSFHixc32s5GcK',NULL,NULL,NULL,1,'2012-06-05 12:21:55','2012-06-05 12:21:55','127.0.0.1','127.0.0.1',2012,'2012-06-05 12:21:55',NULL,NULL,NULL,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(21,'20@test.jp','$2a$10$2/SD3u6NuO6vtmx3hcT7WOSRuG30yOLUziyoZsjnIG7xHSM6kTO3G',NULL,NULL,NULL,1,'2012-06-05 12:22:12','2012-06-05 12:22:12','127.0.0.1','127.0.0.1',2012,'2012-06-05 12:22:12',NULL,NULL,NULL,'0000-00-00 00:00:00','0000-00-00 00:00:00');
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

-- Dump completed on 2012-07-03  1:01:07
