-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.0.27-community-nt


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
  `species` varchar(45) NOT NULL,
  `gender` varchar(1) NOT NULL COMMENT 'm/f',
  `leave_date` datetime default NULL COMMENT 'y/n - in lab or not',
  `leave_reason` text COMMENT 'death/exported',
  `band` varchar(10) default NULL,
  `user_id` int(10) unsigned default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `bats`
--

/*!40000 ALTER TABLE `bats` DISABLE KEYS */;
INSERT INTO `bats` (`id`,`cage_id`,`collection_date`,`collection_age`,`collection_place`,`species`,`gender`,`leave_date`,`leave_reason`,`band`,`user_id`) VALUES 
 (1,NULL,'2006-01-05 00:00:00','Adult','Ben\'s Attic','Eptesicus fuscus','F','2006-12-14 00:00:00','Dezomb','A1',NULL),
 (2,4,'2006-01-05 00:00:00','Juvenile','Underneath the Sycamore Tree','Eptesicus fuscus','M',NULL,NULL,'A2',NULL),
 (3,3,'2006-03-05 00:00:00','Adult','Heaven','Eptesicus fuscus','M',NULL,NULL,'B1',NULL),
 (4,4,'2006-04-05 00:00:00','Juvenile','Hell','Eptesicus fuscus','M',NULL,NULL,'C1',NULL),
 (5,4,'2006-06-05 00:00:00','Juvenile','Murat\'s Hair','Carollia perspicillata','M',NULL,NULL,'D1',NULL),
 (6,3,'2006-04-05 00:00:00','Juvenile','Panda Cafe','Myotis septentrionalis','M',NULL,NULL,'E1',NULL),
 (7,1,'2006-03-05 00:00:00','Adult','Sam Spade\'s Office','Carollia perspicillata','F',NULL,NULL,'F1',NULL);
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
 (1,1,1,'2006-12-05 18:44:03',1,NULL),
 (2,2,1,'2006-12-05 18:45:05',1,NULL),
 (3,3,1,'2006-12-05 18:48:42',1,NULL),
 (4,4,1,'2006-12-05 18:49:02',1,NULL),
 (5,5,1,'2006-12-05 18:49:37',1,NULL),
 (6,6,3,'2006-12-05 18:50:36',1,NULL),
 (7,7,1,'2006-12-05 18:51:54',1,NULL),
 (8,4,3,'2006-12-05 18:52:55',1,NULL),
 (9,1,4,'2006-12-07 22:18:55',2,NULL),
 (10,7,4,'2006-12-07 22:18:55',2,NULL),
 (11,1,1,'2006-12-07 22:32:14',2,NULL),
 (26,4,3,'2006-12-07 23:48:36',2,NULL),
 (27,6,1,'2006-12-07 23:57:45',2,NULL),
 (28,2,1,'2006-12-07 23:58:31',2,NULL),
 (29,2,2,'2006-12-08 00:10:27',2,NULL),
 (30,2,3,'2006-12-08 00:13:04',2,NULL),
 (31,1,4,'2006-12-08 16:20:13',2,NULL),
 (32,2,4,'2006-12-08 16:20:13',2,NULL),
 (33,3,4,'2006-12-08 16:20:13',2,NULL),
 (34,4,4,'2006-12-08 16:20:13',2,NULL),
 (35,1,3,'2006-12-08 16:53:49',2,NULL),
 (36,3,3,'2006-12-08 16:56:44',2,NULL),
 (37,6,3,'2006-12-13 14:18:37',2,NULL),
 (41,1,4,'2006-12-14 17:38:34',2,NULL);
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
 (1,4,1,'2006-12-05 18:52:55',1,NULL,4),
 (2,1,1,'2006-12-07 22:18:55',2,NULL,1),
 (3,7,1,'2006-12-07 22:18:55',2,NULL,7),
 (4,1,4,'2006-12-07 22:32:14',1,NULL,9),
 (19,4,1,'2006-12-07 23:48:36',2,'Hi!',8),
 (20,6,3,'2006-12-07 23:57:45',2,'Because',6),
 (21,2,3,'2006-12-07 23:58:31',2,'Why Not?',2),
 (22,2,1,'2006-12-08 00:10:27',2,'Wanted to, sue me',28),
 (23,2,2,'2006-12-08 00:13:04',2,'Because',29),
 (24,1,3,'2006-12-08 16:20:13',2,'Because',11),
 (25,2,3,'2006-12-08 16:20:13',2,'',30),
 (26,3,3,'2006-12-08 16:20:13',2,'',3),
 (27,4,3,'2006-12-08 16:20:13',2,'',26),
 (28,1,4,'2006-12-08 16:53:49',2,'sue me!!!!',31),
 (29,3,4,'2006-12-08 16:56:44',2,'HEAVY!!!',33),
 (30,6,1,'2006-12-13 14:18:37',2,'Just because',27),
 (31,1,3,'2006-12-14 16:46:36',2,'',35),
 (34,1,1,'2006-12-14 17:37:30',2,'Broke curfew',35),
 (35,1,4,'2006-12-14 17:39:13',2,'Dezomb',41);
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
  `food` float NOT NULL COMMENT 'food in grams',
  `fed_by` varchar(45) NOT NULL COMMENT 'fed by "investigator" or "animal care"',
  `species` varchar(45) NOT NULL COMMENT 'species of bat',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `cages`
