/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

CREATE DATABASE IF NOT EXISTS `annonymousgrading` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `annonymousgrading`;

CREATE TABLE IF NOT EXISTS `deliverables` (
  `deliverable_id` int(11) NOT NULL DEFAULT nextval(`annonymousgrading`.`pk_deliverables`),
  `title` varchar(40) DEFAULT NULL,
  `description` varchar(248) DEFAULT NULL,
  `project_id` int(11) DEFAULT NULL,
  `deadline` datetime DEFAULT NULL,
  `video_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`deliverable_id`),
  KEY `project_id` (`project_id`),
  KEY `video_id` (`video_id`),
  CONSTRAINT `deliverables_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`project_id`),
  CONSTRAINT `deliverables_ibfk_2` FOREIGN KEY (`video_id`) REFERENCES `videos` (`video_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*!40000 ALTER TABLE `deliverables` DISABLE KEYS */;
INSERT INTO `deliverables` (`deliverable_id`, `title`, `description`, `project_id`, `deadline`, `video_id`) VALUES
	(1001, 'ergd;kjfklsedjbfjsk', 'sefjhgvfhokjhgyftyuiokjhgftyuiokjehgyt678iujhbgyu893ijhfgeyuiwokni', 1010, '2020-06-12 21:00:00', NULL),
	(1002, 'sefuakjlfhsgajkjshvdz', 'sedfsahwisodkjbhaegusizocjdbhfgyesudjc', 1010, '2020-06-12 21:00:00', NULL),
	(1003, 'xdfgkjhgvshjkdlfvgkjhdc', 'sdijgdwplscjhufijklemdjhyue78930-4p5tly,mtgfbvc', 1010, '2020-06-12 21:00:00', NULL),
	(1004, 'jkseaolasjfhcjsbnz', 'wsflaKAJHgbxnclskoeiawuhgbxznkldevbf', 1013, '2020-07-06 21:00:00', 1001),
	(1005, 'New Demo!', 'I will attach here a new demo!', 1016, '2020-05-17 21:00:00', NULL),
	(1006, 'Am terminat proiectul!', 'Sunt foarte fericita ca am terminat acest proiect pe ultima suta de metri si arata atat de bine! ', 1013, '2020-07-06 21:00:00', 1001),
	(1007, 'Alt livrabil!', 'Hai sa testam!', 1022, '2021-02-03 22:00:00', 1002);
/*!40000 ALTER TABLE `deliverables` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `pk_deliverables` (
  `next_not_cached_value` bigint(21) NOT NULL,
  `minimum_value` bigint(21) NOT NULL,
  `maximum_value` bigint(21) NOT NULL,
  `start_value` bigint(21) NOT NULL COMMENT 'start value when sequences is created or value if RESTART is used',
  `increment` bigint(21) NOT NULL COMMENT 'increment value',
  `cache_size` bigint(21) unsigned NOT NULL,
  `cycle_option` tinyint(1) unsigned NOT NULL COMMENT '0 if no cycles are allowed, 1 if the sequence should begin a new cycle when maximum_value is passed',
  `cycle_count` bigint(21) NOT NULL COMMENT 'How many cycles have been done'
) ENGINE=InnoDB SEQUENCE=1;

/*!40000 ALTER TABLE `pk_deliverables` DISABLE KEYS */;
INSERT INTO `pk_deliverables` (`next_not_cached_value`, `minimum_value`, `maximum_value`, `start_value`, `increment`, `cache_size`, `cycle_option`, `cycle_count`) VALUES
	(2001, 1, 9223372036854775806, 1, 1, 1000, 0, 0);
/*!40000 ALTER TABLE `pk_deliverables` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `pk_projects` (
  `next_not_cached_value` bigint(21) NOT NULL,
  `minimum_value` bigint(21) NOT NULL,
  `maximum_value` bigint(21) NOT NULL,
  `start_value` bigint(21) NOT NULL COMMENT 'start value when sequences is created or value if RESTART is used',
  `increment` bigint(21) NOT NULL COMMENT 'increment value',
  `cache_size` bigint(21) unsigned NOT NULL,
  `cycle_option` tinyint(1) unsigned NOT NULL COMMENT '0 if no cycles are allowed, 1 if the sequence should begin a new cycle when maximum_value is passed',
  `cycle_count` bigint(21) NOT NULL COMMENT 'How many cycles have been done'
) ENGINE=InnoDB SEQUENCE=1;

/*!40000 ALTER TABLE `pk_projects` DISABLE KEYS */;
INSERT INTO `pk_projects` (`next_not_cached_value`, `minimum_value`, `maximum_value`, `start_value`, `increment`, `cache_size`, `cycle_option`, `cycle_count`) VALUES
	(2001, 1, 9223372036854775806, 1, 1, 1000, 0, 0);
/*!40000 ALTER TABLE `pk_projects` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `pk_project_deliverable` (
  `next_not_cached_value` bigint(21) NOT NULL,
  `minimum_value` bigint(21) NOT NULL,
  `maximum_value` bigint(21) NOT NULL,
  `start_value` bigint(21) NOT NULL COMMENT 'start value when sequences is created or value if RESTART is used',
  `increment` bigint(21) NOT NULL COMMENT 'increment value',
  `cache_size` bigint(21) unsigned NOT NULL,
  `cycle_option` tinyint(1) unsigned NOT NULL COMMENT '0 if no cycles are allowed, 1 if the sequence should begin a new cycle when maximum_value is passed',
  `cycle_count` bigint(21) NOT NULL COMMENT 'How many cycles have been done'
) ENGINE=InnoDB SEQUENCE=1;

/*!40000 ALTER TABLE `pk_project_deliverable` DISABLE KEYS */;
INSERT INTO `pk_project_deliverable` (`next_not_cached_value`, `minimum_value`, `maximum_value`, `start_value`, `increment`, `cache_size`, `cycle_option`, `cycle_count`) VALUES
	(2001, 1, 9223372036854775806, 1, 1, 1000, 0, 0);
/*!40000 ALTER TABLE `pk_project_deliverable` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `pk_project_member` (
  `next_not_cached_value` bigint(21) NOT NULL,
  `minimum_value` bigint(21) NOT NULL,
  `maximum_value` bigint(21) NOT NULL,
  `start_value` bigint(21) NOT NULL COMMENT 'start value when sequences is created or value if RESTART is used',
  `increment` bigint(21) NOT NULL COMMENT 'increment value',
  `cache_size` bigint(21) unsigned NOT NULL,
  `cycle_option` tinyint(1) unsigned NOT NULL COMMENT '0 if no cycles are allowed, 1 if the sequence should begin a new cycle when maximum_value is passed',
  `cycle_count` bigint(21) NOT NULL COMMENT 'How many cycles have been done'
) ENGINE=InnoDB SEQUENCE=1;

/*!40000 ALTER TABLE `pk_project_member` DISABLE KEYS */;
INSERT INTO `pk_project_member` (`next_not_cached_value`, `minimum_value`, `maximum_value`, `start_value`, `increment`, `cache_size`, `cycle_option`, `cycle_count`) VALUES
	(2001, 1, 9223372036854775806, 1, 1, 1000, 0, 0);
/*!40000 ALTER TABLE `pk_project_member` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `pk_project_reviews` (
  `next_not_cached_value` bigint(21) NOT NULL,
  `minimum_value` bigint(21) NOT NULL,
  `maximum_value` bigint(21) NOT NULL,
  `start_value` bigint(21) NOT NULL COMMENT 'start value when sequences is created or value if RESTART is used',
  `increment` bigint(21) NOT NULL COMMENT 'increment value',
  `cache_size` bigint(21) unsigned NOT NULL,
  `cycle_option` tinyint(1) unsigned NOT NULL COMMENT '0 if no cycles are allowed, 1 if the sequence should begin a new cycle when maximum_value is passed',
  `cycle_count` bigint(21) NOT NULL COMMENT 'How many cycles have been done'
) ENGINE=InnoDB SEQUENCE=1;

/*!40000 ALTER TABLE `pk_project_reviews` DISABLE KEYS */;
INSERT INTO `pk_project_reviews` (`next_not_cached_value`, `minimum_value`, `maximum_value`, `start_value`, `increment`, `cache_size`, `cycle_option`, `cycle_count`) VALUES
	(2001, 1, 9223372036854775806, 1, 1, 1000, 0, 0);
/*!40000 ALTER TABLE `pk_project_reviews` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `pk_students` (
  `next_not_cached_value` bigint(21) NOT NULL,
  `minimum_value` bigint(21) NOT NULL,
  `maximum_value` bigint(21) NOT NULL,
  `start_value` bigint(21) NOT NULL COMMENT 'start value when sequences is created or value if RESTART is used',
  `increment` bigint(21) NOT NULL COMMENT 'increment value',
  `cache_size` bigint(21) unsigned NOT NULL,
  `cycle_option` tinyint(1) unsigned NOT NULL COMMENT '0 if no cycles are allowed, 1 if the sequence should begin a new cycle when maximum_value is passed',
  `cycle_count` bigint(21) NOT NULL COMMENT 'How many cycles have been done'
) ENGINE=InnoDB SEQUENCE=1;

/*!40000 ALTER TABLE `pk_students` DISABLE KEYS */;
INSERT INTO `pk_students` (`next_not_cached_value`, `minimum_value`, `maximum_value`, `start_value`, `increment`, `cache_size`, `cycle_option`, `cycle_count`) VALUES
	(3001, 1, 9223372036854775806, 1, 1, 1000, 0, 0);
/*!40000 ALTER TABLE `pk_students` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `pk_teachers` (
  `next_not_cached_value` bigint(21) NOT NULL,
  `minimum_value` bigint(21) NOT NULL,
  `maximum_value` bigint(21) NOT NULL,
  `start_value` bigint(21) NOT NULL COMMENT 'start value when sequences is created or value if RESTART is used',
  `increment` bigint(21) NOT NULL COMMENT 'increment value',
  `cache_size` bigint(21) unsigned NOT NULL,
  `cycle_option` tinyint(1) unsigned NOT NULL COMMENT '0 if no cycles are allowed, 1 if the sequence should begin a new cycle when maximum_value is passed',
  `cycle_count` bigint(21) NOT NULL COMMENT 'How many cycles have been done'
) ENGINE=InnoDB SEQUENCE=1;

/*!40000 ALTER TABLE `pk_teachers` DISABLE KEYS */;
INSERT INTO `pk_teachers` (`next_not_cached_value`, `minimum_value`, `maximum_value`, `start_value`, `increment`, `cache_size`, `cycle_option`, `cycle_count`) VALUES
	(3001, 1, 9223372036854775806, 1, 1, 1000, 0, 0);
/*!40000 ALTER TABLE `pk_teachers` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `pk_users` (
  `next_not_cached_value` bigint(21) NOT NULL,
  `minimum_value` bigint(21) NOT NULL,
  `maximum_value` bigint(21) NOT NULL,
  `start_value` bigint(21) NOT NULL COMMENT 'start value when sequences is created or value if RESTART is used',
  `increment` bigint(21) NOT NULL COMMENT 'increment value',
  `cache_size` bigint(21) unsigned NOT NULL,
  `cycle_option` tinyint(1) unsigned NOT NULL COMMENT '0 if no cycles are allowed, 1 if the sequence should begin a new cycle when maximum_value is passed',
  `cycle_count` bigint(21) NOT NULL COMMENT 'How many cycles have been done'
) ENGINE=InnoDB SEQUENCE=1;

/*!40000 ALTER TABLE `pk_users` DISABLE KEYS */;
INSERT INTO `pk_users` (`next_not_cached_value`, `minimum_value`, `maximum_value`, `start_value`, `increment`, `cache_size`, `cycle_option`, `cycle_count`) VALUES
	(3002, 1, 9223372036854775806, 2, 1, 1000, 0, 0);
/*!40000 ALTER TABLE `pk_users` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `pk_videos` (
  `next_not_cached_value` bigint(21) NOT NULL,
  `minimum_value` bigint(21) NOT NULL,
  `maximum_value` bigint(21) NOT NULL,
  `start_value` bigint(21) NOT NULL COMMENT 'start value when sequences is created or value if RESTART is used',
  `increment` bigint(21) NOT NULL COMMENT 'increment value',
  `cache_size` bigint(21) unsigned NOT NULL,
  `cycle_option` tinyint(1) unsigned NOT NULL COMMENT '0 if no cycles are allowed, 1 if the sequence should begin a new cycle when maximum_value is passed',
  `cycle_count` bigint(21) NOT NULL COMMENT 'How many cycles have been done'
) ENGINE=InnoDB SEQUENCE=1;

/*!40000 ALTER TABLE `pk_videos` DISABLE KEYS */;
INSERT INTO `pk_videos` (`next_not_cached_value`, `minimum_value`, `maximum_value`, `start_value`, `increment`, `cache_size`, `cycle_option`, `cycle_count`) VALUES
	(2001, 1, 9223372036854775806, 1, 1, 1000, 0, 0);
/*!40000 ALTER TABLE `pk_videos` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `projectdeliverables` (
  `project_deliverable_id` int(11) NOT NULL DEFAULT nextval(`annonymousgrading`.`pk_project_deliverable`),
  `project_member_id` int(11) DEFAULT NULL,
  `deliverable_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`project_deliverable_id`),
  KEY `project_member_id` (`project_member_id`),
  KEY `deliverable_id` (`deliverable_id`),
  CONSTRAINT `projectdeliverables_ibfk_1` FOREIGN KEY (`project_member_id`) REFERENCES `projectmember` (`project_member_id`),
  CONSTRAINT `projectdeliverables_ibfk_2` FOREIGN KEY (`deliverable_id`) REFERENCES `deliverables` (`deliverable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*!40000 ALTER TABLE `projectdeliverables` DISABLE KEYS */;
INSERT INTO `projectdeliverables` (`project_deliverable_id`, `project_member_id`, `deliverable_id`) VALUES
	(1001, NULL, 1001),
	(1002, NULL, 1004),
	(1003, NULL, 1005),
	(1004, NULL, 1004),
	(1005, NULL, 1007);
/*!40000 ALTER TABLE `projectdeliverables` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `projectmember` (
  `project_member_id` int(11) NOT NULL DEFAULT nextval(`annonymousgrading`.`pk_project_member`),
  `project_id` int(11) DEFAULT NULL,
  `student_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`project_member_id`),
  KEY `project_id` (`project_id`),
  KEY `student_id` (`student_id`),
  CONSTRAINT `projectmember_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`project_id`),
  CONSTRAINT `projectmember_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*!40000 ALTER TABLE `projectmember` DISABLE KEYS */;
