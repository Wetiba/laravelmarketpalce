# ************************************************************
# Sequel Pro SQL dump
# Version 5446
#
# https://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 8.1.0)
# Database: buckleup
# Generation Time: 2023-12-19 09:35:33 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
SET NAMES utf8mb4;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table account_transactions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `account_transactions`;

CREATE TABLE `account_transactions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `account_id` int NOT NULL,
  `amount` double(11,2) NOT NULL,
  `type` enum('deposit','withdrawal') COLLATE utf8mb4_general_ci DEFAULT NULL,
  `trx_reference` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `user_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;



# Dump of table account_wallets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `account_wallets`;

CREATE TABLE `account_wallets` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `balance` double(11,2) NOT NULL,
  `balance_limit` double(11,2) NOT NULL DEFAULT '0.00',
  `type` enum('vendor','customer') COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `account_wallets` WRITE;
/*!40000 ALTER TABLE `account_wallets` DISABLE KEYS */;

INSERT INTO `account_wallets` (`id`, `user_id`, `balance`, `balance_limit`, `type`, `created_at`, `updated_at`)
VALUES
	(1,1,100.10,0.00,'vendor','2023-11-01 19:07:42','2023-11-01 19:07:42'),
	(2,1,150.00,2000.00,'customer','2023-11-01 19:07:42','2023-11-01 19:07:42'),
	(3,5,2000.00,0.00,'customer','2023-11-13 06:23:04','2023-11-13 06:23:04'),
	(4,5,0.00,0.00,'vendor','2023-11-13 06:23:04','2023-11-13 06:23:04'),
	(5,2,0.00,2000.00,'customer','2023-11-13 14:29:16','2023-11-13 14:29:16'),
	(6,2,0.00,0.00,'vendor','2023-11-13 14:29:16','2023-11-13 14:29:16'),
	(7,3,0.00,2000.00,'customer','2023-11-13 14:31:19','2023-11-13 14:31:19'),
	(8,3,0.00,0.00,'vendor','2023-11-13 14:31:19','2023-11-13 14:31:19'),
	(9,6,0.00,0.00,'customer','2023-11-13 14:36:34','2023-11-13 14:36:34'),
	(10,6,0.00,0.00,'vendor','2023-11-13 14:36:34','2023-11-13 14:36:34');

/*!40000 ALTER TABLE `account_wallets` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table admin_notifications
# ------------------------------------------------------------

DROP TABLE IF EXISTS `admin_notifications`;

CREATE TABLE `admin_notifications` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL DEFAULT '0',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `read_status` tinyint(1) NOT NULL DEFAULT '0',
  `click_url` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `admin_notifications` WRITE;
/*!40000 ALTER TABLE `admin_notifications` DISABLE KEYS */;

INSERT INTO `admin_notifications` (`id`, `user_id`, `title`, `read_status`, `click_url`, `created_at`, `updated_at`)
VALUES
	(1,1,'New member registered',0,'/admin/users/detail/1','2022-05-24 06:24:06','2022-05-24 06:24:06'),
	(2,0,'A new support ticket has opened ',1,'/admin/tickets/view/1','2022-05-24 08:40:46','2023-10-28 03:03:00'),
	(3,1,'New member registered',1,'/admin/users/detail/1','2023-10-27 20:30:37','2023-10-31 04:04:40'),
	(4,1,'New support ticket has opened',1,'/admin/tickets/view/1','2023-10-27 20:32:10','2023-10-27 20:32:21'),
	(5,0,'SMTP Error: Could not connect to SMTP host. Failed to connect to server',0,'#','2023-11-04 17:23:58','2023-11-04 17:23:58'),
	(6,0,'SMTP Error: Could not connect to SMTP host. Failed to connect to server',0,'#','2023-11-04 17:24:13','2023-11-04 17:24:13'),
	(7,0,'SMTP Error: Could not connect to SMTP host. Failed to connect to server',0,'#','2023-11-04 17:38:57','2023-11-04 17:38:57'),
	(8,2,'New member registered',0,'/admin/users/detail/2','2023-11-09 14:23:27','2023-11-09 14:23:27'),
	(9,3,'New member registered',0,'/admin/users/detail/3','2023-11-12 07:04:17','2023-11-12 07:04:17'),
	(10,4,'New member registered',0,'/admin/users/detail/4','2023-11-12 13:23:27','2023-11-12 13:23:27'),
	(11,5,'New member registered',0,'/admin/users/detail/5','2023-11-13 06:23:04','2023-11-13 06:23:04'),
	(12,6,'New member registered',0,'/admin/users/detail/6','2023-11-13 14:36:34','2023-11-13 14:36:34'),
	(13,0,'SMTP Error: Could not connect to SMTP host. Failed to connect to server',0,'#','2023-12-18 05:42:00','2023-12-18 05:42:00'),
	(14,0,'SMTP Error: Could not connect to SMTP host. Failed to connect to server',0,'#','2023-12-18 05:44:07','2023-12-18 05:44:07');

/*!40000 ALTER TABLE `admin_notifications` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table admin_password_resets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `admin_password_resets`;

CREATE TABLE `admin_password_resets` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `token` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `admin_password_resets` WRITE;
/*!40000 ALTER TABLE `admin_password_resets` DISABLE KEYS */;

INSERT INTO `admin_password_resets` (`id`, `email`, `token`, `status`, `created_at`, `updated_at`)
VALUES
	(1,'pmaxmorales@hotmail.com','597255',1,'2023-12-18 05:41:59',NULL);

/*!40000 ALTER TABLE `admin_password_resets` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table admins
# ------------------------------------------------------------

DROP TABLE IF EXISTS `admins`;

CREATE TABLE `admins` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `username` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`,`username`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `admins` WRITE;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;

INSERT INTO `admins` (`id`, `name`, `email`, `username`, `email_verified_at`, `image`, `password`, `remember_token`, `created_at`, `updated_at`)
VALUES
	(1,'Super Admin','pmaxmorales@hotmail.com','admin',NULL,NULL,'$2y$10$RP8VHEzpXABDqjRxp2hNY..FhazFT58XNKWNkqSD2EY3HscF4gZXq','VHB2fFqvjcdWRVYG8IVXXI2foi7bxtdrfPTc9PeO1ZNejd5FlbQulcHAPHDm',NULL,'2023-12-18 05:44:06');

/*!40000 ALTER TABLE `admins` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table advertisements
# ------------------------------------------------------------

DROP TABLE IF EXISTS `advertisements`;

CREATE TABLE `advertisements` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` text COLLATE utf8mb4_unicode_ci,
  `status` int NOT NULL DEFAULT '1',
  `size` text COLLATE utf8mb4_unicode_ci,
  `redirect_url` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `impression` int NOT NULL DEFAULT '0',
  `click` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table affiliate_coupons
# ------------------------------------------------------------

DROP TABLE IF EXISTS `affiliate_coupons`;

CREATE TABLE `affiliate_coupons` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `coupon_id` bigint NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '0: inactive, 1: active',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `affiliate_coupons` WRITE;
/*!40000 ALTER TABLE `affiliate_coupons` DISABLE KEYS */;

INSERT INTO `affiliate_coupons` (`id`, `user_id`, `coupon_id`, `status`, `created_at`, `updated_at`)
VALUES
	(1,1,4,1,'2023-11-01 15:23:10','2023-11-01 15:23:10'),
	(2,1,2,1,'2023-11-01 16:22:00','2023-11-01 16:22:00'),
	(3,1,1,1,'2023-11-01 16:29:55','2023-11-01 16:29:55'),
	(4,1,3,1,'2023-11-01 16:33:36','2023-11-01 16:33:36');

/*!40000 ALTER TABLE `affiliate_coupons` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table categories
# ------------------------------------------------------------

DROP TABLE IF EXISTS `categories`;

CREATE TABLE `categories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `icon` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;

INSERT INTO `categories` (`id`, `name`, `icon`, `status`, `created_at`, `updated_at`)
VALUES
	(1,'Health','<i class=\"fab fa-accessible-icon\"></i>',1,'2023-10-27 20:21:26','2023-10-27 20:21:26');

/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table coupon_reports
# ------------------------------------------------------------

DROP TABLE IF EXISTS `coupon_reports`;

CREATE TABLE `coupon_reports` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `coupon_id` int unsigned NOT NULL DEFAULT '0',
  `action` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `number` int unsigned NOT NULL DEFAULT '0',
  `ip` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `coupon_reports` WRITE;
/*!40000 ALTER TABLE `coupon_reports` DISABLE KEYS */;

INSERT INTO `coupon_reports` (`id`, `coupon_id`, `action`, `number`, `ip`, `date`, `created_at`, `updated_at`)
VALUES
	(1,1,'impression',5,'127.0.0.1','2023-10-30','2023-10-30 21:45:12','2023-10-31 03:42:33'),
	(2,2,'impression',5,'127.0.0.1','2023-10-30','2023-10-30 21:45:12','2023-10-31 03:42:33'),
	(3,1,'click',2,'127.0.0.1','2023-10-30','2023-10-31 03:42:36','2023-10-31 03:42:56');

/*!40000 ALTER TABLE `coupon_reports` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table coupons
# ------------------------------------------------------------

DROP TABLE IF EXISTS `coupons`;

CREATE TABLE `coupons` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL DEFAULT '0',
  `category_id` int unsigned NOT NULL DEFAULT '0',
  `store_id` int unsigned NOT NULL DEFAULT '0',
  `title` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `coupon_code` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ending_date` datetime DEFAULT NULL,
  `image` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `featured_validity` date DEFAULT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cashback` decimal(5,2) unsigned DEFAULT '0.00',
  `today_deal` int unsigned DEFAULT '0',
  `top_deal` int unsigned NOT NULL DEFAULT '0',
  `impression` int unsigned NOT NULL DEFAULT '0',
  `click` int unsigned NOT NULL DEFAULT '0',
  `copy` int unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '0: Pending\r\n1: Approved/Active\r\n2: Approved/Inactive\r\n3: Rejected',
  `reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quantity_to_use` int unsigned NOT NULL DEFAULT '0',
  `current_use` int unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `coupons` WRITE;
/*!40000 ALTER TABLE `coupons` DISABLE KEYS */;

INSERT INTO `coupons` (`id`, `user_id`, `category_id`, `store_id`, `title`, `coupon_code`, `ending_date`, `image`, `featured_validity`, `url`, `cashback`, `today_deal`, `top_deal`, `impression`, `click`, `copy`, `status`, `reason`, `description`, `quantity_to_use`, `current_use`, `created_at`, `updated_at`)
VALUES
	(1,0,1,1,'Roger','45454545','2024-05-31 00:00:00','653c2b24e95841698442020.jpg',NULL,'https://buckleupsavings.com/product-category-v2/',20.00,0,0,5,2,0,0,NULL,'Este cupon',3,2,'2023-10-27 20:27:01','2023-11-01 16:29:55'),
	(2,0,1,1,'te','c','2023-11-29 00:00:00','6553d975c967f1699993973.png',NULL,'https://www.theindustrymodelmgmt.com/model/new-york/management-board/2279-lilia-butler/12930-digitals',20.00,0,0,5,0,0,1,NULL,'test',3,2,'2023-10-27 20:35:31','2023-11-14 12:32:53'),
	(3,1,1,2,'test','3434334','2024-01-19 00:00:00','65408597d79cd1698727319.png',NULL,'https://www.theindustrymodelmgmt.com/model/new-york/management-board/2279-lilia-butler/12930-digitals',20.00,0,0,0,0,0,1,NULL,'tset',3,1,'2023-10-31 03:42:00','2023-10-31 04:09:06'),
	(4,1,1,2,'asdfasdf','34344443','2024-02-23 00:00:00','65408acc1582c1698728652.png',NULL,'https://www.theindustrymodelmgmt.com/model/new-york/management-board/2279-lilia-butler/12930-digitals',20.00,1,0,0,0,0,1,NULL,'tstsa',3,1,'2023-10-31 04:04:12','2023-12-18 19:55:14'),
	(5,1,1,2,'test','afasdf','2024-01-25 00:00:00',NULL,NULL,NULL,0.00,0,0,0,0,0,0,NULL,'test',0,0,'2023-11-01 18:04:39','2023-11-01 18:04:39'),
	(6,1,1,2,'test','12345','2024-01-04 10:00:00',NULL,NULL,NULL,0.00,0,0,0,0,0,0,NULL,'2000 in savings',0,0,'2023-11-05 01:18:01','2023-11-05 01:18:01');

/*!40000 ALTER TABLE `coupons` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table deposits
# ------------------------------------------------------------

DROP TABLE IF EXISTS `deposits`;

CREATE TABLE `deposits` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL DEFAULT '0',
  `coupon_id` int NOT NULL DEFAULT '0',
  `package_id` int NOT NULL DEFAULT '0',
  `method_code` int unsigned NOT NULL DEFAULT '0',
  `amount` decimal(28,8) NOT NULL DEFAULT '0.00000000',
  `method_currency` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `charge` decimal(28,8) NOT NULL DEFAULT '0.00000000',
  `rate` decimal(28,8) NOT NULL DEFAULT '0.00000000',
  `final_amo` decimal(28,8) NOT NULL DEFAULT '0.00000000',
  `detail` text COLLATE utf8mb4_unicode_ci,
  `btc_amo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `btc_wallet` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `trx` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `try` int NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1=>success, 2=>pending, 3=>cancel',
  `from_api` tinyint(1) NOT NULL DEFAULT '0',
  `admin_feedback` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `deposits` WRITE;
/*!40000 ALTER TABLE `deposits` DISABLE KEYS */;

INSERT INTO `deposits` (`id`, `user_id`, `coupon_id`, `package_id`, `method_code`, `amount`, `method_currency`, `charge`, `rate`, `final_amo`, `detail`, `btc_amo`, `btc_wallet`, `trx`, `try`, `status`, `from_api`, `admin_feedback`, `created_at`, `updated_at`)
VALUES
	(1,1,3,1,114,100.00000000,'USD',2.80000000,1.00000000,102.80000000,NULL,'0','cs_test_a1R6tc0m9p40zKZnv3y3qM2gDilCNkWne6dh3pBNVpcSn7Q3h3rccy6Reo','5T8ZDWDQ15RV',0,0,0,NULL,'2023-10-31 04:14:50','2023-10-31 04:14:54'),
	(2,1,4,1,114,100.00000000,'USD',2.80000000,1.00000000,102.80000000,NULL,'0','','N3FKX1CG858V',0,0,0,NULL,'2023-11-03 00:34:10','2023-11-03 00:34:10');

/*!40000 ALTER TABLE `deposits` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table extensions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `extensions`;

CREATE TABLE `extensions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `act` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `script` text COLLATE utf8mb4_unicode_ci,
  `shortcode` text COLLATE utf8mb4_unicode_ci COMMENT 'object',
  `support` text COLLATE utf8mb4_unicode_ci COMMENT 'help section',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1=>enable, 2=>disable',
  `deleted_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `extensions` WRITE;
/*!40000 ALTER TABLE `extensions` DISABLE KEYS */;

