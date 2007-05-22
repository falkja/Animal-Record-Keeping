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
-- Definition of table `bats`
--

DROP TABLE IF EXISTS `bats`;
CREATE TABLE `bats` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cage_id` int(10) unsigned DEFAULT NULL,
  `collection_date` datetime NOT NULL,
  `collection_age` varchar(45) NOT NULL COMMENT 'juvenile/adult',
  `collection_place` varchar(100) NOT NULL,
  `gender` varchar(1) NOT NULL COMMENT 'm/f',
  `leave_date` datetime DEFAULT NULL COMMENT 'y/n - in lab or not',
  `leave_reason` text COMMENT 'death/exported',
  `band` varchar(10) DEFAULT NULL,
  `note` text,
  `vaccination_date` date DEFAULT NULL,
  `species_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `bats`
--

/*!40000 ALTER TABLE `bats` DISABLE KEYS */;
INSERT INTO `bats` (`id`,`cage_id`,`collection_date`,`collection_age`,`collection_place`,`gender`,`leave_date`,`leave_reason`,`band`,`note`,`vaccination_date`,`species_id`) VALUES 
 (1,1,'2005-07-25 00:00:00','Adult','Fort Washington, MD','F',NULL,NULL,'GR39','<tr><td>Ben\'s bat - catches mealworms and discriminates groove beads</td><td>BF</td><td>Apr 25, 2007</td></tr>',NULL,2),
 (2,3,'2005-07-11 00:00:00','Juvenile','Oxon Hill, MD','F',NULL,NULL,'GR27',NULL,NULL,2),
 (3,4,'2005-07-11 00:00:00','Juvenile','Oxon Hill, MD','M',NULL,NULL,'GR30',NULL,NULL,2),
 (4,7,'2005-07-11 00:00:00','Juvenile','Oxon Hill, MD','M',NULL,NULL,'GR37',NULL,NULL,2),
 (5,2,'2005-08-15 00:00:00','Juvenile','Clinton, MD','M',NULL,NULL,'GR41','<tr><td>CATCHER</td><td>AP</td><td>Apr 27, 2007</td></tr>',NULL,2),
 (6,11,'2005-08-15 00:00:00','Juvenile','Clinton, MD','M',NULL,NULL,'GR44',NULL,NULL,2),
 (7,20,'2005-08-15 00:00:00','Juvenile','Clinton, MD','F',NULL,NULL,'GR53',NULL,NULL,2),
 (8,2,'2005-08-15 00:00:00','Juvenile','Clinton, MD','F',NULL,NULL,'GR57',NULL,NULL,2),
 (9,2,'2005-08-15 00:00:00','Juvenile','Clinton, MD','M',NULL,NULL,'GR58',NULL,NULL,2);
INSERT INTO `bats` (`id`,`cage_id`,`collection_date`,`collection_age`,`collection_place`,`gender`,`leave_date`,`leave_reason`,`band`,`note`,`vaccination_date`,`species_id`) VALUES 
 (10,2,'2005-08-15 00:00:00','Adult','Clinton, MD','F',NULL,NULL,'GR65','<tr><td>Bat used for ABR noise exposure study. </td><td>AP</td><td>Apr 27, 2007</td></tr>',NULL,2),
 (11,2,'2005-08-15 00:00:00','Juvenile','Clinton, MD','M',NULL,NULL,'GR78','<tr><td>CATCHER</td><td>AP</td><td>Apr 27, 2007</td></tr>',NULL,2),
 (12,3,'2005-08-15 00:00:00','Adult','Clinton, MD','F',NULL,NULL,'GR91','<tr><td>Former GR76. Rebanded.</td><td>AP</td><td>Apr 27, 2007</td></tr>',NULL,2),
 (13,5,'2005-08-15 00:00:00','Juvenile','Clinton, MD','M',NULL,NULL,'GR92 (band','<tr><td>Former GR56. Rebanded.</td><td>AP</td><td>Apr 27, 2007</td></tr>',NULL,2),
 (14,13,'2006-07-05 00:00:00','Adult','Clinton, MD?','F',NULL,NULL,'B36',NULL,NULL,2),
 (15,13,'2006-07-05 00:00:00','Adult','Clinton, MD?','F',NULL,NULL,'B41',NULL,NULL,2),
 (16,11,'2006-07-05 00:00:00','Adult','Clinton, MD?','F',NULL,NULL,'B42',NULL,NULL,2),
 (17,8,'2006-07-05 00:00:00','Adult','Clinton, MD?','F',NULL,NULL,'B59',NULL,NULL,2);
INSERT INTO `bats` (`id`,`cage_id`,`collection_date`,`collection_age`,`collection_place`,`gender`,`leave_date`,`leave_reason`,`band`,`note`,`vaccination_date`,`species_id`) VALUES 
 (18,11,'2006-07-05 00:00:00','Adult','Clinton, MD?','F',NULL,NULL,'B63',NULL,NULL,2),
 (19,13,'2006-07-07 00:00:00','Juvenile','Brown University','M',NULL,NULL,'B77','<tr><td>Born around June, 15 2006</td><td>AP</td><td>Apr 27, 2007</td></tr>',NULL,2),
 (20,13,'2006-08-02 00:00:00','Juvenile','Clinton, MD?','M',NULL,NULL,'B85',NULL,NULL,2),
 (21,13,'2006-08-02 00:00:00','Juvenile','Clinton, MD?','F',NULL,NULL,'B86',NULL,NULL,2),
 (22,2,'2006-08-02 00:00:00','Juvenile','Clinton, MD?','F',NULL,NULL,'B88',NULL,NULL,2),
 (23,2,'2006-08-02 00:00:00','Juvenile','Clinton, MD?','F',NULL,NULL,'B89',NULL,NULL,2),
 (24,13,'2006-08-02 00:00:00','Juvenile','Clinton, MD?','M',NULL,NULL,'W4',NULL,NULL,2),
 (25,4,'2006-08-02 00:00:00','Juvenile','Clinton, MD?','M',NULL,NULL,'W5',NULL,NULL,2),
 (26,2,'2006-08-02 00:00:00','Juvenile','Clinton, MD?','F',NULL,NULL,'W6',NULL,NULL,2),
 (27,13,'2006-08-02 00:00:00','Juvenile','Clinton, MD?','M',NULL,NULL,'W8',NULL,NULL,2);
INSERT INTO `bats` (`id`,`cage_id`,`collection_date`,`collection_age`,`collection_place`,`gender`,`leave_date`,`leave_reason`,`band`,`note`,`vaccination_date`,`species_id`) VALUES 
 (28,12,'2005-08-15 00:00:00','Adult','Clinton, MD','F',NULL,NULL,'GR47',NULL,NULL,2),
 (29,12,'2005-08-15 00:00:00','Adult','Clinton, MD','F',NULL,NULL,'GR54',NULL,NULL,2),
 (30,12,'2005-08-15 00:00:00','Juvenile','Clinton, MD','F',NULL,NULL,'GR79',NULL,NULL,2),
 (31,12,'2005-08-15 00:00:00','Adult','Clinton, MD','F',NULL,NULL,'GR81','<tr><td>Former GR51. Rebanded 12/14/06</td><td>AP</td><td>Apr 27, 2007</td></tr>',NULL,2),
 (32,12,'2006-07-05 00:00:00','Adult','Clinton, MD?','F',NULL,NULL,'B35','<tr><td>Used for ABRnoise exposure experiments.</td><td>AP</td><td>Apr 27, 2007</td></tr>',NULL,2),
 (33,12,'2006-07-05 00:00:00','Adult','Clinton, MD?','F',NULL,NULL,'B39',NULL,NULL,2),
 (34,12,'2006-07-05 00:00:00','Adult','Clinton, MD?','F',NULL,NULL,'B50',NULL,NULL,2),
 (35,12,'2006-07-05 00:00:00','Adult','Clinton, MD?','F',NULL,NULL,'B62',NULL,NULL,2),
 (36,12,'2006-07-05 00:00:00','Juvenile','Clinton, MD?','F',NULL,NULL,'B65',NULL,NULL,2);
INSERT INTO `bats` (`id`,`cage_id`,`collection_date`,`collection_age`,`collection_place`,`gender`,`leave_date`,`leave_reason`,`band`,`note`,`vaccination_date`,`species_id`) VALUES 
 (37,12,'2006-07-05 00:00:00','Juvenile','Clinton, MD?','F',NULL,NULL,'B66',NULL,NULL,2),
 (38,12,'2006-08-02 00:00:00','Juvenile','Clinton, MD?','M',NULL,NULL,'B72',NULL,NULL,2),
 (39,12,'2006-08-02 00:00:00','Juvenile','Clinton, MD?','F',NULL,NULL,'B90',NULL,NULL,2),
 (40,12,'2006-08-02 00:00:00','Juvenile','Clinton, MD?','F',NULL,NULL,'W3',NULL,NULL,2),
 (41,12,'2006-07-07 00:00:00','Adult','Brown University','F',NULL,NULL,'W11','<tr><td>Former W9. Rebanded.</td><td>AP</td><td>Apr 27, 2007</td></tr>',NULL,2),
 (42,3,'2005-08-15 00:00:00','Adult','Clinton, MD','F',NULL,NULL,'GR62','<tr><td>Used for ABR noise exposure experiment.</td><td>AP</td><td>Apr 27, 2007</td></tr>',NULL,2),
 (43,10,'2006-07-05 00:00:00','Adult','Clinton, MD?','F',NULL,NULL,'B34',NULL,NULL,2),
 (44,9,'2006-07-05 00:00:00','Adult','Clinton, MD?','F',NULL,NULL,'B64',NULL,NULL,2),
 (45,6,'2006-07-05 00:00:00','Adult','Clinton, MD?','F',NULL,NULL,'B46','<tr><td>Bat has a broken wing.</td><td>AP</td><td>Apr 27, 2007</td></tr>',NULL,2);