INSERT INTO `projectmember` (`project_member_id`, `project_id`, `student_id`) VALUES
	(1001, NULL, NULL),
	(1002, NULL, NULL),
	(1003, NULL, NULL),
	(1004, 1010, 1001),
	(1005, 1010, 1001),
	(1006, 1010, 1001),
	(1007, 1013, 1001),
	(1008, NULL, NULL),
	(1009, NULL, NULL),
	(1010, NULL, NULL),
	(1011, 1016, 1001),
	(1012, NULL, NULL),
	(1013, NULL, NULL),
	(1014, NULL, NULL),
	(1015, 1021, NULL),
	(1016, 1022, 16);
/*!40000 ALTER TABLE `projectmember` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `projectreviews` (
  `project_review_id` int(11) NOT NULL DEFAULT nextval(`annonymousgrading`.`pk_project_reviews`),
  `project_member_id` int(11) DEFAULT NULL,
  `project_id` int(11) DEFAULT NULL,
  `review_value` float DEFAULT NULL,
  `review_deadline` datetime DEFAULT NULL,
  `review_date` datetime DEFAULT NULL,
  PRIMARY KEY (`project_review_id`),
  KEY `project_member_id` (`project_member_id`),
  KEY `project_id` (`project_id`),
  CONSTRAINT `projectreviews_ibfk_1` FOREIGN KEY (`project_member_id`) REFERENCES `projectmember` (`project_member_id`),
  CONSTRAINT `projectreviews_ibfk_2` FOREIGN KEY (`project_id`) REFERENCES `projects` (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*!40000 ALTER TABLE `projectreviews` DISABLE KEYS */;