INSERT INTO `extensions` (`id`, `act`, `name`, `description`, `image`, `script`, `shortcode`, `support`, `status`, `deleted_at`, `created_at`, `updated_at`)
VALUES
	(1,'tawk-chat','Tawk.to','Key location is shown bellow','tawky_big.png','<script>\r\n                        var Tawk_API=Tawk_API||{}, Tawk_LoadStart=new Date();\r\n                        (function(){\r\n                        var s1=document.createElement(\"script\"),s0=document.getElementsByTagName(\"script\")[0];\r\n                        s1.async=true;\r\n                        s1.src=\"https://embed.tawk.to/{{app_key}}\";\r\n                        s1.charset=\"UTF-8\";\r\n                        s1.setAttribute(\"crossorigin\",\"*\");\r\n                        s0.parentNode.insertBefore(s1,s0);\r\n                        })();\r\n                    </script>','{\"app_key\":{\"title\":\"App Key\",\"value\":\"------\"}}','twak.png',0,NULL,'2019-10-18 23:16:05','2022-05-11 05:33:48'),
	(2,'google-recaptcha2','Google Recaptcha 2','Key location is shown bellow','recaptcha3.png','\n<script src=\"https://www.google.com/recaptcha/api.js\"></script>\n<div class=\"g-recaptcha\" data-sitekey=\"{{site_key}}\" data-callback=\"verifyCaptcha\"></div>\n<div id=\"g-recaptcha-error\"></div>','{\"site_key\":{\"title\":\"Site Key\",\"value\":\"----\"},\"secret_key\":{\"title\":\"Secret Key\",\"value\":\"----\"}}','recaptcha.png',0,NULL,'2019-10-18 23:16:05','2022-05-24 08:40:30'),
	(3,'custom-captcha','Custom Captcha','Just put any random string','customcaptcha.png',NULL,'{\"random_key\":{\"title\":\"Random String\",\"value\":\"SecureString\"}}','na',0,NULL,'2019-10-18 23:16:05','2022-05-24 05:44:41'),
	(4,'google-analytics','Google Analytics','Key location is shown bellow','google_analytics.png','<script async src=\"https://www.googletagmanager.com/gtag/js?id={{app_key}}\"></script>\r\n                <script>\r\n                  window.dataLayer = window.dataLayer || [];\r\n                  function gtag(){dataLayer.push(arguments);}\r\n                  gtag(\"js\", new Date());\r\n                \r\n                  gtag(\"config\", \"{{app_key}}\");\r\n                </script>','{\"app_key\":{\"title\":\"App Key\",\"value\":\"------\"}}','ganalytics.png',0,NULL,NULL,'2021-05-04 10:19:12'),
	(5,'fb-comment','Facebook Comment ','Key location is shown bellow','Facebook.png','<div id=\"fb-root\"></div><script async defer crossorigin=\"anonymous\" src=\"https://connect.facebook.net/en_GB/sdk.js#xfbml=1&version=v4.0&appId={{app_key}}&autoLogAppEvents=1\"></script>','{\"app_key\":{\"title\":\"App Key\",\"value\":\"----\"}}','fb_com.PNG',0,NULL,NULL,'2022-05-14 10:17:18');

/*!40000 ALTER TABLE `extensions` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table forms
# ------------------------------------------------------------

DROP TABLE IF EXISTS `forms`;

CREATE TABLE `forms` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `act` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `form_data` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table frontends
# ------------------------------------------------------------

DROP TABLE IF EXISTS `frontends`;

CREATE TABLE `frontends` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `data_keys` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data_values` longtext COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `frontends` WRITE;
/*!40000 ALTER TABLE `frontends` DISABLE KEYS */;

