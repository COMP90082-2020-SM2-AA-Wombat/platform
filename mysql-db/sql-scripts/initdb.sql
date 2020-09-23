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

-- -----------------------------------------------------
-- Table `AA_AUDIT`.`facility_operator`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AA_AUDIT`.`facility_operator` ;

CREATE TABLE IF NOT EXISTS `AA_AUDIT`.`facility_operator` (
  `operator_id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `registration_number` VARCHAR(45) NULL,
  `public_private` VARCHAR(45) NULL,
  PRIMARY KEY (`operator_id`),
  UNIQUE INDEX `registration_number_UNIQUE` (`registration_number` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AA_AUDIT`.`facilities`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AA_AUDIT`.`facilities` ;

CREATE TABLE IF NOT EXISTS `AA_AUDIT`.`facilities` (
  `facility_id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `state` VARCHAR(45) NULL,
  `address` VARCHAR(45) NULL,
  `facility_operator_operator_id` INT NOT NULL,
  PRIMARY KEY (`facility_id`, `facility_operator_operator_id`),
  INDEX `fk_facilities_facility_operator1_idx` (`facility_operator_operator_id` ASC) VISIBLE,
  CONSTRAINT `fk_facilities_facility_operator1`
    FOREIGN KEY (`facility_operator_operator_id`)
    REFERENCES `AA_AUDIT`.`facility_operator` (`operator_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AA_AUDIT`.`versions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AA_AUDIT`.`versions` ;

CREATE TABLE IF NOT EXISTS `AA_AUDIT`.`versions` (
  `version` INT NOT NULL,
  `date_created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `comments` BLOB NULL,
  PRIMARY KEY (`version`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AA_AUDIT`.`audits`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AA_AUDIT`.`audits` ;

CREATE TABLE IF NOT EXISTS `AA_AUDIT`.`audits` (
  `audit_id` INT NOT NULL,
  `audit_date` DATETIME NULL,
  `revision_num` INT NOT NULL,
  `facilities_facility_id` INT NOT NULL,
  `versions_version` INT NOT NULL,
  PRIMARY KEY (`audit_id`, `revision_num`, `facilities_facility_id`, `versions_version`),
  INDEX `fk_audits_facilities1_idx` (`facilities_facility_id` ASC) VISIBLE,
  INDEX `fk_audits_versions1_idx` (`versions_version` ASC) VISIBLE,
  CONSTRAINT `fk_audits_facilities1`
    FOREIGN KEY (`facilities_facility_id`)
    REFERENCES `AA_AUDIT`.`facilities` (`facility_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_audits_versions1`
    FOREIGN KEY (`versions_version`)
    REFERENCES `AA_AUDIT`.`versions` (`version`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AA_AUDIT`.`auditors`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AA_AUDIT`.`auditors` ;

CREATE TABLE IF NOT EXISTS `AA_AUDIT`.`auditors` (
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `employee_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`employee_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AA_AUDIT`.`reports`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AA_AUDIT`.`reports` ;

CREATE TABLE IF NOT EXISTS `AA_AUDIT`.`reports` (
  `report_id` INT NOT NULL,
  `reporting_date` DATETIME NULL,
  `report_document` VARCHAR(45) NULL,
  PRIMARY KEY (`report_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AA_AUDIT`.`linac_models`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AA_AUDIT`.`linac_models` ;

CREATE TABLE IF NOT EXISTS `AA_AUDIT`.`linac_models` (
  `linac_model_id` INT NOT NULL,
  `manufacturer` VARCHAR(45) NULL,
  `model` VARCHAR(45) NULL,
  PRIMARY KEY (`linac_model_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AA_AUDIT`.`planning_systems`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AA_AUDIT`.`planning_systems` ;

CREATE TABLE IF NOT EXISTS `AA_AUDIT`.`planning_systems` (
  `ps_id` INT NOT NULL,
  `manufacturer` VARCHAR(45) NULL,
  `name` VARCHAR(45) NULL,
  `version` VARCHAR(45) NULL,
  PRIMARY KEY (`ps_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AA_AUDIT`.`phantoms`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AA_AUDIT`.`phantoms` ;

CREATE TABLE IF NOT EXISTS `AA_AUDIT`.`phantoms` (
  `phantom_id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`phantom_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AA_AUDIT`.`audits_has_auditors`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AA_AUDIT`.`audits_has_auditors` ;

CREATE TABLE IF NOT EXISTS `AA_AUDIT`.`audits_has_auditors` (
  `audits_audit_id` INT NOT NULL,
  `audits_facilities_facility_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`audits_audit_id`, `audits_facilities_facility_id`),
  INDEX `fk_audits_has_auditors_auditors1_idx` (`audits_facilities_facility_id` ASC) VISIBLE,
  INDEX `fk_audits_has_auditors_audits1_idx` (`audits_audit_id` ASC) VISIBLE,
  CONSTRAINT `fk_audits_has_auditors_audits1`
    FOREIGN KEY (`audits_audit_id`)
    REFERENCES `AA_AUDIT`.`audits` (`audit_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_audits_has_auditors_auditors1`
    FOREIGN KEY (`audits_facilities_facility_id`)
    REFERENCES `AA_AUDIT`.`auditors` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AA_AUDIT`.`audits_has_reports`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AA_AUDIT`.`audits_has_reports` ;

CREATE TABLE IF NOT EXISTS `AA_AUDIT`.`audits_has_reports` (
  `audits_audit_id` INT NOT NULL,
  `reports_report_id` INT NOT NULL,
  PRIMARY KEY (`audits_audit_id`, `reports_report_id`),
  INDEX `fk_audits_has_reports_reports1_idx` (`reports_report_id` ASC) VISIBLE,
  INDEX `fk_audits_has_reports_audits1_idx` (`audits_audit_id` ASC) VISIBLE,
  CONSTRAINT `fk_audits_has_reports_audits1`
    FOREIGN KEY (`audits_audit_id`)
    REFERENCES `AA_AUDIT`.`audits` (`audit_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_audits_has_reports_reports1`
    FOREIGN KEY (`reports_report_id`)
    REFERENCES `AA_AUDIT`.`reports` (`report_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AA_AUDIT`.`cases`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AA_AUDIT`.`cases` ;

CREATE TABLE IF NOT EXISTS `AA_AUDIT`.`cases` (
  `case_id` INT NOT NULL,
  `description` VARCHAR(45) NULL,
  PRIMARY KEY (`case_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AA_AUDIT`.`beams`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AA_AUDIT`.`beams` ;

CREATE TABLE IF NOT EXISTS `AA_AUDIT`.`beams` (
  `beam_id` INT NOT NULL,
  `descriptiotn` VARCHAR(45) NULL,
  `direction` VARCHAR(45) NULL,
  PRIMARY KEY (`beam_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AA_AUDIT`.`points`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AA_AUDIT`.`points` ;

CREATE TABLE IF NOT EXISTS `AA_AUDIT`.`points` (
  `point` INT NOT NULL,
  `position` VARCHAR(45) NULL,
  PRIMARY KEY (`point`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AA_AUDIT`.`energy_level`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AA_AUDIT`.`energy_level` ;

CREATE TABLE IF NOT EXISTS `AA_AUDIT`.`energy_level` (
  `energy_level` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`energy_level`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AA_AUDIT`.`results`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AA_AUDIT`.`results` ;

CREATE TABLE IF NOT EXISTS `AA_AUDIT`.`results` (
  `result_id` INT NOT NULL,
  `points_point` INT NOT NULL,
  `beams_beam_id` INT NOT NULL,
  `cases_case_id` INT NOT NULL,
  `measured_current` VARCHAR(45) NULL,
  `audits_audit_id` INT NOT NULL,
  `audits_revision_num` INT NOT NULL,
  `predicted_current` VARCHAR(45) NULL,
  `energy_level_energy_level` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`result_id`, `points_point`, `beams_beam_id`, `cases_case_id`, `audits_audit_id`, `audits_revision_num`, `energy_level_energy_level`),
  INDEX `fk_results_points1_idx` (`points_point` ASC) VISIBLE,
  INDEX `fk_results_beams1_idx` (`beams_beam_id` ASC) VISIBLE,
  INDEX `fk_results_cases1_idx` (`cases_case_id` ASC) VISIBLE,
  INDEX `fk_results_audits1_idx` (`audits_audit_id` ASC, `audits_revision_num` ASC) VISIBLE,
  INDEX `fk_results_energy_level1_idx` (`energy_level_energy_level` ASC) VISIBLE,
  CONSTRAINT `fk_results_points1`
    FOREIGN KEY (`points_point`)
    REFERENCES `AA_AUDIT`.`points` (`point`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_results_beams1`
    FOREIGN KEY (`beams_beam_id`)
    REFERENCES `AA_AUDIT`.`beams` (`beam_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_results_cases1`
    FOREIGN KEY (`cases_case_id`)
    REFERENCES `AA_AUDIT`.`cases` (`case_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_results_audits1`
    FOREIGN KEY (`audits_audit_id` , `audits_revision_num`)
    REFERENCES `AA_AUDIT`.`audits` (`audit_id` , `revision_num`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_results_energy_level1`
    FOREIGN KEY (`energy_level_energy_level`)
    REFERENCES `AA_AUDIT`.`energy_level` (`energy_level`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AA_AUDIT`.`facilities_has_linacs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AA_AUDIT`.`facilities_has_linacs` ;

CREATE TABLE IF NOT EXISTS `AA_AUDIT`.`facilities_has_linacs` (
  `facilities_facility_id` INT NOT NULL,
  `linacs_linac_model_id` INT NOT NULL,
  `linac_serial_number` VARCHAR(45) NULL,
  `linac_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`linac_id`, `linacs_linac_model_id`, `facilities_facility_id`),
  INDEX `fk_facilities_has_linacs_linacs1_idx` (`linacs_linac_model_id` ASC) VISIBLE,
  INDEX `fk_facilities_has_linacs_facilities1_idx` (`facilities_facility_id` ASC) VISIBLE,
  CONSTRAINT `fk_facilities_has_linacs_facilities1`
    FOREIGN KEY (`facilities_facility_id`)
    REFERENCES `AA_AUDIT`.`facilities` (`facility_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_facilities_has_linacs_linacs1`
    FOREIGN KEY (`linacs_linac_model_id`)
    REFERENCES `AA_AUDIT`.`linac_models` (`linac_model_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AA_AUDIT`.`facilities_has_planning_systems`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AA_AUDIT`.`facilities_has_planning_systems` ;

CREATE TABLE IF NOT EXISTS `AA_AUDIT`.`facilities_has_planning_systems` (
  `facilities_facility_id` INT NOT NULL,
  `planning_systems_ps_id` INT NOT NULL,
  PRIMARY KEY (`facilities_facility_id`, `planning_systems_ps_id`),
  INDEX `fk_facilities_has_planning_systems_planning_systems1_idx` (`planning_systems_ps_id` ASC) VISIBLE,
  INDEX `fk_facilities_has_planning_systems_facilities1_idx` (`facilities_facility_id` ASC) VISIBLE,
  CONSTRAINT `fk_facilities_has_planning_systems_facilities1`
    FOREIGN KEY (`facilities_facility_id`)
    REFERENCES `AA_AUDIT`.`facilities` (`facility_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_facilities_has_planning_systems_planning_systems1`
    FOREIGN KEY (`planning_systems_ps_id`)
    REFERENCES `AA_AUDIT`.`planning_systems` (`ps_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AA_AUDIT`.`trs_398_method`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AA_AUDIT`.`trs_398_method` ;

CREATE TABLE IF NOT EXISTS `AA_AUDIT`.`trs_398_method` (
  `method_id` INT NOT NULL,
  `description` VARCHAR(45) NULL,
  PRIMARY KEY (`method_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AA_AUDIT`.`ct_models`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AA_AUDIT`.`ct_models` ;

CREATE TABLE IF NOT EXISTS `AA_AUDIT`.`ct_models` (
  `ct_model_id` INT NOT NULL,
  `manufacturer` VARCHAR(45) NULL,
  `model` VARCHAR(45) NULL,
  PRIMARY KEY (`ct_model_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AA_AUDIT`.`facilities_has_cts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AA_AUDIT`.`facilities_has_cts` ;

CREATE TABLE IF NOT EXISTS `AA_AUDIT`.`facilities_has_cts` (
  `ct_id` VARCHAR(45) NOT NULL,
  `ct_models_ct_model_id` INT NOT NULL,
  `facilities_facility_id` INT NOT NULL,
  PRIMARY KEY (`ct_id`, `ct_models_ct_model_id`, `facilities_facility_id`),
  INDEX `fk_facilities_has_cts_ct_models1_idx` (`ct_models_ct_model_id` ASC) VISIBLE,
  INDEX `fk_facilities_has_cts_facilities1_idx` (`facilities_facility_id` ASC) VISIBLE,
  CONSTRAINT `fk_facilities_has_cts_ct_models1`
    FOREIGN KEY (`ct_models_ct_model_id`)
    REFERENCES `AA_AUDIT`.`ct_models` (`ct_model_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_facilities_has_cts_facilities1`
    FOREIGN KEY (`facilities_facility_id`)
    REFERENCES `AA_AUDIT`.`facilities` (`facility_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AA_AUDIT`.`planning_system_algorithm`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AA_AUDIT`.`planning_system_algorithm` ;

CREATE TABLE IF NOT EXISTS `AA_AUDIT`.`planning_system_algorithm` (
  `algorithm_id` INT NOT NULL,
  `algorithm_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`algorithm_id`),
  UNIQUE INDEX `algorithm_name_UNIQUE` (`algorithm_name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AA_AUDIT`.`facility_stated`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AA_AUDIT`.`facility_stated` ;

CREATE TABLE IF NOT EXISTS `AA_AUDIT`.`facility_stated` (
  `audits_audit_id` INT NOT NULL,
  `facilities_has_linacs_linac_id` VARCHAR(45) NOT NULL,
  `facilities_facility_id` INT NOT NULL,
  `trs_398_method_method_id` INT NOT NULL,
  `dose` VARCHAR(45) NULL,
  `facilities_has_planning_systems_planning_system_id` VARCHAR(45) NOT NULL,
  `facilities_has_cts_ct_id` VARCHAR(45) NOT NULL,
  `energy_level_energy_level` VARCHAR(45) NOT NULL,
  `planning_system_algorithm_algorithm_id` INT NOT NULL,
  `phantoms_phantom_id` INT NOT NULL,
  `facilities_has_planning_systems_planning_systems_ps_id` INT NOT NULL,
  PRIMARY KEY (`audits_audit_id`, `facilities_has_linacs_linac_id`, `facilities_facility_id`, `trs_398_method_method_id`, `facilities_has_planning_systems_planning_system_id`, `facilities_has_cts_ct_id`, `energy_level_energy_level`, `planning_system_algorithm_algorithm_id`, `phantoms_phantom_id`, `facilities_has_planning_systems_planning_systems_ps_id`),
  INDEX `fk_facility_stated_rename_facilities_has_linacs1_idx` (`facilities_has_linacs_linac_id` ASC) VISIBLE,
  INDEX `fk_facility_stated_rename_facilities1_idx` (`facilities_facility_id` ASC) VISIBLE,
  INDEX `fk_facility_stated_rename_trs_398_method1_idx` (`trs_398_method_method_id` ASC) VISIBLE,
  INDEX `fk_facility_stated_facilities_has_cts1_idx` (`facilities_has_cts_ct_id` ASC) VISIBLE,
  INDEX `fk_facility_stated_energy_level1_idx` (`energy_level_energy_level` ASC) VISIBLE,
  INDEX `fk_facility_stated_planning_system_algorithm1_idx` (`planning_system_algorithm_algorithm_id` ASC) VISIBLE,
  INDEX `fk_facility_stated_phantoms1_idx` (`phantoms_phantom_id` ASC) VISIBLE,
  INDEX `fk_facility_stated_facilities_has_planning_systems1_idx` (`facilities_has_planning_systems_planning_systems_ps_id` ASC) VISIBLE,
  CONSTRAINT `fk_facility_stated_rename_audits1`
    FOREIGN KEY (`audits_audit_id`)
    REFERENCES `AA_AUDIT`.`audits` (`audit_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_facility_stated_rename_facilities_has_linacs1`
    FOREIGN KEY (`facilities_has_linacs_linac_id`)
    REFERENCES `AA_AUDIT`.`facilities_has_linacs` (`linac_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_facility_stated_rename_facilities1`
    FOREIGN KEY (`facilities_facility_id`)
    REFERENCES `AA_AUDIT`.`facilities` (`facility_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_facility_stated_rename_trs_398_method1`
    FOREIGN KEY (`trs_398_method_method_id`)
    REFERENCES `AA_AUDIT`.`trs_398_method` (`method_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_facility_stated_facilities_has_cts1`
    FOREIGN KEY (`facilities_has_cts_ct_id`)
    REFERENCES `AA_AUDIT`.`facilities_has_cts` (`ct_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_facility_stated_energy_level1`
    FOREIGN KEY (`energy_level_energy_level`)
    REFERENCES `AA_AUDIT`.`energy_level` (`energy_level`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_facility_stated_planning_system_algorithm1`
    FOREIGN KEY (`planning_system_algorithm_algorithm_id`)
    REFERENCES `AA_AUDIT`.`planning_system_algorithm` (`algorithm_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_facility_stated_phantoms1`
    FOREIGN KEY (`phantoms_phantom_id`)
    REFERENCES `AA_AUDIT`.`phantoms` (`phantom_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_facility_stated_facilities_has_planning_systems1`
    FOREIGN KEY (`facilities_has_planning_systems_planning_systems_ps_id`)
    REFERENCES `AA_AUDIT`.`facilities_has_planning_systems` (`planning_systems_ps_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AA_AUDIT`.`constant_values`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AA_AUDIT`.`constant_values` ;

CREATE TABLE IF NOT EXISTS `AA_AUDIT`.`constant_values` (
  `constant_id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `value` JSON NULL,
  `date_inserted` DATETIME NULL,
  `versions_version` INT NOT NULL,
  PRIMARY KEY (`constant_id`, `versions_version`),
  INDEX `fk_constant_values_versions1_idx` (`versions_version` ASC) VISIBLE,
  CONSTRAINT `fk_constant_values_versions1`
    FOREIGN KEY (`versions_version`)
    REFERENCES `AA_AUDIT`.`versions` (`version`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;



----------------------------------------------------------
----------------------------------------------------------
--  INSERTING DATA
----------------------------------------------------------
----------------------------------------------------------



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
INSERT INTO `auditors` VALUES ('Bec','Sandoval','1'),('Onno','Hoffman','10'),('Eric','Thorne','11'),('Daisy','Norman','2'),('Tina','Le','3'),('John','Vargas','4'),('Terry','Byrne','5'),('Nina','Hicks','6'),('Velvet','Steele','7'),('Clem','Estrada','8'),('Robert','Jennings','9');
/*!40000 ALTER TABLE `auditors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `audits`
--

LOCK TABLES `audits` WRITE;
/*!40000 ALTER TABLE `audits` DISABLE KEYS */;
/*!40000 ALTER TABLE `audits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `audits_has_auditors`
--

LOCK TABLES `audits_has_auditors` WRITE;
/*!40000 ALTER TABLE `audits_has_auditors` DISABLE KEYS */;
/*!40000 ALTER TABLE `audits_has_auditors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `audits_has_reports`
--

LOCK TABLES `audits_has_reports` WRITE;
/*!40000 ALTER TABLE `audits_has_reports` DISABLE KEYS */;
/*!40000 ALTER TABLE `audits_has_reports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `beams`
--

LOCK TABLES `beams` WRITE;
/*!40000 ALTER TABLE `beams` DISABLE KEYS */;
INSERT INTO `beams` VALUES (1,'1',NULL),(2,'Chair',NULL),(3,'Comb',NULL),(4,'IMRT',NULL),(5,'VMAT',NULL);
/*!40000 ALTER TABLE `beams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `cases`
--

LOCK TABLES `cases` WRITE;
/*!40000 ALTER TABLE `cases` DISABLE KEYS */;
INSERT INTO `cases` VALUES (1,'Foo'),(5,'Bar'),(6,'Baz'),(7,'Qux'),(8,'Corge');
/*!40000 ALTER TABLE `cases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `constant_values`
--

LOCK TABLES `constant_values` WRITE;
/*!40000 ALTER TABLE `constant_values` DISABLE KEYS */;
/*!40000 ALTER TABLE `constant_values` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `ct_models`
--

LOCK TABLES `ct_models` WRITE;
/*!40000 ALTER TABLE `ct_models` DISABLE KEYS */;
INSERT INTO `ct_models` VALUES (1,'GE','750 HD'),(2,'GE','Optima 660'),(3,'GE','LightSpeed 16'),(4,'Philips','iCT'),(5,'Philips','MX 16'),(6,'Siemens','Senstation'),(7,'Siemens','Scope 16'),(8,'Toshiba','Prime 160'),(9,'Toshiba','Aquilion 8'),(10,'GE','BrightSpeed Edge 8');
/*!40000 ALTER TABLE `ct_models` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `energy_level`
--

LOCK TABLES `energy_level` WRITE;
/*!40000 ALTER TABLE `energy_level` DISABLE KEYS */;
INSERT INTO `energy_level` VALUES ('10'),('10FFF'),('15'),('6'),('6FFF');
/*!40000 ALTER TABLE `energy_level` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `facilities`
--

LOCK TABLES `facilities` WRITE;
/*!40000 ALTER TABLE `facilities` DISABLE KEYS */;
INSERT INTO `facilities` VALUES (2,'Appenzeller Dog','QLD','Some Fake Street',4),(3,'Antelope','NSW','Some Fake Street',4),(5,'Ainu Dog','NZ','Some Fake Street',1),(7,'Asian Palm Civet','NSW','Some Fake Street',1),(8,'American Bulldog','ACT','Some Fake Street',4),(9,'Ant','VIC','Some Fake Street',1),(10,'Avocet','VIC','Some Fake Street',4),(13,'American Water Spaniel','SA','Some Fake Street',4),(14,'American Staffordshire Terrier','QLD','Some Fake Street',1),(15,'African Palm Civet','QLD','Some Fake Street',2),(16,'Arctic Hare','SA','Some Fake Street',1),(20,'Australian Kelpie Dog','NT','Some Fake Street',4),(24,'Barracuda','VIC','Some Fake Street',1),(25,'Amur Leopard','NT','Some Fake Street',2),(28,'African Tree Toad','SA','Some Fake Street',1),(30,'African Penguin','WA','Some Fake Street',3),(34,'African Wild Dog','ACT','Some Fake Street',4),(37,'American Coonhound','NZ','Some Fake Street',1),(41,'Badger','SA','Some Fake Street',3),(44,'American Pit Bull Terrier','NSW','Some Fake Street',3),(45,'American Cocker Spaniel','NT','Some Fake Street',1),(47,'Alaskan Malamute','NSW','Some Fake Street',2),(48,'Akita','VIC','Some Fake Street',1),(49,'Banded Palm Civet','NZ','Some Fake Street',4),(50,'Arctic Wolf','ACT','Some Fake Street',2),(51,'Axolotl','QLD','Some Fake Street',1),(54,'Australian Cattle Dog','ACT','Some Fake Street',1),(55,'American Eskimo Dog','VIC','Some Fake Street',2),(55,'Australian Shepherd','NZ','Some Fake Street',4),(56,'Asiatic Black Bear','QLD','Some Fake Street',1),(57,'Albatross','QLD','Some Fake Street',3),(57,'Beagle','NT','Some Fake Street',4),(58,'Alpine Dachsbracke','SA','Some Fake Street',4),(61,'Beaver','NSW','Some Fake Street',4),(63,'Birds Of Paradise','ACT','Some Fake Street',2),(65,'Bear','NZ','Some Fake Street',1),(66,'African Clawed Frog','VIC','Some Fake Street',1),(70,'African Forest Elephant','NSW','Some Fake Street',1),(73,'Angelfish','NZ','Some Fake Street',3),(74,'Asian Giant Hornet','NZ','Some Fake Street',4),(80,'Bearded Dragon','VIC','Some Fake Street',2),(81,'Bedlington Terrier','QLD','Some Fake Street',4),(90,'Boykin Spaniel','NZ','Some Fake Street',4);
/*!40000 ALTER TABLE `facilities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `facilities_has_cts`
--

LOCK TABLES `facilities_has_cts` WRITE;
/*!40000 ALTER TABLE `facilities_has_cts` DISABLE KEYS */;
/*!40000 ALTER TABLE `facilities_has_cts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `facilities_has_linacs`
--

LOCK TABLES `facilities_has_linacs` WRITE;
/*!40000 ALTER TABLE `facilities_has_linacs` DISABLE KEYS */;
INSERT INTO `facilities_has_linacs` VALUES (90,1,'DFDSFDS',''),(66,1,'SN56168','1'),(48,3,'PQNVG','10'),(47,1,'P12547','11'),(57,2,'BGTRE','12'),(58,1,'MGAREW','13'),(8,1,'876878','14'),(37,5,'34567','15'),(55,3,'LOPPIY','16'),(44,2,'09364','17'),(14,5,'HIBHIV','18'),(13,5,'7896325','19'),(70,2,'DBJDKJB','2'),(25,3,'65156','20'),(25,3,'65157','21'),(73,4,'VBNHGF','22'),(9,4,'UIGIG','23'),(3,2,'POPOJ','24'),(2,2,'GHFGHF','25'),(16,2,'DGFDGFDGD','26'),(50,1,'GHFGHFGH','27'),(74,1,'87TG8G86F','28'),(7,1,'GHGFHFGT55','29'),(15,3,'SN-789456','3'),(56,2,'QWEPOICV','30'),(54,3,'3657895','31'),(20,5,'GHGFH','32'),(55,5,'DSFDSF','33'),(55,5,'ERWEF','34'),(10,1,'453453','35'),(51,1,'FDGDFGD','36'),(41,1,'FGDFGHDF','37'),(49,3,'DSFSDFEFGR','38'),(24,2,'342423424','39'),(15,1,'SN96611','4'),(57,4,'4543543567','40'),(65,1,'FHGGFJHF','41'),(80,2,'656565656565','42'),(61,3,'7845151','43'),(81,4,'LOIJJHH','44'),(63,5,'POYRED','45'),(30,4,'KDDDFD','5'),(30,5,'789555','6'),(28,1,'SNJKBKJBK','7'),(34,2,'435345','8'),(5,2,'PLOIDD','9');
/*!40000 ALTER TABLE `facilities_has_linacs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `facilities_has_planning_systems`
--

LOCK TABLES `facilities_has_planning_systems` WRITE;
/*!40000 ALTER TABLE `facilities_has_planning_systems` DISABLE KEYS */;
/*!40000 ALTER TABLE `facilities_has_planning_systems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `facility_operator`
--

LOCK TABLES `facility_operator` WRITE;
/*!40000 ALTER TABLE `facility_operator` DISABLE KEYS */;
INSERT INTO `facility_operator` VALUES (1,'Operator A','123456','public'),(2,'Operator B ','234567','private'),(3,'Operator C','789456','public'),(4,'Operator D','591357',NULL);
/*!40000 ALTER TABLE `facility_operator` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `facility_stated`
--

LOCK TABLES `facility_stated` WRITE;
/*!40000 ALTER TABLE `facility_stated` DISABLE KEYS */;
/*!40000 ALTER TABLE `facility_stated` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `linac_models`
--

LOCK TABLES `linac_models` WRITE;
/*!40000 ALTER TABLE `linac_models` DISABLE KEYS */;
INSERT INTO `linac_models` VALUES (1,'Elekta','Axesse'),(2,'Accuray','CyberKnife'),(3,'Accuray','Tomotherapy'),(4,'Varian','Halcyon'),(5,'Neusoft','NMSR600');
/*!40000 ALTER TABLE `linac_models` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `phantoms`
--

LOCK TABLES `phantoms` WRITE;
/*!40000 ALTER TABLE `phantoms` DISABLE KEYS */;
INSERT INTO `phantoms` VALUES (1,'Max'),(2,'Red Anne'),(3,'Yellow Anne');
/*!40000 ALTER TABLE `phantoms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `planning_system_algorithm`
--

LOCK TABLES `planning_system_algorithm` WRITE;
/*!40000 ALTER TABLE `planning_system_algorithm` DISABLE KEYS */;
/*!40000 ALTER TABLE `planning_system_algorithm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `planning_systems`
--

LOCK TABLES `planning_systems` WRITE;
/*!40000 ALTER TABLE `planning_systems` DISABLE KEYS */;
INSERT INTO `planning_systems` VALUES (0,'RAV','Eth',NULL),(1,'RAV','Sun',NULL),(2,'IHP','Mountain',NULL),(3,'LEK','Sea',NULL),(4,'LEK','Land',NULL),(5,'Bra','iPL',NULL),(6,'URA','Pre',NULL),(7,'URA','Animal',NULL);
/*!40000 ALTER TABLE `planning_systems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `points`
--

LOCK TABLES `points` WRITE;
/*!40000 ALTER TABLE `points` DISABLE KEYS */;
INSERT INTO `points` VALUES (1,NULL),(3,NULL),(5,NULL),(8,NULL),(10,NULL),(11,NULL),(12,NULL),(13,NULL),(14,NULL),(15,NULL),(16,NULL),(17,NULL),(18,NULL),(19,NULL),(20,NULL);
/*!40000 ALTER TABLE `points` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `reports`
--

LOCK TABLES `reports` WRITE;
/*!40000 ALTER TABLE `reports` DISABLE KEYS */;
/*!40000 ALTER TABLE `reports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `results`
--

LOCK TABLES `results` WRITE;
/*!40000 ALTER TABLE `results` DISABLE KEYS */;
/*!40000 ALTER TABLE `results` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `trs_398_method`
--

LOCK TABLES `trs_398_method` WRITE;
/*!40000 ALTER TABLE `trs_398_method` DISABLE KEYS */;
INSERT INTO `trs_398_method` VALUES (1,'Daily Output (cGy/MU)'),(2,NULL);
/*!40000 ALTER TABLE `trs_398_method` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `versions`
--

LOCK TABLES `versions` WRITE;
/*!40000 ALTER TABLE `versions` DISABLE KEYS */;
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

-- Dump completed on 2020-09-22 20:32:59
