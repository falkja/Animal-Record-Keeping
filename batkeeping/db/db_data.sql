-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.2.3-falcon-alpha-community-nt


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema batkeeping
--

CREATE DATABASE IF NOT EXISTS batkeeping;
USE batkeeping;

--
-- Definition of table `bat_notes`
--

DROP TABLE IF EXISTS `bat_notes`;
CREATE TABLE `bat_notes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `bat_id` int(10) unsigned NOT NULL,
  `date` datetime NOT NULL,
  `text` text NOT NULL,
  `user_id` int(10) unsigned NOT NULL COMMENT 'signature',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `bat_notes`
--

/*!40000 ALTER TABLE `bat_notes` DISABLE KEYS */;
/*!40000 ALTER TABLE `bat_notes` ENABLE KEYS */;


--
-- Definition of table `bats`
--

DROP TABLE IF EXISTS `bats`;
CREATE TABLE `bats` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cage_id` int(10) unsigned DEFAULT NULL,
  `collection_date` datetime NOT NULL,
  `collection_age` varchar(45) NOT NULL COMMENT 'juvenile/adult',
  `collection_place` varchar(100) NOT NULL,
  `species` varchar(45) NOT NULL,
  `gender` varchar(1) NOT NULL COMMENT 'm/f',
  `leave_date` datetime DEFAULT NULL COMMENT 'y/n - in lab or not',
  `leave_reason` text COMMENT 'death/exported',
  `band` varchar(10) DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `note` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `bats`
--

/*!40000 ALTER TABLE `bats` DISABLE KEYS */;
INSERT INTO `bats` (`id`,`cage_id`,`collection_date`,`collection_age`,`collection_place`,`species`,`gender`,`leave_date`,`leave_reason`,`band`,`user_id`,`note`) VALUES 
 (1,NULL,'2006-12-15 00:00:00','Juvenile','Ben\'s Beard','Eptesicus fuscus','M','2006-12-15 00:00:00','Flew away','A1',NULL,NULL),
 (2,2,'2006-12-15 00:00:00','Adult','Murat\'s Hair','Eptesicus fuscus','F',NULL,NULL,'A2',NULL,'<tr><td>Bat catches mealworms</td><td>AtH</td><td>Mar 08, 2007</td></tr><tr><td>Bat now on non protocol</td><td>AtH</td><td>Mar 08, 2007</td></tr><tr><td>I love ajax</td><td>AtH</td><td>Mar 08, 2007</td></tr>'),
 (3,2,'2006-12-15 00:00:00','Juvenile','Kaushik\'s Glasses','Carollia perspicillata','F',NULL,NULL,'A3',NULL,NULL),
 (4,8,'2006-12-15 00:00:00','Adult','Chen\'s High Heeled Boots','Myotis septentrionalis','M',NULL,NULL,'A4',NULL,NULL),
 (5,3,'2006-12-15 00:00:00','Juvenile','Wei\'s Dumpling','Eptesicus fuscus','M',NULL,NULL,'A5',NULL,NULL),
 (6,2,'2006-12-15 00:00:00','Juvenile','Flea Market','Eptesicus fuscus','M',NULL,NULL,'A6',NULL,NULL);
/*!40000 ALTER TABLE `bats` ENABLE KEYS */;


--
-- Definition of table `cage_in_histories`
--