INSERT INTO `frontends` (`id`, `data_keys`, `data_values`, `created_at`, `updated_at`)
VALUES
	(1,'seo.data','{\"seo_image\":\"1\",\"keywords\":[\"Buckleup Sabings\"],\"description\":\"Partnership with Buckle up Savings.. is launching! Join us on the call to learn more about the entire Business and how to activate your account with Buckle up savings.\",\"social_title\":\"Buckleup Savings - Affiliate Platform\",\"social_description\":\"Want to know more about this great opportunity?\\nDouble your Buying Power with Every Swipe! The first 1000 people contacting me will get a free Subscription to our Marketplace to start their online business.\",\"image\":\"653c28162348c1698441238.jpg\"}','2020-07-04 23:42:52','2023-11-04 19:43:23'),
	(24,'about.content','{\"has_image\":\"1\",\"heading\":\"Latest News\",\"sub_heading\":\"Register New Account\",\"description\":\"fdg sdfgsdf g ggg\",\"about_icon\":\"<i class=\\\"las la-address-card\\\"><\\/i>\",\"background_image\":\"60951a84abd141620384388.png\",\"about_image\":\"5f9914e907ace1603867881.jpg\"}','2020-10-28 00:51:20','2021-05-07 10:16:28'),
	(25,'blog.content','{\"heading\":\"Recent Posts\"}','2020-10-28 00:51:34','2022-05-09 07:38:29'),
	(27,'contact_us.content','{\"title\":\"Get In Touch With Us\",\"short_details\":\"Maecenas nec odio et ante tincidunt tempus. Donec vitae apitlibero venenatis.\",\"contact_details\":\"15205 North Kierland Blvd.100 Old City House\",\"email_address\":\"info@buckleupsavings.com\",\"contact_number\":\"+123 - 4567890\",\"map_url\":\"https:\\/\\/www.google.com\\/maps\\/embed?pb=!1m18!1m12!1m3!1d208957.7521241648!2d-106.81656260859592!3d35.0826103212825!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x87220addd309837b%3A0xc0d3f8ceb8d9f6fd!2z4KaG4Kay4Kas4KaV4Kaw4KeN4KaV4Ka_LCDgpqjgpr_gpokg4Kau4KeH4KaV4KeN4Ka44Ka_4KaV4KeLLCDgpq7gpr7gprDgp43gppXgpr_gpqgg4Kav4KeB4KaV4KeN4Kak4Kaw4Ka-4Ka34KeN4Kaf4KeN4Kaw!5e0!3m2!1sbn!2sbd!4v1652796215061!5m2!1sbn!2sbd\"}','2020-10-28 00:59:19','2023-11-04 18:52:00'),
	(28,'counter.content','{\"heading\":\"Latest News\",\"sub_heading\":\"Register New Account\"}','2020-10-28 01:04:02','2020-10-28 01:04:02'),
	(31,'social_icon.element','{\"title\":\"Facebook\",\"social_icon\":\"<i class=\\\"fab fa-facebook-f\\\"><\\/i>\",\"url\":\"https:\\/\\/www.facebook.com\\/\"}','2020-11-12 04:07:30','2022-05-17 04:34:31'),
	(33,'feature.content','{\"heading\":\"asdf\",\"sub_heading\":\"asdf\"}','2021-01-03 23:40:54','2021-01-03 23:40:55'),
	(34,'feature.element','{\"title\":\"asdf\",\"description\":\"asdf\",\"feature_icon\":\"asdf\"}','2021-01-03 23:41:02','2021-01-03 23:41:02'),
	(35,'service.element','{\"trx_type\":\"withdraw\",\"service_icon\":\"<i class=\\\"las la-highlighter\\\"><\\/i>\",\"title\":\"asdfasdf\",\"description\":\"asdfasdfasdfasdf\"}','2021-03-06 01:12:10','2021-03-06 01:12:10'),
	(36,'service.content','{\"trx_type\":\"deposit\",\"heading\":\"asdf fffff\",\"subheading\":\"555\"}','2021-03-06 01:27:34','2022-03-30 08:07:06'),
	(39,'banner.content','{\"has_image\":\"1\",\"heading\":\"THIS WILL BLOW YOUR MIND.\",\"background_image\":\"654042202e51e1698710048.png\"}','2021-05-02 06:09:30','2023-11-04 18:41:42'),
	(41,'cookie.data','{\"short_desc\":\"We may use cookies or any other tracking technologies when you visit our website, including any other media form, mobile website, or mobile application related or connected to help customize the Site and improve your experience.\",\"description\":\"<div class=\\\"mb-5\\\" style=\\\"color: rgb(111, 111, 111); font-family: Nunito, sans-serif; margin-bottom: 3rem !important;\\\"><h3 class=\\\"mb-3\\\" style=\\\"font-weight: 600; line-height: 1.3; font-size: 24px; font-family: Exo, sans-serif; color: rgb(54, 54, 54);\\\">What information do we collect?<\\/h3><p class=\\\"font-18\\\" style=\\\"margin-right: 0px; margin-left: 0px; font-size: 18px !important;\\\">We gather data from you when you register on our site, submit a request, buy any services, react to an overview, or round out a structure. At the point when requesting any assistance or enrolling on our site, as suitable, you might be approached to enter your: name, email address, or telephone number. You may, nonetheless, visit our site anonymously.<\\/p><\\/div><div class=\\\"mb-5\\\" style=\\\"color: rgb(111, 111, 111); font-family: Nunito, sans-serif; margin-bottom: 3rem !important;\\\"><h3 class=\\\"mb-3\\\" style=\\\"font-weight: 600; line-height: 1.3; font-size: 24px; font-family: Exo, sans-serif; color: rgb(54, 54, 54);\\\">How do we protect your information?<\\/h3><p class=\\\"font-18\\\" style=\\\"margin-right: 0px; margin-left: 0px; font-size: 18px !important;\\\">All provided delicate\\/credit data is sent through Stripe.<br>After an exchange, your private data (credit cards, social security numbers, financials, and so on) won\'t be put away on our workers.<\\/p><\\/div><div class=\\\"mb-5\\\" style=\\\"color: rgb(111, 111, 111); font-family: Nunito, sans-serif; margin-bottom: 3rem !important;\\\"><h3 class=\\\"mb-3\\\" style=\\\"font-weight: 600; line-height: 1.3; font-size: 24px; font-family: Exo, sans-serif; color: rgb(54, 54, 54);\\\">Do we disclose any information to outside parties?<\\/h3><p class=\\\"font-18\\\" style=\\\"margin-right: 0px; margin-left: 0px; font-size: 18px !important;\\\">We don\'t sell, exchange, or in any case move to outside gatherings by and by recognizable data. This does exclude confided in outsiders who help us in working our site, leading our business, or adjusting you, since those gatherings consent to keep this data private. We may likewise deliver your data when we accept discharge is suitable to follow the law, implement our site strategies, or ensure our own or others\' rights, property, or wellbeing.<\\/p><\\/div><div class=\\\"mb-5\\\" style=\\\"color: rgb(111, 111, 111); font-family: Nunito, sans-serif; margin-bottom: 3rem !important;\\\"><h3 class=\\\"mb-3\\\" style=\\\"font-weight: 600; line-height: 1.3; font-size: 24px; font-family: Exo, sans-serif; color: rgb(54, 54, 54);\\\">Children\'s Online Privacy Protection Act Compliance<\\/h3><p class=\\\"font-18\\\" style=\\\"margin-right: 0px; margin-left: 0px; font-size: 18px !important;\\\">We are consistent with the prerequisites of COPPA (Children\'s Online Privacy Protection Act), we don\'t gather any data from anybody under 13 years old. Our site, items, and administrations are completely coordinated to individuals who are in any event 13 years of age or more established.<\\/p><\\/div><div class=\\\"mb-5\\\" style=\\\"color: rgb(111, 111, 111); font-family: Nunito, sans-serif; margin-bottom: 3rem !important;\\\"><h3 class=\\\"mb-3\\\" style=\\\"font-weight: 600; line-height: 1.3; font-size: 24px; font-family: Exo, sans-serif; color: rgb(54, 54, 54);\\\">Changes to our Privacy Policy<\\/h3><p class=\\\"font-18\\\" style=\\\"margin-right: 0px; margin-left: 0px; font-size: 18px !important;\\\">If we decide to change our privacy policy, we will post those changes on this page.<\\/p><\\/div><div class=\\\"mb-5\\\" style=\\\"color: rgb(111, 111, 111); font-family: Nunito, sans-serif; margin-bottom: 3rem !important;\\\"><h3 class=\\\"mb-3\\\" style=\\\"font-weight: 600; line-height: 1.3; font-size: 24px; font-family: Exo, sans-serif; color: rgb(54, 54, 54);\\\">How long we retain your information?<\\/h3><p class=\\\"font-18\\\" style=\\\"margin-right: 0px; margin-left: 0px; font-size: 18px !important;\\\">At the point when you register for our site, we cycle and keep your information we have about you however long you don\'t erase the record or withdraw yourself (subject to laws and guidelines).<\\/p><\\/div><div class=\\\"mb-5\\\" style=\\\"color: rgb(111, 111, 111); font-family: Nunito, sans-serif; margin-bottom: 3rem !important;\\\"><h3 class=\\\"mb-3\\\" style=\\\"font-weight: 600; line-height: 1.3; font-size: 24px; font-family: Exo, sans-serif; color: rgb(54, 54, 54);\\\">What we don\\u2019t do with your data<\\/h3><p class=\\\"font-18\\\" style=\\\"margin-right: 0px; margin-left: 0px; font-size: 18px !important;\\\">We don\'t and will never share, unveil, sell, or in any case give your information to different organizations for the promoting of their items or administrations.<\\/p><\\/div>\",\"status\":1}','2020-07-04 23:42:52','2022-03-30 11:23:12'),
	(42,'policy_pages.element','{\"title\":\"Privacy Policy\",\"details\":\"<div class=\\\"mb-5\\\" style=\\\"color:rgb(111,111,111);font-family:Nunito, sans-serif;margin-bottom:3rem;\\\"><h3 class=\\\"mb-3\\\" style=\\\"font-weight:600;line-height:1.3;font-size:24px;font-family:Exo, sans-serif;color:rgb(54,54,54);\\\">What information do we collect?<\\/h3><p class=\\\"font-18\\\" style=\\\"margin-right:0px;margin-left:0px;font-size:18px;\\\">We gather data from you when you register on our site, submit a request, buy any services, react to an overview, or round out a structure. At the point when requesting any assistance or enrolling on our site, as suitable, you might be approached to enter your: name, email address, or telephone number. You may, nonetheless, visit our site anonymously.<\\/p><\\/div><div class=\\\"mb-5\\\" style=\\\"color:rgb(111,111,111);font-family:Nunito, sans-serif;margin-bottom:3rem;\\\"><h3 class=\\\"mb-3\\\" style=\\\"font-weight:600;line-height:1.3;font-size:24px;font-family:Exo, sans-serif;color:rgb(54,54,54);\\\">How do we protect your information?<\\/h3><p class=\\\"font-18\\\" style=\\\"margin-right:0px;margin-left:0px;font-size:18px;\\\">All provided delicate\\/credit data is sent through Stripe.<br \\/>After an exchange, your private data (credit cards, social security numbers, financials, and so on) won\'t be put away on our workers.<\\/p><\\/div><div class=\\\"mb-5\\\" style=\\\"color:rgb(111,111,111);font-family:Nunito, sans-serif;margin-bottom:3rem;\\\"><h3 class=\\\"mb-3\\\" style=\\\"font-weight:600;line-height:1.3;font-size:24px;font-family:Exo, sans-serif;color:rgb(54,54,54);\\\">Do we disclose any information to outside parties?<\\/h3><p class=\\\"font-18\\\" style=\\\"margin-right:0px;margin-left:0px;font-size:18px;\\\">We don\'t sell, exchange, or in any case, move to outside gatherings by and by recognizable data. This does exclude confided-in outsiders who help us in working our site, leading our business, or adjusting you since those gatherings consent to keep this data private. We may likewise deliver your data when we accept discharge is suitable to follow the law, implement our site strategies, or ensure our own or others\' rights, property, or wellbeing.<\\/p><\\/div><div class=\\\"mb-5\\\" style=\\\"color:rgb(111,111,111);font-family:Nunito, sans-serif;margin-bottom:3rem;\\\"><h3 class=\\\"mb-3\\\" style=\\\"font-weight:600;line-height:1.3;font-size:24px;font-family:Exo, sans-serif;color:rgb(54,54,54);\\\">Children\'s Online Privacy Protection Act Compliance<\\/h3><p class=\\\"font-18\\\" style=\\\"margin-right:0px;margin-left:0px;font-size:18px;\\\">We are consistent with the prerequisites of COPPA (Children\'s Online Privacy Protection Act), we don\'t gather any data from anybody under 13 years old. Our site, items, and administrations are completely coordinated to individuals who are in any event 13 years of age or more established.<\\/p><\\/div><div class=\\\"mb-5\\\" style=\\\"color:rgb(111,111,111);font-family:Nunito, sans-serif;margin-bottom:3rem;\\\"><h3 class=\\\"mb-3\\\" style=\\\"font-weight:600;line-height:1.3;font-size:24px;font-family:Exo, sans-serif;color:rgb(54,54,54);\\\">Changes to our Privacy Policy<\\/h3><p class=\\\"font-18\\\" style=\\\"margin-right:0px;margin-left:0px;font-size:18px;\\\">If we decide to change our privacy policy, we will post those changes on this page.<\\/p><\\/div><div class=\\\"mb-5\\\" style=\\\"color:rgb(111,111,111);font-family:Nunito, sans-serif;margin-bottom:3rem;\\\"><h3 class=\\\"mb-3\\\" style=\\\"font-weight:600;line-height:1.3;font-size:24px;font-family:Exo, sans-serif;color:rgb(54,54,54);\\\">How long we retain your information?<\\/h3><p class=\\\"font-18\\\" style=\\\"margin-right:0px;margin-left:0px;font-size:18px;\\\">At the point when you register for our site, we cycle and keep the information we have about you however long you don\'t erase the record or withdraw yourself (subject to laws and guidelines).<\\/p><\\/div><div class=\\\"mb-5\\\" style=\\\"color:rgb(111,111,111);font-family:Nunito, sans-serif;margin-bottom:3rem;\\\"><h3 class=\\\"mb-3\\\" style=\\\"font-weight:600;line-height:1.3;font-size:24px;font-family:Exo, sans-serif;color:rgb(54,54,54);\\\">What we don\\u2019t do with your data<\\/h3><p class=\\\"font-18\\\" style=\\\"margin-right:0px;margin-left:0px;font-size:18px;\\\">We don\'t and will never share, unveil, sell, or in any case give your information to different organizations for the promotion of their items or administrations.<\\/p><p class=\\\"font-18\\\" style=\\\"margin-right:0px;margin-left:0px;font-size:18px;\\\"><br \\/><\\/p><h3 class=\\\"mb-3\\\" style=\\\"font-weight:600;line-height:1.3;font-size:24px;color:rgb(54,54,54);font-family:Exo, sans-serif;\\\">How does the cashback work on the card?<\\/h3><p class=\\\"font-18\\\" style=\\\"margin-right:0px;margin-left:0px;font-size:18px;\\\"><br \\/><\\/p><p class=\\\"font-18\\\" style=\\\"margin-right:0px;margin-left:0px;font-size:18px;\\\"><br \\/><\\/p><p class=\\\"font-18\\\" style=\\\"margin-right:0px;margin-left:0px;font-size:18px;\\\"><br \\/><\\/p><\\/div>\"}','2021-06-09 08:50:42','2023-11-04 20:19:25'),
	(43,'policy_pages.element','{\"title\":\"Terms of Service\",\"details\":\"<div class=\\\"mb-5\\\" style=\\\"color:rgb(111,111,111);font-family:Nunito, sans-serif;margin-bottom:3rem;\\\"><p class=\\\"font-18\\\" style=\\\"margin-right:0px;margin-left:0px;font-size:18px;\\\">We claim all authority to dismiss, end, or handicap any help with or without cause per administrator discretion. This is a Complete independent facilitating, on the off chance that you misuse our ticket or Livechat or emotionally supportive network by submitting solicitations or protests we will impair your record. The solitary time you should reach us about the seaward facilitating is if there is an issue with the worker. We have not many substance limitations and everything is as per laws and guidelines. Try not to join on the off chance that you intend to do anything contrary to the guidelines, we do check these things and we will know, don\'t burn through our own and your time by joining on the off chance that you figure you will have the option to sneak by us and break the terms.<\\/p><\\/div><div class=\\\"mb-5\\\" style=\\\"color:rgb(111,111,111);font-family:Nunito, sans-serif;margin-bottom:3rem;\\\"><ul class=\\\"font-18\\\" style=\\\"padding-left:15px;list-style-type:disc;font-size:18px;\\\"><li style=\\\"margin-top:0px;margin-right:0px;margin-left:0px;\\\">Configuration requests - If you have a fully managed dedicated server with us then we offer custom PHP\\/MySQL configurations, firewalls for dedicated IPs, DNS, and httpd configurations.<\\/li><li style=\\\"margin-top:0px;margin-right:0px;margin-left:0px;\\\">Software requests - Cpanel Extension Installation will be granted as long as it does not interfere with the security, stability, and performance of other users on the server.<\\/li><li style=\\\"margin-top:0px;margin-right:0px;margin-left:0px;\\\">Emergency Support - We do not provide emergency support \\/ Phone Support \\/ LiveChat Support. Support may take some hours sometimes.<\\/li><li style=\\\"margin-top:0px;margin-right:0px;margin-left:0px;\\\">Webmaster help - We do not offer any support for webmaster related issues and difficulty including coding, &amp; installs, Error solving. if there is an issue where a library or configuration of the server then we can help you if it\'s possible from our end.<\\/li><li style=\\\"margin-top:0px;margin-right:0px;margin-left:0px;\\\">Backups - We keep backups but we are not responsible for data loss, you are fully responsible for all backups.<\\/li><li style=\\\"margin-top:0px;margin-right:0px;margin-left:0px;\\\">We Don\'t support any child porn or such material.<\\/li><li style=\\\"margin-top:0px;margin-right:0px;margin-left:0px;\\\">No spam-related sites or material, such as email lists, mass mail programs, and scripts, etc.<\\/li><li style=\\\"margin-top:0px;margin-right:0px;margin-left:0px;\\\">No harassing material that may cause people to retaliate against you.<\\/li><li style=\\\"margin-top:0px;margin-right:0px;margin-left:0px;\\\">No phishing pages.<\\/li><li style=\\\"margin-top:0px;margin-right:0px;margin-left:0px;\\\">You may not run any exploitation script from the server. reason can be terminated immediately.<\\/li><li style=\\\"margin-top:0px;margin-right:0px;margin-left:0px;\\\">If Anyone attempting to hack or exploit the server by using your script or hosting, we will terminate your account to keep safe other users.<\\/li><li style=\\\"margin-top:0px;margin-right:0px;margin-left:0px;\\\">Malicious Botnets are strictly forbidden.<\\/li><li style=\\\"margin-top:0px;margin-right:0px;margin-left:0px;\\\">Spam, mass mailing, or email marketing in any way are strictly forbidden here.<\\/li><li style=\\\"margin-top:0px;margin-right:0px;margin-left:0px;\\\">Malicious hacking materials, trojans, viruses, &amp; malicious bots running or for download are forbidden.<\\/li><li style=\\\"margin-top:0px;margin-right:0px;margin-left:0px;\\\">Resource and cronjob abuse is forbidden and will result in suspension or termination.<\\/li><li style=\\\"margin-top:0px;margin-right:0px;margin-left:0px;\\\">Php\\/CGI proxies are strictly forbidden.<\\/li><li style=\\\"margin-top:0px;margin-right:0px;margin-left:0px;\\\">CGI-IRC is strictly forbidden.<\\/li><li style=\\\"margin-top:0px;margin-right:0px;margin-left:0px;\\\">No fake or disposal mailers, mass mailing, mail bombers, SMS bombers, etc.<\\/li><li style=\\\"margin-top:0px;margin-right:0px;margin-left:0px;\\\">NO CREDIT OR REFUND will be granted for interruptions of service, due to User Agreement violations.<\\/li><\\/ul><\\/div><div class=\\\"mb-5\\\" style=\\\"color:rgb(111,111,111);font-family:Nunito, sans-serif;margin-bottom:3rem;\\\"><h3 class=\\\"mb-3\\\" style=\\\"font-weight:600;line-height:1.3;font-size:24px;font-family:Exo, sans-serif;color:rgb(54,54,54);\\\">Terms &amp; Conditions for Users<\\/h3><p class=\\\"font-18\\\" style=\\\"margin-right:0px;margin-left:0px;font-size:18px;\\\">Before getting to this site, you are consenting to be limited by these site Terms and Conditions of Use, every single appropriate law, and guidelines, and concur that you are answerable for consistency with any material neighborhood laws. If you disagree with any of these terms, you are restricted from utilizing or getting to this site.<\\/p><\\/div><div class=\\\"mb-5\\\" style=\\\"color:rgb(111,111,111);font-family:Nunito, sans-serif;margin-bottom:3rem;\\\"><h3 class=\\\"mb-3\\\" style=\\\"font-weight:600;line-height:1.3;font-size:24px;font-family:Exo, sans-serif;color:rgb(54,54,54);\\\">Support<\\/h3><p class=\\\"font-18\\\" style=\\\"margin-right:0px;margin-left:0px;font-size:18px;\\\">Whenever you have downloaded our item, you may get in touch with us for help through email and we will give a valiant effort to determine your issue. We will attempt to answer using the Email for more modest bug fixes, after which we will refresh the center bundle. Content help is offered to confirmed clients by Tickets as it were. Backing demands made by email and Livechat.<\\/p><p class=\\\"my-3 font-18 font-weight-bold\\\" style=\\\"margin-right:0px;margin-left:0px;font-size:18px;\\\">On the off chance that your help requires extra adjustment of the System, at that point, you have two alternatives:<\\/p><ul class=\\\"font-18\\\" style=\\\"padding-left:15px;list-style-type:disc;font-size:18px;\\\"><li style=\\\"margin-top:0px;margin-right:0px;margin-left:0px;\\\">Hang tight for additional update discharge.<\\/li><li style=\\\"margin-top:0px;margin-right:0px;margin-left:0px;\\\">Or on the other hand, enlist a specialist (We offer customization for extra charges).<\\/li><\\/ul><\\/div><div class=\\\"mb-5\\\" style=\\\"color:rgb(111,111,111);font-family:Nunito, sans-serif;margin-bottom:3rem;\\\"><h3 class=\\\"mb-3\\\" style=\\\"font-weight:600;line-height:1.3;font-size:24px;font-family:Exo, sans-serif;color:rgb(54,54,54);\\\">Ownership<\\/h3><p class=\\\"font-18\\\" style=\\\"margin-right:0px;margin-left:0px;font-size:18px;\\\">You may not guarantee scholarly or selective possession of any of our items, altered or unmodified. All items are property, we created them. Our items are given \\\"with no guarantees\\\" without guarantee of any sort, either communicated or suggested. On no occasion will our juridical individual be subject to any harms including, however not restricted to, immediate, roundabout, extraordinary, accidental, or significant harms or different misfortunes emerging out of the utilization of or powerlessness to utilize our items.<\\/p><\\/div><div class=\\\"mb-5\\\" style=\\\"color:rgb(111,111,111);font-family:Nunito, sans-serif;margin-bottom:3rem;\\\"><h3 class=\\\"mb-3\\\" style=\\\"font-weight:600;line-height:1.3;font-size:24px;font-family:Exo, sans-serif;color:rgb(54,54,54);\\\">Warranty<\\/h3><p class=\\\"font-18\\\" style=\\\"margin-right:0px;margin-left:0px;font-size:18px;\\\">We don\'t offer any guarantee or assurance of these Services in any way. When our Services have been modified we can\'t ensure they will work with all outsider plugins, modules, or internet browsers. Program similarity ought to be tried against the show formats on the demo worker. If you don\'t mind guarantee that the programs you use will work with the component, as we can not ensure that our systems will work with all program mixes.<\\/p><\\/div><div class=\\\"mb-5\\\" style=\\\"color:rgb(111,111,111);font-family:Nunito, sans-serif;margin-bottom:3rem;\\\"><h3 class=\\\"mb-3\\\" style=\\\"font-weight:600;line-height:1.3;font-size:24px;font-family:Exo, sans-serif;color:rgb(54,54,54);\\\">Unauthorized\\/Illegal Usage<\\/h3><p class=\\\"font-18\\\" style=\\\"margin-right:0px;margin-left:0px;font-size:18px;\\\">You may not utilize our things for any illicit or unapproved reason or may you, in the utilization of the stage, disregard any laws in your locale (counting yet not restricted to copyright laws) just as the laws of your nation and International law. Specifically, it is disallowed to utilize the things on our foundation for pages that advance: brutality, illegal intimidation, hard sexual entertainment, bigotry, obscenity content or warez programming joins.<br \\/><br \\/>You can\'t imitate, copy, duplicate, sell, exchange or adventure any of our segment, utilization of the offered on our things, or admittance to the administration without the express composed consent by us or item proprietor.<br \\/><br \\/>Our Members are liable for all substance posted on the discussion and demo and movement that happens under your record.<br \\/><br \\/>We hold the chance of hindering your participation account quickly if we will think about a particularly not allowed conduct.<br \\/><br \\/>If you make a record on our site, you are liable for keeping up the security of your record, and you are completely answerable for all exercises that happen under the record and some other activities taken regarding the record. You should quickly inform us, of any unapproved employments of your record or some other penetrates of security.<\\/p><\\/div><div class=\\\"mb-5\\\" style=\\\"color:rgb(111,111,111);font-family:Nunito, sans-serif;margin-bottom:3rem;\\\"><h3 class=\\\"mb-3\\\" style=\\\"font-weight:600;line-height:1.3;font-size:24px;font-family:Exo, sans-serif;color:rgb(54,54,54);\\\">Fiverr, Seoclerks Sellers Or Affiliates<\\/h3><p class=\\\"font-18\\\" style=\\\"margin-right:0px;margin-left:0px;font-size:18px;\\\">We do NOT ensure full SEO campaign conveyance within 24 hours. We make no assurance for conveyance time by any means. We give our best assessment to orders during the putting in of requests, anyway, these are gauges. We won\'t be considered liable for loss of assets, negative surveys or you being prohibited for late conveyance. If you are selling on a site that requires time touchy outcomes, utilize Our SEO Services at your own risk.<\\/p><\\/div><div class=\\\"mb-5\\\" style=\\\"color:rgb(111,111,111);font-family:Nunito, sans-serif;margin-bottom:3rem;\\\"><h3 class=\\\"mb-3\\\" style=\\\"font-weight:600;line-height:1.3;font-size:24px;font-family:Exo, sans-serif;color:rgb(54,54,54);\\\">Payment\\/Refund Policy<\\/h3><p class=\\\"font-18\\\" style=\\\"margin-right:0px;margin-left:0px;font-size:18px;\\\">No refund or cash back will be made. After a deposit has been finished, it is extremely unlikely to invert it. You should utilize your equilibrium on requests our administrations, Hosting, SEO campaign. You concur that once you complete a deposit, you won\'t document a debate or a chargeback against us in any way, shape, or form.<br \\/><br \\/>If you document a debate or chargeback against us after a deposit, we claim all authority to end every single future request, prohibit you from our site. False action, for example, utilizing unapproved or taken charge cards will prompt the end of your record. There are no special cases.<\\/p><\\/div><div class=\\\"mb-5\\\" style=\\\"color:rgb(111,111,111);font-family:Nunito, sans-serif;margin-bottom:3rem;\\\"><h3 class=\\\"mb-3\\\" style=\\\"font-weight:600;line-height:1.3;font-size:24px;font-family:Exo, sans-serif;color:rgb(54,54,54);\\\">Free Balance \\/ Coupon Policy<\\/h3><p class=\\\"font-18\\\" style=\\\"margin-right:0px;margin-left:0px;font-size:18px;\\\">We offer numerous approaches to get FREE Balance, Coupons and Deposit offers yet we generally reserve the privilege to audit it and deduct it from your record offset with any explanation we may it is a sort of misuse. If we choose to deduct a few or all of free Balance from your record balance, and your record balance becomes negative, at that point the record will naturally be suspended. If your record is suspended because of a negative Balance you can request to make a custom payment to settle your equilibrium to actuate your record.<\\/p><\\/div>\"}','2021-06-09 08:51:18','2021-06-09 08:51:18'),
	(44,'banner.element','{\"feature\":\"Partnership with Buckle up savings.\"}','2022-04-19 04:20:25','2023-11-04 18:44:58'),
	(45,'banner.element','{\"feature\":\"Always 100% Free\"}','2022-04-19 04:20:32','2022-04-19 04:20:32'),
	(46,'banner.element','{\"feature\":\"Get Paid for Every Swipe from Others.\"}','2022-04-19 04:20:38','2023-11-04 18:45:49'),
	(47,'banner.element','{\"feature\":\"up to $2000 on your VIP card.\"}','2022-04-19 04:20:45','2023-11-04 18:46:48'),
	(48,'category.content','{\"heading\":\"Top Category\"}','2022-04-19 04:26:48','2022-04-19 04:26:48'),
	(49,'today_deal.content','{\"heading\":\"Today\'s Best Deals\"}','2022-04-19 04:38:19','2022-04-19 04:38:19'),
	(50,'top_deal.content','{\"heading\":\"Top Deals\"}','2022-04-19 04:42:05','2022-04-19 04:42:05'),
	(51,'expired_soon_deal.content','{\"heading\":\"Expire Soon Deals\"}','2022-04-19 04:45:00','2022-04-19 04:45:00'),
	(52,'popular-store.content','{\"heading\":\"Popular Store\"}','2022-04-19 04:47:13','2022-04-19 04:47:13'),
	(53,'popular_store.content','{\"heading\":\"Popular Store\"}','2022-04-19 04:49:02','2022-04-19 04:49:02'),
	(54,'testimonial.content','{\"heading\":\"Get Paid for Every Swipe from Others.\",\"subheading\":\"Earn REWARDS for the things you buy everywhere, every day on our platform. Explore our cardholder benefits.\"}','2022-04-19 05:05:09','2023-11-04 21:41:19'),
	(55,'testimonial.element','{\"icon\":\"<i class=\\\"las la-quote-left\\\"><\\/i>\",\"message\":\"Lorem ipsum dolor sit amet consectetur adipisicing elit. Placeat quas, alias minima ab provident aliquam quis quae reiciendis nemo. Inventore quaerat.\",\"name\":\"John Doe\",\"designation\":\"CEO, Humma Company\"}','2022-04-19 05:07:02','2022-05-16 07:26:46'),
	(56,'testimonial.element','{\"icon\":\"<i class=\\\"las la-quote-left\\\"><\\/i>\",\"message\":\"Lorem ipsum dolor sit amet consectetur adipisicing elit. Placeat quas, alias minima ab provident aliquam quis quae reiciendis nemo. Inventore quaerat.\",\"name\":\"John Doe\",\"designation\":\"Businessman\"}','2022-04-19 05:07:30','2022-05-16 07:26:51'),
	(57,'testimonial.element','{\"icon\":\"<i class=\\\"las la-quote-left\\\"><\\/i>\",\"message\":\"Lorem ipsum dolor sit amet consectetur adipisicing elit. Placeat quas, alias minima ab provident aliquam quis quae reiciendis nemo. Inventore quaerat.\",\"name\":\"John Doe\",\"designation\":\"Sportsman\"}','2022-04-19 05:07:41','2022-05-16 07:26:57'),
	(58,'counter.element','{\"title\":\"Total Users\",\"counter_digit\":\"4,545k\"}','2022-04-19 05:12:50','2023-11-04 18:54:02'),
	(59,'counter.element','{\"title\":\"Total Stores\",\"counter_digit\":\"90.000\"}','2022-04-19 05:13:06','2023-11-04 18:55:02'),
	(60,'counter.element','{\"title\":\"Total gift card\",\"counter_digit\":\"2,23566\"}','2022-04-19 05:13:18','2023-11-04 18:53:02'),
	(61,'breadcrumb.content','{\"has_image\":\"1\",\"background_image\":\"625e5e5d9c4f61650351709.jpg\"}','2022-04-19 05:31:49','2022-04-19 05:31:49'),
	(62,'social_icon.element','{\"title\":\"Instagram\",\"social_icon\":\"<i class=\\\"fab fa-instagram\\\"><\\/i>\",\"url\":\"https:\\/\\/www.instagram.com\\/\"}','2022-04-19 05:53:19','2022-04-19 05:53:19'),
	(63,'social_icon.element','{\"title\":\"Twitter\",\"social_icon\":\"<i class=\\\"fab fa-twitter\\\"><\\/i>\",\"url\":\"https:\\/\\/www.twitter.com\\/\"}','2022-04-19 05:53:41','2022-04-19 05:53:41'),
	(64,'social_icon.element','{\"title\":\"LinkedIn\",\"social_icon\":\"<i class=\\\"fab fa-linkedin-in\\\"><\\/i>\",\"url\":\"https:\\/\\/www.linkedin.com\\/\"}','2022-04-19 05:54:05','2022-05-17 04:35:56'),
	(65,'blog.element','{\"has_image\":[\"1\"],\"title\":\"Fuga odit repellat alias animi totam officiis facere dolore repellat alias.\",\"description\":\"<p class=\\\"fs--18px\\\" style=\\\"margin-right:0px;margin-left:0px;color:rgb(85,85,85);font-family:Sora, sans-serif;font-size:1.125rem;\\\">Nobis, maiores. Dolores nesciunt, quibusdam sed, velit dicta qui atque, ad doloribus eveniet cupiditate pariatur doloremque nihil harum nemo voluptatum illum. Alias doloribus eveniet cupiditate.<\\/p><p class=\\\"mt-3\\\" style=\\\"margin-right:0px;margin-left:0px;color:rgb(85,85,85);font-family:Sora, sans-serif;font-size:15px;\\\">Fugiat doloremque mollitia a adipisci voluptas natus aperiam numquam libero facilis. Veniam dignissimos natus ab doloremque exercitationem minima neque, iusto, ullam nostrum impedit dolores quos architecto aut ipsa nihil dolore facere, inventore quidem voluptates. Impedit, obcaecati numquam! Corrupti eos alias quibusdam sint cupiditate at iure reprehenderit a debitis id enim explicabo, nemo expedita magni nesciunt excepturi dicta omnis. Minus quibusdam nulla officia eos ipsam soluta, iusto omnis repellendus consequuntur cupiditate temporibus, commodi expedita atque architecto praesentium suscipit molestias dignissimos, impedit itaque aliquam nam dolore explicabo! Ad dolores beatae ipsum nemo provident voluptatibus Minus quibusdam nulla officia eos.<\\/p><p class=\\\"mt-4\\\" style=\\\"margin-right:0px;margin-left:0px;color:rgb(85,85,85);font-family:Sora, sans-serif;font-size:15px;\\\">Totam minima nulla, placeat quidem, omnis sed laboriosam fuga maxime animi, cupiditate molestias consectetur. Labore, assumenda eaque. Officiis voluptas accusantium alias nostrum fugit dolore eos blanditiis aperiam, illo consequuntur repellendus doloribus a porro exercitationem quia. Accusamus molestiae beatae alias, veritatis delectus reiciendis est harum ex nesciunt rem? Recusandae et nihil id ducimus aliquid, pariatur aut tempore doloremque ratione cum in non eius maiores a voluptatum, quam aliquam perspiciatis magnam provident. Et odit saepe illo libero, voluptatem optio aliquam deserunt nam accusamus in commodi dolorum pariatur. Et quo labore velit nesciunt.<\\/p>\",\"blog_image\":\"6288bc969471d1653128342.png\"}','2022-05-09 07:40:50','2022-05-21 08:49:03'),
	(66,'blog.element','{\"has_image\":[\"1\"],\"title\":\"Repellat nobis ducimus nam, vitae distinctio culpa hic dignissimos, doloribu\",\"description\":\"<p class=\\\"fs--18px\\\" style=\\\"margin-right:0px;margin-left:0px;color:rgb(85,85,85);font-size:1.125rem;font-family:Sora, sans-serif;\\\">Nobis, maiores. Dolores nesciunt, quibusdam sed, velit dicta qui atque, ad doloribus eveniet cupiditate pariatur doloremque nihil harum nemo voluptatum illum. Alias doloribus eveniet cupiditate.<\\/p><p class=\\\"mt-3\\\" style=\\\"color:rgb(85,85,85);font-size:15px;margin-right:0px;margin-left:0px;font-family:Sora, sans-serif;\\\">Fugiat doloremque mollitia a adipisci voluptas natus aperiam numquam libero facilis. Veniam dignissimos natus ab doloremque exercitationem minima neque, iusto, ullam nostrum impedit dolores quos architecto aut ipsa nihil dolore facere, inventore quidem voluptates. Impedit, obcaecati numquam! Corrupti eos alias quibusdam sint cupiditate at iure reprehenderit a debitis id enim explicabo, nemo expedita magni nesciunt excepturi dicta omnis. Minus quibusdam nulla officia eos ipsam soluta, iusto omnis repellendus consequuntur cupiditate temporibus, commodi expedita atque architecto praesentium suscipit molestias dignissimos, impedit itaque aliquam nam dolore explicabo! Ad dolores beatae ipsum nemo provident voluptatibus Minus quibusdam nulla officia eos.<\\/p><p class=\\\"mt-4\\\" style=\\\"color:rgb(85,85,85);font-size:15px;margin-right:0px;margin-left:0px;font-family:Sora, sans-serif;\\\">Totam minima nulla, placeat quidem, omnis sed laboriosam fuga maxime animi, cupiditate molestias consectetur. Labore, assumenda eaque. Officiis voluptas accusantium alias nostrum fugit dolore eos blanditiis aperiam, illo consequuntur repellendus doloribus a porro exercitationem quia. Accusamus molestiae beatae alias, veritatis delectus reiciendis est harum ex nesciunt rem? Recusandae et nihil id ducimus aliquid, pariatur aut tempore doloremque ratione cum in non eius maiores a voluptatum, quam aliquam perspiciatis magnam provident. Et odit saepe illo libero, voluptatem optio aliquam deserunt nam accusamus in commodi dolorum pariatur. Et quo labore velit nesciunt.<\\/p>\",\"blog_image\":\"6288bd128ead51653128466.png\"}','2022-05-09 08:03:37','2022-05-21 08:51:06'),
	(67,'blog.element','{\"has_image\":[\"1\"],\"title\":\"Natur odit nisi dolor sit amet consectetur adipisicing elit.\",\"description\":\"<div class=\\\"blog-details-content mt-4\\\" style=\\\"color:rgb(85,85,85);font-family:Sora, sans-serif;font-size:15px;\\\"><p class=\\\"fs--18px\\\" style=\\\"margin-right:0px;margin-left:0px;font-size:1.125rem;\\\">Nobis, maiores. Dolores nesciunt, quibusdam sed, velit dicta qui atque, ad doloribus eveniet cupiditate pariatur doloremque nihil harum nemo voluptatum illum. Alias doloribus eveniet cupiditate.<\\/p><p class=\\\"mt-3\\\" style=\\\"margin-right:0px;margin-left:0px;\\\">Fugiat doloremque mollitia a adipisci voluptas natus aperiam numquam libero facilis. Veniam dignissimos natus ab doloremque exercitationem minima neque, iusto, ullam nostrum impedit dolores quos architecto aut ipsa nihil dolore facere, inventore quidem voluptates. Impedit, obcaecati numquam! Corrupti eos alias quibusdam sint cupiditate at iure reprehenderit a debitis id enim explicabo, nemo expedita magni nesciunt excepturi dicta omnis. Minus quibusdam nulla officia eos ipsam soluta, iusto omnis repellendus consequuntur cupiditate temporibus, commodi expedita atque architecto praesentium suscipit molestias dignissimos, impedit itaque aliquam nam dolore explicabo! Ad dolores beatae ipsum nemo provident voluptatibus Minus quibusdam nulla officia eos.<\\/p><p class=\\\"mt-4\\\" style=\\\"margin-right:0px;margin-left:0px;\\\">Totam minima nulla, placeat quidem, omnis sed laboriosam fuga maxime animi, cupiditate molestias consectetur. Labore, assumenda eaque. Officiis voluptas accusantium alias nostrum fugit dolore eos blanditiis aperiam, illo consequuntur repellendus doloribus a porro exercitationem quia. Accusamus molestiae beatae alias, veritatis delectus reiciendis est harum ex nesciunt rem? Recusandae et nihil id ducimus aliquid, pariatur aut tempore doloremque ratione cum in non eius maiores a voluptatum, quam aliquam perspiciatis magnam provident. Et odit saepe illo libero, voluptatem optio aliquam deserunt nam accusamus in commodi dolorum pariatur. Et quo labore velit nesciunt.<\\/p><\\/div>\",\"blog_image\":\"6288bd5a881971653128538.png\"}','2022-05-09 08:03:39','2022-05-21 08:52:19'),
	(68,'blog.element','{\"has_image\":[\"1\"],\"title\":\"Asperiores maiores itaque earum? Placeat minima incidunt asper\",\"description\":\"<div class=\\\"blog-details-content mt-4\\\" style=\\\"color:rgb(85,85,85);font-family:Sora, sans-serif;font-size:15px;\\\"><p class=\\\"fs--18px\\\" style=\\\"margin-right:0px;margin-left:0px;font-size:1.125rem;\\\">Nobis, maiores. Dolores nesciunt, quibusdam sed, velit dicta qui atque, ad doloribus eveniet cupiditate pariatur doloremque nihil harum nemo voluptatum illum. Alias doloribus eveniet cupiditate.<\\/p><p class=\\\"mt-3\\\" style=\\\"margin-right:0px;margin-left:0px;\\\">Fugiat doloremque mollitia a adipisci voluptas natus aperiam numquam libero facilis. Veniam dignissimos natus ab doloremque exercitationem minima neque, iusto, ullam nostrum impedit dolores quos architecto aut ipsa nihil dolore facere, inventore quidem voluptates. Impedit, obcaecati numquam! Corrupti eos alias quibusdam sint cupiditate at iure reprehenderit a debitis id enim explicabo, nemo expedita magni nesciunt excepturi dicta omnis. Minus quibusdam nulla officia eos ipsam soluta, iusto omnis repellendus consequuntur cupiditate temporibus, commodi expedita atque architecto praesentium suscipit molestias dignissimos, impedit itaque aliquam nam dolore explicabo! Ad dolores beatae ipsum nemo provident voluptatibus Minus quibusdam nulla officia eos.<\\/p><p class=\\\"mt-4\\\" style=\\\"margin-right:0px;margin-left:0px;\\\">Totam minima nulla, placeat quidem, omnis sed laboriosam fuga maxime animi, cupiditate molestias consectetur. Labore, assumenda eaque. Officiis voluptas accusantium alias nostrum fugit dolore eos blanditiis aperiam, illo consequuntur repellendus doloribus a porro exercitationem quia. Accusamus molestiae beatae alias, veritatis delectus reiciendis est harum ex nesciunt rem? Recusandae et nihil id ducimus aliquid, pariatur aut tempore doloremque ratione cum in non eius maiores a voluptatum, quam aliquam perspiciatis magnam provident. Et odit saepe illo libero, voluptatem optio aliquam deserunt nam accusamus in commodi dolorum pariatur. Et quo labore velit nesciunt.<\\/p><\\/div>\",\"blog_image\":\"6288bdbb5ec421653128635.png\"}','2022-05-09 08:03:41','2022-05-21 08:53:55'),
	(69,'blog.element','{\"has_image\":[\"1\"],\"title\":\"Minus nostrum explicabo nemo. Delectus iusto, sed debitis quisquam\",\"description\":\"<div class=\\\"blog-details-content mt-4\\\" style=\\\"color:rgb(85,85,85);font-family:Sora, sans-serif;font-size:15px;\\\"><p class=\\\"fs--18px\\\" style=\\\"margin-right:0px;margin-left:0px;font-size:1.125rem;\\\">Nobis, maiores. Dolores nesciunt, quibusdam sed, velit dicta qui atque, ad doloribus eveniet cupiditate pariatur doloremque nihil harum nemo voluptatum illum. Alias doloribus eveniet cupiditate.<\\/p><p class=\\\"mt-3\\\" style=\\\"margin-right:0px;margin-left:0px;\\\">Fugiat doloremque mollitia a adipisci voluptas natus aperiam numquam libero facilis. Veniam dignissimos natus ab doloremque exercitationem minima neque, iusto, ullam nostrum impedit dolores quos architecto aut ipsa nihil dolore facere, inventore quidem voluptates. Impedit, obcaecati numquam! Corrupti eos alias quibusdam sint cupiditate at iure reprehenderit a debitis id enim explicabo, nemo expedita magni nesciunt excepturi dicta omnis. Minus quibusdam nulla officia eos ipsam soluta, iusto omnis repellendus consequuntur cupiditate temporibus, commodi expedita atque architecto praesentium suscipit molestias dignissimos, impedit itaque aliquam nam dolore explicabo! Ad dolores beatae ipsum nemo provident voluptatibus Minus quibusdam nulla officia eos.<\\/p><p class=\\\"mt-4\\\" style=\\\"margin-right:0px;margin-left:0px;\\\">Totam minima nulla, placeat quidem, omnis sed laboriosam fuga maxime animi, cupiditate molestias consectetur. Labore, assumenda eaque. Officiis voluptas accusantium alias nostrum fugit dolore eos blanditiis aperiam, illo consequuntur repellendus doloribus a porro exercitationem quia. Accusamus molestiae beatae alias, veritatis delectus reiciendis est harum ex nesciunt rem? Recusandae et nihil id ducimus aliquid, pariatur aut tempore doloremque ratione cum in non eius maiores a voluptatum, quam aliquam perspiciatis magnam provident. Et odit saepe illo libero, voluptatem optio aliquam deserunt nam accusamus in commodi dolorum pariatur. Et quo labore velit nesciunt.<\\/p><\\/div>\",\"blog_image\":\"6288be18c56201653128728.png\"}','2022-05-09 08:03:42','2022-05-21 08:55:29'),
	(70,'blog.element','{\"has_image\":[\"1\"],\"title\":\"Ipsum dolor sit amet, consectetur adipisicing elit. Aperiam voluptas dolor\",\"description\":\"<div class=\\\"blog-details-content mt-4\\\" style=\\\"color:rgb(85,85,85);font-family:Sora, sans-serif;font-size:15px;\\\"><p class=\\\"fs--18px\\\" style=\\\"margin-right:0px;margin-left:0px;font-size:1.125rem;\\\">Nobis, maiores. Dolores nesciunt, quibusdam sed, velit dicta qui atque, ad doloribus eveniet cupiditate pariatur doloremque nihil harum nemo voluptatum illum. Alias doloribus eveniet cupiditate.<\\/p><p class=\\\"mt-3\\\" style=\\\"margin-right:0px;margin-left:0px;\\\">Fugiat doloremque mollitia a adipisci voluptas natus aperiam numquam libero facilis. Veniam dignissimos natus ab doloremque exercitationem minima neque, iusto, ullam nostrum impedit dolores quos architecto aut ipsa nihil dolore facere, inventore quidem voluptates. Impedit, obcaecati numquam! Corrupti eos alias quibusdam sint cupiditate at iure reprehenderit a debitis id enim explicabo, nemo expedita magni nesciunt excepturi dicta omnis. Minus quibusdam nulla officia eos ipsam soluta, iusto omnis repellendus consequuntur cupiditate temporibus, commodi expedita atque architecto praesentium suscipit molestias dignissimos, impedit itaque aliquam nam dolore explicabo! Ad dolores beatae ipsum nemo provident voluptatibus Minus quibusdam nulla officia eos.<\\/p><p class=\\\"mt-4\\\" style=\\\"margin-right:0px;margin-left:0px;\\\">Totam minima nulla, placeat quidem, omnis sed laboriosam fuga maxime animi, cupiditate molestias consectetur. Labore, assumenda eaque. Officiis voluptas accusantium alias nostrum fugit dolore eos blanditiis aperiam, illo consequuntur repellendus doloribus a porro exercitationem quia. Accusamus molestiae beatae alias, veritatis delectus reiciendis est harum ex nesciunt rem? Recusandae et nihil id ducimus aliquid, pariatur aut tempore doloremque ratione cum in non eius maiores a voluptatum, quam aliquam perspiciatis magnam provident. Et odit saepe illo libero, voluptatem optio aliquam deserunt nam accusamus in commodi dolorum pariatur. Et quo labore velit nesciunt.<\\/p><\\/div>\",\"blog_image\":\"6288bef6098f01653128950.png\"}','2022-05-09 08:03:43','2022-05-21 08:59:10'),
	(71,'maintenance.data','{\"description\":\"<div class=\\\"mb-5\\\" style=\\\"font-family: Nunito, sans-serif; margin-bottom: 3rem !important;\\\"><h3 class=\\\"mb-3\\\" style=\\\"text-align: center; font-weight: 600; line-height: 1.3; font-size: 24px; font-family: Exo, sans-serif;\\\"><font color=\\\"#ffffff\\\">What information do we collect?<\\/font><\\/h3><p class=\\\"font-18\\\" style=\\\"text-align: center; margin-right: 0px; margin-left: 0px; font-size: 18px !important;\\\"><font color=\\\"#ffffff\\\">We gather data from you when you register on our site, submit a request, buy any services, react to an overview, or round out a structure. At the point when requesting any assistance or enrolling on our site, as suitable, you might be approached to enter your: name, email address, or telephone number. You may, nonetheless, visit our site anonymously.<\\/font><\\/p><\\/div>\"}','2020-07-04 17:42:52','2022-05-24 05:53:48'),
	(72,'login.content','{\"has_image\":\"1\",\"heading\":\"Login to Your Account\",\"image\":\"65469fb56e4a01699127221.jpg\"}','2022-05-18 09:07:28','2023-11-04 19:47:01'),
	(73,'register.content','{\"has_image\":\"1\",\"heading\":\"Register Account\",\"image\":\"6284cd845dcfc1652870532.png\"}','2022-05-18 09:12:12','2022-05-18 09:12:12');