INSERT INTO `bats` (`id`,`cage_id`,`collection_date`,`collection_age`,`collection_place`,`gender`,`leave_date`,`leave_reason`,`band`,`note`,`vaccination_date`,`species_id`) VALUES 
 (46,16,'2004-07-14 00:00:00','Juvenile','Cheverly, MD','M',NULL,NULL,'Y31','<tr><td>CATCHER</td><td>AP</td><td>Apr 27, 2007</td></tr>',NULL,2),
 (47,14,'2005-07-11 00:00:00','Adult','Oxon Hill, MD','F',NULL,NULL,'GR34','<tr><td>CATCHER</td><td>AP</td><td>Apr 27, 2007</td></tr>',NULL,2),
 (48,14,'2005-08-15 00:00:00','Juvenile','Clinton, MD','F',NULL,NULL,'GR59','<tr><td>CATCHER</td><td>AP</td><td>Apr 27, 2007</td></tr>',NULL,2),
 (49,15,'2005-08-15 00:00:00','Juvenile','Clinton, MD','M',NULL,NULL,'GR46',NULL,NULL,2),
 (50,16,'2005-08-15 00:00:00','Juvenile','Clinton, MD','M',NULL,NULL,'GR61',NULL,NULL,2),
 (51,15,'2006-07-05 00:00:00','Adult','Clinton, MD?','F',NULL,NULL,'B37',NULL,NULL,2),
 (52,15,'2006-07-05 00:00:00','Adult','Clinton, MD?','F',NULL,NULL,'B40','<tr><td>CATCHER</td><td>AP</td><td>Apr 27, 2007</td></tr>',NULL,2),
 (53,14,'2006-07-05 00:00:00','Juvenile','Clinton, MD?','M',NULL,NULL,'B60','<tr><td>CATCHER</td><td>AP</td><td>Apr 27, 2007</td></tr>',NULL,2);
INSERT INTO `bats` (`id`,`cage_id`,`collection_date`,`collection_age`,`collection_place`,`gender`,`leave_date`,`leave_reason`,`band`,`note`,`vaccination_date`,`species_id`) VALUES 
 (54,3,'2005-07-25 00:00:00','Adult','Fort Washington, MD','F',NULL,NULL,'GR32','<tr><td>CATCHER</td><td>AP</td><td>Apr 27, 2007</td></tr>',NULL,2),
 (55,13,'2006-07-05 00:00:00','Juvenile','Clinton, MD?','M',NULL,NULL,'B47','<tr><td>CATCHER</td><td>AP</td><td>Apr 27, 2007</td></tr><tr><td>YOU MAY NOT USE THIS BAT</td><td>AP</td><td>Apr 27, 2007</td></tr>',NULL,2),
 (56,13,'2005-08-15 00:00:00','Juvenile','Clinton, MD','M',NULL,NULL,'GR66',NULL,NULL,2),
 (57,13,'2006-07-05 00:00:00','Juvenile','Clinton, MD?','F',NULL,NULL,'B43',NULL,NULL,2),
 (58,2,'2006-07-05 00:00:00','Juvenile','Clinton, MD?','M',NULL,NULL,'B38',NULL,NULL,2),
 (59,19,'2001-01-31 00:00:00','Adult','Maryland','M',NULL,NULL,'OR82',NULL,NULL,3),
 (60,NULL,'2007-05-18 00:00:00','Juvenile','Lanham, MD','M','2007-05-18 00:00:00',NULL,'Testing',NULL,NULL,3),
 (61,12,'2007-05-18 00:00:00','Juvenile','123','M',NULL,NULL,'Test2',NULL,NULL,2);
INSERT INTO `bats` (`id`,`cage_id`,`collection_date`,`collection_age`,`collection_place`,`gender`,`leave_date`,`leave_reason`,`band`,`note`,`vaccination_date`,`species_id`) VALUES 
 (62,1,'2007-05-18 00:00:00','Juvenile','33345sdf','M',NULL,NULL,'Test3',NULL,NULL,2),
 (63,1,'2007-05-18 00:00:00','Juvenile','33345sdf','M',NULL,NULL,'Test4',NULL,NULL,2),
 (64,7,'2007-05-18 00:00:00','Juvenile','sdf','M',NULL,NULL,'aaa',NULL,NULL,2),
 (65,7,'2007-05-18 00:00:00','Juvenile','sdf','M',NULL,NULL,'aaas',NULL,NULL,2),
 (66,7,'2007-05-18 00:00:00','Juvenile','sdf','M',NULL,NULL,'aaas',NULL,NULL,2),
 (67,7,'2007-05-18 00:00:00','Juvenile','sdf','M',NULL,NULL,'aaas',NULL,NULL,2);
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
 (1,1,1,'2007-04-25 13:11:39',6,'new bat'),
 (2,1,2,'2007-04-25 13:16:22',6,''),
 (3,1,1,'2007-04-25 17:11:01',6,''),
 (4,2,3,'2007-04-25 17:59:56',5,'new bat'),
 (5,3,4,'2007-04-25 18:22:04',5,'new bat'),
 (6,4,7,'2007-04-25 18:23:16',5,'new bat'),
 (7,5,2,'2007-04-25 18:24:06',5,'new bat'),
 (8,6,11,'2007-04-27 07:52:37',5,'new bat'),
 (9,7,7,'2007-04-27 07:53:39',5,'new bat'),
 (10,8,2,'2007-04-27 07:55:15',5,'new bat'),
 (11,9,2,'2007-04-27 07:56:04',5,'new bat'),
 (12,10,2,'2007-04-27 07:56:53',5,'new bat'),
 (13,11,2,'2007-04-27 07:58:40',5,'new bat'),
 (14,12,3,'2007-04-27 07:59:44',5,'new bat'),
 (15,13,2,'2007-04-27 08:01:35',5,'new bat'),
 (16,14,13,'2007-04-27 08:07:46',5,'new bat'),
 (17,15,13,'2007-04-27 08:08:42',5,'new bat'),
 (18,16,11,'2007-04-27 08:09:22',5,'new bat'),
 (19,17,8,'2007-04-27 08:10:52',5,'new bat'),
 (20,18,11,'2007-04-27 08:11:31',5,'new bat'),
 (21,19,13,'2007-04-27 08:15:15',5,'new bat'),
 (22,20,13,'2007-04-27 08:16:41',5,'new bat');
INSERT INTO `cage_in_histories` (`id`,`bat_id`,`cage_id`,`date`,`user_id`,`note`) VALUES 
 (23,21,13,'2007-04-27 08:17:28',5,'new bat'),
 (24,22,2,'2007-04-27 08:18:26',5,'new bat'),
 (25,23,2,'2007-04-27 08:19:00',5,'new bat'),
 (26,24,13,'2007-04-27 08:19:33',5,'new bat'),
 (27,25,4,'2007-04-27 08:20:18',5,'new bat'),
 (28,26,2,'2007-04-27 08:20:49',5,'new bat'),
 (29,27,13,'2007-04-27 08:21:24',5,'new bat'),
 (30,28,12,'2007-04-27 08:24:39',5,'new bat'),
 (31,29,12,'2007-04-27 08:25:20',5,'new bat'),
 (32,30,12,'2007-04-27 08:31:45',5,'new bat'),
 (33,31,12,'2007-04-27 08:32:52',5,'new bat'),
 (34,32,12,'2007-04-27 08:33:57',5,'new bat'),
 (35,33,12,'2007-04-27 08:35:01',5,'new bat'),
 (36,34,12,'2007-04-27 08:36:29',5,'new bat'),
 (37,35,12,'2007-04-27 08:38:23',5,'new bat'),
 (38,36,12,'2007-04-27 08:39:06',5,'new bat'),
 (39,37,12,'2007-04-27 08:39:48',5,'new bat'),
 (40,38,12,'2007-04-27 08:40:21',5,'new bat'),
 (41,39,12,'2007-04-27 08:40:54',5,'new bat'),
 (42,40,12,'2007-04-27 08:41:30',5,'new bat'),
 (43,41,12,'2007-04-27 08:42:18',5,'new bat');
INSERT INTO `cage_in_histories` (`id`,`bat_id`,`cage_id`,`date`,`user_id`,`note`) VALUES 
 (44,42,3,'2007-04-27 09:10:03',5,'new bat'),
 (45,43,10,'2007-04-27 09:11:45',5,'new bat'),
 (46,44,9,'2007-04-27 09:12:19',5,'new bat'),
 (47,45,6,'2007-04-27 09:16:00',5,'new bat'),
 (48,46,16,'2007-04-27 09:19:51',5,'new bat'),
 (49,47,14,'2007-04-27 09:23:36',5,'new bat'),
 (50,48,14,'2007-04-27 09:24:31',5,'new bat'),
 (51,49,15,'2007-04-27 09:26:00',5,'new bat'),
 (52,50,16,'2007-04-27 09:26:38',5,'new bat'),
 (53,51,15,'2007-04-27 09:27:35',5,'new bat'),
 (54,52,15,'2007-04-27 09:28:12',5,'new bat'),
 (55,53,14,'2007-04-27 09:29:35',5,'new bat'),
 (56,54,3,'2007-04-27 09:36:07',5,'new bat'),
 (57,55,13,'2007-04-27 09:54:07',5,'new bat'),
 (58,56,13,'2007-04-27 09:56:47',5,'new bat'),
 (59,57,13,'2007-04-27 09:57:47',5,'new bat'),
 (60,58,2,'2007-04-27 09:59:08',5,'new bat'),
 (61,59,19,'2007-04-27 10:01:16',5,'new bat'),
 (62,13,5,'2007-04-27 11:11:53',5,''),
 (63,4,20,'2007-04-27 14:18:46',5,'bat very overweight. Needs a diet.'),
 (64,4,7,'2007-04-27 14:30:57',5,'');