DROP TABLE IF EXISTS `cage_in_histories`;
CREATE TABLE `cage_in_histories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `bat_id` int(10) unsigned NOT NULL,
  `cage_id` int(10) unsigned NOT NULL,
  `date` datetime DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL COMMENT 'signature of user who did the change',
  `note` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `cage_in_histories`
--

/*!40000 ALTER TABLE `cage_in_histories` DISABLE KEYS */;
INSERT INTO `cage_in_histories` (`id`,`bat_id`,`cage_id`,`date`,`user_id`,`note`) VALUES 
 (1,1,1,'2006-12-15 20:09:09',1,NULL),
 (2,2,2,'2006-12-15 20:25:22',1,NULL),
 (3,3,3,'2006-12-15 20:26:07',1,NULL),
 (4,4,1,'2006-12-15 20:30:15',1,NULL),
 (5,5,2,'2006-12-15 20:31:23',1,NULL),
 (6,1,2,'2006-12-15 20:56:47',1,NULL),
 (7,4,2,'2006-12-15 20:56:47',1,NULL),
 (8,2,3,'2006-12-15 21:14:56',1,'teleported'),
 (9,6,2,'2006-12-15 21:15:54',1,'Fresh catch'),
 (10,6,3,'2006-12-15 21:16:53',1,'Too fiesty'),
 (11,5,6,'2006-12-16 21:16:54',2,'more bats in cage 99.  SWEET!'),
 (12,5,3,'2006-12-18 08:55:20',2,''),
 (13,3,5,'2006-12-18 09:04:51',2,''),
 (14,5,6,'2006-12-18 09:06:30',2,''),
 (15,3,3,'2006-12-18 09:08:18',2,''),
 (16,3,6,'2006-12-18 09:18:53',2,''),
 (17,2,2,'2006-12-18 09:25:45',2,''),
 (18,6,2,'2006-12-18 09:25:45',2,''),
 (19,4,6,'2006-12-18 09:26:01',2,''),
 (20,2,3,'2006-12-18 09:26:31',2,''),
 (21,6,3,'2006-12-18 09:26:31',2,''),
 (22,4,4,'2006-12-18 09:39:23',2,''),
 (23,5,2,'2006-12-18 09:48:51',2,''),
 (24,2,2,'2006-12-18 09:49:05',2,'');
INSERT INTO `cage_in_histories` (`id`,`bat_id`,`cage_id`,`date`,`user_id`,`note`) VALUES 
 (25,6,2,'2006-12-18 09:49:05',2,''),
 (26,4,2,'2006-12-18 09:49:59',2,''),
 (27,2,3,'2006-12-18 09:50:13',2,''),
 (28,4,3,'2006-12-18 09:50:13',2,''),
 (29,2,2,'2006-12-18 09:50:27',2,''),
 (30,4,2,'2006-12-18 09:50:27',2,''),
 (31,2,3,'2006-12-18 10:12:38',2,''),
 (32,4,3,'2006-12-18 10:12:38',2,''),
 (33,2,2,'2006-12-18 10:13:58',2,''),
 (34,4,2,'2006-12-18 10:13:58',2,''),
 (35,2,5,'2006-12-18 10:14:16',2,''),
 (36,4,5,'2006-12-18 10:14:16',2,''),
 (37,5,5,'2006-12-18 10:14:16',2,''),
 (38,2,2,'2006-12-18 10:14:53',2,''),
 (39,4,2,'2006-12-18 10:16:28',2,''),
 (40,5,2,'2006-12-18 10:16:28',2,''),
 (41,5,3,'2006-12-18 15:46:01',1,''),
 (42,2,4,'2007-01-03 10:55:20',4,''),
 (43,3,2,'2007-01-03 14:08:42',4,''),
 (44,3,3,'2007-01-03 14:18:59',4,''),
 (45,4,3,'2007-01-03 14:19:13',4,''),
 (46,6,3,'2007-01-03 14:19:25',4,''),
 (47,3,2,'2007-01-03 14:20:56',4,''),
 (48,4,7,'2007-01-18 22:22:15',4,''),
 (49,5,7,'2007-01-18 22:22:15',4,'');
INSERT INTO `cage_in_histories` (`id`,`bat_id`,`cage_id`,`date`,`user_id`,`note`) VALUES 
 (50,4,2,'2007-01-19 00:17:21',4,''),
 (51,5,2,'2007-01-19 00:17:21',4,''),
 (52,6,2,'2007-01-19 00:23:36',4,''),
 (53,5,3,'2007-01-19 00:23:48',4,''),
 (54,4,3,'2007-01-19 00:24:02',4,''),
 (55,4,7,'2007-01-19 00:46:32',4,''),
 (56,5,2,'2007-01-20 23:12:04',4,''),
 (57,2,2,'2007-02-01 13:15:15',4,''),
 (58,3,8,'2007-02-01 13:46:33',4,''),
 (59,5,8,'2007-02-01 13:46:34',4,''),
 (60,3,2,'2007-02-01 13:46:58',4,''),
 (61,5,2,'2007-02-01 13:46:58',4,''),
 (62,4,8,'2007-02-01 13:54:22',4,''),
 (63,4,3,'2007-02-01 13:57:09',4,''),
 (64,4,8,'2007-02-01 14:01:01',4,''),
 (65,4,4,'2007-02-01 14:01:31',4,''),
 (66,4,7,'2007-02-01 14:03:07',4,''),
 (67,4,2,'2007-02-01 14:23:41',4,''),
 (68,3,8,'2007-02-01 14:58:06',4,''),
 (69,4,8,'2007-02-01 14:58:06',4,''),
 (70,3,7,'2007-02-01 14:58:37',4,''),
 (71,4,7,'2007-02-01 14:58:37',4,''),
 (72,3,3,'2007-02-01 14:59:06',4,''),
 (73,4,3,'2007-02-01 14:59:06',4,''),
 (74,5,4,'2007-02-01 15:10:47',4,'');
INSERT INTO `cage_in_histories` (`id`,`bat_id`,`cage_id`,`date`,`user_id`,`note`) VALUES 
 (75,5,2,'2007-02-02 10:09:26',4,''),
 (76,2,8,'2007-02-02 10:13:32',4,''),
 (77,3,2,'2007-02-02 10:14:32',4,''),
 (78,4,2,'2007-02-02 10:14:32',4,''),
 (79,3,3,'2007-02-02 10:56:06',4,''),
 (80,4,3,'2007-02-02 10:56:06',4,''),
 (81,2,2,'2007-02-02 14:16:40',4,''),
 (82,3,8,'2007-02-02 14:17:24',4,''),
 (83,3,2,'2007-02-02 14:28:37',4,''),
 (84,2,5,'2007-02-02 14:29:12',4,''),
 (85,2,2,'2007-02-02 14:37:10',4,''),
 (86,2,8,'2007-02-02 15:29:29',4,''),
 (87,3,8,'2007-02-02 15:29:29',4,''),
 (88,4,5,'2007-02-05 11:30:27',4,''),
 (89,4,2,'2007-02-05 16:09:34',4,''),
 (90,6,6,'2007-02-05 16:28:26',4,''),
 (91,6,2,'2007-02-05 16:34:30',4,''),
 (92,2,3,'2007-02-06 16:23:44',4,''),
 (93,6,3,'2007-02-06 16:23:51',4,''),
 (94,6,2,'2007-02-06 18:27:37',4,''),
 (95,4,3,'2007-02-10 00:35:01',4,''),
 (96,7,18,'2007-02-10 10:14:39',NULL,NULL),
 (97,8,7,'2007-02-10 10:14:39',NULL,NULL),
 (98,9,4,'2007-02-10 10:14:39',NULL,NULL),
 (99,10,2,'2007-02-10 10:14:39',NULL,NULL);
INSERT INTO `cage_in_histories` (`id`,`bat_id`,`cage_id`,`date`,`user_id`,`note`) VALUES 
 (100,11,5,'2007-02-10 10:14:39',NULL,NULL),
 (101,12,10,'2007-02-10 10:14:39',NULL,NULL),
 (102,13,2,'2007-02-10 10:14:39',NULL,NULL),
 (103,14,7,'2007-02-10 10:14:39',NULL,NULL),
 (104,15,17,'2007-02-10 10:14:39',NULL,NULL),
 (105,16,2,'2007-02-10 10:14:39',NULL,NULL),
 (106,17,3,'2007-02-10 10:14:39',NULL,NULL),
 (107,18,10,'2007-02-10 10:14:39',NULL,NULL),
 (108,19,3,'2007-02-10 10:14:39',NULL,NULL),
 (109,20,3,'2007-02-10 10:14:39',NULL,NULL),
 (110,21,9,'2007-02-10 10:14:39',NULL,NULL),
 (111,22,2,'2007-02-10 10:14:39',NULL,NULL),
 (112,23,9,'2007-02-10 10:14:39',NULL,NULL),
 (113,24,7,'2007-02-10 10:14:39',NULL,NULL),
 (114,25,3,'2007-02-10 10:14:39',NULL,NULL),
 (115,26,6,'2007-02-10 10:14:39',NULL,NULL),
 (116,27,7,'2007-02-10 10:14:40',NULL,NULL),
 (117,28,6,'2007-02-10 10:14:40',NULL,NULL),
 (118,29,15,'2007-02-10 10:14:40',NULL,NULL),
 (119,30,17,'2007-02-10 10:14:40',NULL,NULL),
 (120,31,3,'2007-02-10 10:14:40',NULL,NULL),
 (121,32,6,'2007-02-10 10:14:40',NULL,NULL);
INSERT INTO `cage_in_histories` (`id`,`bat_id`,`cage_id`,`date`,`user_id`,`note`) VALUES 
 (122,33,9,'2007-02-10 10:14:40',NULL,NULL),
 (123,34,16,'2007-02-10 10:14:40',NULL,NULL),
 (124,35,15,'2007-02-10 10:14:40',NULL,NULL),
 (125,36,9,'2007-02-10 10:14:40',NULL,NULL),
 (126,37,15,'2007-02-10 10:14:40',NULL,NULL),
 (127,38,5,'2007-02-10 10:14:40',NULL,NULL),
 (128,39,9,'2007-02-10 10:14:40',NULL,NULL),
 (129,40,5,'2007-02-10 10:14:40',NULL,NULL),
 (130,41,3,'2007-02-10 10:14:40',NULL,NULL),
 (131,42,5,'2007-02-10 10:14:41',NULL,NULL),
 (132,43,13,'2007-02-10 10:14:41',NULL,NULL),
 (133,44,7,'2007-02-10 10:14:41',NULL,NULL),
 (134,45,2,'2007-02-10 10:14:41',NULL,NULL),
 (135,46,16,'2007-02-10 10:14:41',NULL,NULL),
 (136,47,7,'2007-02-10 10:14:41',NULL,NULL),
 (137,48,17,'2007-02-10 10:14:41',NULL,NULL),
 (138,49,17,'2007-02-10 10:14:41',NULL,NULL),
 (139,50,18,'2007-02-10 10:14:41',NULL,NULL),
 (140,51,5,'2007-02-10 10:14:41',NULL,NULL),
 (141,52,15,'2007-02-10 10:14:41',NULL,NULL),
 (142,53,13,'2007-02-10 10:14:41',NULL,NULL),
 (143,54,8,'2007-02-10 10:14:41',NULL,NULL);
INSERT INTO `cage_in_histories` (`id`,`bat_id`,`cage_id`,`date`,`user_id`,`note`) VALUES 
 (144,55,5,'2007-02-10 10:14:41',NULL,NULL),
 (145,56,8,'2007-02-10 10:14:41',NULL,NULL),
 (146,57,2,'2007-02-10 10:14:41',NULL,NULL),
 (147,58,9,'2007-02-10 10:14:41',NULL,NULL),
 (148,59,10,'2007-02-10 10:14:41',NULL,NULL),
 (149,60,9,'2007-02-10 10:14:41',NULL,NULL),
 (150,61,3,'2007-02-10 10:14:42',NULL,NULL),
 (151,62,12,'2007-02-10 10:14:42',NULL,NULL),
 (152,63,15,'2007-02-10 10:14:42',NULL,NULL),
 (153,64,12,'2007-02-10 10:14:42',NULL,NULL),
 (154,65,17,'2007-02-10 10:14:42',NULL,NULL),
 (155,66,6,'2007-02-10 10:14:42',NULL,NULL),
 (156,67,16,'2007-02-10 10:14:42',NULL,NULL),
 (157,68,17,'2007-02-10 10:14:42',NULL,NULL),
 (158,69,9,'2007-02-10 10:14:42',NULL,NULL),
 (159,70,10,'2007-02-10 10:14:42',NULL,NULL),
 (160,71,13,'2007-02-10 10:14:42',NULL,NULL),
 (161,72,12,'2007-02-10 10:14:42',NULL,NULL),
 (162,73,9,'2007-02-10 10:14:42',NULL,NULL),
 (163,74,10,'2007-02-10 10:14:42',NULL,NULL),
 (164,75,18,'2007-02-10 10:14:42',NULL,NULL);
INSERT INTO `cage_in_histories` (`id`,`bat_id`,`cage_id`,`date`,`user_id`,`note`) VALUES 
 (165,76,3,'2007-02-10 10:14:42',NULL,NULL),
 (166,77,7,'2007-02-10 10:14:42',NULL,NULL),
 (167,78,10,'2007-02-10 10:14:42',NULL,NULL),
 (168,79,5,'2007-02-10 10:14:42',NULL,NULL),
 (169,80,8,'2007-02-10 10:14:42',NULL,NULL),
 (170,81,17,'2007-02-10 10:14:42',NULL,NULL),
 (171,82,9,'2007-02-10 10:14:42',NULL,NULL),
 (172,83,18,'2007-02-10 10:14:42',NULL,NULL),
 (173,84,5,'2007-02-10 10:14:42',NULL,NULL),
 (174,85,5,'2007-02-10 10:14:42',NULL,NULL),
 (175,86,5,'2007-02-10 10:14:42',NULL,NULL),
 (176,2,2,'2007-02-10 10:21:27',1,''),
 (177,5,3,'2007-02-10 15:00:03',4,''),
 (178,2,3,'2007-02-11 12:32:22',1,''),
 (179,6,3,'2007-02-11 12:32:22',1,''),
 (180,2,2,'2007-02-11 12:40:04',1,''),
 (181,4,2,'2007-02-11 12:40:04',1,''),
 (182,5,2,'2007-02-11 12:40:04',1,''),
 (183,6,2,'2007-02-11 12:40:04',1,''),
 (184,2,3,'2007-02-11 12:40:50',1,''),
 (185,4,3,'2007-02-11 12:40:50',1,''),
 (186,5,3,'2007-02-11 12:40:50',1,''),
 (187,6,3,'2007-02-11 12:40:50',1,'');
INSERT INTO `cage_in_histories` (`id`,`bat_id`,`cage_id`,`date`,`user_id`,`note`) VALUES 
 (188,2,2,'2007-02-11 12:41:55',1,''),
 (189,4,2,'2007-02-11 12:41:55',1,''),
 (190,5,2,'2007-02-11 12:41:55',1,''),
 (191,6,2,'2007-02-11 12:41:55',1,''),
 (192,2,3,'2007-02-11 12:44:16',1,''),
 (193,4,3,'2007-02-11 12:44:16',1,''),
 (194,5,3,'2007-02-11 12:44:16',1,''),
 (195,6,3,'2007-02-11 12:44:16',1,''),
 (196,2,2,'2007-02-11 13:05:41',1,''),
 (197,4,2,'2007-02-11 13:05:41',1,''),
 (198,5,2,'2007-02-11 13:05:41',1,''),
 (199,6,2,'2007-02-11 13:05:41',1,''),
 (200,4,8,'2007-02-13 17:01:18',4,''),
 (201,2,3,'2007-02-13 17:04:03',4,''),
 (202,5,3,'2007-02-13 17:18:08',4,''),
 (203,3,2,'2007-03-12 18:10:58',4,''),
 (204,2,2,'2007-03-13 11:27:06',4,'');
/*!40000 ALTER TABLE `cage_in_histories` ENABLE KEYS */;


--
-- Definition of table `cage_out_histories`
--

DROP TABLE IF EXISTS `cage_out_histories`;
CREATE TABLE `cage_out_histories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `bat_id` int(10) unsigned NOT NULL,
  `cage_id` int(10) unsigned NOT NULL,
  `date` datetime DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL COMMENT 'sig of user who did the change',
  `note` text CHARACTER SET utf8,
  `cage_in_history_id` int(10) unsigned NOT NULL COMMENT 'each cage_out belongs to a cage in event',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cage_out_histories`
--

/*!40000 ALTER TABLE `cage_out_histories` DISABLE KEYS */;
INSERT INTO `cage_out_histories` (`id`,`bat_id`,`cage_id`,`date`,`user_id`,`note`,`cage_in_history_id`) VALUES 
 (1,1,1,'2006-12-15 20:56:47',1,'Wanted to',1),
 (2,4,1,'2006-12-15 20:56:47',1,'Wanted to',4),
 (3,1,2,'2006-12-15 21:00:05',1,'Flew away',6),
 (4,5,2,'2006-12-15 21:03:21',1,'Kidnapped by Ferrets',5),
 (5,2,2,'2006-12-15 21:14:56',1,'teleported',2),
 (6,6,2,'2006-12-15 21:16:53',1,'Too fiesty',9),
 (7,5,6,'2006-12-18 08:55:20',2,'',11),
 (8,3,3,'2006-12-18 09:04:51',2,'',3),
 (9,5,3,'2006-12-18 09:06:30',2,'',12),
 (10,3,5,'2006-12-18 09:08:18',2,'',13),
 (11,3,3,'2006-12-18 09:18:53',2,'',15),
 (12,2,3,'2006-12-18 09:25:45',2,'',8),
 (13,6,3,'2006-12-18 09:25:45',2,'',10),
 (14,4,2,'2006-12-18 09:26:01',2,'',7),
 (15,2,2,'2006-12-18 09:26:31',2,'',17),
 (16,6,2,'2006-12-18 09:26:31',2,'',18),
 (17,4,6,'2006-12-18 09:39:23',2,'',19),
 (18,5,6,'2006-12-18 09:48:51',2,'',14),
 (19,2,3,'2006-12-18 09:49:05',2,'',20),
 (20,6,3,'2006-12-18 09:49:05',2,'',21),
 (21,4,4,'2006-12-18 09:49:59',2,'',22),
 (22,2,2,'2006-12-18 09:50:13',2,'',24);
INSERT INTO `cage_out_histories` (`id`,`bat_id`,`cage_id`,`date`,`user_id`,`note`,`cage_in_history_id`) VALUES 
 (23,4,2,'2006-12-18 09:50:13',2,'',26),
 (24,2,3,'2006-12-18 09:50:27',2,'',27),
 (25,4,3,'2006-12-18 09:50:27',2,'',28),
 (26,2,2,'2006-12-18 10:12:38',2,'',29),
 (27,4,2,'2006-12-18 10:12:38',2,'',30),
 (28,2,3,'2006-12-18 10:13:58',2,'',31),
 (29,4,3,'2006-12-18 10:13:58',2,'',32),
 (30,2,2,'2006-12-18 10:14:16',2,'',33),
 (31,4,2,'2006-12-18 10:14:16',2,'',34),
 (32,5,2,'2006-12-18 10:14:16',2,'',23),
 (33,2,5,'2006-12-18 10:14:53',2,'',35),
 (34,4,5,'2006-12-18 10:16:28',2,'',36),
 (35,5,5,'2006-12-18 10:16:28',2,'',37),
 (36,5,2,'2006-12-18 15:46:01',1,'',40),
 (37,2,2,'2007-01-03 10:55:20',4,'',38),
 (38,3,6,'2007-01-03 14:08:42',4,'',16),
 (39,3,2,'2007-01-03 14:18:59',4,'',43),
 (40,4,2,'2007-01-03 14:19:13',4,'',39),
 (41,6,2,'2007-01-03 14:19:25',4,'',25),
 (42,3,3,'2007-01-03 14:20:55',4,'',44),
 (43,4,3,'2007-01-18 22:22:15',4,'',45),
 (44,5,3,'2007-01-18 22:22:15',4,'',41),
 (45,4,7,'2007-01-19 00:17:21',4,'',48);
INSERT INTO `cage_out_histories` (`id`,`bat_id`,`cage_id`,`date`,`user_id`,`note`,`cage_in_history_id`) VALUES 
 (46,5,7,'2007-01-19 00:17:21',4,'',49),
 (47,6,3,'2007-01-19 00:23:36',4,'',46),
 (48,5,2,'2007-01-19 00:23:48',4,'',51),
 (49,4,2,'2007-01-19 00:24:02',4,'',50),
 (50,4,3,'2007-01-19 00:46:32',4,'',54),
 (51,5,3,'2007-01-20 23:12:04',4,'',53),
 (52,2,4,'2007-02-01 13:15:15',4,'',42),
 (53,3,2,'2007-02-01 13:46:33',4,'',47),
 (54,5,2,'2007-02-01 13:46:34',4,'',56),
 (55,3,8,'2007-02-01 13:46:58',4,'',58),
 (56,5,8,'2007-02-01 13:46:58',4,'',59),
 (57,4,7,'2007-02-01 13:54:22',4,'',55),
 (58,4,8,'2007-02-01 13:57:09',4,'',62),
 (59,4,3,'2007-02-01 14:01:01',4,'',63),
 (60,4,8,'2007-02-01 14:01:31',4,'',64),
 (61,4,4,'2007-02-01 14:03:07',4,'',65),
 (62,4,7,'2007-02-01 14:23:41',4,'',66),
 (63,3,2,'2007-02-01 14:58:06',4,'',60),
 (64,4,2,'2007-02-01 14:58:06',4,'',67),
 (65,3,8,'2007-02-01 14:58:37',4,'',68),
 (66,4,8,'2007-02-01 14:58:37',4,'',69),
 (67,3,7,'2007-02-01 14:59:06',4,'',70),
 (68,4,7,'2007-02-01 14:59:06',4,'',71);
INSERT INTO `cage_out_histories` (`id`,`bat_id`,`cage_id`,`date`,`user_id`,`note`,`cage_in_history_id`) VALUES 
 (69,5,2,'2007-02-01 15:10:47',4,'',61),
 (70,5,4,'2007-02-02 10:09:26',4,'',74),
 (71,2,2,'2007-02-02 10:13:31',4,'',57),
 (72,3,3,'2007-02-02 10:14:32',4,'',72),
 (73,4,3,'2007-02-02 10:14:32',4,'',73),
 (74,3,2,'2007-02-02 10:56:06',4,'',77),
 (75,4,2,'2007-02-02 10:56:06',4,'',78),
 (76,2,8,'2007-02-02 14:16:40',4,'',76),
 (77,3,3,'2007-02-02 14:17:24',4,'',79),
 (78,3,8,'2007-02-02 14:28:37',4,'',82),
 (79,2,2,'2007-02-02 14:29:12',4,'',81),
 (80,2,5,'2007-02-02 14:37:10',4,'',84),
 (81,2,2,'2007-02-02 15:29:29',4,'',85),
 (82,3,2,'2007-02-02 15:29:29',4,'',83),
 (83,4,3,'2007-02-05 11:30:27',4,'',80),
 (84,4,5,'2007-02-05 16:09:34',4,'',88),
 (85,6,2,'2007-02-05 16:28:26',4,'',52),
 (86,6,6,'2007-02-05 16:34:30',4,'',90),
 (87,2,8,'2007-02-06 16:23:44',4,'',86),
 (88,6,2,'2007-02-06 16:23:51',4,'',91),
 (89,6,3,'2007-02-06 18:27:37',4,'',93),
 (90,4,2,'2007-02-10 00:35:01',4,'',89),
 (91,2,3,'2007-02-10 10:21:27',1,'',92);
INSERT INTO `cage_out_histories` (`id`,`bat_id`,`cage_id`,`date`,`user_id`,`note`,`cage_in_history_id`) VALUES 
 (92,5,2,'2007-02-10 15:00:03',4,'',75),
 (93,2,2,'2007-02-11 12:32:22',1,'',176),
 (94,6,2,'2007-02-11 12:32:22',1,'',94),
 (95,2,3,'2007-02-11 12:40:04',1,'',178),
 (96,4,3,'2007-02-11 12:40:04',1,'',95),
 (97,5,3,'2007-02-11 12:40:04',1,'',177),
 (98,6,3,'2007-02-11 12:40:04',1,'',179),
 (99,2,2,'2007-02-11 12:40:50',1,'',180),
 (100,4,2,'2007-02-11 12:40:50',1,'',181),
 (101,5,2,'2007-02-11 12:40:50',1,'',182),
 (102,6,2,'2007-02-11 12:40:50',1,'',183),
 (103,2,3,'2007-02-11 12:41:55',1,'',184),
 (104,4,3,'2007-02-11 12:41:55',1,'',185),
 (105,5,3,'2007-02-11 12:41:55',1,'',186),
 (106,6,3,'2007-02-11 12:41:55',1,'',187),
 (107,2,2,'2007-02-11 12:44:16',1,'',188),
 (108,4,2,'2007-02-11 12:44:16',1,'',189),
 (109,5,2,'2007-02-11 12:44:16',1,'',190),
 (110,6,2,'2007-02-11 12:44:16',1,'',191),
 (111,2,3,'2007-02-11 13:05:41',1,'',192),
 (112,4,3,'2007-02-11 13:05:41',1,'',193),
 (113,5,3,'2007-02-11 13:05:41',1,'',194);
INSERT INTO `cage_out_histories` (`id`,`bat_id`,`cage_id`,`date`,`user_id`,`note`,`cage_in_history_id`) VALUES 
 (114,6,3,'2007-02-11 13:05:41',1,'',195),
 (115,4,2,'2007-02-13 17:01:18',4,'',197),
 (116,2,2,'2007-02-13 17:04:03',4,'',196),
 (117,5,2,'2007-02-13 17:18:08',4,'',198),
 (118,3,8,'2007-03-12 18:10:58',4,'',87),
 (119,2,3,'2007-03-13 11:27:06',4,'',201);
/*!40000 ALTER TABLE `cage_out_histories` ENABLE KEYS */;


--
-- Definition of table `cages`
--

DROP TABLE IF EXISTS `cages`;
CREATE TABLE `cages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `date_created` datetime NOT NULL,
  `date_destroyed` datetime DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL COMMENT 'investigators user_id, can be nil',
  `room_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `cages`
--

/*!40000 ALTER TABLE `cages` DISABLE KEYS */;
INSERT INTO `cages` (`id`,`name`,`date_created`,`date_destroyed`,`user_id`,`room_id`) VALUES 
 (1,'Cage1','2006-12-15 00:00:00','2006-12-15 00:00:00',1,11),
 (2,'Cage2','2006-12-15 00:00:00',NULL,4,9),
 (3,'Cage3','2006-12-15 00:00:00',NULL,1,10),
 (4,'Cage6','2006-12-15 00:00:00',NULL,4,9),
 (5,'Cage7','2006-12-15 00:00:00',NULL,5,9),
 (6,'Cage9','2006-12-16 00:00:00',NULL,5,9),
 (7,'Cage4','2007-01-10 00:00:00',NULL,5,9),
 (8,'Cage5','2007-01-10 00:00:00',NULL,1,9);
/*!40000 ALTER TABLE `cages` ENABLE KEYS */;


--
-- Definition of table `medical_care_actions`
--

DROP TABLE IF EXISTS `medical_care_actions`;
CREATE TABLE `medical_care_actions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `proposed_treatment_id` int(10) unsigned NOT NULL,
  `date` datetime NOT NULL,
  `remarks` text NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `medical_care_actions`