INSERT INTO `projectreviews` (`project_review_id`, `project_member_id`, `project_id`, `review_value`, `review_deadline`, `review_date`) VALUES
	(1001, NULL, 1008, 2.25, NULL, NULL),
	(1002, NULL, 1022, 8.75, NULL, '2021-01-10 19:54:12'),
	(1003, NULL, 1022, 8.75, NULL, '2021-01-10 20:10:29'),
	(1004, NULL, 1015, 8, NULL, '2021-01-10 20:11:36'),
	(1005, NULL, 1018, 5.5, NULL, '2021-01-10 20:12:48'),
	(1006, NULL, 1015, 3, NULL, '2021-01-10 20:14:17'),
	(1007, NULL, 1016, 4, NULL, '2021-01-10 20:42:24'),
	(1008, NULL, 1017, 5, NULL, '2021-01-10 20:43:25'),
	(1009, NULL, 1019, 2.5, NULL, '2021-01-10 20:46:14'),
	(1010, NULL, 1014, 3, NULL, '2021-01-10 20:48:00'),
	(1011, NULL, 1013, 2.5, NULL, '2021-01-10 20:49:27'),
	(1012, NULL, 1023, 4.5, NULL, '2021-01-10 20:50:18'),
	(1013, NULL, 1008, 3.25, NULL, '2021-01-10 20:53:24'),
	(1014, NULL, 1017, 1.5, '2021-01-10 22:00:00', '2021-01-10 20:56:52'),
	(1015, NULL, 1018, 2, '2103-02-27 22:00:00', '2021-01-10 20:58:42'),
	(1016, NULL, 1017, 1.5, '2029-03-26 21:00:00', '2021-01-10 20:59:11'),
	(1017, NULL, 1016, 2, '2021-01-27 22:00:00', '2021-01-10 21:00:07'),
	(1018, NULL, 1018, 1.5, '2021-04-17 21:00:00', '2021-01-10 21:01:52');
