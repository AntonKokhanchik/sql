CREATE DATABASE  IF NOT EXISTS `stud` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `stud`;
-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: stud
-- ------------------------------------------------------
-- Server version	5.7.17-log

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
-- Table structure for table `students`
--

DROP TABLE IF EXISTS `students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `students` (
  `n_zach` int(11) NOT NULL AUTO_INCREMENT,
  `student_name` varchar(32) NOT NULL,
  `student_surname` varchar(32) NOT NULL,
  `student_lastname` varchar(32) DEFAULT NULL,
  `number_telephone` varchar(30) DEFAULT NULL,
  `n_group` int(11) DEFAULT NULL,
  PRIMARY KEY (`n_zach`)
) ENGINE=InnoDB AUTO_INCREMENT=17040 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `students`
--

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
INSERT INTO `students` VALUES (17000,'Гюннар','Йоунассон','Стейнар','940977',34),(17001,'Бальдюр','Йоунссон','Кристьян','363348',44),(17002,'Бальдюр','Торкельссон','Синдри','489389',25),(17003,'Торстейдн','Гримссон','Йоунас','515226',45),(17004,'Сверрир','Фридрикссон','Бьёдн','576194',14),(17005,'Ингибьёрг','Тоумасдоуттир','Сигюрбьёрг','621932',15),(17006,'Ауслёйг','Торкельсдоуттир','Эльса','139227',44),(17007,'Бьёрг','Сигфусдоуттир','Роуса','728365',34),(17008,'Тоура','Йоунасдоуттир','Сванхильдюр','438703',24),(17009,'Сигридюр','Гвюднадоуттир','Кристьяна','194119',35),(17010,'Modesta','Johnson','Fredrick',NULL,44),(17011,'Mike','Jast','Kaylin','1-762-974-3660',34),(17012,'Kristy','Donnelly','Alva','213-407-8378',44),(17013,'Isabelle','Johnson','Vito','(852) 578-6137',44),(17014,'Madisen','Fahey','Antonina',NULL,34),(17015,'Amos','Jacobson','Leola','1-369-855-1646',34),(17016,'Roman','Lynch','May','938-995-9161',35),(17017,'Trenton','Armstrong','Riley','154-620-5019',34),(17018,'Henriette','Weimann','Gussie',NULL,45),(17019,'Annamarie','Hettinger','Yadira',NULL,44),(17020,'Mazie','Collier','Alycia',NULL,44),(17021,'Wilfred','Kling','Allene','477-872-5412',34),(17022,'Gay','Cummings','Rogelio','506-201-8584',35),(17023,'Ayana','Smith','Raven','103-539-2138',34),(17024,'Jairo','Lemke','Warren','642-029-1264',45),(17025,'Elnora','Johnson','Reese','(528) 198-5633',34),(17026,'Erin','Wisozk','Caitlyn','(946) 513-0514',35),(17027,'Corbin','Hirthe','Verona',NULL,35),(17028,'Paris','Sporer','Tyrese','781.683.8729',34),(17029,'Robyn','Roob','Euna','1-758-474-1931',35),(17030,'Tamara','Boehm','Coleman',NULL,34),(17031,'Brant','Stiedemann','Kennith','334-364-0725',34),(17032,'Mohamed','Stark','Magnus','745-213-4677',45),(17033,'Aditya','Muller','Eliane','1-483-767-9404',35),(17034,'Aida','Runolfsdottir','Ivy','1-510-547-5463',44),(17035,'Carlo','Goldner','Harley','936-599-8222',44),(17036,'Bethany','Hintz','Mack','905.822.0414',35),(17037,'Monserrat','Price','Shanie','461.648.1847',45),(17038,'Amani','Larkin','Brown','118-553-4690',45),(17039,'Oran','Kuhn','Shanon','197.495.5001',45);
/*!40000 ALTER TABLE `students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `students_subjects`
--