--

/*!40000 ALTER TABLE `medical_care_actions` DISABLE KEYS */;
INSERT INTO `medical_care_actions` (`id`,`proposed_treatment_id`,`date`,`remarks`,`user_id`) VALUES 
 (1,1,'2006-12-15 21:58:00','Robitussin',1),
 (2,4,'2006-12-15 22:03:00','Gassss',1),
 (3,16,'2007-01-08 14:04:00','Oh man, we missed the last treatments',4),
 (4,27,'2007-01-08 14:16:00','Doesn\'t like the taste.',4),
 (5,28,'2007-01-08 14:40:00','',4);
/*!40000 ALTER TABLE `medical_care_actions` ENABLE KEYS */;


--
-- Definition of table `medical_problems`
--

DROP TABLE IF EXISTS `medical_problems`;
CREATE TABLE `medical_problems` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `bat_id` int(10) unsigned NOT NULL,
  `date_opened` datetime NOT NULL,
  `description` text NOT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `date_closed` datetime DEFAULT NULL,
  `title` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `medical_problems`
--

/*!40000 ALTER TABLE `medical_problems` DISABLE KEYS */;
INSERT INTO `medical_problems` (`id`,`bat_id`,`date_opened`,`description`,`user_id`,`date_closed`,`title`) VALUES 
 (1,2,'2006-12-15 00:00:00','Bat hobbles, drinks too much and complains when mealworms tread on its foot.',2,NULL,'Gout'),
 (2,6,'2006-12-15 00:00:00','Bat refuses to fly with other bats. Mocks investigators and finds flaws with the published literature',2,NULL,'Inflated Ego'),
 (3,4,'2006-12-15 00:00:00','bat sings at a high pitch destroying the glass in other bat\'s cages',2,NULL,'High pitched singing'),
 (4,4,'2006-12-15 00:00:00','Bat heckles other bats, steals food and rushes other bats trying to capture worm',2,NULL,'Over competitiveness'),
 (5,2,'2006-12-18 00:00:00','None',4,'2007-01-02 00:00:00','Another problem'),
 (6,2,'2007-01-02 00:00:00','new test',5,'2007-01-08 00:00:00','new '),
 (7,2,'2007-01-11 00:00:00','Might be depressed.',4,NULL,'Low Self Esteem'),
 (8,2,'2007-02-21 00:00:00','Bat can\'t stay awake.  Could be narcoleptic.',5,NULL,'Very sleepy');