/*!40000 ALTER TABLE `projectreviews` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `projects` (
  `project_id` int(11) NOT NULL DEFAULT nextval(`annonymousgrading`.`pk_projects`),
  `title` varchar(40) DEFAULT NULL,
  `description` varchar(248) DEFAULT NULL,
  `creation_date` datetime DEFAULT NULL,
  `total_grade` float DEFAULT NULL,
  PRIMARY KEY (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*!40000 ALTER TABLE `projects` DISABLE KEYS */;
INSERT INTO `projects` (`project_id`, `title`, `description`, `creation_date`, `total_grade`) VALUES
	(1001, 'Canarii', 'Pasari galbene ce pot fi admirate de toti iubitorii de animale.', '2021-01-07 00:00:00', NULL),
	(1002, 'sdgdh', 'setryhtjyuiky8r5ty34er', '1995-04-02 00:00:00', NULL),
	(1003, 'sdgdh', 'setryhtjyuiky8r5ty34er', '1995-04-02 00:00:00', NULL),
	(1004, 'krjgoityjtkrntgkjerhgn', 'rthktyjoitujheisejeiortj85yu5otujhdgbosdkfwugefyusgjkdtjhgeiodgdprohijrtyrijgdnbgdn vdgjdghehbg', '2001-05-04 00:00:00', NULL),
	(1005, 'krjgoityjtkrntgkjerhgn', 'rthktyjoitujheisejeiortj85yu5otujhdgbosdkfwugefyusgjkdtjhgeiodgdprohijrtyrijgdnbgdn vdgjdghehbg', '2001-05-04 00:00:00', NULL),
	(1007, 'Ana are mere', 'Mere Anei sunt cele mai bune mere importate din Bulgaria. The end.', '2021-01-03 00:00:00', NULL),
	(1008, 'rjgiryor', 'e5tekrjw3iyr7t8eojfstyeirtjgeogke5-otw04tujoeigt', '2021-05-04 00:00:00', NULL),
	(1009, 'rjgiryor', 'e5tekrjw3iyr7t8eojfstyeirtjgeogke5-otw04tujoeigt', '2021-05-04 00:00:00', NULL),
	(1010, 'fiwjhiefjifn', 'wefwlajdqiwedhyewtrfwuiahdwjfbsjhvbsncs', '2020-04-29 00:00:00', NULL),
	(1011, 'fiwjhiefjifn', 'wefwlajdqiwedhyewtrfwuiahdwjfbsjhvbsncs', '2020-04-29 00:00:00', NULL),
	(1012, 'fiwjhiefjifn', 'wefwlajdqiwedhyewtrfwuiahdwjfbsjhvbsncs', '2020-04-29 00:00:00', NULL),
	(1013, 'gfjodjgsi', 'gsefawjdqpowrjhwugtewuygh', '2020-05-23 00:00:00', NULL),
	(1014, 'rgeh', 'rgeswerqwr34wt5erg', '1567-03-02 00:00:00', NULL),
	(1015, 'jshjdkuhf', 'efnosiethojsolejfskjhbcgsefui', '2020-04-03 00:00:00', NULL),
	(1016, 'jshjdkuhf', 'efnosiethojsolejfskjhbcgsefui', '2020-04-03 00:00:00', NULL),
	(1017, 'Tinerii Titani', 'Desene animate', '2021-01-08 00:00:00', NULL),
	(1018, 'Tinerii Titani', 'Desene animate', '2021-01-08 00:00:00', NULL),
	(1019, 'Ala Bala Portocala', 'Jocul de picioare', '2021-01-08 00:00:00', NULL),
	(1020, 'Ala Bala Portocala', 'Jocul de picioare', '2021-01-08 00:00:00', NULL),
	(1021, 'Annonymous Grading', 'Tehnologii Web', '2021-01-08 00:00:00', NULL),
	(1022, 'Manca-ti-as Hazu', 'Te pup stii ca de tine sunt foc!', '2020-12-21 00:00:00', NULL),
	(1023, 'Manca-ti-as Hazu', 'Te pup stii ca de tine sunt foc!', '2020-12-21 00:00:00', NULL),
	(1024, NULL, NULL, NULL, NULL),
	(1025, NULL, NULL, NULL, NULL),
	(1026, NULL, NULL, NULL, NULL),
	(1027, NULL, NULL, NULL, NULL);
