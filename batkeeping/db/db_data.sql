-- MySQL dump 10.10
--
-- Host: localhost    Database: batkeeping
-- ------------------------------------------------------
-- Server version	5.0.17-nt

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
-- Table structure for table `bat_notes`
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
LOCK TABLES `bat_notes` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `bat_notes` ENABLE KEYS */;

--
-- Table structure for table `bats`
--

DROP TABLE IF EXISTS `bats`;
CREATE TABLE `bats` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `cage_id` int(10) unsigned NOT NULL,
  `collection_date` datetime NOT NULL,
  `collection_age` varchar(45) NOT NULL COMMENT 'juvenile/adult',
  `collection_place` varchar(100) NOT NULL,
  `species` varchar(45) NOT NULL,
  `gender` varchar(1) NOT NULL COMMENT 'm/f',
  `leave_date` datetime default NULL COMMENT 'y/n - in lab or not',
  `leave_reason` varchar(12) default NULL COMMENT 'death/exported',
  `band` varchar(10) default NULL,
  `user_id` int(10) unsigned default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `bats`
--


/*!40000 ALTER TABLE `bats` DISABLE KEYS */;
LOCK TABLES `bats` WRITE;
INSERT INTO `bats` VALUES (1,1,'2006-01-05 00:00:00','Adult','Ben\'s Attic','Eptesicus fuscus','F',NULL,NULL,'A1',NULL),(2,1,'2006-01-05 00:00:00','Juvenile','Underneath the Sycamore Tree','Eptesicus fuscus','M',NULL,NULL,'A2',NULL),(3,1,'2006-03-05 00:00:00','Adult','Heaven','Eptesicus fuscus','M',NULL,NULL,'B1',NULL),(4,3,'2006-04-05 00:00:00','Juvenile','Hell','Eptesicus fuscus','M',NULL,NULL,'C1',NULL),(5,1,'2006-06-05 00:00:00','Juvenile','Murat\'s Hair','Carollia perspicillata','M',NULL,NULL,'D1',NULL),(6,3,'2006-04-05 00:00:00','Juvenile','Panda Cafe','Myotis septentrionalis','M',NULL,NULL,'E1',NULL),(7,1,'2006-03-05 00:00:00','Adult','Sam Spade\'s Office','Carollia perspicillata','F',NULL,NULL,'F1',NULL);
UNLOCK TABLES;
/*!40000 ALTER TABLE `bats` ENABLE KEYS */;

--
-- Table structure for table `cage_in_histories`
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
LOCK TABLES `cage_in_histories` WRITE;
INSERT INTO `cage_in_histories` VALUES (1,1,1,'2006-12-05 18:44:03',1,NULL),(2,2,1,'2006-12-05 18:45:05',1,NULL),(3,3,1,'2006-12-05 18:48:42',1,NULL),(4,4,1,'2006-12-05 18:49:02',1,NULL),(5,5,1,'2006-12-05 18:49:37',1,NULL),(6,6,3,'2006-12-05 18:50:36',1,NULL),(7,7,1,'2006-12-05 18:51:54',1,NULL),(8,4,3,'2006-12-05 18:52:55',1,NULL);
UNLOCK TABLES;
/*!40000 ALTER TABLE `cage_in_histories` ENABLE KEYS */;

--
-- Table structure for table `cage_out_histories`
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
LOCK TABLES `cage_out_histories` WRITE;
INSERT INTO `cage_out_histories` VALUES (1,4,1,'2006-12-05 18:52:55',1,NULL,4);
UNLOCK TABLES;
/*!40000 ALTER TABLE `cage_out_histories` ENABLE KEYS */;

--
-- Table structure for table `cages`
--

DROP TABLE IF EXISTS `cages`;
CREATE TABLE `cages` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(45) NOT NULL,
  `date_created` datetime NOT NULL,
  `date_destroyed` datetime default NULL,
  `user_id` int(10) unsigned default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `cages`
--


/*!40000 ALTER TABLE `cages` DISABLE KEYS */;
LOCK TABLES `cages` WRITE;
INSERT INTO `cages` VALUES (1,'Cage1','2006-01-05 00:00:00',NULL,NULL),(2,'Cage2','2006-02-05 00:00:00','2006-10-05 00:00:00',NULL),(3,'Cage3','2006-03-05 00:00:00',NULL,NULL),(4,'Cage4','2006-04-05 00:00:00',NULL,NULL);
UNLOCK TABLES;
/*!40000 ALTER TABLE `cages` ENABLE KEYS */;

--
-- Table structure for table `medical_care_actions`
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
LOCK TABLES `medical_care_actions` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `medical_care_actions` ENABLE KEYS */;

--
-- Table structure for table `medical_problems`
--

DROP TABLE IF EXISTS `medical_problems`;
CREATE TABLE `medical_problems` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `bat_id` int(10) unsigned NOT NULL,
  `date_opened` datetime NOT NULL,
  `description` text NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `date_closed` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `medical_problems`
--


/*!40000 ALTER TABLE `medical_problems` DISABLE KEYS */;
LOCK TABLES `medical_problems` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `medical_problems` ENABLE KEYS */;

--
-- Table structure for table `proposed_treatments`
--

DROP TABLE IF EXISTS `proposed_treatments`;
CREATE TABLE `proposed_treatments` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `medical_problem_id` int(10) unsigned NOT NULL,
  `date_started` datetime NOT NULL,
  `date_finished` datetime NOT NULL,
  `date_closed` datetime NOT NULL,
  `treatment` text NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `proposed_treatments`
--


/*!40000 ALTER TABLE `proposed_treatments` DISABLE KEYS */;
LOCK TABLES `proposed_treatments` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `proposed_treatments` ENABLE KEYS */;

--
-- Table structure for table `protocol_end_histories`
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
LOCK TABLES `protocol_end_histories` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `protocol_end_histories` ENABLE KEYS */;

--
-- Table structure for table `protocol_start_histories`
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
LOCK TABLES `protocol_start_histories` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `protocol_start_histories` ENABLE KEYS */;

--
-- Table structure for table `protocols`
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
LOCK TABLES `protocols` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `protocols` ENABLE KEYS */;

--
-- Table structure for table `users`
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
LOCK TABLES `users` WRITE;
INSERT INTO `users` VALUES (1,'Conan The Barbarian','CTB','ctb@slash.burn.net','2006-01-01 00:00:00',NULL),(2,'Adam The Apple','','','2006-02-05 00:00:00',NULL),(3,'Greyhound Bus','\"The Bus\"','','2006-03-05 00:00:00',NULL),(4,'Winston Churchill','WC','','2006-04-05 00:00:00','2006-11-05 00:00:00');
UNLOCK TABLES;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

--
-- Table structure for table `weights`
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
LOCK TABLES `weights` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `weights` ENABLE KEYS */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