/*!40000 ALTER TABLE `frontends` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table gateway_currencies
# ------------------------------------------------------------

DROP TABLE IF EXISTS `gateway_currencies`;

CREATE TABLE `gateway_currencies` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `currency` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `symbol` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `method_code` int DEFAULT NULL,
  `gateway_alias` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `min_amount` decimal(28,8) NOT NULL DEFAULT '0.00000000',
  `max_amount` decimal(28,8) NOT NULL DEFAULT '0.00000000',
  `percent_charge` decimal(5,2) NOT NULL DEFAULT '0.00',
  `fixed_charge` decimal(28,8) NOT NULL DEFAULT '0.00000000',
  `rate` decimal(28,8) NOT NULL DEFAULT '0.00000000',
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gateway_parameter` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `gateway_currencies` WRITE;
/*!40000 ALTER TABLE `gateway_currencies` DISABLE KEYS */;

INSERT INTO `gateway_currencies` (`id`, `name`, `currency`, `symbol`, `method_code`, `gateway_alias`, `min_amount`, `max_amount`, `percent_charge`, `fixed_charge`, `rate`, `image`, `gateway_parameter`, `created_at`, `updated_at`)
VALUES
	(4,'Credit Card / Debit Card','USD','$',114,'StripeV3',20.00000000,500.00000000,2.50,0.30000000,1.00000000,NULL,'{\"secret_key\":\"0\",\"publishable_key\":\"0\",\"end_point\":\"0\"}','2023-11-03 00:27:20','2023-11-03 00:27:20');

