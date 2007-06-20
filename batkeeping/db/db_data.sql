-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.0.32-Debian_7etch1-log


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
  `id` int(10) unsigned NOT NULL auto_increment,
  `bat_id` int(10) unsigned NOT NULL,
  `date` datetime NOT NULL,
  `text` text NOT NULL,
  `user_id` int(10) unsigned NOT NULL COMMENT 'signature',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `bat_notes`
--

/*!40000 ALTER TABLE `bat_notes` DISABLE KEYS */;
INSERT INTO `bat_notes` (`id`,`bat_id`,`date`,`text`,`user_id`) VALUES 
 (1,2,'2007-06-14 00:00:00','Catches tethered mealworms.',5),
 (2,3,'2007-06-14 00:00:00','Catches tethered mealworms.',5),
 (3,6,'2007-06-14 00:00:00','Used by Genni in experiments as a juvenile-- please ask before using.',5),
 (4,11,'2007-06-14 00:00:00','Catches tethered mealworms',5),
 (5,11,'2007-06-14 00:00:00','Genni\'s bat',5),
 (6,16,'2007-06-11 00:00:00','Alberta',1),
 (7,16,'2007-06-19 00:00:00','catches mealworms',1),
 (8,16,'2007-06-19 00:00:00','ben\'s bat - groove discrimination',1),
 (9,17,'2007-06-12 00:00:00','Eugene',1),
 (10,17,'2007-06-19 00:00:00','catches mealworms',1),
 (11,18,'2007-06-14 00:00:00','Genni\'s bat-- used in experiments as a juvenile.',5),
 (12,19,'2007-06-14 00:00:00','\"Gareth\"-- born in captivity along with his twin (now dead).',5),
 (13,19,'2007-06-14 00:00:00','Used by Genni in experiments as a juvenile-- please ask before using.',5),
 (14,19,'2007-06-14 00:00:00','Son of W11',5),
 (15,24,'2007-06-14 00:00:00','Genni\'s bat-- please ask before using.',5);
INSERT INTO `bat_notes` (`id`,`bat_id`,`date`,`text`,`user_id`) VALUES 
 (16,26,'2007-06-14 00:00:00','Genni\'s bat-- please ask before using.',5),
 (17,29,'2007-06-14 00:00:00','Please ask Genni before using.',5),
 (18,32,'2007-06-14 00:00:00','Used by Genni in experiments as a juvenile-- please ask before using.',5),
 (19,35,'2007-06-14 00:00:00','\"Gaia\"-- mother of B77; please ask Genni before using.',5),
 (20,37,'2007-06-14 00:00:00','\"Yoda\"',5),
 (21,44,'2007-06-14 00:00:00','Catches tethered mealworms.',5),
 (22,45,'2007-06-14 00:00:00','Bat can catch tethered mealworms.',5),
 (23,46,'2007-06-14 00:00:00','was a mom with one pup',3),
 (24,47,'2007-06-14 00:00:00','was a mom with two pups',3),
 (25,48,'2007-06-14 00:00:00','was a mom with one pup',3),
 (26,49,'2007-06-14 00:00:00','was a mom with two pups',3),
 (27,50,'2007-06-14 00:00:00','was a mom with one pup',3),
 (28,51,'2007-06-14 00:00:00','was a mom with two pups',3),
 (29,52,'2007-06-14 00:00:00','Catches tethered mealworms; Genni\'s bat.',5),
 (30,53,'2007-06-14 00:00:00','Catches tethered mealworms.',5);
INSERT INTO `bat_notes` (`id`,`bat_id`,`date`,`text`,`user_id`) VALUES 
 (31,53,'2007-06-14 00:00:00','Genni\'s bat.',5),
 (32,54,'2007-06-14 00:00:00','Genni\'s bat; catches tethered mealworms.',5),
 (33,56,'2007-06-14 00:00:00','Genni\'s bat',5),
 (34,58,'2007-06-14 00:00:00','Catches tethered mealworms; Genni\'s bat',5),
 (35,68,'2007-06-19 00:00:00','trained to station #7',5),
 (36,15,'2007-06-20 11:50:51','ben\'s bat',1),
 (37,15,'2007-06-20 11:50:57','catches mealworms',1),
 (39,15,'2007-06-20 11:51:16','groove discrimination',1);
/*!40000 ALTER TABLE `bat_notes` ENABLE KEYS */;


--
-- Definition of table `bats`
--

DROP TABLE IF EXISTS `bats`;
CREATE TABLE `bats` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `cage_id` int(10) unsigned default NULL,
  `collection_date` datetime NOT NULL,
  `collection_age` varchar(45) NOT NULL COMMENT 'juvenile/adult',
  `collection_place` varchar(100) NOT NULL,
  `gender` varchar(1) NOT NULL COMMENT 'm/f',
  `leave_date` datetime default NULL COMMENT 'y/n - in lab or not',
  `leave_reason` text COMMENT 'death/exported',
  `band` varchar(10) default NULL,
  `vaccination_date` date default NULL,
  `species_id` int(10) unsigned default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `bats`
--

/*!40000 ALTER TABLE `bats` DISABLE KEYS */;
INSERT INTO `bats` (`id`,`cage_id`,`collection_date`,`collection_age`,`collection_place`,`gender`,`leave_date`,`leave_reason`,`band`,`vaccination_date`,`species_id`) VALUES 
 (1,1,'2005-08-15 00:00:00','Juvenile','Clinton, MD','M',NULL,NULL,'G58','2005-09-01',2),
 (2,23,'2005-08-15 00:00:00','Juvenile','Clinton, MD','M',NULL,NULL,'G78','2005-09-01',2),
 (3,23,'2005-08-15 00:00:00','Juvenile','Clinton, MD','M',NULL,NULL,'G41','2005-09-01',2),
 (4,6,'2005-07-11 00:00:00','Adult','Oxon Hill','F',NULL,NULL,'G29','2005-08-01',2),
 (5,1,'2006-08-02 00:00:00','Juvenile','Clinton, MD?','F',NULL,NULL,'B89',NULL,2),
 (6,1,'2005-08-15 00:00:00','Juvenile','Clinton, MD','M',NULL,NULL,'B65','2005-09-01',2),
 (7,4,'2006-06-11 00:00:00','Juvenile','? USA','M',NULL,NULL,'B85','2006-08-14',2),
 (8,4,'2006-06-11 00:00:00','Juvenile','? USA','M',NULL,NULL,'W4','2006-08-14',2),
 (9,2,'2006-06-11 00:00:00','Juvenile','? USA','M',NULL,NULL,'W5','2006-08-03',2),
 (10,2,'2005-07-11 00:00:00','Juvenile','Oxon Hill','M',NULL,NULL,'G30','2005-08-01',2),
 (11,23,'2006-07-06 00:00:00','Juvenile','?','M',NULL,NULL,'B47','2006-08-15',2);
INSERT INTO `bats` (`id`,`cage_id`,`collection_date`,`collection_age`,`collection_place`,`gender`,`leave_date`,`leave_reason`,`band`,`vaccination_date`,`species_id`) VALUES 
 (12,4,'2006-07-06 00:00:00','Adult','?','F',NULL,NULL,'B41','2006-08-15',2),
 (13,4,'2006-08-03 00:00:00','Juvenile','?','F',NULL,NULL,'B86','2006-08-14',2),
 (14,4,'2005-08-15 00:00:00','Juvenile','Clinton, MD','F',NULL,NULL,'G53','2005-09-01',2),
 (15,16,'2005-07-25 00:00:00','Adult','Fort Washington','F',NULL,NULL,'G39','2007-08-01',2),
 (16,19,'2007-04-30 00:00:00','Adult','Clinton, MD','F',NULL,NULL,'OR40','2007-06-08',2),
 (17,19,'2007-05-12 00:00:00','Adult','Cindy\'s Home','M',NULL,NULL,'OR41','2007-06-08',2),
 (18,4,'2006-07-06 00:00:00','Juvenile','?','F',NULL,NULL,'B43','2006-08-15',2),
 (19,4,'2007-06-12 00:00:00','Juvenile','Brown University','M',NULL,NULL,'B77','2006-08-15',2),
 (20,4,'2005-08-15 00:00:00','Juvenile','Clinton, MD','M',NULL,NULL,'G66','2005-09-01',2),
 (21,1,'2005-08-15 00:00:00','Juvenile','Clinton, MD','F',NULL,NULL,'G57','2005-09-01',2),
 (22,1,'2006-08-03 00:00:00','Juvenile','?','M',NULL,NULL,'W8','2006-08-14',2);
INSERT INTO `bats` (`id`,`cage_id`,`collection_date`,`collection_age`,`collection_place`,`gender`,`leave_date`,`leave_reason`,`band`,`vaccination_date`,`species_id`) VALUES 
 (23,9,'2005-08-15 00:00:00','Juvenile','Clinton, MD','M',NULL,NULL,'G44','2005-09-01',2),
 (24,9,'2005-08-15 00:00:00','Adult','Clinton, MD','F',NULL,NULL,'G47','2005-09-01',2),
 (25,9,'2007-06-12 00:00:00','Adult','Clinton, MD','F',NULL,NULL,'G54','2005-09-01',2),
 (26,9,'2005-08-15 00:00:00','Juvenile','Clinton, MD','F',NULL,NULL,'G79','2005-09-01',2),
 (27,9,'2005-08-15 00:00:00','Adult','Clinton, MD','F',NULL,NULL,'G81','2005-09-01',2),
 (28,9,'2006-07-06 00:00:00','Adult','?','F',NULL,NULL,'B36','2006-08-15',2),
 (29,9,'2006-07-06 00:00:00','Adult','?','F',NULL,NULL,'B39','2006-08-15',2),
 (30,NULL,'2006-07-06 00:00:00','Adult','?','F','2007-06-16 00:00:00','dead','B50','2006-08-15',2),
 (31,9,'2006-07-06 00:00:00','Adult','?','F',NULL,NULL,'B62','2006-08-15',2),
 (32,9,'2006-07-06 00:00:00','Juvenile','?','F',NULL,NULL,'B66','2006-08-15',2),
 (33,9,'2006-07-06 00:00:00','Juvenile','?','M',NULL,NULL,'B72','2006-08-15',2);
INSERT INTO `bats` (`id`,`cage_id`,`collection_date`,`collection_age`,`collection_place`,`gender`,`leave_date`,`leave_reason`,`band`,`vaccination_date`,`species_id`) VALUES 
 (34,9,'2006-07-06 00:00:00','Juvenile','?','F',NULL,NULL,'B90','2006-08-15',2),
 (35,9,'2006-07-07 00:00:00','Adult','Brown University','F',NULL,NULL,'W11','2006-08-15',2),
 (36,10,'2006-07-06 00:00:00','Adult','?','M',NULL,NULL,'B63','2006-08-15',2),
 (37,11,'2001-01-31 00:00:00','Adult','?','M',NULL,NULL,'OR82',NULL,3),
 (38,5,'2005-07-11 00:00:00','Juvenile','Oxon Hill, MD','M',NULL,NULL,'G37','2005-08-01',2),
 (39,3,'2006-08-03 00:00:00','Juvenile','? USA','F',NULL,NULL,'W6','2006-08-14',2),
 (40,3,'2006-07-06 00:00:00','Adult','? USA','F',NULL,NULL,'B42','2006-08-15',2),
 (41,6,'2005-08-15 00:00:00','Adult','Clinton, MD','F',NULL,NULL,'G62','2005-09-01',2),
 (42,7,'2005-08-15 00:00:00','Juvenile','Clinton, MD','M',NULL,NULL,'G92','2005-09-01',2),
 (43,8,'2006-07-06 00:00:00','Juvenile','? USA','M',NULL,NULL,'B38','2006-08-15',2),
 (44,12,'2005-07-11 00:00:00','Juvenile','Oxon Hill, MD','F',NULL,NULL,'G32','2005-08-01',2);
