-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: cs
-- ------------------------------------------------------
-- Server version	8.3.0

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
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `events` (
  `Event_ID` int NOT NULL AUTO_INCREMENT,
  `Event_Status_Code` int DEFAULT NULL,
  `Event_Type_Code` int DEFAULT NULL,
  `Organizer_ID` int DEFAULT NULL,
  `Venue_ID` int DEFAULT NULL,
  `Event_Name` varchar(255) NOT NULL,
  `Event_Start_Date` date NOT NULL,
  `Event_End_Date` date NOT NULL,
  `Number_of_Participants` int DEFAULT NULL,
  `Event_Duration` int DEFAULT NULL,
  `Potential_Cost` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`Event_ID`),
  KEY `Event_Status_Code` (`Event_Status_Code`),
  KEY `Event_Type_Code` (`Event_Type_Code`),
  KEY `Organizer_ID` (`Organizer_ID`),
  KEY `Venue_ID` (`Venue_ID`),
  CONSTRAINT `events_ibfk_1` FOREIGN KEY (`Event_Status_Code`) REFERENCES `ref_event_status` (`Event_Status_Code`),
  CONSTRAINT `events_ibfk_2` FOREIGN KEY (`Event_Type_Code`) REFERENCES `ref_event_types` (`Event_Type_Code`),
  CONSTRAINT `events_ibfk_3` FOREIGN KEY (`Organizer_ID`) REFERENCES `organizers` (`Organizer_ID`),
  CONSTRAINT `events_ibfk_4` FOREIGN KEY (`Venue_ID`) REFERENCES `venues` (`Venue_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events`
--

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
INSERT INTO `events` VALUES (1,1,1,1,1,'Tech Conference 2024','2024-01-15','2024-01-17',500,3,25000.00),(2,2,2,2,2,'Team Building Workshop','2024-02-10','2024-02-11',50,2,5000.00),(3,3,3,3,3,'Marketing Seminar','2024-03-05','2024-03-05',150,1,7500.00),(4,4,4,4,4,'Online Product Launch','2024-04-20','2024-04-20',300,1,3000.00),(6,2,6,6,6,'Industry Trade Show','2024-06-12','2024-06-14',1000,3,50000.00),(7,3,7,7,7,'Outdoor Team Retreat','2024-07-10','2024-07-12',30,3,3000.00),(8,4,8,8,8,'Product Demo Day','2024-08-15','2024-08-15',100,1,4000.00),(9,5,9,9,9,'Panel Discussion Series','2024-09-01','2024-09-03',250,3,10000.00),(10,1,10,10,10,'Tech Career Fair','2024-10-10','2024-10-10',400,1,20000.00),(11,2,11,11,11,'Hackathon 2024','2024-10-15','2024-10-16',150,2,12000.00),(12,3,12,12,12,'Leadership Roundtable','2024-11-05','2024-11-05',40,1,6000.00),(13,4,13,13,13,'Social Gathering Night','2024-12-10','2024-12-10',500,1,2000.00),(14,5,14,14,14,'Charity Fundraiser Gala','2025-01-20','2025-01-20',300,1,15000.00),(15,1,15,15,15,'Art Exhibition Opening','2025-02-05','2025-02-07',700,3,10000.00),(16,2,16,16,16,'New Book Launch Event','2025-03-12','2025-03-12',250,1,8000.00),(17,3,17,17,17,'Annual Sports Meet','2025-04-18','2025-04-20',1000,3,20000.00),(18,4,18,18,18,'National Science Fair','2025-05-10','2025-05-12',500,3,15000.00),(19,5,19,19,19,'Local Film Screening','2025-06-15','2025-06-15',200,1,3000.00),(20,1,20,20,20,'Cultural Festival','2025-07-01','2025-07-03',800,3,25000.00),(21,2,21,21,21,'Live Music Concert','2025-08-15','2025-08-15',1000,1,50000.00),(22,3,22,22,22,'Classical Dance Performance','2025-09-05','2025-09-05',400,1,15000.00),(23,4,23,23,23,'Drama Play Showcase','2025-10-10','2025-10-10',350,1,12000.00),(24,5,24,24,24,'National Quiz Contest','2025-11-20','2025-11-20',500,1,6000.00),(25,1,25,25,25,'Inter-University Debate','2025-12-05','2025-12-05',300,1,7000.00),(26,2,NULL,NULL,NULL,'Test Update','2024-01-10','2024-01-12',250,NULL,18000.00);
/*!40000 ALTER TABLE `events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organizers`
--

DROP TABLE IF EXISTS `organizers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `organizers` (
  `Organizer_ID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Email_Address` varchar(255) NOT NULL,
  `Contact_ID` int DEFAULT NULL,
  `Address_ID` int DEFAULT NULL,
  `Web_Site_Address` varchar(255) DEFAULT NULL,
  `Mobile_Number` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`Organizer_ID`),
  UNIQUE KEY `Email_Address` (`Email_Address`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organizers`
--

LOCK TABLES `organizers` WRITE;
/*!40000 ALTER TABLE `organizers` DISABLE KEYS */;
INSERT INTO `organizers` VALUES (1,'Organizer One','org1@example.com',101,201,'www.org1.com','1234567890'),(2,'Organizer Two','org2@example.com',102,202,'www.org2.com','1234567891'),(3,'Organizer Three','org3@example.com',103,203,'www.org3.com','1234567892'),(4,'Organizer Four','org4@example.com',104,204,'www.org4.com','1234567893'),(5,'Organizer Five','org5@example.com',105,205,'www.org5.com','1234567894'),(6,'Organizer Six','org6@example.com',106,206,'www.org6.com','1234567895'),(7,'Organizer Seven','org7@example.com',107,207,'www.org7.com','1234567896'),(8,'Organizer Eight','org8@example.com',108,208,'www.org8.com','1234567897'),(9,'Organizer Nine','org9@example.com',109,209,'www.org9.com','1234567898'),(10,'Organizer Ten','org10@example.com',110,210,'www.org10.com','1234567899'),(11,'Organizer Eleven','org11@example.com',111,211,'www.org11.com','1234567800'),(12,'Organizer Twelve','org12@example.com',112,212,'www.org12.com','1234567801'),(13,'Organizer Thirteen','org13@example.com',113,213,'www.org13.com','1234567802'),(14,'Organizer Fourteen','org14@example.com',114,214,'www.org14.com','1234567803'),(15,'Organizer Fifteen','org15@example.com',115,215,'www.org15.com','1234567804'),(16,'Organizer Sixteen','org16@example.com',116,216,'www.org16.com','1234567805'),(17,'Organizer Seventeen','org17@example.com',117,217,'www.org17.com','1234567806'),(18,'Organizer Eighteen','org18@example.com',118,218,'www.org18.com','1234567807'),(19,'Organizer Nineteen','org19@example.com',119,219,'www.org19.com','1234567808'),(20,'Organizer Twenty','org20@example.com',120,220,'www.org20.com','1234567809'),(21,'Organizer Twenty-One','org21@example.com',121,221,'www.org21.com','1234567810'),(22,'Organizer Twenty-Two','org22@example.com',122,222,'www.org22.com','1234567811'),(23,'Organizer Twenty-Three','org23@example.com',123,223,'www.org23.com','1234567812'),(24,'Organizer Twenty-Four','org24@example.com',124,224,'www.org24.com','1234567813'),(25,'Organizer Twenty-Five','org25@example.com',125,225,'www.org25.com','1234567814');
/*!40000 ALTER TABLE `organizers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ref_event_status`
--

DROP TABLE IF EXISTS `ref_event_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ref_event_status` (
  `Event_Status_Code` int NOT NULL AUTO_INCREMENT,
  `Event_Status_Description` varchar(255) NOT NULL,
  PRIMARY KEY (`Event_Status_Code`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ref_event_status`
--

LOCK TABLES `ref_event_status` WRITE;
/*!40000 ALTER TABLE `ref_event_status` DISABLE KEYS */;
INSERT INTO `ref_event_status` VALUES (1,'Scheduled'),(2,'Ongoing'),(3,'Completed'),(4,'Cancelled'),(5,'Postponed');
/*!40000 ALTER TABLE `ref_event_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ref_event_types`
--

DROP TABLE IF EXISTS `ref_event_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ref_event_types` (
  `Event_Type_Code` int NOT NULL AUTO_INCREMENT,
  `Event_Type_Description` varchar(255) NOT NULL,
  PRIMARY KEY (`Event_Type_Code`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ref_event_types`
--

LOCK TABLES `ref_event_types` WRITE;
/*!40000 ALTER TABLE `ref_event_types` DISABLE KEYS */;
INSERT INTO `ref_event_types` VALUES (1,'Conference'),(2,'Workshop'),(3,'Seminar'),(4,'Webinar'),(5,'Networking Event'),(6,'Trade Show'),(7,'Team Building'),(8,'Product Launch'),(9,'Panel Discussion'),(10,'Career Fair'),(11,'Hackathon'),(12,'Roundtable'),(13,'Social Gathering'),(14,'Fundraiser'),(15,'Art Exhibition'),(16,'Book Launch'),(17,'Sports Meet'),(18,'Science Fair'),(19,'Film Screening'),(20,'Cultural Festival'),(21,'Music Concert'),(22,'Dance Performance'),(23,'Drama Play'),(24,'Quiz Contest'),(25,'Debate Competition');
/*!40000 ALTER TABLE `ref_event_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `venues`
--

DROP TABLE IF EXISTS `venues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `venues` (
  `Venue_ID` int NOT NULL AUTO_INCREMENT,
  `Venue_Name` varchar(255) NOT NULL,
  `Other_Details` text,
  PRIMARY KEY (`Venue_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `venues`
--

LOCK TABLES `venues` WRITE;
/*!40000 ALTER TABLE `venues` DISABLE KEYS */;
INSERT INTO `venues` VALUES (1,'Venue A','Located downtown with capacity of 500'),(2,'Venue B','Located uptown with capacity of 300'),(3,'Venue C','Suburban location with 700 capacity'),(4,'Venue D','Coastal area, scenic with 400 capacity'),(5,'Venue E','Luxury venue with 200 capacity'),(6,'Venue F','Modern facility with state-of-the-art equipment'),(7,'Venue G','Outdoor venue for casual events'),(8,'Venue H','Conference hall with 1000 capacity'),(9,'Venue I','Mid-sized venue suitable for workshops'),(10,'Venue J','Rooftop venue with stunning views'),(11,'Venue K','Garden setting with capacity of 150'),(12,'Venue L','Historical building with charm and capacity of 250'),(13,'Venue M','Theatre with 600 seating capacity'),(14,'Venue N','Small studio space with 50 capacity'),(15,'Venue O','Sports arena with 5000 capacity'),(16,'Venue P','University hall with 1200 capacity'),(17,'Venue Q','Hotel ballroom with 400 capacity'),(18,'Venue R','Convention center with 2000 capacity'),(19,'Venue S','Warehouse-style venue with industrial charm'),(20,'Venue T','Museum gallery with 300 capacity'),(21,'Venue U','Aquarium event space with underwater view'),(22,'Venue V','Zoo pavilion with open seating'),(23,'Venue W','Airport hangar converted for events'),(24,'Venue X','Library conference room with 100 capacity'),(25,'Venue Y','Casino event room with 500 capacity');
/*!40000 ALTER TABLE `venues` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-14 13:56:54