/*!40000 ALTER TABLE `gateway_currencies` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table gateways
# ------------------------------------------------------------

DROP TABLE IF EXISTS `gateways`;

CREATE TABLE `gateways` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `form_id` int unsigned NOT NULL DEFAULT '0',
  `code` int DEFAULT NULL,
  `name` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alias` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'NULL',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1=>enable, 2=>disable',
  `gateway_parameters` text COLLATE utf8mb4_unicode_ci,
  `supported_currencies` text COLLATE utf8mb4_unicode_ci,
  `crypto` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0: fiat currency, 1: crypto currency',
  `extra` text COLLATE utf8mb4_unicode_ci,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `gateways` WRITE;
/*!40000 ALTER TABLE `gateways` DISABLE KEYS */;

INSERT INTO `gateways` (`id`, `form_id`, `code`, `name`, `alias`, `status`, `gateway_parameters`, `supported_currencies`, `crypto`, `extra`, `description`, `created_at`, `updated_at`)
VALUES
	(3,0,103,'Stripe Hosted','Stripe',1,'{\"secret_key\":{\"title\":\"Secret Key\",\"global\":true,\"value\":\"sk_test_51I6GGiCGv1sRiQlEi5v1or9eR0HVbuzdMd2rW4n3DxC8UKfz66R4X6n4yYkzvI2LeAIuRU9H99ZpY7XCNFC9xMs500vBjZGkKG\"},\"publishable_key\":{\"title\":\"PUBLISHABLE KEY\",\"global\":true,\"value\":\"pk_test_51I6GGiCGv1sRiQlEOisPKrjBqQqqcFsw8mXNaZ2H2baN6R01NulFS7dKFji1NRRxuchoUTEDdB7ujKcyKYSVc0z500eth7otOM\"}}','{\"USD\":\"USD\",\"AUD\":\"AUD\",\"BRL\":\"BRL\",\"CAD\":\"CAD\",\"CHF\":\"CHF\",\"DKK\":\"DKK\",\"EUR\":\"EUR\",\"GBP\":\"GBP\",\"HKD\":\"HKD\",\"INR\":\"INR\",\"JPY\":\"JPY\",\"MXN\":\"MXN\",\"MYR\":\"MYR\",\"NOK\":\"NOK\",\"NZD\":\"NZD\",\"PLN\":\"PLN\",\"SEK\":\"SEK\",\"SGD\":\"SGD\"}',0,NULL,NULL,'2019-09-14 13:14:22','2021-05-21 00:48:36'),
	(11,0,111,'Stripe Storefront','StripeJs',1,'{\"secret_key\":{\"title\":\"Secret Key\",\"global\":true,\"value\":\"sk_test_51I6GGiCGv1sRiQlEi5v1or9eR0HVbuzdMd2rW4n3DxC8UKfz66R4X6n4yYkzvI2LeAIuRU9H99ZpY7XCNFC9xMs500vBjZGkKG\"},\"publishable_key\":{\"title\":\"PUBLISHABLE KEY\",\"global\":true,\"value\":\"pk_test_51I6GGiCGv1sRiQlEOisPKrjBqQqqcFsw8mXNaZ2H2baN6R01NulFS7dKFji1NRRxuchoUTEDdB7ujKcyKYSVc0z500eth7otOM\"}}','{\"USD\":\"USD\",\"AUD\":\"AUD\",\"BRL\":\"BRL\",\"CAD\":\"CAD\",\"CHF\":\"CHF\",\"DKK\":\"DKK\",\"EUR\":\"EUR\",\"GBP\":\"GBP\",\"HKD\":\"HKD\",\"INR\":\"INR\",\"JPY\":\"JPY\",\"MXN\":\"MXN\",\"MYR\":\"MYR\",\"NOK\":\"NOK\",\"NZD\":\"NZD\",\"PLN\":\"PLN\",\"SEK\":\"SEK\",\"SGD\":\"SGD\"}',0,NULL,NULL,'2019-09-14 13:14:22','2021-05-21 00:53:10'),
	(25,0,114,'Stripe Checkout','StripeV3',1,'{\"secret_key\":{\"title\":\"Secret Key\",\"global\":true,\"value\":\"0\"},\"publishable_key\":{\"title\":\"PUBLISHABLE KEY\",\"global\":true,\"value\":\"0\"},\"end_point\":{\"title\":\"End Point Secret\",\"global\":true,\"value\":\"0\"}}','{\"USD\":\"USD\",\"AUD\":\"AUD\",\"BRL\":\"BRL\",\"CAD\":\"CAD\",\"CHF\":\"CHF\",\"DKK\":\"DKK\",\"EUR\":\"EUR\",\"GBP\":\"GBP\",\"HKD\":\"HKD\",\"INR\":\"INR\",\"JPY\":\"JPY\",\"MXN\":\"MXN\",\"MYR\":\"MYR\",\"NOK\":\"NOK\",\"NZD\":\"NZD\",\"PLN\":\"PLN\",\"SEK\":\"SEK\",\"SGD\":\"SGD\"}',0,'{\"webhook\":{\"title\": \"Webhook Endpoint\",\"value\":\"ipn.StripeV3\"}}',NULL,'2019-09-14 13:14:22','2023-11-03 00:27:20');

/*!40000 ALTER TABLE `gateways` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table general_settings
# ------------------------------------------------------------

DROP TABLE IF EXISTS `general_settings`;

CREATE TABLE `general_settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `site_name` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cur_text` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'currency text',
  `cur_sym` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'currency symbol',
  `email_from` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_template` text COLLATE utf8mb4_unicode_ci,
  `sms_body` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sms_from` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_color` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `secondary_color` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mail_config` text COLLATE utf8mb4_unicode_ci COMMENT 'email configuration',
  `sms_config` text COLLATE utf8mb4_unicode_ci,
  `global_shortcodes` text COLLATE utf8mb4_unicode_ci,
  `kv` tinyint(1) NOT NULL DEFAULT '0',
  `ev` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'email verification, 0 - dont check, 1 - check',
  `en` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'email notification, 0 - dont send, 1 - send',
  `sv` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'mobile verication, 0 - dont check, 1 - check',
  `sn` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'sms notification, 0 - dont send, 1 - send',
  `force_ssl` tinyint(1) NOT NULL DEFAULT '0',
  `maintenance_mode` tinyint(1) NOT NULL DEFAULT '0',
  `secure_password` tinyint(1) NOT NULL DEFAULT '0',
  `agree` tinyint(1) NOT NULL DEFAULT '0',
  `registration` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0: Off	, 1: On',
  `active_template` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `coupon_auto_approve` tinyint(1) NOT NULL DEFAULT '0',
  `sys_version` text COLLATE utf8mb4_unicode_ci,
  `system_info` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `general_settings` WRITE;
/*!40000 ALTER TABLE `general_settings` DISABLE KEYS */;

INSERT INTO `general_settings` (`id`, `site_name`, `cur_text`, `cur_sym`, `email_from`, `email_template`, `sms_body`, `sms_from`, `base_color`, `secondary_color`, `mail_config`, `sms_config`, `global_shortcodes`, `kv`, `ev`, `en`, `sv`, `sn`, `force_ssl`, `maintenance_mode`, `secure_password`, `agree`, `registration`, `active_template`, `coupon_auto_approve`, `sys_version`, `system_info`, `created_at`, `updated_at`)
VALUES
	(1,'Buckleup Savings','USD','$','info@bucleupsavings.com','<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\r\n  <!--[if !mso]><!-->\r\n  <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\r\n  <!--<![endif]-->\r\n  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n  <title></title>\r\n  <style type=\"text/css\">\r\n.ReadMsgBody { width: 100%; background-color: #ffffff; }\r\n.ExternalClass { width: 100%; background-color: #ffffff; }\r\n.ExternalClass, .ExternalClass p, .ExternalClass span, .ExternalClass font, .ExternalClass td, .ExternalClass div { line-height: 100%; }\r\nhtml { width: 100%; }\r\nbody { -webkit-text-size-adjust: none; -ms-text-size-adjust: none; margin: 0; padding: 0; }\r\ntable { border-spacing: 0; table-layout: fixed; margin: 0 auto;border-collapse: collapse; }\r\ntable table table { table-layout: auto; }\r\n.yshortcuts a { border-bottom: none !important; }\r\nimg:hover { opacity: 0.9 !important; }\r\na { color: #0087ff; text-decoration: none; }\r\n.textbutton a { font-family: \'open sans\', arial, sans-serif !important;}\r\n.btn-link a { color:#FFFFFF !important;}\r\n\r\n@media only screen and (max-width: 480px) {\r\nbody { width: auto !important; }\r\n*[class=\"table-inner\"] { width: 90% !important; text-align: center !important; }\r\n*[class=\"table-full\"] { width: 100% !important; text-align: center !important; }\r\n/* image */\r\nimg[class=\"img1\"] { width: 100% !important; height: auto !important; }\r\n}\r\n</style>\r\n\r\n\r\n\r\n  <table bgcolor=\"#414a51\" width=\"100%\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\">\r\n    <tbody><tr>\r\n      <td height=\"50\"></td>\r\n    </tr>\r\n    <tr>\r\n      <td align=\"center\" style=\"text-align:center;vertical-align:top;font-size:0;\">\r\n        <table align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n          <tbody><tr>\r\n            <td align=\"center\" width=\"600\">\r\n              <!--header-->\r\n              <table class=\"table-inner\" width=\"95%\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\">\r\n                <tbody><tr>\r\n                  <td bgcolor=\"#0087ff\" style=\"border-top-left-radius:6px; border-top-right-radius:6px;text-align:center;vertical-align:top;font-size:0;\" align=\"center\">\r\n                    <table width=\"90%\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\">\r\n                      <tbody><tr>\r\n                        <td height=\"20\"></td>\r\n                      </tr>\r\n                      <tr>\r\n                        <td align=\"center\" style=\"font-family: \'Open sans\', Arial, sans-serif; color:#FFFFFF; font-size:16px; font-weight: bold;\">This is a System Generated Email</td>\r\n                      </tr>\r\n                      <tr>\r\n                        <td height=\"20\"></td>\r\n                      </tr>\r\n                    </tbody></table>\r\n                  </td>\r\n                </tr>\r\n              </tbody></table>\r\n              <!--end header-->\r\n              <table class=\"table-inner\" width=\"95%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n                <tbody><tr>\r\n                  <td bgcolor=\"#FFFFFF\" align=\"center\" style=\"text-align:center;vertical-align:top;font-size:0;\">\r\n                    <table align=\"center\" width=\"90%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n                      <tbody><tr>\r\n                        <td height=\"35\"></td>\r\n                      </tr>\r\n                      <!--logo-->\r\n                      <tr>\r\n                        <td align=\"center\" style=\"vertical-align:top;font-size:0;\">\r\n                          <a href=\"#\">\r\n                            <br>\r\n                          </a>\r\n                        </td>\r\n                      </tr>\r\n                      <!--end logo-->\r\n                      <tr>\r\n                        <td height=\"40\"></td>\r\n                      </tr>\r\n                      <!--headline-->\r\n                      <tr>\r\n                        <td align=\"center\" style=\"font-family: \'Open Sans\', Arial, sans-serif; font-size: 22px;color:#414a51;font-weight: bold;\">Hello {{fullname}} ({{username}})</td>\r\n                      </tr>\r\n                      <!--end headline-->\r\n                      <tr>\r\n                        <td align=\"center\" style=\"text-align:center;vertical-align:top;font-size:0;\">\r\n                          <table width=\"40\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\">\r\n                            <tbody><tr>\r\n                              <td height=\"20\" style=\" border-bottom:3px solid #0087ff;\"></td>\r\n                            </tr>\r\n                          </tbody></table>\r\n                        </td>\r\n                      </tr>\r\n                      <tr>\r\n                        <td height=\"20\"></td>\r\n                      </tr>\r\n                      <!--content-->\r\n                      <tr>\r\n                        <td align=\"left\" style=\"font-family: \'Open sans\', Arial, sans-serif; color:#7f8c8d; font-size:16px; line-height: 28px;\">{{message}}</td>\r\n                      </tr>\r\n                      <!--end content-->\r\n                      <tr>\r\n                        <td height=\"40\"></td>\r\n                      </tr>\r\n              \r\n                    </tbody></table>\r\n                  </td>\r\n                </tr>\r\n                <tr>\r\n                  <td height=\"45\" align=\"center\" bgcolor=\"#f4f4f4\" style=\"border-bottom-left-radius:6px;border-bottom-right-radius:6px;\">\r\n                    <table align=\"center\" width=\"90%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n                      <tbody><tr>\r\n                        <td height=\"10\"></td>\r\n                      </tr>\r\n                      <!--preference-->\r\n                      <tr>\r\n                        <td class=\"preference-link\" align=\"center\" style=\"font-family: \'Open sans\', Arial, sans-serif; color:#95a5a6; font-size:14px;\">\r\n                          © 2023&nbsp;<a href=\"#\">{{site_name}}</a>&nbsp;. All Rights Reserved. \r\n                        </td>\r\n                      </tr>\r\n                      <!--end preference-->\r\n                      <tr>\r\n                        <td height=\"10\"></td>\r\n                      </tr>\r\n                    </tbody></table>\r\n                  </td>\r\n                </tr>\r\n              </tbody></table>\r\n            </td>\r\n          </tr>\r\n        </tbody></table>\r\n      </td>\r\n    </tr>\r\n    <tr>\r\n      <td height=\"60\"></td>\r\n    </tr>\r\n  </tbody></table>','hi {{fullname}} ({{username}}), {{message}}','Buckleup Savings','#004aad','#FBD927','{\"name\":\"smtp\",\"host\":\"smtp.ionos.com\",\"port\":\"587\",\"enc\":\"ssl\",\"username\":\"info@buckleupsavings.com\",\"password\":\"Moneycr.com$10I35U=\"}','{\"name\":\"infobip\",\"clickatell\":{\"api_key\":\"----------------\"},\"infobip\":{\"username\":\"---------------\",\"password\":\"-----------------\"},\"message_bird\":{\"api_key\":\"-------------------\"},\"nexmo\":{\"api_key\":\"----------------------\",\"api_secret\":\"----------------------\"},\"sms_broadcast\":{\"username\":\"----------------------\",\"password\":\"-----------------------------\"},\"twilio\":{\"account_sid\":\"-----------------------\",\"auth_token\":\"---------------------------\",\"from\":\"----------------------\"},\"text_magic\":{\"username\":\"-----------------------\",\"apiv2_key\":\"-------------------------------\"},\"custom\":{\"method\":\"get\",\"url\":\"https:\\/\\/hostname\\/demo-api-v1\",\"headers\":{\"name\":[\"api_key\"],\"value\":[\"test_api 555\"]},\"body\":{\"name\":[\"from_number\"],\"value\":[\"5657545757\"]}}}','{\n    \"site_name\":\"Name of your site\",\n    \"site_currency\":\"Currency of your site\",\n    \"currency_symbol\":\"Symbol of currency\"\n}',0,0,1,0,1,0,0,0,1,1,'basic',0,NULL,'[]',NULL,'2023-12-18 19:48:08');