--

/*!40000 ALTER TABLE `cages` DISABLE KEYS */;
INSERT INTO `cages` (`id`,`name`,`date_created`,`date_destroyed`,`user_id`,`food`,`fed_by`,`species`) VALUES 
 (1,'Cage1','2006-01-05 00:00:00',NULL,1,20,'Animal Care',''),
 (2,'Cage2','2006-02-05 00:00:00','2006-10-05 00:00:00',NULL,0,'',''),
 (3,'Cage3','2006-03-05 00:00:00',NULL,2,100,'Animal Care',''),
 (4,'Cage4','2006-04-05 00:00:00',NULL,3,0,'Investigator','');
/*!40000 ALTER TABLE `cages` ENABLE KEYS */;


--
-- Definition of table `medical_care_actions`
--

DROP TABLE IF EXISTS `medical_care_actions`;
CREATE TABLE `medical_care_actions` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `proposed_treatment_id` int(10) unsigned NOT NULL,
  `date` datetime NOT NULL,
  `medicine` varchar(45) NOT NULL,
  `dosage` varchar(45) NOT NULL,
  `remarks` text NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`id`)
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
  `id` int(10) unsigned NOT NULL auto_increment,
  `bat_id` int(10) unsigned NOT NULL,
  `date_opened` datetime NOT NULL,
  `description` text NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `date_closed` datetime default NULL,
  `title` varchar(45) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `medical_problems`
--

/*!40000 ALTER TABLE `medical_problems` DISABLE KEYS */;
INSERT INTO `medical_problems` (`id`,`bat_id`,`date_opened`,`description`,`user_id`,`date_closed`,`title`) VALUES 
 (1,1,'2006-12-13 00:00:00','Obese',2,'2006-12-13 00:00:00',''),
 (2,5,'2006-12-13 00:00:00','Large head',2,NULL,'');
/*!40000 ALTER TABLE `medical_problems` ENABLE KEYS */;


--
-- Definition of table `proposed_treatments`
--

DROP TABLE IF EXISTS `proposed_treatments`;
CREATE TABLE `proposed_treatments` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `medical_problem_id` int(10) unsigned NOT NULL,
  `date_started` datetime NOT NULL,
  `date_finished` datetime NOT NULL,
  `date_closed` datetime default NULL,
  `treatment` text NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `proposed_treatments`
--

/*!40000 ALTER TABLE `proposed_treatments` DISABLE KEYS */;
INSERT INTO `proposed_treatments` (`id`,`medical_problem_id`,`date_started`,`date_finished`,`date_closed`,`treatment`,`user_id`) VALUES 
 (1,1,'2006-12-13 12:56:22','2006-12-18 12:56:22','2006-12-13 13:57:06','lots of exercise',2),
 (2,2,'2006-12-13 13:25:49','2006-12-20 00:00:00',NULL,'Let out hot air',2);
/*!40000 ALTER TABLE `proposed_treatments` ENABLE KEYS */;


--
-- Definition of table `protocol_end_histories`
--

