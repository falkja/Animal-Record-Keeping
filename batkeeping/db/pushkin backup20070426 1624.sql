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
  `note` text,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `bats`
--

/*!40000 ALTER TABLE `bats` DISABLE KEYS */;
INSERT INTO `bats` (`id`,`cage_id`,`collection_date`,`collection_age`,`collection_place`,`species`,`gender`,`leave_date`,`leave_reason`,`band`,`user_id`,`note`) VALUES 
 (1,1,'2005-07-07 00:00:00','Adult','Maryland','Eptesicus fuscus','M',NULL,NULL,'G39',NULL,'<tr><td>Ben\'s bat - catches mealworms and discriminates groove beads</td><td>BF</td><td>Apr 25, 2007</td></tr>'),
 (2,3,'2005-08-01 00:00:00','Juvenile','Oxon Hill, MD','Eptesicus fuscus','F',NULL,NULL,'GR27',NULL,NULL),
 (3,4,'2005-08-01 00:00:00','Juvenile','Oxon Hill, MD','Eptesicus fuscus','M',NULL,NULL,'GR30',NULL,NULL),
 (4,7,'2005-08-01 00:00:00','Juvenile','Oxon Hill, MD','Eptesicus fuscus','M',NULL,NULL,'GR37',NULL,NULL),
 (5,2,'2005-09-01 00:00:00','Juvenile','Clinton, MD','Eptesicus fuscus','M',NULL,NULL,'GR41',NULL,NULL);
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
 (1,1,1,'2007-04-25 13:11:39',6,'new bat'),
 (2,1,2,'2007-04-25 13:16:22',6,''),
 (3,1,1,'2007-04-25 17:11:01',6,''),
 (4,2,3,'2007-04-25 17:59:56',5,'new bat'),
 (5,3,4,'2007-04-25 18:22:04',5,'new bat'),
 (6,4,7,'2007-04-25 18:23:16',5,'new bat'),
 (7,5,2,'2007-04-25 18:24:06',5,'new bat');
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
 (1,1,1,'2007-04-25 13:16:22',6,'',1),
 (2,1,2,'2007-04-25 17:11:01',6,'',2);
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
 (1,'BF','2007-04-24 00:00:00',NULL,6,2),
 (2,'Thin','2007-04-25 00:00:00',NULL,1,2),
 (3,'NP','2007-04-25 00:00:00',NULL,1,2),
 (4,'THIN2','2007-04-25 00:00:00',NULL,1,2),
 (5,'THIN4','2007-04-25 00:00:00',NULL,1,2),
 (6,'NP2','2007-04-25 00:00:00',NULL,1,2),
 (7,'MED','2007-04-25 00:00:00',NULL,1,2),
 (8,'MA2','2007-04-25 00:00:00',NULL,7,2),
 (9,'SURGERY2','2007-04-25 00:00:00',NULL,8,2),
 (10,'SURGERY3','2007-04-25 00:00:00',NULL,8,2),
 (11,'RECOVERY','2007-04-25 00:00:00',NULL,1,2),
 (12,'FLIGHT','2007-04-25 00:00:00',NULL,1,2),
 (13,'FLIGHT TEMP','2007-04-25 00:00:00',NULL,1,2),
 (14,'GS1','2007-04-25 00:00:00',NULL,9,2),
 (15,'GS2','2007-04-25 00:00:00',NULL,9,2),
 (16,'GS3','2007-04-25 00:00:00',NULL,9,2);
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
 (1,8,'2007-04-25',2,'G39 GR27 GR30 GR30 GR37 GR37 GR41 GR41 ',NULL);
/*!40000 ALTER TABLE `census` ENABLE KEYS */;


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
 (1,'Fruit Bats (4148L)'),
 (2,'Belfry (4102D)'),
 (3,'Colony Room (4100)');
/*!40000 ALTER TABLE `rooms` ENABLE KEYS */;


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
/*!40000 ALTER TABLE `task_histories` ENABLE KEYS */;