/*!40000 ALTER TABLE `general_settings` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table languages
# ------------------------------------------------------------

DROP TABLE IF EXISTS `languages`;

CREATE TABLE `languages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `text_align` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0: left to right text align, 1: right to left text align',
  `is_default` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0: not default language, 1: default language',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `languages` WRITE;
/*!40000 ALTER TABLE `languages` DISABLE KEYS */;

INSERT INTO `languages` (`id`, `name`, `code`, `icon`, `text_align`, `is_default`, `created_at`, `updated_at`)
VALUES
	(1,'English','en','5f15968db08911595250317.png',0,1,'2020-07-06 03:47:55','2022-05-24 08:38:32');

/*!40000 ALTER TABLE `languages` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table migrations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `migrations`;

CREATE TABLE `migrations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;

INSERT INTO `migrations` (`id`, `migration`, `batch`)
VALUES
	(1,'2014_10_12_000000_create_users_table',1),
	(2,'2019_08_19_000000_create_failed_jobs_table',1),
	(4,'2020_06_14_061757_create_support_tickets_table',3),
	(5,'2020_06_14_061837_create_support_messages_table',3),
	(6,'2020_06_14_061904_create_support_attachments_table',3),
	(7,'2020_06_14_062359_create_admins_table',3),
	(8,'2020_06_14_064604_create_transactions_table',4),
	(9,'2020_06_14_065247_create_general_settings_table',5),
	(12,'2014_10_12_100000_create_password_resets_table',6),
	(13,'2020_06_14_060541_create_user_logins_table',6),
	(14,'2020_06_14_071708_create_admin_password_resets_table',7),
	(15,'2020_09_14_053026_create_countries_table',8),
	(16,'2021_03_15_084721_create_admin_notifications_table',9),
	(17,'2016_06_01_000001_create_oauth_auth_codes_table',10),
	(18,'2016_06_01_000002_create_oauth_access_tokens_table',10),
	(19,'2016_06_01_000003_create_oauth_refresh_tokens_table',10),
	(20,'2016_06_01_000004_create_oauth_clients_table',10),
	(21,'2016_06_01_000005_create_oauth_personal_access_clients_table',10),
	(22,'2021_05_08_103925_create_sms_gateways_table',11),
	(23,'2019_12_14_000001_create_personal_access_tokens_table',12),
	(24,'2021_05_23_111859_create_email_logs_table',13),
	(25,'2022_02_26_061836_create_forms_table',14),
	(26,'2022_04_19_135610_create_categories_table',15),
	(28,'2022_04_24_134752_create_stores_table',17),
	(29,'2022_04_26_125346_create_packages_table',18),
	(30,'2022_05_07_121843_create_advertisements_table',19);

/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table notification_logs
# ------------------------------------------------------------

DROP TABLE IF EXISTS `notification_logs`;

CREATE TABLE `notification_logs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL DEFAULT '0',
  `sender` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sent_from` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sent_to` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subject` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` text COLLATE utf8mb4_unicode_ci,
  `notification_type` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `notification_logs` WRITE;
/*!40000 ALTER TABLE `notification_logs` DISABLE KEYS */;

INSERT INTO `notification_logs` (`id`, `user_id`, `sender`, `sent_from`, `sent_to`, `subject`, `message`, `notification_type`, `created_at`, `updated_at`)
VALUES
	(1,1,'php','info@bucleupsavings.com','pmaxmorales@hotmail.com','Reply Support Ticket','<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\r\n  <!--[if !mso]><!-->\r\n  <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\r\n  <!--<![endif]-->\r\n  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n  <title></title>\r\n  <style type=\"text/css\">\r\n.ReadMsgBody { width: 100%; background-color: #ffffff; }\r\n.ExternalClass { width: 100%; background-color: #ffffff; }\r\n.ExternalClass, .ExternalClass p, .ExternalClass span, .ExternalClass font, .ExternalClass td, .ExternalClass div { line-height: 100%; }\r\nhtml { width: 100%; }\r\nbody { -webkit-text-size-adjust: none; -ms-text-size-adjust: none; margin: 0; padding: 0; }\r\ntable { border-spacing: 0; table-layout: fixed; margin: 0 auto;border-collapse: collapse; }\r\ntable table table { table-layout: auto; }\r\n.yshortcuts a { border-bottom: none !important; }\r\nimg:hover { opacity: 0.9 !important; }\r\na { color: #0087ff; text-decoration: none; }\r\n.textbutton a { font-family: \'open sans\', arial, sans-serif !important;}\r\n.btn-link a { color:#FFFFFF !important;}\r\n\r\n@media only screen and (max-width: 480px) {\r\nbody { width: auto !important; }\r\n*[class=\"table-inner\"] { width: 90% !important; text-align: center !important; }\r\n*[class=\"table-full\"] { width: 100% !important; text-align: center !important; }\r\n/* image */\r\nimg[class=\"img1\"] { width: 100% !important; height: auto !important; }\r\n}\r\n</style>\r\n\r\n\r\n\r\n  <table bgcolor=\"#414a51\" width=\"100%\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\">\r\n    <tbody><tr>\r\n      <td height=\"50\"></td>\r\n    </tr>\r\n    <tr>\r\n      <td align=\"center\" style=\"text-align:center;vertical-align:top;font-size:0;\">\r\n        <table align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n          <tbody><tr>\r\n            <td align=\"center\" width=\"600\">\r\n              <!--header-->\r\n              <table class=\"table-inner\" width=\"95%\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\">\r\n                <tbody><tr>\r\n                  <td bgcolor=\"#0087ff\" style=\"border-top-left-radius:6px; border-top-right-radius:6px;text-align:center;vertical-align:top;font-size:0;\" align=\"center\">\r\n                    <table width=\"90%\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\">\r\n                      <tbody><tr>\r\n                        <td height=\"20\"></td>\r\n                      </tr>\r\n                      <tr>\r\n                        <td align=\"center\" style=\"font-family: \'Open sans\', Arial, sans-serif; color:#FFFFFF; font-size:16px; font-weight: bold;\">This is a System Generated Email</td>\r\n                      </tr>\r\n                      <tr>\r\n                        <td height=\"20\"></td>\r\n                      </tr>\r\n                    </tbody></table>\r\n                  </td>\r\n                </tr>\r\n              </tbody></table>\r\n              <!--end header-->\r\n              <table class=\"table-inner\" width=\"95%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n                <tbody><tr>\r\n                  <td bgcolor=\"#FFFFFF\" align=\"center\" style=\"text-align:center;vertical-align:top;font-size:0;\">\r\n                    <table align=\"center\" width=\"90%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n                      <tbody><tr>\r\n                        <td height=\"35\"></td>\r\n                      </tr>\r\n                      <!--logo-->\r\n                      <tr>\r\n                        <td align=\"center\" style=\"vertical-align:top;font-size:0;\">\r\n                          <a href=\"#\">\r\n                            <br>\r\n                          </a>\r\n                        </td>\r\n                      </tr>\r\n                      <!--end logo-->\r\n                      <tr>\r\n                        <td height=\"40\"></td>\r\n                      </tr>\r\n                      <!--headline-->\r\n                      <tr>\r\n                        <td align=\"center\" style=\"font-family: \'Open Sans\', Arial, sans-serif; font-size: 22px;color:#414a51;font-weight: bold;\">Hello Roger Morales (bitrogers)</td>\r\n                      </tr>\r\n                      <!--end headline-->\r\n                      <tr>\r\n                        <td align=\"center\" style=\"text-align:center;vertical-align:top;font-size:0;\">\r\n                          <table width=\"40\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\">\r\n                            <tbody><tr>\r\n                              <td height=\"20\" style=\" border-bottom:3px solid #0087ff;\"></td>\r\n                            </tr>\r\n                          </tbody></table>\r\n                        </td>\r\n                      </tr>\r\n                      <tr>\r\n                        <td height=\"20\"></td>\r\n                      </tr>\r\n                      <!--content-->\r\n                      <tr>\r\n                        <td align=\"left\" style=\"font-family: \'Open sans\', Arial, sans-serif; color:#7f8c8d; font-size:16px; line-height: 28px;\"><div><p><span data-mce-style=\"font-size: 11pt;\" style=\"font-size: 11pt;\"><span style=\"font-weight: bolder;\">A member from our support team has replied to the following ticket:</span></span></p><p><span style=\"font-weight: bolder;\"><span data-mce-style=\"font-size: 11pt;\" style=\"font-size: 11pt;\"><span style=\"font-weight: bolder;\"><br></span></span></span></p><p><span style=\"font-weight: bolder;\">[Ticket#545749] I have severa problems<br><br>Click here to reply:&nbsp; http://localhost/buckle/ticket/view/545749</span></p><p>----------------------------------------------</p><p>Here is the reply :<br></p><p>Ok, a moment<br></p></div><div><br style=\"font-family: Montserrat, sans-serif;\"></div></td>\r\n                      </tr>\r\n                      <!--end content-->\r\n                      <tr>\r\n                        <td height=\"40\"></td>\r\n                      </tr>\r\n              \r\n                    </tbody></table>\r\n                  </td>\r\n                </tr>\r\n                <tr>\r\n                  <td height=\"45\" align=\"center\" bgcolor=\"#f4f4f4\" style=\"border-bottom-left-radius:6px;border-bottom-right-radius:6px;\">\r\n                    <table align=\"center\" width=\"90%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n                      <tbody><tr>\r\n                        <td height=\"10\"></td>\r\n                      </tr>\r\n                      <!--preference-->\r\n                      <tr>\r\n                        <td class=\"preference-link\" align=\"center\" style=\"font-family: \'Open sans\', Arial, sans-serif; color:#95a5a6; font-size:14px;\">\r\n                          © 2023&nbsp;<a href=\"#\">Buckleup Savings</a>&nbsp;. All Rights Reserved. \r\n                        </td>\r\n                      </tr>\r\n                      <!--end preference-->\r\n                      <tr>\r\n                        <td height=\"10\"></td>\r\n                      </tr>\r\n                    </tbody></table>\r\n                  </td>\r\n                </tr>\r\n              </tbody></table>\r\n            </td>\r\n          </tr>\r\n        </tbody></table>\r\n      </td>\r\n    </tr>\r\n    <tr>\r\n      <td height=\"60\"></td>\r\n    </tr>\r\n  </tbody></table>','email','2023-10-27 20:32:40','2023-10-27 20:32:40'),
	(2,1,'infobip','info@bucleupsavings.com','933051234561','Reply Support Ticket','hi Roger Morales (bitrogers), Your Ticket#545749 :  I have severa problems has been replied.','sms','2023-10-27 20:32:41','2023-10-27 20:32:41'),
	(3,1,'php','info@bucleupsavings.com','pmaxmorales@hotmail.com','Could you whitelist my IP?','<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\r\n  <!--[if !mso]><!-->\r\n  <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\r\n  <!--<![endif]-->\r\n  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n  <title></title>\r\n  <style type=\"text/css\">\r\n.ReadMsgBody { width: 100%; background-color: #ffffff; }\r\n.ExternalClass { width: 100%; background-color: #ffffff; }\r\n.ExternalClass, .ExternalClass p, .ExternalClass span, .ExternalClass font, .ExternalClass td, .ExternalClass div { line-height: 100%; }\r\nhtml { width: 100%; }\r\nbody { -webkit-text-size-adjust: none; -ms-text-size-adjust: none; margin: 0; padding: 0; }\r\ntable { border-spacing: 0; table-layout: fixed; margin: 0 auto;border-collapse: collapse; }\r\ntable table table { table-layout: auto; }\r\n.yshortcuts a { border-bottom: none !important; }\r\nimg:hover { opacity: 0.9 !important; }\r\na { color: #0087ff; text-decoration: none; }\r\n.textbutton a { font-family: \'open sans\', arial, sans-serif !important;}\r\n.btn-link a { color:#FFFFFF !important;}\r\n\r\n@media only screen and (max-width: 480px) {\r\nbody { width: auto !important; }\r\n*[class=\"table-inner\"] { width: 90% !important; text-align: center !important; }\r\n*[class=\"table-full\"] { width: 100% !important; text-align: center !important; }\r\n/* image */\r\nimg[class=\"img1\"] { width: 100% !important; height: auto !important; }\r\n}\r\n</style>\r\n\r\n\r\n\r\n  <table bgcolor=\"#414a51\" width=\"100%\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\">\r\n    <tbody><tr>\r\n      <td height=\"50\"></td>\r\n    </tr>\r\n    <tr>\r\n      <td align=\"center\" style=\"text-align:center;vertical-align:top;font-size:0;\">\r\n        <table align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n          <tbody><tr>\r\n            <td align=\"center\" width=\"600\">\r\n              <!--header-->\r\n              <table class=\"table-inner\" width=\"95%\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\">\r\n                <tbody><tr>\r\n                  <td bgcolor=\"#0087ff\" style=\"border-top-left-radius:6px; border-top-right-radius:6px;text-align:center;vertical-align:top;font-size:0;\" align=\"center\">\r\n                    <table width=\"90%\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\">\r\n                      <tbody><tr>\r\n                        <td height=\"20\"></td>\r\n                      </tr>\r\n                      <tr>\r\n                        <td align=\"center\" style=\"font-family: \'Open sans\', Arial, sans-serif; color:#FFFFFF; font-size:16px; font-weight: bold;\">This is a System Generated Email</td>\r\n                      </tr>\r\n                      <tr>\r\n                        <td height=\"20\"></td>\r\n                      </tr>\r\n                    </tbody></table>\r\n                  </td>\r\n                </tr>\r\n              </tbody></table>\r\n              <!--end header-->\r\n              <table class=\"table-inner\" width=\"95%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n                <tbody><tr>\r\n                  <td bgcolor=\"#FFFFFF\" align=\"center\" style=\"text-align:center;vertical-align:top;font-size:0;\">\r\n                    <table align=\"center\" width=\"90%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n                      <tbody><tr>\r\n                        <td height=\"35\"></td>\r\n                      </tr>\r\n                      <!--logo-->\r\n                      <tr>\r\n                        <td align=\"center\" style=\"vertical-align:top;font-size:0;\">\r\n                          <a href=\"#\">\r\n                            <br>\r\n                          </a>\r\n                        </td>\r\n                      </tr>\r\n                      <!--end logo-->\r\n                      <tr>\r\n                        <td height=\"40\"></td>\r\n                      </tr>\r\n                      <!--headline-->\r\n                      <tr>\r\n                        <td align=\"center\" style=\"font-family: \'Open Sans\', Arial, sans-serif; font-size: 22px;color:#414a51;font-weight: bold;\">Hello Roger Morales (bitrogers)</td>\r\n                      </tr>\r\n                      <!--end headline-->\r\n                      <tr>\r\n                        <td align=\"center\" style=\"text-align:center;vertical-align:top;font-size:0;\">\r\n                          <table width=\"40\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\">\r\n                            <tbody><tr>\r\n                              <td height=\"20\" style=\" border-bottom:3px solid #0087ff;\"></td>\r\n                            </tr>\r\n                          </tbody></table>\r\n                        </td>\r\n                      </tr>\r\n                      <tr>\r\n                        <td height=\"20\"></td>\r\n                      </tr>\r\n                      <!--content-->\r\n                      <tr>\r\n                        <td align=\"left\" style=\"font-family: \'Open sans\', Arial, sans-serif; color:#7f8c8d; font-size:16px; line-height: 28px;\">test</td>\r\n                      </tr>\r\n                      <!--end content-->\r\n                      <tr>\r\n                        <td height=\"40\"></td>\r\n                      </tr>\r\n              \r\n                    </tbody></table>\r\n                  </td>\r\n                </tr>\r\n                <tr>\r\n                  <td height=\"45\" align=\"center\" bgcolor=\"#f4f4f4\" style=\"border-bottom-left-radius:6px;border-bottom-right-radius:6px;\">\r\n                    <table align=\"center\" width=\"90%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n                      <tbody><tr>\r\n                        <td height=\"10\"></td>\r\n                      </tr>\r\n                      <!--preference-->\r\n                      <tr>\r\n                        <td class=\"preference-link\" align=\"center\" style=\"font-family: \'Open sans\', Arial, sans-serif; color:#95a5a6; font-size:14px;\">\r\n                          © 2023&nbsp;<a href=\"#\">Buckleup Savings</a>&nbsp;. All Rights Reserved. \r\n                        </td>\r\n                      </tr>\r\n                      <!--end preference-->\r\n                      <tr>\r\n                        <td height=\"10\"></td>\r\n                      </tr>\r\n                    </tbody></table>\r\n                  </td>\r\n                </tr>\r\n              </tbody></table>\r\n            </td>\r\n          </tr>\r\n        </tbody></table>\r\n      </td>\r\n    </tr>\r\n    <tr>\r\n      <td height=\"60\"></td>\r\n    </tr>\r\n  </tbody></table>','email','2023-10-27 20:43:35','2023-10-27 20:43:35'),
	(4,1,'infobip','info@bucleupsavings.com','933051234561','Could you whitelist my IP?','hi Roger Morales (bitrogers), test','sms','2023-10-27 20:43:36','2023-10-27 20:43:36');