/*!40000 ALTER TABLE `medical_problems` ENABLE KEYS */;


--
-- Definition of table `proposed_treatments`
--

DROP TABLE IF EXISTS `proposed_treatments`;
CREATE TABLE `proposed_treatments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `medical_problem_id` int(10) unsigned NOT NULL,
  `date_started` datetime NOT NULL,
  `date_finished` datetime NOT NULL,
  `date_closed` datetime DEFAULT NULL,
  `treatment` text NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `proposed_treatments`
--

/*!40000 ALTER TABLE `proposed_treatments` DISABLE KEYS */;
INSERT INTO `proposed_treatments` (`id`,`medical_problem_id`,`date_started`,`date_finished`,`date_closed`,`treatment`,`user_id`) VALUES 
 (1,1,'2006-12-15 00:00:00','2006-12-20 00:00:00','2007-01-02 00:00:00','Cough syrup',1),
 (2,2,'2006-12-15 00:00:00','2006-12-15 00:00:00','2007-01-02 00:00:00','AM - No treatment, this is normal for bats',1),
 (3,3,'2006-12-15 00:00:00','2006-12-20 00:00:00','2006-12-19 00:00:00','Helium - AM',1),
 (4,3,'2006-12-15 00:00:00','2007-12-15 00:00:00','2006-12-19 00:00:00','Helium - PM',1),
 (5,3,'2006-12-16 00:00:00','2006-12-16 00:00:00','2006-12-19 00:00:00','Helium PM',1),
 (8,5,'2006-12-22 00:00:00','2006-12-22 00:00:00','2007-01-02 00:00:00','test',2),
 (9,2,'2006-12-22 00:00:00','2006-12-22 00:00:00','2007-01-02 00:00:00','test',2),
 (10,2,'2006-12-22 00:00:00','2006-12-22 00:00:00','2007-01-02 00:00:00','tes1',2),
 (11,1,'2007-01-02 00:00:00','2007-01-02 00:00:00','2007-01-02 00:00:00','Amputation',4),
 (12,5,'2007-01-02 00:00:00','2007-01-02 00:00:00','2007-01-02 00:00:00','This here is a test treatment',4),
 (13,5,'2007-01-02 00:00:00','2007-01-02 00:00:00','2007-01-02 00:00:00','I got a nother test',4);
INSERT INTO `proposed_treatments` (`id`,`medical_problem_id`,`date_started`,`date_finished`,`date_closed`,`treatment`,`user_id`) VALUES 
 (14,5,'2007-01-02 00:00:00','2007-01-02 00:00:00','2007-01-02 00:00:00','I got a nother test',4),
 (15,5,'2007-01-02 00:00:00','2007-01-02 00:00:00','2007-01-02 00:00:00','I got a nother test',4),
 (16,1,'2007-01-02 00:00:00','2007-01-02 00:00:00','2007-01-08 00:00:00','Cough syrup',4),
 (17,1,'2007-01-02 00:00:00','2007-01-02 00:00:00','2007-01-08 00:00:00','Kleenex',4),
 (18,1,'2007-01-02 00:00:00','2007-01-02 00:00:00','2007-01-08 00:00:00','Extra food',4),
 (19,2,'2007-01-02 00:00:00','2007-01-02 00:00:00','2007-01-02 00:00:00','testing',4),
 (20,1,'2007-01-02 00:00:00','2007-01-02 00:00:00','2007-01-08 00:00:00','a new treatment',4),
 (21,6,'2007-01-02 00:00:00','2007-01-02 00:00:00','2007-01-08 00:00:00','test treatment',4),
 (22,6,'2007-01-02 00:00:00','2007-01-02 00:00:00','2007-01-08 00:00:00','second treatment',4),
 (23,6,'2007-01-02 00:00:00','2007-01-02 00:00:00','2007-01-08 00:00:00','third treatment',4),
 (24,2,'2007-01-02 00:00:00','2007-01-02 00:00:00','2007-01-08 00:00:00','testing again',4);
INSERT INTO `proposed_treatments` (`id`,`medical_problem_id`,`date_started`,`date_finished`,`date_closed`,`treatment`,`user_id`) VALUES 
 (25,2,'2007-01-02 00:00:00','2007-01-02 00:00:00','2007-01-08 00:00:00','testing for a nother time',4),
 (26,1,'2007-01-02 00:00:00','2007-01-02 00:00:00','2007-01-08 00:00:00','next treatmetn',4),
 (27,1,'2007-01-08 00:00:00','2007-01-08 00:00:00',NULL,'Cough syrup',4),
 (28,2,'2007-01-08 00:00:00','2007-01-11 00:00:00',NULL,'Verbally abuse the bat',4),
 (29,1,'2007-01-08 00:00:00','2007-01-14 00:00:00','2007-01-08 00:00:00','Amputation',4),
 (30,7,'2007-01-11 00:00:00','2007-01-15 00:00:00',NULL,'Words of encouragement.',4),
 (31,7,'2007-01-16 00:00:00','2007-01-17 00:00:00',NULL,'Feed worms in front of the other bats',4),
 (32,7,'2007-01-16 00:00:00','2007-01-16 00:00:00','2007-01-16 00:00:00','',4);
/*!40000 ALTER TABLE `proposed_treatments` ENABLE KEYS */;


--
-- Definition of table `protocol_end_histories`
--

DROP TABLE IF EXISTS `protocol_end_histories`;
CREATE TABLE `protocol_end_histories` (
  `id` int(10) unsigned NOT NULL DEFAULT '0',
  `bat_id` int(10) unsigned NOT NULL,
  `protocol_id` int(10) unsigned NOT NULL,
  `date` datetime DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `protocol_start_history_id` int(10) unsigned DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `protocol_end_histories`
--

/*!40000 ALTER TABLE `protocol_end_histories` DISABLE KEYS */;
/*!40000 ALTER TABLE `protocol_end_histories` ENABLE KEYS */;


--
-- Definition of table `protocol_start_histories`
--

DROP TABLE IF EXISTS `protocol_start_histories`;
CREATE TABLE `protocol_start_histories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `bat_id` int(10) unsigned NOT NULL,
  `protocol_id` int(10) unsigned NOT NULL,
  `date` datetime DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `protocol_start_histories`