INSERT INTO `bats` (`id`,`cage_id`,`collection_date`,`collection_age`,`collection_place`,`gender`,`leave_date`,`leave_reason`,`band`,`vaccination_date`,`species_id`) VALUES 
 (45,15,'2005-06-13 00:00:00','Adult','?','M',NULL,NULL,'Y31','2005-08-13',2),
 (46,18,'2007-06-13 00:00:00','Adult','Fort Washington, MD','M',NULL,NULL,'OR42',NULL,2),
 (47,18,'2007-06-13 00:00:00','Adult','Fort Washington, MD','F',NULL,NULL,'OR43',NULL,2),
 (48,18,'2007-06-13 00:00:00','Adult','Fort Washington, MD','F',NULL,NULL,'OR44',NULL,2),
 (49,18,'2007-06-13 00:00:00','Adult','Fort Washington, MD','F',NULL,NULL,'OR46',NULL,2),
 (50,18,'2007-06-13 00:00:00','Adult','Fort Washington, MD','F',NULL,NULL,'OR47',NULL,2),
 (51,18,'2007-06-13 00:00:00','Adult','Fort Washington, MD','F',NULL,NULL,'OR45',NULL,2),
 (52,13,'2005-06-14 00:00:00','Adult','?','F',NULL,NULL,'G34','2005-06-14',2),
 (53,13,'2006-07-14 00:00:00','Adult','Clinton, MD','F',NULL,NULL,'B40','2006-08-14',2),
 (54,23,'2006-07-14 00:00:00','Juvenile','Clinton, MD','M',NULL,NULL,'B60','2006-08-14',2),
 (55,15,'2005-06-14 00:00:00','Adult','?','M',NULL,NULL,'GR61','2005-08-14',2);
INSERT INTO `bats` (`id`,`cage_id`,`collection_date`,`collection_age`,`collection_place`,`gender`,`leave_date`,`leave_reason`,`band`,`vaccination_date`,`species_id`) VALUES 
 (56,14,'2006-07-14 00:00:00','Adult','Clinton, MD','F',NULL,NULL,'B37','2006-08-14',2),
 (57,14,'2005-06-14 00:00:00','Adult','?','M',NULL,NULL,'GR46','2005-08-14',2),
 (58,13,'2005-06-14 00:00:00','Adult','?','F',NULL,NULL,'GR59','2005-08-14',2),
 (59,20,'2006-07-06 00:00:00','Adult','Clinton, MD','F',NULL,NULL,'B46','2006-08-15',2),
 (60,21,'2007-06-15 00:00:00','Juvenile','Clinton, MD','F',NULL,NULL,'W3','2006-08-14',2),
 (61,22,'2007-06-15 00:00:00','Adult','Clinton, MD','F',NULL,NULL,'B64','2006-08-15',2),
 (62,18,'2007-06-14 00:00:00','Juvenile','Fort Washington, MD','F',NULL,NULL,'OR48',NULL,2),
 (63,18,'2007-06-13 00:00:00','Juvenile','Fort Washington, MD','F',NULL,NULL,'OR49',NULL,2),
 (64,18,'2007-06-13 00:00:00','Juvenile','Fort Washington, MD','M',NULL,NULL,'OR50',NULL,2),
 (65,18,'2007-06-13 00:00:00','Juvenile','Fort Washington, MD','M',NULL,NULL,'OR51',NULL,2),
 (66,18,'2007-06-13 00:00:00','Juvenile','Fort Washington, MD','M',NULL,NULL,'OR52',NULL,2);
INSERT INTO `bats` (`id`,`cage_id`,`collection_date`,`collection_age`,`collection_place`,`gender`,`leave_date`,`leave_reason`,`band`,`vaccination_date`,`species_id`) VALUES 
 (67,12,'2006-07-06 00:00:00','Adult','? USA','F',NULL,NULL,'B35','2006-08-15',2),
 (68,24,'2006-10-25 00:00:00','Adult','Biodome','F',NULL,NULL,'Pu98',NULL,4),
 (69,24,'2006-10-25 00:00:00','Adult','Biodome','M',NULL,NULL,'Pu78',NULL,4),
 (70,24,'2006-10-25 00:00:00','Adult','Biodome in Montreal','M',NULL,NULL,'Pu82',NULL,4),
 (71,24,'2006-10-25 00:00:00','Adult','Biodome','M',NULL,NULL,'Pu81',NULL,2),
 (72,24,'2006-10-25 00:00:00','Adult','Biodome','F',NULL,NULL,'Pu93',NULL,4),
 (73,24,'2006-10-25 00:00:00','Adult','Biodome','M',NULL,NULL,'Pu96',NULL,4),
 (74,13,'2005-08-19 00:00:00','Juvenile','?','F',NULL,NULL,'G59','2005-09-19',2);
/*!40000 ALTER TABLE `bats` ENABLE KEYS */;


--
-- Definition of table `cage_in_histories`
--

DROP TABLE IF EXISTS `cage_in_histories`;
CREATE TABLE `cage_in_histories` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `bat_id` int(10) unsigned NOT NULL,
  `cage_id` int(10) unsigned NOT NULL,
  `date` datetime default NULL,
  `user_id` int(10) unsigned default NULL COMMENT 'signature of user who did the change',
  `note` text,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `cage_in_histories`
--

/*!40000 ALTER TABLE `cage_in_histories` DISABLE KEYS */;
INSERT INTO `cage_in_histories` (`id`,`bat_id`,`cage_id`,`date`,`user_id`,`note`) VALUES 
 (1,1,1,'2007-06-11 13:23:45',2,'new bat'),
 (2,2,1,'2007-06-11 13:25:14',2,'new bat'),
 (3,3,1,'2007-06-11 13:32:39',1,'new bat'),
 (4,4,1,'2007-06-11 14:14:10',2,'new bat'),
 (5,5,1,'2007-06-11 14:18:37',2,'new bat'),
 (6,6,1,'2007-06-11 14:27:39',2,'new bat'),
 (7,7,1,'2007-06-11 14:34:47',2,'new bat'),
 (8,8,1,'2007-06-11 14:36:55',2,'new bat'),
 (9,9,2,'2007-06-11 14:41:16',4,'new bat'),
 (10,10,2,'2007-06-11 16:12:10',2,'new bat'),
 (11,11,4,'2007-06-11 16:18:30',2,'new bat'),
 (12,12,4,'2007-06-11 16:19:41',2,'new bat'),
 (13,13,4,'2007-06-11 16:20:48',2,'new bat'),
 (14,14,4,'2007-06-11 16:24:41',2,'new bat'),
 (15,4,3,'2007-06-11 17:28:39',2,'abscess'),
 (16,15,16,'2007-06-11 18:35:15',1,'new bat'),
 (17,16,17,'2007-06-11 18:58:03',1,'new bat'),
 (18,17,17,'2007-06-11 18:59:10',1,'new bat'),
 (19,18,4,'2007-06-12 11:13:01',1,'new bat'),
 (20,19,4,'2007-06-12 11:15:46',1,'new bat'),
 (21,20,4,'2007-06-12 11:19:44',1,'new bat'),
 (22,21,4,'2007-06-12 11:21:39',1,'new bat');
INSERT INTO `cage_in_histories` (`id`,`bat_id`,`cage_id`,`date`,`user_id`,`note`) VALUES 
 (23,22,4,'2007-06-12 11:23:14',1,'new bat'),
 (24,23,9,'2007-06-12 11:40:49',1,'new bat'),
 (25,24,9,'2007-06-12 11:43:16',1,'new bat'),
 (26,25,9,'2007-06-12 11:44:23',1,'new bat'),
 (27,26,9,'2007-06-12 11:45:30',1,'new bat'),
 (28,27,9,'2007-06-12 11:46:47',1,'new bat'),
 (29,28,9,'2007-06-12 11:47:58',1,'new bat'),
 (30,29,9,'2007-06-12 11:48:53',1,'new bat'),
 (31,30,9,'2007-06-12 11:49:49',1,'new bat'),
 (32,31,9,'2007-06-12 11:52:40',1,'new bat'),
 (33,32,9,'2007-06-12 11:53:29',1,'new bat'),
 (34,33,9,'2007-06-12 11:54:06',1,'new bat'),
 (35,34,9,'2007-06-12 11:55:06',1,'new bat'),
 (36,35,9,'2007-06-12 11:56:22',1,'new bat'),
 (37,36,10,'2007-06-12 11:58:42',1,'new bat'),
 (38,37,11,'2007-06-12 12:10:43',1,'new bat'),
 (39,38,5,'2007-06-13 10:14:21',3,'new bat'),
 (40,39,3,'2007-06-13 10:25:56',3,'new bat'),
 (41,40,3,'2007-06-13 10:34:39',3,'new bat'),
 (42,41,6,'2007-06-13 10:47:47',3,'new bat'),
 (43,4,6,'2007-06-13 10:48:22',3,'');
INSERT INTO `cage_in_histories` (`id`,`bat_id`,`cage_id`,`date`,`user_id`,`note`) VALUES 
 (44,42,7,'2007-06-13 10:55:55',3,'new bat'),
 (45,43,8,'2007-06-13 11:04:54',3,'new bat'),
 (46,44,12,'2007-06-13 14:38:11',3,'new bat'),
 (47,45,15,'2007-06-13 16:04:44',5,'new bat'),
 (48,46,18,'2007-06-14 11:29:55',1,'new bat'),
 (49,47,18,'2007-06-14 11:34:43',1,'new bat'),
 (50,48,18,'2007-06-14 11:38:36',1,'new bat'),
 (51,49,18,'2007-06-14 11:41:17',1,'new bat'),
 (52,50,18,'2007-06-14 11:44:43',1,'new bat'),
 (53,51,18,'2007-06-14 11:50:38',1,'new bat'),
 (54,16,19,'2007-06-14 12:44:15',3,'clearing out flight cage for quarantine moms and pups'),
 (55,17,19,'2007-06-14 12:44:15',3,'clearing out flight cage for quarantine moms and pups'),
 (56,52,13,'2007-06-14 14:06:42',5,'new bat'),
 (57,53,13,'2007-06-14 14:08:44',5,'new bat'),
 (58,54,13,'2007-06-14 14:09:46',5,'new bat'),
 (59,55,15,'2007-06-14 17:46:25',5,'new bat'),
 (60,56,14,'2007-06-14 17:47:17',5,'new bat'),
 (61,57,14,'2007-06-14 17:47:43',5,'new bat'),
 (62,58,14,'2007-06-14 17:48:27',5,'new bat');
INSERT INTO `cage_in_histories` (`id`,`bat_id`,`cage_id`,`date`,`user_id`,`note`) VALUES 
 (63,30,6,'2007-06-15 15:27:31',8,'infected eye'),
 (64,59,20,'2007-06-15 15:59:43',8,'new bat'),
 (65,60,21,'2007-06-15 16:02:23',8,'new bat'),
 (66,61,22,'2007-06-15 16:05:54',8,'new bat'),
 (67,62,18,'2007-06-16 16:33:28',5,'new bat'),
 (68,63,18,'2007-06-16 16:35:08',5,'new bat'),
 (69,64,18,'2007-06-16 16:36:53',5,'new bat'),
 (70,65,18,'2007-06-16 16:37:58',5,'new bat'),
 (71,66,18,'2007-06-17 14:09:37',5,'new bat'),
 (72,21,1,'2007-06-18 10:09:06',6,'weight loss'),
 (73,8,4,'2007-06-18 10:40:27',6,''),
 (74,22,1,'2007-06-18 10:47:33',6,''),
 (75,7,4,'2007-06-18 11:04:45',6,''),
 (76,11,23,'2007-06-18 16:33:34',11,''),
 (77,2,23,'2007-06-18 16:33:56',11,''),
 (78,3,23,'2007-06-18 16:33:56',11,''),
 (79,54,23,'2007-06-18 16:34:16',11,''),
 (80,58,13,'2007-06-18 16:34:41',11,''),
 (81,67,12,'2007-06-18 17:37:03',2,'new bat'),
 (82,68,24,'2007-06-19 13:56:45',5,'new bat'),
 (83,69,24,'2007-06-19 13:57:45',5,'new bat'),
 (84,70,24,'2007-06-19 14:00:16',5,'new bat');
INSERT INTO `cage_in_histories` (`id`,`bat_id`,`cage_id`,`date`,`user_id`,`note`) VALUES 
 (85,71,24,'2007-06-19 14:01:15',5,'new bat'),
 (86,72,24,'2007-06-19 14:02:27',5,'new bat'),
 (87,73,24,'2007-06-19 14:03:26',5,'new bat'),
 (88,74,13,'2007-06-19 15:36:37',5,'new bat');
/*!40000 ALTER TABLE `cage_in_histories` ENABLE KEYS */;


--
-- Definition of table `cage_out_histories`
--