/*!40000 ALTER TABLE `notification_logs` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table notification_templates
# ------------------------------------------------------------

DROP TABLE IF EXISTS `notification_templates`;

CREATE TABLE `notification_templates` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `act` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subj` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_body` text COLLATE utf8mb4_unicode_ci,
  `sms_body` text COLLATE utf8mb4_unicode_ci,
  `shortcodes` text COLLATE utf8mb4_unicode_ci,
  `email_status` tinyint(1) NOT NULL DEFAULT '1',
  `sms_status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `notification_templates` WRITE;
/*!40000 ALTER TABLE `notification_templates` DISABLE KEYS */;

INSERT INTO `notification_templates` (`id`, `act`, `name`, `subj`, `email_body`, `sms_body`, `shortcodes`, `email_status`, `sms_status`, `created_at`, `updated_at`)
VALUES
	(3,'DEPOSIT_COMPLETE','Deposit - Automated - Successful','Deposit Completed Successfully','<div>Your deposit of&nbsp;<span style=\"font-weight: bolder;\">{{amount}} {{site_currency}}</span>&nbsp;is via&nbsp;&nbsp;<span style=\"font-weight: bolder;\">{{method_name}}&nbsp;</span>has been completed Successfully.<span style=\"font-weight: bolder;\"><br></span></div><div><span style=\"font-weight: bolder;\"><br></span></div><div><span style=\"font-weight: bolder;\">Details of your Deposit :<br></span></div><div><br></div><div>Amount : {{amount}} {{site_currency}}</div><div>Charge:&nbsp;<font color=\"#000000\">{{charge}} {{site_currency}}</font></div><div><br></div><div>Conversion Rate : 1 {{site_currency}} = {{rate}} {{method_currency}}</div><div>Received : {{method_amount}} {{method_currency}}<br></div><div>Paid via :&nbsp; {{method_name}}</div><div><br></div><div>Transaction Number : {{trx}}</div><div><font size=\"5\"><span style=\"font-weight: bolder;\"><br></span></font></div><div><font size=\"5\">Your current Balance is&nbsp;<span style=\"font-weight: bolder;\">{{post_balance}} {{site_currency}}</span></font></div><div><br style=\"font-family: Montserrat, sans-serif;\"></div>','{{amount}} {{site_currency}} Deposit successfully by {{method_name}}','{\"trx\":\"Transaction number for the deposit\",\"amount\":\"Amount inserted by the user\",\"charge\":\"Gateway charge set by the admin\",\"rate\":\"Conversion rate between base currency and method currency\",\"method_name\":\"Name of the deposit method\",\"method_currency\":\"Currency of the deposit method\",\"method_amount\":\"Amount after conversion between base currency and method currency\",\"post_balance\":\"Balance of the user after this transaction\"}',1,1,'2021-11-03 12:00:00','2022-04-03 02:25:43'),
	(4,'DEPOSIT_APPROVE','Deposit - Manual - Approved','Your Deposit is Approved','<div style=\"font-family: Montserrat, sans-serif;\">Your deposit request of&nbsp;<span style=\"font-weight: bolder;\">{{amount}} {{site_currency}}</span>&nbsp;is via&nbsp;&nbsp;<span style=\"font-weight: bolder;\">{{method_name}}&nbsp;</span>is Approved .<span style=\"font-weight: bolder;\"><br></span></div><div style=\"font-family: Montserrat, sans-serif;\"><span style=\"font-weight: bolder;\"><br></span></div><div style=\"font-family: Montserrat, sans-serif;\"><span style=\"font-weight: bolder;\">Details of your Deposit :<br></span></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Amount : {{amount}} {{site_currency}}</div><div style=\"font-family: Montserrat, sans-serif;\">Charge:&nbsp;<font color=\"#FF0000\">{{charge}} {{site_currency}}</font></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Conversion Rate : 1 {{site_currency}} = {{rate}} {{method_currency}}</div><div style=\"font-family: Montserrat, sans-serif;\">Received : {{method_amount}} {{method_currency}}<br></div><div style=\"font-family: Montserrat, sans-serif;\">Paid via :&nbsp; {{method_name}}</div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Transaction Number : {{trx}}</div><div style=\"font-family: Montserrat, sans-serif;\"><font size=\"5\"><span style=\"font-weight: bolder;\"><br></span></font></div><div style=\"font-family: Montserrat, sans-serif;\"><font size=\"5\">Your current Balance is&nbsp;<span style=\"font-weight: bolder;\">{{post_balance}} {{site_currency}}</span></font></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div>','Admin Approve Your {{amount}} {{site_currency}} payment request by {{method_name}} transaction : {{trx}}','{\"trx\":\"Transaction number for the deposit\",\"amount\":\"Amount inserted by the user\",\"charge\":\"Gateway charge set by the admin\",\"rate\":\"Conversion rate between base currency and method currency\",\"method_name\":\"Name of the deposit method\",\"method_currency\":\"Currency of the deposit method\",\"method_amount\":\"Amount after conversion between base currency and method currency\",\"post_balance\":\"Balance of the user after this transaction\"}',1,1,'2021-11-03 12:00:00','2022-04-03 02:26:07'),
	(5,'DEPOSIT_REJECT','Deposit - Manual - Rejected','Your Deposit Request is Rejected','<div style=\"font-family: Montserrat, sans-serif;\">Your deposit request of&nbsp;<span style=\"font-weight: bolder;\">{{amount}} {{site_currency}}</span>&nbsp;is via&nbsp;&nbsp;<span style=\"font-weight: bolder;\">{{method_name}} has been rejected</span>.<span style=\"font-weight: bolder;\"><br></span></div><div><br></div><div><br></div><div style=\"font-family: Montserrat, sans-serif;\">Conversion Rate : 1 {{site_currency}} = {{rate}} {{method_currency}}</div><div style=\"font-family: Montserrat, sans-serif;\">Received : {{method_amount}} {{method_currency}}<br></div><div style=\"font-family: Montserrat, sans-serif;\">Paid via :&nbsp; {{method_name}}</div><div style=\"font-family: Montserrat, sans-serif;\">Charge: {{charge}}</div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Transaction Number was : {{trx}}</div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">if you have any queries, feel free to contact us.<br></div><br style=\"font-family: Montserrat, sans-serif;\"><div style=\"font-family: Montserrat, sans-serif;\"><br><br></div><span style=\"color: rgb(33, 37, 41); font-family: Montserrat, sans-serif;\">{{rejection_message}}</span><br>','Admin Rejected Your {{amount}} {{site_currency}} payment request by {{method_name}}\r\n\r\n{{rejection_message}}','{\"trx\":\"Transaction number for the deposit\",\"amount\":\"Amount inserted by the user\",\"charge\":\"Gateway charge set by the admin\",\"rate\":\"Conversion rate between base currency and method currency\",\"method_name\":\"Name of the deposit method\",\"method_currency\":\"Currency of the deposit method\",\"method_amount\":\"Amount after conversion between base currency and method currency\",\"rejection_message\":\"Rejection message by the admin\"}',1,1,'2021-11-03 12:00:00','2022-04-05 03:45:27'),
	(6,'DEPOSIT_REQUEST','Deposit - Manual - Requested','Deposit Request Submitted Successfully','<div>Your deposit request of&nbsp;<span style=\"font-weight: bolder;\">{{amount}} {{site_currency}}</span>&nbsp;is via&nbsp;&nbsp;<span style=\"font-weight: bolder;\">{{method_name}}&nbsp;</span>submitted successfully<span style=\"font-weight: bolder;\">&nbsp;.<br></span></div><div><span style=\"font-weight: bolder;\"><br></span></div><div><span style=\"font-weight: bolder;\">Details of your Deposit :<br></span></div><div><br></div><div>Amount : {{amount}} {{site_currency}}</div><div>Charge:&nbsp;<font color=\"#FF0000\">{{charge}} {{site_currency}}</font></div><div><br></div><div>Conversion Rate : 1 {{site_currency}} = {{rate}} {{method_currency}}</div><div>Payable : {{method_amount}} {{method_currency}}<br></div><div>Pay via :&nbsp; {{method_name}}</div><div><br></div><div>Transaction Number : {{trx}}</div><div><br></div><div><br style=\"font-family: Montserrat, sans-serif;\"></div>','{{amount}} {{site_currency}} Deposit requested by {{method_name}}. Charge: {{charge}} . Trx: {{trx}}','{\"trx\":\"Transaction number for the deposit\",\"amount\":\"Amount inserted by the user\",\"charge\":\"Gateway charge set by the admin\",\"rate\":\"Conversion rate between base currency and method currency\",\"method_name\":\"Name of the deposit method\",\"method_currency\":\"Currency of the deposit method\",\"method_amount\":\"Amount after conversion between base currency and method currency\"}',1,1,'2021-11-03 12:00:00','2022-04-03 02:29:19'),
	(7,'PASS_RESET_CODE','Password - Reset - Code','Password Reset','<div style=\"font-family: Montserrat, sans-serif;\">We have received a request to reset the password for your account on&nbsp;<span style=\"font-weight: bolder;\">{{time}} .<br></span></div><div style=\"font-family: Montserrat, sans-serif;\">Requested From IP:&nbsp;<span style=\"font-weight: bolder;\">{{ip}}</span>&nbsp;using&nbsp;<span style=\"font-weight: bolder;\">{{browser}}</span>&nbsp;on&nbsp;<span style=\"font-weight: bolder;\">{{operating_system}}&nbsp;</span>.</div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><br style=\"font-family: Montserrat, sans-serif;\"><div style=\"font-family: Montserrat, sans-serif;\"><div>Your account recovery code is:&nbsp;&nbsp;&nbsp;<font size=\"6\"><span style=\"font-weight: bolder;\">{{code}}</span></font></div><div><br></div></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\"><font size=\"4\" color=\"#CC0000\">If you do not wish to reset your password, please disregard this message.&nbsp;</font><br></div><div><font size=\"4\" color=\"#CC0000\"><br></font></div>','Your account recovery code is: {{code}}','{\"code\":\"Verification code for password reset\",\"ip\":\"IP address of the user\",\"browser\":\"Browser of the user\",\"operating_system\":\"Operating system of the user\",\"time\":\"Time of the request\"}',1,0,'2021-11-03 12:00:00','2022-03-20 20:47:05'),
	(8,'PASS_RESET_DONE','Password - Reset - Confirmation','You have reset your password','<p style=\"font-family: Montserrat, sans-serif;\">You have successfully reset your password.</p><p style=\"font-family: Montserrat, sans-serif;\">You changed from&nbsp; IP:&nbsp;<span style=\"font-weight: bolder;\">{{ip}}</span>&nbsp;using&nbsp;<span style=\"font-weight: bolder;\">{{browser}}</span>&nbsp;on&nbsp;<span style=\"font-weight: bolder;\">{{operating_system}}&nbsp;</span>&nbsp;on&nbsp;<span style=\"font-weight: bolder;\">{{time}}</span></p><p style=\"font-family: Montserrat, sans-serif;\"><span style=\"font-weight: bolder;\"><br></span></p><p style=\"font-family: Montserrat, sans-serif;\"><span style=\"font-weight: bolder;\"><font color=\"#ff0000\">If you did not change that, please contact us as soon as possible.</font></span></p>','Your password has been changed successfully','{\"ip\":\"IP address of the user\",\"browser\":\"Browser of the user\",\"operating_system\":\"Operating system of the user\",\"time\":\"Time of the request\"}',1,1,'2021-11-03 12:00:00','2022-04-05 03:46:35'),
	(9,'ADMIN_SUPPORT_REPLY','Support - Reply','Reply Support Ticket','<div><p><span data-mce-style=\"font-size: 11pt;\" style=\"font-size: 11pt;\"><span style=\"font-weight: bolder;\">A member from our support team has replied to the following ticket:</span></span></p><p><span style=\"font-weight: bolder;\"><span data-mce-style=\"font-size: 11pt;\" style=\"font-size: 11pt;\"><span style=\"font-weight: bolder;\"><br></span></span></span></p><p><span style=\"font-weight: bolder;\">[Ticket#{{ticket_id}}] {{ticket_subject}}<br><br>Click here to reply:&nbsp; {{link}}</span></p><p>----------------------------------------------</p><p>Here is the reply :<br></p><p>{{reply}}<br></p></div><div><br style=\"font-family: Montserrat, sans-serif;\"></div>','Your Ticket#{{ticket_id}} :  {{ticket_subject}} has been replied.','{\"ticket_id\":\"ID of the support ticket\",\"ticket_subject\":\"Subject  of the support ticket\",\"reply\":\"Reply made by the admin\",\"link\":\"URL to view the support ticket\"}',1,1,'2021-11-03 12:00:00','2022-03-20 20:47:51'),
	(10,'EVER_CODE','Verification - Email','Please verify your email address','<br><div><div style=\"font-family: Montserrat, sans-serif;\">Thanks For joining us.<br></div><div style=\"font-family: Montserrat, sans-serif;\">Please use the below code to verify your email address.<br></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Your email verification code is:<font size=\"6\"><span style=\"font-weight: bolder;\">&nbsp;{{code}}</span></font></div></div>','---','{\"code\":\"Email verification code\"}',1,0,'2021-11-03 12:00:00','2022-04-03 02:32:07'),
	(11,'SVER_CODE','Verification - SMS','Verify Your Mobile Number','---','Your phone verification code is: {{code}}','{\"code\":\"SMS Verification Code\"}',0,1,'2021-11-03 12:00:00','2022-03-20 19:24:37'),
	(15,'DEFAULT','Default Template','{{subject}}','{{message}}','{{message}}','{\"subject\":\"Subject\",\"message\":\"Message\"}',1,1,'2019-09-14 13:14:22','2021-11-04 09:38:55'),
	(18,'PACKAGE_PURCHASED','Package Purchased - Successfully','Package Purchased Successfully','<div><span style=\"color: rgb(33, 37, 41); font-size: 1rem; text-align: var(--bs-body-text-align);\"><b>{{package_name}}</b>&nbsp;p</span>ackage purchased successfully</div><div><span style=\"font-weight: bolder;\"><br></span></div><div><span style=\"font-weight: bolder;\">Details of your Package:<br></span></div><div><br></div><div><div>Product Name: {{product_name}}</div><div>Featured Validity: {{featured_validity}}</div></div><div>Package Name: {{package_name}}</div><div><span style=\"color: rgb(33, 37, 41);\">Package Duration: {{duration}} Days</span><br></div><div>Price: {{price}} {{site_currency}}</div><div>Charge:&nbsp;<font color=\"#000000\">{{charge}} {{site_currency}}</font></div><div><br></div><div>Conversion Rate : 1 {{site_currency}} = {{rate}} {{method_currency}}</div><div>Received : {{method_amount}} {{method_currency}}<br></div><div>Paid via :&nbsp; {{method_name}}</div>','{{package_name}} package purchased successfully','{\"package_name\": \"Package name\",\r\n    \"product_name\": \"Product name\",\r\n    \"featured_validity\": \"Product featured validity\",\r\n    \"duration\": \"Package duration in days\",\r\n    \"price\": \"Package price\",\r\n    \"charge\": \"Gateway charge set by the admin\",\r\n    \"rate\": \"Conversion rate between base currency and method currency\",\r\n    \"method_name\": \"Name of the deposit method\",\r\n    \"method_currency\": \"Currency of the deposit method\",\r\n    \"method_amount\": \"Amount after conversion between base currency and method currency\"\r\n}',1,1,'2021-11-03 12:00:00','2022-05-08 07:34:52');