--

/*!40000 ALTER TABLE `protocol_start_histories` DISABLE KEYS */;
/*!40000 ALTER TABLE `protocol_start_histories` ENABLE KEYS */;


--
-- Definition of table `protocols`
--

DROP TABLE IF EXISTS `protocols`;
CREATE TABLE `protocols` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `number` varchar(45) NOT NULL,
  `text` text NOT NULL,
  `start_date` datetime NOT NULL,
  `renewal_A_date` datetime DEFAULT NULL,
  `renewal_B_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `protocols`
--

/*!40000 ALTER TABLE `protocols` DISABLE KEYS */;
/*!40000 ALTER TABLE `protocols` ENABLE KEYS */;


--
-- Definition of table `rooms`
--

DROP TABLE IF EXISTS `rooms`;
CREATE TABLE `rooms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rooms`
--

/*!40000 ALTER TABLE `rooms` DISABLE KEYS */;
INSERT INTO `rooms` (`id`,`name`) VALUES 
 (9,'Fruit Bats (4148L)'),
 (10,'Belfry (4102D)'),
 (11,'Colony Room (4100)');
/*!40000 ALTER TABLE `rooms` ENABLE KEYS */;


--
-- Definition of table `task_histories`
--

DROP TABLE IF EXISTS `task_histories`;
CREATE TABLE `task_histories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `task_id` int(10) unsigned NOT NULL,
  `date_done` datetime NOT NULL,
  `remarks` text NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `fed` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `task_histories`