DROP TABLE IF EXISTS `cage_out_histories`;
CREATE TABLE `cage_out_histories` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `bat_id` int(10) unsigned NOT NULL,
  `cage_id` int(10) unsigned NOT NULL,
  `date` datetime default NULL,
  `user_id` int(10) unsigned default NULL COMMENT 'sig of user who did the change',
  `note` text character set utf8,
  `cage_in_history_id` int(10) unsigned NOT NULL COMMENT 'each cage_out belongs to a cage in event',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cage_out_histories`
--

/*!40000 ALTER TABLE `cage_out_histories` DISABLE KEYS */;
INSERT INTO `cage_out_histories` (`id`,`bat_id`,`cage_id`,`date`,`user_id`,`note`,`cage_in_history_id`) VALUES 
 (1,4,1,'2007-06-11 17:28:39',2,'abscess',15),
 (2,4,3,'2007-06-13 10:48:22',3,'',43),
 (3,16,17,'2007-06-14 12:44:15',3,'clearing out flight cage for quarantine moms and pups',54),
 (4,17,17,'2007-06-14 12:44:15',3,'clearing out flight cage for quarantine moms and pups',55),
 (5,30,9,'2007-06-15 15:27:31',8,'infected eye',63),
 (6,21,4,'2007-06-18 10:09:06',6,'weight loss',72),
 (7,8,1,'2007-06-18 10:40:27',6,'',73),
 (8,22,4,'2007-06-18 10:47:33',6,'',74),
 (9,7,1,'2007-06-18 11:04:45',6,'',75),
 (10,30,6,'2007-06-18 14:06:38',6,'Dead',63),
 (11,11,4,'2007-06-18 16:33:34',11,'',76),
 (12,2,1,'2007-06-18 16:33:56',11,'',77),
 (13,3,1,'2007-06-18 16:33:56',11,'',78),
 (14,54,13,'2007-06-18 16:34:16',11,'',79),
 (15,58,14,'2007-06-18 16:34:41',11,'',80);
/*!40000 ALTER TABLE `cage_out_histories` ENABLE KEYS */;


--
-- Definition of table `cages`
--

DROP TABLE IF EXISTS `cages`;
CREATE TABLE `cages` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(45) NOT NULL,
  `date_created` datetime NOT NULL,
  `date_destroyed` datetime default NULL,
  `user_id` int(10) unsigned default NULL COMMENT 'investigators user_id, can be nil',
  `room_id` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `cages`
--

/*!40000 ALTER TABLE `cages` DISABLE KEYS */;
INSERT INTO `cages` (`id`,`name`,`date_created`,`date_destroyed`,`user_id`,`room_id`) VALUES 
 (1,'NP','2007-06-11 00:00:00',NULL,4,1),
 (2,'NP2','2007-06-11 00:00:00',NULL,4,1),
 (3,'Med 2','2007-06-11 00:00:00',NULL,4,1),
 (4,'Flight Temp','2007-06-11 00:00:00',NULL,4,1),
 (5,'Med 1','2007-06-11 00:00:00',NULL,4,1),
 (6,'Med 3','2007-06-11 00:00:00',NULL,4,1),
 (7,'Med 4','2007-06-11 00:00:00',NULL,4,1),
 (8,'Med 5','2007-06-11 00:00:00',NULL,4,1),
 (9,'\"Flight\"','2007-06-11 00:00:00',NULL,4,1),
 (10,'Recovery','2007-06-11 00:00:00',NULL,4,1),
 (11,'NPM','2007-06-11 00:00:00',NULL,4,1),
 (12,'Monitor','2007-06-11 00:00:00',NULL,4,1),
 (13,'GS#1','2007-06-11 00:00:00',NULL,5,1),
 (14,'GS#2','2007-06-11 00:00:00',NULL,5,1),
 (15,'GS#3','2007-06-11 00:00:00',NULL,5,1),
 (16,'BF','2007-06-11 00:00:00',NULL,1,1),
 (17,'Flight','2007-06-11 00:00:00',NULL,1,2),
 (18,'Quarantine Moms and Pups','2007-06-14 00:00:00',NULL,5,2),
 (19,'BF 2','2007-06-14 00:00:00',NULL,1,2),
 (20,'MC #1','2007-06-15 00:00:00',NULL,9,1),
 (21,'MC','2007-06-15 00:00:00',NULL,9,1);
INSERT INTO `cages` (`id`,`name`,`date_created`,`date_destroyed`,`user_id`,`room_id`) VALUES 
 (22,'Surgery 2','2007-06-15 00:00:00',NULL,10,1),
 (23,'GSWNLRY','2007-06-18 00:00:00',NULL,5,1),
 (24,'Carollia partition','2007-06-19 00:00:00',NULL,5,3);
/*!40000 ALTER TABLE `cages` ENABLE KEYS */;


--
-- Definition of table `census`
--

DROP TABLE IF EXISTS `census`;
CREATE TABLE `census` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `animals` int(10) unsigned default NULL,
  `date` date NOT NULL,
  `room_id` int(10) unsigned NOT NULL,
  `bats_added` varchar(2000) default NULL,
  `bats_removed` varchar(2000) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `census`
--

/*!40000 ALTER TABLE `census` DISABLE KEYS */;
INSERT INTO `census` (`id`,`animals`,`date`,`room_id`,`bats_added`,`bats_removed`) VALUES 
 (1,15,'2007-06-11',1,'B65 B85 B89 G29 G41 G58 G78 W4 W5G30 B47 B41 B86 G53 G39 ',NULL),
 (2,2,'2007-06-11',2,'OR40 OR41 ',NULL),
 (3,35,'2007-06-12',1,'B43 B77 G66 G57 W8 G44 G47 G54 G79 G81 B36 B39 B50 B62 B66 B72 B90 W11 B63 OR82 ',NULL),
 (4,43,'2007-06-13',1,'G37 W6 B42 G62 G92 B38 G32 Y31 ',NULL),
 (5,8,'2007-06-14',2,'OR42 OR43 OR44 OR45 OR47 OR45 ',NULL),
 (6,50,'2007-06-14',1,'G34 B40 B60 GR61 B37 GR46 GR59 ',NULL),
 (7,53,'2007-06-15',1,'B46 W3 B64 ',NULL),
 (8,12,'2007-06-16',2,'OR48 OR49 OR50 OR51 ',NULL),
 (9,13,'2007-06-17',2,'OR52 ',NULL),
 (10,53,'2007-06-18',1,'B35 ','B50 '),
 (11,6,'2007-06-19',3,'Pu98 Pu78 Pu82 Pu81 Pu93 Pu96 ',NULL),
 (12,54,'2007-06-19',1,'G59 ',NULL);
/*!40000 ALTER TABLE `census` ENABLE KEYS */;


--
-- Definition of table `medical_problems`
--

DROP TABLE IF EXISTS `medical_problems`;
CREATE TABLE `medical_problems` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `bat_id` int(10) unsigned NOT NULL,
  `date_opened` datetime NOT NULL,
  `description` text NOT NULL,
  `date_closed` datetime default NULL,
  `title` varchar(45) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `medical_problems`
--

/*!40000 ALTER TABLE `medical_problems` DISABLE KEYS */;
INSERT INTO `medical_problems` (`id`,`bat_id`,`date_opened`,`description`,`date_closed`,`title`) VALUES 
 (1,4,'2007-06-11 00:00:00','Abscess on left side of face and bat teeth',NULL,'Face abscess'),
 (2,38,'2006-12-19 00:00:00','Bat had a malignant melanoma removed from its back by Dr Hall. Bat is always sweaty. Need to monitor for changes in condition daily.',NULL,'Malignant melanoma'),
 (3,39,'2007-04-30 00:00:00','Abscess on right side of face.',NULL,'Abscess on face'),
 (4,40,'2007-05-15 00:00:00','Infection on and around old surgical site. ','2007-06-15 00:00:00','Abscess on face around edge of surgical site.'),
 (5,41,'2007-05-15 00:00:00','Gums are swollen, abscessed and infected. Bat in observation. If there is need for practice surgery or other, you might want to consider using this bat. If weight starts dropping bat will need to be put down.',NULL,'Severe dental issues'),
 (6,42,'2007-05-16 00:00:00','Severe gum disease. Low weight and problems competing with other bats at feeding time. House alone.',NULL,'Gum disease'),
 (7,43,'2007-06-04 00:00:00','Swollen right knee. Site drained. Mostly blood. Did not refill after initial treatment. ',NULL,'Right leg swollen at knee. Possible fracture.');
INSERT INTO `medical_problems` (`id`,`bat_id`,`date_opened`,`description`,`date_closed`,`title`) VALUES 
 (8,44,'2007-06-13 00:00:00','Right wing is badly torn and bleeding.',NULL,'Wing membrane torn'),
 (9,45,'2007-06-05 00:00:00','Abscess on nose-- drained it and inject Baytril on site; gave Bactrim (0.15 cc) daily for 10 days.  Nose seems fine now; treatment complete.','2007-06-14 00:00:00','Abscess on nose'),
 (10,40,'2007-06-15 00:00:00','treated with Bactrim, no current treatment. Watch abscess, drain if needed',NULL,'Abscess on face around edge of surgical site'),
 (11,30,'2007-06-15 00:00:00','Left eye horribly swollen all around eye. Eye scabbed over completely.','2007-06-16 00:00:00','Swollen/Infected Eye'),
 (12,67,'2007-06-20 00:00:00','Bat sweaty. Please clarify reason for monitoring, treatment?',NULL,'Sweaty (no entry found,??)');
/*!40000 ALTER TABLE `medical_problems` ENABLE KEYS */;


--
-- Definition of table `medical_treatments`
--

DROP TABLE IF EXISTS `medical_treatments`;
CREATE TABLE `medical_treatments` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `title` varchar(45) NOT NULL,
  `medical_problem_id` int(10) unsigned default NULL,
  `date_opened` date NOT NULL,
  `date_closed` date default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `medical_treatments`
--

/*!40000 ALTER TABLE `medical_treatments` DISABLE KEYS */;
INSERT INTO `medical_treatments` (`id`,`title`,`medical_problem_id`,`date_opened`,`date_closed`) VALUES 
 (1,'0.15 cc Bactrim',1,'2007-06-11',NULL),
 (2,'0.15 cc Bactrim',1,'2007-06-11','2007-06-11'),
 (3,'Currently no treatment is necessary. Monitor ',2,'2006-12-19',NULL),
 (4,'0.15cc Bactrim.',3,'2007-04-30',NULL),
 (5,'Monitor status. Make sure infection doesn\'t r',4,'2007-05-15','2007-06-15'),
 (6,'observation',5,'2007-05-15',NULL),
 (7,'Monitor status. If weight drops we\'ll need to',6,'2007-06-13',NULL),
 (8,'Currently under observation',7,'2007-06-13',NULL),
 (9,'Metacam 0.03cc as needed for a maximum of 2 d',8,'2007-06-13','2007-06-15'),
 (10,'Bactrim (orally).  Baytril (injected)',9,'2007-06-05','2007-06-14'),
 (11,'0.15 cc Bactrim',8,'2007-06-15',NULL),
 (12,'topical antibiotics on torn wing',8,'2007-06-15',NULL),
 (13,'No current treatment- monitor head abscess',10,'2007-06-15',NULL),
 (14,'topical antibiotics on eye and all around',11,'2007-06-15','2007-06-18'),
 (15,'topical antibiotics on eye and all around PM',11,'2007-06-15','2007-06-18'),
 (16,'0.15 cc Bactrim',11,'2007-06-15','2007-06-18');
INSERT INTO `medical_treatments` (`id`,`title`,`medical_problem_id`,`date_opened`,`date_closed`) VALUES 
 (17,'0.15 cc Bactrim PM',11,'2007-06-15','2007-06-18');
/*!40000 ALTER TABLE `medical_treatments` ENABLE KEYS */;


--
-- Definition of table `rooms`
--

DROP TABLE IF EXISTS `rooms`;
CREATE TABLE `rooms` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rooms`
--

/*!40000 ALTER TABLE `rooms` DISABLE KEYS */;
INSERT INTO `rooms` (`id`,`name`) VALUES 
 (1,'Belfry (4102F)'),
 (2,'Colony (4100)'),
 (3,'Fruit & Nectar Flight Cage (4148L)');
/*!40000 ALTER TABLE `rooms` ENABLE KEYS */;


--
-- Definition of table `species`
--

DROP TABLE IF EXISTS `species`;
CREATE TABLE `species` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(45) NOT NULL,
  `lower_weight_limit` float default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `species`
--

/*!40000 ALTER TABLE `species` DISABLE KEYS */;
INSERT INTO `species` (`id`,`name`,`lower_weight_limit`) VALUES 
 (2,'Eptesicus fuscus',11),
 (3,'Myotis septentrionalis',5),
 (4,'Carollia perspicillata',15);
/*!40000 ALTER TABLE `species` ENABLE KEYS */;


--
-- Definition of table `task_census`
--

DROP TABLE IF EXISTS `task_census`;
CREATE TABLE `task_census` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `date` date NOT NULL,
  `internal_description` varchar(45) NOT NULL,
  `date_done` date default NULL,
  `room_id` int(10) unsigned NOT NULL,
  `task_id` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `task_census`
--