INSERT INTO `cage_in_histories` (`id`,`bat_id`,`cage_id`,`date`,`user_id`,`note`) VALUES 
 (65,7,20,'2007-04-27 14:31:13',5,''),
 (66,43,10,'2007-04-29 23:55:42',1,'reactivated'),
 (67,46,16,'2007-05-18 13:44:13',6,'reactivated'),
 (68,14,3,'2007-05-18 14:00:29',6,''),
 (69,14,13,'2007-05-18 14:00:47',6,''),
 (70,60,1,'2007-05-18 14:43:41',6,'new bat'),
 (71,60,3,'2007-05-18 14:52:46',6,''),
 (72,60,1,'2007-05-18 15:28:47',6,'reactivated'),
 (73,60,1,'2007-05-18 15:41:08',6,'reactivated'),
 (74,60,1,'2007-05-18 16:01:50',6,'reactivated'),
 (75,60,1,'2007-05-18 16:05:27',6,'reactivated'),
 (76,61,12,'2007-05-18 16:09:25',6,'new bat'),
 (77,62,1,'2007-05-18 16:13:40',6,'new bat'),
 (78,63,1,'2007-05-18 16:14:18',6,'new bat'),
 (79,64,7,'2007-05-18 18:04:05',6,'new bat'),
 (80,65,7,'2007-05-18 18:06:48',6,'new bat'),
 (81,66,7,'2007-05-18 18:19:44',6,'new bat'),
 (82,67,7,'2007-05-18 18:20:42',6,'new bat');
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
 (1,1,1,'2007-04-25 13:16:22',6,'',1),
 (2,1,2,'2007-04-25 17:11:01',6,'',2),
 (3,13,2,'2007-04-27 11:11:53',5,'',15),
 (4,4,7,'2007-04-27 14:18:46',5,'bat very overweight. Needs a diet.',6),
 (5,4,20,'2007-04-27 14:30:57',5,'',63),
 (6,7,7,'2007-04-27 14:31:13',5,'',9),
 (7,43,10,'2007-04-29 23:54:20',1,'',45),
 (8,46,16,'2007-05-18 13:43:48',6,'',48),
 (9,14,13,'2007-05-18 14:00:29',6,'',16),
 (10,14,3,'2007-05-18 14:00:47',6,'',68),
 (11,60,1,'2007-05-18 14:52:46',6,'',71),
 (12,60,3,'2007-05-18 15:08:20',6,'was only a testing bat, not a real one',71),
 (13,60,1,'2007-05-18 15:38:02',6,'',72),
 (14,60,1,'2007-05-18 15:49:09',6,'',73),
 (15,60,1,'2007-05-18 16:02:37',6,'',74),
 (16,60,1,'2007-05-18 16:05:44',6,'',75);
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
 (1,'BF','2007-04-24 00:00:00',NULL,6,2),
 (2,'Thin','2007-04-25 00:00:00',NULL,1,2),
 (3,'NP','2007-04-25 00:00:00',NULL,1,2),
 (4,'THIN2','2007-04-25 00:00:00',NULL,1,2),
 (5,'THIN4','2007-04-25 00:00:00',NULL,1,2),
 (6,'NP2','2007-04-25 00:00:00',NULL,10,2),
 (7,'MED','2007-04-25 00:00:00',NULL,1,2),
 (8,'MA2','2007-04-25 00:00:00',NULL,7,2),
 (9,'SURGERY2','2007-04-25 00:00:00',NULL,8,2),
 (10,'SURGERY3','2007-04-25 00:00:00',NULL,8,2),
 (11,'RECOVERY','2007-04-25 00:00:00',NULL,1,2),
 (12,'FLIGHT','2007-04-25 00:00:00',NULL,1,2),
 (13,'FLIGHT TEMP','2007-04-25 00:00:00',NULL,1,2),
 (14,'GS1','2007-04-25 00:00:00',NULL,9,2),
 (15,'GS2','2007-04-25 00:00:00',NULL,9,2),
 (16,'GS3','2007-04-25 00:00:00',NULL,9,2),
 (18,'n','2007-04-27 00:00:00','2007-04-27 00:00:00',5,2),
 (19,'NPM','2007-04-27 00:00:00',NULL,1,2),
 (20,'MED2','2007-04-27 00:00:00',NULL,1,2),
 (21,'NP7','2007-05-18 00:00:00',NULL,5,2);
/*!40000 ALTER TABLE `cages` ENABLE KEYS */;


--
-- Definition of table `census`
--

DROP TABLE IF EXISTS `census`;
CREATE TABLE `census` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `animals` int(10) unsigned DEFAULT NULL,
  `date` date NOT NULL,
  `room_id` int(10) unsigned NOT NULL,
  `bats_added` varchar(2000) DEFAULT NULL,
  `bats_removed` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `census`
--

/*!40000 ALTER TABLE `census` DISABLE KEYS */;
INSERT INTO `census` (`id`,`animals`,`date`,`room_id`,`bats_added`,`bats_removed`) VALUES 
 (1,5,'2007-04-25',2,'G39 GR27 GR30 GR37 GR41 ',NULL),
 (2,59,'2007-04-27',2,'GR44 GR53 GR57 GR58 GR65 GR78 GR91 GR92 (bandless) B36 B41 B42 B59 B63 B77 B85 B86 B88 B89 W4 W5 W6 W8 GR47 GR54 GR79 GR81 B35 B39 B50 B62 B65 B66 B72 B90 W3 W11 GR62 B34 B64 B46 Y31 GR34 GR59 GR46 GR61 B37 B40 B60 GR32 B47 GR66 B43 B38 OR82 ',NULL),
 (3,59,'2007-05-18',2,'Y31 Testing Testing Testing Testing aaas aaas aaas ','Y31 Testing Testing Testing Testing Testing Testing Testing '),
 (4,60,'2007-05-18',2,'Testing ',NULL),
 (5,57,'2007-05-18',2,'Test2 ',NULL),
 (6,57,'2007-05-18',2,'Test3 ',NULL),
 (7,57,'2007-05-18',2,'aaa ',NULL);
/*!40000 ALTER TABLE `census` ENABLE KEYS */;


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
  `date_closed` datetime DEFAULT NULL,
  `title` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `medical_problems`
--

/*!40000 ALTER TABLE `medical_problems` DISABLE KEYS */;
INSERT INTO `medical_problems` (`id`,`bat_id`,`date_opened`,`description`,`date_closed`,`title`) VALUES 
 (1,4,'2007-04-24 00:00:00','Abscess on face below right eye. White pus when drained. Mouth bleeding.',NULL,'Abscess under right eye'),
 (2,7,'2007-04-24 00:00:00','Abscess on face under right eye. Some pus when drained, bleeding in mouth.',NULL,'Abscess under right eye');
/*!40000 ALTER TABLE `medical_problems` ENABLE KEYS */;


--
-- Definition of table `medical_treatments`
--