--

/*!40000 ALTER TABLE `task_histories` DISABLE KEYS */;
INSERT INTO `task_histories` (`id`,`task_id`,`date_done`,`remarks`,`user_id`,`fed`) VALUES 
 (1,432,'2007-02-18 20:46:21','',1,NULL),
 (2,433,'2006-06-18 21:21:00','72 hugs given',4,NULL),
 (3,433,'2006-06-18 21:21:00','14 hugs given',4,NULL),
 (4,433,'2007-02-18 21:26:00','12 hugs given',4,NULL),
 (5,434,'2007-02-20 15:14:00','I said please and thank you',4,NULL),
 (6,413,'2007-02-21 13:52:36','',1,NULL),
 (7,410,'2007-02-22 15:08:04','',4,NULL),
 (8,410,'2007-03-08 15:16:54','',1,NULL),
 (9,411,'2007-03-12 18:15:40','',4,NULL),
 (10,411,'2007-03-12 18:21:50','',4,NULL),
 (11,412,'2007-03-13 11:54:39','',4,NULL),
 (12,449,'2007-03-13 12:01:17','',4,2);
/*!40000 ALTER TABLE `task_histories` ENABLE KEYS */;


--
-- Definition of table `tasks`
--

DROP TABLE IF EXISTS `tasks`;
CREATE TABLE `tasks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `repeat_code` int(10) unsigned NOT NULL COMMENT '0 means daily 1 = sunday etc.',
  `medical_problem_id` int(10) unsigned DEFAULT NULL,
  `cage_id` int(10) unsigned DEFAULT NULL,
  `title` text NOT NULL,
  `notes` text NOT NULL,
  `internal_description` varchar(45) DEFAULT NULL,
  `food` double DEFAULT NULL,
  `dish_type` varchar(45) DEFAULT NULL,
  `dish_num` int(10) unsigned DEFAULT NULL,
  `jitter` int(11) NOT NULL,
  `date_started` datetime NOT NULL,
  `date_ended` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tasks`
--

/*!40000 ALTER TABLE `tasks` DISABLE KEYS */;
INSERT INTO `tasks` (`id`,`repeat_code`,`medical_problem_id`,`cage_id`,`title`,`notes`,`internal_description`,`food`,`dish_type`,`dish_num`,`jitter`,`date_started`,`date_ended`) VALUES 
 (26,0,NULL,NULL,'Check the fruit bats nectar feeders','',NULL,NULL,NULL,NULL,0,'0000-00-00 00:00:00',NULL),
 (28,2,NULL,NULL,'Check the light in the Belfry','',NULL,NULL,NULL,NULL,0,'0000-00-00 00:00:00',NULL),
 (126,4,NULL,4,'Weigh cage Cage6','','weigh',NULL,NULL,NULL,0,'0000-00-00 00:00:00',NULL),
 (136,7,NULL,NULL,'Do dishes','Soak in bleach water at least 10 minutes',NULL,NULL,NULL,NULL,0,'0000-00-00 00:00:00',NULL),
 (145,6,NULL,NULL,'Change pads','',NULL,NULL,NULL,NULL,-1,'0000-00-00 00:00:00',NULL),
 (168,0,NULL,NULL,'Fill out temperature and humidity','',NULL,NULL,NULL,NULL,0,'0000-00-00 00:00:00',NULL),
 (396,2,NULL,2,'Weigh cage Cage2','','weigh',NULL,NULL,NULL,-1,'2007-02-11 13:55:11','2007-03-08 17:15:00'),
 (397,3,NULL,2,'Weigh cage Cage2','','weigh',NULL,NULL,NULL,-1,'2007-02-11 13:55:11','2007-03-08 17:15:00'),
 (398,4,NULL,2,'Weigh cage Cage2','','weigh',NULL,NULL,NULL,-1,'2007-02-11 13:55:12','2007-03-08 17:15:00');
INSERT INTO `tasks` (`id`,`repeat_code`,`medical_problem_id`,`cage_id`,`title`,`notes`,`internal_description`,`food`,`dish_type`,`dish_num`,`jitter`,`date_started`,`date_ended`) VALUES 
 (399,5,NULL,2,'Weigh cage Cage2','','weigh',NULL,NULL,NULL,-1,'2007-02-11 13:55:12','2007-03-08 17:15:00'),
 (400,6,NULL,2,'Weigh cage Cage2','','weigh',NULL,NULL,NULL,-1,'2007-02-11 13:55:12','2007-03-08 17:15:00'),
 (401,7,NULL,2,'Weigh cage Cage2','','weigh',NULL,NULL,NULL,-1,'2007-02-11 13:55:12','2007-03-08 17:15:00'),
 (402,1,NULL,2,'Weigh cage Cage2','','weigh',NULL,NULL,NULL,-1,'2007-02-11 13:55:12','2007-03-08 17:15:00'),
 (410,5,NULL,2,'Feed cage Cage2','','feed',6,'Small',1,0,'2007-02-13 08:12:02',NULL),
 (411,2,NULL,2,'Feed cage Cage2','','feed',7,'Small',1,0,'2007-02-13 08:12:11',NULL),
 (412,3,NULL,2,'Feed cage Cage2','','feed',7,'Small',1,0,'2007-02-13 08:12:11',NULL),
 (413,4,NULL,2,'Feed cage Cage2','','feed',7,'Small',1,0,'2007-02-13 08:12:11','2007-03-12 18:28:42'),
 (414,6,NULL,2,'Feed cage Cage2','','feed',7,'Small',1,0,'2007-02-13 08:12:26',NULL),
 (415,7,NULL,2,'Feed cage Cage2','','feed',7,'Small',1,0,'2007-02-13 08:12:27','2007-03-12 18:28:51');
