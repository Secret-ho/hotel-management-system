SET FOREIGN_KEY_CHECKS = 0;
CREATE DATABASE  IF NOT EXISTS `hotelmanagementsystem` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `hotelmanagementsystem`;
-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: hotelmanagementsystem
-- ------------------------------------------------------
-- Server version	9.7.0

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
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup
--

-- SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ 'a6d6ad67-4bc6-11f1-89d3-00090faa0001:1-60';

--
-- Table structure for table `corporate_invoice`
--

DROP TABLE IF EXISTS `corporate_invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `corporate_invoice` (
  `invoice_id` int NOT NULL,
  `company_name` varchar(100) NOT NULL,
  `company_registration_number` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`invoice_id`),
  CONSTRAINT `corporate_invoice_ibfk_1` FOREIGN KEY (`invoice_id`) REFERENCES `invoice` (`invoice_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corporate_invoice`
--

LOCK TABLES `corporate_invoice` WRITE;
/*!40000 ALTER TABLE `corporate_invoice` DISABLE KEYS */;
INSERT INTO `corporate_invoice` VALUES (2,'شرکت فناوری اطلاعات پارس','1234567890'),(6,'بازرگانی سامان','9876543210'),(9,'سازمان گردشگری آفتاب','1122334455');
/*!40000 ALTER TABLE `corporate_invoice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `national_id` varchar(20) NOT NULL,
  `birth_date` date DEFAULT NULL,
  `gender` enum('male','female','other') DEFAULT NULL,
  `mobile_phone` varchar(20) DEFAULT NULL,
  `landline_phone` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `address` text,
  `first_reservation_date` date DEFAULT NULL,
  `total_stays` int DEFAULT '0',
  `membership_level` enum('standard','silver','gold') DEFAULT 'standard',
  `registration_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `profile_picture` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `national_id` (`national_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'احمد','رضایی','0012345678','1985-04-15','male','09121234567','02188765432','ahmad.rezaee@email.com','تهران، خیابان آزادی','2023-01-10',5,'gold','2026-05-09 17:04:30',NULL),(2,'مریم','کریمی','0023456789','1990-07-22','female','09129876543','02188765433','maryam.karimi@email.com','تهران، خیابان ولیعصر','2023-02-15',3,'silver','2026-05-09 17:04:30',NULL),(3,'رضا','نوروزی','0034567890','1982-11-05','male','09351234567','05137654321','reza.norozi@email.com','مشهد، بلوار احمدآباد','2023-03-20',8,'gold','2026-05-09 17:04:30',NULL),(4,'سارا','احمدی','0045678901','1995-02-28','female','09101234567','03132223456','sara.ahmadi@email.com','اصفهان، چهارباغ','2023-04-25',2,'standard','2026-05-09 17:04:30',NULL),(5,'علی','محمدی','0056789012','1988-09-17','male','09111234567','02188543210','ali.mohammadi@email.com','تهران، سعادت‌آباد','2023-05-30',4,'silver','2026-05-09 17:04:30',NULL),(6,'فاطمه','حسینی','0067890123','1993-12-10','female','09121234568','05132234567','fatemeh.hosseini@email.com','مشهد، خیابان امام','2023-06-05',6,'gold','2026-05-09 17:04:30',NULL),(7,'حسین','عباسی','0078901234','1980-03-25','male','09131234567','03132224567','hossein.abbasi@email.com','اصفهان، میدان امام','2023-07-12',7,'gold','2026-05-09 17:04:30',NULL),(8,'زهرا','قاسمی','0089012345','1998-08-14','female','09141234567','04135554321','zahra.ghasemi@email.com','تبریز، خیابان امام','2023-08-18',1,'standard','2026-05-09 17:04:30',NULL),(9,'مهدی','کاظمی','0090123456','1987-04-05','male','09151234567','07132345678','mehdi.kazemi@email.com','شیراز، بلوار کریمخان','2023-09-22',3,'silver','2026-05-09 17:04:30',NULL),(10,'نرگس','پورحسن','0101234567','1992-06-30','female','09161234567','02537765432','narges.poorhasan@email.com','قم، بلوار جمهوری','2023-10-27',2,'standard','2026-05-09 17:04:30',NULL);
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feedback`
--

DROP TABLE IF EXISTS `feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `feedback` (
  `feedback_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `reservation_id` int DEFAULT NULL,
  `feedback_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `feedback_text` text,
  `overall_rating` int DEFAULT NULL,
  `room_quality_rating` int DEFAULT NULL,
  `service_quality_rating` int DEFAULT NULL,
  `staff_behavior_rating` int DEFAULT NULL,
  `status` enum('pending','processing','done') DEFAULT 'pending',
  `feedback_status` enum('pending','approved','rejected') DEFAULT 'pending',
  `submission_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `feedback_content` text,
  PRIMARY KEY (`feedback_id`),
  KEY `customer_id` (`customer_id`),
  KEY `reservation_id` (`reservation_id`),
  CONSTRAINT `feedback_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE CASCADE,
  CONSTRAINT `feedback_ibfk_2` FOREIGN KEY (`reservation_id`) REFERENCES `reservation` (`reservation_id`) ON DELETE SET NULL,
  CONSTRAINT `feedback_chk_1` CHECK ((`overall_rating` between 1 and 5)),
  CONSTRAINT `feedback_chk_2` CHECK ((`room_quality_rating` between 1 and 5)),
  CONSTRAINT `feedback_chk_3` CHECK ((`service_quality_rating` between 1 and 5)),
  CONSTRAINT `feedback_chk_4` CHECK ((`staff_behavior_rating` between 1 and 5))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feedback`
--

LOCK TABLES `feedback` WRITE;
/*!40000 ALTER TABLE `feedback` DISABLE KEYS */;
INSERT INTO `feedback` VALUES (1,1,1,'2026-05-09 17:04:31','هتل بسیار عالی بود، اتاق تمیز، کارکنان خوش‌برخورد',5,5,4,5,'done','approved','2026-05-09 17:04:31',NULL),(2,2,2,'2026-05-09 17:04:31','اتاق خوب بود ولی سرویس غذا دیر رسید',4,4,3,4,'done','approved','2026-05-09 17:04:31',NULL),(3,3,3,'2026-05-09 17:04:31','مشکل در سیستم تهویه اتاق داشتیم',3,3,4,4,'processing','pending','2026-05-09 17:04:31',NULL),(4,4,4,'2026-05-09 17:04:31','اقامت فوق‌العاده‌ای بود، حتما برمی‌گردیم',5,5,5,5,'done','approved','2026-05-09 17:04:31',NULL),(5,5,5,'2026-05-09 17:04:31','رزرو کنسل شد، اما پشتیبانی خوب بود',4,NULL,4,4,'done','approved','2026-05-09 17:04:31',NULL),(6,6,6,'2026-05-09 17:04:31','سوئیت رویال بی‌نظیر بود، ممنون از همه',5,5,5,5,'done','approved','2026-05-09 17:04:31',NULL),(7,7,7,'2026-05-09 17:04:31','نسبت به قیمت، اتاق کوچک بود',3,3,3,4,'done','approved','2026-05-09 17:04:31',NULL),(8,8,8,'2026-05-09 17:04:31','تمیزی خوب، کارکنان خوش‌اخلاق',4,4,4,5,'pending','pending','2026-05-09 17:04:31',NULL),(9,9,9,'2026-05-09 17:04:31','خدمات خشکشویی عالی بود',4,4,5,4,'processing','pending','2026-05-09 17:04:31',NULL),(10,10,10,'2026-05-09 17:04:31','هتل خوبی بود، موقعیت مکانی عالی',4,4,4,4,'done','approved','2026-05-09 17:04:31',NULL);
/*!40000 ALTER TABLE `feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hotel`
--

DROP TABLE IF EXISTS `hotel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hotel` (
  `hotel_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `code` varchar(20) NOT NULL,
  `address` text,
  `phone_number` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `total_floors` int DEFAULT NULL,
  `total_rooms` int DEFAULT NULL,
  `star_rating` int DEFAULT NULL,
  `facilities` text,
  `manager_name` varchar(100) DEFAULT NULL,
  `website` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`hotel_id`),
  UNIQUE KEY `code` (`code`),
  CONSTRAINT `hotel_chk_1` CHECK ((`star_rating` between 1 and 5))
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hotel`
--

LOCK TABLES `hotel` WRITE;
/*!40000 ALTER TABLE `hotel` DISABLE KEYS */;
INSERT INTO `hotel` VALUES (1,'هتل پارسیان','H001','تهران، خیابان ولیعصر، نبش خیابان پارک','02188765432','info@parsianhotel.com',5,120,5,'استخر، سونا، جکوزی، رستوران، پارکینگ','احمد رضایی','www.parsianhotel.com'),(2,'هتل اسپیناس','H002','تهران، خیابان سعادت‌آباد','02188543210','contact@espinas.com',12,250,5,'سالن همایش، استخر، اسپا، کافی‌شاپ','محمد کریمی','www.espinas.com'),(3,'هتل المپیک','H003','تهران، خیابان المپیک','02144789123','info@olympic.com',8,180,4,'استخر، رستوران، پارکینگ','سعید احمدی','www.olympichotel.com'),(4,'هتل آتیک','H004','مشهد، بلوار احمدآباد','05137654321','info@atic.com',4,80,4,'رستوران، کافی‌شاپ، پارکینگ','رضا نوروزی','www.atichotel.com'),(5,'هتل درویشی','H005','مشهد، خیابان امام رضا','05132234567','info@darvishee.com',6,110,4,'استخر، سونا، رستوران','علی درویشی','www.darvishee.com'),(6,'هتل همای','H006','اصفهان، چهارباغ عباسی','03132223456','info@homay.com',3,60,5,'تالار، استخر، رستوران سنتی','مهدی همایون','www.homayhotel.com'),(7,'هتل عباسی','H007','اصفهان، میدان امام','03132224567','info@abbasi.com',4,150,5,'رستوران سنتی، استخر، موزه','عباس صفوی','www.abbasihotel.com'),(8,'هتل لاله','H008','تبریز، خیابان امام','04135554321','info@laleh.com',5,95,3,'رستوران، پارکینگ','لطیف پور','www.lalehhotel.com'),(9,'هتل بزرگ شیراز','H009','شیراز، بلوار کریمخان','07132345678','info@shirazgrand.com',7,130,4,'استخر، رستوران، کافی‌شاپ','رضا حافظی','www.shirazgrand.com'),(10,'هتل کوثر','H010','قم، بلوار جمهوری','02537765432','info@kowsar.com',4,85,4,'رستوران، پارکینگ، نمازخانه','جواد حسینی','www.kowsarhotel.com');
/*!40000 ALTER TABLE `hotel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hotel_facility`
--

DROP TABLE IF EXISTS `hotel_facility`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hotel_facility` (
  `hotel_id` int NOT NULL,
  `facility_name` varchar(100) NOT NULL,
  PRIMARY KEY (`hotel_id`,`facility_name`),
  CONSTRAINT `hotel_facility_ibfk_1` FOREIGN KEY (`hotel_id`) REFERENCES `hotel` (`hotel_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hotel_facility`
--

LOCK TABLES `hotel_facility` WRITE;
/*!40000 ALTER TABLE `hotel_facility` DISABLE KEYS */;
INSERT INTO `hotel_facility` VALUES (1,'استخر'),(1,'جکوزی'),(1,'رستوران'),(1,'سونا'),(2,'اسپا'),(2,'استخر'),(2,'سالن همایش'),(3,'استخر'),(3,'رستوران'),(4,'رستوران'),(4,'کافی‌شاپ'),(5,'استخر'),(5,'رستوران'),(5,'سونا'),(6,'استخر'),(6,'تالار'),(6,'رستوران سنتی'),(7,'استخر'),(7,'رستوران سنتی'),(7,'موزه'),(8,'پارکینگ'),(8,'رستوران'),(9,'استخر'),(9,'رستوران'),(9,'کافی‌شاپ'),(10,'پارکینگ'),(10,'رستوران'),(10,'نمازخانه');
/*!40000 ALTER TABLE `hotel_facility` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `housekeeping`
--

DROP TABLE IF EXISTS `housekeeping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `housekeeping` (
  `staff_id` int NOT NULL,
  `area_responsibility` varchar(100) DEFAULT NULL,
  `tools_assigned` text,
  PRIMARY KEY (`staff_id`),
  CONSTRAINT `housekeeping_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `housekeeping`
--

LOCK TABLES `housekeeping` WRITE;
/*!40000 ALTER TABLE `housekeeping` DISABLE KEYS */;
INSERT INTO `housekeeping` VALUES (3,'طبقات 1 تا 3','جاروبرقی، مواد شوینده'),(7,'تمامی طبقات','جاروبرقی، مواد شوینده، تجهیزات نظافت');
/*!40000 ALTER TABLE `housekeeping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `individual_invoice`
--

DROP TABLE IF EXISTS `individual_invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `individual_invoice` (
  `invoice_id` int NOT NULL,
  `national_id_customer` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`invoice_id`),
  CONSTRAINT `individual_invoice_ibfk_1` FOREIGN KEY (`invoice_id`) REFERENCES `invoice` (`invoice_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `individual_invoice`
--

LOCK TABLES `individual_invoice` WRITE;
/*!40000 ALTER TABLE `individual_invoice` DISABLE KEYS */;
INSERT INTO `individual_invoice` VALUES (1,'0012345678'),(3,'0023456789'),(4,'0034567890'),(5,'0045678901'),(7,'0056789012'),(8,'0067890123'),(10,'0078901234');
/*!40000 ALTER TABLE `individual_invoice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoice`
--

DROP TABLE IF EXISTS `invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoice` (
  `invoice_id` int NOT NULL AUTO_INCREMENT,
  `invoice_number` varchar(20) NOT NULL,
  `issue_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `grand_total` decimal(10,2) DEFAULT NULL,
  `paid_amount` decimal(10,2) DEFAULT NULL,
  `remaining_amount` decimal(10,2) DEFAULT NULL,
  `cost_details` text,
  `status` enum('settled','unsettled') DEFAULT 'unsettled',
  `reservation_id` int DEFAULT NULL,
  `customer_id` int DEFAULT NULL,
  `issued_by_staff_id` int DEFAULT NULL,
  PRIMARY KEY (`invoice_id`),
  UNIQUE KEY `invoice_number` (`invoice_number`),
  KEY `reservation_id` (`reservation_id`),
  KEY `customer_id` (`customer_id`),
  KEY `issued_by_staff_id` (`issued_by_staff_id`),
  CONSTRAINT `invoice_ibfk_1` FOREIGN KEY (`reservation_id`) REFERENCES `reservation` (`reservation_id`) ON DELETE SET NULL,
  CONSTRAINT `invoice_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE CASCADE,
  CONSTRAINT `invoice_ibfk_3` FOREIGN KEY (`issued_by_staff_id`) REFERENCES `staff` (`staff_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice`
--

LOCK TABLES `invoice` WRITE;
/*!40000 ALTER TABLE `invoice` DISABLE KEYS */;
INSERT INTO `invoice` VALUES (1,'INV001','2026-05-09 17:04:30',1650000.00,1650000.00,0.00,'اقامت 3 شب اتاق 101','settled',1,1,2),(2,'INV002','2026-05-09 17:04:30',1650000.00,1650000.00,0.00,'اقامت 3 شب اتاق 101','settled',2,2,2),(3,'INV003','2026-05-09 17:04:30',1650000.00,1000000.00,650000.00,'اقامت 3 شب اتاق 102','unsettled',3,3,6),(4,'INV004','2026-05-09 17:04:30',6500000.00,6500000.00,0.00,'اقامت 5 شب اتاق 301 + خدمات ویژه','settled',4,4,2),(5,'INV005','2026-05-09 17:04:30',1100000.00,0.00,1100000.00,'اقامت 2 شب اتاق 201','unsettled',5,5,2),(6,'INV006','2026-05-09 17:04:30',6500000.00,6500000.00,0.00,'اقامت 5 شب اتاق 501','settled',6,6,10),(7,'INV007','2026-05-09 17:04:30',2200000.00,2200000.00,0.00,'اقامت 4 شب اتاق 202','settled',7,7,2),(8,'INV008','2026-05-09 17:04:30',840000.00,840000.00,0.00,'اقامت 2 شب اتاق 110','settled',8,8,10),(9,'INV009','2026-05-09 17:04:30',2750000.00,2750000.00,0.00,'اقامت 5 شب اتاق 105','settled',9,9,2),(10,'INV010','2026-05-09 17:04:30',1040000.00,1040000.00,0.00,'اقامت 2 شب اتاق 205','settled',10,10,6);
/*!40000 ALTER TABLE `invoice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manager`
--

DROP TABLE IF EXISTS `manager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `manager` (
  `staff_id` int NOT NULL,
  `management_level` varchar(50) DEFAULT NULL,
  `bonus` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`staff_id`),
  CONSTRAINT `manager_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manager`
--

LOCK TABLES `manager` WRITE;
/*!40000 ALTER TABLE `manager` DISABLE KEYS */;
INSERT INTO `manager` VALUES (1,'مدیرعامل',5000000.00),(5,'مدیر اجرایی',4500000.00),(9,'مدیر شعبه',4000000.00);
/*!40000 ALTER TABLE `manager` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `payment_id` int NOT NULL AUTO_INCREMENT,
  `payment_number` varchar(20) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `payment_method` enum('online','card','cash','bank_transfer') NOT NULL,
  `transaction_tracking_id` varchar(100) DEFAULT NULL,
  `status` enum('successful','failed','pending') DEFAULT 'pending',
  `source_account_name` varchar(100) DEFAULT NULL,
  `reservation_id` int DEFAULT NULL,
  PRIMARY KEY (`payment_id`),
  UNIQUE KEY `payment_number` (`payment_number`),
  KEY `reservation_id` (`reservation_id`),
  CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`reservation_id`) REFERENCES `reservation` (`reservation_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
INSERT INTO `payment` VALUES (1,'PAY001',1650000.00,'2026-05-09 17:04:30','online','TRX123456','successful','احمد رضایی',1),(2,'PAY002',1650000.00,'2026-05-09 17:04:30','online','TRX123457','successful','مریم کریمی',2),(3,'PAY003',1650000.00,'2026-05-09 17:04:30','cash',NULL,'pending','رضا نوروزی',3),(4,'PAY004',3000000.00,'2026-05-09 17:04:30','online','TRX123458','successful','سارا احمدی',4),(5,'PAY005',3500000.00,'2026-05-09 17:04:30','card',NULL,'successful','علی محمدی',4),(6,'PAY006',1100000.00,'2026-05-09 17:04:30','online','TRX123459','failed','احمد رضایی',5),(7,'PAY007',6500000.00,'2026-05-09 17:04:30','online','TRX123460','successful','فاطمه حسینی',6),(8,'PAY008',2200000.00,'2026-05-09 17:04:30','cash',NULL,'successful','حسین عباسی',7),(9,'PAY009',840000.00,'2026-05-09 17:04:30','online','TRX123461','successful','زهرا قاسمی',8),(10,'PAY010',2750000.00,'2026-05-09 17:04:30','online','TRX123462','successful','مهدی کاظمی',9);
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phone`
--

DROP TABLE IF EXISTS `phone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `phone` (
  `phone_id` int NOT NULL AUTO_INCREMENT,
  `phone_number` varchar(20) NOT NULL,
  `person_id` int NOT NULL,
  `person_type` enum('hotel','customer','staff') NOT NULL,
  PRIMARY KEY (`phone_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phone`
--

LOCK TABLES `phone` WRITE;
/*!40000 ALTER TABLE `phone` DISABLE KEYS */;
INSERT INTO `phone` VALUES (1,'02188765432',1,'hotel'),(2,'02188765433',1,'hotel'),(3,'09121234567',1,'customer'),(4,'09129876543',2,'customer'),(5,'09351234567',3,'customer'),(6,'09101234567',1,'staff'),(7,'09111234567',2,'staff'),(8,'09121234568',3,'staff'),(9,'02188543210',2,'hotel'),(10,'05137654321',4,'hotel'),(11,'02188765432',1,'hotel'),(12,'02188765433',1,'hotel'),(13,'09121234567',1,'customer'),(14,'09129876543',2,'customer'),(15,'09351234567',3,'customer'),(16,'09101234567',1,'staff'),(17,'09111234567',2,'staff'),(18,'09121234568',3,'staff'),(19,'02188543210',2,'hotel'),(20,'05137654321',4,'hotel');
/*!40000 ALTER TABLE `phone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `receptionist`
--

DROP TABLE IF EXISTS `receptionist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `receptionist` (
  `staff_id` int NOT NULL,
  `shift` enum('morning','evening','night') DEFAULT NULL,
  `desk_number` int DEFAULT NULL,
  PRIMARY KEY (`staff_id`),
  CONSTRAINT `receptionist_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `receptionist`
--

LOCK TABLES `receptionist` WRITE;
/*!40000 ALTER TABLE `receptionist` DISABLE KEYS */;
INSERT INTO `receptionist` VALUES (2,'morning',1),(6,'evening',2),(10,'night',1);
/*!40000 ALTER TABLE `receptionist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservation` (
  `reservation_id` int NOT NULL AUTO_INCREMENT,
  `reservation_number` varchar(20) NOT NULL,
  `reservation_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `check_in_date` date NOT NULL,
  `check_out_date` date NOT NULL,
  `nights` int DEFAULT NULL,
  `total_guests` int DEFAULT NULL,
  `adults` int DEFAULT NULL,
  `children` int DEFAULT NULL,
  `status` enum('confirmed','pending','cancelled','completed') DEFAULT 'pending',
  `estimated_total` decimal(10,2) DEFAULT NULL,
  `booking_method` enum('online','phone','in_person') DEFAULT 'online',
  `discount_code` varchar(50) DEFAULT NULL,
  `room_id` int DEFAULT NULL,
  `customer_id` int DEFAULT NULL,
  PRIMARY KEY (`reservation_id`),
  UNIQUE KEY `reservation_number` (`reservation_number`),
  KEY `room_id` (`room_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`room_id`) REFERENCES `room` (`room_id`) ON DELETE SET NULL,
  CONSTRAINT `reservation_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation`
--

LOCK TABLES `reservation` WRITE;
/*!40000 ALTER TABLE `reservation` DISABLE KEYS */;
INSERT INTO `reservation` VALUES (1,'RES001','2026-05-09 17:04:30','2026-05-15','2026-05-18',3,2,2,0,'confirmed',1650000.00,'online','WELCOME10',1,1),(2,'RES002','2026-05-09 17:04:30','2026-05-20','2026-05-23',3,2,2,0,'confirmed',1650000.00,'online',NULL,1,2),(3,'RES003','2026-05-09 17:04:30','2026-05-25','2026-05-28',3,2,2,0,'pending',1650000.00,'phone',NULL,2,3),(4,'RES004','2026-05-09 17:04:30','2026-06-01','2026-06-06',5,4,2,2,'confirmed',6500000.00,'online','FAMILY20',6,4),(5,'RES005','2026-05-09 17:04:30','2026-06-10','2026-06-12',2,2,2,0,'cancelled',1100000.00,'online',NULL,3,5),(6,'RES006','2026-05-09 17:04:30','2026-06-15','2026-06-20',5,3,3,0,'confirmed',6500000.00,'online','VIP10',5,6),(7,'RES007','2026-05-09 17:04:30','2026-06-18','2026-06-22',4,2,2,0,'confirmed',2200000.00,'in_person',NULL,4,7),(8,'RES008','2026-05-09 17:04:30','2026-07-01','2026-07-03',2,1,1,0,'pending',840000.00,'online',NULL,10,8),(9,'RES009','2026-05-09 17:04:30','2026-07-05','2026-07-10',5,2,2,0,'confirmed',2750000.00,'phone','SUMMER15',7,9),(10,'RES010','2026-05-09 17:04:30','2026-07-15','2026-07-17',2,2,2,0,'confirmed',1040000.00,'online',NULL,8,10);
/*!40000 ALTER TABLE `reservation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room`
--

DROP TABLE IF EXISTS `room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room` (
  `room_id` int NOT NULL AUTO_INCREMENT,
  `room_number` varchar(10) NOT NULL,
  `floor_number` int DEFAULT NULL,
  `status` enum('empty','reserved','occupied','cleaning','out_of_service') DEFAULT 'empty',
  `standard_capacity` int DEFAULT NULL,
  `max_capacity` int DEFAULT NULL,
  `standard_price_per_night` decimal(10,2) DEFAULT NULL,
  `amenities` text,
  `room_type_id` int DEFAULT NULL,
  `hotel_id` int DEFAULT NULL,
  PRIMARY KEY (`room_id`),
  KEY `room_type_id` (`room_type_id`),
  KEY `hotel_id` (`hotel_id`),
  CONSTRAINT `room_ibfk_1` FOREIGN KEY (`room_type_id`) REFERENCES `roomtype` (`room_type_id`) ON DELETE SET NULL,
  CONSTRAINT `room_ibfk_2` FOREIGN KEY (`hotel_id`) REFERENCES `hotel` (`hotel_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room`
--

LOCK TABLES `room` WRITE;
/*!40000 ALTER TABLE `room` DISABLE KEYS */;
INSERT INTO `room` VALUES (1,'101',1,'empty',2,2,550000.00,'تلویزیون، یخچال، اینترنت',1,1),(2,'102',1,'occupied',2,2,550000.00,'تلویزیون، یخچال، اینترنت',1,1),(3,'201',2,'reserved',2,2,750000.00,'تلویزیون، یخچال، اینترنت، بخاری',2,1),(4,'202',2,'cleaning',2,2,750000.00,'تلویزیون، یخچال، اینترنت، بخاری',2,1),(5,'301',3,'empty',3,4,1300000.00,'تلویزیون، یخچال، اینترنت، نشیمن',4,1),(6,'501',5,'empty',4,6,2800000.00,'تلویزیون، یخچال، اینترنت، جکوزی، نشیمن',5,1),(7,'105',1,'empty',2,2,520000.00,'تلویزیون، یخچال',1,2),(8,'205',2,'occupied',2,2,720000.00,'تلویزیون، یخچال، اینترنت',2,2),(9,'305',3,'empty',3,4,1250000.00,'تلویزیون، یخچال، اینترنت، نشیمن',4,2),(10,'110',1,'empty',1,1,420000.00,'تلویزیون، اینترنت',7,3),(11,'101',1,'empty',2,2,550000.00,'تلویزیون، یخچال، اینترنت',1,1),(12,'102',1,'occupied',2,2,550000.00,'تلویزیون، یخچال، اینترنت',1,1),(13,'201',2,'reserved',2,2,750000.00,'تلویزیون، یخچال، اینترنت، بخاری',2,1),(14,'202',2,'cleaning',2,2,750000.00,'تلویزیون، یخچال، اینترنت، بخاری',2,1),(15,'301',3,'empty',3,4,1300000.00,'تلویزیون، یخچال، اینترنت، نشیمن',4,1),(16,'501',5,'empty',4,6,2800000.00,'تلویزیون، یخچال، اینترنت، جکوزی، نشیمن',5,1),(17,'105',1,'empty',2,2,520000.00,'تلویزیون، یخچال',1,2),(18,'205',2,'occupied',2,2,720000.00,'تلویزیون، یخچال، اینترنت',2,2),(19,'305',3,'empty',3,4,1250000.00,'تلویزیون، یخچال، اینترنت، نشیمن',4,2),(20,'110',1,'empty',1,1,420000.00,'تلویزیون، اینترنت',7,3);
/*!40000 ALTER TABLE `room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roomtype`
--

DROP TABLE IF EXISTS `roomtype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roomtype` (
  `room_type_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` text,
  `default_capacity` int DEFAULT NULL,
  `min_price_per_night` decimal(10,2) DEFAULT NULL,
  `max_price_per_night` decimal(10,2) DEFAULT NULL,
  `min_booking_count` int DEFAULT NULL,
  `max_booking_count` int DEFAULT NULL,
  `status` enum('available','unavailable') DEFAULT 'available',
  PRIMARY KEY (`room_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roomtype`
--

LOCK TABLES `roomtype` WRITE;
/*!40000 ALTER TABLE `roomtype` DISABLE KEYS */;
INSERT INTO `roomtype` VALUES (1,'استاندارد','اتاق ساده با امکانات پایه',2,500000.00,800000.00,1,10,'available'),(2,'دبل','اتاق دو تخته',2,700000.00,1000000.00,1,8,'available'),(3,'تویین','اتاق دو تخته مجزا',2,750000.00,1100000.00,1,8,'available'),(4,'جونیور سوئیت','اتاق بزرگ با نشیمن',3,1200000.00,1800000.00,1,5,'available'),(5,'رویال سوئیت','لوکس‌ترین اتاق',4,2500000.00,4000000.00,1,3,'available'),(6,'خانوادگی','مناسب برای خانواده',5,1500000.00,2200000.00,1,6,'available'),(7,'تک نفره','اتاق یک تخته',1,400000.00,600000.00,1,10,'available'),(8,'استاندارد','اتاق ساده با امکانات پایه',2,500000.00,800000.00,1,10,'available'),(9,'دبل','اتاق دو تخته',2,700000.00,1000000.00,1,8,'available'),(10,'تویین','اتاق دو تخته مجزا',2,750000.00,1100000.00,1,8,'available'),(11,'جونیور سوئیت','اتاق بزرگ با نشیمن',3,1200000.00,1800000.00,1,5,'available'),(12,'رویال سوئیت','لوکس‌ترین اتاق',4,2500000.00,4000000.00,1,3,'available'),(13,'خانوادگی','مناسب برای خانواده',5,1500000.00,2200000.00,1,6,'available'),(14,'تک نفره','اتاق یک تخته',1,400000.00,600000.00,1,10,'available');
/*!40000 ALTER TABLE `roomtype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service`
--

DROP TABLE IF EXISTS `service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service` (
  `service_id` int NOT NULL AUTO_INCREMENT,
  `service_name` varchar(100) NOT NULL,
  `description` text,
  `base_fee` decimal(10,2) DEFAULT NULL,
  `unit_of_measure` enum('hourly','count','kg') DEFAULT 'count',
  `service_hours` varchar(100) DEFAULT NULL,
  `responsible_staff_id` int DEFAULT NULL,
  `room_id` int DEFAULT NULL,
  `customer_id` int DEFAULT NULL,
  `reservation_id` int DEFAULT NULL,
  PRIMARY KEY (`service_id`),
  KEY `responsible_staff_id` (`responsible_staff_id`),
  KEY `room_id` (`room_id`),
  KEY `customer_id` (`customer_id`),
  KEY `reservation_id` (`reservation_id`),
  CONSTRAINT `service_ibfk_1` FOREIGN KEY (`responsible_staff_id`) REFERENCES `staff` (`staff_id`) ON DELETE SET NULL,
  CONSTRAINT `service_ibfk_2` FOREIGN KEY (`room_id`) REFERENCES `room` (`room_id`) ON DELETE SET NULL,
  CONSTRAINT `service_ibfk_3` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE CASCADE,
  CONSTRAINT `service_ibfk_4` FOREIGN KEY (`reservation_id`) REFERENCES `reservation` (`reservation_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service`
--

LOCK TABLES `service` WRITE;
/*!40000 ALTER TABLE `service` DISABLE KEYS */;
INSERT INTO `service` VALUES (1,'روم سرویس','سرویس غذا در اتاق',150000.00,'count','24 ساعته',2,1,1,1),(2,'خشکشویی','خشکشویی البسه',50000.00,'kg','8:00 - 20:00',3,1,1,1),(3,'تاکسی سرویس','خدمات حمل و نقل',200000.00,'count','24 ساعته',2,2,2,2),(4,'ماساژ','ماساژ حرفه‌ای',300000.00,'hourly','10:00 - 22:00',1,5,6,6),(5,'تحویل غذا','سرویس غذا به درب اتاق',120000.00,'count','24 ساعته',2,6,4,4),(6,'نظافت اضافی','نظافت ویژه اتاق',80000.00,'count','ساعت درخواستی',3,3,5,NULL),(7,'سرویس نوشیدنی','نوشیدنی سرد و گرم',60000.00,'count','24 ساعته',2,4,7,7),(8,'اینترنت پرسرعت','اینترنت اختصاصی',50000.00,'count','24 ساعته',8,8,9,9),(9,'ترانسفر فرودگاه','سرویس رفت و برگشت فرودگاه',350000.00,'count','قبلی هماهنگی',10,9,10,10),(10,'ساتوکار','خدمات ساتوکار و پذیرایی',180000.00,'hourly','8:00 - 18:00',1,10,8,8),(11,'روم سرویس','سرویس غذا در اتاق',150000.00,'count','24 ساعته',2,1,1,1),(12,'خشکشویی','خشکشویی البسه',50000.00,'kg','8:00 - 20:00',3,1,1,1),(13,'تاکسی سرویس','خدمات حمل و نقل',200000.00,'count','24 ساعته',2,2,2,2),(14,'ماساژ','ماساژ حرفه‌ای',300000.00,'hourly','10:00 - 22:00',1,5,6,6),(15,'تحویل غذا','سرویس غذا به درب اتاق',120000.00,'count','24 ساعته',2,6,4,4),(16,'نظافت اضافی','نظافت ویژه اتاق',80000.00,'count','ساعت درخواستی',3,3,5,NULL),(17,'سرویس نوشیدنی','نوشیدنی سرد و گرم',60000.00,'count','24 ساعته',2,4,7,7),(18,'اینترنت پرسرعت','اینترنت اختصاصی',50000.00,'count','24 ساعته',8,8,9,9),(19,'ترانسفر فرودگاه','سرویس رفت و برگشت فرودگاه',350000.00,'count','قبلی هماهنگی',10,9,10,10),(20,'ساتوکار','خدمات ساتوکار و پذیرایی',180000.00,'hourly','8:00 - 18:00',1,10,8,8);
/*!40000 ALTER TABLE `service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff` (
  `staff_id` int NOT NULL AUTO_INCREMENT,
  `personal_code` varchar(20) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `national_id` varchar(20) NOT NULL,
  `birth_date` date DEFAULT NULL,
  `address` text,
  `job_title` varchar(50) DEFAULT NULL,
  `access_level` enum('admin','reception','housekeeping','cashier') NOT NULL,
  `hire_date` date DEFAULT NULL,
  `base_salary` decimal(10,2) DEFAULT NULL,
  `bank_account_info` text,
  `employment_status` enum('active','on_leave','terminated') DEFAULT 'active',
  `hotel_id` int DEFAULT NULL,
  PRIMARY KEY (`staff_id`),
  UNIQUE KEY `personal_code` (`personal_code`),
  UNIQUE KEY `national_id` (`national_id`),
  KEY `hotel_id` (`hotel_id`),
  CONSTRAINT `staff_ibfk_1` FOREIGN KEY (`hotel_id`) REFERENCES `hotel` (`hotel_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;


/* =====================================================
   USERS TABLE
===================================================== */

CREATE TABLE IF NOT EXISTS users
(
    user_id INT AUTO_INCREMENT PRIMARY KEY,

    username VARCHAR(50) NOT NULL UNIQUE,

    password_hash VARCHAR(255) NOT NULL,

    role ENUM
    (
        'admin',
        'reception',
        'cashier',
        'housekeeping'
    ) NOT NULL,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

/* =====================================================
   DEFAULT USERS
===================================================== */

INSERT INTO users
(
    username,
    password_hash,
    role
)
VALUES
(
    'admin1',
    SHA2('admin123',256),
    'admin'
),
(
    'reception1',
    SHA2('recep123',256),
    'reception'
),
(
    'cashier1',
    SHA2('cash123',256),
    'cashier'
),
(
    'housekeeping1',
    SHA2('house123',256),
    'housekeeping'
);

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES (1,'EMP001','رضا','مدیری','1111111111','1975-03-10','تهران، خیابان انقلاب','مدیرعامل','admin','2010-01-01',15000000.00,'IR0123456789','active',1),(2,'EMP002','سعید','نظری','2222222222','1985-07-22','تهران، خیابان آزادی','پذیرش','reception','2015-03-15',6000000.00,'IR0234567890','active',1),(3,'EMP003','مریم','صادقی','3333333333','1990-11-05','تهران، خیابان ولیعصر','سرپرست نظافت','housekeeping','2018-06-20',5500000.00,'IR0345678901','active',1),(4,'EMP004','علی','رضوی','4444444444','1988-09-18','مشهد، احمدآباد','صندوقدار','cashier','2016-02-10',6500000.00,'IR0456789012','active',4),(5,'EMP005','احمد','کریمی','5555555555','1982-12-01','اصفهان، چهارباغ','مدیر','admin','2012-05-05',14000000.00,'IR0567890123','active',6),(6,'EMP006','فاطمه','نوروزی','6666666666','1992-04-25','شیراز، بلوار کریمخان','پذیرش','reception','2019-09-10',5800000.00,'IR0678901234','on_leave',9),(7,'EMP007','حسن','حسینی','7777777777','1987-08-14','قم، جمهوری','نظافت','housekeeping','2020-01-15',4500000.00,'IR0789012345','active',10),(8,'EMP008','زهرا','عباسی','8888888888','1995-02-20','تهران، سعادت‌آباد','صندوقدار','cashier','2017-11-01',6200000.00,'IR0890123456','active',2),(9,'EMP009','محمدرضا','کاظمی','9999999999','1983-06-12','تبریز، امام','مدیر','admin','2014-07-07',13500000.00,'IR0901234567','active',8),(10,'EMP010','نگار','اسدی','1010101010','1993-10-30','مشهد، خیابان امام','پذیرش','reception','2021-03-20',5500000.00,'IR1012345678','active',5);
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-10 19:38:37



-- =====================================================
-- 1. Insert new staff members
-- =====================================================
INSERT INTO `staff` (`personal_code`, `first_name`, `last_name`, `national_id`, `birth_date`, `address`, `job_title`, `access_level`, `hire_date`, `base_salary`, `bank_account_info`, `employment_status`, `hotel_id`) VALUES
('EMP011', 'محمد', 'محمدی', '1111111112', '1988-05-12', 'تهران، خیابان آزادی', 'نظافت', 'housekeeping', '2022-01-15', 4800000.00, 'IR1111111111', 'active', 1),
('EMP012', 'زینب', 'رضایی', '2222222223', '1992-08-23', 'مشهد، بلوار احمدآباد', 'خدمه', 'housekeeping', '2021-06-20', 4700000.00, 'IR2222222222', 'active', 4),
('EMP013', 'حسین', 'محمدی', '3333333334', '1985-11-02', 'اصفهان، چهارباغ', 'نظافت', 'housekeeping', '2020-09-10', 5000000.00, 'IR3333333333', 'active', 6),
('EMP014', 'فاطمه', 'کریمی', '4444444445', '1995-03-18', 'شیراز، بلوار کریمخان', 'خدمه', 'housekeeping', '2023-02-01', 4600000.00, 'IR4444444444', 'active', 9),
('EMP015', 'علی', 'حسینی', '5555555556', '1990-07-07', 'قم، جمهوری', 'نظافت', 'housekeeping', '2022-08-25', 4900000.00, 'IR5555555555', 'active', 10),
('EMP016', 'سارا', 'موسوی', '6666666667', '1993-12-12', 'تبریز، خیابان امام', 'خدمه', 'housekeeping', '2021-11-11', 4750000.00, 'IR6666666666', 'active', 8),
('EMP017', 'کامران', 'شریفی', '7777777778', '1978-04-20', 'تهران، خیابان ولیعصر', 'مدیر اجرایی', 'admin', '2015-03-01', 14000000.00, 'IR7777777777', 'active', 2),
('EMP018', 'لیلا', 'نوری', '8888888889', '1982-09-15', 'مشهد، خیابان امام رضا', 'مدیر شعبه', 'admin', '2016-07-10', 13500000.00, 'IR8888888888', 'active', 5),
('EMP019', 'حمید', 'طاهری', '9999999990', '1980-01-30', 'اصفهان، میدان امام', 'مدیر عملیات', 'admin', '2014-11-05', 14500000.00, 'IR9999999999', 'active', 3),
('EMP020', 'نرگس', 'یزدانی', '1010101011', '1985-06-25', 'شیراز، بلوار کریمخان', 'مدیر فروش', 'admin', '2017-09-18', 13000000.00, 'IR1010101010', 'active', 7),
('EMP021', 'رضا', 'احمدی', '1112131415', '1979-12-03', 'قم، بلوار جمهوری', 'مدیر مالی', 'admin', '2018-02-20', 13800000.00, 'IR1112131415', 'active', 1),
('EMP022', 'سعید', 'رستمی', '1212121213', '1991-04-10', 'تهران، خیابان سعادت‌آباد', 'پذیرش', 'reception', '2020-05-15', 5800000.00, 'IR1212121212', 'active', 1),
('EMP023', 'مونا', 'کاظمی', '1313131314', '1994-08-17', 'مشهد، بلوار احمدآباد', 'پذیرش', 'reception', '2021-10-01', 5600000.00, 'IR1313131313', 'active', 4),
('EMP024', 'امیر', 'حیدری', '1414141415', '1996-01-22', 'اصفهان، چهارباغ', 'پذیرش', 'reception', '2022-03-12', 5900000.00, 'IR1414141414', 'active', 6),
('EMP025', 'شیدا', 'علیپور', '1515151516', '1993-09-05', 'شیراز، بلوار کریمخان', 'پذیرش', 'reception', '2019-12-20', 5700000.00, 'IR1515151515', 'active', 9),
('EMP026', 'پوریا', 'غفاری', '1616161617', '1995-11-30', 'قم، بلوار جمهوری', 'پذیرش', 'reception', '2023-01-08', 5500000.00, 'IR1616161616', 'active', 10);

-- =====================================================
-- 2. Insert new reservations (6 rows)
-- =====================================================
INSERT INTO `reservation` (`reservation_number`, `reservation_date`, `check_in_date`, `check_out_date`, `nights`, `total_guests`, `adults`, `children`, `status`, `estimated_total`, `booking_method`, `discount_code`, `room_id`, `customer_id`) VALUES
('RES011', CURRENT_TIMESTAMP, '2026-08-01', '2026-08-04', 3, 2, 2, 0, 'confirmed', 1650000.00, 'online', 'WELCOME10', 1, 1),
('RES012', CURRENT_TIMESTAMP, '2026-08-10', '2026-08-13', 3, 2, 2, 0, 'confirmed', 1650000.00, 'phone', NULL, 2, 2),
('RES013', CURRENT_TIMESTAMP, '2026-08-15', '2026-08-18', 3, 2, 2, 0, 'pending', 1650000.00, 'online', NULL, 3, 3),
('RES014', CURRENT_TIMESTAMP, '2026-08-20', '2026-08-25', 5, 4, 2, 2, 'confirmed', 6500000.00, 'in_person', 'FAMILY20', 6, 4),
('RES015', CURRENT_TIMESTAMP, '2026-08-25', '2026-08-27', 2, 2, 2, 0, 'confirmed', 1100000.00, 'online', NULL, 4, 5),
('RES016', CURRENT_TIMESTAMP, '2026-09-01', '2026-09-06', 5, 3, 3, 0, 'confirmed', 6500000.00, 'online', 'VIP10', 5, 6);

-- =====================================================
-- 3. Insert new invoices (6 rows)
-- =====================================================
INSERT INTO `invoice` (`invoice_number`, `issue_date`, `grand_total`, `paid_amount`, `remaining_amount`, `cost_details`, `status`, `reservation_id`, `customer_id`, `issued_by_staff_id`) VALUES
('INV011', CURRENT_TIMESTAMP, 1650000.00, 1650000.00, 0.00, 'اقامت 3 شب اتاق 101', 'settled', 11, 1, 2),
('INV012', CURRENT_TIMESTAMP, 1650000.00, 1000000.00, 650000.00, 'اقامت 3 شب اتاق 102', 'unsettled', 12, 2, 6),
('INV013', CURRENT_TIMESTAMP, 1650000.00, 0.00, 1650000.00, 'اقامت 3 شب اتاق 201', 'unsettled', 13, 3, 10),
('INV014', CURRENT_TIMESTAMP, 6500000.00, 6500000.00, 0.00, 'اقامت 5 شب اتاق 301 + خدمات ویژه', 'settled', 14, 4, 2),
('INV015', CURRENT_TIMESTAMP, 1100000.00, 1100000.00, 0.00, 'اقامت 2 شب اتاق 202', 'settled', 15, 5, 6),
('INV016', CURRENT_TIMESTAMP, 6500000.00, 6500000.00, 0.00, 'اقامت 5 شب اتاق 501', 'settled', 16, 6, 10);

-- =====================================================
-- 4. Insert into corporate_invoice (5 rows)
-- =====================================================
INSERT INTO `corporate_invoice` (`invoice_id`, `company_name`, `company_registration_number`) VALUES
(11, 'شرکت مهندسی آریا', '9988776655'),
(12, 'بازرگانی خلیج فارس', '5566778899'),
(13, 'سازمان همایش‌های بین‌المللی', '1122334466'),
(14, 'شرکت گردشگری هفت اقلیم', '4433221100'),
(15, 'هلدینگ توسعه گردشگری', '6677889900');

-- =====================================================
-- 5. Insert into individual_invoice (1 row)
-- =====================================================
INSERT INTO `individual_invoice` (`invoice_id`, `national_id_customer`) VALUES
(16, '0089012345');

-- =====================================================
-- 6. Insert into housekeeping (6 rows)
-- =====================================================
INSERT INTO `housekeeping` (`staff_id`, `area_responsibility`, `tools_assigned`) VALUES
(11, 'طبقات 4 تا 6 و لابی', 'جاروبرقی، مواد شوینده، تی'),
(12, 'طبقه همکف و رستوران', 'جاروبرقی صنعتی، مواد ضدعفونی'),
(13, 'سوئیت‌های ویژه و طبقه 5', 'جاروبرقی، مواد شوینده، بخارشوی'),
(14, 'اتاق‌های شرقی و سالن ورزشی', 'تی دستی، سطل، مواد شوینده'),
(15, 'برج شمالی و پارکینگ', 'جاروبرقی، مواد شوینده، جارو دستی'),
(16, 'مناطق عمومی و راهروها', 'جاروبرقی، مواد شوینده، تی برقی');

-- =====================================================
-- 7. Insert into manager (5 rows)
-- =====================================================
INSERT INTO `manager` (`staff_id`, `management_level`, `bonus`) VALUES
(17, 'مدیر اجرایی', 4800000.00),
(18, 'مدیر شعبه', 4500000.00),
(19, 'مدیر عملیات', 5000000.00),
(20, 'مدیر فروش', 4200000.00),
(21, 'مدیر مالی', 4600000.00);

-- =====================================================
-- 8. Insert into receptionist (5 rows)
-- =====================================================
INSERT INTO `receptionist` (`staff_id`, `shift`, `desk_number`) VALUES
(22, 'morning', 2),
(23, 'evening', 1),
(24, 'night', 2),
(25, 'morning', 3),
(26, 'evening', 3);

SET FOREIGN_KEY_CHECKS = 1;