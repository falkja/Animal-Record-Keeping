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
 (1,NULL,'2006-12-15 00:00:00','Juvenile','Ben\'s Beard','Eptesicus fuscus','M','2006-12-15 00:00:00','Flew away','A1',NULL),
 (2,2,'2006-12-15 00:00:00','Adult','Murat\'s Hair','Glossophaga soricina','F',NULL,NULL,'A2',NULL),
 (3,6,'2006-12-15 00:00:00','Juvenile','Kaushik\'s Glasses','Carollia perspicillata','F',NULL,NULL,'A3',NULL),
 (4,2,'2006-12-15 00:00:00','Adult','Chen\'s High Heeled Boots','Myotis septentrionalis','M',NULL,NULL,'A4',NULL),
 (5,3,'2006-12-15 00:00:00','Juvenile','Wei\'s Dumpling','Eptesicus fuscus','M',NULL,NULL,'A5',NULL),
 (6,2,'2006-12-15 00:00:00','Juvenile','Flea Market','Eptesicus fuscus','M',NULL,NULL,'A6',NULL);
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
 (41,5,3,'2006-12-18 15:46:01',1,'');
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
 (36,5,2,'2006-12-18 15:46:01',1,'',40);
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
  `food` float default NULL COMMENT 'food in grams',
  `fed_by` varchar(45) NOT NULL COMMENT 'fed by "investigator" or "animal care"',
  `species` varchar(45) NOT NULL COMMENT 'species of bat',
  `room` varchar(45) NOT NULL COMMENT 'room the cage is housed',
  `dish_type` varchar(45) NOT NULL,
  `dish_num` int(10) unsigned default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `cages`
--

/*!40000 ALTER TABLE `cages` DISABLE KEYS */;
INSERT INTO `cages` (`id`,`name`,`date_created`,`date_destroyed`,`user_id`,`food`,`fed_by`,`species`,`room`,`dish_type`,`dish_num`) VALUES 
 (1,'Cage1','2006-12-15 00:00:00','2006-12-15 00:00:00',NULL,0,'Animal Care','','Belfry (4102F)','',0),
 (2,'Cage2','2006-12-15 00:00:00',NULL,4,5,'Investigator','','Belfry (4102F)','Long',2),
 (3,'Cage3','2006-12-15 00:00:00',NULL,1,10,'Animal Care','','Fruit Bats (4148L)','Metal tray',1),
 (4,'Cage6','2006-12-15 00:00:00',NULL,4,6,'Investigator','','Colony Room (4100)','Medium',4),
 (5,'cage7','2006-12-15 00:00:00',NULL,5,2,'Investigator','','Colony Room (4100)','Medium',1),
 (6,'Cage99','2006-12-16 00:00:00',NULL,5,4,'Investigator','','Belfry (4102F)','Small',3);
/*!40000 ALTER TABLE `cages` ENABLE KEYS */;


--
-- Definition of table `medical_care_actions`
--

DROP TABLE IF EXISTS `medical_care_actions`;
CREATE TABLE `medical_care_actions` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `proposed_treatment_id` int(10) unsigned NOT NULL,
  `date` datetime NOT NULL,
  `remarks` text NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `medical_care_actions`
--

/*!40000 ALTER TABLE `medical_care_actions` DISABLE KEYS */;
INSERT INTO `medical_care_actions` (`id`,`proposed_treatment_id`,`date`,`remarks`,`user_id`) VALUES 
 (1,1,'2006-12-15 21:58:00','Robitussin',1),
 (2,4,'2006-12-15 22:03:00','Gassss',1);
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
  `user_id` int(10) unsigned default NULL,
  `date_closed` datetime default NULL,
  `title` varchar(45) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `medical_problems`
--

/*!40000 ALTER TABLE `medical_problems` DISABLE KEYS */;
INSERT INTO `medical_problems` (`id`,`bat_id`,`date_opened`,`description`,`user_id`,`date_closed`,`title`) VALUES 
 (1,2,'2006-12-15 00:00:00','Bat hobbles, drinks too much and complains when mealworms tread on its foot.',NULL,NULL,'Gout'),
 (2,6,'2006-12-15 00:00:00','Bat refuses to fly with other bats. Mocks investigators and finds flaws with the published literature',1,NULL,'Inflated Ego'),
 (3,4,'2006-12-15 00:00:00','bat sings at a high pitch destroying the glass in other bat\'s cages',NULL,'2006-12-19 00:00:00','High pitched singing'),
 (4,4,'2006-12-15 00:00:00','Bat heckles other bats, steals food and rushes other bats trying to capture worm',1,'2006-12-15 00:00:00','Over competitiveness'),
 (5,2,'2006-12-18 00:00:00','None',NULL,NULL,'Another problem');
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
 (1,1,'2006-12-15 00:00:00','2006-12-20 00:00:00',NULL,'Cough syrup',1),
 (2,2,'2006-12-15 00:00:00','2006-12-15 00:00:00',NULL,'AM - No treatment, this is normal for bats',1),
 (3,3,'2006-12-15 00:00:00','2006-12-20 00:00:00','2006-12-19 00:00:00','Helium - AM',1),
 (4,3,'2006-12-15 00:00:00','2007-12-15 00:00:00','2006-12-19 00:00:00','Helium - PM',1),
 (5,3,'2006-12-16 00:00:00','2006-12-16 00:00:00','2006-12-19 00:00:00','Helium PM',1),
 (8,5,'2006-12-22 00:00:00','2006-12-22 00:00:00',NULL,'test',2),
 (9,2,'2006-12-22 00:00:00','2006-12-22 00:00:00',NULL,'test',2),
 (10,2,'2006-12-22 00:00:00','2006-12-22 00:00:00',NULL,'tes1',2);
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
-- Definition of table `tasks`
--

DROP TABLE IF EXISTS `tasks`;
CREATE TABLE `tasks` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `last_done_date` datetime default NULL,
  `repeat` int(10) unsigned NOT NULL,
  `proposed_treatment_id` int(10) unsigned default NULL,
  `cage_id` int(10) unsigned default NULL,
  `title` varchar(45) NOT NULL,
  `description` varchar(20) NOT NULL,
  `notes` text NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tasks`
--

/*!40000 ALTER TABLE `tasks` DISABLE KEYS */;
INSERT INTO `tasks` (`id`,`last_done_date`,`repeat`,`proposed_treatment_id`,`cage_id`,`title`,`description`,`notes`) VALUES 
 (1,NULL,0,10,NULL,'tes1','','');
/*!40000 ALTER TABLE `tasks` ENABLE KEYS */;


--
-- Definition of table `tasks_users`
--

DROP TABLE IF EXISTS `tasks_users`;
CREATE TABLE `tasks_users` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `user_id` int(10) unsigned NOT NULL,
  `task_id` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tasks_users`
--

/*!40000 ALTER TABLE `tasks_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `tasks_users` ENABLE KEYS */;


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
 (1,'General Animal Care','GAC','','2006-12-23 00:00:00',NULL),
 (2,'General Medical Care','GMC','','2006-12-23 00:00:00',NULL),
 (3,'Weekend/Holiday Care','WC','','2006-12-23 00:00:00',NULL),
 (4,'Attila the Hun','AtH','hun@villagepillage.com','2006-12-23 00:00:00',NULL),
 (5,'Conan the Barbarian','CTB','ctb@slash.burn.net','2006-12-23 00:00:00',NULL);
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
 (35,2,'2006-12-19 09:36:00',14,'','',1);
/*!40000 ALTER TABLE `weights` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