/*!40000 ALTER TABLE `task_census` DISABLE KEYS */;
INSERT INTO `task_census` (`id`,`date`,`internal_description`,`date_done`,`room_id`,`task_id`) VALUES 
 (1,'2007-06-05','change_water',NULL,1,1),
 (2,'2007-06-06','change_water',NULL,1,1),
 (3,'2007-06-07','change_water',NULL,1,1),
 (4,'2007-06-08','change_water',NULL,1,1),
 (5,'2007-06-09','change_water',NULL,1,1),
 (6,'2007-06-10','change_water',NULL,1,1),
 (7,'2007-06-11','change_water','2007-06-11',1,1),
 (8,'2007-06-12','change_water',NULL,1,1),
 (10,'2007-06-13','weigh',NULL,1,2),
 (11,'2007-06-13','weigh',NULL,1,10),
 (13,'2007-06-13','weigh',NULL,1,40),
 (14,'2007-06-13','weigh',NULL,1,62),
 (15,'2007-06-14','weigh',NULL,1,2),
 (16,'2007-06-14','weigh',NULL,1,10),
 (17,'2007-06-14','weigh',NULL,1,40),
 (18,'2007-06-15','weigh',NULL,1,2),
 (19,'2007-06-15','weigh',NULL,1,10),
 (20,'2007-06-15','weigh',NULL,1,40),
 (21,'2007-06-16','weigh',NULL,1,2),
 (22,'2007-06-16','weigh',NULL,1,10),
 (23,'2007-06-16','weigh',NULL,1,40),
 (24,'2007-06-17','weigh',NULL,1,2),
 (25,'2007-06-17','weigh',NULL,1,10),
 (26,'2007-06-17','weigh',NULL,1,40);
INSERT INTO `task_census` (`id`,`date`,`internal_description`,`date_done`,`room_id`,`task_id`) VALUES 
 (27,'2007-06-18','weigh',NULL,1,2),
 (28,'2007-06-18','weigh',NULL,1,10),
 (29,'2007-06-18','weigh',NULL,1,40),
 (30,'2007-06-19','weigh',NULL,1,2),
 (31,'2007-06-19','weigh',NULL,1,10),
 (32,'2007-06-19','weigh',NULL,1,40),
 (33,'2007-06-20','weigh',NULL,1,2),
 (34,'2007-06-20','weigh',NULL,1,10),
 (35,'2007-06-20','weigh',NULL,1,40);
/*!40000 ALTER TABLE `task_census` ENABLE KEYS */;


--
-- Definition of table `task_histories`
--

DROP TABLE IF EXISTS `task_histories`;
CREATE TABLE `task_histories` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `task_id` int(10) unsigned NOT NULL,
  `date_done` datetime NOT NULL,
  `remarks` text NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `fed` int(10) unsigned default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `task_histories`
--

/*!40000 ALTER TABLE `task_histories` DISABLE KEYS */;
INSERT INTO `task_histories` (`id`,`task_id`,`date_done`,`remarks`,`user_id`,`fed`) VALUES 
 (1,1,'2007-06-11 19:38:16','',1,NULL),
 (2,6,'2007-06-13 10:22:00','Sweaty. Wound drying nicely, scab coming off.',3,NULL),
 (3,14,'2007-06-13 10:28:00','0.15cc Bactrim. Small amount of pus came out of localized area under right eye.',3,NULL),
 (4,22,'2007-06-13 10:39:00','Looks good. Keep eye on surgical site for changes.',3,NULL),
 (5,29,'2007-06-13 10:52:00','no change in condition',3,NULL),
 (6,36,'2007-06-13 10:53:00','0.15cc Bactrim and fed separately. No visible abscess in face. ',3,NULL),
 (7,44,'2007-06-13 10:59:00','fed some extra white worms. No change in condition. Bat eats slowly but happily!',3,NULL),
 (8,51,'2007-06-13 11:07:00','Leg looks good. No treatment required. Keep monitoring. Bat highly agitated, handle extra-gently.',3,NULL),
 (9,58,'2007-06-13 14:40:00','Applied topical antibiotic on right wing. Administered 0.03cc Metacam for pain relief. Called Dr Hall. She\'ll check on bat tonight or tomorrow morning. Apply vetbond??',3,NULL),
 (10,38,'2007-06-15 14:48:00','watch weight after eating',8,NULL);
INSERT INTO `task_histories` (`id`,`task_id`,`date_done`,`remarks`,`user_id`,`fed`) VALUES 
 (11,68,'2007-06-15 14:53:00','blood on bottom pad',8,NULL),
 (12,75,'2007-06-15 14:54:00','',8,NULL),
 (13,75,'2007-06-15 14:54:00','',8,NULL),
 (14,8,'2007-06-15 14:55:00','scab fell off, wound looks healed',8,NULL),
 (15,16,'2007-06-15 14:57:00','',8,NULL),
 (16,31,'2007-06-15 14:58:00','same',8,NULL),
 (17,81,'2007-06-15 15:02:00','',8,NULL),
 (18,53,'2007-06-15 15:02:00','looks better, steady weight',8,NULL),
 (19,46,'2007-06-15 15:07:00','worms left over in cage- tried to feed extra worms but wouldn\'t eat',8,NULL),
 (20,87,'2007-06-15 15:21:00','',8,NULL),
 (21,99,'2007-06-15 15:22:00','',8,NULL),
 (22,93,'2007-06-15 19:20:00','',1,NULL),
 (23,105,'2007-06-15 19:20:00','',1,NULL),
 (24,39,'2007-06-16 12:02:00','',7,NULL),
 (25,17,'2007-06-16 12:06:00','',7,NULL),
 (26,10,'2007-06-15 15:02:00','',7,NULL),
 (27,69,'2007-06-16 12:08:00','',7,NULL),
 (28,76,'2007-06-16 12:09:00','',7,NULL),
 (29,11,'2007-06-17 11:41:00','',7,NULL),
 (30,33,'2007-06-17 11:49:00','',7,NULL);
INSERT INTO `task_histories` (`id`,`task_id`,`date_done`,`remarks`,`user_id`,`fed`) VALUES 
 (31,70,'2007-06-17 11:57:00','',7,NULL),
 (32,65,'2007-06-17 11:57:00','',7,NULL),
 (33,4,'2007-06-18 16:45:00','looks fine',2,NULL),
 (34,2,'2007-06-18 16:45:00','',2,NULL),
 (35,63,'2007-06-18 16:53:00','0.15cc Bactrim, AB',2,NULL),
 (36,77,'2007-06-18 17:04:00','looks ok',2,NULL),
 (37,10,'2007-06-17 11:41:00','',2,NULL),
 (38,12,'2007-06-18 17:09:00','0.15cc Bactrim ',2,NULL),
 (39,10,'2007-06-18 17:04:00','',2,NULL),
 (40,34,'2007-06-18 17:22:00','0.15cc Bactrim',2,NULL),
 (41,27,'2007-06-18 17:23:00','same',2,NULL),
 (42,71,'2007-06-18 17:23:00','',2,NULL),
 (43,42,'2007-06-18 17:24:00','lots of worms left in the cage, tried to hand feed him',2,NULL),
 (44,40,'2007-06-18 17:24:00','',2,NULL),
 (45,49,'2007-06-18 17:31:00','looks real good!',2,NULL),
 (46,5,'2007-06-19 17:06:00','healing, maybe a little less sweaty',1,NULL),
 (47,2,'2007-06-19 17:06:00','',1,NULL),
 (48,13,'2007-06-19 17:10:00','eye a little watery',1,NULL),
 (49,10,'2007-06-18 17:04:00','',1,NULL);
INSERT INTO `task_histories` (`id`,`task_id`,`date_done`,`remarks`,`user_id`,`fed`) VALUES 
 (50,78,'2007-06-19 17:13:00','drained some pus from surgical site',1,NULL),
 (51,10,'2007-06-19 17:10:00','',1,NULL),
 (52,35,'2007-06-19 17:19:00','',1,NULL),
 (53,28,'2007-06-19 17:22:00','',1,NULL),
 (54,43,'2007-06-19 17:23:00','better today',1,NULL),
 (55,40,'2007-06-19 17:23:00','',1,NULL),
 (56,50,'2007-06-19 17:25:00','hard abscess/growth at injury site',1,NULL),
 (57,64,'2007-06-19 17:27:00','Has torn more, now only connected at wing joint',1,NULL),
 (58,72,'2007-06-19 17:29:00','Has torn more, now only connected at wing joint',1,NULL),
 (59,6,'2007-06-20 08:23:00','Area where melanoma was removed looks healed. Bat less sweaty today. Skin on site of lesion looks darker than the rest. Keep eye on it. Keep eye on bald area on chest for possible lesions.',3,NULL),
 (60,2,'2007-06-20 08:23:00','',3,NULL),
 (61,14,'2007-06-20 08:28:00','0.15cc Bactrim. Bat sleepy (probably just due to the early time of day, but keep eye on activity level). No pus.',3,NULL),
 (62,10,'2007-06-19 17:13:00','',3,NULL);
INSERT INTO `task_histories` (`id`,`task_id`,`date_done`,`remarks`,`user_id`,`fed`) VALUES 
 (63,79,'2007-06-20 08:31:00','looks good, maybe a bit too skinny. Keep eye on weight.',3,NULL),
 (64,10,'2007-06-20 08:28:00','',3,NULL),
 (65,29,'2007-06-20 08:33:00','No change in condition.Gums horribly swollen.Looking at the After Eating weight from yesterday, bat obviously eating with appetite. Keep monitoring.',3,NULL),
 (66,36,'2007-06-20 08:35:00','0.15cc Bactrim and brushed teeth with new toothbrush.',3,NULL),
 (67,44,'2007-06-20 08:39:00','Brushed the few teeth bat has. Few worms left in cage. Gave a few white worms in dish.',3,NULL),
 (68,40,'2007-06-20 08:39:00','',3,NULL),
 (69,66,'2007-06-20 08:44:00','Whole section of wing membrane gone. A patch of dry membrane hanging from joint. Considered removing it, but I figured it might fall off on its own. I removed bat\'s band since it seemed to be aggravating the problem. Bat extremely sweaty. 0.15cc Bactrim and 0.03cc Metacam,topical antibiotics. Fed some worms while preparing treatment.',3,NULL),
 (70,73,'2007-06-20 08:54:00','',3,NULL);
INSERT INTO `task_histories` (`id`,`task_id`,`date_done`,`remarks`,`user_id`,`fed`) VALUES 
 (71,51,'2007-06-20 09:01:00','looks good',3,NULL);
/*!40000 ALTER TABLE `task_histories` ENABLE KEYS */;


--
-- Definition of table `tasks`
--