DROP TABLE IF EXISTS `protocol_end_histories`;
CREATE TABLE `protocol_end_histories` (
  `id` int(10) unsigned NOT NULL default '0',
  `bat_id` int(10) unsigned NOT NULL,
  `protocol_id` int(10) unsigned NOT NULL,
  `date` datetime default NULL,
  `user_id` int(10) unsigned default NULL,
  `protocol_start_history_id` int(10) unsigned default NULL
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
  `id` int(10) unsigned NOT NULL auto_increment,
  `bat_id` int(10) unsigned NOT NULL,
  `protocol_id` int(10) unsigned NOT NULL,
  `date` datetime default NULL,
  `user_id` int(10) unsigned default NULL,
  PRIMARY KEY  (`id`)
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
  `id` int(10) unsigned NOT NULL auto_increment,
  `number` varchar(45) NOT NULL,
  `text` text NOT NULL,
  `start_date` datetime NOT NULL,
  `renewal_A_date` datetime default NULL,
  `renewal_B_date` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `protocols`
--

/*!40000 ALTER TABLE `protocols` DISABLE KEYS */;
/*!40000 ALTER TABLE `protocols` ENABLE KEYS */;


--
-- Definition of table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(100) NOT NULL,
  `initials` varchar(45) NOT NULL,
  `email` varchar(100) NOT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`,`name`,`initials`,`email`,`start_date`,`end_date`) VALUES 
 (1,'Conan The Barbarian','CTB','ctb@slash.burn.net','2006-01-01 00:00:00',NULL),
 (2,'Adam The Apple','AA','','2006-02-05 00:00:00',NULL),
 (3,'Greyhound Bus','\"The Bus\"','','2006-03-05 00:00:00',NULL),
 (4,'Winston Churchill','WC','','2006-04-05 00:00:00','2006-11-05 00:00:00');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;


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
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `weights`
--

/*!40000 ALTER TABLE `weights` DISABLE KEYS */;
INSERT INTO `weights` (`id`,`bat_id`,`date`,`weight`,`note`,`after_eating`,`user_id`) VALUES 
 (1,1,'2006-12-07 19:10:20',10,'','',2),
 (2,2,'2006-12-07 19:10:20',20,'','',2),
 (3,3,'2006-12-07 19:10:20',30,'','',2),
 (4,5,'2006-12-07 19:10:21',40,'','',2),
 (5,7,'2006-12-07 19:10:21',50,'','',2),
 (6,4,'2006-12-07 19:26:30',0,'','',2),
 (7,6,'2006-12-07 19:26:30',0,'','',2),
 (8,4,'2006-12-07 19:28:23',20,'Good weight','',2),
 (9,6,'2006-12-07 19:28:23',40,'Porker! Go on diet Now!','',2),
 (10,1,'2006-12-08 16:16:53',10,'','',2),
 (11,2,'2006-12-08 16:16:54',20,'','',2),
 (12,3,'2006-12-08 16:16:54',30,'','',2),
 (13,4,'2006-12-08 16:16:54',40,'','',2),
 (14,1,'2006-12-08 16:20:13',40,'','',2),
 (15,2,'2006-12-08 16:20:13',20,'','',2),
 (16,3,'2006-12-08 16:20:13',100,'','',2),
 (17,4,'2006-12-08 16:20:13',20,'','',2),
 (18,1,'2006-12-08 16:53:49',90,'','',2),
 (19,2,'2006-12-08 16:53:49',10,'','',2),
 (20,3,'2006-12-08 16:53:49',100,'Porker!','',2),
 (21,4,'2006-12-08 16:53:49',200,'Problem!','',2),
 (22,5,'2006-12-08 16:53:49',20,'','',2);
INSERT INTO `weights` (`id`,`bat_id`,`date`,`weight`,`note`,`after_eating`,`user_id`) VALUES 
 (23,2,'2006-12-08 16:56:44',30,'Too heavy','',2),
 (24,3,'2006-12-08 16:56:44',34,'','',2),
 (25,4,'2006-12-08 16:56:44',11,'','',2),
 (26,5,'2006-12-08 16:56:44',10,'','',2);
/*!40000 ALTER TABLE `weights` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
