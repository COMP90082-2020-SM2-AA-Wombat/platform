CREATE DATABASE  IF NOT EXISTS `AA_AUDIT` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `AA_AUDIT`;
-- MySQL dump 10.13  Distrib 8.0.21, for macos10.15 (x86_64)
--
-- Host: localhost    Database: AA_AUDIT
-- ------------------------------------------------------
-- Server version	8.0.21

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `auditors`
--

LOCK TABLES `auditors` WRITE;
/*!40000 ALTER TABLE `auditors` DISABLE KEYS */;
INSERT INTO `auditors` (`first_name`, `last_name`, `employee_id`) VALUES ('Bec','Sandoval','1'),('Onno','Hoffman','10'),('Eric','Thorne','11'),('Daisy','Norman','2'),('Tina','Le','3'),('John','Vargas','4'),('Terry','Byrne','5'),('Nina','Hicks','6'),('Velvet','Steele','7'),('Clem','Estrada','8'),('Robert','Jennings','9');
/*!40000 ALTER TABLE `auditors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `audits`
--

LOCK TABLES `audits` WRITE;
/*!40000 ALTER TABLE `audits` DISABLE KEYS */;
INSERT INTO `audits` (`audit_id`, `audit_date`, `revision_num`, `facilities_facility_id`, `versions_version`) VALUES (3081,'2016-10-05',1,56,1),(3081,'2016-10-05',2,56,1);
/*!40000 ALTER TABLE `audits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `audits_has_auditors`
--

LOCK TABLES `audits_has_auditors` WRITE;
/*!40000 ALTER TABLE `audits_has_auditors` DISABLE KEYS */;
INSERT INTO `audits_has_auditors` (`audits_audit_id`, `audits_revision_num`, `auditors_employee_id`) VALUES (3081,1,'2'),(3081,1,'4'),(3081,2,'1'),(3081,2,'11');
/*!40000 ALTER TABLE `audits_has_auditors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `audits_has_reports`
--

LOCK TABLES `audits_has_reports` WRITE;
/*!40000 ALTER TABLE `audits_has_reports` DISABLE KEYS */;
INSERT INTO `audits_has_reports` (`audits_audit_id`, `reports_report_id`) VALUES (3081,1);
/*!40000 ALTER TABLE `audits_has_reports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `beams`
--

LOCK TABLES `beams` WRITE;
/*!40000 ALTER TABLE `beams` DISABLE KEYS */;
INSERT INTO `beams` (`beam_id`, `description`, `direction`) VALUES (1,'1',NULL),(2,'Chair',NULL),(3,'Comb',NULL),(4,'IMRT',NULL),(5,'VMAT',NULL);
/*!40000 ALTER TABLE `beams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `cases`
--

LOCK TABLES `cases` WRITE;
/*!40000 ALTER TABLE `cases` DISABLE KEYS */;
INSERT INTO `cases` (`case_id`, `description`) VALUES (1,'Foo'),(3,'Quizzle'),(5,'Bar'),(6,'Baz'),(7,'Qux'),(8,'Corge');
/*!40000 ALTER TABLE `cases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `constant_values`
--

LOCK TABLES `constant_values` WRITE;
/*!40000 ALTER TABLE `constant_values` DISABLE KEYS */;
INSERT INTO `constant_values` (`constant_id`, `name`, `value`, `date_inserted`, `versions_version`) VALUES (1,'Pi','3.14','2020-09-15',1),(2,'C','65156165165.264656','2020-05-12',2);
/*!40000 ALTER TABLE `constant_values` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `ct_models`
--

LOCK TABLES `ct_models` WRITE;
/*!40000 ALTER TABLE `ct_models` DISABLE KEYS */;
INSERT INTO `ct_models` (`ct_model_id`, `manufacturer`, `model`) VALUES (1,'GE','750 HD'),(2,'GE','Optima 660'),(3,'GE','LightSpeed 16'),(4,'Philips','iCT'),(5,'Philips','MX 16'),(6,'Siemens','Senstation'),(7,'Siemens','Scope 16'),(8,'Toshiba','Prime 160'),(9,'Toshiba','Aquilion 8'),(10,'GE','BrightSpeed Edge 8');
/*!40000 ALTER TABLE `ct_models` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `energy_level`
--

LOCK TABLES `energy_level` WRITE;
/*!40000 ALTER TABLE `energy_level` DISABLE KEYS */;
INSERT INTO `energy_level` (`energy_level`) VALUES ('10'),('10FFF'),('15'),('6'),('6FFF');
/*!40000 ALTER TABLE `energy_level` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `facilities`
--

LOCK TABLES `facilities` WRITE;
/*!40000 ALTER TABLE `facilities` DISABLE KEYS */;
INSERT INTO `facilities` (`facility_id`, `name`, `state`, `address`, `facility_operator_operator_id`) VALUES (2,'Appenzeller Dog','QLD','Some Fake Street',4),(3,'Antelope','NSW','Some Fake Street',4),(5,'Ainu Dog','NZ','Some Fake Street',1),(7,'Asian Palm Civet','NSW','Some Fake Street',1),(8,'American Bulldog','ACT','Some Fake Street',4),(9,'Ant','VIC','Some Fake Street',1),(10,'Avocet','VIC','Some Fake Street',4),(13,'American Water Spaniel','SA','Some Fake Street',4),(14,'American Staffordshire Terrier','QLD','Some Fake Street',1),(15,'African Palm Civet','QLD','Some Fake Street',2),(16,'Arctic Hare','SA','Some Fake Street',1),(20,'Australian Kelpie Dog','NT','Some Fake Street',4),(24,'Barracuda','VIC','Some Fake Street',1),(25,'Amur Leopard','NT','Some Fake Street',2),(28,'African Tree Toad','SA','Some Fake Street',1),(30,'African Penguin','WA','Some Fake Street',3),(34,'African Wild Dog','ACT','Some Fake Street',4),(37,'American Coonhound','NZ','Some Fake Street',1),(41,'Badger','SA','Some Fake Street',3),(44,'American Pit Bull Terrier','NSW','Some Fake Street',3),(45,'American Cocker Spaniel','NT','Some Fake Street',1),(47,'Alaskan Malamute','NSW','Some Fake Street',2),(48,'Akita','VIC','Some Fake Street',1),(49,'Banded Palm Civet','NZ','Some Fake Street',4),(50,'Arctic Wolf','ACT','Some Fake Street',2),(51,'Axolotl','QLD','Some Fake Street',1),(54,'Australian Cattle Dog','ACT','Some Fake Street',1),(55,'American Eskimo Dog','VIC','Some Fake Street',2),(55,'Australian Shepherd','NZ','Some Fake Street',4),(56,'Asiatic Black Bear','QLD','Some Fake Street',1),(57,'Albatross','QLD','Some Fake Street',3),(57,'Beagle','NT','Some Fake Street',4),(58,'Alpine Dachsbracke','SA','Some Fake Street',4),(61,'Beaver','NSW','Some Fake Street',4),(63,'Birds Of Paradise','ACT','Some Fake Street',2),(65,'Bear','NZ','Some Fake Street',1),(66,'African Clawed Frog','VIC','Some Fake Street',1),(70,'African Forest Elephant','NSW','Some Fake Street',1),(73,'Angelfish','NZ','Some Fake Street',3),(74,'Asian Giant Hornet','NZ','Some Fake Street',4),(80,'Bearded Dragon','VIC','Some Fake Street',2),(81,'Bedlington Terrier','QLD','Some Fake Street',4),(90,'Boykin Spaniel','NZ','Some Fake Street',4);
/*!40000 ALTER TABLE `facilities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `facilities_has_cts`
--

LOCK TABLES `facilities_has_cts` WRITE;
/*!40000 ALTER TABLE `facilities_has_cts` DISABLE KEYS */;
INSERT INTO `facilities_has_cts` (`ct_id`, `ct_models_ct_model_id`, `facilities_facility_id`) VALUES ('3',1,20),('2',2,13),('1',6,56);
/*!40000 ALTER TABLE `facilities_has_cts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `facilities_has_linacs`
--

LOCK TABLES `facilities_has_linacs` WRITE;
/*!40000 ALTER TABLE `facilities_has_linacs` DISABLE KEYS */;
INSERT INTO `facilities_has_linacs` (`facilities_facility_id`, `linacs_linac_model_id`, `linac_serial_number`, `linac_id`) VALUES (90,1,'DFDSFDS',''),(66,1,'SN56168','1'),(48,3,'PQNVG','10'),(47,1,'P12547','11'),(57,2,'BGTRE','12'),(58,1,'MGAREW','13'),(8,1,'876878','14'),(37,5,'34567','15'),(55,3,'LOPPIY','16'),(44,2,'09364','17'),(14,5,'HIBHIV','18'),(13,5,'7896325','19'),(70,2,'DBJDKJB','2'),(25,3,'65156','20'),(25,3,'65157','21'),(73,4,'VBNHGF','22'),(9,4,'UIGIG','23'),(3,2,'POPOJ','24'),(2,2,'GHFGHF','25'),(16,2,'DGFDGFDGD','26'),(50,1,'GHFGHFGH','27'),(74,1,'87TG8G86F','28'),(7,1,'GHGFHFGT55','29'),(15,3,'SN-789456','3'),(56,2,'QWEPOICV','30'),(54,3,'3657895','31'),(20,5,'GHGFH','32'),(55,5,'DSFDSF','33'),(55,5,'ERWEF','34'),(10,1,'453453','35'),(51,1,'FDGDFGD','36'),(41,1,'FGDFGHDF','37'),(49,3,'DSFSDFEFGR','38'),(24,2,'342423424','39'),(15,1,'SN96611','4'),(57,4,'4543543567','40'),(65,1,'FHGGFJHF','41'),(80,2,'656565656565','42'),(61,3,'7845151','43'),(81,4,'LOIJJHH','44'),(63,5,'POYRED','45'),(30,4,'KDDDFD','5'),(30,5,'789555','6'),(28,1,'SNJKBKJBK','7'),(34,2,'435345','8'),(5,2,'PLOIDD','9');
/*!40000 ALTER TABLE `facilities_has_linacs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `facilities_has_planning_systems`
--

LOCK TABLES `facilities_has_planning_systems` WRITE;
/*!40000 ALTER TABLE `facilities_has_planning_systems` DISABLE KEYS */;
INSERT INTO `facilities_has_planning_systems` (`facilities_facility_id`, `planning_systems_ps_id`) VALUES (56,0),(20,2),(13,3);
/*!40000 ALTER TABLE `facilities_has_planning_systems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `facility_operator`
--

LOCK TABLES `facility_operator` WRITE;
/*!40000 ALTER TABLE `facility_operator` DISABLE KEYS */;
INSERT INTO `facility_operator` (`operator_id`, `name`, `registration_number`, `public_private`) VALUES (1,'Operator A','123456','public'),(2,'Operator B ','234567','private'),(3,'Operator C','789456','public'),(4,'Operator D','591357',NULL);
/*!40000 ALTER TABLE `facility_operator` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `facility_stated`
--

LOCK TABLES `facility_stated` WRITE;
/*!40000 ALTER TABLE `facility_stated` DISABLE KEYS */;
INSERT INTO `facility_stated` (`facilities_has_linacs_linac_id`, `trs_398_method_method_id`, `amount`, `facilities_has_cts_ct_id`, `energy_level_energy_level`, `planning_system_algorithm_algorithm_id`, `phantoms_phantom_id`, `facilities_has_planning_systems_planning_systems_ps_id`, `audits_audit_id`, `audits_revision_num`) VALUES ('1',1,1.003000000000000000000000000000,'1','10FFF',1,1,1,3081,1),('1',1,1.003000000000000000000000000000,'1','10FFF',2,1,1,3081,1),('1',1,1.002000000000000000000000000000,'1','6',1,1,1,3081,1),('1',1,1.002000000000000000000000000000,'1','6',2,1,1,3081,1),('1',2,0.707000000000000000000000000000,'1','10FFF',1,1,1,3081,1),('1',2,0.707000000000000000000000000000,'1','10FFF',2,1,1,3081,1),('1',2,0.667500000000000000000000000000,'1','6',1,1,1,3081,1),('1',2,0.667500000000000000000000000000,'1','6',2,1,1,3081,1);
/*!40000 ALTER TABLE `facility_stated` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `linac_models`
--

LOCK TABLES `linac_models` WRITE;
/*!40000 ALTER TABLE `linac_models` DISABLE KEYS */;
INSERT INTO `linac_models` (`linac_model_id`, `manufacturer`, `model`) VALUES (1,'Elekta','Axesse'),(2,'Accuray','CyberKnife'),(3,'Accuray','Tomotherapy'),(4,'Varian','Halcyon'),(5,'Neusoft','NMSR600');
/*!40000 ALTER TABLE `linac_models` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `phantoms`
--

LOCK TABLES `phantoms` WRITE;
/*!40000 ALTER TABLE `phantoms` DISABLE KEYS */;
INSERT INTO `phantoms` (`phantom_id`, `name`) VALUES (1,'Max'),(2,'Red Anne'),(3,'Yellow Anne');
/*!40000 ALTER TABLE `phantoms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `planning_system_algorithm`
--

LOCK TABLES `planning_system_algorithm` WRITE;
/*!40000 ALTER TABLE `planning_system_algorithm` DISABLE KEYS */;
INSERT INTO `planning_system_algorithm` (`algorithm_id`, `algorithm_name`) VALUES (2,'Acu'),(5,'Large'),(1,'Lost'),(4,'Mon'),(3,'Small');
/*!40000 ALTER TABLE `planning_system_algorithm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `planning_systems`
--

LOCK TABLES `planning_systems` WRITE;
/*!40000 ALTER TABLE `planning_systems` DISABLE KEYS */;
INSERT INTO `planning_systems` (`ps_id`, `manufacturer`, `name`, `version`) VALUES (0,'RAV','Eth',NULL),(1,'RAV','Sun',NULL),(2,'IHP','Mountain',NULL),(3,'LEK','Sea',NULL),(4,'LEK','Land',NULL),(5,'Bra','iPL',NULL),(6,'URA','Pre',NULL),(7,'URA','Animal',NULL);
/*!40000 ALTER TABLE `planning_systems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `points`
--

LOCK TABLES `points` WRITE;
/*!40000 ALTER TABLE `points` DISABLE KEYS */;
INSERT INTO `points` (`point`, `position`) VALUES (1,NULL),(3,NULL),(5,NULL),(8,NULL),(10,NULL),(11,NULL),(12,NULL),(13,NULL),(14,NULL),(15,NULL),(16,NULL),(17,NULL),(18,NULL),(19,NULL),(20,NULL);
/*!40000 ALTER TABLE `points` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `reports`
--

LOCK TABLES `reports` WRITE;
/*!40000 ALTER TABLE `reports` DISABLE KEYS */;
INSERT INTO `reports` (`report_id`, `reporting_date`, `report_document`) VALUES (1,'2017-01-01','link to a file');
/*!40000 ALTER TABLE `reports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `results`
--

LOCK TABLES `results` WRITE;
/*!40000 ALTER TABLE `results` DISABLE KEYS */;
INSERT INTO `results` (`result_id`, `points_point`, `beams_beam_id`, `cases_case_id`, `audits_audit_id`, `audits_revision_num`, `energy_level`, `measured_current`, `predicted_current`, `variation_pc`, `planning_system_algorithm_algorithm_id`) VALUES (1,1,1,1,3081,1,'6',NULL,NULL,-2.060,2),(2,10,1,1,3081,1,'6',NULL,NULL,-2.170,2),(3,3,1,3,3081,1,'6',NULL,NULL,-1.800,2),(4,1,1,1,3081,1,'6',NULL,NULL,-1.200,1),(5,10,1,1,3081,1,'6',NULL,NULL,-2.600,1),(6,3,1,3,3081,1,'6',NULL,NULL,0.900,1),(7,1,1,1,3081,1,'10FFF',NULL,NULL,-1.300,2),(8,10,1,1,3081,1,'10FFF',NULL,NULL,-2.300,2),(9,3,1,3,3081,1,'10FFF',NULL,NULL,-1.400,2),(10,1,1,1,3081,1,'10FFF',NULL,NULL,-0.200,1),(11,10,1,1,3081,1,'10FFF',NULL,NULL,-2.300,1),(12,3,1,3,3081,1,'10FFF',NULL,NULL,0.600,1);
/*!40000 ALTER TABLE `results` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `trs_398_method`
--

LOCK TABLES `trs_398_method` WRITE;
/*!40000 ALTER TABLE `trs_398_method` DISABLE KEYS */;
INSERT INTO `trs_398_method` (`method_id`, `description`) VALUES (1,'Dummy Method1'),(2,'Dummy Method 2');
/*!40000 ALTER TABLE `trs_398_method` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `versions`
--

LOCK TABLES `versions` WRITE;
/*!40000 ALTER TABLE `versions` DISABLE KEYS */;
INSERT INTO `versions` (`version`, `date_created`, `comments`) VALUES (1,'2020-10-16',NULL),(2,'2020-10-17',NULL);
/*!40000 ALTER TABLE `versions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-10-19 13:30:34