INSERT INTO `tasks` (`id`,`repeat_code`,`medical_problem_id`,`cage_id`,`title`,`notes`,`internal_description`,`food`,`dish_type`,`dish_num`,`jitter`,`date_started`,`date_ended`) VALUES 
 (416,1,NULL,2,'Feed cage Cage2','','feed',7,'Small',1,0,'2007-02-13 08:12:27',NULL),
 (417,2,NULL,8,'Weigh cage Cage5','','weigh',NULL,NULL,NULL,-1,'2007-02-13 16:57:17','2007-02-13 16:57:23'),
 (418,3,NULL,8,'Weigh cage Cage5','','weigh',NULL,NULL,NULL,-1,'2007-02-13 16:57:17','2007-02-13 16:57:23'),
 (419,4,NULL,8,'Weigh cage Cage5','','weigh',NULL,NULL,NULL,-1,'2007-02-13 16:57:17','2007-02-13 16:57:23'),
 (420,5,NULL,8,'Weigh cage Cage5','','weigh',NULL,NULL,NULL,-1,'2007-02-13 16:57:17','2007-02-13 16:57:23'),
 (421,6,NULL,8,'Weigh cage Cage5','','weigh',NULL,NULL,NULL,-1,'2007-02-13 16:57:17','2007-02-13 16:57:23'),
 (422,7,NULL,8,'Weigh cage Cage5','','weigh',NULL,NULL,NULL,-1,'2007-02-13 16:57:18','2007-02-13 16:57:23'),
 (423,1,NULL,8,'Weigh cage Cage5','','weigh',NULL,NULL,NULL,-1,'2007-02-13 16:57:18','2007-02-13 16:57:23'),
 (424,0,NULL,8,'Weigh cage Cage5','','weigh',NULL,NULL,NULL,-1,'2007-02-13 16:57:25','2007-02-13 16:57:39');
INSERT INTO `tasks` (`id`,`repeat_code`,`medical_problem_id`,`cage_id`,`title`,`notes`,`internal_description`,`food`,`dish_type`,`dish_num`,`jitter`,`date_started`,`date_ended`) VALUES 
 (425,0,NULL,8,'Weigh cage Cage5','','weigh',NULL,NULL,NULL,-1,'2007-02-13 16:59:56',NULL),
 (426,0,NULL,3,'Weigh cage Cage3','','weigh',NULL,NULL,NULL,-1,'2007-02-13 17:13:25','2007-02-13 17:16:33'),
 (427,0,NULL,3,'Weigh cage Cage3','','weigh',NULL,NULL,NULL,-1,'2007-02-13 17:15:51','2007-02-13 17:16:33'),
 (428,2,NULL,3,'Weigh cage Cage3','','weigh',NULL,NULL,NULL,-1,'2007-02-13 17:16:25','2007-02-13 17:16:33'),
 (429,2,NULL,3,'Weigh cage Cage3','','weigh',NULL,NULL,NULL,-1,'2007-02-13 17:16:39',NULL),
 (430,3,NULL,3,'Weigh cage Cage3','','weigh',NULL,NULL,NULL,-1,'2007-02-13 17:16:39',NULL),
 (431,4,NULL,3,'Weigh cage Cage3','','weigh',NULL,NULL,NULL,-1,'2007-02-13 17:16:39',NULL),
 (432,0,1,NULL,'Cough syrup','','medical',NULL,NULL,NULL,0,'2007-02-18 20:28:40',NULL),
 (433,0,1,NULL,'Give lots of hugs','','medical',NULL,NULL,NULL,0,'2007-02-18 21:08:45',NULL),
 (434,0,7,NULL,'Be polite to the bat','','medical',NULL,NULL,NULL,0,'2007-02-20 15:12:40',NULL);
INSERT INTO `tasks` (`id`,`repeat_code`,`medical_problem_id`,`cage_id`,`title`,`notes`,`internal_description`,`food`,`dish_type`,`dish_num`,`jitter`,`date_started`,`date_ended`) VALUES 
 (435,0,8,NULL,'200mg Caffeine!\r\n0.04 cc Amoxicillin','','medical',NULL,NULL,NULL,0,'2007-02-21 14:04:25',NULL),
 (436,5,NULL,8,'Feed cage Cage5','','feed',2,'Medium',1,0,'2007-03-12 18:11:16','2007-03-12 18:11:21'),
 (437,2,NULL,8,'Feed cage Cage5','','feed',2,'Small',1,0,'2007-03-12 18:14:10',NULL),
 (438,3,NULL,2,'Feed cage Cage2','','feed',3,'Small',1,0,'2007-03-12 18:27:06','2007-03-12 18:28:38'),
 (439,1,NULL,2,'Feed cage Cage2','','feed',3,'Small',1,0,'2007-03-12 18:28:24','2007-03-12 18:28:34'),
 (440,2,NULL,2,'Feed cage Cage2','','feed',3,'Small',1,0,'2007-03-12 18:28:24','2007-03-12 18:28:32'),
 (441,3,NULL,2,'Feed cage Cage2','','feed',3,'Small',1,0,'2007-03-12 18:28:24','2007-03-12 18:28:40'),
 (442,4,NULL,2,'Feed cage Cage2','','feed',3,'Small',1,0,'2007-03-12 18:28:24',NULL),
 (443,5,NULL,2,'Feed cage Cage2','','feed',3,'Small',1,0,'2007-03-12 18:28:25','2007-03-12 18:28:46'),
 (444,6,NULL,2,'Feed cage Cage2','','feed',3,'Small',1,0,'2007-03-12 18:28:25','2007-03-12 18:28:49');
INSERT INTO `tasks` (`id`,`repeat_code`,`medical_problem_id`,`cage_id`,`title`,`notes`,`internal_description`,`food`,`dish_type`,`dish_num`,`jitter`,`date_started`,`date_ended`) VALUES 
 (445,7,NULL,2,'Feed cage Cage2','','feed',3,'Small',1,0,'2007-03-12 18:28:25','2007-03-12 18:29:01'),
 (446,7,NULL,2,'Feed cage Cage2','','feed',3,'Small',1,0,'2007-03-12 18:29:06',NULL),
 (447,1,NULL,3,'Feed cage Cage3','','feed',2,'Medium',1,0,'2007-03-13 12:00:52',NULL),
 (448,2,NULL,3,'Feed cage Cage3','','feed',2,'Medium',1,0,'2007-03-13 12:00:52',NULL),
 (449,3,NULL,3,'Feed cage Cage3','','feed',2,'Medium',1,0,'2007-03-13 12:00:52',NULL),
 (450,4,NULL,3,'Feed cage Cage3','','feed',2,'Medium',1,0,'2007-03-13 12:00:52',NULL),
 (451,5,NULL,3,'Feed cage Cage3','','feed',2,'Medium',1,0,'2007-03-13 12:00:52',NULL),
 (452,6,NULL,3,'Feed cage Cage3','','feed',2,'Medium',1,0,'2007-03-13 12:00:52',NULL),
 (453,7,NULL,3,'Feed cage Cage3','','feed',2,'Medium',1,0,'2007-03-13 12:00:52',NULL);
/*!40000 ALTER TABLE `tasks` ENABLE KEYS */;


--
-- Definition of table `tasks_users`
--

