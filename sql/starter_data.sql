-- MariaDB dump 10.19  Distrib 10.5.9-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: nbiadb
-- ------------------------------------------------------
-- Server version	10.5.9-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES UTF8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `annotation`
--

DROP TABLE IF EXISTS `annotation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `annotation` (
  `file_path` varchar(300) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `file_size` bigint(20) DEFAULT NULL,
  `annotation_type` varchar(30) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `series_instance_uid` varchar(300) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `general_series_pk_id` bigint(20) DEFAULT NULL,
  `annotations_pk_id` bigint(20) NOT NULL,
  `submission_date` datetime DEFAULT NULL,
  PRIMARY KEY (`annotations_pk_id`),
  UNIQUE KEY `PK_ANNOTATIONS_PK_ID` (`annotations_pk_id`),
  KEY `fk_ann_gs_pk_id` (`general_series_pk_id`),
  KEY `annotation_file_size` (`file_size`),
  KEY `annotations_submitted_date_idx` (`submission_date`),
  CONSTRAINT `fk_ann_gs_pk_id` FOREIGN KEY (`general_series_pk_id`) REFERENCES `general_series` (`general_series_pk_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `annotation`
--

LOCK TABLES `annotation` WRITE;
/*!40000 ALTER TABLE `annotation` DISABLE KEYS */;
/*!40000 ALTER TABLE `annotation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clinical_trial`
--

DROP TABLE IF EXISTS `clinical_trial`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clinical_trial` (
  `trial_pk_id` bigint(20) NOT NULL,
  `trial_sponsor_name` varchar(64) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `trial_protocol_id` varchar(64) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `trial_protocol_name` varchar(64) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `trial_coordinating_center` varchar(64) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  PRIMARY KEY (`trial_pk_id`),
  UNIQUE KEY `PK_TRIAL_PK_ID` (`trial_pk_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clinical_trial`
--

LOCK TABLES `clinical_trial` WRITE;
/*!40000 ALTER TABLE `clinical_trial` DISABLE KEYS */;
/*!40000 ALTER TABLE `clinical_trial` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clinical_trial_protocol`
--

DROP TABLE IF EXISTS `clinical_trial_protocol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clinical_trial_protocol` (
  `id` bigint(20) NOT NULL,
  `protocol_id` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `protocol_name` varchar(1000) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `clinical_trial_sponsor_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `PK_C_TRIAL_PROTOCOL` (`id`),
  KEY `fk_clin_trial_sponsor_id` (`clinical_trial_sponsor_id`),
  CONSTRAINT `fk_clin_trial_sponsor_id` FOREIGN KEY (`clinical_trial_sponsor_id`) REFERENCES `clinical_trial_sponsor` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clinical_trial_protocol`
--

LOCK TABLES `clinical_trial_protocol` WRITE;
/*!40000 ALTER TABLE `clinical_trial_protocol` DISABLE KEYS */;
/*!40000 ALTER TABLE `clinical_trial_protocol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clinical_trial_sponsor`
--

DROP TABLE IF EXISTS `clinical_trial_sponsor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clinical_trial_sponsor` (
  `id` bigint(20) NOT NULL,
  `coordinating_center` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `sponsor_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `PK_C_TRIAL_SPONSOR` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clinical_trial_sponsor`
--

LOCK TABLES `clinical_trial_sponsor` WRITE;
/*!40000 ALTER TABLE `clinical_trial_sponsor` DISABLE KEYS */;
/*!40000 ALTER TABLE `clinical_trial_sponsor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clinical_trial_subject`
--

DROP TABLE IF EXISTS `clinical_trial_subject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clinical_trial_subject` (
  `id` bigint(20) NOT NULL,
  `trial_subject_id` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `trial_subject_reading_id` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `clinical_trial_protocol_id` bigint(20) NOT NULL,
  `patient_id` bigint(20) NOT NULL,
  `trial_site_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `PK_CLINICAL_TRIAL_SUBJECT` (`id`),
  KEY `fk_clinical_trial_protocol_id` (`clinical_trial_protocol_id`),
  KEY `fk_patient_id` (`patient_id`),
  KEY `fk_trial_site` (`trial_site_id`),
  CONSTRAINT `fk_clinical_trial_protocol_id` FOREIGN KEY (`clinical_trial_protocol_id`) REFERENCES `clinical_trial_protocol` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_pk_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_trial_site` FOREIGN KEY (`trial_site_id`) REFERENCES `trial_site` (`trial_site_pk_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clinical_trial_subject`
--

LOCK TABLES `clinical_trial_subject` WRITE;
/*!40000 ALTER TABLE `clinical_trial_subject` DISABLE KEYS */;
/*!40000 ALTER TABLE `clinical_trial_subject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `collection_descriptions`
--

DROP TABLE IF EXISTS `collection_descriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `collection_descriptions` (
  `collection_descriptions_pk_id` bigint(20) NOT NULL,
  `collection_name` varchar(64) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `user_name` varchar(20) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `description` mediumtext CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `collection_descriptions_timest` date DEFAULT NULL,
  `license_id` bigint(20) DEFAULT NULL,
  `md5hash` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`collection_descriptions_pk_id`),
  UNIQUE KEY `PK_COLLECTION_DESC_PK_ID` (`collection_descriptions_pk_id`),
  KEY `license_id_fk_idx` (`license_id`),
  CONSTRAINT `license_id_fk` FOREIGN KEY (`license_id`) REFERENCES `license` (`license_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `collection_descriptions`
--

LOCK TABLES `collection_descriptions` WRITE;
/*!40000 ALTER TABLE `collection_descriptions` DISABLE KEYS */;
INSERT INTO `collection_descriptions` VALUES (1,'Public','nbiaAdmin','The public collection<br>','2022-02-19',1,'47de399d506b727c980213642ff196c6');
/*!40000 ALTER TABLE `collection_descriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `csm_application`
--

DROP TABLE IF EXISTS `csm_application`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `csm_application` (
  `APPLICATION_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `APPLICATION_NAME` varchar(255) NOT NULL,
  `APPLICATION_DESCRIPTION` varchar(200) NOT NULL,
  `DECLARATIVE_FLAG` tinyint(1) NOT NULL DEFAULT 0,
  `ACTIVE_FLAG` tinyint(1) NOT NULL DEFAULT 0,
  `UPDATE_DATE` date NOT NULL DEFAULT '1950-01-01',
  `DATABASE_URL` varchar(100) DEFAULT NULL,
  `DATABASE_USER_NAME` varchar(100) DEFAULT NULL,
  `DATABASE_PASSWORD` varchar(100) DEFAULT NULL,
  `DATABASE_DIALECT` varchar(100) DEFAULT NULL,
  `DATABASE_DRIVER` varchar(100) DEFAULT NULL,
  `CSM_VERSION` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`APPLICATION_ID`),
  UNIQUE KEY `UQ_APPLICATION_NAME` (`APPLICATION_NAME`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `csm_application`
--

LOCK TABLES `csm_application` WRITE;
/*!40000 ALTER TABLE `csm_application` DISABLE KEYS */;
INSERT INTO `csm_application` VALUES (1,'csmupt','CSM UPT Super Admin Application',0,0,'2022-02-19',NULL,NULL,NULL,NULL,NULL,NULL),(2,'NCIA','Application Description',0,0,'2022-02-19',NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `csm_application` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `csm_configuration_props`
--

DROP TABLE IF EXISTS `csm_configuration_props`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `csm_configuration_props` (
  `PROPERTY_KEY` varchar(300) NOT NULL,
  `PROPERTY_VALUE` varchar(3000) DEFAULT NULL,
  PRIMARY KEY (`PROPERTY_KEY`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `csm_configuration_props`
--

LOCK TABLES `csm_configuration_props` WRITE;
/*!40000 ALTER TABLE `csm_configuration_props` DISABLE KEYS */;
INSERT INTO `csm_configuration_props` VALUES ('AES_ENCRYPTION_KEY','super secret'),('ALLOWED_ATTEMPTS','3'),('ALLOWED_LOGIN_TIME','600000'),('MD5_HASH_KEY','true'),('PASSWORD_EXPIRY_DAYS','60'),('PASSWORD_LOCKOUT_TIME','1800000'),('PASSWORD_MATCH_NUM','24'),('PASSWORD_PATTERN_DESCRIPTION','At least one Upper case alphabet, at least one lower case alphabet, at least one number and minimum 8 characters length'),('PASSWORD_PATTERN_MATCH','^.*(?=.{8,})(?=..*[0-9])(?=.*[a-z])(?=.*[A-Z]).*$');
/*!40000 ALTER TABLE `csm_configuration_props` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `csm_filter_clause`
--

DROP TABLE IF EXISTS `csm_filter_clause`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `csm_filter_clause` (
  `FILTER_CLAUSE_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `CLASS_NAME` varchar(100) NOT NULL,
  `FILTER_CHAIN` varchar(2000) NOT NULL,
  `TARGET_CLASS_NAME` varchar(100) NOT NULL,
  `TARGET_CLASS_ATTRIBUTE_NAME` varchar(100) NOT NULL,
  `TARGET_CLASS_ATTRIBUTE_TYPE` varchar(100) NOT NULL,
  `TARGET_CLASS_ALIAS` varchar(100) DEFAULT NULL,
  `TARGET_CLASS_ATTRIBUTE_ALIAS` varchar(100) DEFAULT NULL,
  `GENERATED_SQL_USER` varchar(4000) NOT NULL,
  `APPLICATION_ID` bigint(20) NOT NULL,
  `UPDATE_DATE` date NOT NULL,
  `GENERATED_SQL_GROUP` varchar(4000) NOT NULL,
  PRIMARY KEY (`FILTER_CLAUSE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `csm_filter_clause`
--

LOCK TABLES `csm_filter_clause` WRITE;
/*!40000 ALTER TABLE `csm_filter_clause` DISABLE KEYS */;
/*!40000 ALTER TABLE `csm_filter_clause` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `csm_group`
--

DROP TABLE IF EXISTS `csm_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `csm_group` (
  `GROUP_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `GROUP_NAME` varchar(255) NOT NULL,
  `GROUP_DESC` varchar(200) DEFAULT NULL,
  `UPDATE_DATE` date NOT NULL DEFAULT '1950-01-01',
  `APPLICATION_ID` bigint(20) NOT NULL,
  PRIMARY KEY (`GROUP_ID`),
  UNIQUE KEY `UQ_GROUP_GROUP_NAME` (`APPLICATION_ID`,`GROUP_NAME`),
  KEY `idx_APPLICATION_ID` (`APPLICATION_ID`),
  CONSTRAINT `FK_APPLICATION_GROUP` FOREIGN KEY (`APPLICATION_ID`) REFERENCES `csm_application` (`APPLICATION_ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `csm_group`
--

LOCK TABLES `csm_group` WRITE;
/*!40000 ALTER TABLE `csm_group` DISABLE KEYS */;
INSERT INTO `csm_group` VALUES (1,'General User','Public user group','2022-02-19',2),(2,'readers','readers','2022-02-19',2);
/*!40000 ALTER TABLE `csm_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `csm_mapping`
--

DROP TABLE IF EXISTS `csm_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `csm_mapping` (
  `MAPPING_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `APPLICATION_ID` bigint(20) NOT NULL,
  `OBJECT_NAME` varchar(100) NOT NULL,
  `ATTRIBUTE_NAME` varchar(100) NOT NULL,
  `OBJECT_PACKAGE_NAME` varchar(100) DEFAULT NULL,
  `TABLE_NAME` varchar(100) DEFAULT NULL,
  `TABLE_NAME_GROUP` varchar(100) DEFAULT NULL,
  `TABLE_NAME_USER` varchar(100) DEFAULT NULL,
  `VIEW_NAME_GROUP` varchar(100) DEFAULT NULL,
  `VIEW_NAME_USER` varchar(100) DEFAULT NULL,
  `ACTIVE_FLAG` tinyint(1) NOT NULL DEFAULT 0,
  `MAINTAINED_FLAG` tinyint(1) NOT NULL DEFAULT 0,
  `UPDATE_DATE` date DEFAULT '0000-00-00',
  PRIMARY KEY (`MAPPING_ID`),
  UNIQUE KEY `UQ_MP_OBJ_NAME_ATTRI_NAME_APP_ID` (`OBJECT_NAME`,`ATTRIBUTE_NAME`,`APPLICATION_ID`),
  KEY `FK_PE_APPLICATION` (`APPLICATION_ID`),
  CONSTRAINT `FK_PE_APPLICATION` FOREIGN KEY (`APPLICATION_ID`) REFERENCES `csm_application` (`APPLICATION_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `csm_mapping`
--

LOCK TABLES `csm_mapping` WRITE;
/*!40000 ALTER TABLE `csm_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `csm_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `csm_password_history`
--

DROP TABLE IF EXISTS `csm_password_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `csm_password_history` (
  `CSM_PASSWORD_HISTORY_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `LOGIN_NAME` varchar(500) DEFAULT NULL,
  `PASSWORD` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`CSM_PASSWORD_HISTORY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `csm_password_history`
--

LOCK TABLES `csm_password_history` WRITE;
/*!40000 ALTER TABLE `csm_password_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `csm_password_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `csm_pg_pe`
--

DROP TABLE IF EXISTS `csm_pg_pe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `csm_pg_pe` (
  `PG_PE_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `PROTECTION_GROUP_ID` bigint(20) NOT NULL,
  `PROTECTION_ELEMENT_ID` bigint(20) NOT NULL,
  `UPDATE_DATE` date DEFAULT '0000-00-00',
  PRIMARY KEY (`PG_PE_ID`),
  UNIQUE KEY `UQ_PROTECTION_GROUP_PROTECTION_ELEMENT_PROTECTION_GROUP_ID` (`PROTECTION_ELEMENT_ID`,`PROTECTION_GROUP_ID`),
  KEY `idx_PROTECTION_ELEMENT_ID` (`PROTECTION_ELEMENT_ID`),
  KEY `idx_PROTECTION_GROUP_ID` (`PROTECTION_GROUP_ID`),
  CONSTRAINT `FK_PROTECTION_ELEMENT_PROTECTION_GROUP` FOREIGN KEY (`PROTECTION_ELEMENT_ID`) REFERENCES `csm_protection_element` (`PROTECTION_ELEMENT_ID`) ON DELETE CASCADE,
  CONSTRAINT `FK_PROTECTION_GROUP_PROTECTION_ELEMENT` FOREIGN KEY (`PROTECTION_GROUP_ID`) REFERENCES `csm_protection_group` (`PROTECTION_GROUP_ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `csm_pg_pe`
--

LOCK TABLES `csm_pg_pe` WRITE;
/*!40000 ALTER TABLE `csm_pg_pe` DISABLE KEYS */;
INSERT INTO `csm_pg_pe` VALUES (1,1,2,'2022-02-19'),(2,2,3,'2022-02-19'),(3,1,4,'2022-02-19'),(4,1,5,'2022-02-19'),(5,2,4,'2022-02-19'),(6,2,5,'2022-02-19');
/*!40000 ALTER TABLE `csm_pg_pe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `csm_privilege`
--

DROP TABLE IF EXISTS `csm_privilege`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `csm_privilege` (
  `PRIVILEGE_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `PRIVILEGE_NAME` varchar(100) NOT NULL,
  `PRIVILEGE_DESCRIPTION` varchar(200) DEFAULT NULL,
  `UPDATE_DATE` date NOT NULL DEFAULT '1950-01-01',
  PRIMARY KEY (`PRIVILEGE_ID`),
  UNIQUE KEY `UQ_PRIVILEGE_NAME` (`PRIVILEGE_NAME`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `csm_privilege`
--

LOCK TABLES `csm_privilege` WRITE;
/*!40000 ALTER TABLE `csm_privilege` DISABLE KEYS */;
INSERT INTO `csm_privilege` VALUES (1,'CREATE','This privilege grants permission to a user to create an entity. This entity can be an object, a database entry, or a resource such as a network connection','2022-02-19'),(2,'ACCESS','This privilege allows a user to access a particular resource.  Examples of resources include a network or database connection, socket, module of the application, or even the application itself','2022-02-19'),(3,'READ','This privilege permits the user to read data from a file, URL, database, an object, etc. This can be used at an entity level signifying that the user is allowed to read data about a particular entry','2022-02-19'),(4,'WRITE','This privilege allows a user to write data to a file, URL, database, an object, etc. This can be used at an entity level signifying that the user is allowed to write data about a particular entity','2022-02-19'),(5,'UPDATE','This privilege grants permission at an entity level and signifies that the user is allowed to update data for a particular entity. Entities may include an object, object attribute, database row etc','2022-02-19'),(6,'DELETE','This privilege permits a user to delete a logical entity. This entity can be an object, a database entry, a resource such as a network connection, etc','2022-02-19'),(7,'EXECUTE','This privilege allows a user to execute a particular resource. The resource can be a method, function, behavior of the application, URL, button etc','2022-02-19');
/*!40000 ALTER TABLE `csm_privilege` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `csm_protection_element`
--

DROP TABLE IF EXISTS `csm_protection_element`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `csm_protection_element` (
  `PROTECTION_ELEMENT_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `PROTECTION_ELEMENT_NAME` varchar(100) NOT NULL,
  `PROTECTION_ELEMENT_DESCRIPTION` varchar(200) DEFAULT NULL,
  `OBJECT_ID` varchar(100) NOT NULL,
  `ATTRIBUTE` varchar(100) DEFAULT NULL,
  `PROTECTION_ELEMENT_TYPE` varchar(100) DEFAULT NULL,
  `APPLICATION_ID` bigint(20) NOT NULL,
  `UPDATE_DATE` date NOT NULL DEFAULT '1950-01-01',
  `ATTRIBUTE_VALUE` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`PROTECTION_ELEMENT_ID`),
  UNIQUE KEY `UQ_PE_PE_NAME_ATTRIBUTE_VALUE_APP_ID` (`OBJECT_ID`,`ATTRIBUTE`,`ATTRIBUTE_VALUE`,`APPLICATION_ID`),
  KEY `idx_APPLICATION_ID` (`APPLICATION_ID`),
  KEY `idx_OBJ_ATTR_APP` (`OBJECT_ID`,`ATTRIBUTE`,`APPLICATION_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `csm_protection_element`
--

LOCK TABLES `csm_protection_element` WRITE;
/*!40000 ALTER TABLE `csm_protection_element` DISABLE KEYS */;
INSERT INTO `csm_protection_element` VALUES (1,'csmupt','CSM UPT Super Admin Application Protection Element','csmupt',NULL,NULL,1,'2022-02-19',NULL),(2,'NCIA','NCIA Admin Application Protection Element','NCIA',NULL,NULL,1,'2022-02-19',NULL),(3,'NCIA.Common_Element','','NCIA.Common_Element',NULL,NULL,2,'2022-02-19',NULL),(4,'NCIA.Public','NCIA.TRIAL_DATA_PROVENANCE','NCIA.Public','NCIA.PROJECT',NULL,2,'2022-02-19',NULL),(5,'NCIA.Public//Public','NCIA.TRIAL_DATA_PROVENANCE','NCIA.Public//Public','NCIA.PROJECT//DP_SITE_NAME',NULL,2,'2022-02-19',NULL);
/*!40000 ALTER TABLE `csm_protection_element` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `csm_protection_group`
--

DROP TABLE IF EXISTS `csm_protection_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `csm_protection_group` (
  `PROTECTION_GROUP_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `PROTECTION_GROUP_NAME` varchar(100) NOT NULL,
  `PROTECTION_GROUP_DESCRIPTION` varchar(200) DEFAULT NULL,
  `APPLICATION_ID` bigint(20) NOT NULL,
  `LARGE_ELEMENT_COUNT_FLAG` tinyint(1) NOT NULL,
  `UPDATE_DATE` date NOT NULL DEFAULT '1950-01-01',
  `PARENT_PROTECTION_GROUP_ID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`PROTECTION_GROUP_ID`),
  UNIQUE KEY `UQ_PROTECTION_GROUP_PROTECTION_GROUP_NAME` (`APPLICATION_ID`,`PROTECTION_GROUP_NAME`),
  KEY `idx_APPLICATION_ID` (`APPLICATION_ID`),
  KEY `idx_PARENT_PROTECTION_GROUP_ID` (`PARENT_PROTECTION_GROUP_ID`),
  CONSTRAINT `FK_PG_APPLICATION` FOREIGN KEY (`APPLICATION_ID`) REFERENCES `csm_application` (`APPLICATION_ID`) ON DELETE CASCADE,
  CONSTRAINT `FK_PROTECTION_GROUP` FOREIGN KEY (`PARENT_PROTECTION_GROUP_ID`) REFERENCES `csm_protection_group` (`PROTECTION_GROUP_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `csm_protection_group`
--

LOCK TABLES `csm_protection_group` WRITE;
/*!40000 ALTER TABLE `csm_protection_group` DISABLE KEYS */;
INSERT INTO `csm_protection_group` VALUES (1,'NCIA.PUBLIC','Public',2,0,'2022-02-19',NULL),(2,'NCIA.Common_PG','',2,0,'2022-02-19',NULL);
/*!40000 ALTER TABLE `csm_protection_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `csm_role`
--

DROP TABLE IF EXISTS `csm_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `csm_role` (
  `ROLE_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ROLE_NAME` varchar(100) NOT NULL,
  `ROLE_DESCRIPTION` varchar(200) DEFAULT NULL,
  `APPLICATION_ID` bigint(20) NOT NULL,
  `ACTIVE_FLAG` tinyint(1) NOT NULL,
  `UPDATE_DATE` date NOT NULL DEFAULT '1950-01-01',
  PRIMARY KEY (`ROLE_ID`),
  UNIQUE KEY `UQ_ROLE_ROLE_NAME` (`APPLICATION_ID`,`ROLE_NAME`),
  KEY `idx_APPLICATION_ID` (`APPLICATION_ID`),
  CONSTRAINT `FK_APPLICATION_ROLE` FOREIGN KEY (`APPLICATION_ID`) REFERENCES `csm_application` (`APPLICATION_ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `csm_role`
--

LOCK TABLES `csm_role` WRITE;
/*!40000 ALTER TABLE `csm_role` DISABLE KEYS */;
INSERT INTO `csm_role` VALUES (1,'NCIA.READ','public role',2,0,'2022-02-19'),(2,'NCIA.ADMIN','UPT access role',2,0,'2022-02-19'),(3,'NCIA.CURATE','Add or modify curation data',2,0,'2022-02-19'),(4,'NCIA.MANAGE_VISIBILITY_STATUS','Manage Visibility Status',2,0,'2022-02-19'),(5,'NCIA.VIEW_SUBMISSION_REPORT','View submission report',2,0,'2022-02-19'),(6,'NCIA.SUPER_CURATOR','Super Admin for approving deletion',2,0,'2022-02-19'),(7,'NCIA.DELETE_ADMIN','Super Admin for deletion',2,0,'2022-02-19'),(8,'NCIA.MANAGE_COLLECTION_DESCRIPTION','Manage collection description',2,0,'2022-02-19');
/*!40000 ALTER TABLE `csm_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `csm_role_privilege`
--

DROP TABLE IF EXISTS `csm_role_privilege`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `csm_role_privilege` (
  `ROLE_PRIVILEGE_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ROLE_ID` bigint(20) NOT NULL,
  `PRIVILEGE_ID` bigint(20) NOT NULL,
  `UPDATE_DATE` date NOT NULL DEFAULT '1950-01-01',
  PRIMARY KEY (`ROLE_PRIVILEGE_ID`),
  UNIQUE KEY `UQ_ROLE_PRIVILEGE_ROLE_ID` (`PRIVILEGE_ID`,`ROLE_ID`),
  KEY `idx_PRIVILEGE_ID` (`PRIVILEGE_ID`),
  KEY `idx_ROLE_ID` (`ROLE_ID`),
  CONSTRAINT `FK_PRIVILEGE_ROLE` FOREIGN KEY (`PRIVILEGE_ID`) REFERENCES `csm_privilege` (`PRIVILEGE_ID`) ON DELETE CASCADE,
  CONSTRAINT `FK_ROLE` FOREIGN KEY (`ROLE_ID`) REFERENCES `csm_role` (`ROLE_ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `csm_role_privilege`
--

LOCK TABLES `csm_role_privilege` WRITE;
/*!40000 ALTER TABLE `csm_role_privilege` DISABLE KEYS */;
INSERT INTO `csm_role_privilege` VALUES (1,1,3,'2022-02-19');
/*!40000 ALTER TABLE `csm_role_privilege` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `csm_user`
--

DROP TABLE IF EXISTS `csm_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `csm_user` (
  `USER_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `LOGIN_NAME` varchar(500) DEFAULT NULL,
  `FIRST_NAME` varchar(100) NOT NULL,
  `LAST_NAME` varchar(100) NOT NULL,
  `ORGANIZATION` varchar(500) DEFAULT NULL,
  `DEPARTMENT` varchar(100) DEFAULT NULL,
  `TITLE` varchar(100) DEFAULT NULL,
  `PHONE_NUMBER` varchar(100) DEFAULT NULL,
  `PASSWORD` varchar(100) DEFAULT NULL,
  `EMAIL_ID` varchar(100) DEFAULT NULL,
  `START_DATE` date DEFAULT NULL,
  `END_DATE` date DEFAULT NULL,
  `UPDATE_DATE` date NOT NULL DEFAULT '1950-01-01',
  `MIDDLE_NAME` varchar(100) DEFAULT NULL,
  `FAX` varchar(20) DEFAULT NULL,
  `ADDRESS` varchar(200) DEFAULT NULL,
  `CITY` varchar(100) DEFAULT NULL,
  `STATE` varchar(100) DEFAULT NULL,
  `COUNTRY` varchar(100) DEFAULT NULL,
  `POSTAL_CODE` varchar(10) DEFAULT NULL,
  `MIGRATED_FLAG` tinyint(1) NOT NULL DEFAULT 0,
  `PREMGRT_LOGIN_NAME` varchar(100) DEFAULT NULL,
  `PASSWORD_EXPIRED` tinyint(1) DEFAULT 0,
  `FIRST_TIME_LOGIN` tinyint(1) DEFAULT 0,
  `ACTIVE_FLAG` tinyint(1) DEFAULT 1,
  `PASSWORD_EXPIRY_DATE` date DEFAULT '2012-10-10',
  PRIMARY KEY (`USER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `csm_user`
--

LOCK TABLES `csm_user` WRITE;
/*!40000 ALTER TABLE `csm_user` DISABLE KEYS */;
INSERT INTO `csm_user` VALUES (1,'nbiaAdmin','FsQcmjeTRwMyYjNa0oHwgA==','qHd6B/O/6sCgHyhdRmAt7Q==',NULL,NULL,NULL,NULL,'5kJqWYBdWCphljGP2pGUGg==','',NULL,NULL,'2022-02-19',NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0,0,1,'2021-11-23'),(2,'nbia_guest','DQ4nFusFQxr7f3z5/qvdhw==','DQ4nFusFQxr7f3z5/qvdhw==',NULL,NULL,NULL,NULL,NULL,'J+U4jOdifJsvA5uICPsem96DzM2a7MkdUeb0eQ3Sr8E=',NULL,NULL,'2022-02-19',NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0,0,1,'2012-10-10');
/*!40000 ALTER TABLE `csm_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `csm_user_group`
--

DROP TABLE IF EXISTS `csm_user_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `csm_user_group` (
  `USER_GROUP_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `USER_ID` bigint(20) NOT NULL,
  `GROUP_ID` bigint(20) NOT NULL,
  PRIMARY KEY (`USER_GROUP_ID`),
  KEY `idx_USER_ID` (`USER_ID`),
  KEY `idx_GROUP_ID` (`GROUP_ID`),
  CONSTRAINT `FK_UG_GROUP` FOREIGN KEY (`GROUP_ID`) REFERENCES `csm_group` (`GROUP_ID`) ON DELETE CASCADE,
  CONSTRAINT `FK_USER_GROUP` FOREIGN KEY (`USER_ID`) REFERENCES `csm_user` (`USER_ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `csm_user_group`
--

LOCK TABLES `csm_user_group` WRITE;
/*!40000 ALTER TABLE `csm_user_group` DISABLE KEYS */;
INSERT INTO `csm_user_group` VALUES (1,1,2);
/*!40000 ALTER TABLE `csm_user_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `csm_user_group_role_pg`
--

DROP TABLE IF EXISTS `csm_user_group_role_pg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `csm_user_group_role_pg` (
  `USER_GROUP_ROLE_PG_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `USER_ID` bigint(20) DEFAULT NULL,
  `GROUP_ID` bigint(20) DEFAULT NULL,
  `ROLE_ID` bigint(20) NOT NULL,
  `PROTECTION_GROUP_ID` bigint(20) NOT NULL,
  `UPDATE_DATE` date NOT NULL DEFAULT '1950-01-01',
  PRIMARY KEY (`USER_GROUP_ROLE_PG_ID`),
  KEY `idx_GROUP_ID` (`GROUP_ID`),
  KEY `idx_ROLE_ID` (`ROLE_ID`),
  KEY `idx_PROTECTION_GROUP_ID` (`PROTECTION_GROUP_ID`),
  KEY `idx_USER_ID` (`USER_ID`),
  CONSTRAINT `FK_USER_GROUP_ROLE_PROTECTION_GROUP_GROUPS` FOREIGN KEY (`GROUP_ID`) REFERENCES `csm_group` (`GROUP_ID`) ON DELETE CASCADE,
  CONSTRAINT `FK_USER_GROUP_ROLE_PROTECTION_GROUP_PROTECTION_GROUP` FOREIGN KEY (`PROTECTION_GROUP_ID`) REFERENCES `csm_protection_group` (`PROTECTION_GROUP_ID`) ON DELETE CASCADE,
  CONSTRAINT `FK_USER_GROUP_ROLE_PROTECTION_GROUP_ROLE` FOREIGN KEY (`ROLE_ID`) REFERENCES `csm_role` (`ROLE_ID`) ON DELETE CASCADE,
  CONSTRAINT `FK_USER_GROUP_ROLE_PROTECTION_GROUP_USER` FOREIGN KEY (`USER_ID`) REFERENCES `csm_user` (`USER_ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `csm_user_group_role_pg`
--

LOCK TABLES `csm_user_group_role_pg` WRITE;
/*!40000 ALTER TABLE `csm_user_group_role_pg` DISABLE KEYS */;
INSERT INTO `csm_user_group_role_pg` VALUES (1,NULL,1,1,1,'2022-02-19'),(2,1,NULL,1,1,'2022-02-19'),(3,1,NULL,2,1,'2022-02-19'),(4,1,NULL,3,1,'2022-02-19'),(5,1,NULL,4,1,'2022-02-19'),(6,1,NULL,5,1,'2022-02-19'),(7,1,NULL,6,1,'2022-02-19'),(8,1,NULL,7,1,'2022-02-19'),(9,1,NULL,8,1,'2022-02-19'),(10,2,NULL,1,1,'2022-02-19'),(11,1,NULL,2,2,'2022-02-19'),(12,1,NULL,3,2,'2022-02-19'),(13,1,NULL,7,2,'2022-02-19'),(14,1,NULL,8,2,'2022-02-19'),(15,1,NULL,4,2,'2022-02-19'),(16,1,NULL,1,2,'2022-02-19'),(17,1,NULL,6,2,'2022-02-19'),(18,1,NULL,5,2,'2022-02-19');
/*!40000 ALTER TABLE `csm_user_group_role_pg` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `csm_user_pe`
--

DROP TABLE IF EXISTS `csm_user_pe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `csm_user_pe` (
  `USER_PROTECTION_ELEMENT_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `PROTECTION_ELEMENT_ID` bigint(20) NOT NULL,
  `USER_ID` bigint(20) NOT NULL,
  `UPDATE_DATE` date NOT NULL DEFAULT '1950-01-01',
  PRIMARY KEY (`USER_PROTECTION_ELEMENT_ID`),
  UNIQUE KEY `UQ_USER_PROTECTION_ELEMENT_PROTECTION_ELEMENT_ID` (`USER_ID`,`PROTECTION_ELEMENT_ID`),
  KEY `idx_USER_ID` (`USER_ID`),
  KEY `idx_PROTECTION_ELEMENT_ID` (`PROTECTION_ELEMENT_ID`),
  CONSTRAINT `FK_PE_USER` FOREIGN KEY (`USER_ID`) REFERENCES `csm_user` (`USER_ID`) ON DELETE CASCADE,
  CONSTRAINT `FK_PROTECTION_ELEMENT_USER` FOREIGN KEY (`PROTECTION_ELEMENT_ID`) REFERENCES `csm_protection_element` (`PROTECTION_ELEMENT_ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `csm_user_pe`
--

LOCK TABLES `csm_user_pe` WRITE;
/*!40000 ALTER TABLE `csm_user_pe` DISABLE KEYS */;
INSERT INTO `csm_user_pe` VALUES (1,1,1,'2022-02-19'),(2,2,1,'2022-02-19');
/*!40000 ALTER TABLE `csm_user_pe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ct_image`
--

DROP TABLE IF EXISTS `ct_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ct_image` (
  `kvp` decimal(22,6) DEFAULT NULL,
  `scan_options` varchar(16) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `data_collection_diameter` decimal(22,6) DEFAULT NULL,
  `reconstruction_diameter` decimal(22,6) DEFAULT NULL,
  `gantry_detector_tilt` decimal(22,6) DEFAULT NULL,
  `exposure_time` decimal(22,6) DEFAULT NULL,
  `x_ray_tube_current` decimal(22,6) DEFAULT NULL,
  `exposure` decimal(22,6) DEFAULT NULL,
  `exposure_in_microas` decimal(22,6) DEFAULT NULL,
  `convolution_kernel` varchar(16) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `revolution_time` decimal(22,6) DEFAULT NULL,
  `single_collimation_width` decimal(22,6) DEFAULT NULL,
  `total_collimation_width` decimal(22,6) DEFAULT NULL,
  `table_speed` decimal(22,6) DEFAULT NULL,
  `table_feed_per_rotation` decimal(22,6) DEFAULT NULL,
  `ct_pitch_factor` decimal(22,6) DEFAULT NULL,
  `anatomic_region_seq` varchar(500) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `image_pk_id` bigint(20) NOT NULL,
  `ct_image_pk_id` bigint(20) NOT NULL,
  `general_series_pk_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`ct_image_pk_id`),
  UNIQUE KEY `PK_CT_IMAGE_PK_ID` (`ct_image_pk_id`),
  KEY `convolution_kernel_idx` (`convolution_kernel`),
  KEY `ct_image_image_pk_id_indx` (`image_pk_id`),
  KEY `kvp_idx` (`kvp`),
  KEY `general_series_pk_id` (`general_series_pk_id`),
  CONSTRAINT `ct_image_ibfk_1` FOREIGN KEY (`general_series_pk_id`) REFERENCES `general_series` (`general_series_pk_id`),
  CONSTRAINT `fk_image_pk_id` FOREIGN KEY (`image_pk_id`) REFERENCES `general_image` (`image_pk_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ct_image`
--

LOCK TABLES `ct_image` WRITE;
/*!40000 ALTER TABLE `ct_image` DISABLE KEYS */;
INSERT INTO `ct_image` VALUES (120.000000,'HELIX',500.000000,400.000000,0.000000,680.000000,356.000000,242.000000,NULL,'C',0.750000,0.625000,40.000000,58.900000,70.656000,1.104000,'',229376,262144,196608);
/*!40000 ALTER TABLE `ct_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `custom_series_list`
--

DROP TABLE IF EXISTS `custom_series_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `custom_series_list` (
  `CUSTOM_SERIES_LIST_PK_ID` bigint(20) NOT NULL,
  `NAME` varchar(200) DEFAULT NULL,
  `comment_` varchar(200) DEFAULT NULL,
  `HYPERLINK` varchar(200) DEFAULT NULL,
  `CUSTOM_SERIES_LIST_TIMESTAMP` date DEFAULT NULL,
  `USER_NAME` varchar(20) DEFAULT NULL,
  `usage_count` int(10) unsigned DEFAULT 0,
  PRIMARY KEY (`CUSTOM_SERIES_LIST_PK_ID`),
  UNIQUE KEY `CUSTOM_SERIES_LIST_PK_ID` (`CUSTOM_SERIES_LIST_PK_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `custom_series_list`
--

LOCK TABLES `custom_series_list` WRITE;
/*!40000 ALTER TABLE `custom_series_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `custom_series_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `custom_series_list_attribute`
--

DROP TABLE IF EXISTS `custom_series_list_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `custom_series_list_attribute` (
  `custom_series_list_attribute_p` bigint(20) NOT NULL DEFAULT 0,
  `SERIES_INSTANCE_UID` varchar(200) DEFAULT NULL,
  `CUSTOM_SERIES_LIST_PK_ID` bigint(20) NOT NULL,
  PRIMARY KEY (`custom_series_list_attribute_p`),
  UNIQUE KEY `CUSTOM_SERIES_LIST_ATTRIBUTE_PK_ID` (`custom_series_list_attribute_p`),
  KEY `FK_CUSTOM_SERIES_LIST_PK_ID` (`CUSTOM_SERIES_LIST_PK_ID`),
  KEY `series_instance_uid_idx` (`SERIES_INSTANCE_UID`),
  CONSTRAINT `FK_CUSTOM_SERIES_LIST_PK_ID` FOREIGN KEY (`CUSTOM_SERIES_LIST_PK_ID`) REFERENCES `custom_series_list` (`CUSTOM_SERIES_LIST_PK_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `custom_series_list_attribute`
--

LOCK TABLES `custom_series_list_attribute` WRITE;
/*!40000 ALTER TABLE `custom_series_list_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `custom_series_list_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `databasechangelog`
--

DROP TABLE IF EXISTS `databasechangelog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `databasechangelog` (
  `ID` varchar(63) NOT NULL,
  `AUTHOR` varchar(63) NOT NULL,
  `FILENAME` varchar(200) NOT NULL,
  `DATEEXECUTED` datetime NOT NULL,
  `MD5SUM` varchar(32) DEFAULT NULL,
  `DESCRIPTION` varchar(255) DEFAULT NULL,
  `COMMENTS` varchar(255) DEFAULT NULL,
  `TAG` varchar(255) DEFAULT NULL,
  `LIQUIBASE` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`ID`,`AUTHOR`,`FILENAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `databasechangelog`
--

LOCK TABLES `databasechangelog` WRITE;
/*!40000 ALTER TABLE `databasechangelog` DISABLE KEYS */;
/*!40000 ALTER TABLE `databasechangelog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `databasechangeloglock`
--

DROP TABLE IF EXISTS `databasechangeloglock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `databasechangeloglock` (
  `ID` int(11) NOT NULL,
  `LOCKED` tinyint(1) NOT NULL,
  `LOCKGRANTED` datetime DEFAULT NULL,
  `LOCKEDBY` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `databasechangeloglock`
--

LOCK TABLES `databasechangeloglock` WRITE;
/*!40000 ALTER TABLE `databasechangeloglock` DISABLE KEYS */;
/*!40000 ALTER TABLE `databasechangeloglock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deletion_audit_trail`
--

DROP TABLE IF EXISTS `deletion_audit_trail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deletion_audit_trail` (
  `deletion_pk_id` bigint(20) NOT NULL,
  `data_id` varchar(64) DEFAULT NULL,
  `data_type` varchar(50) DEFAULT NULL,
  `total_image` bigint(20) DEFAULT NULL,
  `user_name` varchar(50) DEFAULT NULL,
  `time_stamp` datetime DEFAULT NULL,
  PRIMARY KEY (`deletion_pk_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deletion_audit_trail`
--

LOCK TABLES `deletion_audit_trail` WRITE;
/*!40000 ALTER TABLE `deletion_audit_trail` DISABLE KEYS */;
/*!40000 ALTER TABLE `deletion_audit_trail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dicom_image`
--

DROP TABLE IF EXISTS `dicom_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dicom_image` (
  `IMAGE_PK_ID` tinyint(4) NOT NULL,
  `INSTANCE_NUMBER` tinyint(4) NOT NULL,
  `CONTENT_DATE` tinyint(4) NOT NULL,
  `CONTENT_TIME` tinyint(4) NOT NULL,
  `IMAGE_TYPE` tinyint(4) NOT NULL,
  `ACQUISITION_DATE` tinyint(4) NOT NULL,
  `ACQUISITION_TIME` tinyint(4) NOT NULL,
  `ACQUISITION_NUMBER` tinyint(4) NOT NULL,
  `LOSSY_IMAGE_COMPRESSION` tinyint(4) NOT NULL,
  `PIXEL_SPACING` tinyint(4) NOT NULL,
  `IMAGE_ORIENTATION_PATIENT` tinyint(4) NOT NULL,
  `IMAGE_POSITION_PATIENT` tinyint(4) NOT NULL,
  `SLICE_THICKNESS` tinyint(4) NOT NULL,
  `SLICE_LOCATION` tinyint(4) NOT NULL,
  `I_ROWS` tinyint(4) NOT NULL,
  `I_COLUMNS` tinyint(4) NOT NULL,
  `CONTRAST_BOLUS_AGENT` tinyint(4) NOT NULL,
  `CONTRAST_BOLUS_ROUTE` tinyint(4) NOT NULL,
  `SOP_CLASS_UID` tinyint(4) NOT NULL,
  `SOP_INSTANCE_UID` tinyint(4) NOT NULL,
  `GENERAL_SERIES_PK_ID` tinyint(4) NOT NULL,
  `PATIENT_POSITION` tinyint(4) NOT NULL,
  `SOURCE_TO_DETECTOR_DISTANCE` tinyint(4) NOT NULL,
  `SOURCE_SUBJECT_DISTANCE` tinyint(4) NOT NULL,
  `FOCAL_SPOT_SIZE` tinyint(4) NOT NULL,
  `STORAGE_MEDIA_FILE_SET_UID` tinyint(4) NOT NULL,
  `DICOM_FILE_URI` tinyint(4) NOT NULL,
  `ACQUISITION_DATETIME` tinyint(4) NOT NULL,
  `IMAGE_COMMENTS` tinyint(4) NOT NULL,
  `IMAGE_RECEIVING_TIMESTAMP` tinyint(4) NOT NULL,
  `CURATION_TIMESTAMP` tinyint(4) NOT NULL,
  `ANNOTATION` tinyint(4) NOT NULL,
  `SUBMISSION_DATE` tinyint(4) NOT NULL,
  `DICOM_SIZE` tinyint(4) NOT NULL,
  `IMAGE_LATERALITY` tinyint(4) NOT NULL,
  `TRIAL_DP_PK_ID` tinyint(4) NOT NULL,
  `PATIENT_ID` tinyint(4) NOT NULL,
  `STUDY_INSTANCE_UID` tinyint(4) NOT NULL,
  `SERIES_INSTANCE_UID` tinyint(4) NOT NULL,
  `PATIENT_PK_ID` tinyint(4) NOT NULL,
  `STUDY_PK_ID` tinyint(4) NOT NULL,
  `PROJECT` tinyint(4) NOT NULL,
  `ACQUISITION_MATRIX` tinyint(4) NOT NULL,
  `DX_DATA_COLLECTION_DIAMETER` tinyint(4) NOT NULL,
  `KVP` tinyint(4) NOT NULL,
  `SCAN_OPTIONS` tinyint(4) NOT NULL,
  `DATA_COLLECTION_DIAMETER` tinyint(4) NOT NULL,
  `RECONSTRUCTION_DIAMETER` tinyint(4) NOT NULL,
  `GANTRY_DETECTOR_TILT` tinyint(4) NOT NULL,
  `EXPOSURE_TIME` tinyint(4) NOT NULL,
  `X_RAY_TUBE_CURRENT` tinyint(4) NOT NULL,
  `EXPOSURE` tinyint(4) NOT NULL,
  `EXPOSURE_IN_MICROAS` tinyint(4) NOT NULL,
  `CONVOLUTION_KERNEL` tinyint(4) NOT NULL,
  `REVOLUTION_TIME` tinyint(4) NOT NULL,
  `SINGLE_COLLIMATION_WIDTH` tinyint(4) NOT NULL,
  `TOTAL_COLLIMATION_WIDTH` tinyint(4) NOT NULL,
  `TABLE_SPEED` tinyint(4) NOT NULL,
  `TABLE_FEED_PER_ROTATION` tinyint(4) NOT NULL,
  `CT_PITCH_FACTOR` tinyint(4) NOT NULL,
  `ANATOMIC_REGION_SEQ` tinyint(4) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dicom_image`
--

LOCK TABLES `dicom_image` WRITE;
/*!40000 ALTER TABLE `dicom_image` DISABLE KEYS */;
/*!40000 ALTER TABLE `dicom_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dicom_series`
--

DROP TABLE IF EXISTS `dicom_series`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dicom_series` (
  `GENERAL_SERIES_PK_ID` tinyint(4) NOT NULL,
  `BODY_PART_EXAMINED` tinyint(4) NOT NULL,
  `FRAME_OF_REFERENCE_UID` tinyint(4) NOT NULL,
  `SERIES_LATERALITY` tinyint(4) NOT NULL,
  `MODALITY` tinyint(4) NOT NULL,
  `PROTOCOL_NAME` tinyint(4) NOT NULL,
  `SERIES_DATE` tinyint(4) NOT NULL,
  `SERIES_DESC` tinyint(4) NOT NULL,
  `SERIES_INSTANCE_UID` tinyint(4) NOT NULL,
  `SERIES_NUMBER` tinyint(4) NOT NULL,
  `SYNC_FRAME_OF_REF_UID` tinyint(4) NOT NULL,
  `STUDY_PK_ID` tinyint(4) NOT NULL,
  `GENERAL_EQUIPMENT_PK_ID` tinyint(4) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dicom_series`
--

LOCK TABLES `dicom_series` WRITE;
/*!40000 ALTER TABLE `dicom_series` DISABLE KEYS */;
/*!40000 ALTER TABLE `dicom_series` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dicom_study`
--

DROP TABLE IF EXISTS `dicom_study`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dicom_study` (
  `STUDY_PK_ID` tinyint(4) NOT NULL,
  `STUDY_INSTANCE_UID` tinyint(4) NOT NULL,
  `ADDITIONAL_PATIENT_HISTORY` tinyint(4) NOT NULL,
  `STUDY_DATE` tinyint(4) NOT NULL,
  `STUDY_DESC` tinyint(4) NOT NULL,
  `ADMITTING_DIAGNOSES_DESC` tinyint(4) NOT NULL,
  `ADMITTING_DIAGNOSES_CODE_SEQ` tinyint(4) NOT NULL,
  `OCCUPATION` tinyint(4) NOT NULL,
  `PATIENT_AGE` tinyint(4) NOT NULL,
  `PATIENT_SIZE` tinyint(4) NOT NULL,
  `PATIENT_WEIGHT` tinyint(4) NOT NULL,
  `STUDY_ID` tinyint(4) NOT NULL,
  `STUDY_TIME` tinyint(4) NOT NULL,
  `TRIAL_TIME_POINT_ID` tinyint(4) NOT NULL,
  `TRIAL_TIME_POINT_DESC` tinyint(4) NOT NULL,
  `PATIENT_PK_ID` tinyint(4) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dicom_study`
--

LOCK TABLES `dicom_study` WRITE;
/*!40000 ALTER TABLE `dicom_study` DISABLE KEYS */;
/*!40000 ALTER TABLE `dicom_study` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `download_data_history`
--

DROP TABLE IF EXISTS `download_data_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `download_data_history` (
  `download_data_history_pk_id` bigint(20) NOT NULL,
  `series_instance_uid` varchar(64) DEFAULT NULL,
  `login_name` varchar(100) DEFAULT NULL,
  `download_timestamp` date DEFAULT NULL,
  `download_type` varchar(20) DEFAULT NULL,
  `size_` decimal(22,2) DEFAULT NULL,
  PRIMARY KEY (`download_data_history_pk_id`),
  KEY `download_data_history_timestamp_idx` (`download_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `download_data_history`
--

LOCK TABLES `download_data_history` WRITE;
/*!40000 ALTER TABLE `download_data_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `download_data_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `download_history`
--

DROP TABLE IF EXISTS `download_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `download_history` (
  `download_history_pk_id` bigint(20) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `total_file_size` decimal(22,2) DEFAULT NULL,
  `download_file_name` varchar(300) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  PRIMARY KEY (`download_history_pk_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `download_history`
--

LOCK TABLES `download_history` WRITE;
/*!40000 ALTER TABLE `download_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `download_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `general_equipment`
--

DROP TABLE IF EXISTS `general_equipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `general_equipment` (
  `general_equipment_pk_id` bigint(20) NOT NULL,
  `manufacturer` varchar(64) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `institution_name` varchar(64) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `manufacturer_model_name` varchar(64) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `software_versions` varchar(64) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `institution_address` varchar(1024) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `station_name` varchar(16) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `device_serial_number` varchar(64) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  PRIMARY KEY (`general_equipment_pk_id`),
  UNIQUE KEY `PK_G_EQUIPMENT_ID` (`general_equipment_pk_id`),
  KEY `idx_manufacturer_model_name` (`manufacturer_model_name`),
  KEY `idx_software_versions` (`software_versions`),
  KEY `idx_manufacturer` (`manufacturer`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `general_equipment`
--

LOCK TABLES `general_equipment` WRITE;
/*!40000 ALTER TABLE `general_equipment` DISABLE KEYS */;
INSERT INTO `general_equipment` VALUES (163840,'Philips',NULL,'Ingenuity CT','4.1',NULL,NULL,NULL);
/*!40000 ALTER TABLE `general_equipment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `general_image`
--

DROP TABLE IF EXISTS `general_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `general_image` (
  `image_pk_id` bigint(20) NOT NULL,
  `instance_number` bigint(20) DEFAULT NULL,
  `content_date` date DEFAULT NULL,
  `content_time` varchar(16) COLLATE latin1_general_ci DEFAULT NULL,
  `image_type` varchar(16) COLLATE latin1_general_ci DEFAULT NULL,
  `acquisition_date` date DEFAULT NULL,
  `acquisition_time` varchar(16) COLLATE latin1_general_ci DEFAULT NULL,
  `acquisition_number` decimal(22,6) DEFAULT NULL,
  `lossy_image_compression` varchar(16) COLLATE latin1_general_ci DEFAULT NULL,
  `pixel_spacing` decimal(22,6) DEFAULT NULL,
  `image_orientation_patient` varchar(200) COLLATE latin1_general_ci DEFAULT NULL,
  `image_position_patient` varchar(200) COLLATE latin1_general_ci DEFAULT NULL,
  `slice_thickness` decimal(22,6) DEFAULT NULL,
  `slice_location` decimal(22,6) DEFAULT NULL,
  `i_rows` decimal(22,6) DEFAULT NULL,
  `i_columns` decimal(22,6) DEFAULT NULL,
  `contrast_bolus_agent` varchar(64) COLLATE latin1_general_ci DEFAULT NULL,
  `contrast_bolus_route` varchar(64) COLLATE latin1_general_ci DEFAULT NULL,
  `sop_class_uid` varchar(64) COLLATE latin1_general_ci DEFAULT NULL,
  `sop_instance_uid` varchar(64) COLLATE latin1_general_ci DEFAULT NULL,
  `general_series_pk_id` bigint(20) DEFAULT NULL,
  `patient_position` varchar(16) COLLATE latin1_general_ci DEFAULT NULL,
  `source_to_detector_distance` decimal(22,6) DEFAULT NULL,
  `source_subject_distance` decimal(22,6) DEFAULT NULL,
  `focal_spot_size` decimal(22,6) DEFAULT NULL,
  `storage_media_file_set_uid` varchar(64) COLLATE latin1_general_ci DEFAULT NULL,
  `dicom_file_uri` varchar(2000) COLLATE latin1_general_ci DEFAULT NULL,
  `acquisition_datetime` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `image_comments` varchar(4000) COLLATE latin1_general_ci DEFAULT NULL,
  `image_receiving_timestamp` datetime DEFAULT NULL,
  `curation_timestamp` datetime DEFAULT NULL,
  `annotation` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  `submission_date` date DEFAULT NULL,
  `dicom_size` decimal(22,6) DEFAULT NULL,
  `image_laterality` varchar(16) COLLATE latin1_general_ci DEFAULT NULL,
  `trial_dp_pk_id` bigint(20) DEFAULT NULL,
  `patient_id` varchar(64) COLLATE latin1_general_ci DEFAULT NULL,
  `study_instance_uid` varchar(500) COLLATE latin1_general_ci DEFAULT NULL,
  `series_instance_uid` varchar(64) COLLATE latin1_general_ci DEFAULT NULL,
  `patient_pk_id` bigint(20) DEFAULT NULL,
  `study_pk_id` bigint(20) DEFAULT NULL,
  `project` varchar(200) COLLATE latin1_general_ci DEFAULT NULL,
  `acquisition_matrix` decimal(22,6) DEFAULT 0.000000,
  `dx_data_collection_diameter` decimal(22,6) DEFAULT 0.000000,
  `md5_digest` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `US_FRAME_NUMBER` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `US_COLOR_DATA_PRESENT` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `US_MULTI_MODALITY` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `posda_transfer_id` int(20) DEFAULT NULL,
  PRIMARY KEY (`image_pk_id`),
  UNIQUE KEY `PK_IMAGE_PK_ID` (`image_pk_id`),
  UNIQUE KEY `Image_Visibility_Submitted_IDX` (`image_pk_id`,`submission_date`),
  UNIQUE KEY `sop_instance_uid` (`sop_instance_uid`),
  KEY `acquisition_matrix_idx` (`acquisition_matrix`),
  KEY `contrast_bolus_route_idx` (`contrast_bolus_route`),
  KEY `curation_t_indx` (`curation_timestamp`),
  KEY `dx_data_collection_diameter` (`dx_data_collection_diameter`),
  KEY `general_image_search` (`general_series_pk_id`,`image_pk_id`,`slice_thickness`,`contrast_bolus_agent`,`curation_timestamp`),
  KEY `gi_gs_ds_indx` (`general_series_pk_id`,`dicom_size`),
  KEY `gi_ppkid_indx` (`patient_pk_id`),
  KEY `gi_spkid_indx` (`study_pk_id`),
  KEY `gi_tdpkid_indx` (`trial_dp_pk_id`),
  KEY `image_fk_series_pk_id` (`general_series_pk_id`),
  KEY `image_sop_instance_uid` (`sop_instance_uid`),
  KEY `slice_thickness_idx` (`slice_thickness`),
  KEY `SubmittedDateIndex` (`submission_date`),
  KEY `idx_visibility_submitted_date` (`submission_date`),
  KEY `series_instance_uid_idx` (`series_instance_uid`),
  KEY `PATIENT_ID_IDX` (`patient_id`),
  KEY `STUDY_INSTANCE_UID_IDX` (`study_instance_uid`),
  KEY `US_MULTI_MODALITY_IDX` (`US_MULTI_MODALITY`),
  KEY `instanceNumberindx` (`instance_number`),
  KEY `contentDateindx` (`content_date`),
  KEY `contentTimeindx` (`content_time`),
  KEY `imageTypeindx` (`image_type`),
  KEY `acquisitionDateindx` (`acquisition_date`),
  KEY `acquisitionTimeindx` (`acquisition_time`),
  KEY `acquisitionNumberindx` (`acquisition_number`),
  KEY `lossyImageCompressionindx` (`lossy_image_compression`),
  KEY `imageOrientationPatientindx` (`image_orientation_patient`),
  KEY `imagePositionPatientindx` (`image_position_patient`),
  KEY `sliceLocationindx` (`slice_location`),
  KEY `contrastBolusAgentindx` (`contrast_bolus_agent`),
  KEY `SOPClassUIDindx` (`sop_class_uid`),
  KEY `patientPositionindx` (`patient_position`),
  KEY `sourceToDetectorDistanceindx` (`source_to_detector_distance`),
  KEY `sourceSubjectDistanceindx` (`source_subject_distance`),
  KEY `focalSpotSizeindx` (`focal_spot_size`),
  KEY `storageMediaFileSetUIDindx` (`storage_media_file_set_uid`),
  KEY `acquisitionDatetimeindx` (`acquisition_datetime`),
  KEY `imageCommentsindx` (`image_comments`(767)),
  KEY `imageLateralityindx` (`image_laterality`),
  KEY `acquisitionMatrixindx` (`acquisition_matrix`),
  KEY `columnsindx` (`i_columns`),
  KEY `rowsindx` (`i_rows`),
  KEY `usFrameNumindx` (`US_FRAME_NUMBER`),
  KEY `usColorDataPresentindx` (`US_COLOR_DATA_PRESENT`),
  CONSTRAINT `FK_general_image_patient` FOREIGN KEY (`patient_pk_id`) REFERENCES `patient` (`patient_pk_id`),
  CONSTRAINT `FK_general_image_study` FOREIGN KEY (`study_pk_id`) REFERENCES `study` (`study_pk_id`),
  CONSTRAINT `FK_general_image_trialdata_prov` FOREIGN KEY (`trial_dp_pk_id`) REFERENCES `trial_data_provenance` (`trial_dp_pk_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_g_series_pk_id` FOREIGN KEY (`general_series_pk_id`) REFERENCES `general_series` (`general_series_pk_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `general_image`
--

LOCK TABLES `general_image` WRITE;
/*!40000 ALTER TABLE `general_image` DISABLE KEYS */;
INSERT INTO `general_image` VALUES (229376,1,'2002-06-04','133213.653','ORIGINAL','2002-06-04','133213',2.000000,'00',0.781250,'1\\0\\0\\0\\1\\0','-196.8\\-83.9\\-29.67',3.000000,29.670000,512.000000,512.000000,NULL,NULL,'1.2.840.10008.5.1.4.1.1.2','1.3.6.1.4.1.14519.5.2.1.4801.5885.890301857812897912547670620939',196608,'FFS',1040.000000,570.000000,NULL,NULL,'/opt/dicoms/1-001.dcm','20020604133213.050','CHEST W/O',NULL,'2022-02-19 22:59:00',NULL,'2022-02-19',527720.000000,NULL,32768,'C3N-02523','1.3.6.1.4.1.14519.5.2.1.4801.5885.273378882339536463149915111634','1.3.6.1.4.1.14519.5.2.1.4801.5885.113884838686340531426541864075',98304,131072,'Public',NULL,NULL,'6004d4d7e85c8d483950fce35cf81ac8',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `general_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `general_series`
--

DROP TABLE IF EXISTS `general_series`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `general_series` (
  `general_series_pk_id` bigint(20) NOT NULL,
  `modality` varchar(16) NOT NULL,
  `series_instance_uid` varchar(64) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `series_laterality` varchar(16) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `series_date` date DEFAULT NULL,
  `protocol_name` varchar(64) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `series_desc` varchar(64) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `body_part_examined` varchar(16) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `study_pk_id` bigint(20) DEFAULT NULL,
  `general_equipment_pk_id` bigint(20) DEFAULT NULL,
  `trial_protocol_id` varchar(64) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `trial_protocol_name` varchar(64) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `trial_site_name` varchar(64) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `study_date` date DEFAULT NULL,
  `study_desc` varchar(64) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `admitting_diagnoses_desc` varchar(64) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `patient_age` varchar(4) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `patient_sex` varchar(16) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `patient_weight` decimal(22,6) DEFAULT NULL,
  `age_group` varchar(10) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `patient_pk_id` bigint(20) DEFAULT NULL,
  `series_number` decimal(22,6) DEFAULT NULL,
  `sync_frame_of_ref_uid` varchar(64) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `patient_id` varchar(64) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `frame_of_reference_uid` varchar(64) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `visibility` varchar(5) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `security_group` varchar(50) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `annotations_flag` varchar(5) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `project` varchar(200) DEFAULT NULL,
  `site` varchar(40) DEFAULT NULL,
  `study_instance_uid` varchar(500) DEFAULT NULL,
  `max_submission_timestamp` datetime DEFAULT NULL,
  `batchNum` int(20) DEFAULT NULL,
  `submission_type` varchar(100) DEFAULT NULL,
  `released_status` varchar(50) DEFAULT NULL,
  `third_party_analysis` varchar(4) DEFAULT NULL,
  `description_uri` varchar(500) DEFAULT NULL,
  `exclude_commercial` varchar(4) DEFAULT NULL,
  `date_released` datetime DEFAULT NULL,
  PRIMARY KEY (`general_series_pk_id`),
  UNIQUE KEY `PK_G_SERIES_PK_ID` (`general_series_pk_id`),
  UNIQUE KEY `series_instance_uid` (`series_instance_uid`),
  KEY `body_part_examined_idx` (`body_part_examined`),
  KEY `general_series_sec_grp_idx` (`security_group`),
  KEY `general_series_site_idx` (`trial_site_name`),
  KEY `modality_idx` (`modality`),
  KEY `series_desc_idx` (`series_desc`),
  KEY `series_visibility_ind` (`visibility`),
  KEY `fk_gs_study_pk_id` (`study_pk_id`),
  KEY `fk_g_equipment_pk_id` (`general_equipment_pk_id`),
  KEY `Series_instance_uid_idx` (`series_instance_uid`),
  KEY `patient_pk_id_idx` (`patient_pk_id`),
  KEY `STUDY_INSTANCE_UID_IDX` (`study_instance_uid`),
  CONSTRAINT `fk_g_equipment_pk_id` FOREIGN KEY (`general_equipment_pk_id`) REFERENCES `general_equipment` (`general_equipment_pk_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_gs_study_pk_id` FOREIGN KEY (`study_pk_id`) REFERENCES `study` (`study_pk_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `general_series`
--

LOCK TABLES `general_series` WRITE;
/*!40000 ALTER TABLE `general_series` DISABLE KEYS */;
INSERT INTO `general_series` VALUES (196608,'CT','1.3.6.1.4.1.14519.5.2.1.4801.5885.113884838686340531426541864075',NULL,'2002-06-04','CHEST WITHOUT /Thorax','CHEST W/O, iDose (3)','CHEST',131072,163840,NULL,NULL,NULL,'2002-06-04','CT Body Outside Consultation With Formal Dictation',NULL,'061Y','M',NULL,'060Y',98304,201.000000,NULL,'C3N-02523','1.3.6.1.4.1.14519.5.2.1.4801.5885.907045470620044815886464014844','1',NULL,NULL,'Public','Public','1.3.6.1.4.1.14519.5.2.1.4801.5885.273378882339536463149915111634','2022-02-19 22:54:55',1,'Complete','Yes','NO','',NULL,'2022-02-19 00:00:00');
/*!40000 ALTER TABLE `general_series` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gui_action_history`
--

DROP TABLE IF EXISTS `gui_action_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gui_action_history` (
  `GUI_ACTION_HISTORY_PK_ID` bigint(20) NOT NULL DEFAULT 0,
  `ACTION_TIMESTAMP` date DEFAULT NULL,
  `ACTION` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`GUI_ACTION_HISTORY_PK_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gui_action_history`
--

LOCK TABLES `gui_action_history` WRITE;
/*!40000 ALTER TABLE `gui_action_history` DISABLE KEYS */;
INSERT INTO `gui_action_history` VALUES (360448,'2022-02-19','{\"action\":\"SIMPLE_SEARCH\",\"user\":\"nbiaAdmin\"}'),(589824,'2022-02-19','{\"action\":\"SIMPLE_SEARCH\",\"user\":\"nbiaAdmin\"}'),(589825,'2022-02-19','{\"action\":\"SIMPLE_SEARCH\",\"user\":\"nbiaAdmin\"}'),(589826,'2022-02-19','{\"action\":\"SIMPLE_SEARCH\",\"user\":\"nbia_guest\"}');
/*!40000 ALTER TABLE `gui_action_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hibernate_unique_key`
--

DROP TABLE IF EXISTS `hibernate_unique_key`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hibernate_unique_key` (
  `next_hi` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hibernate_unique_key`
--

LOCK TABLES `hibernate_unique_key` WRITE;
/*!40000 ALTER TABLE `hibernate_unique_key` DISABLE KEYS */;
INSERT INTO `hibernate_unique_key` VALUES (22);
/*!40000 ALTER TABLE `hibernate_unique_key` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `license`
--

DROP TABLE IF EXISTS `license`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `license` (
  `license_id` bigint(20) NOT NULL,
  `long_name` varchar(255) DEFAULT NULL,
  `short_name` varchar(50) DEFAULT NULL,
  `license_url` varchar(255) DEFAULT NULL,
  `commercial_use` varchar(45) DEFAULT 'YES',
  `license_text` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`license_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `license`
--

LOCK TABLES `license` WRITE;
/*!40000 ALTER TABLE `license` DISABLE KEYS */;
INSERT INTO `license` VALUES (1,'Creative Commons Attribution 3.0 Unported License','CC BY 3.0','http://creativecommons.org/licenses/by/3.0/','YES','https://creativecommons.org/licenses/by/3.0/'),(2,'Creative Commons Attribution 4.0 International License','CC BY 4.0','https://creativecommons.org/licenses/by/4.0/','YES','https://creativecommons.org/licenses/by/4.0/legalcode'),(3,'Creative Commons Attribution-NonCommercial 4.0 International License','CC BY-NC 4.0','https://creativecommons.org/licenses/by-nc/4.0/','NO','https://creativecommons.org/licenses/by-nc/4.0/legalcode'),(4,'Creative Commons Attribution-NonCommercial 3.0 Unported License','CC BY-NC 3.0','https://creativecommons.org/licenses/by-nc/3.0/','NO','https://creativecommons.org/licenses/by-nc/3.0/legalcode');
/*!40000 ALTER TABLE `license` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `login_history`
--

DROP TABLE IF EXISTS `login_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `login_history` (
  `login_history_pk_id` bigint(20) NOT NULL,
  `login_timestamp` datetime DEFAULT NULL,
  `ip_address` varchar(15) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  PRIMARY KEY (`login_history_pk_id`),
  UNIQUE KEY `PK_LOGIN_HISTORY_PK_ID` (`login_history_pk_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `login_history`
--

LOCK TABLES `login_history` WRITE;
/*!40000 ALTER TABLE `login_history` DISABLE KEYS */;
INSERT INTO `login_history` VALUES (393216,'2022-02-19 22:35:16','192.168.112.1'),(622592,'2022-02-19 23:01:13','192.168.112.1'),(622593,'2022-02-19 23:05:27','192.168.112.1');
/*!40000 ALTER TABLE `login_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manufacturer`
--

DROP TABLE IF EXISTS `manufacturer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `manufacturer` (
  `MANUFACTURER` tinyint(4) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manufacturer`
--

LOCK TABLES `manufacturer` WRITE;
/*!40000 ALTER TABLE `manufacturer` DISABLE KEYS */;
/*!40000 ALTER TABLE `manufacturer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manufacturer_model_software`
--

DROP TABLE IF EXISTS `manufacturer_model_software`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `manufacturer_model_software` (
  `ID` tinyint(4) NOT NULL,
  `MANUFACTURER` tinyint(4) NOT NULL,
  `MODEL` tinyint(4) NOT NULL,
  `SOFTWARE` tinyint(4) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manufacturer_model_software`
--

LOCK TABLES `manufacturer_model_software` WRITE;
/*!40000 ALTER TABLE `manufacturer_model_software` DISABLE KEYS */;
/*!40000 ALTER TABLE `manufacturer_model_software` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `modality_descriptions`
--

DROP TABLE IF EXISTS `modality_descriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `modality_descriptions` (
  `modality_descriptions_pk_id` bigint(20) NOT NULL,
  `modality_name` varchar(20) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `description` mediumtext CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  PRIMARY KEY (`modality_descriptions_pk_id`),
  UNIQUE KEY `MD_COLLECTION_DESC_PK_ID` (`modality_descriptions_pk_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modality_descriptions`
--

LOCK TABLES `modality_descriptions` WRITE;
/*!40000 ALTER TABLE `modality_descriptions` DISABLE KEYS */;
INSERT INTO `modality_descriptions` VALUES (1,'CR','Computed Radiography'),(2,'CT','Computed Tomography'),(3,'MR','Magnetic Resonance'),(4,'NM','Nuclear Medicine'),(5,'US','Ultrasound'),(6,'OT','Other'),(7,'BI','Biomagnetic imaging'),(8,'DG','Diaphanography'),(9,'ES','Endoscopy'),(10,'LS','Laser surface scan'),(11,'PT','Positron emission tomography (PET)'),(12,'RG','Radiographic imaging (conventional film/screen)'),(13,'TG','Thermography'),(14,'XA','X-Ray Angiography'),(15,'RF','Radio Fluoroscopy'),(16,'RTIMAGE','Radiotherapy Image'),(17,'RTDOSE','Radiotherapy Dose'),(18,'RTSTRUCT','Radiotherapy Structure Set'),(19,'RTPLAN','Radiotherapy Plan'),(20,'RTRECORD','RT Treatment Record'),(21,'HC','Hard Copy'),(22,'DX','Digital Radiography'),(23,'MG','Mammography'),(24,'IO','Intra-oral Radiography'),(25,'IO','Intra-oral Radiography'),(26,'PX','Panoramic X-Ray'),(27,'GM','General Microscopy'),(28,'SM','Slide Microscopy'),(29,'XC','External-camera Photography'),(30,'PR','Presentation State'),(31,'AU','Audio'),(32,'ECG','Electrocardiography'),(33,'EPS','Cardiac Electrophysiology'),(34,'HD','Hemodynamic Waveform'),(35,'SR','SR Document'),(36,'IVUS','Intravascular Ultrasound'),(37,'OP','Ophthalmic Photography'),(38,'SMR','Stereometric Relationship'),(39,'AR','Autorefraction'),(40,'KER','Keratometry'),(41,'VA','Visual Acuity'),(42,'VA','Visual Acuity'),(43,'SRF','Subjective Refraction'),(44,'OCT','Optical Coherence Tomography (non-Ophthalmic)'),(45,'LEN','Lensometry'),(46,'OPV','Ophthalmic Visual Field'),(47,'OPM','Ophthalmic Mapping'),(48,'OAM','Ophthalmic Axial Measurements'),(49,'RESP','Respiratory Waveform'),(50,'KO','Key Object Selection'),(51,'SEG','Segmentation'),(52,'REG','Registration'),(53,'OPT','Ophthalmic Tomography'),(54,'BDUS','Bone Densitometry (ultrasound)'),(55,'BMD','Bone Densitometry (X-Ray)'),(56,'DOC','Document'),(57,'FID','Fiducials'),(58,'SC','Secondary Capture'),(59,'HISTOPATHOLOGY','HISTOPATHOLOGY');
/*!40000 ALTER TABLE `modality_descriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mr_image`
--

DROP TABLE IF EXISTS `mr_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mr_image` (
  `IMAGE_TYPE_VALUE_3` varchar(16) NOT NULL,
  `SCANNING_SEQUENCE` varchar(126) NOT NULL,
  `SEQUENCE_VARIANT` varchar(126) NOT NULL,
  `REPETITION_TIME` decimal(22,10) DEFAULT NULL,
  `ECHO_TIME` decimal(22,10) DEFAULT NULL,
  `INVERSION_TIME` decimal(22,10) DEFAULT NULL,
  `SEQUENCE_NAME` varchar(64) DEFAULT NULL,
  `IMAGED_NUCLEUS` varchar(64) DEFAULT NULL,
  `MAGNETIC_FIELD_STRENGTH` decimal(22,10) DEFAULT NULL,
  `SAR` decimal(22,10) DEFAULT NULL,
  `DB_DT` decimal(22,10) DEFAULT NULL,
  `TRIGGER_TIME` decimal(22,10) DEFAULT NULL,
  `ANGIO_FLAG` varchar(1) DEFAULT NULL,
  `IMAGE_PK_ID` bigint(20) NOT NULL,
  `MR_IMAGE_PK_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `GENERAL_SERIES_PK_ID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`MR_IMAGE_PK_ID`),
  KEY `MR_IMAGE_IMAGE_PK_ID_INDX` (`IMAGE_PK_ID`),
  KEY `MR_SERIES_PK_ID_INDX` (`GENERAL_SERIES_PK_ID`),
  CONSTRAINT `FK_MR_GEN_IMAGE_PK_ID` FOREIGN KEY (`IMAGE_PK_ID`) REFERENCES `general_image` (`image_pk_id`),
  CONSTRAINT `FK_MR_GEN_SERIES_PK_ID` FOREIGN KEY (`GENERAL_SERIES_PK_ID`) REFERENCES `general_series` (`general_series_pk_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mr_image`
--

LOCK TABLES `mr_image` WRITE;
/*!40000 ALTER TABLE `mr_image` DISABLE KEYS */;
/*!40000 ALTER TABLE `mr_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `number_month`
--

DROP TABLE IF EXISTS `number_month`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `number_month` (
  `PATIENT_ID` tinyint(4) NOT NULL,
  `NUMBER_MONTH` tinyint(4) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `number_month`
--

LOCK TABLES `number_month` WRITE;
/*!40000 ALTER TABLE `number_month` DISABLE KEYS */;
/*!40000 ALTER TABLE `number_month` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient`
--

DROP TABLE IF EXISTS `patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient` (
  `patient_pk_id` bigint(20) NOT NULL,
  `patient_id` varchar(64) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `patient_name` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `patient_birth_date` date DEFAULT NULL,
  `patient_sex` varchar(16) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `ethnic_group` varchar(16) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `trial_dp_pk_id` bigint(20) DEFAULT NULL,
  `trial_subject_id` varchar(64) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `trial_subject_reading_id` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `trial_site_pk_id` bigint(20) DEFAULT NULL,
  `species_code` varchar(64) DEFAULT NULL,
  `species_description` varchar(500) DEFAULT NULL,
  `qc_subject` varchar(4) DEFAULT NULL,
  PRIMARY KEY (`patient_pk_id`),
  UNIQUE KEY `PK_PATINET_PK_ID` (`patient_pk_id`),
  KEY `fk_trial_dp_pk_id` (`trial_dp_pk_id`),
  KEY `fk_trial_site_pk_id` (`trial_site_pk_id`),
  KEY `Patient_Id_Idx` (`patient_id`),
  KEY `species_codeindx` (`species_code`),
  CONSTRAINT `fk_trial_dp_pk_id` FOREIGN KEY (`trial_dp_pk_id`) REFERENCES `trial_data_provenance` (`trial_dp_pk_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient`
--

LOCK TABLES `patient` WRITE;
/*!40000 ALTER TABLE `patient` DISABLE KEYS */;
INSERT INTO `patient` VALUES (98304,'C3N-02523','C3N-02523',NULL,'M',NULL,32768,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `patient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qc_status_history`
--

DROP TABLE IF EXISTS `qc_status_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qc_status_history` (
  `qc_status_history_pk_id` bigint(20) NOT NULL,
  `series_instance_uid` varchar(64) NOT NULL,
  `user_id` varchar(100) DEFAULT NULL,
  `comment_` varchar(4000) DEFAULT NULL,
  `history_timestamp` datetime DEFAULT NULL,
  `new_value` varchar(100) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `old_value` varchar(100) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `oldBatch` varchar(20) DEFAULT NULL,
  `newBatch` varchar(20) DEFAULT NULL,
  `oldSubmissionType` varchar(100) DEFAULT NULL,
  `newSubmissionType` varchar(100) DEFAULT NULL,
  `oldReleasedStatus` varchar(50) DEFAULT NULL,
  `newReleasedStatus` varchar(50) DEFAULT NULL,
  `site` varchar(200) DEFAULT NULL,
  `uri` varchar(200) DEFAULT NULL,
  `date_released` datetime DEFAULT NULL,
  PRIMARY KEY (`qc_status_history_pk_id`),
  UNIQUE KEY `PK_QC_STATUS_HISTORY_PK_ID` (`qc_status_history_pk_id`),
  KEY `genseries_qcsts_id_idx` (`series_instance_uid`),
  KEY `qc_status_history_idx` (`history_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qc_status_history`
--

LOCK TABLES `qc_status_history` WRITE;
/*!40000 ALTER TABLE `qc_status_history` DISABLE KEYS */;
INSERT INTO `qc_status_history` VALUES (327680,'1.3.6.1.4.1.14519.5.2.1.4801.5885.113884838686340531426541864075','nbiaAdmin',NULL,'2022-02-19 22:34:57','1','0','1','1',NULL,'Complete',NULL,'Yes',NULL,NULL,'2022-02-19 00:00:00'),(327681,'1.3.6.1.4.1.14519.5.2.1.4801.5885.113884838686340531426541864075','nbiaAdmin',NULL,'2022-02-19 22:36:49','12','1','1',NULL,'Complete',NULL,'Yes',NULL,NULL,NULL,NULL),(327682,'1.3.6.1.4.1.14519.5.2.1.4801.5885.113884838686340531426541864075','nbiaAdmin',NULL,'2022-02-19 22:37:25',NULL,'12','1',NULL,'Complete','Complete','Yes','Yes',NULL,NULL,'2022-02-19 00:00:00'),(524288,'1.3.6.1.4.1.14519.5.2.1.4801.5885.113884838686340531426541864075','nbiaAdmin',NULL,'2022-02-19 22:55:25','12','0','1',NULL,'Complete','Complete','Yes','Yes',NULL,NULL,'2022-02-19 00:00:00'),(557056,'1.3.6.1.4.1.14519.5.2.1.4801.5885.113884838686340531426541864075','nbiaAdmin',NULL,'2022-02-19 22:59:00','1','12','1',NULL,'Complete',NULL,'Yes',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `qc_status_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `query_history`
--

DROP TABLE IF EXISTS `query_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `query_history` (
  `query_history_pk_id` bigint(20) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `query_execute_timestamp` datetime DEFAULT NULL,
  `query_elapsed_time` bigint(20) DEFAULT NULL,
  `saved_query_pk_id` bigint(20) DEFAULT NULL,
  `tool` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`query_history_pk_id`),
  UNIQUE KEY `PK_QUERY_HISTORY_PK_ID` (`query_history_pk_id`),
  KEY `query_history_user_idx` (`user_id`),
  KEY `query_hist_save_quer_idx` (`saved_query_pk_id`),
  CONSTRAINT `FK_Q_H_USER_ID` FOREIGN KEY (`user_id`) REFERENCES `csm_user` (`USER_ID`) ON DELETE CASCADE,
  CONSTRAINT `fk_s_query_pk_id` FOREIGN KEY (`saved_query_pk_id`) REFERENCES `saved_query` (`saved_query_pk_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `query_history`
--

LOCK TABLES `query_history` WRITE;
/*!40000 ALTER TABLE `query_history` DISABLE KEYS */;
INSERT INTO `query_history` VALUES (425984,1,'2022-02-19 22:35:41',0,NULL,'portal'),(425985,1,'2022-02-19 22:35:41',0,NULL,'portal'),(425986,1,'2022-02-19 22:35:46',0,NULL,'portal'),(425987,1,'2022-02-19 22:35:47',0,NULL,'portal'),(425988,1,'2022-02-19 22:35:48',0,NULL,'portal'),(425989,1,'2022-02-19 22:35:49',0,NULL,'portal'),(425990,1,'2022-02-19 22:37:45',0,NULL,'portal'),(655360,1,'2022-02-19 23:05:31',0,NULL,'portal'),(655361,1,'2022-02-19 23:05:32',0,NULL,'portal');
/*!40000 ALTER TABLE `query_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `query_history_attribute`
--

DROP TABLE IF EXISTS `query_history_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `query_history_attribute` (
  `query_history_attribute_pk_id` bigint(20) NOT NULL,
  `attribute_name` varchar(300) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `subattribute_name` varchar(300) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `attribute_value` varchar(300) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `query_history_pk_id` bigint(20) DEFAULT NULL,
  `instance_number` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`query_history_attribute_pk_id`),
  UNIQUE KEY `PK_Q_H_A_PK_ID` (`query_history_attribute_pk_id`),
  KEY `attri_name_idx` (`attribute_name`),
  KEY `attri_value_idx` (`attribute_value`),
  KEY `query_history_attr_parent` (`query_history_pk_id`),
  KEY `FK_Q_H_PK_ID` (`query_history_pk_id`),
  CONSTRAINT `FK_Q_H_PK_ID` FOREIGN KEY (`query_history_pk_id`) REFERENCES `query_history` (`query_history_pk_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `query_history_attribute`
--

LOCK TABLES `query_history_attribute` WRITE;
/*!40000 ALTER TABLE `query_history_attribute` DISABLE KEYS */;
INSERT INTO `query_history_attribute` VALUES (458752,'gov.nih.nci.ncia.criteria.CollectionCriteria','1','Public',425984,1),(458753,'gov.nih.nci.ncia.criteria.CollectionCriteria','1','Public',425985,1),(458754,'gov.nih.nci.ncia.criteria.CollectionCriteria','1','Public',425986,1),(458755,'gov.nih.nci.ncia.criteria.ImageModalityCriteria','1','CT',425987,1),(458756,'gov.nih.nci.ncia.criteria.ModalityAndedSearchCriteria','0','all',425987,1),(458757,'gov.nih.nci.ncia.criteria.CollectionCriteria','1','Public',425987,1),(458758,'gov.nih.nci.ncia.criteria.CollectionCriteria','1','Public',425988,1),(458759,'gov.nih.nci.ncia.criteria.CollectionCriteria','1','Public',425989,1),(458760,'gov.nih.nci.ncia.criteria.CollectionCriteria','1','Public',425990,1),(688128,'gov.nih.nci.ncia.criteria.CollectionCriteria','1','Public',655360,1),(688129,'gov.nih.nci.ncia.criteria.CollectionCriteria','1','Public',655361,1);
/*!40000 ALTER TABLE `query_history_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `saved_query`
--

DROP TABLE IF EXISTS `saved_query`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `saved_query` (
  `saved_query_pk_id` bigint(20) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `query_name` varchar(200) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `new_data_flag` varchar(5) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `active` varchar(5) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `query_execute_timestamp` datetime DEFAULT NULL,
  PRIMARY KEY (`saved_query_pk_id`),
  UNIQUE KEY `PK_SAVED_Q_PK_ID` (`saved_query_pk_id`),
  KEY `saved_query_user_idx` (`user_id`),
  CONSTRAINT `FK_SAVED_QUERY_USER_ID` FOREIGN KEY (`user_id`) REFERENCES `csm_user` (`USER_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `saved_query`
--

LOCK TABLES `saved_query` WRITE;
/*!40000 ALTER TABLE `saved_query` DISABLE KEYS */;
/*!40000 ALTER TABLE `saved_query` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `saved_query_attribute`
--

DROP TABLE IF EXISTS `saved_query_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `saved_query_attribute` (
  `saved_query_attribute_pk_id` bigint(20) NOT NULL,
  `attribute_name` varchar(300) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `subattribute_name` varchar(300) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `attribute_value` varchar(300) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `saved_query_pk_id` bigint(20) DEFAULT NULL,
  `instance_number` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`saved_query_attribute_pk_id`),
  UNIQUE KEY `PK_S_Q_A_PK_ID` (`saved_query_attribute_pk_id`),
  KEY `saved_query_attr_parent` (`saved_query_pk_id`),
  KEY `FK_SAVED_QUERY_PK_ID` (`saved_query_pk_id`),
  CONSTRAINT `FK_SAVED_QUERY_PK_ID` FOREIGN KEY (`saved_query_pk_id`) REFERENCES `saved_query` (`saved_query_pk_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `saved_query_attribute`
--

LOCK TABLES `saved_query_attribute` WRITE;
/*!40000 ALTER TABLE `saved_query_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `saved_query_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `saved_query_last_exec`
--

DROP TABLE IF EXISTS `saved_query_last_exec`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `saved_query_last_exec` (
  `SAVED_QUERY_PK_ID` tinyint(4) NOT NULL,
  `LAST_EXECUTE_DATE` tinyint(4) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `saved_query_last_exec`
--

LOCK TABLES `saved_query_last_exec` WRITE;
/*!40000 ALTER TABLE `saved_query_last_exec` DISABLE KEYS */;
/*!40000 ALTER TABLE `saved_query_last_exec` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site`
--

DROP TABLE IF EXISTS `site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site` (
  `site_pk_id` bigint(20) NOT NULL,
  `dp_site_name` varchar(40) DEFAULT NULL,
  `dp_site_id` varchar(64) DEFAULT NULL,
  `trial_dp_pk_id` bigint(20) NOT NULL,
  PRIMARY KEY (`site_pk_id`),
  UNIQUE KEY `SITE_PK_ID` (`site_pk_id`),
  KEY `siteNameInd` (`dp_site_name`),
  KEY `fk_tdp_st_pk_id` (`trial_dp_pk_id`),
  CONSTRAINT `fk_tdp_st_pk_id` FOREIGN KEY (`trial_dp_pk_id`) REFERENCES `trial_data_provenance` (`trial_dp_pk_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site`
--

LOCK TABLES `site` WRITE;
/*!40000 ALTER TABLE `site` DISABLE KEYS */;
INSERT INTO `site` VALUES (1,'Public',NULL,1),(65536,'Public','1',32768);
/*!40000 ALTER TABLE `site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `software_versions`
--

DROP TABLE IF EXISTS `software_versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `software_versions` (
  `SOFTWARE_VERSIONS` tinyint(4) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `software_versions`
--

LOCK TABLES `software_versions` WRITE;
/*!40000 ALTER TABLE `software_versions` DISABLE KEYS */;
/*!40000 ALTER TABLE `software_versions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `species`
--

DROP TABLE IF EXISTS `species`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `species` (
  `species_code` varchar(64) NOT NULL,
  `species_description` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`species_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `species`
--

LOCK TABLES `species` WRITE;
/*!40000 ALTER TABLE `species` DISABLE KEYS */;
INSERT INTO `species` VALUES ('107007004','Bovinae'),('125076001','Cavia porcellus'),('125097000','Capra hircus'),('125099002','Ovis aries'),('337915000','Homo sapiens'),('34618005','Bos taurus'),('35354009','Equus caballus'),('36571002','Oryctolagus cuniculus'),('36855005','Canis lupus'),('371564000','Rattus'),('371565004','Rattus norvegicus'),('388168008','Bos'),('388249000','Capra'),('388254009','Ovis'),('388393002','Sus'),('388445009','Equus'),('388490000','Canis'),('388626009','Felis'),('406733009','Callithrix jacchus'),('447482001','Mus genus'),('447612001','Mus musculus'),('448169003','Felis catus'),('448771007','Canis lupus familiaris'),('449310008','Mustela putorius furo'),('78678003','Sus scrofa');
/*!40000 ALTER TABLE `species` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `study`
--

DROP TABLE IF EXISTS `study`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `study` (
  `study_pk_id` bigint(20) NOT NULL,
  `study_instance_uid` varchar(500) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `study_date` date NOT NULL,
  `study_time` varchar(16) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `study_desc` varchar(64) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `admitting_diagnoses_desc` varchar(64) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `admitting_diagnoses_code_seq` varchar(500) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `patient_pk_id` bigint(20) DEFAULT NULL,
  `study_id` varchar(16) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `trial_time_point_id` varchar(64) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `trial_time_point_desc` varchar(1024) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `patient_age` varchar(4) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `age_group` varchar(10) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `patient_size` decimal(22,6) DEFAULT NULL,
  `patient_weight` decimal(22,6) DEFAULT NULL,
  `occupation` varchar(16) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `additional_patient_history` varchar(4000) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `longitudinal_temporal_event_type` varchar(100) DEFAULT NULL,
  `longitudinal_temporal_offset_from_event` double DEFAULT NULL,
  PRIMARY KEY (`study_pk_id`),
  UNIQUE KEY `PK_STUDY_PK_ID` (`study_pk_id`),
  UNIQUE KEY `study_instance_uid` (`study_instance_uid`),
  KEY `study_desc_idx` (`study_desc`),
  KEY `fk_patient_pk_id` (`patient_pk_id`),
  KEY `STUDY_INSTANCE_UID_idx` (`study_instance_uid`),
  CONSTRAINT `fk_patient_pk_id` FOREIGN KEY (`patient_pk_id`) REFERENCES `patient` (`patient_pk_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `study`
--

LOCK TABLES `study` WRITE;
/*!40000 ALTER TABLE `study` DISABLE KEYS */;
INSERT INTO `study` VALUES (131072,'1.3.6.1.4.1.14519.5.2.1.4801.5885.273378882339536463149915111634','2002-06-04','133012.000000','CT Body Outside Consultation With Formal Dictation',NULL,'',98304,NULL,'-50','Days offset from diagnosis','061Y','060Y',NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `study` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `study_series_number`
--

DROP TABLE IF EXISTS `study_series_number`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `study_series_number` (
  `PATIENT_PK_ID` bigint(20) NOT NULL,
  `PATIENT_ID` varchar(50) NOT NULL,
  `PROJECT` varchar(50) NOT NULL,
  `STUDY_NUMBER` bigint(20) NOT NULL,
  `SERIES_NUMBER` bigint(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `study_series_number`
--

LOCK TABLES `study_series_number` WRITE;
/*!40000 ALTER TABLE `study_series_number` DISABLE KEYS */;
INSERT INTO `study_series_number` VALUES (98304,'C3N-02523','Public',1,1);
/*!40000 ALTER TABLE `study_series_number` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `submission_history`
--

DROP TABLE IF EXISTS `submission_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `submission_history` (
  `submission_history_pk_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `patient_id` varchar(64) DEFAULT NULL,
  `study_instance_uid` varchar(500) DEFAULT NULL,
  `series_instance_uid` varchar(64) DEFAULT NULL,
  `sop_instance_uid` varchar(64) DEFAULT NULL,
  `submission_timestamp` datetime DEFAULT NULL,
  `project` varchar(200) DEFAULT NULL,
  `site` varchar(40) DEFAULT NULL,
  `operation_type` smallint(6) NOT NULL,
  UNIQUE KEY `submission_history_pk_id` (`submission_history_pk_id`),
  KEY `project_side_idx` (`project`,`site`),
  KEY `series_instance_uid_idx` (`series_instance_uid`)
) ENGINE=InnoDB AUTO_INCREMENT=491521 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `submission_history`
--

LOCK TABLES `submission_history` WRITE;
/*!40000 ALTER TABLE `submission_history` DISABLE KEYS */;
INSERT INTO `submission_history` VALUES (294912,'C3N-02523','1.3.6.1.4.1.14519.5.2.1.4801.5885.273378882339536463149915111634','1.3.6.1.4.1.14519.5.2.1.4801.5885.113884838686340531426541864075','1.3.6.1.4.1.14519.5.2.1.4801.5885.890301857812897912547670620939','2022-02-19 22:33:58','Public','Public',0),(491520,'C3N-02523','1.3.6.1.4.1.14519.5.2.1.4801.5885.273378882339536463149915111634','1.3.6.1.4.1.14519.5.2.1.4801.5885.113884838686340531426541864075','1.3.6.1.4.1.14519.5.2.1.4801.5885.890301857812897912547670620939','2022-02-19 22:54:55','Public','Public',1);
/*!40000 ALTER TABLE `submission_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trial_data_provenance`
--

DROP TABLE IF EXISTS `trial_data_provenance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trial_data_provenance` (
  `trial_dp_pk_id` bigint(20) NOT NULL,
  `dp_site_name` varchar(40) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `dp_site_id` varchar(64) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `project` varchar(50) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  PRIMARY KEY (`trial_dp_pk_id`),
  UNIQUE KEY `PK_TRIAL_DP_PK_ID` (`trial_dp_pk_id`),
  KEY `siteNameIndex` (`dp_site_name`),
  KEY `projectIndex` (`project`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trial_data_provenance`
--

LOCK TABLES `trial_data_provenance` WRITE;
/*!40000 ALTER TABLE `trial_data_provenance` DISABLE KEYS */;
INSERT INTO `trial_data_provenance` VALUES (1,NULL,NULL,'Public'),(32768,NULL,NULL,'Public');
/*!40000 ALTER TABLE `trial_data_provenance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trial_site`
--

DROP TABLE IF EXISTS `trial_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trial_site` (
  `trial_site_pk_id` bigint(20) NOT NULL,
  `trial_site_id` varchar(64) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `trial_site_name` varchar(64) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `trial_pk_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`trial_site_pk_id`),
  UNIQUE KEY `PK_TRIAL_SITE_PK_ID` (`trial_site_pk_id`),
  KEY `fk_trial_pk_id` (`trial_pk_id`),
  CONSTRAINT `fk_trial_pk_id` FOREIGN KEY (`trial_pk_id`) REFERENCES `clinical_trial` (`trial_pk_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trial_site`
--

LOCK TABLES `trial_site` WRITE;
/*!40000 ALTER TABLE `trial_site` DISABLE KEYS */;
/*!40000 ALTER TABLE `trial_site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workflow`
--

DROP TABLE IF EXISTS `workflow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `workflow` (
  `WORKFLOW_ID` bigint(20) NOT NULL DEFAULT 0,
  `NAME` varchar(50) DEFAULT NULL,
  `COLLECTION` varchar(200) DEFAULT NULL,
  `SITE` varchar(200) DEFAULT NULL,
  `URL` varchar(255) DEFAULT NULL,
  `WORKFLOW_TYPE` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`WORKFLOW_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workflow`
--

LOCK TABLES `workflow` WRITE;
/*!40000 ALTER TABLE `workflow` DISABLE KEYS */;
/*!40000 ALTER TABLE `workflow` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-02-20 16:22:31