DROP TABLE IF EXISTS `tasks`;
CREATE TABLE `tasks` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `repeat_code` int(10) unsigned NOT NULL COMMENT '0 means daily 1 = sunday etc.',
  `medical_treatment_id` int(10) unsigned default NULL,
  `cage_id` int(10) unsigned default NULL,
  `title` text NOT NULL,
  `notes` text NOT NULL,
  `internal_description` varchar(45) default NULL,
  `food` double default NULL,
  `dish_type` varchar(45) default NULL,
  `dish_num` int(10) unsigned default NULL,
  `jitter` int(11) NOT NULL,
  `date_started` datetime NOT NULL,
  `date_ended` datetime default NULL,
  `animal_care` tinyint(1) default NULL,
  `room_id` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tasks`
--

/*!40000 ALTER TABLE `tasks` DISABLE KEYS */;
INSERT INTO `tasks` (`id`,`repeat_code`,`medical_treatment_id`,`cage_id`,`title`,`notes`,`internal_description`,`food`,`dish_type`,`dish_num`,`jitter`,`date_started`,`date_ended`,`animal_care`,`room_id`) VALUES 
 (1,0,NULL,NULL,'Water','','change_water',NULL,NULL,NULL,0,'2007-06-05 12:39:06','2007-06-13 11:10:19',1,1),
 (2,0,NULL,5,'Weigh cage Med 1','','weigh',NULL,NULL,NULL,-1,'2007-06-13 10:15:40',NULL,0,1),
 (3,1,3,NULL,'Do Currently no treatment is necessary. Monitor ','','medical',NULL,NULL,NULL,0,'2007-06-13 10:17:48','2007-06-19 17:15:22',0,NULL),
 (4,2,3,NULL,'Do Currently no treatment is necessary. Monitor ','','medical',NULL,NULL,NULL,0,'2007-06-13 10:17:48',NULL,1,NULL),
 (5,3,3,NULL,'Do Currently no treatment is necessary. Monitor ','','medical',NULL,NULL,NULL,0,'2007-06-13 10:17:48',NULL,1,NULL),
 (6,4,3,NULL,'Do Currently no treatment is necessary. Monitor ','','medical',NULL,NULL,NULL,0,'2007-06-13 10:17:48',NULL,1,NULL),
 (7,5,3,NULL,'Do Currently no treatment is necessary. Monitor ','','medical',NULL,NULL,NULL,0,'2007-06-13 10:17:48',NULL,1,NULL),
 (8,6,3,NULL,'Do Currently no treatment is necessary. Monitor ','','medical',NULL,NULL,NULL,0,'2007-06-13 10:17:48',NULL,1,NULL);
INSERT INTO `tasks` (`id`,`repeat_code`,`medical_treatment_id`,`cage_id`,`title`,`notes`,`internal_description`,`food`,`dish_type`,`dish_num`,`jitter`,`date_started`,`date_ended`,`animal_care`,`room_id`) VALUES 
 (9,7,3,NULL,'Do Currently no treatment is necessary. Monitor ','','medical',NULL,NULL,NULL,0,'2007-06-13 10:17:48','2007-06-19 17:15:24',0,NULL),
 (10,0,NULL,3,'Weigh cage Med 2','','weigh',NULL,NULL,NULL,-1,'2007-06-13 10:26:39',NULL,0,1),
 (11,1,4,NULL,'Do 0.15cc Bactrim.','','medical',NULL,NULL,NULL,0,'2007-06-13 10:28:51',NULL,0,NULL),
 (12,2,4,NULL,'Do 0.15cc Bactrim.','','medical',NULL,NULL,NULL,0,'2007-06-13 10:28:51',NULL,0,NULL),
 (13,3,4,NULL,'Do 0.15cc Bactrim.','','medical',NULL,NULL,NULL,0,'2007-06-13 10:28:51',NULL,0,NULL),
 (14,4,4,NULL,'Do 0.15cc Bactrim.','','medical',NULL,NULL,NULL,0,'2007-06-13 10:28:51',NULL,0,NULL),
 (15,5,4,NULL,'Do 0.15cc Bactrim.','','medical',NULL,NULL,NULL,0,'2007-06-13 10:28:51',NULL,0,NULL),
 (16,6,4,NULL,'Do 0.15cc Bactrim.','','medical',NULL,NULL,NULL,0,'2007-06-13 10:28:51',NULL,0,NULL),
 (17,7,4,NULL,'Do 0.15cc Bactrim.','','medical',NULL,NULL,NULL,0,'2007-06-13 10:28:51',NULL,0,NULL);
INSERT INTO `tasks` (`id`,`repeat_code`,`medical_treatment_id`,`cage_id`,`title`,`notes`,`internal_description`,`food`,`dish_type`,`dish_num`,`jitter`,`date_started`,`date_ended`,`animal_care`,`room_id`) VALUES 
 (18,0,NULL,3,'Weigh cage Med 2','','weigh',NULL,NULL,NULL,-1,'2007-06-13 10:35:32','2007-06-13 10:35:51',0,1),
 (19,1,5,NULL,'Do Monitor status. Make sure infection doesn\'t r','','medical',NULL,NULL,NULL,0,'2007-06-13 10:39:20','2007-06-15 15:06:59',0,NULL),
 (20,2,5,NULL,'Do Monitor status. Make sure infection doesn\'t r','','medical',NULL,NULL,NULL,0,'2007-06-13 10:39:20','2007-06-15 15:06:59',0,NULL),
 (21,3,5,NULL,'Do Monitor status. Make sure infection doesn\'t r','','medical',NULL,NULL,NULL,0,'2007-06-13 10:39:20','2007-06-15 15:06:59',0,NULL),
 (22,4,5,NULL,'Do Monitor status. Make sure infection doesn\'t r','','medical',NULL,NULL,NULL,0,'2007-06-13 10:39:20','2007-06-15 15:06:59',0,NULL),
 (23,5,5,NULL,'Do Monitor status. Make sure infection doesn\'t r','','medical',NULL,NULL,NULL,0,'2007-06-13 10:39:20','2007-06-15 15:06:59',0,NULL),
 (24,6,5,NULL,'Do Monitor status. Make sure infection doesn\'t r','','medical',NULL,NULL,NULL,0,'2007-06-13 10:39:20','2007-06-15 15:06:59',0,NULL);
INSERT INTO `tasks` (`id`,`repeat_code`,`medical_treatment_id`,`cage_id`,`title`,`notes`,`internal_description`,`food`,`dish_type`,`dish_num`,`jitter`,`date_started`,`date_ended`,`animal_care`,`room_id`) VALUES 
 (25,7,5,NULL,'Do Monitor status. Make sure infection doesn\'t r','','medical',NULL,NULL,NULL,0,'2007-06-13 10:39:20','2007-06-15 15:06:59',0,NULL),
 (26,1,6,NULL,'Do observation','','medical',NULL,NULL,NULL,0,'2007-06-13 10:52:21','2007-06-19 17:16:19',0,NULL),
 (27,2,6,NULL,'Do observation','','medical',NULL,NULL,NULL,0,'2007-06-13 10:52:21',NULL,1,NULL),
 (28,3,6,NULL,'Do observation','','medical',NULL,NULL,NULL,0,'2007-06-13 10:52:21',NULL,1,NULL),
 (29,4,6,NULL,'Do observation','','medical',NULL,NULL,NULL,0,'2007-06-13 10:52:21',NULL,1,NULL),
 (30,5,6,NULL,'Do observation','','medical',NULL,NULL,NULL,0,'2007-06-13 10:52:21',NULL,1,NULL),
 (31,6,6,NULL,'Do observation','','medical',NULL,NULL,NULL,0,'2007-06-13 10:52:22',NULL,1,NULL),
 (32,7,6,NULL,'Do observation','','medical',NULL,NULL,NULL,0,'2007-06-13 10:52:22','2007-06-19 17:16:46',0,NULL),
 (33,1,1,NULL,'Do 0.15 cc Bactrim','','medical',NULL,NULL,NULL,0,'2007-06-13 10:53:20',NULL,0,NULL);
INSERT INTO `tasks` (`id`,`repeat_code`,`medical_treatment_id`,`cage_id`,`title`,`notes`,`internal_description`,`food`,`dish_type`,`dish_num`,`jitter`,`date_started`,`date_ended`,`animal_care`,`room_id`) VALUES 
 (34,2,1,NULL,'Do 0.15 cc Bactrim','','medical',NULL,NULL,NULL,0,'2007-06-13 10:53:20',NULL,0,NULL),
 (35,3,1,NULL,'Do 0.15 cc Bactrim','','medical',NULL,NULL,NULL,0,'2007-06-13 10:53:20',NULL,0,NULL),
 (36,4,1,NULL,'Do 0.15 cc Bactrim','','medical',NULL,NULL,NULL,0,'2007-06-13 10:53:20',NULL,0,NULL),
 (37,5,1,NULL,'Do 0.15 cc Bactrim','','medical',NULL,NULL,NULL,0,'2007-06-13 10:53:21',NULL,0,NULL),
 (38,6,1,NULL,'Do 0.15 cc Bactrim','','medical',NULL,NULL,NULL,0,'2007-06-13 10:53:21',NULL,0,NULL),
 (39,7,1,NULL,'Do 0.15 cc Bactrim','','medical',NULL,NULL,NULL,0,'2007-06-13 10:53:21',NULL,0,NULL),
 (40,0,NULL,7,'Weigh cage Med 4','','weigh',NULL,NULL,NULL,-1,'2007-06-13 10:56:50',NULL,0,1),
 (41,1,7,NULL,'Do Monitor status. If weight drops we\'ll need to','','medical',NULL,NULL,NULL,0,'2007-06-13 10:59:05','2007-06-19 17:17:29',0,NULL),
 (42,2,7,NULL,'Do Monitor status. If weight drops we\'ll need to','','medical',NULL,NULL,NULL,0,'2007-06-13 10:59:05',NULL,1,NULL);
INSERT INTO `tasks` (`id`,`repeat_code`,`medical_treatment_id`,`cage_id`,`title`,`notes`,`internal_description`,`food`,`dish_type`,`dish_num`,`jitter`,`date_started`,`date_ended`,`animal_care`,`room_id`) VALUES 
 (43,3,7,NULL,'Do Monitor status. If weight drops we\'ll need to','','medical',NULL,NULL,NULL,0,'2007-06-13 10:59:05',NULL,1,NULL),
 (44,4,7,NULL,'Do Monitor status. If weight drops we\'ll need to','','medical',NULL,NULL,NULL,0,'2007-06-13 10:59:05',NULL,1,NULL),
 (45,5,7,NULL,'Do Monitor status. If weight drops we\'ll need to','','medical',NULL,NULL,NULL,0,'2007-06-13 10:59:06',NULL,1,NULL),
 (46,6,7,NULL,'Do Monitor status. If weight drops we\'ll need to','','medical',NULL,NULL,NULL,0,'2007-06-13 10:59:06',NULL,1,NULL),
 (47,7,7,NULL,'Do Monitor status. If weight drops we\'ll need to','','medical',NULL,NULL,NULL,0,'2007-06-13 10:59:06','2007-06-19 17:17:34',0,NULL),
 (48,1,8,NULL,'Do Currently under observation','','medical',NULL,NULL,NULL,0,'2007-06-13 11:07:26','2007-06-19 17:14:50',0,NULL),
 (49,2,8,NULL,'Do Currently under observation','','medical',NULL,NULL,NULL,0,'2007-06-13 11:07:26',NULL,1,NULL);
INSERT INTO `tasks` (`id`,`repeat_code`,`medical_treatment_id`,`cage_id`,`title`,`notes`,`internal_description`,`food`,`dish_type`,`dish_num`,`jitter`,`date_started`,`date_ended`,`animal_care`,`room_id`) VALUES 
 (50,3,8,NULL,'Do Currently under observation','','medical',NULL,NULL,NULL,0,'2007-06-13 11:07:26',NULL,1,NULL),
 (51,4,8,NULL,'Do Currently under observation','','medical',NULL,NULL,NULL,0,'2007-06-13 11:07:26',NULL,1,NULL),
 (52,5,8,NULL,'Do Currently under observation','','medical',NULL,NULL,NULL,0,'2007-06-13 11:07:26',NULL,1,NULL),
 (53,6,8,NULL,'Do Currently under observation','','medical',NULL,NULL,NULL,0,'2007-06-13 11:07:27',NULL,1,NULL),
 (54,7,8,NULL,'Do Currently under observation','','medical',NULL,NULL,NULL,0,'2007-06-13 11:07:27','2007-06-19 17:14:53',0,NULL),
 (55,1,9,NULL,'Do Metacam 0.03cc as needed for a maximum of 2 d','','medical',NULL,NULL,NULL,0,'2007-06-13 14:40:18','2007-06-15 14:50:55',0,NULL),
 (56,2,9,NULL,'Do Metacam 0.03cc as needed for a maximum of 2 d','','medical',NULL,NULL,NULL,0,'2007-06-13 14:40:18','2007-06-15 14:50:55',0,NULL),
 (57,3,9,NULL,'Do Metacam 0.03cc as needed for a maximum of 2 d','','medical',NULL,NULL,NULL,0,'2007-06-13 14:40:18','2007-06-15 14:50:55',0,NULL);
INSERT INTO `tasks` (`id`,`repeat_code`,`medical_treatment_id`,`cage_id`,`title`,`notes`,`internal_description`,`food`,`dish_type`,`dish_num`,`jitter`,`date_started`,`date_ended`,`animal_care`,`room_id`) VALUES 
 (58,4,9,NULL,'Do Metacam 0.03cc as needed for a maximum of 2 d','','medical',NULL,NULL,NULL,0,'2007-06-13 14:40:18','2007-06-15 14:50:55',0,NULL),
 (59,5,9,NULL,'Do Metacam 0.03cc as needed for a maximum of 2 d','','medical',NULL,NULL,NULL,0,'2007-06-13 14:40:18','2007-06-15 14:50:55',0,NULL),
 (60,6,9,NULL,'Do Metacam 0.03cc as needed for a maximum of 2 d','','medical',NULL,NULL,NULL,0,'2007-06-13 14:40:18','2007-06-15 14:50:55',0,NULL),
 (61,7,9,NULL,'Do Metacam 0.03cc as needed for a maximum of 2 d','','medical',NULL,NULL,NULL,0,'2007-06-13 14:40:18','2007-06-15 14:50:55',0,NULL),
 (62,3,NULL,15,'Weigh cage GS#3','','weigh',NULL,NULL,NULL,-1,'2007-06-13 16:02:47','2007-06-13 16:03:16',0,1),
 (63,2,11,NULL,'Do 0.15 cc Bactrim','','medical',NULL,NULL,NULL,0,'2007-06-15 14:51:48',NULL,1,NULL),
 (64,3,11,NULL,'Do 0.15 cc Bactrim','','medical',NULL,NULL,NULL,0,'2007-06-15 14:51:52',NULL,1,NULL);
INSERT INTO `tasks` (`id`,`repeat_code`,`medical_treatment_id`,`cage_id`,`title`,`notes`,`internal_description`,`food`,`dish_type`,`dish_num`,`jitter`,`date_started`,`date_ended`,`animal_care`,`room_id`) VALUES 
 (65,1,11,NULL,'Do 0.15 cc Bactrim','','medical',NULL,NULL,NULL,0,'2007-06-15 14:52:04',NULL,1,NULL),
 (66,4,11,NULL,'Do 0.15 cc Bactrim','','medical',NULL,NULL,NULL,0,'2007-06-15 14:52:05',NULL,1,NULL),
 (67,5,11,NULL,'Do 0.15 cc Bactrim','','medical',NULL,NULL,NULL,0,'2007-06-15 14:52:05',NULL,1,NULL),
 (68,6,11,NULL,'Do 0.15 cc Bactrim','','medical',NULL,NULL,NULL,0,'2007-06-15 14:52:05',NULL,1,NULL),
 (69,7,11,NULL,'Do 0.15 cc Bactrim','','medical',NULL,NULL,NULL,0,'2007-06-15 14:52:05',NULL,1,NULL),
 (70,1,12,NULL,'Do topical antibiotics on torn wing','','medical',NULL,NULL,NULL,0,'2007-06-15 14:53:25',NULL,1,NULL),
 (71,2,12,NULL,'Do topical antibiotics on torn wing','','medical',NULL,NULL,NULL,0,'2007-06-15 14:53:25',NULL,1,NULL),
 (72,3,12,NULL,'Do topical antibiotics on torn wing','','medical',NULL,NULL,NULL,0,'2007-06-15 14:53:25',NULL,1,NULL),
 (73,4,12,NULL,'Do topical antibiotics on torn wing','','medical',NULL,NULL,NULL,0,'2007-06-15 14:53:25',NULL,1,NULL);
INSERT INTO `tasks` (`id`,`repeat_code`,`medical_treatment_id`,`cage_id`,`title`,`notes`,`internal_description`,`food`,`dish_type`,`dish_num`,`jitter`,`date_started`,`date_ended`,`animal_care`,`room_id`) VALUES 
 (74,5,12,NULL,'Do topical antibiotics on torn wing','','medical',NULL,NULL,NULL,0,'2007-06-15 14:53:25',NULL,1,NULL),
 (75,6,12,NULL,'Do topical antibiotics on torn wing','','medical',NULL,NULL,NULL,0,'2007-06-15 14:53:25',NULL,1,NULL),
 (76,7,12,NULL,'Do topical antibiotics on torn wing','','medical',NULL,NULL,NULL,0,'2007-06-15 14:53:25',NULL,1,NULL),
 (77,2,13,NULL,'Do No current treatment- monitor head abscess','','medical',NULL,NULL,NULL,0,'2007-06-15 15:02:17',NULL,1,NULL),
 (78,3,13,NULL,'Do No current treatment- monitor head abscess','','medical',NULL,NULL,NULL,0,'2007-06-15 15:02:17',NULL,1,NULL),
 (79,4,13,NULL,'Do No current treatment- monitor head abscess','','medical',NULL,NULL,NULL,0,'2007-06-15 15:02:17',NULL,1,NULL),
 (80,5,13,NULL,'Do No current treatment- monitor head abscess','','medical',NULL,NULL,NULL,0,'2007-06-15 15:02:17',NULL,1,NULL),
 (81,6,13,NULL,'Do No current treatment- monitor head abscess','','medical',NULL,NULL,NULL,0,'2007-06-15 15:02:17',NULL,1,NULL);
INSERT INTO `tasks` (`id`,`repeat_code`,`medical_treatment_id`,`cage_id`,`title`,`notes`,`internal_description`,`food`,`dish_type`,`dish_num`,`jitter`,`date_started`,`date_ended`,`animal_care`,`room_id`) VALUES 
 (82,1,14,NULL,'Do topical antibiotics on eye and all around','','medical',NULL,NULL,NULL,0,'2007-06-15 15:10:04','2007-06-18 19:09:05',1,NULL),
 (83,2,14,NULL,'Do topical antibiotics on eye and all around','','medical',NULL,NULL,NULL,0,'2007-06-15 15:10:04','2007-06-18 19:09:05',1,NULL),
 (84,3,14,NULL,'Do topical antibiotics on eye and all around','','medical',NULL,NULL,NULL,0,'2007-06-15 15:10:04','2007-06-18 19:09:05',1,NULL),
 (85,4,14,NULL,'Do topical antibiotics on eye and all around','','medical',NULL,NULL,NULL,0,'2007-06-15 15:10:04','2007-06-18 19:09:05',1,NULL),
 (86,5,14,NULL,'Do topical antibiotics on eye and all around','','medical',NULL,NULL,NULL,0,'2007-06-15 15:10:04','2007-06-18 19:09:05',1,NULL),
 (87,6,14,NULL,'Do topical antibiotics on eye and all around','','medical',NULL,NULL,NULL,0,'2007-06-15 15:10:04','2007-06-18 19:09:05',1,NULL),
 (88,7,14,NULL,'Do topical antibiotics on eye and all around','','medical',NULL,NULL,NULL,0,'2007-06-15 15:10:04','2007-06-18 19:09:05',1,NULL);
INSERT INTO `tasks` (`id`,`repeat_code`,`medical_treatment_id`,`cage_id`,`title`,`notes`,`internal_description`,`food`,`dish_type`,`dish_num`,`jitter`,`date_started`,`date_ended`,`animal_care`,`room_id`) VALUES 
 (89,2,15,NULL,'Do topical antibiotics on eye and all around PM','','medical',NULL,NULL,NULL,0,'2007-06-15 15:11:14','2007-06-18 19:09:11',1,NULL),
 (90,3,15,NULL,'Do topical antibiotics on eye and all around PM','','medical',NULL,NULL,NULL,0,'2007-06-15 15:11:14','2007-06-18 19:09:11',1,NULL),
 (91,4,15,NULL,'Do topical antibiotics on eye and all around PM','','medical',NULL,NULL,NULL,0,'2007-06-15 15:11:14','2007-06-18 19:09:11',1,NULL),
 (92,5,15,NULL,'Do topical antibiotics on eye and all around PM','','medical',NULL,NULL,NULL,0,'2007-06-15 15:11:14','2007-06-18 19:09:11',1,NULL),
 (93,6,15,NULL,'Do topical antibiotics on eye and all around PM','','medical',NULL,NULL,NULL,0,'2007-06-15 15:11:14','2007-06-18 19:09:11',1,NULL),
 (94,1,16,NULL,'Do 0.15 cc Bactrim','','medical',NULL,NULL,NULL,0,'2007-06-15 15:12:22','2007-06-18 19:09:14',1,NULL),
 (95,2,16,NULL,'Do 0.15 cc Bactrim','','medical',NULL,NULL,NULL,0,'2007-06-15 15:12:22','2007-06-18 19:09:14',1,NULL);
INSERT INTO `tasks` (`id`,`repeat_code`,`medical_treatment_id`,`cage_id`,`title`,`notes`,`internal_description`,`food`,`dish_type`,`dish_num`,`jitter`,`date_started`,`date_ended`,`animal_care`,`room_id`) VALUES 
 (96,3,16,NULL,'Do 0.15 cc Bactrim','','medical',NULL,NULL,NULL,0,'2007-06-15 15:12:22','2007-06-18 19:09:14',1,NULL),
 (97,4,16,NULL,'Do 0.15 cc Bactrim','','medical',NULL,NULL,NULL,0,'2007-06-15 15:12:22','2007-06-18 19:09:14',1,NULL),
 (98,5,16,NULL,'Do 0.15 cc Bactrim','','medical',NULL,NULL,NULL,0,'2007-06-15 15:12:22','2007-06-18 19:09:14',1,NULL),
 (99,6,16,NULL,'Do 0.15 cc Bactrim','','medical',NULL,NULL,NULL,0,'2007-06-15 15:12:22','2007-06-18 19:09:14',1,NULL),
 (100,7,16,NULL,'Do 0.15 cc Bactrim','','medical',NULL,NULL,NULL,0,'2007-06-15 15:12:22','2007-06-18 19:09:14',1,NULL),
 (101,2,17,NULL,'Do 0.15 cc Bactrim PM','','medical',NULL,NULL,NULL,0,'2007-06-15 15:12:51','2007-06-18 19:09:18',1,NULL),
 (102,3,17,NULL,'Do 0.15 cc Bactrim PM','','medical',NULL,NULL,NULL,0,'2007-06-15 15:12:51','2007-06-18 19:09:18',1,NULL),
 (103,4,17,NULL,'Do 0.15 cc Bactrim PM','','medical',NULL,NULL,NULL,0,'2007-06-15 15:12:51','2007-06-18 19:09:18',1,NULL);
INSERT INTO `tasks` (`id`,`repeat_code`,`medical_treatment_id`,`cage_id`,`title`,`notes`,`internal_description`,`food`,`dish_type`,`dish_num`,`jitter`,`date_started`,`date_ended`,`animal_care`,`room_id`) VALUES 
 (104,5,17,NULL,'Do 0.15 cc Bactrim PM','','medical',NULL,NULL,NULL,0,'2007-06-15 15:12:51','2007-06-18 19:09:18',1,NULL),
 (105,6,17,NULL,'Do 0.15 cc Bactrim PM','','medical',NULL,NULL,NULL,0,'2007-06-15 15:12:51','2007-06-18 19:09:18',1,NULL);
/*!40000 ALTER TABLE `tasks` ENABLE KEYS */;


--
-- Definition of table `tasks_users`
--

DROP TABLE IF EXISTS `tasks_users`;
CREATE TABLE `tasks_users` (
  `user_id` int(10) unsigned NOT NULL,
  `task_id` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`user_id`,`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tasks_users`
--

/*!40000 ALTER TABLE `tasks_users` DISABLE KEYS */;
INSERT INTO `tasks_users` (`user_id`,`task_id`) VALUES 
 (1,2),
 (1,3),
 (1,9),
 (1,10),
 (1,11),
 (1,12),
 (1,13),
 (1,14),
 (1,15),
 (1,16),
 (1,17),
 (1,18),
 (1,19),
 (1,20),
 (1,21),
 (1,22),
 (1,23),
 (1,24),
 (1,25),
 (1,26),
 (1,32),
 (1,33),
 (1,34),
 (1,35),
 (1,36),
 (1,37),
 (1,38),
 (1,39),
 (1,40),
 (1,41),
 (1,47),
 (1,48),
 (1,54),
 (1,55),
 (1,56),
 (1,57),
 (1,58),
 (1,59),
 (1,60),
 (1,61),
 (2,2),
 (2,3),
 (2,9),
 (2,10),
 (2,11),
 (2,12),
 (2,13),
 (2,14),
 (2,15),
 (2,16),
 (2,17),
 (2,18),
 (2,19),
 (2,20),
 (2,21),
 (2,22),
 (2,23),
 (2,24),
 (2,25),
 (2,26),
 (2,32),
 (2,33),
 (2,34),
 (2,35),
 (2,36),
 (2,37),
 (2,38),
 (2,39),
 (2,40),
 (2,41),
 (2,47),
 (2,48),
 (2,54),
 (2,55),
 (2,56),
 (2,57),
 (2,58),
 (2,59),
 (2,60),
 (2,61),
 (3,2),
 (3,3),
 (3,9),
 (3,10),
 (3,11),
 (3,12),
 (3,13),
 (3,14),
 (3,15),
 (3,16),
 (3,17),
 (3,18),
 (3,19),
 (3,20),
 (3,21),
 (3,22),
 (3,23),
 (3,24),
 (3,25),
 (3,26),
 (3,32),
 (3,33),
 (3,34),
 (3,35),
 (3,36),
 (3,37),
 (3,38);
INSERT INTO `tasks_users` (`user_id`,`task_id`) VALUES 
 (3,39),
 (3,40),
 (3,41),
 (3,47),
 (3,48),
 (3,54),
 (3,55),
 (3,56),
 (3,57),
 (3,58),
 (3,59),
 (3,60),
 (3,61),
 (5,62);
/*!40000 ALTER TABLE `tasks_users` ENABLE KEYS */;


--
-- Definition of table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(100) NOT NULL,
  `initials` varchar(45) NOT NULL,
  `email` varchar(100) default NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime default NULL,
  `job_type` varchar(45) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`,`name`,`initials`,`email`,`start_date`,`end_date`,`job_type`) VALUES 
 (1,'Ben Falk','BF','falk.ben@gmail.com','2007-06-05 00:00:00',NULL,'Medical Care Administrator'),
 (2,'Jenny Finder','JF','jfinder@umd.edu','2007-06-11 00:00:00',NULL,'Medical Care'),
 (3,'Amaya Perez','AP','amaya.eneko@gmail.com','2007-06-11 00:00:00',NULL,'Medical Care Administrator'),
 (4,'Vanessa Reed','VR','nessareed@mindspring.com','2007-06-11 00:00:00',NULL,' Animal Care'),
 (5,'Genni Spanjer Wright','GSW','gspanjer@umd.edu','2007-06-11 00:00:00',NULL,''),
 (6,'Wei Xian','WX','wxian@psyc.umd.edu','2007-06-14 00:00:00',NULL,'Medical Care'),
 (7,'Krystal Medley','KM','klmedley@hotmail.com','2007-06-14 00:00:00',NULL,'Medical Care Weekend Care'),
 (8,'Sam McIlwain','SM','smcilwai@umd.edu','2007-06-15 00:00:00',NULL,'Medical Care'),
 (9,'Mohit Chadha','MC','mchadha@gmail.com','2007-06-15 00:00:00',NULL,''),
 (10,'Gordon Gifford','GG','ggifford@umd.edu','2007-06-15 00:00:00',NULL,''),
 (11,'Raymond Yu','RY','ray.yu@rice.edu','2007-06-18 00:00:00',NULL,''),
 (12,'Brislin','BMT','Brislin@umd.edu','2007-06-19 00:00:00',NULL,'');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;