/*!40000 ALTER TABLE `notification_templates` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table packages
# ------------------------------------------------------------

DROP TABLE IF EXISTS `packages`;

CREATE TABLE `packages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` decimal(28,8) NOT NULL DEFAULT '0.00000000',
  `duration` int unsigned NOT NULL DEFAULT '0',
  `quantity_coupon_use` int DEFAULT '1',
  `status` tinyint NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `packages` WRITE;
/*!40000 ALTER TABLE `packages` DISABLE KEYS */;

INSERT INTO `packages` (`id`, `name`, `price`, `duration`, `quantity_coupon_use`, `status`, `created_at`, `updated_at`)
VALUES
	(1,'Premium',100.00000000,365,100,1,'2023-10-27 20:27:55','2023-10-31 05:17:54'),
	(2,'entrepreneurs',300.00000000,365,100,1,'2023-11-03 00:44:43','2023-11-03 00:44:43');

/*!40000 ALTER TABLE `packages` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table pages
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pages`;

CREATE TABLE `pages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tempname` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'template name',
  `secs` text COLLATE utf8mb4_unicode_ci,
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `pages` WRITE;
/*!40000 ALTER TABLE `pages` DISABLE KEYS */;

INSERT INTO `pages` (`id`, `name`, `slug`, `tempname`, `secs`, `is_default`, `created_at`, `updated_at`)
VALUES
	(1,'HOME','/','templates.basic.','[\"testimonial\"]',1,'2020-07-11 06:23:58','2023-10-30 21:52:27'),
	(4,'Blog','blog','templates.basic.',NULL,1,'2020-10-22 01:14:43','2022-05-14 10:15:32'),
	(5,'Contact','contact','templates.basic.',NULL,1,'2020-10-22 01:14:53','2022-05-14 10:16:18'),
	(22,'Coupon','coupon','templates.basic.',NULL,1,'2022-05-16 07:32:46','2022-05-16 07:34:51');

/*!40000 ALTER TABLE `pages` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table password_resets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `password_resets`;

CREATE TABLE `password_resets` (
  `email` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `token` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `password_resets` WRITE;
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;

INSERT INTO `password_resets` (`email`, `token`, `created_at`)
VALUES
	('ronnie@gmail.com','100375','2020-07-07 05:44:47'),
	('user@site.comfff','988862','2021-05-07 07:31:28'),
	('mosta@gmail.com','865544','2021-06-10 09:21:05'),
	('user2@site.com','282525','2022-05-08 04:03:32'),
	('user@site.com','190217','2022-05-21 09:21:38');

/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table request_withdrawal
# ------------------------------------------------------------

DROP TABLE IF EXISTS `request_withdrawal`;

CREATE TABLE `request_withdrawal` (
  `id` int NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `trx` varchar(40) COLLATE utf8mb4_general_ci NOT NULL,
  `status` enum('compelted','pending','failed','') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` bigint unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;



# Dump of table stores
# ------------------------------------------------------------

DROP TABLE IF EXISTS `stores`;

CREATE TABLE `stores` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL DEFAULT '0',
  `name` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `featured` tinyint NOT NULL DEFAULT '0',
  `status` tinyint unsigned NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `stores` WRITE;
/*!40000 ALTER TABLE `stores` DISABLE KEYS */;

INSERT INTO `stores` (`id`, `user_id`, `name`, `image`, `featured`, `status`, `created_at`, `updated_at`)
VALUES
	(1,0,'Roger Morales','653c2a753d3881698441845.jpg',1,1,'2023-10-27 20:24:05','2023-10-27 20:36:07'),
	(2,1,'Test','654082ab4b2dd1698726571.png',0,1,'2023-10-31 03:29:31','2023-10-31 03:49:45'),
	(3,1,'Test','6546ed9ac7f0a1699147162.png',0,1,'2023-11-05 01:19:22','2023-11-05 01:19:22');

/*!40000 ALTER TABLE `stores` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table support_attachments
# ------------------------------------------------------------

DROP TABLE IF EXISTS `support_attachments`;

CREATE TABLE `support_attachments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `support_message_id` int unsigned DEFAULT NULL,
  `attachment` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table support_messages
# ------------------------------------------------------------

DROP TABLE IF EXISTS `support_messages`;

CREATE TABLE `support_messages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `support_ticket_id` int unsigned NOT NULL DEFAULT '0',
  `admin_id` int unsigned NOT NULL DEFAULT '0',
  `message` longtext COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `support_messages` WRITE;
/*!40000 ALTER TABLE `support_messages` DISABLE KEYS */;

INSERT INTO `support_messages` (`id`, `support_ticket_id`, `admin_id`, `message`, `created_at`, `updated_at`)
VALUES
	(1,1,0,'Hello','2023-10-27 20:32:10','2023-10-27 20:32:10'),
	(2,1,1,'Ok, a moment','2023-10-27 20:32:38','2023-10-27 20:32:38');

/*!40000 ALTER TABLE `support_messages` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table support_tickets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `support_tickets`;

CREATE TABLE `support_tickets` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT '0',
  `name` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ticket` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subject` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0: Open, 1: Answered, 2: Replied, 3: Closed',
  `priority` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1 = Low, 2 = medium, 3 = heigh',
  `last_reply` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `support_tickets` WRITE;
/*!40000 ALTER TABLE `support_tickets` DISABLE KEYS */;

INSERT INTO `support_tickets` (`id`, `user_id`, `name`, `email`, `ticket`, `subject`, `status`, `priority`, `last_reply`, `created_at`, `updated_at`)
VALUES
	(1,1,'Roger Morales','pmaxmorales@hotmail.com','545749','I have severa problems',1,3,'2023-10-27 14:32:38','2023-10-27 20:32:10','2023-10-27 20:32:38');

/*!40000 ALTER TABLE `support_tickets` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table user_logins
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user_logins`;

CREATE TABLE `user_logins` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL DEFAULT '0',
  `user_ip` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country_code` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `longitude` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `latitude` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `browser` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `os` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `user_logins` WRITE;
/*!40000 ALTER TABLE `user_logins` DISABLE KEYS */;

INSERT INTO `user_logins` (`id`, `user_id`, `user_ip`, `city`, `country`, `country_code`, `longitude`, `latitude`, `browser`, `os`, `created_at`, `updated_at`)
VALUES
	(1,1,'127.0.0.1','','','','','','Chrome','Windows 10','2023-10-27 20:30:37','2023-10-27 20:30:37'),
	(2,2,'174.49.235.199','Lancaster','United States','US','-76.3631','40.009','Chrome','Windows 10','2023-11-09 14:23:27','2023-11-09 14:23:27'),
	(3,3,'174.49.235.199','Lancaster','United States','US','-76.3631','40.009','Chrome','Windows 10','2023-11-12 07:04:17','2023-11-12 07:04:17'),
	(4,4,'190.113.110.180','San José','Costa Rica','CR','-84.0905','9.9395','Chrome','Windows 10','2023-11-12 13:23:27','2023-11-12 13:23:27'),
	(5,5,'190.113.110.180','San José','Costa Rica','CR','-84.0905','9.9395','Chrome','Windows 10','2023-11-13 06:23:04','2023-11-13 06:23:04'),
	(6,6,'174.49.235.199','Lancaster','United States','US','-76.3631','40.009','Chrome','Windows 10','2023-11-13 14:36:34','2023-11-13 14:36:34'),
	(7,6,'174.49.235.199','Lancaster','United States','US','-76.3631','40.009','Chrome','Windows 10','2023-11-13 14:58:12','2023-11-13 14:58:12'),
	(8,6,'201.207.239.95','San José','Costa Rica','CR','-84.1032','9.9354','Chrome','Windows 10','2023-11-13 14:59:42','2023-11-13 14:59:42'),
	(9,3,'174.49.235.199','Lancaster','United States','US','-76.3631','40.009','Handheld Browser','iPhone','2023-11-15 17:05:32','2023-11-15 17:05:32');

/*!40000 ALTER TABLE `user_logins` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `firstname` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lastname` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `username` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `country_code` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci COMMENT 'contains full address',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '0: banned, 1: active',
  `ev` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0: email unverified, 1: email verified',
  `sv` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0: mobile unverified, 1: mobile verified',
  `reg_step` tinyint(1) NOT NULL DEFAULT '0',
  `ver_code` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'stores verification code',
  `ver_code_send_at` datetime DEFAULT NULL COMMENT 'verification send time',
  `tsc` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ban_reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`,`email`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;

INSERT INTO `users` (`id`, `firstname`, `lastname`, `username`, `email`, `country_code`, `mobile`, `password`, `image`, `address`, `status`, `ev`, `sv`, `reg_step`, `ver_code`, `ver_code_send_at`, `tsc`, `ban_reason`, `remember_token`, `created_at`, `updated_at`)
VALUES
	(1,'Roger','Morales','bitrogers','pmaxmorales@hotmail.com','AF','933051234561','$2y$10$zgFY/tdPO300hHvgb7x8EOP/yi0qyds.UCRoL3xGUi6kc3W6J1XsK',NULL,'{\"country\":\"Afghanistan\",\"address\":\"miami\",\"state\":\"miami\",\"zip\":\"305\",\"city\":\"miami\"}',1,1,1,1,NULL,NULL,NULL,NULL,NULL,'2023-10-27 20:30:37','2023-10-27 20:34:49'),
	(2,'Norma','H','norma60','jncallcenter@yahoo.com','US','17177487549','$2y$10$zgFY/tdPO300hHvgb7x8EOP/yi0qyds.UCRoL3xGUi6kc3W6J1XsK',NULL,'{\"country\":\"United States\",\"address\":\"230\",\"state\":\"pensylvania\",\"zip\":\"17559\",\"city\":\"lancaster\"}',1,1,1,1,NULL,NULL,NULL,NULL,NULL,'2023-11-09 14:23:27','2023-11-09 14:24:05'),
	(3,'ann','lopez','annlopez','jhonelhodgson@yahoo.com','US','17177427895','$2y$10$zgFY/tdPO300hHvgb7x8EOP/yi0qyds.UCRoL3xGUi6kc3W6J1XsK',NULL,'{\"country\":\"United States\",\"address\":\"2304 Wilkes Road Lancaster pa 17601\",\"state\":\"Pennsylvania\",\"zip\":\"15773\",\"city\":\"LANCASTER\"}',1,1,1,1,NULL,NULL,NULL,NULL,'KqTI34DPvGvq4NSfvw3R8QFhd4sW5ICyUkGOGfuC4y0EyDoYf2bZjiyFU6cK','2023-11-12 07:04:17','2023-11-12 07:04:34'),
	(4,'roger','morales','notnot','pmaxmorales@test.com','CR','5068888888888','$2y$10$zgFY/tdPO300hHvgb7x8EOP/yi0qyds.UCRoL3xGUi6kc3W6J1XsK',NULL,'{\"country\":\"Costa Rica\",\"address\":\"test\",\"state\":\"test\",\"zip\":\"1121111\",\"city\":\"trst\"}',1,1,1,1,NULL,NULL,NULL,NULL,NULL,'2023-11-12 13:23:27','2023-11-12 13:23:42'),
	(5,'Roger','Morales','bitroger','rogeruni11@yahoo.com','CR','50600000000','$2y$10$zgFY/tdPO300hHvgb7x8EOP/yi0qyds.UCRoL3xGUi6kc3W6J1XsK',NULL,'{\"country\":\"Costa Rica\",\"address\":\"test\",\"state\":\"test\",\"zip\":\"41111\",\"city\":\"test\"}',1,1,1,1,NULL,NULL,NULL,NULL,NULL,'2023-11-13 06:23:04','2023-11-13 06:23:19'),
	(6,'jhonel','hodgson','jhonelh35','jhonelhodgson35@gmail.com','US','12581234785','$2y$10$zgFY/tdPO300hHvgb7x8EOP/yi0qyds.UCRoL3xGUi6kc3W6J1XsK',NULL,'{\"country\":\"United States\",\"address\":\"2304 Wilkes Road Lancaster pa 17601\",\"state\":\"Pennsylvania\",\"zip\":\"15773\",\"city\":\"LANCASTER\"}',1,1,1,1,NULL,NULL,NULL,NULL,'fBm4UwzHVBnvk2eACUO6F22stw1d4EG8pcFxo2x9wOaz4xy2GtCCaLte46bS','2023-11-13 14:36:34','2023-11-13 14:36:40');

/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table vouchers
# ------------------------------------------------------------

DROP TABLE IF EXISTS `vouchers`;

CREATE TABLE `vouchers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `file` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `trx` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` enum('approved','rejected','pending') COLLATE utf8mb4_general_ci DEFAULT 'pending',
  `coupon_code` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `reason` text COLLATE utf8mb4_general_ci,
  `user_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