DROP TABLE IF EXISTS `medical_treatments`;
CREATE TABLE `medical_treatments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(45) NOT NULL,
  `medical_problem_id` int(10) unsigned DEFAULT NULL,
  `date_opened` date NOT NULL,
  `date_closed` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `medical_treatments`
--

/*!40000 ALTER TABLE `medical_treatments` DISABLE KEYS */;
INSERT INTO `medical_treatments` (`id`,`title`,`medical_problem_id`,`date_opened`,`date_closed`) VALUES 
 (5,'0.15 cc Bactrim',1,'2007-05-07',NULL),
 (6,'observations',1,'2007-05-07',NULL);
/*!40000 ALTER TABLE `medical_treatments` ENABLE KEYS */;


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
 (1,'Fruit Bats (4148L)'),
 (2,'Belfry (4102D)'),
 (3,'Colony Room (4100)');
/*!40000 ALTER TABLE `rooms` ENABLE KEYS */;


--
-- Definition of table `species`
--

DROP TABLE IF EXISTS `species`;
CREATE TABLE `species` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `lower_weight_limit` float DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `species`
--

/*!40000 ALTER TABLE `species` DISABLE KEYS */;
INSERT INTO `species` (`id`,`name`,`lower_weight_limit`) VALUES 
 (2,'Eptesicus fuscus',13),
 (3,'Myotis septentrionalis',6);
/*!40000 ALTER TABLE `species` ENABLE KEYS */;


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
 (1,137,'2007-04-27 14:10:42','',5,NULL),
 (2,137,'2007-04-27 14:14:02','',5,NULL),
 (3,209,'2007-04-27 14:33:58','',5,NULL),
 (4,242,'2007-05-07 11:51:00','',6,NULL),
 (5,242,'2007-05-07 11:51:00','',6,NULL),
 (6,242,'2007-05-07 11:51:00','',6,NULL),
 (7,237,'2007-05-07 11:58:00','',6,NULL);
/*!40000 ALTER TABLE `task_histories` ENABLE KEYS */;


--
-- Definition of table `tasks`
--

DROP TABLE IF EXISTS `tasks`;
CREATE TABLE `tasks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `repeat_code` int(10) unsigned NOT NULL COMMENT '0 means daily 1 = sunday etc.',
  `medical_treatment_id` int(10) unsigned DEFAULT NULL,
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
  `animal_care` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tasks`
--

/*!40000 ALTER TABLE `tasks` DISABLE KEYS */;
INSERT INTO `tasks` (`id`,`repeat_code`,`medical_treatment_id`,`cage_id`,`title`,`notes`,`internal_description`,`food`,`dish_type`,`dish_num`,`jitter`,`date_started`,`date_ended`,`animal_care`) VALUES 
 (1,1,NULL,1,'Feed cage BF','','feed',1.5,'Small',1,0,'2007-04-25 13:12:09',NULL,0),
 (2,2,NULL,1,'Feed cage BF','','feed',1.5,'Small',1,0,'2007-04-25 13:12:09',NULL,0),
 (3,3,NULL,1,'Feed cage BF','','feed',1.5,'Small',1,0,'2007-04-25 13:12:09',NULL,0),
 (4,4,NULL,1,'Feed cage BF','','feed',1.5,'Small',1,0,'2007-04-25 13:12:09',NULL,0),
 (5,5,NULL,1,'Feed cage BF','','feed',1.5,'Small',1,0,'2007-04-25 13:12:09',NULL,0),
 (6,6,NULL,1,'Feed cage BF','','feed',1.5,'Small',1,0,'2007-04-25 13:12:09',NULL,0),
 (7,7,NULL,1,'Feed cage BF','','feed',1.5,'Small',1,0,'2007-04-25 13:12:09',NULL,0),
 (8,3,NULL,1,'Weigh cage BF','','weigh',NULL,NULL,NULL,-1,'2007-04-25 13:13:35','2007-05-16 08:21:17',0),
 (9,6,NULL,1,'Weigh cage BF','','weigh',NULL,NULL,NULL,-1,'2007-04-25 13:13:46','2007-05-16 08:21:19',0),
 (10,1,NULL,7,'Feed cage MED','','feed',8,'Medium',2,0,'2007-04-27 10:04:24','2007-04-27 13:01:00',0);
INSERT INTO `tasks` (`id`,`repeat_code`,`medical_treatment_id`,`cage_id`,`title`,`notes`,`internal_description`,`food`,`dish_type`,`dish_num`,`jitter`,`date_started`,`date_ended`,`animal_care`) VALUES 
 (11,2,NULL,7,'Feed cage MED','','feed',8,'Medium',2,0,'2007-04-27 10:04:24','2007-04-27 13:01:08',0),
 (12,3,NULL,7,'Feed cage MED','','feed',8,'Medium',2,0,'2007-04-27 10:04:24','2007-04-27 13:01:19',0),
 (13,4,NULL,7,'Feed cage MED','','feed',8,'Medium',2,0,'2007-04-27 10:04:24','2007-04-27 13:01:31',0),
 (14,5,NULL,7,'Feed cage MED','','feed',8,'Medium',2,0,'2007-04-27 10:04:24','2007-04-27 13:01:39',0),
 (15,6,NULL,7,'Feed cage MED','','feed',8,'Medium',2,0,'2007-04-27 10:04:24','2007-04-27 13:01:50',0),
 (16,7,NULL,7,'Feed cage MED','','feed',8,'Medium',2,0,'2007-04-27 10:04:24','2007-04-27 13:01:58',0),
 (17,1,NULL,2,'Feed cage Thin','','feed',30,'Long',2,0,'2007-04-27 10:05:03',NULL,0),
 (18,2,NULL,2,'Feed cage Thin','','feed',30,'Long',2,0,'2007-04-27 10:05:03',NULL,0),
 (19,3,NULL,2,'Feed cage Thin','','feed',30,'Long',2,0,'2007-04-27 10:05:03',NULL,0),
 (20,4,NULL,2,'Feed cage Thin','','feed',30,'Long',2,0,'2007-04-27 10:05:03',NULL,0);
INSERT INTO `tasks` (`id`,`repeat_code`,`medical_treatment_id`,`cage_id`,`title`,`notes`,`internal_description`,`food`,`dish_type`,`dish_num`,`jitter`,`date_started`,`date_ended`,`animal_care`) VALUES 
 (21,5,NULL,2,'Feed cage Thin','','feed',30,'Long',2,0,'2007-04-27 10:05:03',NULL,0),
 (22,6,NULL,2,'Feed cage Thin','','feed',30,'Long',2,0,'2007-04-27 10:05:03',NULL,0),
 (23,7,NULL,2,'Feed cage Thin','','feed',30,'Long',2,0,'2007-04-27 10:05:03',NULL,0),
 (24,1,NULL,3,'Feed cage NP','','feed',10,'Medium',2,0,'2007-04-27 10:05:25',NULL,0),
 (25,2,NULL,3,'Feed cage NP','','feed',10,'Medium',2,0,'2007-04-27 10:05:25',NULL,0),
 (26,3,NULL,3,'Feed cage NP','','feed',10,'Medium',2,0,'2007-04-27 10:05:25',NULL,0),
 (27,4,NULL,3,'Feed cage NP','','feed',10,'Medium',2,0,'2007-04-27 10:05:25',NULL,0),
 (28,5,NULL,3,'Feed cage NP','','feed',10,'Medium',2,0,'2007-04-27 10:05:25',NULL,0),
 (29,6,NULL,3,'Feed cage NP','','feed',10,'Medium',2,0,'2007-04-27 10:05:25',NULL,0),
 (30,7,NULL,3,'Feed cage NP','','feed',10,'Medium',2,0,'2007-04-27 10:05:25',NULL,0),
 (31,1,NULL,4,'Feed cage THIN2','','feed',6,'Medium',2,0,'2007-04-27 10:05:57',NULL,0);
INSERT INTO `tasks` (`id`,`repeat_code`,`medical_treatment_id`,`cage_id`,`title`,`notes`,`internal_description`,`food`,`dish_type`,`dish_num`,`jitter`,`date_started`,`date_ended`,`animal_care`) VALUES 
 (32,2,NULL,4,'Feed cage THIN2','','feed',6,'Medium',2,0,'2007-04-27 10:05:57',NULL,0),
 (33,3,NULL,4,'Feed cage THIN2','','feed',6,'Medium',2,0,'2007-04-27 10:05:57',NULL,0),
 (34,4,NULL,4,'Feed cage THIN2','','feed',6,'Medium',2,0,'2007-04-27 10:05:57',NULL,0),
 (35,5,NULL,4,'Feed cage THIN2','','feed',6,'Medium',2,0,'2007-04-27 10:05:57',NULL,0),
 (36,6,NULL,4,'Feed cage THIN2','','feed',6,'Medium',2,0,'2007-04-27 10:05:57',NULL,0),
 (37,7,NULL,4,'Feed cage THIN2','','feed',6,'Medium',2,0,'2007-04-27 10:05:57',NULL,0),
 (38,1,NULL,5,'Feed cage THIN4','','feed',3,'Medium',2,0,'2007-04-27 10:06:40',NULL,0),
 (39,2,NULL,5,'Feed cage THIN4','','feed',3,'Medium',2,0,'2007-04-27 10:06:40',NULL,0),
 (40,3,NULL,5,'Feed cage THIN4','','feed',3,'Medium',2,0,'2007-04-27 10:06:40',NULL,0),
 (41,4,NULL,5,'Feed cage THIN4','','feed',3,'Medium',2,0,'2007-04-27 10:06:40',NULL,0),
 (42,5,NULL,5,'Feed cage THIN4','','feed',3,'Medium',2,0,'2007-04-27 10:06:40',NULL,0);
INSERT INTO `tasks` (`id`,`repeat_code`,`medical_treatment_id`,`cage_id`,`title`,`notes`,`internal_description`,`food`,`dish_type`,`dish_num`,`jitter`,`date_started`,`date_ended`,`animal_care`) VALUES 
 (43,6,NULL,5,'Feed cage THIN4','','feed',3,'Medium',2,0,'2007-04-27 10:06:40',NULL,0),
 (44,7,NULL,5,'Feed cage THIN4','','feed',3,'Medium',2,0,'2007-04-27 10:06:40',NULL,0),
 (45,1,NULL,19,'Feed cage NPM','','feed',1.5,'Small',1,0,'2007-04-27 10:07:10',NULL,0),
 (46,2,NULL,19,'Feed cage NPM','','feed',1.5,'Small',1,0,'2007-04-27 10:07:10',NULL,0),
 (47,3,NULL,19,'Feed cage NPM','','feed',1.5,'Small',1,0,'2007-04-27 10:07:10',NULL,0),
 (48,4,NULL,19,'Feed cage NPM','','feed',1.5,'Small',1,0,'2007-04-27 10:07:10',NULL,0),
 (49,5,NULL,19,'Feed cage NPM','','feed',1.5,'Small',1,0,'2007-04-27 10:07:10',NULL,0),
 (50,6,NULL,19,'Feed cage NPM','','feed',1.5,'Small',1,0,'2007-04-27 10:07:10',NULL,0),
 (51,7,NULL,19,'Feed cage NPM','','feed',1.5,'Small',1,0,'2007-04-27 10:07:10',NULL,0),
 (52,1,NULL,8,'Feed cage MA2','','feed',3,'Medium',1,0,'2007-04-27 10:07:35',NULL,0),
 (53,2,NULL,8,'Feed cage MA2','','feed',3,'Medium',1,0,'2007-04-27 10:07:35',NULL,0);
INSERT INTO `tasks` (`id`,`repeat_code`,`medical_treatment_id`,`cage_id`,`title`,`notes`,`internal_description`,`food`,`dish_type`,`dish_num`,`jitter`,`date_started`,`date_ended`,`animal_care`) VALUES 
 (54,3,NULL,8,'Feed cage MA2','','feed',3,'Medium',1,0,'2007-04-27 10:07:35',NULL,0),
 (55,4,NULL,8,'Feed cage MA2','','feed',3,'Medium',1,0,'2007-04-27 10:07:35',NULL,0),
 (56,5,NULL,8,'Feed cage MA2','','feed',3,'Medium',1,0,'2007-04-27 10:07:35',NULL,0),
 (57,6,NULL,8,'Feed cage MA2','','feed',3,'Medium',1,0,'2007-04-27 10:07:35',NULL,0),
 (58,7,NULL,8,'Feed cage MA2','','feed',3,'Medium',1,0,'2007-04-27 10:07:35',NULL,0),
 (59,1,NULL,11,'Feed cage RECOVERY','','feed',3,'Medium',1,0,'2007-04-27 10:07:54',NULL,0),
 (60,2,NULL,11,'Feed cage RECOVERY','','feed',3,'Medium',1,0,'2007-04-27 10:07:54',NULL,0),
 (61,3,NULL,11,'Feed cage RECOVERY','','feed',3,'Medium',1,0,'2007-04-27 10:07:54',NULL,0),
 (62,4,NULL,11,'Feed cage RECOVERY','','feed',3,'Medium',1,0,'2007-04-27 10:07:54',NULL,0),
 (63,5,NULL,11,'Feed cage RECOVERY','','feed',3,'Medium',1,0,'2007-04-27 10:07:54',NULL,0);
INSERT INTO `tasks` (`id`,`repeat_code`,`medical_treatment_id`,`cage_id`,`title`,`notes`,`internal_description`,`food`,`dish_type`,`dish_num`,`jitter`,`date_started`,`date_ended`,`animal_care`) VALUES 
 (64,6,NULL,11,'Feed cage RECOVERY','','feed',3,'Medium',1,0,'2007-04-27 10:07:55',NULL,0),
 (65,7,NULL,11,'Feed cage RECOVERY','','feed',3,'Medium',1,0,'2007-04-27 10:07:55',NULL,0),
 (66,1,NULL,12,'Feed cage FLIGHT','','feed',28,'Long',3,0,'2007-04-27 10:08:13',NULL,0),
 (67,2,NULL,12,'Feed cage FLIGHT','','feed',28,'Long',3,0,'2007-04-27 10:08:13',NULL,0),
 (68,3,NULL,12,'Feed cage FLIGHT','','feed',28,'Long',3,0,'2007-04-27 10:08:13',NULL,0),
 (69,4,NULL,12,'Feed cage FLIGHT','','feed',28,'Long',3,0,'2007-04-27 10:08:13',NULL,0),
 (70,5,NULL,12,'Feed cage FLIGHT','','feed',28,'Long',3,0,'2007-04-27 10:08:13',NULL,0),
 (71,6,NULL,12,'Feed cage FLIGHT','','feed',28,'Long',3,0,'2007-04-27 10:08:13',NULL,0),
 (72,7,NULL,12,'Feed cage FLIGHT','','feed',28,'Long',3,0,'2007-04-27 10:08:13',NULL,0),
 (73,1,NULL,13,'Feed cage FLIGHT TEMP','','feed',20,'Long',2,0,'2007-04-27 10:08:31',NULL,0);
INSERT INTO `tasks` (`id`,`repeat_code`,`medical_treatment_id`,`cage_id`,`title`,`notes`,`internal_description`,`food`,`dish_type`,`dish_num`,`jitter`,`date_started`,`date_ended`,`animal_care`) VALUES 
 (74,2,NULL,13,'Feed cage FLIGHT TEMP','','feed',20,'Long',2,0,'2007-04-27 10:08:31',NULL,0),
 (75,3,NULL,13,'Feed cage FLIGHT TEMP','','feed',20,'Long',2,0,'2007-04-27 10:08:31',NULL,0),
 (76,4,NULL,13,'Feed cage FLIGHT TEMP','','feed',20,'Long',2,0,'2007-04-27 10:08:31',NULL,0),
 (77,5,NULL,13,'Feed cage FLIGHT TEMP','','feed',20,'Long',2,0,'2007-04-27 10:08:31',NULL,0),
 (78,6,NULL,13,'Feed cage FLIGHT TEMP','','feed',20,'Long',2,0,'2007-04-27 10:08:32',NULL,0),
 (79,7,NULL,13,'Feed cage FLIGHT TEMP','','feed',20,'Long',2,0,'2007-04-27 10:08:32',NULL,0),
 (80,1,NULL,14,'Feed cage GS1','','feed',8,'Medium',2,0,'2007-04-27 10:09:17',NULL,0),
 (81,2,NULL,14,'Feed cage GS1','','feed',8,'Medium',2,0,'2007-04-27 10:09:18',NULL,0),
 (82,3,NULL,14,'Feed cage GS1','','feed',8,'Medium',2,0,'2007-04-27 10:09:18',NULL,0),
 (83,4,NULL,14,'Feed cage GS1','','feed',8,'Medium',2,0,'2007-04-27 10:09:18',NULL,0);
INSERT INTO `tasks` (`id`,`repeat_code`,`medical_treatment_id`,`cage_id`,`title`,`notes`,`internal_description`,`food`,`dish_type`,`dish_num`,`jitter`,`date_started`,`date_ended`,`animal_care`) VALUES 
 (84,5,NULL,14,'Feed cage GS1','','feed',8,'Medium',2,0,'2007-04-27 10:09:18',NULL,0),
 (85,6,NULL,14,'Feed cage GS1','','feed',8,'Medium',2,0,'2007-04-27 10:09:18',NULL,0),
 (86,7,NULL,14,'Feed cage GS1','','feed',8,'Medium',2,0,'2007-04-27 10:09:18',NULL,0),
 (87,1,NULL,15,'Feed cage GS2','','feed',6,'Medium',2,0,'2007-04-27 10:09:37',NULL,0),
 (88,2,NULL,15,'Feed cage GS2','','feed',6,'Medium',2,0,'2007-04-27 10:09:37',NULL,0),
 (89,3,NULL,15,'Feed cage GS2','','feed',6,'Medium',2,0,'2007-04-27 10:09:37',NULL,0),
 (90,4,NULL,15,'Feed cage GS2','','feed',6,'Medium',2,0,'2007-04-27 10:09:37',NULL,0),
 (91,5,NULL,15,'Feed cage GS2','','feed',6,'Medium',2,0,'2007-04-27 10:09:37',NULL,0),
 (92,6,NULL,15,'Feed cage GS2','','feed',6,'Medium',2,0,'2007-04-27 10:09:37',NULL,0),
 (93,7,NULL,15,'Feed cage GS2','','feed',6,'Medium',2,0,'2007-04-27 10:09:37',NULL,0),
 (94,1,NULL,16,'Feed cage GS3','','feed',7,'Medium',2,0,'2007-04-27 10:09:56',NULL,0);
INSERT INTO `tasks` (`id`,`repeat_code`,`medical_treatment_id`,`cage_id`,`title`,`notes`,`internal_description`,`food`,`dish_type`,`dish_num`,`jitter`,`date_started`,`date_ended`,`animal_care`) VALUES 
 (95,2,NULL,16,'Feed cage GS3','','feed',7,'Medium',2,0,'2007-04-27 10:09:56',NULL,0),
 (96,3,NULL,16,'Feed cage GS3','','feed',7,'Medium',2,0,'2007-04-27 10:09:56',NULL,0),
 (97,4,NULL,16,'Feed cage GS3','','feed',7,'Medium',2,0,'2007-04-27 10:09:56',NULL,0),
 (98,5,NULL,16,'Feed cage GS3','','feed',7,'Medium',2,0,'2007-04-27 10:09:56',NULL,0),
 (99,6,NULL,16,'Feed cage GS3','','feed',7,'Medium',2,0,'2007-04-27 10:09:56',NULL,0),
 (100,7,NULL,16,'Feed cage GS3','','feed',7,'Medium',2,0,'2007-04-27 10:09:56',NULL,0),
 (101,1,NULL,9,'Feed cage SURGERY2','','feed',1.5,'Medium',1,0,'2007-04-27 10:25:12',NULL,0),
 (102,2,NULL,9,'Feed cage SURGERY2','','feed',1.5,'Medium',1,0,'2007-04-27 10:25:12',NULL,0),
 (103,3,NULL,9,'Feed cage SURGERY2','','feed',1.5,'Medium',1,0,'2007-04-27 10:25:12',NULL,0),
 (104,4,NULL,9,'Feed cage SURGERY2','','feed',1.5,'Medium',1,0,'2007-04-27 10:25:12',NULL,0);
INSERT INTO `tasks` (`id`,`repeat_code`,`medical_treatment_id`,`cage_id`,`title`,`notes`,`internal_description`,`food`,`dish_type`,`dish_num`,`jitter`,`date_started`,`date_ended`,`animal_care`) VALUES 
 (105,5,NULL,9,'Feed cage SURGERY2','','feed',1.5,'Medium',1,0,'2007-04-27 10:25:12',NULL,0),
 (106,6,NULL,9,'Feed cage SURGERY2','','feed',1.5,'Medium',1,0,'2007-04-27 10:25:12',NULL,0),
 (107,7,NULL,9,'Feed cage SURGERY2','','feed',1.5,'Medium',1,0,'2007-04-27 10:25:12',NULL,0),
 (108,1,NULL,10,'Feed cage SURGERY3','','feed',1.5,'Medium',1,0,'2007-04-27 10:25:35',NULL,0),
 (109,2,NULL,10,'Feed cage SURGERY3','','feed',1.5,'Medium',1,0,'2007-04-27 10:25:35',NULL,0),
 (110,3,NULL,10,'Feed cage SURGERY3','','feed',1.5,'Medium',1,0,'2007-04-27 10:25:35',NULL,0),
 (111,4,NULL,10,'Feed cage SURGERY3','','feed',1.5,'Medium',1,0,'2007-04-27 10:25:36',NULL,0),
 (112,5,NULL,10,'Feed cage SURGERY3','','feed',1.5,'Medium',1,0,'2007-04-27 10:25:36',NULL,0),
 (113,6,NULL,10,'Feed cage SURGERY3','','feed',1.5,'Medium',1,0,'2007-04-27 10:25:36',NULL,0),
 (114,7,NULL,10,'Feed cage SURGERY3','','feed',1.5,'Medium',1,0,'2007-04-27 10:25:36',NULL,0);
INSERT INTO `tasks` (`id`,`repeat_code`,`medical_treatment_id`,`cage_id`,`title`,`notes`,`internal_description`,`food`,`dish_type`,`dish_num`,`jitter`,`date_started`,`date_ended`,`animal_care`) VALUES 
 (115,1,NULL,6,'Feed cage NP2','','feed',2,'Medium',1,0,'2007-04-27 10:26:26',NULL,0),
 (116,2,NULL,6,'Feed cage NP2','','feed',2,'Medium',1,0,'2007-04-27 10:26:26',NULL,0),
 (117,3,NULL,6,'Feed cage NP2','','feed',2,'Medium',1,0,'2007-04-27 10:26:26',NULL,0),
 (118,4,NULL,6,'Feed cage NP2','','feed',2,'Medium',1,0,'2007-04-27 10:26:26',NULL,0),
 (119,5,NULL,6,'Feed cage NP2','','feed',2,'Medium',1,0,'2007-04-27 10:26:26',NULL,0),
 (120,6,NULL,6,'Feed cage NP2','','feed',2,'Medium',1,0,'2007-04-27 10:26:26',NULL,0),
 (121,7,NULL,6,'Feed cage NP2','','feed',2,'Medium',1,0,'2007-04-27 10:26:26',NULL,0),
 (122,3,NULL,12,'Weigh cage FLIGHT','','weigh',NULL,NULL,NULL,-1,'2007-04-27 10:38:21','2007-04-27 10:39:27',0),
 (123,3,NULL,12,'Weigh cage FLIGHT','','weigh',NULL,NULL,NULL,-1,'2007-04-27 10:38:30','2007-04-27 10:39:27',0),
 (124,3,NULL,12,'Weigh cage FLIGHT','','weigh',NULL,NULL,NULL,-1,'2007-04-27 10:38:43','2007-04-27 10:39:27',0);
INSERT INTO `tasks` (`id`,`repeat_code`,`medical_treatment_id`,`cage_id`,`title`,`notes`,`internal_description`,`food`,`dish_type`,`dish_num`,`jitter`,`date_started`,`date_ended`,`animal_care`) VALUES 
 (125,3,NULL,12,'Weigh cage FLIGHT','','weigh',NULL,NULL,NULL,-1,'2007-04-27 10:39:08','2007-04-27 10:39:27',0),
 (126,3,NULL,12,'Weigh cage FLIGHT','','weigh',NULL,NULL,NULL,-1,'2007-04-27 10:40:33','2007-04-27 10:43:35',0),
 (127,6,NULL,12,'Weigh cage FLIGHT','','weigh',NULL,NULL,NULL,-1,'2007-04-27 10:41:05','2007-04-27 10:43:29',0),
 (128,5,NULL,13,'Weigh cage FLIGHT TEMP','','weigh',NULL,NULL,NULL,-1,'2007-04-27 10:41:41','2007-04-27 10:42:50',0),
 (129,5,NULL,13,'Weigh cage FLIGHT TEMP','','weigh',NULL,NULL,NULL,-1,'2007-04-27 10:42:37','2007-04-27 10:42:50',0),
 (130,3,NULL,12,'Weigh cage FLIGHT','','weigh',NULL,NULL,NULL,-1,'2007-04-27 10:43:06','2007-04-27 10:43:34',0),
 (131,6,NULL,12,'Weigh cage FLIGHT','','weigh',NULL,NULL,NULL,-1,'2007-04-27 10:43:22','2007-04-27 10:43:28',0),
 (132,3,NULL,12,'Weigh cage FLIGHT','','weigh',NULL,NULL,NULL,-1,'2007-04-27 10:44:05',NULL,0);
INSERT INTO `tasks` (`id`,`repeat_code`,`medical_treatment_id`,`cage_id`,`title`,`notes`,`internal_description`,`food`,`dish_type`,`dish_num`,`jitter`,`date_started`,`date_ended`,`animal_care`) VALUES 
 (133,3,NULL,12,'Weigh cage FLIGHT','','weigh',NULL,NULL,NULL,-1,'2007-04-27 10:45:04','2007-04-27 11:03:44',0),
 (134,6,NULL,12,'Weigh cage FLIGHT','','weigh',NULL,NULL,NULL,-1,'2007-04-27 11:04:11',NULL,0),
 (135,5,NULL,13,'Weigh cage FLIGHT TEMP','','weigh',NULL,NULL,NULL,-1,'2007-04-27 11:04:30',NULL,0),
 (136,3,NULL,19,'Weigh cage NPM','','weigh',NULL,NULL,NULL,-1,'2007-04-27 11:04:44','2007-04-27 11:57:45',0),
 (137,6,NULL,19,'Weigh cage NPM','','weigh',NULL,NULL,NULL,-1,'2007-04-27 11:04:56',NULL,0),
 (138,3,NULL,11,'Weigh cage RECOVERY','','weigh',NULL,NULL,NULL,-1,'2007-04-27 11:05:08',NULL,0),
 (139,6,NULL,11,'Weigh cage RECOVERY','','weigh',NULL,NULL,NULL,-1,'2007-04-27 11:05:18',NULL,0),
 (140,3,NULL,7,'Weigh cage MED','','weigh',NULL,NULL,NULL,-1,'2007-04-27 11:05:46','2007-04-27 14:32:38',0),
 (141,6,NULL,7,'Weigh cage MED','','weigh',NULL,NULL,NULL,-1,'2007-04-27 11:06:12','2007-04-27 14:32:38',0);
INSERT INTO `tasks` (`id`,`repeat_code`,`medical_treatment_id`,`cage_id`,`title`,`notes`,`internal_description`,`food`,`dish_type`,`dish_num`,`jitter`,`date_started`,`date_ended`,`animal_care`) VALUES 
 (142,5,NULL,2,'Weigh cage Thin','','weigh',NULL,NULL,NULL,-1,'2007-04-27 11:06:31',NULL,0),
 (143,2,NULL,2,'Weigh cage Thin','','weigh',NULL,NULL,NULL,-1,'2007-04-27 11:06:43',NULL,0),
 (144,2,NULL,13,'Weigh cage FLIGHT TEMP','','weigh',NULL,NULL,NULL,-1,'2007-04-27 11:07:01',NULL,0),
 (145,5,NULL,4,'Weigh cage THIN2','','weigh',NULL,NULL,NULL,-1,'2007-04-27 11:08:05','2007-04-27 12:00:15',0),
 (146,2,NULL,4,'Weigh cage THIN2','','weigh',NULL,NULL,NULL,-1,'2007-04-27 11:08:18',NULL,0),
 (147,5,NULL,8,'Weigh cage MA2','','weigh',NULL,NULL,NULL,-1,'2007-04-27 11:09:05','2007-04-27 12:00:24',0),
 (148,2,NULL,8,'Weigh cage MA2','','weigh',NULL,NULL,NULL,-1,'2007-04-27 11:09:20',NULL,0),
 (149,5,NULL,5,'Weigh cage THIN4','','weigh',NULL,NULL,NULL,-1,'2007-04-27 11:17:32','2007-04-27 12:00:31',0),
 (150,2,NULL,5,'Weigh cage THIN4','','weigh',NULL,NULL,NULL,-1,'2007-04-27 11:17:45',NULL,0);
INSERT INTO `tasks` (`id`,`repeat_code`,`medical_treatment_id`,`cage_id`,`title`,`notes`,`internal_description`,`food`,`dish_type`,`dish_num`,`jitter`,`date_started`,`date_ended`,`animal_care`) VALUES 
 (151,2,NULL,7,'Weigh cage MED','','weigh',NULL,NULL,NULL,-1,'2007-04-27 11:18:42','2007-04-27 14:32:38',0),
 (152,4,NULL,7,'Weigh cage MED','','weigh',NULL,NULL,NULL,-1,'2007-04-27 11:18:48','2007-04-27 14:32:38',0),
 (153,5,NULL,7,'Weigh cage MED','','weigh',NULL,NULL,NULL,-1,'2007-04-27 11:19:11','2007-04-27 14:32:38',0),
 (154,0,NULL,6,'Weigh cage NP2','','weigh',NULL,NULL,NULL,-1,'2007-04-27 11:20:04','2007-04-27 11:21:17',0),
 (155,0,NULL,9,'Weigh cage SURGERY2','','weigh',NULL,NULL,NULL,-1,'2007-04-27 11:20:22','2007-04-27 11:21:20',0),
 (156,0,NULL,10,'Weigh cage SURGERY3','','weigh',NULL,NULL,NULL,-1,'2007-04-27 11:20:29','2007-04-27 11:21:22',0),
 (157,0,NULL,14,'Weigh cage GS1','','weigh',NULL,NULL,NULL,-1,'2007-04-27 11:20:52','2007-04-27 11:21:24',0),
 (158,0,NULL,15,'Weigh cage GS2','','weigh',NULL,NULL,NULL,-1,'2007-04-27 11:20:58','2007-04-27 11:21:26',0),
 (159,0,NULL,16,'Weigh cage GS3','','weigh',NULL,NULL,NULL,-1,'2007-04-27 11:21:04','2007-04-27 11:21:28',0);
INSERT INTO `tasks` (`id`,`repeat_code`,`medical_treatment_id`,`cage_id`,`title`,`notes`,`internal_description`,`food`,`dish_type`,`dish_num`,`jitter`,`date_started`,`date_ended`,`animal_care`) VALUES 
 (160,2,NULL,9,'Weigh cage SURGERY2','','weigh',NULL,NULL,NULL,-1,'2007-04-27 11:21:40',NULL,0),
 (161,3,NULL,9,'Weigh cage SURGERY2','','weigh',NULL,NULL,NULL,-1,'2007-04-27 11:21:43',NULL,0),
 (162,4,NULL,9,'Weigh cage SURGERY2','','weigh',NULL,NULL,NULL,-1,'2007-04-27 11:21:46',NULL,0),
 (163,5,NULL,9,'Weigh cage SURGERY2','','weigh',NULL,NULL,NULL,-1,'2007-04-27 11:21:49',NULL,0),
 (164,6,NULL,9,'Weigh cage SURGERY2','','weigh',NULL,NULL,NULL,-1,'2007-04-27 11:21:52',NULL,0),
 (165,2,NULL,10,'Weigh cage SURGERY3','','weigh',NULL,NULL,NULL,-1,'2007-04-27 11:22:00',NULL,0),
 (166,3,NULL,10,'Weigh cage SURGERY3','','weigh',NULL,NULL,NULL,-1,'2007-04-27 11:22:03',NULL,0),
 (167,4,NULL,10,'Weigh cage SURGERY3','','weigh',NULL,NULL,NULL,-1,'2007-04-27 11:22:07',NULL,0),
 (168,5,NULL,10,'Weigh cage SURGERY3','','weigh',NULL,NULL,NULL,-1,'2007-04-27 11:22:10',NULL,0),
 (169,6,NULL,10,'Weigh cage SURGERY3','','weigh',NULL,NULL,NULL,-1,'2007-04-27 11:22:13',NULL,0);
INSERT INTO `tasks` (`id`,`repeat_code`,`medical_treatment_id`,`cage_id`,`title`,`notes`,`internal_description`,`food`,`dish_type`,`dish_num`,`jitter`,`date_started`,`date_ended`,`animal_care`) VALUES 
 (170,2,NULL,6,'Weigh cage NP2','','weigh',NULL,NULL,NULL,-1,'2007-04-27 11:22:23',NULL,0),
 (171,3,NULL,6,'Weigh cage NP2','','weigh',NULL,NULL,NULL,-1,'2007-04-27 11:22:26',NULL,0),
 (172,4,NULL,6,'Weigh cage NP2','','weigh',NULL,NULL,NULL,-1,'2007-04-27 11:22:29',NULL,0),
 (173,5,NULL,6,'Weigh cage NP2','','weigh',NULL,NULL,NULL,-1,'2007-04-27 11:22:32',NULL,0),
 (174,6,NULL,6,'Weigh cage NP2','','weigh',NULL,NULL,NULL,-1,'2007-04-27 11:22:35',NULL,0),
 (175,2,NULL,14,'Weigh cage GS1','','weigh',NULL,NULL,NULL,-1,'2007-04-27 11:22:50',NULL,0),
 (176,3,NULL,14,'Weigh cage GS1','','weigh',NULL,NULL,NULL,-1,'2007-04-27 11:22:52',NULL,0),
 (177,4,NULL,14,'Weigh cage GS1','','weigh',NULL,NULL,NULL,-1,'2007-04-27 11:22:55',NULL,0),
 (178,5,NULL,14,'Weigh cage GS1','','weigh',NULL,NULL,NULL,-1,'2007-04-27 11:22:58',NULL,0),
 (179,6,NULL,14,'Weigh cage GS1','','weigh',NULL,NULL,NULL,-1,'2007-04-27 11:23:01',NULL,0);
INSERT INTO `tasks` (`id`,`repeat_code`,`medical_treatment_id`,`cage_id`,`title`,`notes`,`internal_description`,`food`,`dish_type`,`dish_num`,`jitter`,`date_started`,`date_ended`,`animal_care`) VALUES 
 (180,2,NULL,15,'Weigh cage GS2','','weigh',NULL,NULL,NULL,-1,'2007-04-27 11:23:09',NULL,0),
 (181,3,NULL,15,'Weigh cage GS2','','weigh',NULL,NULL,NULL,-1,'2007-04-27 11:23:12',NULL,0),
 (182,4,NULL,15,'Weigh cage GS2','','weigh',NULL,NULL,NULL,-1,'2007-04-27 11:23:15',NULL,0),
 (183,5,NULL,15,'Weigh cage GS2','','weigh',NULL,NULL,NULL,-1,'2007-04-27 11:23:18',NULL,0),
 (184,6,NULL,15,'Weigh cage GS2','','weigh',NULL,NULL,NULL,-1,'2007-04-27 11:23:22',NULL,0),
 (185,2,NULL,16,'Weigh cage GS3','','weigh',NULL,NULL,NULL,-1,'2007-04-27 11:23:32',NULL,0),
 (186,3,NULL,16,'Weigh cage GS3','','weigh',NULL,NULL,NULL,-1,'2007-04-27 11:23:35',NULL,0),
 (187,4,NULL,16,'Weigh cage GS3','','weigh',NULL,NULL,NULL,-1,'2007-04-27 11:23:38',NULL,0),
 (188,5,NULL,16,'Weigh cage GS3','','weigh',NULL,NULL,NULL,-1,'2007-04-27 11:23:41',NULL,0),
 (189,6,NULL,16,'Weigh cage GS3','','weigh',NULL,NULL,NULL,-1,'2007-04-27 11:23:44',NULL,0);
INSERT INTO `tasks` (`id`,`repeat_code`,`medical_treatment_id`,`cage_id`,`title`,`notes`,`internal_description`,`food`,`dish_type`,`dish_num`,`jitter`,`date_started`,`date_ended`,`animal_care`) VALUES 
 (190,7,NULL,7,'Weigh cage MED','','weigh',NULL,NULL,NULL,-1,'2007-04-27 11:23:59','2007-04-27 14:32:38',0),
 (191,1,NULL,7,'Weigh cage MED','','weigh',NULL,NULL,NULL,-1,'2007-04-27 11:24:02','2007-04-27 14:32:38',0),
 (192,6,NULL,3,'Weigh cage NP','','weigh',NULL,NULL,NULL,-1,'2007-04-27 11:25:46',NULL,0),
 (193,2,NULL,3,'Weigh cage NP','','weigh',NULL,NULL,NULL,-1,'2007-04-27 11:25:53','2007-04-27 11:57:05',0),
 (194,3,NULL,3,'Weigh cage NP','','weigh',NULL,NULL,NULL,-1,'2007-04-27 11:57:30',NULL,0),
 (195,3,NULL,19,'Weigh cage NPM','','weigh',NULL,NULL,NULL,-1,'2007-04-27 11:58:02',NULL,0),
 (196,2,NULL,2,'Weigh cage Thin','','weigh',NULL,NULL,NULL,-1,'2007-04-27 11:59:10',NULL,0),
 (197,6,NULL,8,'Weigh cage MA2','','weigh',NULL,NULL,NULL,-1,'2007-04-27 12:01:37',NULL,0),
 (198,6,NULL,4,'Weigh cage THIN2','','weigh',NULL,NULL,NULL,-1,'2007-04-27 12:01:55',NULL,0),
 (199,6,NULL,5,'Weigh cage THIN4','','weigh',NULL,NULL,NULL,-1,'2007-04-27 12:02:10',NULL,0);
INSERT INTO `tasks` (`id`,`repeat_code`,`medical_treatment_id`,`cage_id`,`title`,`notes`,`internal_description`,`food`,`dish_type`,`dish_num`,`jitter`,`date_started`,`date_ended`,`animal_care`) VALUES 
 (200,1,NULL,7,'Feed cage MED','','feed',1,'Medium',1,0,'2007-04-27 13:02:37',NULL,0),
 (201,2,NULL,7,'Feed cage MED','','feed',1,'Medium',1,0,'2007-04-27 13:02:37',NULL,0),
 (202,3,NULL,7,'Feed cage MED','','feed',1,'Medium',1,0,'2007-04-27 13:02:37',NULL,0),
 (203,4,NULL,7,'Feed cage MED','','feed',1,'Medium',1,0,'2007-04-27 13:02:37',NULL,0),
 (204,5,NULL,7,'Feed cage MED','','feed',1,'Medium',1,0,'2007-04-27 13:02:37',NULL,0),
 (205,6,NULL,7,'Feed cage MED','','feed',1,'Medium',1,0,'2007-04-27 13:02:37',NULL,0),
 (206,7,NULL,7,'Feed cage MED','','feed',1,'Medium',1,0,'2007-04-27 13:02:37',NULL,0),
 (207,2,NULL,NULL,'Medicate Bats','',NULL,NULL,NULL,NULL,0,'2007-04-27 13:38:23',NULL,0),
 (208,4,NULL,NULL,'Medicate Bats','',NULL,NULL,NULL,NULL,0,'2007-04-27 13:38:23',NULL,0),
 (209,6,NULL,NULL,'Medicate Bats','',NULL,NULL,NULL,NULL,0,'2007-04-27 13:38:48',NULL,0),
 (210,3,NULL,NULL,'Medicate Bats','',NULL,NULL,NULL,NULL,0,'2007-04-27 13:42:28',NULL,0);
INSERT INTO `tasks` (`id`,`repeat_code`,`medical_treatment_id`,`cage_id`,`title`,`notes`,`internal_description`,`food`,`dish_type`,`dish_num`,`jitter`,`date_started`,`date_ended`,`animal_care`) VALUES 
 (211,5,NULL,NULL,'Medicate Bats','','change_pads',NULL,NULL,NULL,0,'2007-04-27 13:42:28',NULL,0),
 (214,1,NULL,20,'Feed cage MED2','','feed',2,'Medium',1,0,'2007-04-27 14:32:16',NULL,0),
 (215,2,NULL,20,'Feed cage MED2','','feed',2,'Medium',1,0,'2007-04-27 14:32:16',NULL,0),
 (216,3,NULL,20,'Feed cage MED2','','feed',2,'Medium',1,0,'2007-04-27 14:32:16',NULL,0),
 (217,4,NULL,20,'Feed cage MED2','','feed',2,'Medium',1,0,'2007-04-27 14:32:16',NULL,0),
 (218,5,NULL,20,'Feed cage MED2','','feed',2,'Medium',1,0,'2007-04-27 14:32:16',NULL,0),
 (219,6,NULL,20,'Feed cage MED2','','feed',2,'Medium',1,0,'2007-04-27 14:32:16',NULL,0),
 (220,7,NULL,20,'Feed cage MED2','','feed',2,'Medium',1,0,'2007-04-27 14:32:16',NULL,0),
 (228,2,5,NULL,'Do 0.15 cc Bactrim','','medical',NULL,NULL,NULL,0,'2007-05-07 10:51:27','2007-05-07 11:12:05',0),
 (229,2,5,NULL,'Do 0.15 cc Bactrim','','medical',NULL,NULL,NULL,0,'2007-05-07 10:51:56','2007-05-07 11:12:03',0);
INSERT INTO `tasks` (`id`,`repeat_code`,`medical_treatment_id`,`cage_id`,`title`,`notes`,`internal_description`,`food`,`dish_type`,`dish_num`,`jitter`,`date_started`,`date_ended`,`animal_care`) VALUES 
 (230,2,5,NULL,'Do 0.15 cc Bactrim','','medical',NULL,NULL,NULL,0,'2007-05-07 11:02:39','2007-05-07 11:12:01',0),
 (231,2,5,NULL,'Do 0.15 cc Bactrim','','medical',NULL,NULL,NULL,0,'2007-05-07 11:12:09','2007-05-07 11:49:24',0),
 (232,3,5,NULL,'Do 0.15 cc Bactrim','','medical',NULL,NULL,NULL,0,'2007-05-07 11:12:09','2007-05-07 11:49:22',0),
 (233,4,5,NULL,'Do 0.15 cc Bactrim','','medical',NULL,NULL,NULL,0,'2007-05-07 11:12:09','2007-05-07 11:49:21',0),
 (234,5,5,NULL,'Do 0.15 cc Bactrim','','medical',NULL,NULL,NULL,0,'2007-05-07 11:12:09','2007-05-07 11:49:20',0),
 (235,7,6,NULL,'Do observations','','medical',NULL,NULL,NULL,0,'2007-05-07 11:31:15',NULL,0),
 (236,1,6,NULL,'Do observations','','medical',NULL,NULL,NULL,0,'2007-05-07 11:38:28',NULL,0),
 (237,2,6,NULL,'Do observations','','medical',NULL,NULL,NULL,0,'2007-05-07 11:38:28',NULL,0),
 (238,3,6,NULL,'Do observations','','medical',NULL,NULL,NULL,0,'2007-05-07 11:38:28',NULL,0);
INSERT INTO `tasks` (`id`,`repeat_code`,`medical_treatment_id`,`cage_id`,`title`,`notes`,`internal_description`,`food`,`dish_type`,`dish_num`,`jitter`,`date_started`,`date_ended`,`animal_care`) VALUES 
 (239,4,6,NULL,'Do observations','','medical',NULL,NULL,NULL,0,'2007-05-07 11:38:28',NULL,0),
 (240,5,6,NULL,'Do observations','','medical',NULL,NULL,NULL,0,'2007-05-07 11:38:28',NULL,0),
 (241,6,6,NULL,'Do observations','','medical',NULL,NULL,NULL,0,'2007-05-07 11:38:28',NULL,0),
 (242,2,5,NULL,'Do 0.15 cc Bactrim','','medical',NULL,NULL,NULL,0,'2007-05-07 11:49:29',NULL,0);
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
 (1,1),
 (1,2),
 (1,3),
 (1,4),
 (1,5),
 (1,6),
 (1,7),
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
 (1,27),
 (1,28),
 (1,29),
 (1,30),
 (1,31),
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
 (1,42),
 (1,43),
 (1,44),
 (1,45),
 (1,46),
 (1,47),
 (1,48),
 (1,49),
 (1,50),
 (1,51),
 (1,52),
 (1,53),
 (1,54),
 (1,55),
 (1,56),
 (1,57),
 (1,58),
 (1,59),
 (1,60),
 (1,61),
 (1,62),
 (1,63),
 (1,64),
 (1,65),
 (1,66),
 (1,67),
 (1,68),
 (1,69),
 (1,70),
 (1,71),
 (1,72),
 (1,73),
 (1,74),
 (1,75),
 (1,76),
 (1,77),
 (1,78),
 (1,79),
 (1,80),
 (1,81),
 (1,82),
 (1,83),
 (1,84),
 (1,85),
 (1,86),
 (1,87),
 (1,88),
 (1,89),
 (1,90),
 (1,91),
 (1,92),
 (1,93),
 (1,94),
 (1,95),
 (1,96),
 (1,97),
 (1,98),
 (1,99),
 (1,100),
 (1,200),
 (1,201),
 (1,202),
 (1,203),
 (1,204),
 (1,205),
 (1,206),
 (1,214);
INSERT INTO `tasks_users` (`user_id`,`task_id`) VALUES 
 (1,215),
 (1,216),
 (1,217),
 (1,218),
 (1,219),
 (1,220),
 (2,212),
 (2,213),
 (3,1),
 (3,2),
 (3,3),
 (3,4),
 (3,5),
 (3,6),
 (3,7),
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
 (3,27),
 (3,28),
 (3,29),
 (3,30),
 (3,31),
 (3,32),
 (3,33),
 (3,34),
 (3,35),
 (3,36),
 (3,37),
 (3,38),
 (3,39),
 (3,40),
 (3,41),
 (3,42),
 (3,43),
 (3,44),
 (3,45),
 (3,46),
 (3,47),
 (3,48),
 (3,49),
 (3,50),
 (3,51),
 (3,52),
 (3,53),
 (3,54),
 (3,55),
 (3,56),
 (3,57),
 (3,58),
 (3,59),
 (3,60),
 (3,61),
 (3,62),
 (3,63),
 (3,64),
 (3,65),
 (3,66),
 (3,67),
 (3,68),
 (3,69),
 (3,70),
 (3,71),
 (3,72),
 (3,73),
 (3,74),
 (3,75),
 (3,76),
 (3,77),
 (3,78),
 (3,79),
 (3,80),
 (3,81),
 (3,82),
 (3,83),
 (3,84),
 (3,85),
 (3,86),
 (3,87),
 (3,88),
 (3,89),
 (3,90),
 (3,91),
 (3,92),
 (3,93),
 (3,94),
 (3,95),
 (3,96),
 (3,97),
 (3,98),
 (3,99),
 (3,100);
INSERT INTO `tasks_users` (`user_id`,`task_id`) VALUES 
 (3,190),
 (3,191),
 (3,200),
 (3,201),
 (3,202),
 (3,203),
 (3,204),
 (3,205),
 (3,206),
 (3,214),
 (3,215),
 (3,216),
 (3,217),
 (3,218),
 (3,219),
 (3,220),
 (5,141),
 (5,192),
 (5,197),
 (5,209),
 (6,8),
 (6,9),
 (6,151),
 (6,152),
 (6,207),
 (6,208),
 (6,221),
 (6,222),
 (6,223),
 (6,224),
 (6,225),
 (6,226),
 (6,227),
 (6,228),
 (6,229),
 (6,230),
 (6,231),
 (6,232),
 (6,233),
 (6,234),
 (6,236),
 (6,237),
 (6,238),
 (6,239),
 (6,240),
 (6,241),
 (6,242),
 (8,101),
 (8,102),
 (8,103),
 (8,104),
 (8,105),
 (8,106),
 (8,107),
 (8,108),
 (8,109),
 (8,110),
 (8,111),
 (8,112),
 (8,113),
 (8,114),
 (8,155),
 (8,156),
 (8,160),
 (8,161),
 (8,162),
 (8,163),
 (8,164),
 (8,165),
 (8,166),
 (8,167),
 (8,168),
 (8,169),
 (9,157),
 (9,158),
 (9,159),
 (9,175),
 (9,176),
 (9,177),
 (9,178),
 (9,179),
 (9,180),
 (9,181),
 (9,182),
 (9,183),
 (9,184),
 (9,185),
 (9,186),
 (9,187),
 (9,188),
 (9,189),
 (10,115),
 (10,116),
 (10,117),
 (10,118),
 (10,119);
INSERT INTO `tasks_users` (`user_id`,`task_id`) VALUES 
 (10,120),
 (10,121),
 (10,154),
 (10,170),
 (10,171),
 (10,172),
 (10,173),
 (10,174),
 (11,143),
 (11,144),
 (11,146),
 (11,148),
 (11,150),
 (11,193),
 (11,196),
 (12,235),
 (14,122),
 (14,123),
 (14,124),
 (14,125),
 (14,126),
 (14,127),
 (14,128),
 (14,129),
 (14,130),
 (14,131),
 (14,132),
 (14,133),
 (14,134),
 (14,135),
 (14,136),
 (14,137),
 (14,138),
 (14,139),
 (14,140),
 (14,142),
 (14,145),
 (14,147),
 (14,149),
 (14,153),
 (14,194),
 (14,195),
 (14,198),
 (14,199),
 (14,210),
 (14,211);
/*!40000 ALTER TABLE `tasks_users` ENABLE KEYS */;


--
-- Definition of table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `initials` varchar(45) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime DEFAULT NULL,
  `job_type` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`,`name`,`initials`,`email`,`start_date`,`end_date`,`job_type`) VALUES 
 (1,'Vanessa Reed','VR','nessareed@mindspring.com','2007-04-24 00:00:00',NULL,'Animal Care'),
 (2,'General Medical Care','GMC','','2007-04-24 00:00:00','2007-05-21 00:00:00',''),
 (3,'Krystal Medley','KM','klmedley@hotmail.com','2007-04-24 00:00:00',NULL,'Weekend Care'),
 (4,'Amaya Perez Cruz','APC','amaya.eneko@gmail.com','2007-04-24 00:00:00','2007-04-24 00:00:00',NULL),
 (5,'Amaya Perez','AP','perez@psyc.umd.edu','2007-04-24 00:00:00',NULL,'Medical Care'),
 (6,'Ben Falk','BF','falk.ben@gmail.com','2007-04-24 00:00:00',NULL,'Medical Care'),
 (7,'Murat Aytekin','MA','aytekin@wam.umd.edu','2007-04-25 00:00:00',NULL,NULL),
 (8,'Gordon Gifford','GG','ggifford@umd.edu','2007-04-25 00:00:00',NULL,NULL),
 (9,'Genevieve Spanjer Wright','GSW','gspanjer@umd.edu','2007-04-25 00:00:00',NULL,''),
 (10,'Mohit Chadha','MC','mchadha@psyc.umd.edu','2007-04-27 00:00:00',NULL,NULL),
 (11,'Wei Xian','WX','wxian@psyc.umd.edu','2007-04-27 00:00:00',NULL,NULL),
 (12,'Chen Chiu','CC','chiuc@wam.umd.edu','2007-04-27 00:00:00',NULL,NULL);