--
-- Definition of table `weathers`
--

DROP TABLE IF EXISTS `weathers`;
CREATE TABLE `weathers` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `log_date` date NOT NULL,
  `temperature` float NOT NULL,
  `humidity` float NOT NULL,
  `room_id` int(10) unsigned NOT NULL,
  `sig` varchar(45) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `weathers`
--

/*!40000 ALTER TABLE `weathers` DISABLE KEYS */;
INSERT INTO `weathers` (`id`,`log_date`,`temperature`,`humidity`,`room_id`,`sig`) VALUES 
 (2,'2007-06-08',79,32,1,'BF'),
 (3,'2007-06-08',76,63,2,'BF'),
 (4,'2007-06-11',79,27,1,'BF'),
 (5,'2007-06-11',76,54,2,'BF'),
 (6,'2007-06-13',77,31,1,'BF'),
 (7,'2007-06-13',75,61,2,'BF'),
 (8,'2007-06-15',77,49,2,'BF'),
 (9,'2007-06-16',79,26,1,'KM'),
 (10,'2007-06-16',77,50,2,'KM'),
 (11,'2007-06-17',77,30,1,'KM'),
 (12,'2007-06-17',75.8,57,2,'KM'),
 (13,'2007-06-18',77,23,1,'VR');
/*!40000 ALTER TABLE `weathers` ENABLE KEYS */;