--
-- Definition of table `tasks`
--

DROP TABLE IF EXISTS `tasks`;
CREATE TABLE `tasks` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `repeat_code` int(10) unsigned NOT NULL COMMENT '0 means daily 1 = sunday etc.',
  `medical_problem_id` int(10) unsigned default NULL,
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
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tasks`
--

/*!40000 ALTER TABLE `tasks` DISABLE KEYS */;
INSERT INTO `tasks` (`id`,`repeat_code`,`medical_problem_id`,`cage_id`,`title`,`notes`,`internal_description`,`food`,`dish_type`,`dish_num`,`jitter`,`date_started`,`date_ended`) VALUES 
 (1,1,NULL,1,'Feed cage BF','','feed',1.5,'Small',1,0,'2007-04-25 13:12:09',NULL),
 (2,2,NULL,1,'Feed cage BF','','feed',1.5,'Small',1,0,'2007-04-25 13:12:09',NULL),
 (3,3,NULL,1,'Feed cage BF','','feed',1.5,'Small',1,0,'2007-04-25 13:12:09',NULL),
 (4,4,NULL,1,'Feed cage BF','','feed',1.5,'Small',1,0,'2007-04-25 13:12:09',NULL),
 (5,5,NULL,1,'Feed cage BF','','feed',1.5,'Small',1,0,'2007-04-25 13:12:09',NULL),
 (6,6,NULL,1,'Feed cage BF','','feed',1.5,'Small',1,0,'2007-04-25 13:12:09',NULL),
 (7,7,NULL,1,'Feed cage BF','','feed',1.5,'Small',1,0,'2007-04-25 13:12:09',NULL),
 (8,3,NULL,1,'Weigh cage BF','','weigh',NULL,NULL,NULL,-1,'2007-04-25 13:13:35',NULL),
 (9,6,NULL,1,'Weigh cage BF','','weigh',NULL,NULL,NULL,-1,'2007-04-25 13:13:46',NULL);
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
 (1,1),
 (1,2),
 (1,3),
 (1,4),
 (1,5),
 (1,6),
 (1,7),
 (3,1),
 (3,2),
 (3,3),
 (3,4),
 (3,5),
 (3,6),
 (3,7),
 (6,8),
 (6,9);
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
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`,`name`,`initials`,`email`,`start_date`,`end_date`) VALUES 
 (1,'General Animal Care','GAC','','2007-04-24 00:00:00',NULL),
 (2,'General Medical Care','GMC','','2007-04-24 00:00:00',NULL),
 (3,'Weekend Care','WC','','2007-04-24 00:00:00',NULL),
 (4,'Amaya Perez Cruz','APC','amaya.eneko@gmail.com','2007-04-24 00:00:00','2007-04-24 00:00:00'),
 (5,'Amaya Perez','AP','perez@psyc.umd.edu','2007-04-24 00:00:00',NULL),
 (6,'Ben Falk','BF','falk.ben@gmail.com','2007-04-24 00:00:00',NULL),
 (7,'Murat Aytekin','MA','aytekin@wam.umd.edu','2007-04-25 00:00:00',NULL),
 (8,'Gordon Gifford','GG','ggifford@psyc.umd.edu','2007-04-25 00:00:00',NULL),
 (9,'Genevieve Spanjer Wright','GSW','gspanjer@umd.edu','2007-04-25 00:00:00',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;


--
-- Definition of table `weathers`
--

DROP TABLE IF EXISTS `weathers`;
CREATE TABLE `weathers` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `log_date` datetime NOT NULL,
  `temperature` float NOT NULL,
  `humidity` float NOT NULL,
  `room` varchar(45) NOT NULL,
  `sig` varchar(45) NOT NULL,
  PRIMARY KEY  (`id`)
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
 (1,1,'2007-04-25 13:15:48',19,'','y',6,NULL),
 (2,1,'2007-04-25 13:16:22',19,'','n',6,NULL);
/*!40000 ALTER TABLE `weights` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
