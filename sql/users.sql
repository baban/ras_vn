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
-- Table structure for table `admin_users`
--

DROP TABLE IF EXISTS `admin_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `last_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `role` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `status` tinyint(1) DEFAULT '0',
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `salt` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `crypted_password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `preferences` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_admin_users_on_email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_users`
--

LOCK TABLES `admin_users` WRITE;
/*!40000 ALTER TABLE `admin_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `admin_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bookmarks`
--

DROP TABLE IF EXISTS `bookmarks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bookmarks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `recipe_id` int(11) NOT NULL,
  `deleted_at` time DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookmarks`
--

LOCK TABLES `bookmarks` WRITE;
/*!40000 ALTER TABLE `bookmarks` DISABLE KEYS */;
/*!40000 ALTER TABLE `bookmarks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `distincts`
--

DROP TABLE IF EXISTS `distincts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `distincts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `prefecture_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `distincts`
--

LOCK TABLES `distincts` WRITE;
/*!40000 ALTER TABLE `distincts` DISABLE KEYS */;
/*!40000 ALTER TABLE `distincts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `eat_styles`
--

DROP TABLE IF EXISTS `eat_styles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eat_styles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eat_styles`
--

LOCK TABLES `eat_styles` WRITE;
/*!40000 ALTER TABLE `eat_styles` DISABLE KEYS */;
/*!40000 ALTER TABLE `eat_styles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `food_genres`
--

DROP TABLE IF EXISTS `food_genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `food_genres` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `food_genres`
--

LOCK TABLES `food_genres` WRITE;
/*!40000 ALTER TABLE `food_genres` DISABLE KEYS */;
/*!40000 ALTER TABLE `food_genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `information`
--

DROP TABLE IF EXISTS `information`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `information` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `content` text COLLATE utf8_unicode_ci NOT NULL,
  `public` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `information`
--

LOCK TABLES `information` WRITE;
/*!40000 ALTER TABLE `information` DISABLE KEYS */;
/*!40000 ALTER TABLE `information` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `omniusers`
--

DROP TABLE IF EXISTS `omniusers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `omniusers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `provider` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uid` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `omniusers`
--

LOCK TABLES `omniusers` WRITE;
/*!40000 ALTER TABLE `omniusers` DISABLE KEYS */;
INSERT INTO `omniusers` VALUES (1,'twitter','38643985','matzbara','2012-06-30 02:37:13','2012-06-30 02:37:13');
/*!40000 ALTER TABLE `omniusers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prefectures`
--

DROP TABLE IF EXISTS `prefectures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prefectures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prefectures`
--

LOCK TABLES `prefectures` WRITE;
/*!40000 ALTER TABLE `prefectures` DISABLE KEYS */;
/*!40000 ALTER TABLE `prefectures` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recipe_advertisements`
--

DROP TABLE IF EXISTS `recipe_advertisements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recipe_advertisements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `image` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `alt` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recipe_advertisements`
--

LOCK TABLES `recipe_advertisements` WRITE;
/*!40000 ALTER TABLE `recipe_advertisements` DISABLE KEYS */;
/*!40000 ALTER TABLE `recipe_advertisements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recipe_comments`
--

DROP TABLE IF EXISTS `recipe_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recipe_comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `recipe_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `content` text COLLATE utf8_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recipe_comments`
--

LOCK TABLES `recipe_comments` WRITE;
/*!40000 ALTER TABLE `recipe_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `recipe_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recipe_food_genres`
--

DROP TABLE IF EXISTS `recipe_food_genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recipe_food_genres` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recipe_food_genres`
--

LOCK TABLES `recipe_food_genres` WRITE;
/*!40000 ALTER TABLE `recipe_food_genres` DISABLE KEYS */;
/*!40000 ALTER TABLE `recipe_food_genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recipe_foods`
--

DROP TABLE IF EXISTS `recipe_foods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recipe_foods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `recipe_food_genre_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recipe_foods`
--

LOCK TABLES `recipe_foods` WRITE;
/*!40000 ALTER TABLE `recipe_foods` DISABLE KEYS */;
/*!40000 ALTER TABLE `recipe_foods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recipe_foodstuff_rankings`
--

DROP TABLE IF EXISTS `recipe_foodstuff_rankings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recipe_foodstuff_rankings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `recipe_foodstuff_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recipe_foodstuff_rankings`
--

LOCK TABLES `recipe_foodstuff_rankings` WRITE;
/*!40000 ALTER TABLE `recipe_foodstuff_rankings` DISABLE KEYS */;
/*!40000 ALTER TABLE `recipe_foodstuff_rankings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recipe_foodstuffs`
--

DROP TABLE IF EXISTS `recipe_foodstuffs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recipe_foodstuffs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `recipe_id` int(11) NOT NULL,
  `recipe_food_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `amount` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `deleted_at` time DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recipe_foodstuffs`
--

LOCK TABLES `recipe_foodstuffs` WRITE;
/*!40000 ALTER TABLE `recipe_foodstuffs` DISABLE KEYS */;
/*!40000 ALTER TABLE `recipe_foodstuffs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recipe_like_logs`
--

DROP TABLE IF EXISTS `recipe_like_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recipe_like_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `recipe_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recipe_like_logs`
--

LOCK TABLES `recipe_like_logs` WRITE;
/*!40000 ALTER TABLE `recipe_like_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `recipe_like_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recipe_rankings`
--

DROP TABLE IF EXISTS `recipe_rankings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recipe_rankings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `recipe_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recipe_rankings`
--

LOCK TABLES `recipe_rankings` WRITE;
/*!40000 ALTER TABLE `recipe_rankings` DISABLE KEYS */;
/*!40000 ALTER TABLE `recipe_rankings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recipe_steps`
--

DROP TABLE IF EXISTS `recipe_steps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recipe_steps` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `recipe_id` int(11) NOT NULL,
  `image` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `movie_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `content` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `deleted_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recipe_steps`
--

LOCK TABLES `recipe_steps` WRITE;
/*!40000 ALTER TABLE `recipe_steps` DISABLE KEYS */;
/*!40000 ALTER TABLE `recipe_steps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recipes`
--

DROP TABLE IF EXISTS `recipes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recipes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `public` tinyint(1) NOT NULL DEFAULT '0',
  `recipe_image` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `one_point` text COLLATE utf8_unicode_ci NOT NULL,
  `like_count` int(11) NOT NULL DEFAULT '0',
  `eatstyle_id` int(11) NOT NULL DEFAULT '0',
  `amount` int(11) DEFAULT NULL,
  `view_count` int(11) NOT NULL DEFAULT '0',
  `recipe_food_genre_id` int(11) NOT NULL DEFAULT '0',
  `deleted_at` time DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recipes`
--

LOCK TABLES `recipes` WRITE;
/*!40000 ALTER TABLE `recipes` DISABLE KEYS */;
/*!40000 ALTER TABLE `recipes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restaurant_comments`
--

DROP TABLE IF EXISTS `restaurant_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `restaurant_comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `restaurant_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `comment` text COLLATE utf8_unicode_ci,
  `public` tinyint(1) NOT NULL DEFAULT '0',
  `point` float NOT NULL DEFAULT '0',
  `deleted_at` time DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurant_comments`
--

LOCK TABLES `restaurant_comments` WRITE;
/*!40000 ALTER TABLE `restaurant_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `restaurant_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restaurant_menus`
--

DROP TABLE IF EXISTS `restaurant_menus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `restaurant_menus` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `restaurant_id` int(11) NOT NULL,
  `view_style` int(11) NOT NULL DEFAULT '1',
  `image` blob,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `comment` text COLLATE utf8_unicode_ci,
  `price_comment` text COLLATE utf8_unicode_ci,
  `price` text COLLATE utf8_unicode_ci,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurant_menus`
--

LOCK TABLES `restaurant_menus` WRITE;
/*!40000 ALTER TABLE `restaurant_menus` DISABLE KEYS */;
/*!40000 ALTER TABLE `restaurant_menus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restaurant_profiles`
--

DROP TABLE IF EXISTS `restaurant_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `restaurant_profiles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `restaurant_id` int(11) NOT NULL,
  `top_photo` blob,
  `longitude` float DEFAULT NULL,
  `latitude` float DEFAULT NULL,
  `deleted_at` time DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurant_profiles`
--

LOCK TABLES `restaurant_profiles` WRITE;
/*!40000 ALTER TABLE `restaurant_profiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `restaurant_profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restaurants`
--

DROP TABLE IF EXISTS `restaurants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `restaurants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `public` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `sub_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `coupon_flg` tinyint(1) NOT NULL,
  `mobile_coupon_flg` tinyint(1) NOT NULL,
  `comment` text COLLATE utf8_unicode_ci NOT NULL,
  `postcode` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone_number` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fax_number` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `homepage` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `open_time` time DEFAULT NULL,
  `close_time` time DEFAULT NULL,
  `close_day` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted_at` time DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurants`
--

LOCK TABLES `restaurants` WRITE;
/*!40000 ALTER TABLE `restaurants` DISABLE KEYS */;
/*!40000 ALTER TABLE `restaurants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES ('20120427000000'),('20120427000010'),('20120427000020'),('20120427140308'),('20120501113348'),('20120512054405'),('20120512102136'),('20120513035424'),('20120513045452'),('20120513134902'),('20120518175654'),('20120518175755'),('20120518180638'),('20120518181238'),('20120518181558'),('20120518183410'),('20120518184249'),('20120521050034'),('20120523151342'),('20120524134151'),('20120524134234'),('20120525144054'),('20120525145741'),('20120527105138'),('20120614003308'),('20120618145939'),('20120624045235'),('20120624053904');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `search_logs`
--

DROP TABLE IF EXISTS `search_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `search_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `words` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `location` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `search_logs`
--

LOCK TABLES `search_logs` WRITE;
/*!40000 ALTER TABLE `search_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `search_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `toppage_contents`
--

DROP TABLE IF EXISTS `toppage_contents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `toppage_contents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `recommend_recipe_id` int(11) NOT NULL,
  `recommend_recipe_genre_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `toppage_contents`
--

LOCK TABLES `toppage_contents` WRITE;
/*!40000 ALTER TABLE `toppage_contents` DISABLE KEYS */;
/*!40000 ALTER TABLE `toppage_contents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tpl_sets`
--

DROP TABLE IF EXISTS `tpl_sets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tpl_sets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tpl_sets`
--

LOCK TABLES `tpl_sets` WRITE;
/*!40000 ALTER TABLE `tpl_sets` DISABLE KEYS */;
/*!40000 ALTER TABLE `tpl_sets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_profile_visibilities`
--

DROP TABLE IF EXISTS `user_profile_visibilities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_profile_visibilities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_profile_id` int(11) DEFAULT '1',
  `nickname` tinyint(1) NOT NULL DEFAULT '1',
  `sex` tinyint(1) NOT NULL DEFAULT '1',
  `first_name` tinyint(1) DEFAULT '1',
  `last_name` tinyint(1) DEFAULT '1',
  `blood_type` tinyint(1) NOT NULL DEFAULT '1',
  `birthday` tinyint(1) NOT NULL DEFAULT '1',
  `mail_address` tinyint(1) NOT NULL DEFAULT '1',
  `postcode` tinyint(1) NOT NULL DEFAULT '1',
  `address` tinyint(1) NOT NULL DEFAULT '1',
  `address_point` tinyint(1) NOT NULL DEFAULT '1',
  `comment` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_profile_visibilities`
--

LOCK TABLES `user_profile_visibilities` WRITE;
/*!40000 ALTER TABLE `user_profile_visibilities` DISABLE KEYS */;
INSERT INTO `user_profile_visibilities` VALUES (1,1,1,1,1,1,1,1,1,1,1,1,1,'2012-06-30 02:39:00','2012-06-30 02:39:00');
/*!40000 ALTER TABLE `user_profile_visibilities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_profiles`
--

DROP TABLE IF EXISTS `user_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_profiles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `image` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `nickname` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `sex` int(11) DEFAULT NULL,
  `first_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `last_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `blood_type` int(11) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `mail_address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `postcode` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `address` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `comment` text COLLATE utf8_unicode_ci NOT NULL,
  `recipe_count` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_profiles`
--

LOCK TABLES `user_profiles` WRITE;
/*!40000 ALTER TABLE `user_profiles` DISABLE KEYS */;
INSERT INTO `user_profiles` VALUES (1,1,NULL,'matzbara',1,'','',NULL,'2016-10-02','babanba.n@gmail.com','','','',0,'2012-06-30 02:39:00','2012-06-30 02:39:00');
/*!40000 ALTER TABLE `user_profiles` ENABLE KEYS */;
UNLOCK TABLES;

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
  `omniuser_id` int(11) DEFAULT NULL,
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
INSERT INTO `users` VALUES (1,'babanba.n@gmail.com','$2a$10$DuVMagXbgW5Rk3Yu0fJXP.021NuesP.vsAs3fgMKMmfmKmOvli0PS',NULL,NULL,NULL,2,'2012-06-04 15:47:08','2012-05-26 00:36:40','127.0.0.1','127.0.0.1','2012-05-26 00:36:40','2012-06-29 23:00:12',NULL,NULL,NULL,NULL,1),(2,'1@test.jp','$2a$10$IbUu9y4oTZObacdTQhBwHOe49FfWb3kUAZNSIiCzgPxgwqqM56Uhq',NULL,NULL,NULL,1,'2012-06-05 00:24:47','2012-06-05 00:24:47','127.0.0.1','127.0.0.1','2012-06-05 00:24:47','2012-06-05 00:24:47',NULL,NULL,NULL,NULL,NULL),(3,'2@test.jp','$2a$10$HeUwWIYyBhoXc3IGdaWsteBDQyNPu1ACLDJrE1rsbtaLrrsw..t1W',NULL,NULL,NULL,1,'2012-06-05 00:25:09','2012-06-05 00:25:09','127.0.0.1','127.0.0.1','2012-06-05 00:25:09','2012-06-05 00:25:09',NULL,NULL,NULL,NULL,NULL),(4,'3@test.jp','$2a$10$4wQ/u6hpjgfauItR8mkgM.2zTIQGEhwV/ftPlnlyv0IES7H2SUq0u',NULL,NULL,NULL,1,'2012-06-05 00:25:30','2012-06-05 00:25:30','127.0.0.1','127.0.0.1','2012-06-05 00:25:30','2012-06-05 00:25:30',NULL,NULL,NULL,NULL,NULL),(5,'4@test.jp','$2a$10$eLPfr2j418KWTRtgTIdsbOlH.Fem4E.Tj2ROwORtPUq2yvg3lERUO',NULL,NULL,NULL,1,'2012-06-05 00:25:49','2012-06-05 00:25:49','127.0.0.1','127.0.0.1','2012-06-05 00:25:49','2012-06-05 00:25:49',NULL,NULL,NULL,NULL,NULL),(6,'5@test.jp','$2a$10$TJWRQanfpLUTfPrLdY3doudhLxI.81V/lRXgh.trW6UvJekfXKBFq',NULL,NULL,NULL,1,'2012-06-05 00:27:17','2012-06-05 00:27:17','127.0.0.1','127.0.0.1','2012-06-05 00:27:17','2012-06-05 00:27:17',NULL,NULL,NULL,NULL,NULL),(7,'6@test.jp','$2a$10$gw0nDAHGJ2m4FCMyXynTRuA2l24SsQpqwrfh/yhS6S2IKukmdT/BG',NULL,NULL,NULL,1,'2012-06-05 00:27:35','2012-06-05 00:27:35','127.0.0.1','127.0.0.1','2012-06-05 00:27:35','2012-06-05 00:27:35',NULL,NULL,NULL,NULL,NULL),(8,'7@test.jp','$2a$10$nOLdqofa/vN43UVbz32JNeSo1JSxN07a7QzX3qPCIb9rXUc5R8zKm',NULL,NULL,NULL,1,'2012-06-05 00:28:03','2012-06-05 00:28:03','127.0.0.1','127.0.0.1','2012-06-05 00:28:03','2012-06-05 00:28:03',NULL,NULL,NULL,NULL,NULL),(9,'8@test.jp','$2a$10$DM4JGN5kos09M80dIG.qZeG/yf6Plz5U.hxH.uLeFBdyE1qIenK72',NULL,NULL,NULL,1,'2012-06-05 00:28:24','2012-06-05 00:28:24','127.0.0.1','127.0.0.1','2012-06-05 00:28:24','2012-06-05 00:28:24',NULL,NULL,NULL,NULL,NULL),(10,'9@test.jp','$2a$10$fRG1ITFJQeDCr2xRqETvAeVj0GynYl0ug933/L198CkEXRDPYSQLS',NULL,NULL,NULL,1,'2012-06-05 00:28:38','2012-06-05 00:28:38','127.0.0.1','127.0.0.1','2012-06-05 00:28:38','2012-06-05 00:28:38',NULL,NULL,NULL,NULL,NULL),(11,'10@test.jp','$2a$10$Uvy7sPNLIflcxrHQC3r3IeFCgOFsI63IQdwvZtZVqvKM677EoTNDW',NULL,NULL,NULL,1,'2012-06-05 00:29:05','2012-06-05 00:29:05','127.0.0.1','127.0.0.1','2012-06-05 00:29:05','2012-06-05 00:29:05',NULL,NULL,NULL,NULL,NULL),(12,'11@test.jp','$2a$10$JyZDP4eQKVbU1c.id8EVjeNt2rx4Ja7nDCHPkZRxXUjZ7XpUv3d5O',NULL,NULL,NULL,1,'2012-06-05 12:19:45','2012-06-05 12:19:45','127.0.0.1','127.0.0.1','2012-06-05 12:19:45','2012-06-05 12:19:45',NULL,NULL,NULL,NULL,NULL),(13,'12@test.jp','$2a$10$DgaxP/pLSCfusLa7rkeva.JinAyTz.7IFrnoK4lNwsmhYrkhlxcJ6',NULL,NULL,NULL,1,'2012-06-05 12:20:03','2012-06-05 12:20:03','127.0.0.1','127.0.0.1','2012-06-05 12:20:03','2012-06-05 12:20:03',NULL,NULL,NULL,NULL,NULL),(14,'13@test.jp','$2a$10$5I215esVdz5Rk7XFfEAshOJCUhOeIBabRzsvIerphiMvXwkCooY1e',NULL,NULL,NULL,1,'2012-06-05 12:20:19','2012-06-05 12:20:19','127.0.0.1','127.0.0.1','2012-06-05 12:20:19','2012-06-05 12:20:19',NULL,NULL,NULL,NULL,NULL),(15,'14@test.jp','$2a$10$nw5UlnIIAwt0yjrNqZRIx.I8TWLmAvojQ8M50TruTLP5X9ZJoMOYO',NULL,NULL,NULL,1,'2012-06-05 12:20:38','2012-06-05 12:20:38','127.0.0.1','127.0.0.1','2012-06-05 12:20:38','2012-06-05 12:20:38',NULL,NULL,NULL,NULL,NULL),(16,'15@test.jp','$2a$10$Emds607SK8Nqy/GHGhQc3.rxIxi5RuUcbA8T.niDASYH.otqB2NLq',NULL,NULL,NULL,1,'2012-06-05 12:20:55','2012-06-05 12:20:55','127.0.0.1','127.0.0.1','2012-06-05 12:20:55','2012-06-05 12:20:55',NULL,NULL,NULL,NULL,NULL),(17,'16@test.jp','$2a$10$KTYk/gT9Q3hPh9JsB8lLIuqhmytvlcE4Loj.aOSZ..tKBmA5Wy47m',NULL,NULL,NULL,1,'2012-06-05 12:21:10','2012-06-05 12:21:10','127.0.0.1','127.0.0.1','2012-06-05 12:21:10','2012-06-05 12:21:10',NULL,NULL,NULL,NULL,NULL),(18,'17@test.jp','$2a$10$CE5/1Vh.sOYhU.FfVmMuKOMRHs8eSVaEkR6Rkc6T.7Wvzp/LTOB4O',NULL,NULL,NULL,1,'2012-06-05 12:21:25','2012-06-05 12:21:25','127.0.0.1','127.0.0.1','2012-06-05 12:21:25','2012-06-05 12:21:25',NULL,NULL,NULL,NULL,NULL),(19,'18@test.jp','$2a$10$tVi2AOmf3R/5sOQ1QEooKu7tkP8OrboWeibdIXT2njJU3Im20X0yW',NULL,NULL,NULL,1,'2012-06-05 12:21:39','2012-06-05 12:21:39','127.0.0.1','127.0.0.1','2012-06-05 12:21:39','2012-06-05 12:21:39',NULL,NULL,NULL,NULL,NULL),(20,'19@test.jp','$2a$10$gF4S79NeOlDt9YRt.ajPUO92i9p6JVSWRGqQppkiSFHixc32s5GcK',NULL,NULL,NULL,1,'2012-06-05 12:21:55','2012-06-05 12:21:55','127.0.0.1','127.0.0.1','2012-06-05 12:21:55','2012-06-05 12:21:55',NULL,NULL,NULL,NULL,NULL),(21,'20@test.jp','$2a$10$2/SD3u6NuO6vtmx3hcT7WOSRuG30yOLUziyoZsjnIG7xHSM6kTO3G',NULL,NULL,NULL,1,'2012-06-05 12:22:12','2012-06-05 12:22:12','127.0.0.1','127.0.0.1','2012-06-05 12:22:12','2012-06-05 12:22:12',NULL,NULL,NULL,NULL,NULL);
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

-- Dump completed on 2012-06-30 11:45:48
