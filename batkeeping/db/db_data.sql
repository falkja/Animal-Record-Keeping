-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.0.17-nt


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
 (2,3,'2006-12-15 00:00:00','Adult','Murat\'s Hair','Glossophaga soricina','F',NULL,NULL,'A2',NULL),
 (3,3,'2006-12-15 00:00:00','Juvenile','Kaushik\'s Glasses','Carollia perspicillata','F',NULL,NULL,'A3',NULL),
 (4,2,'2006-12-15 00:00:00','Adult','Chen\'s High Heeled Boots','Myotis septentrionalis','M',NULL,NULL,'A4',NULL),
 (5,NULL,'2006-12-15 00:00:00','Juvenile','Wei\'s Dumpling','Eptesicus fuscus','M','2006-12-15 00:00:00','Kidnapped by Ferrets','A5',NULL),
 (6,3,'2006-12-15 00:00:00','Juvenile','Flea Market','Eptesicus fuscus','M',NULL,NULL,'A6',NULL);
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
 (10,6,3,'2006-12-15 21:16:53',1,'Too fiesty');
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
 (6,6,2,'2006-12-15 21:16:53',1,'Too fiesty',9);
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
  `room` varchar(45) NOT NULL COMMENT 'room the cage is housed',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `cages`
--

/*!40000 ALTER TABLE `cages` DISABLE KEYS */;
INSERT INTO `cages` (`id`,`name`,`date_created`,`date_destroyed`,`user_id`,`food`,`fed_by`,`species`,`room`) VALUES 
 (1,'Cage1','2006-12-15 00:00:00','2006-12-15 00:00:00',NULL,0,'Animal Care','','Belfry (4102F)'),
 (2,'Cage2','2006-12-15 00:00:00',NULL,1,0,'Investigator','','Belfry (4102F)'),
 (3,'Cage3','2006-12-15 00:00:00',NULL,NULL,0,'Animal Care','','Fruit Bats (4148L)');
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
 (1,2,'2006-12-15 00:00:00','Bat hobbles, drinks too much and complains when mealworms tread on its foot.',NULL,NULL,'Gout');
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
 (1,'Conan The Barbarian','CTB','ctb@slash.burn.net','2006-12-15 00:00:00',NULL);
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
/*!40000 ALTER TABLE `weights` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