DROP TABLE IF EXISTS `tasks_users`;
CREATE TABLE `tasks_users` (
  `user_id` int(10) unsigned NOT NULL,
  `task_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tasks_users`
--

/*!40000 ALTER TABLE `tasks_users` DISABLE KEYS */;
INSERT INTO `tasks_users` (`user_id`,`task_id`) VALUES 
 (1,28),
 (1,72),
 (1,126),
 (1,145),
 (1,168),
 (1,396),
 (1,397),
 (1,398),
 (1,399),
 (1,400),
 (1,401),
 (1,402),
 (1,410),
 (1,411),
 (1,412),
 (1,413),
 (1,414),
 (1,415),
 (1,416),
 (1,417),
 (1,418),
 (1,419),
 (1,420),
 (1,421),
 (1,422),
 (1,423),
 (1,424),
 (1,425),
 (1,427),
 (1,428),
 (1,429),
 (1,430),
 (1,431),
 (2,2),
 (2,24),
 (2,25),
 (2,432),
 (2,433),
 (3,136),
 (3,401),
 (3,402),
 (3,415),
 (3,416),
 (3,422),
 (3,423),
 (3,424),
 (3,425),
 (3,427),
 (4,30),
 (4,127),
 (4,434),
 (4,436),
 (4,437),
 (4,438),
 (4,439),
 (4,440),
 (4,441),
 (4,442),
 (4,443),
 (4,444),
 (4,445),
 (4,446),
 (4,447),
 (4,448),
 (4,449),
 (4,450),
 (4,451),
 (4,452),
 (4,453),
 (5,26),
 (5,426),
 (5,435);
/*!40000 ALTER TABLE `tasks_users` ENABLE KEYS */;


--
-- Definition of table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `initials` varchar(45) NOT NULL,
  `email` varchar(100) NOT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`,`name`,`initials`,`email`,`start_date`,`end_date`) VALUES 
 (1,'General Animal Care','GAC','','2006-12-23 00:00:00',NULL),
 (2,'General Medical Care','GMC','','2006-12-23 00:00:00',NULL),
 (3,'Weekend/Holiday Care','WC','','2006-12-23 00:00:00',NULL),
 (4,'Attila the Hun','AtH','hun@villagepillage.com','2006-12-23 00:00:00',NULL),
 (5,'Conan the Barbarian','CTB','ctb@slash.burn.net','2006-12-23 00:00:00',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;


--
-- Definition of table `weathers`
--

DROP TABLE IF EXISTS `weathers`;
CREATE TABLE `weathers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `log_date` datetime NOT NULL,
  `temperature` float NOT NULL,
  `humidity` float NOT NULL,
  `room` varchar(45) NOT NULL,
  `sig` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `weathers`
--

/*!40000 ALTER TABLE `weathers` DISABLE KEYS */;
/*!40000 ALTER TABLE `weathers` ENABLE KEYS */;


--
-- Definition of table `weights`
--

DROP TABLE IF EXISTS `weights`;
CREATE TABLE `weights` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `bat_id` int(10) unsigned NOT NULL,
  `date` datetime NOT NULL,
  `weight` float NOT NULL,
  `note` text NOT NULL,
  `after_eating` varchar(1) NOT NULL COMMENT 'y/n',
  `user_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `weights`
--

/*!40000 ALTER TABLE `weights` DISABLE KEYS */;
INSERT INTO `weights` (`id`,`bat_id`,`date`,`weight`,`note`,`after_eating`,`user_id`) VALUES 
 (1,2,'2006-12-18 14:48:22',15,'NA','',1),
 (2,4,'2006-12-18 14:48:22',14.2,'none','',1),
 (3,5,'2006-12-18 14:48:22',13,'nada','',1),
 (4,6,'2006-12-18 14:48:22',12,'zilch','',1),
 (5,2,'2006-12-18 14:50:42',16,'','',1),
 (6,4,'2006-12-18 14:50:42',17,'','',1),
 (7,5,'2006-12-18 14:50:42',18,'','',1),
 (8,6,'2006-12-18 14:50:42',19,'','',1),
 (9,5,'2006-12-18 14:51:34',14,'','',1),
 (10,5,'2006-12-18 20:30:16',18,'','',2),
 (11,5,'2006-12-18 20:30:20',90,'','',2),
 (12,5,'2006-12-18 20:30:24',40,'','',2),
 (13,5,'2006-12-18 20:30:28',16,'','',2),
 (14,5,'2006-12-19 08:37:02',14,'','',1),
 (15,5,'2006-12-19 08:37:06',16,'','',1),
 (16,5,'2006-12-19 08:37:10',15.5,'','',1),
 (17,5,'2006-12-19 08:37:16',19.5,'','',1),
 (18,5,'2006-12-19 08:37:20',14.7,'','',1),
 (19,5,'2006-12-19 09:31:41',14,'','',1),
 (20,5,'2006-12-19 09:31:46',15.5,'','',1),
 (21,5,'2006-12-19 09:31:49',14,'','',1),
 (22,5,'2006-12-19 09:31:54',16,'','',1),
 (23,5,'2006-12-19 09:32:00',35,'','',1);
INSERT INTO `weights` (`id`,`bat_id`,`date`,`weight`,`note`,`after_eating`,`user_id`) VALUES 
 (24,5,'2006-12-19 09:32:03',18,'','',1),
 (25,5,'2006-12-19 09:32:06',25,'','',1),
 (26,5,'2006-12-19 09:32:10',20,'','',1),
 (27,5,'2006-12-19 09:32:13',16,'','',1),
 (28,5,'2006-12-19 09:34:14',30,'','',1),
 (29,5,'2006-12-19 09:34:17',25,'','',1),
 (30,5,'2006-12-19 09:34:34',16,'','',1),
 (31,5,'2006-12-19 09:34:45',14,'','',1),
 (32,2,'2006-12-19 09:35:42',4,'','',1),
 (33,2,'2006-12-19 09:35:55',35,'','',1),
 (34,2,'2006-12-19 09:35:58',15,'','',1),
 (35,2,'2006-12-19 09:36:00',14,'','',1),
 (36,2,'2007-01-03 10:55:20',15,'24','',4),
 (37,4,'2007-01-03 11:01:58',14,'NA','',4),
 (38,6,'2007-01-03 11:05:22',14,'','',4),
 (39,6,'2007-01-03 11:05:47',15,'','',4),
 (40,6,'2007-01-03 11:07:42',15,'','',4),
 (41,6,'2007-01-03 11:07:51',16,'','',4),
 (42,6,'2007-01-03 11:08:44',13,'','',4),
 (43,2,'2007-01-03 11:09:30',19,'','',4),
 (44,3,'2007-01-03 11:10:53',14,'','',4),
 (45,3,'2007-01-03 11:17:57',14,'','',4),
 (46,3,'2007-01-03 14:08:42',5,'12','',4);
INSERT INTO `weights` (`id`,`bat_id`,`date`,`weight`,`note`,`after_eating`,`user_id`) VALUES 
 (47,3,'2007-01-03 14:18:51',12,'','',4),
 (48,3,'2007-01-03 14:18:59',13,'','',4),
 (49,4,'2007-01-03 14:19:13',14,'','',4),
 (50,6,'2007-01-03 14:19:19',14,'','',4),
 (51,4,'2007-01-11 14:10:36',15,'','',4),
 (52,4,'2007-01-15 23:45:53',1,'','',4),
 (53,6,'2007-01-15 23:45:57',3,'','',4),
 (54,5,'2007-01-15 23:46:00',2,'','',4),
 (55,2,'2007-01-20 18:20:05',14,'','',4),
 (56,4,'2007-02-05 16:32:50',15,'','',4),
 (57,5,'2007-02-05 16:37:55',15,'','',4),
 (58,6,'2007-02-05 16:38:01',16,'','',4),
 (59,4,'2007-02-06 14:57:17',14,'','y',4),
 (60,2,'2007-02-06 14:57:49',12,'','y',4),
 (61,2,'2007-02-06 14:59:24',16,'','n',4),
 (62,5,'2007-02-06 15:16:01',17,'','n',4),
 (63,5,'2007-02-06 15:16:52',17,'','n',4),
 (64,5,'2007-02-06 15:17:12',18,'','n',4),
 (65,5,'2007-02-06 15:17:40',14,'','n',4),
 (66,3,'2007-02-06 15:19:06',12,'','n',4),
 (67,3,'2007-02-06 15:19:11',13,'','n',4),
 (68,3,'2007-02-06 15:20:00',14,'','n',4),
 (69,3,'2007-02-06 15:20:16',15,'','n',4);
INSERT INTO `weights` (`id`,`bat_id`,`date`,`weight`,`note`,`after_eating`,`user_id`) VALUES 
 (70,3,'2007-02-06 15:21:00',12,'','n',4),
 (71,3,'2007-02-06 15:21:51',14,'','y',4),
 (72,4,'2007-02-06 15:22:37',13,'','y',4),
 (73,4,'2007-02-06 15:22:42',14,'','n',4),
 (74,4,'2007-02-06 15:51:42',14,'','n',4),
 (75,6,'2007-02-08 18:41:46',14,'','n',4),
 (76,3,'2007-02-13 17:01:00',15,'','n',4);
/*!40000 ALTER TABLE `weights` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