INSERT INTO `users` (`id`,`name`,`initials`,`email`,`start_date`,`end_date`,`job_type`) VALUES 
 (13,'Kaushik Ghose','KG','kghose@umd.edu','2007-04-27 00:00:00',NULL,NULL),
 (14,'Samantha McIlwain','SM','smcilwai@umd.edu','2007-04-27 00:00:00',NULL,'Medical Care'),
 (16,'Cynthia F. Moss','CFM','cmoss@psyc.umd.edu','2007-04-27 00:00:00',NULL,NULL),
 (18,'Joe','J','s','2007-05-18 00:00:00','2007-05-21 00:00:00','');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;


--
-- Definition of table `weathers`
--

DROP TABLE IF EXISTS `weathers`;
CREATE TABLE `weathers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `log_date` date NOT NULL,
  `temperature` float NOT NULL,
  `humidity` float NOT NULL,
  `room_id` int(10) unsigned NOT NULL,
  `sig` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `weathers`
--

/*!40000 ALTER TABLE `weathers` DISABLE KEYS */;
INSERT INTO `weathers` (`id`,`log_date`,`temperature`,`humidity`,`room_id`,`sig`) VALUES 
 (1,'2007-04-27',78.3,49,3,'BF');
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
  `task_history_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `weights`
--

/*!40000 ALTER TABLE `weights` DISABLE KEYS */;
INSERT INTO `weights` (`id`,`bat_id`,`date`,`weight`,`note`,`after_eating`,`user_id`,`task_history_id`) VALUES 
 (1,1,'2007-04-25 13:15:48',19,'','y',6,NULL),
 (2,1,'2007-04-25 13:16:22',19,'','n',6,NULL),
 (3,59,'2007-04-27 14:10:42',6.4,'right arm swollen due to band being too tight. Removed band and applied topical antibiotic.','n',5,NULL),
 (4,59,'2007-04-27 14:14:02',6.4,'','n',5,NULL),
 (5,4,'2007-05-07 11:51:00',15,'','n',6,6),
 (6,4,'2007-05-07 11:58:00',12,'','n',6,7);
/*!40000 ALTER TABLE `weights` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
