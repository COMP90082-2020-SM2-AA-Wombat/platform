-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema AA_AUDIT
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `AA_AUDIT` ;

-- -----------------------------------------------------
-- Schema AA_AUDIT
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `AA_AUDIT` DEFAULT CHARACTER SET utf8 ;
USE `AA_AUDIT` ;

CREATE TABLE input_table_2 (
  name VARCHAR(20),
  color VARCHAR(10)
);

INSERT INTO input_table_2
  (name, color)
VALUES
  ('Sam', 'blue'),
  ('Ari', 'yellow');
-- -----------------------------------------------------
-- Table `AA_AUDIT`.`facility_operator`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AA_AUDIT`.`facility_operator` ;

CREATE TABLE IF NOT EXISTS `AA_AUDIT`.`facility_operator` (
  `operator_id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `registration_number` VARCHAR(45) NULL,
  `public_private` VARCHAR(45) NULL,
=======
------------------------------------------------------
------------------------------------------------------
-- AA AUDITS DDL V3.6 + DUMMY DATA INSERTS
------------------------------------------------------
------------------------------------------------------



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
-- Table structure for table `auditors`
--

DROP TABLE IF EXISTS `auditors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auditors` (
  `first_name` varchar(45) DEFAULT NULL,
  `last_name` varchar(45) DEFAULT NULL,
  `employee_id` varchar(45) NOT NULL,
  PRIMARY KEY (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `audits`
--

DROP TABLE IF EXISTS `audits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audits` (
  `audit_id` int NOT NULL,
  `audit_date` date DEFAULT NULL,
  `revision_num` int NOT NULL,
  `facilities_facility_id` int NOT NULL,
  `versions_version` int NOT NULL,
  PRIMARY KEY (`audit_id`,`revision_num`,`facilities_facility_id`),
  KEY `fk_audits_facilities1_idx` (`facilities_facility_id`),
  KEY `fk_audits_versions1_idx` (`versions_version`),
  CONSTRAINT `fk_audits_facilities1` FOREIGN KEY (`facilities_facility_id`) REFERENCES `facilities` (`facility_id`),
  CONSTRAINT `fk_audits_versions1` FOREIGN KEY (`versions_version`) REFERENCES `versions` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `audits_has_auditors`
--

DROP TABLE IF EXISTS `audits_has_auditors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audits_has_auditors` (
  `audits_audit_id` int NOT NULL,
  `audits_revision_num` int NOT NULL,
  `auditors_employee_id` varchar(45) NOT NULL,
  PRIMARY KEY (`audits_audit_id`,`audits_revision_num`,`auditors_employee_id`),
  KEY `fk_audits_has_auditors_auditors1_idx` (`auditors_employee_id`),
  KEY `fk_audits_has_auditors_audits1_idx` (`audits_audit_id`,`audits_revision_num`),
  CONSTRAINT `fk_audits_has_auditors_auditors1` FOREIGN KEY (`auditors_employee_id`) REFERENCES `auditors` (`employee_id`),
  CONSTRAINT `fk_audits_has_auditors_audits1` FOREIGN KEY (`audits_audit_id`, `audits_revision_num`) REFERENCES `audits` (`audit_id`, `revision_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `audits_has_reports`
--

DROP TABLE IF EXISTS `audits_has_reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audits_has_reports` (
  `audits_audit_id` int NOT NULL,
  `reports_report_id` int NOT NULL,
  PRIMARY KEY (`audits_audit_id`,`reports_report_id`),
  KEY `fk_audits_has_reports_reports1_idx` (`reports_report_id`),
  KEY `fk_audits_has_reports_audits1_idx` (`audits_audit_id`),
  CONSTRAINT `fk_audits_has_reports_audits1` FOREIGN KEY (`audits_audit_id`) REFERENCES `audits` (`audit_id`),
  CONSTRAINT `fk_audits_has_reports_reports1` FOREIGN KEY (`reports_report_id`) REFERENCES `reports` (`report_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `audits_v`
--

DROP TABLE IF EXISTS `audits_v`;
/*!50001 DROP VIEW IF EXISTS `audits_v`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `audits_v` AS SELECT 
 1 AS `audit_id`,
 1 AS `revision_num`,
 1 AS `versions_version`,
 1 AS `audit_date`,
 1 AS `facilities_facility_id`,
 1 AS `facility_name`,
 1 AS `facility_operator_name`,
 1 AS `operator_id`,
 1 AS `report_id`,
 1 AS `reporting_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `beams`
--

DROP TABLE IF EXISTS `beams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `beams` (
  `beam_id` int NOT NULL,
  `descriptiotn` varchar(45) DEFAULT NULL,
  `direction` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`beam_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cases`
--

DROP TABLE IF EXISTS `cases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cases` (
  `case_id` int NOT NULL,
  `description` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`case_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `constant_values`
--

DROP TABLE IF EXISTS `constant_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `constant_values` (
  `constant_id` int NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `value` json DEFAULT NULL,
  `date_inserted` date DEFAULT NULL,
  `versions_version` int NOT NULL,
  PRIMARY KEY (`constant_id`,`versions_version`),
  KEY `fk_constant_values_versions1_idx` (`versions_version`),
  CONSTRAINT `fk_constant_values_versions1` FOREIGN KEY (`versions_version`) REFERENCES `versions` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ct_models`
--

DROP TABLE IF EXISTS `ct_models`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ct_models` (
  `ct_model_id` int NOT NULL,
  `manufacturer` varchar(45) DEFAULT NULL,
  `model` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ct_model_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `energy_level`
--

DROP TABLE IF EXISTS `energy_level`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `energy_level` (
  `energy_level` varchar(45) NOT NULL,
  PRIMARY KEY (`energy_level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `facilities`
--

DROP TABLE IF EXISTS `facilities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `facilities` (
  `facility_id` int NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `state` varchar(45) DEFAULT NULL,
  `address` varchar(45) DEFAULT NULL,
  `facility_operator_operator_id` int NOT NULL,
  PRIMARY KEY (`facility_id`,`facility_operator_operator_id`),
  KEY `fk_facilities_facility_operator1_idx` (`facility_operator_operator_id`),
  CONSTRAINT `fk_facilities_facility_operator1` FOREIGN KEY (`facility_operator_operator_id`) REFERENCES `facility_operator` (`operator_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `facilities_has_cts`
--

DROP TABLE IF EXISTS `facilities_has_cts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `facilities_has_cts` (
  `ct_id` varchar(45) NOT NULL,
  `ct_models_ct_model_id` int NOT NULL,
  `facilities_facility_id` int NOT NULL,
  PRIMARY KEY (`ct_id`,`ct_models_ct_model_id`,`facilities_facility_id`),
  KEY `fk_facilities_has_cts_ct_models1_idx` (`ct_models_ct_model_id`),
  KEY `fk_facilities_has_cts_facilities1_idx` (`facilities_facility_id`),
  CONSTRAINT `fk_facilities_has_cts_ct_models1` FOREIGN KEY (`ct_models_ct_model_id`) REFERENCES `ct_models` (`ct_model_id`),
  CONSTRAINT `fk_facilities_has_cts_facilities1` FOREIGN KEY (`facilities_facility_id`) REFERENCES `facilities` (`facility_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `facilities_has_linacs`
--

DROP TABLE IF EXISTS `facilities_has_linacs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `facilities_has_linacs` (
  `facilities_facility_id` int NOT NULL,
  `linacs_linac_model_id` int NOT NULL,
  `linac_serial_number` varchar(45) DEFAULT NULL,
  `linac_id` varchar(45) NOT NULL,
  PRIMARY KEY (`linac_id`,`linacs_linac_model_id`,`facilities_facility_id`),
  KEY `fk_facilities_has_linacs_linacs1_idx` (`linacs_linac_model_id`),
  KEY `fk_facilities_has_linacs_facilities1_idx` (`facilities_facility_id`),
  CONSTRAINT `fk_facilities_has_linacs_facilities1` FOREIGN KEY (`facilities_facility_id`) REFERENCES `facilities` (`facility_id`),
  CONSTRAINT `fk_facilities_has_linacs_linacs1` FOREIGN KEY (`linacs_linac_model_id`) REFERENCES `linac_models` (`linac_model_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `facilities_has_planning_systems`
--

DROP TABLE IF EXISTS `facilities_has_planning_systems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `facilities_has_planning_systems` (
  `facilities_facility_id` int NOT NULL,
  `planning_systems_ps_id` int NOT NULL,
  PRIMARY KEY (`facilities_facility_id`,`planning_systems_ps_id`),
  KEY `fk_facilities_has_planning_systems_planning_systems1_idx` (`planning_systems_ps_id`),
  KEY `fk_facilities_has_planning_systems_facilities1_idx` (`facilities_facility_id`),
  CONSTRAINT `fk_facilities_has_planning_systems_facilities1` FOREIGN KEY (`facilities_facility_id`) REFERENCES `facilities` (`facility_id`),
  CONSTRAINT `fk_facilities_has_planning_systems_planning_systems1` FOREIGN KEY (`planning_systems_ps_id`) REFERENCES `planning_systems` (`ps_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `facility_operator`
--

DROP TABLE IF EXISTS `facility_operator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `facility_operator` (
  `operator_id` int NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `registration_number` varchar(45) DEFAULT NULL,
  `public_private` varchar(45) DEFAULT NULL,