--
-- Definition of table `weights`
--

DROP TABLE IF EXISTS `weights`;
CREATE TABLE `weights` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `bat_id` int(10) unsigned NOT NULL,
  `date` datetime NOT NULL,
  `weight` float NOT NULL,
  `note` text NOT NULL,
  `after_eating` varchar(1) NOT NULL COMMENT 'y/n',
  `user_id` int(10) unsigned NOT NULL,
  `task_history_id` int(10) unsigned default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `weights`
--

/*!40000 ALTER TABLE `weights` DISABLE KEYS */;
INSERT INTO `weights` (`id`,`bat_id`,`date`,`weight`,`note`,`after_eating`,`user_id`,`task_history_id`) VALUES 
 (1,1,'2007-06-11 15:42:45',14.5,'','n',2,NULL),
 (2,2,'2007-06-11 15:47:50',16.1,'','n',2,NULL),
 (3,5,'2007-06-11 15:48:56',17.3,'small thing on face - some pus','n',2,NULL),
 (4,6,'2007-06-11 15:50:28',16.9,'','n',2,NULL),
 (5,8,'2007-06-11 15:53:11',20,'','n',2,NULL),
 (6,7,'2007-06-11 15:57:08',19.3,'','n',2,NULL),
 (7,4,'2007-06-11 16:05:48',14.1,'gums bad, abscess on face','n',2,NULL),
 (8,3,'2007-06-11 16:05:59',14.4,'','n',2,NULL),
 (9,10,'2007-06-11 16:12:44',14.5,'mites','y',2,NULL),
 (10,9,'2007-06-11 16:14:07',15.7,'teeth look bad','y',2,NULL),
 (11,11,'2007-06-11 16:19:31',22.4,'','y',2,NULL),
 (12,12,'2007-06-11 16:19:59',22.9,'','y',2,NULL),
 (13,13,'2007-06-11 16:21:25',18.2,'','y',2,NULL),
 (14,14,'2007-06-11 16:28:33',18.2,'','y',2,NULL),
 (15,15,'2007-06-11 18:35:44',15.2,'','n',1,NULL),
 (16,16,'2007-06-11 19:04:59',14.4,'','n',1,NULL),
 (17,17,'2007-06-11 19:05:11',12.7,'','n',1,NULL),
 (18,18,'2007-06-12 11:13:28',20.4,'','y',1,NULL);
INSERT INTO `weights` (`id`,`bat_id`,`date`,`weight`,`note`,`after_eating`,`user_id`,`task_history_id`) VALUES 
 (19,19,'2007-06-12 11:16:03',19.4,'','y',1,NULL),
 (20,20,'2007-06-12 11:20:00',24.3,'','y',1,NULL),
 (21,21,'2007-06-12 11:21:52',19.9,'','n',1,NULL),
 (22,22,'2007-06-12 11:23:46',17.4,'','y',1,NULL),
 (23,23,'2007-06-12 17:17:22',21.6,'','y',1,NULL),
 (24,35,'2007-06-12 17:19:49',26.6,'','y',1,NULL),
 (25,34,'2007-06-12 17:21:05',20,'','y',1,NULL),
 (26,24,'2007-06-12 17:21:58',24.9,'','y',1,NULL),
 (27,30,'2007-06-12 17:22:29',17.6,'','y',1,NULL),
 (28,26,'2007-06-12 17:25:51',20.8,'','y',1,NULL),
 (29,32,'2007-06-12 17:27:57',19.6,'','y',1,NULL),
 (30,28,'2007-06-12 17:29:28',22.3,'','y',1,NULL),
 (31,27,'2007-06-12 17:30:46',21.6,'','y',1,NULL),
 (32,29,'2007-06-12 17:31:21',19.1,'','y',1,NULL),
 (33,25,'2007-06-12 17:33:01',20.8,'','y',1,NULL),
 (34,31,'2007-06-12 17:33:59',18,'','y',1,NULL),
 (35,33,'2007-06-12 17:37:18',21.8,'','y',1,NULL),
 (36,37,'2007-06-12 17:44:11',6.7,'','y',1,NULL),
 (37,36,'2007-06-12 17:45:48',15.7,'','y',1,NULL);
INSERT INTO `weights` (`id`,`bat_id`,`date`,`weight`,`note`,`after_eating`,`user_id`,`task_history_id`) VALUES 
 (38,16,'2007-06-12 19:05:20',14.3,'','n',1,NULL),
 (39,38,'2007-06-13 10:22:00',20.1,'','n',3,2),
 (40,39,'2007-06-13 10:28:00',21.4,'','n',3,3),
 (41,28,'2007-06-13 10:39:00',17.3,'','n',3,4),
 (42,40,'2007-06-13 10:40:15',17.3,'','n',3,NULL),
 (43,41,'2007-06-13 10:52:00',16.3,'','n',3,5),
 (44,4,'2007-06-13 10:53:00',12.9,'','n',3,6),
 (45,42,'2007-06-13 10:59:00',12.4,'','n',3,7),
 (46,28,'2007-06-13 11:07:00',14.1,'','n',3,8),
 (47,44,'2007-06-13 14:40:00',17,'','n',3,9),
 (48,45,'2007-06-13 16:33:19',15.7,'','y',1,NULL),
 (49,16,'2007-06-13 19:01:36',14.4,'','n',1,NULL),
 (50,16,'2007-06-13 19:30:08',14.4,'brushed teeth','n',1,NULL),
 (51,15,'2007-06-13 19:33:06',14.6,'','n',1,NULL),
 (52,46,'2007-06-14 11:30:15',19,'Mom plus pup','n',1,NULL),
 (53,47,'2007-06-14 11:35:32',25.1,'Mom plus 2 pups','n',1,NULL),
 (54,48,'2007-06-14 11:39:56',18.6,'Mom with one pup','n',1,NULL),
 (55,49,'2007-06-14 11:42:59',23.2,'mom with two pups','n',1,NULL);
INSERT INTO `weights` (`id`,`bat_id`,`date`,`weight`,`note`,`after_eating`,`user_id`,`task_history_id`) VALUES 
 (56,50,'2007-06-14 11:47:51',17.6,'mom with one pup','n',1,NULL),
 (57,51,'2007-06-14 11:53:26',26,'mom with two pups','n',1,NULL),
 (58,52,'2007-06-14 14:07:16',15.1,'','n',5,NULL),
 (59,53,'2007-06-14 14:09:03',15.5,'','n',5,NULL),
 (60,54,'2007-06-14 14:10:06',21.4,'','n',5,NULL),
 (61,15,'2007-06-14 15:50:42',14.7,'','n',1,NULL),
 (62,49,'2007-06-15 13:08:29',24.5,'mom with 2 pups, one of her right toes is swollen','n',8,NULL),
 (63,46,'2007-06-15 13:09:58',18,'mom and one pup fed in a dish','n',8,NULL),
 (64,47,'2007-06-15 13:11:36',24.6,'with twins both boys','n',8,NULL),
 (65,50,'2007-06-15 13:15:24',13.4,'mom without pup','n',8,NULL),
 (66,48,'2007-06-15 13:16:42',21.4,'mom and one pup','n',8,NULL),
 (67,51,'2007-06-15 13:18:52',18.5,'mom without pup','n',8,NULL),
 (68,23,'2007-06-15 14:36:49',20.4,'','n',8,NULL),
 (69,24,'2007-06-15 14:37:27',24.5,'','n',8,NULL),
 (70,25,'2007-06-15 14:37:42',20.3,'','n',8,NULL),
 (71,26,'2007-06-15 14:37:59',19.3,'','n',8,NULL);
INSERT INTO `weights` (`id`,`bat_id`,`date`,`weight`,`note`,`after_eating`,`user_id`,`task_history_id`) VALUES 
 (72,27,'2007-06-15 14:38:20',20.8,'','n',8,NULL),
 (73,28,'2007-06-15 14:38:30',21.8,'','n',8,NULL),
 (74,29,'2007-06-15 14:39:14',18.6,'black hard puss drained from muzzle','n',8,NULL),
 (75,30,'2007-06-15 14:41:33',15.8,'horrible left eye infection- moved out of cage','n',8,NULL),
 (76,31,'2007-06-15 14:41:43',17.2,'','n',8,NULL),
 (77,32,'2007-06-15 14:41:55',19.1,'','n',8,NULL),
 (78,33,'2007-06-15 14:42:04',21.8,'','n',8,NULL),
 (79,34,'2007-06-15 14:42:15',19.1,'','n',8,NULL),
 (80,35,'2007-06-15 14:42:45',25.6,'weight actually decreasing- good','n',8,NULL),
 (81,37,'2007-06-15 14:43:44',5.8,'really dry skin','n',8,NULL),
 (82,36,'2007-06-15 14:44:15',15.3,'','n',8,NULL),
 (83,10,'2007-06-15 14:45:20',11.8,'low weight- fed extra, watch weight','n',8,NULL),
 (84,9,'2007-06-15 14:45:40',13.6,'','n',8,NULL),
 (85,4,'2007-06-15 14:48:00',12.7,'','n',8,10),
 (86,44,'2007-06-15 14:53:00',16.7,'','n',8,11),
 (87,44,'2007-06-15 14:54:00',16.7,'','n',8,13);