DROP TABLE IF EXISTS `students_subjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `students_subjects` (
  `n_zach` int(11) NOT NULL,
  `n_subject` int(11) NOT NULL,
  `mark` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`n_zach`,`n_subject`),
  KEY `n_subject` (`n_subject`),
  CONSTRAINT `students_subjects_ibfk_1` FOREIGN KEY (`n_zach`) REFERENCES `students` (`n_zach`),
  CONSTRAINT `students_subjects_ibfk_2` FOREIGN KEY (`n_subject`) REFERENCES `teachers` (`n_subject`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `students_subjects`
--

LOCK TABLES `students_subjects` WRITE;
/*!40000 ALTER TABLE `students_subjects` DISABLE KEYS */;
INSERT INTO `students_subjects` VALUES (17000,3,4),(17000,7,5),(17000,8,3),(17000,9,3),(17000,11,2),(17001,4,3),(17001,6,4),(17001,10,5),(17001,12,3),(17001,13,3),(17002,1,5),(17002,2,3),(17003,4,2),(17003,6,4),(17003,10,5),(17003,12,3),(17003,13,4),(17004,5,5),(17005,5,3),(17006,4,5),(17006,6,2),(17006,10,3),(17006,12,4),(17006,13,3),(17007,3,2),(17007,7,5),(17007,8,4),(17007,9,3),(17007,11,3),(17008,1,2),(17008,2,4),(17009,3,5),(17009,7,3),(17009,8,2),(17009,9,4),(17009,11,2),(17010,6,3),(17010,10,4),(17010,12,2),(17010,13,2),(17011,7,3),(17011,8,2),(17011,9,5),(17011,11,3),(17012,6,3),(17012,10,3),(17012,12,3),(17012,13,4),(17013,6,3),(17013,10,5),(17013,12,4),(17013,13,2),(17014,7,5),(17014,8,4),(17014,9,5),(17014,11,2),(17015,7,2),(17015,8,5),(17015,9,2),(17015,11,2),(17016,7,5),(17016,8,5),(17016,9,2),(17016,11,4),(17017,7,2),(17017,8,2),(17017,9,2),(17017,11,4),(17018,6,5),(17018,10,4),(17018,12,5),(17018,13,2),(17019,6,2),(17019,10,5),(17019,12,4),(17019,13,2),(17020,6,2),(17020,10,2),(17020,12,3),(17020,13,5),(17021,7,3),(17021,8,3),(17021,9,2),(17021,11,3),(17022,7,5),(17022,8,5),(17022,9,5),(17022,11,4),(17023,7,5),(17023,8,2),(17023,9,3),(17023,11,2),(17024,6,5),(17024,10,5),(17024,12,4),(17024,13,4),(17025,7,2),(17025,8,4),(17025,9,2),(17025,11,5),(17026,7,2),(17026,8,2),(17026,9,5),(17026,11,5),(17027,7,4),(17027,8,2),(17027,9,5),(17027,11,5),(17028,7,5),(17028,8,2),(17028,9,3),(17028,11,4),(17029,7,5),(17029,8,3),(17029,9,3),(17029,11,2),(17030,7,3),(17030,8,4),(17030,9,2),(17030,11,2),(17031,7,4),(17031,8,4),(17031,9,3),(17031,11,3),(17032,6,2),(17032,10,2),(17032,12,3),(17032,13,2),(17033,7,4),(17033,8,3),(17033,9,2),(17033,11,2),(17034,6,3),(17034,10,5),(17034,12,3),(17034,13,2),(17035,6,3),(17035,10,5),(17035,12,3),(17035,13,5),(17036,7,2),(17036,8,5),(17036,9,4),(17036,11,2),(17037,6,2),(17037,10,4),(17037,12,3),(17037,13,4),(17038,6,3),(17038,10,3),(17038,12,4),(17038,13,2),(17039,6,3),(17039,10,5),(17039,12,2),(17039,13,2);
/*!40000 ALTER TABLE `students_subjects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teachers`
--

DROP TABLE IF EXISTS `teachers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teachers` (
  `n_subject` int(11) NOT NULL AUTO_INCREMENT,
  `subject_name` varchar(64) NOT NULL,
  `teacher_name` char(128) NOT NULL,
  PRIMARY KEY (`n_subject`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teachers`
--

LOCK TABLES `teachers` WRITE;
/*!40000 ALTER TABLE `teachers` DISABLE KEYS */;
INSERT INTO `teachers` VALUES (1,'Скандинавские руны','Любим Кронидович Быховский'),(2,'Приручение медведей','Афродита Аполлоновна Ершова'),(3,'Метание топоров','Любомир Платонович Вояковский'),(4,'Вальгалловедение','Один Асгардович Вранов'),(5,'ОБЖ','Гера Цезаревна Водова'),(6,'Языки','Языковедов Степан Ростиславович'),(7,'ОБЖ','Безопасный Никита Феликсович'),(8,'Математика','Точная Влада Евлампиевна'),(9,'Искуства','Красивая Христина Соломоновна'),(10,'Мистика','Невероятный Владислав Мартьянович'),(11,'Науковедение','Учёный Мартын Ульянович'),(12,'Науковедение','Точная Влада Евлампиевна'),(13,'Искуства','Мастеровой Игнатий Климентович');
/*!40000 ALTER TABLE `teachers` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-02-23 14:21:21