/*!40000 ALTER TABLE `projects` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `students` (
  `student_id` int(11) NOT NULL DEFAULT nextval(`annonymousgrading`.`pk_students`),
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`student_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `students_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*!40000 ALTER TABLE `students` DISABLE KEYS */;
INSERT INTO `students` (`student_id`, `user_id`) VALUES
	(4, NULL),
	(5, NULL),
	(6, NULL),
	(7, NULL),
	(8, NULL),
	(9, NULL),
	(10, NULL),
	(11, 16),
	(12, 17),
	(13, 19),
	(14, 20),
	(15, 21),
	(16, 22),
	(1001, 1002),
	(2001, 2006),
	(2002, 2007);
/*!40000 ALTER TABLE `students` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `teachers` (
  `teacher_id` int(11) NOT NULL DEFAULT nextval(`annonymousgrading`.`pk_teachers`),
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`teacher_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `teachers_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*!40000 ALTER TABLE `teachers` DISABLE KEYS */;
INSERT INTO `teachers` (`teacher_id`, `user_id`) VALUES
	(1001, 1003),
	(2001, 2002),
	(2002, 2004);
/*!40000 ALTER TABLE `teachers` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `users` (
  `user_id` int(11) NOT NULL DEFAULT nextval(`annonymousgrading`.`pk_users`),
  `email` varchar(30) DEFAULT NULL,
  `username` varchar(30) DEFAULT NULL,
  `user_password` varchar(100) DEFAULT NULL,
  `first_name` varchar(40) DEFAULT NULL,
  `last_name` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `users_unique` (`email`,`username`),
  UNIQUE KEY `username_unique` (`username`),
  UNIQUE KEY `email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`user_id`, `email`, `username`, `user_password`, `first_name`, `last_name`) VALUES
	(1, 'user1@db.com', 'user1', '123', 'user1', 'User'),
	(8, 'awsdjhwfjnkf@hnfjgn.com', 'sefjnfwkjbfkb', 'sjfknfjnv', 'fksjmfwkfwkm', 'seidfjjdgrn'),
	(9, 'ahnfjsf@hejf.com', 'kjky', 'oirhotkht', 'jiijn', 'jfejnjsn'),
	(10, 'ekhgj@gmail.com', 'uiip', 'efe5y', '7kuy', 'eferhgr'),
	(12, 'kyjoyjerihgn@fgbjft.com', 'lkyhjyjm', '3oi9358', 'joyitrji', 'djrgijy'),
	(13, 'fjy7kyt@hmail.com', 'rhykjuy', 'ygjuy7u56', 'hnygjg', 'segyfj'),
	(14, 'gnkfjhrn@fgjmbkf.com', 'gfkrjok', '85y95uohknm', 'rkoihjtiyjmh', 'rgrkjhrijh'),
	(15, 't7ktjhri5tohrkn@jfbgjthj.com', 'thrkjhring', 'gujtfkjgir5uy8', 'jiuym', 'grthuj'),
	(16, 'rthlkrgjekln@jgnjdhm', 'gblkfmhbfklb', 'drgnjehg69u9tjh', 'rgkgbnkedb', 'cjihruihgri'),
	(17, 'grdkrgnkdn@jdvbjd.com', 'sefsjgnkgj', 'drgndjgndgjn6', 'groiehgujnh', 'zdvkjdgjknb'),
	(19, 'sefsklfhodij@jdgbk.com', 'dfishjfiekng', 'dgdjfhsi75y95y', 'yfjfdrgodejig', 'srgdjhfrui'),
	(20, 'egdhsjb@kndjn.com', 'dhnhroiht', 'foiwngejgnb56', 'wgelhkr6oh', 'jshgjsgn'),
	(21, 'dfsejfbhjbgh@gmail.com', 'egdyrj', 'sefejyr703rjkf', 'sgdnfskjfo', 'jhgdyghkjb'),
	(22, 'gdghueyr739@jfj.com', 'efjsfnkngr', 'efksjfis93', 'sgvskfsiogj', 'zvjsbvsjv '),
	(1002, 'popescu.ana@gmail.com', 'popescu.ana', '1234', 'Ana', 'Popescu'),
	(1003, 'alex.bodi@gmail.com', 'alex.bodi', 'abcd', 'Alex', 'Bodi'),
	(2002, 'mihai_viteazu@gmail.com', 'mihai_viteazu1601', 'TaraRomaneasca', 'Mihai', 'Viteazu'),
	(2004, 'ion_creanga@nica.com', 'ion.creanga', 'Nica', 'Ion', 'Creanga'),
	(2006, 'dcnsjrgfhi@jgjv.com', 'efekjhgkr.gjnh', '7594tujng', 'fkjgi', 'gfth'),
	(2007, 'hrgwte@skejfikei.com', 'estgrthr', 'e45t45y', 'jyujtyh', 'dgfjh');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `videos` (
  `video_id` int(11) NOT NULL DEFAULT nextval(`annonymousgrading`.`pk_videos`),
  `deliverable_id` int(11) DEFAULT NULL,
  `video_name` varchar(50) DEFAULT NULL,
  `video_link` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`video_id`),
  KEY `deliverable_id` (`deliverable_id`),
  CONSTRAINT `videos_ibfk_1` FOREIGN KEY (`deliverable_id`) REFERENCES `deliverables` (`deliverable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*!40000 ALTER TABLE `videos` DISABLE KEYS */;
INSERT INTO `videos` (`video_id`, `deliverable_id`, `video_name`, `video_link`) VALUES
	(1001, 1004, 'Am terminat proiectul!', 'https://www.youtube.com/results?search_query=we+are+the+champions'),
	(1002, 1007, 'Alt livrabil!', 'https://www.youtube.com/watch?v=9jK-NcRmVcw');
/*!40000 ALTER TABLE `videos` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