INSERT INTO `weights` (`id`,`bat_id`,`date`,`weight`,`note`,`after_eating`,`user_id`,`task_history_id`) VALUES 
 (88,52,'2007-06-15 14:55:17',14.5,'','n',5,NULL),
 (89,38,'2007-06-15 14:55:00',20.5,'','n',8,14),
 (90,53,'2007-06-15 14:57:09',15.1,'re-training to catch mealworms','n',5,NULL),
 (91,54,'2007-06-15 14:57:56',20.9,'','n',5,NULL),
 (92,39,'2007-06-15 14:57:00',20.8,'','n',8,15),
 (93,41,'2007-06-15 14:58:00',16.1,'','n',8,16),
 (94,40,'2007-06-15 15:02:00',16.5,'','n',8,17),
 (95,43,'2007-06-15 15:02:00',14.3,'','n',8,18),
 (96,42,'2007-06-15 15:07:00',12.7,'','n',8,19),
 (97,30,'2007-06-15 15:21:00',15.8,'','n',8,20),
 (98,30,'2007-06-15 19:20:00',15.8,'','n',1,23),
 (99,15,'2007-06-15 16:28:37',14.3,'','n',8,NULL),
 (100,17,'2007-06-15 17:01:51',12.5,'','n',1,NULL),
 (101,16,'2007-06-15 17:02:00',14,'','n',1,NULL),
 (102,4,'2007-06-16 12:02:00',13.9,'','y',7,24),
 (103,39,'2007-06-16 12:06:00',21.6,'','y',7,25),
 (104,44,'2007-06-16 12:09:00',18.3,'','n',7,28),
 (105,47,'2007-06-16 15:29:40',24.7,'mom + twin pups','y',5,NULL),
 (106,48,'2007-06-16 15:42:10',14.5,'mom alone','y',5,NULL);
INSERT INTO `weights` (`id`,`bat_id`,`date`,`weight`,`note`,`after_eating`,`user_id`,`task_history_id`) VALUES 
 (107,50,'2007-06-16 15:44:01',16.5,'mom alone; fed extra','y',5,NULL),
 (108,46,'2007-06-16 15:46:57',20.6,'mom + pup; pup is male','y',5,NULL),
 (109,49,'2007-06-16 15:49:20',25,'mom + twins; 1 pup is female & 1 is male','y',5,NULL),
 (110,51,'2007-06-16 15:51:04',18.6,'mom alone','y',5,NULL),
 (111,62,'2007-06-16 16:33:28',4.3,'small pup not attached to a mother; did not take formula','n',5,NULL),
 (112,63,'2007-06-16 16:35:08',4.7,'OR45\'s pup?; small pup not attached to a mom at 1st; later attached to OR45','n',5,NULL),
 (113,64,'2007-06-16 16:36:53',3.4,'tiny pup not attached to mom; took some formula; eyes closed; R FA = 20.5mm; R gap = 7.9 mm?','n',5,NULL),
 (114,65,'2007-06-16 16:37:58',4.9,'pup not attached to a mom; took some formula; R FA = 24.6 mm; R gap = 3.7 mm','n',5,NULL),
 (115,39,'2007-06-17 11:41:00',20.8,'','n',7,29),
 (116,4,'2007-06-17 11:49:00',12.9,'','n',7,30),
 (117,44,'2007-06-17 11:57:00',16.6,'','n',7,32);
INSERT INTO `weights` (`id`,`bat_id`,`date`,`weight`,`note`,`after_eating`,`user_id`,`task_history_id`) VALUES 
 (118,66,'2007-06-17 14:13:29',3.1,'pup attached to mom up until June 17; took a little formula; R FA = 20 mm; R total gap (TG) = 7.9 mm','n',5,NULL),
 (119,64,'2007-06-17 14:10:06',3.1,'still not attached to a mom; took some formula; very tiny','n',5,NULL),
 (120,62,'2007-06-17 14:10:31',4.1,'still not attached to a mom; would not take formula','n',5,NULL),
 (121,65,'2007-06-17 14:11:57',5,'not attached to a mom, but weight up a little; took a little formula; R FA = 24.5mm; R total (not just top part, as measured yesterday) gap = 7.7 mm','n',5,NULL),
 (122,63,'2007-06-17 14:12:56',4.9,'not attached to a mom, but weight up a little; took a tiny bit of formula; R FA = 24.8mm; R total gap = 7.15 mm','n',5,NULL),
 (123,11,'2007-06-18 10:18:43',21.2,'','n',6,NULL),
 (124,13,'2007-06-18 10:28:31',17.3,'','n',6,NULL),
 (125,12,'2007-06-18 10:31:23',21.2,'b. t.','n',6,NULL),
 (126,18,'2007-06-18 10:34:21',19.4,'bt','n',6,NULL),
 (127,14,'2007-06-18 10:37:18',17.1,'bt','n',6,NULL);
INSERT INTO `weights` (`id`,`bat_id`,`date`,`weight`,`note`,`after_eating`,`user_id`,`task_history_id`) VALUES 
 (128,20,'2007-06-18 10:43:39',22.7,'bt','n',6,NULL),
 (129,22,'2007-06-18 10:45:51',16.1,'bt','n',6,NULL),
 (130,1,'2007-06-18 11:00:32',13.4,'bt','n',6,NULL),
 (131,6,'2007-06-18 11:08:34',16.3,'bt','n',6,NULL),
 (132,5,'2007-06-18 11:13:02',16.7,'bt, black stuff from face','n',6,NULL),
 (133,2,'2007-06-18 11:15:24',16.9,'bt','n',6,NULL),
 (134,3,'2007-06-18 11:16:47',14.3,'bt','n',6,NULL),
 (135,10,'2007-06-18 11:24:57',12.1,'','n',6,NULL),
 (136,9,'2007-06-18 11:26:23',13.6,'','n',6,NULL),
 (138,66,'2007-06-18 12:00:04',3,'still not attached, but in pouch with moms & pups; took some formula','n',5,NULL),
 (139,21,'2007-06-18 14:10:40',16.3,'bt','n',6,NULL),
 (140,19,'2007-06-18 14:13:09',17.2,'bt','n',6,NULL),
 (141,7,'2007-06-18 14:13:30',20.5,'bt','n',6,NULL),
 (142,8,'2007-06-18 14:13:51',18.1,'bt','n',6,NULL),
 (143,53,'2007-06-18 15:03:03',14.9,'re-training to catch mealworms','n',5,NULL),
 (144,52,'2007-06-18 15:04:50',14,'re-training to catch mealworms','n',5,NULL);
INSERT INTO `weights` (`id`,`bat_id`,`date`,`weight`,`note`,`after_eating`,`user_id`,`task_history_id`) VALUES 
 (145,54,'2007-06-18 15:05:37',20.5,'re-training to catch mealworms','n',5,NULL),
 (146,15,'2007-06-18 18:37:19',14.7,'','n',1,NULL),
 (147,38,'2007-06-18 16:45:00',19.9,'','y',2,33),
 (148,44,'2007-06-18 17:23:00',18.1,'','y',2,42),
 (149,40,'2007-06-18 17:04:00',17,'','y',2,36),
 (150,39,'2007-06-18 17:09:00',21.4,'','y',2,38),
 (151,4,'2007-06-18 17:22:00',14.1,'','y',2,40),
 (152,41,'2007-06-18 17:23:00',19.1,'','y',2,41),
 (153,62,'2007-06-18 17:26:40',4.5,'','n',5,NULL),
 (154,42,'2007-06-18 17:24:00',12.1,'','y',2,43),
 (155,43,'2007-06-18 17:31:00',16.1,'','y',2,45),
 (156,67,'2007-06-18 17:37:04',17.6,'','y',2,NULL),
 (157,16,'2007-06-18 18:37:03',13.5,'','n',1,NULL),
 (158,60,'2007-06-19 10:44:38',18.2,'','n',9,NULL),
 (159,23,'2007-06-19 12:43:56',19.9,'bt','n',12,NULL),
 (160,26,'2007-06-19 12:49:21',19.5,'bt','n',12,NULL),
 (161,31,'2007-06-19 12:56:51',16.9,'bt','n',12,NULL),
 (162,35,'2007-06-19 12:59:32',25.3,'bt','n',12,NULL);
INSERT INTO `weights` (`id`,`bat_id`,`date`,`weight`,`note`,`after_eating`,`user_id`,`task_history_id`) VALUES 
 (163,24,'2007-06-19 13:01:34',23.6,'bt','n',12,NULL),
 (164,32,'2007-06-19 13:02:57',18.1,'bt','n',12,NULL),
 (165,25,'2007-06-19 13:04:07',19.5,'bt','n',12,NULL),
 (166,29,'2007-06-19 13:05:24',17.9,'bt','n',12,NULL),
 (167,33,'2007-06-19 13:07:26',20.9,'bt','n',12,NULL),
 (168,27,'2007-06-19 13:09:41',20.5,'bt','n',12,NULL),
 (169,28,'2007-06-19 13:10:15',21,'bt','n',12,NULL),
 (170,34,'2007-06-19 13:14:22',18.5,'bt, teeth not very good','n',12,NULL),
 (171,37,'2007-06-19 13:17:45',15.6,'','n',12,NULL),
 (172,36,'2007-06-19 13:19:03',15.1,'bt','n',12,NULL),
 (173,68,'2007-06-19 13:56:45',18.6,'being trained as demonstrator for social learning experiment','n',5,NULL),
 (174,69,'2007-06-19 13:57:45',18.9,'being trained as demonstrator for social learning exp.-- station #9','n',5,NULL),
 (175,70,'2007-06-19 14:00:16',19.5,'being trained for social learning study; station # 4; banded sticking to skin, removed-- clipped fur on R shoulder','n',5,NULL),
 (176,71,'2007-06-19 14:01:16',19.2,'being trained as demonstrator (staiton #11); band removed-- fur clipped on rump','n',5,NULL);
INSERT INTO `weights` (`id`,`bat_id`,`date`,`weight`,`note`,`after_eating`,`user_id`,`task_history_id`) VALUES 
 (177,72,'2007-06-19 14:02:27',16.2,'being trained as a demonstrator (station #2)','n',5,NULL),
 (178,73,'2007-06-19 14:03:27',17.4,'being trained as demonstrator (station #5)','n',5,NULL),
 (179,17,'2007-06-19 14:29:47',13.2,'','n',1,NULL),
 (180,11,'2007-06-19 14:32:33',20.2,'','n',5,NULL),
 (181,54,'2007-06-19 14:33:08',19.9,'','n',5,NULL),
 (182,3,'2007-06-19 14:33:26',13.3,'','n',5,NULL),
 (183,2,'2007-06-19 14:34:04',16.4,'','n',5,NULL),
 (184,52,'2007-06-19 15:35:15',13.9,'','n',5,NULL),
 (185,74,'2007-06-19 15:36:37',14.4,'','n',5,NULL),
 (186,53,'2007-06-19 15:36:58',14.9,'','n',5,NULL),
 (187,59,'2007-06-19 15:56:20',18.4,'','n',9,NULL),
 (188,61,'2007-06-19 15:57:12',18.1,'','n',9,NULL),
 (189,38,'2007-06-19 17:06:00',20.1,'','y',1,46),
 (190,39,'2007-06-19 17:10:00',21.6,'','y',1,48),
 (191,40,'2007-06-19 17:13:00',16.2,'','y',1,50),
 (192,4,'2007-06-19 17:19:00',13.9,'','y',1,52),
 (193,42,'2007-06-19 17:23:00',13.5,'','y',1,54);
INSERT INTO `weights` (`id`,`bat_id`,`date`,`weight`,`note`,`after_eating`,`user_id`,`task_history_id`) VALUES 
 (194,43,'2007-06-19 17:25:00',15.7,'','y',1,56),
 (195,44,'2007-06-19 17:29:00',17.6,'','n',1,58),
 (196,38,'2007-06-20 08:23:00',19.4,'','n',3,59),
 (197,39,'2007-06-20 08:28:00',21,'','n',3,61),
 (198,40,'2007-06-20 08:31:00',16.1,'','n',3,63),
 (199,41,'2007-06-20 08:33:00',16.7,'','n',3,65),
 (200,4,'2007-06-20 08:35:00',13.1,'','n',3,66),
 (201,42,'2007-06-20 08:39:00',12.1,'','n',3,67),
 (202,44,'2007-06-20 08:54:00',16.7,'','n',3,70),
 (203,67,'2007-06-20 08:59:32',16.5,'','n',3,NULL),
 (204,43,'2007-06-20 09:01:00',14.9,'','n',3,71),
 (205,69,'2007-06-20 09:44:37',17.7,'','n',5,NULL),
 (206,71,'2007-06-20 09:44:59',17.3,'','n',5,NULL),
 (207,70,'2007-06-20 09:45:23',17.3,'','n',5,NULL),
 (208,72,'2007-06-20 09:45:42',15.5,'','n',5,NULL),
 (209,73,'2007-06-20 09:46:15',16.6,'','n',5,NULL),
 (210,68,'2007-06-20 09:46:32',17.3,'','n',5,NULL);
/*!40000 ALTER TABLE `weights` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
