-- MySQL dump 10.13  Distrib 8.0.30, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: bookmatch
-- ------------------------------------------------------
-- Server version	8.0.30

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bookmarks`
--

DROP TABLE IF EXISTS `bookmarks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookmarks` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `book_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `bookmarks_user_id_book_id_unique` (`user_id`,`book_id`),
  KEY `bookmarks_book_id_foreign` (`book_id`),
  CONSTRAINT `bookmarks_book_id_foreign` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`) ON DELETE CASCADE,
  CONSTRAINT `bookmarks_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookmarks`
--

LOCK TABLES `bookmarks` WRITE;
/*!40000 ALTER TABLE `bookmarks` DISABLE KEYS */;
/*!40000 ALTER TABLE `bookmarks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `books` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `author` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `isbn` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `genre_id` bigint unsigned NOT NULL,
  `publisher` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `published_year` smallint DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `cover_image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_copies` int NOT NULL DEFAULT '1',
  `available_copies` int NOT NULL DEFAULT '1',
  `location_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `books_isbn_unique` (`isbn`),
  UNIQUE KEY `books_slug_unique` (`slug`),
  KEY `books_genre_id_foreign` (`genre_id`),
  CONSTRAINT `books_genre_id_foreign` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books`
--

LOCK TABLES `books` WRITE;
/*!40000 ALTER TABLE `books` DISABLE KEYS */;
INSERT INTO `books` VALUES (1,'At Excepturi Culpa','Chelsie Zboncak','1049572332536',8,'Legros Ltd',1991,'Excepturi fuga eos culpa ullam a. Quia est ad ullam qui aperiam eos aut vitae. Ea quidem ut explicabo veritatis iste quia. Rem explicabo voluptatem aut dolor pariatur quia dignissimos. Ut quae sunt labore eum minus velit quia odit.','covers/placeholder.jpg',2,2,'RM-077','at-excepturi-culpa','2026-06-14 03:57:42','2026-06-14 03:57:42'),(2,'Nesciunt Porro Dolorem','Kellie Ziemann','4367256631065',4,'Strosin PLC',2010,'Consequatur unde omnis eum ad itaque similique. Non omnis ex beatae et repudiandae eum optio. Dolores dignissimos corporis et nihil voluptatem est.',NULL,3,3,'IB-849','nesciunt-porro-dolorem','2026-06-14 03:57:42','2026-06-14 03:57:42'),(3,'Optio Modi Cumque','Mrs. Hope Rau Sr.','2012133334038',10,'Corwin Ltd',1983,'Quasi deserunt eos et qui. Molestiae voluptatem illo sed ratione. Dolorem ratione sint eaque officiis qui esse saepe. Delectus doloribus quaerat est explicabo non dolores ex.',NULL,4,4,'CX-126','optio-modi-cumque','2026-06-14 03:57:42','2026-06-14 03:57:42'),(4,'Ab Qui Harum','Miss Joy Hintz','9594599793846',6,'Nitzsche, Swift and Effertz',1990,'Repellat quibusdam quas quia id sunt occaecati occaecati et. Et harum dignissimos accusantium alias ducimus aut dolorem. Aliquam aspernatur veritatis aliquam sit veritatis minima.','covers/placeholder.jpg',3,3,'XL-168','ab-qui-harum','2026-06-14 03:57:42','2026-06-14 03:57:42'),(5,'Id Dolorem Ad','Evans Bergstrom V','8735695795638',8,'Heidenreich, Kling and Corwin',2004,'Molestiae neque incidunt in iste architecto sequi velit. Mollitia perspiciatis est sunt qui ad quia at. Et eum quia officia repellendus ipsam debitis pariatur.','covers/placeholder.jpg',4,4,'XT-501','id-dolorem-ad','2026-06-14 03:57:42','2026-06-14 03:57:42'),(6,'Nesciunt Cum Ut','Rebeka Brown','2970207838542',5,'Mayer, Daniel and Little',2016,'Rerum est qui facere autem qui unde. Qui rerum repellendus qui molestiae. Accusamus quam omnis cum placeat neque sit.',NULL,1,1,'FS-035','nesciunt-cum-ut','2026-06-14 03:57:42','2026-06-14 03:57:42'),(7,'Aut Repudiandae Dicta','Rhett O\'Reilly','8040729164035',2,'Sipes PLC',1986,'Voluptas quisquam autem cum et vitae. Nihil corrupti et reiciendis aut qui. Porro dolore eligendi cumque est doloremque aliquam minus.','covers/placeholder.jpg',2,2,'FP-875','aut-repudiandae-dicta','2026-06-14 03:57:42','2026-06-14 03:57:42'),(8,'Suscipit Velit Et','Prof. Erik Farrell PhD','4697320810548',7,'Klocko-McCullough',2016,'Iure odit ut optio aut repellat et in. Exercitationem sunt ea aut ex ut. Perferendis ut quam qui autem dolores aut.','covers/placeholder.jpg',2,2,'YG-574','suscipit-velit-et','2026-06-14 03:57:42','2026-06-14 03:57:42'),(9,'Et Velit Libero','Barrett Borer III','0338869597930',5,'Ledner-Hickle',2004,'Enim vel soluta facere voluptatem perferendis delectus aliquid. Tempora minima et blanditiis sunt explicabo et provident quo. Mollitia veniam tenetur laborum et doloremque et.','covers/placeholder.jpg',1,1,'PE-369','et-velit-libero','2026-06-14 03:57:42','2026-06-14 03:57:42'),(10,'Aut Ab In','Dr. Jazmin Becker','9678908317328',9,'Gibson-Prosacco',2019,'Delectus et aut soluta. Sit explicabo voluptatem sapiente laboriosam. Voluptatibus fugiat assumenda pariatur sit quia nihil.','covers/placeholder.jpg',1,1,'GW-930','aut-ab-in','2026-06-14 03:57:42','2026-06-14 03:57:42'),(11,'Ducimus Molestiae Recusandae','Providenci Beatty','9647214880696',9,'Romaguera Ltd',2003,'Omnis architecto et sint in tenetur quidem unde omnis. Placeat eos rerum et qui corporis id eum. Id quidem voluptas adipisci reprehenderit et.',NULL,2,2,'EC-183','ducimus-molestiae-recusandae','2026-06-14 03:57:42','2026-06-14 03:57:42'),(12,'Dolores Et Sed','Bernadine Bogan','1196017319198',2,'Hessel, Nader and Cronin',1990,'Laboriosam quae iure odit velit magnam eligendi nobis. Dignissimos et perferendis nesciunt consequatur similique dicta soluta. Sequi non consequuntur sunt similique nemo nisi recusandae.','covers/placeholder.jpg',3,3,'NW-726','dolores-et-sed','2026-06-14 03:57:42','2026-06-14 03:57:42'),(13,'Et Qui Aut','Ms. Imogene Anderson DVM','3872201451471',1,'Hayes, Runolfsdottir and Haley',2017,'Ipsam explicabo ut totam corrupti. Mollitia quibusdam aperiam voluptatem sunt minus. Omnis officiis aut non iure laudantium.',NULL,4,4,'GU-022','et-qui-aut','2026-06-14 03:57:42','2026-06-14 03:57:42'),(14,'Quaerat Sit Tenetur','Amina Murazik','5026269383563',10,'Kilback LLC',1995,'Ullam doloremque occaecati corrupti id. Itaque sunt accusamus saepe voluptates explicabo quasi. Ab ad odio reiciendis sed. Laudantium iste eum amet quis in.','covers/placeholder.jpg',4,4,'DC-013','quaerat-sit-tenetur','2026-06-14 03:57:42','2026-06-14 03:57:42'),(15,'Repudiandae Ut Magni','Leonel Dicki','8156563727788',10,'Mayer-Kling',2021,'Voluptatum omnis aperiam facilis iste quo aliquid repudiandae. Assumenda tempora ducimus nisi ut. Alias rerum iusto hic deserunt asperiores officia. Excepturi dolor nobis ut vel quia earum.','covers/placeholder.jpg',5,5,'OL-645','repudiandae-ut-magni','2026-06-14 03:57:42','2026-06-14 03:57:42'),(16,'Numquam Deleniti Quod','Jess Krajcik','1600275118293',1,'Bosco, Armstrong and Kohler',2022,'Ea aut qui repellat cupiditate voluptas. Minima aliquam enim tenetur. Voluptatem rerum quaerat aut. Et et illo iste iste perferendis recusandae iste sed.',NULL,4,4,'UJ-850','numquam-deleniti-quod','2026-06-14 03:57:42','2026-06-14 03:57:42'),(17,'Sint Vero Inventore','Mr. Timothy Jacobson','3474208901914',5,'Langosh-McClure',1980,'Possimus ratione et illo velit eius non at porro. Quidem qui blanditiis autem placeat illum eligendi. Consequatur nam est sunt error ipsam tenetur ducimus. Odit nulla et qui harum perferendis consequatur.','covers/placeholder.jpg',3,3,'MP-809','sint-vero-inventore','2026-06-14 03:57:42','2026-06-14 03:57:42'),(18,'Qui Sed Ex','Clarabelle Schmitt DVM','6842779669337',10,'Cummings LLC',1994,'Earum doloribus et quia explicabo quia sapiente voluptatem. Delectus velit consequatur velit quia vitae laboriosam officia. Ad facilis quis voluptatibus in autem ipsum veniam. Sequi culpa quisquam nisi minus quis voluptatum.',NULL,5,5,'MA-141','qui-sed-ex','2026-06-14 03:57:42','2026-06-14 03:57:42'),(19,'Dolores Alias Provident','Sheldon Klocko','8814565370600',1,'Farrell-Kohler',1985,'Aut nobis modi nobis aut tempore. Distinctio dicta id dolorem consectetur voluptatibus aut. Maxime enim autem ex dicta vero aut. Est voluptates mollitia ducimus id suscipit qui reprehenderit expedita.','covers/placeholder.jpg',4,4,'SY-051','dolores-alias-provident','2026-06-14 03:57:42','2026-06-14 03:57:42'),(20,'Aliquid Odit Quo','Cody Heathcote','2625714576362',2,'Hamill, West and Schulist',2013,'Consequatur doloribus dolorem consectetur. Est qui corrupti natus enim. Et quas id commodi asperiores doloribus nam eaque. Vero omnis numquam nemo molestiae laudantium sed.','covers/placeholder.jpg',1,1,'SE-870','aliquid-odit-quo','2026-06-14 03:57:42','2026-06-14 03:57:42'),(21,'Cumque Ut Dolores','Prof. Torrance Hilpert MD','1158251655637',3,'Treutel, Denesik and Friesen',1987,'Magni exercitationem consectetur voluptas ea ut sint repudiandae. Vel neque laudantium consequatur commodi tenetur itaque error. Porro expedita possimus et maiores.','covers/placeholder.jpg',2,2,'HT-920','cumque-ut-dolores','2026-06-14 03:57:42','2026-06-14 03:57:42'),(22,'Officiis Aut Accusamus','Jaycee Sauer','3026629617458',3,'Cormier and Sons',1990,'Consequatur perspiciatis error dolor maxime non dolorem exercitationem. Facere quibusdam voluptas cupiditate ut ut nisi tempore. Est quaerat doloribus eligendi ut ea illum maxime quia. Ea accusantium perferendis exercitationem quisquam hic. Ut iste optio minus nesciunt.',NULL,2,2,'TH-047','officiis-aut-accusamus','2026-06-14 03:57:42','2026-06-14 03:57:42'),(23,'Quo Iure Sed','Dr. Hans Kertzmann DDS','6228536168582',7,'Schowalter PLC',1993,'Explicabo et asperiores quas. Sit aut nihil pariatur nesciunt voluptatem qui recusandae. Autem culpa error ut ut assumenda. Modi nobis necessitatibus eum alias.',NULL,1,1,'DR-986','quo-iure-sed','2026-06-14 03:57:42','2026-06-14 03:57:42'),(24,'Corporis Autem Doloremque','Larissa Borer','8765910423227',5,'Powlowski and Sons',2020,'Qui nobis est nobis ex sed sit rerum. Sapiente vel voluptates dolorem. Laborum enim quis nobis consectetur ut mollitia. Consequatur incidunt animi cupiditate dolorem. Eum aut rerum perferendis.','covers/placeholder.jpg',1,1,'HP-360','corporis-autem-doloremque','2026-06-14 03:57:42','2026-06-14 03:57:42'),(25,'Aspernatur Doloremque Dolor','Emelia Murazik','1842724276137',10,'Watsica, Hermiston and Koepp',1983,'Et et ipsam deleniti omnis sed. Ipsam dolore perspiciatis ea porro officia aliquam. Distinctio ea sequi sed eum.','covers/placeholder.jpg',5,5,'FZ-613','aspernatur-doloremque-dolor','2026-06-14 03:57:42','2026-06-14 03:57:42'),(26,'Eum Est Aut','Herman Turner','3401765435223',10,'Huels, Swift and Johnston',2013,'Odit odit fugit eius placeat eligendi consequatur quibusdam. Suscipit itaque nisi libero molestiae pariatur. Et in eos ea voluptas est cumque.','covers/placeholder.jpg',2,2,'HY-675','eum-est-aut','2026-06-14 03:57:42','2026-06-14 03:57:42'),(27,'Repellat Sunt Distinctio','Estevan Cassin I','5776084259791',6,'McClure-Lubowitz',2013,'Amet sequi culpa praesentium commodi quo. Dolorem aut culpa placeat ipsam dicta. Sint temporibus explicabo et expedita placeat ex molestiae.','covers/placeholder.jpg',2,2,'SB-739','repellat-sunt-distinctio','2026-06-14 03:57:42','2026-06-14 03:57:42'),(28,'Qui Ullam Ut','Hunter Jacobi','8189534923776',4,'Lindgren-Gorczany',2017,'Voluptas occaecati commodi aliquam id maiores quo iure exercitationem. Dignissimos sed necessitatibus quas et animi. Quos ut sit laborum ipsum corporis dolores quibusdam eos. Reiciendis alias consectetur dignissimos voluptas cum molestiae.','covers/placeholder.jpg',3,3,'VS-898','qui-ullam-ut','2026-06-14 03:57:42','2026-06-14 03:57:42'),(29,'Distinctio Magni Ut','Miss Ora Schulist','4052884720913',8,'Rempel, Monahan and Kohler',2000,'Reiciendis maxime sit reiciendis quis facere earum officia. Aut quia excepturi ut. Quae dicta dolor deleniti assumenda numquam.','covers/placeholder.jpg',5,5,'LX-686','distinctio-magni-ut','2026-06-14 03:57:42','2026-06-14 03:57:42'),(30,'Facilis Eius Est','Reyna Greenfelder','0198746540306',5,'Kris-Jacobson',2010,'Natus eligendi consequatur ea eos saepe consectetur. Et cumque quod illum molestiae. Et consequatur itaque praesentium veritatis laboriosam illo asperiores. Recusandae aut nihil laborum ut.','covers/placeholder.jpg',4,4,'JS-389','facilis-eius-est','2026-06-14 03:57:42','2026-06-14 03:57:42'),(31,'Maxime Et Possimus','Theron Moore','7060540359239',2,'Bergstrom Group',2009,'Cumque accusamus est ratione ut reiciendis aliquam voluptatem. Hic illum nobis doloribus earum sunt. Hic dolore non accusantium dolor minus et voluptatem. Quis quod aut repellat adipisci distinctio corrupti error.',NULL,3,3,'QN-126','maxime-et-possimus','2026-06-14 03:57:42','2026-06-14 03:57:42'),(32,'Qui Omnis Aut','Corine Johnston','4772644204791',10,'Beatty-Mitchell',1996,'Saepe laudantium officiis iste omnis cupiditate. Sed nemo voluptas aut illum possimus harum et. Repellendus voluptas necessitatibus illum adipisci. Dolore iusto optio in quos.',NULL,3,3,'GR-954','qui-omnis-aut','2026-06-14 03:57:42','2026-06-14 03:57:42'),(33,'Autem Illo Harum','Oceane Hoppe','2439618526392',1,'Yundt Group',1994,'Reiciendis et est et accusantium. Aliquam amet rerum iure nobis ut aspernatur modi. Nisi et quo quo cum quia maiores architecto. Ipsa rem dolor quia dolor corporis.','covers/placeholder.jpg',1,1,'HP-304','autem-illo-harum','2026-06-14 03:57:42','2026-06-14 03:57:42'),(34,'Velit Ullam Sed','Agustin Quitzon','1233761739082',9,'Dibbert-Sawayn',2007,'Consectetur et qui maxime dolor id itaque. Quia ut reiciendis impedit dolorem. Ex labore quaerat dolore qui quas. Magni omnis quibusdam et commodi.','covers/placeholder.jpg',1,1,'EH-150','velit-ullam-sed','2026-06-14 03:57:42','2026-06-14 03:57:42'),(35,'Non Natus Quod','Dr. Casper White','3316844100665',6,'Lakin, Hilpert and Price',1990,'Excepturi quia nisi neque et molestiae quis sint. Odio accusantium non quis nihil ut aut alias. Aut rem repellendus dolor enim. Possimus aut aut placeat.',NULL,1,1,'CF-387','non-natus-quod','2026-06-14 03:57:42','2026-06-14 03:57:42'),(36,'Omnis Voluptatem Nostrum','Viviane West','9022187061006',7,'Schowalter, Ortiz and Deckow',2017,'Nobis et aut voluptatum cumque laudantium sit eius. Pariatur veniam esse distinctio. Delectus accusamus id quis eos sit.',NULL,3,3,'FD-143','omnis-voluptatem-nostrum','2026-06-14 03:57:42','2026-06-14 03:57:42'),(37,'Non Aliquam Deleniti','Sydni Dicki','5531506271283',4,'Christiansen-Muller',1989,'Illum ullam iure soluta possimus tenetur sed. Quia id qui maxime eveniet commodi sit. Cupiditate aut neque est.','covers/placeholder.jpg',1,1,'BD-912','non-aliquam-deleniti','2026-06-14 03:57:42','2026-06-14 03:57:42'),(38,'Ipsam Assumenda Est','Monroe Schneider','7747426621743',9,'Terry, Rolfson and McDermott',2008,'Omnis ad qui sit voluptas fugit reiciendis fuga. Velit aut ullam et modi dolores autem. Perspiciatis ut aliquid quae. Quis dolor voluptatem temporibus.',NULL,2,2,'LM-569','ipsam-assumenda-est','2026-06-14 03:57:42','2026-06-14 03:57:42'),(39,'Esse Voluptates Fuga','Ova Olson MD','2933266288068',5,'Kuphal-Bernier',1982,'Provident quod distinctio qui nostrum. Dicta doloribus minus molestiae cum tempora commodi repudiandae. Repellendus ut praesentium sunt fugit quidem hic et. Rem velit eligendi dicta sed ut reprehenderit.',NULL,2,2,'GL-444','esse-voluptates-fuga','2026-06-14 03:57:42','2026-06-14 03:57:42'),(40,'Tenetur Aut Quaerat','Dr. Keith Lakin MD','4733778248878',10,'Haley-Johnson',1981,'Vel vitae alias incidunt. Labore qui eum vero totam optio assumenda assumenda. Dignissimos enim minima sunt consequatur quam non quisquam beatae. Sed impedit non ea repellendus.','covers/placeholder.jpg',3,3,'YJ-437','tenetur-aut-quaerat','2026-06-14 03:57:42','2026-06-14 03:57:42'),(41,'Atque Nisi Tempore','Drake Bauch V','3465365259991',6,'Wilderman, Kirlin and Hodkiewicz',2010,'Ut assumenda expedita sequi nam aut corporis. Sint optio aperiam quis delectus quisquam expedita. Dolorem ipsa eos voluptatem consectetur error.','covers/placeholder.jpg',3,3,'JP-683','atque-nisi-tempore','2026-06-14 03:57:42','2026-06-14 03:57:42'),(42,'Quaerat Sunt Accusantium','Bethel Hayes','7848054363295',3,'Emard, Bins and Borer',2007,'Est exercitationem porro minima omnis. Ut aut id quam soluta dolores unde praesentium. Rem et ipsa et distinctio reprehenderit cumque eaque.','covers/placeholder.jpg',1,1,'QG-007','quaerat-sunt-accusantium','2026-06-14 03:57:42','2026-06-14 03:57:42'),(43,'Consectetur Dolores Optio','Augustine Strosin','7048477632647',3,'Adams, Hirthe and Effertz',1996,'Sint sunt et est pariatur minus maiores enim. Necessitatibus temporibus quaerat voluptatibus molestiae aperiam et dolorem. Nostrum aut magni qui dolores. Veritatis et quis consequatur asperiores ullam quam. Eius nesciunt deleniti minima nesciunt fugiat sequi velit.','covers/placeholder.jpg',2,2,'YK-198','consectetur-dolores-optio','2026-06-14 03:57:42','2026-06-14 03:57:42'),(44,'Aperiam Nam Omnis','Daphne Pacocha DDS','1231244144720',4,'Hahn-Jaskolski',2017,'Aliquid laboriosam dicta quibusdam fuga dolorem delectus ut. Mollitia quibusdam culpa placeat in corporis eveniet veniam enim. Nihil aut cum nam ducimus nisi. Sint eos odio eum fugit.','covers/placeholder.jpg',2,2,'GQ-197','aperiam-nam-omnis','2026-06-14 03:57:42','2026-06-14 03:57:42'),(45,'Debitis Quis Nisi','Norberto Johnson','7748691262689',4,'Gibson-Kihn',1996,'Consequatur vel rem provident sit ea. Sunt ea aspernatur illum velit. Voluptas quia ut quaerat et voluptatem ipsam.','covers/placeholder.jpg',3,3,'WG-532','debitis-quis-nisi','2026-06-14 03:57:42','2026-06-14 03:57:42'),(46,'Magnam Sunt Illum','Miss Ima Jerde','3930822615975',2,'Stiedemann LLC',2004,'Sint vero est incidunt qui. Molestias fuga earum rerum accusantium atque fugiat voluptates sit. Iste ipsum nesciunt occaecati asperiores. Perspiciatis itaque officia nulla porro dolore temporibus.',NULL,2,2,'DG-673','magnam-sunt-illum','2026-06-14 03:57:42','2026-06-14 03:57:42'),(47,'Nesciunt Natus Sed','Karina McDermott','0035054112737',7,'O\'Hara Ltd',1983,'Voluptas autem non ut distinctio doloremque nemo consequatur dolores. Suscipit architecto impedit vitae. Vel odio voluptas qui at autem. A eum hic id quo incidunt autem.','covers/placeholder.jpg',4,4,'OK-943','nesciunt-natus-sed','2026-06-14 03:57:42','2026-06-14 03:57:42'),(48,'Perspiciatis Quas Accusantium','Tomasa Lehner','3124947168790',3,'Upton, Yost and Mayer',2016,'Velit suscipit voluptatem laborum ut cumque nam. Recusandae maxime laboriosam sunt. Accusantium optio qui consequatur itaque non nisi quod. Ut deserunt vel voluptate ipsam laborum.',NULL,1,1,'HP-983','perspiciatis-quas-accusantium','2026-06-14 03:57:42','2026-06-14 03:57:42'),(49,'Eaque Velit Voluptates','Howard Upton','7991382516549',8,'Lemke Ltd',1985,'Natus quisquam sint aut quam odit reprehenderit et. Et omnis ea molestiae. Deserunt a consectetur ullam doloribus aut.','covers/placeholder.jpg',2,2,'KF-939','eaque-velit-voluptates','2026-06-14 03:57:42','2026-06-14 03:57:42'),(50,'Nemo Corrupti Labore','Alexys Thompson','6139522545159',4,'Dietrich-Friesen',1987,'Natus magni ut sunt expedita. Magnam voluptas nesciunt exercitationem dolores ipsa at sint explicabo. Et numquam sint et ut accusamus explicabo id in. Voluptatem id dolor autem praesentium expedita eum ipsum.','covers/placeholder.jpg',5,5,'DX-210','nemo-corrupti-labore','2026-06-14 03:57:42','2026-06-14 03:57:42'),(51,'Dolor Autem Voluptatum','Heidi Kerluke','6954465777053',5,'Zieme, Bailey and Kutch',2020,'Et exercitationem maiores laboriosam sint est. Consectetur ipsum accusamus deserunt asperiores sit. Quas vitae nemo natus voluptas. Quaerat qui commodi ducimus sit ut ad voluptas.',NULL,4,4,'VE-373','dolor-autem-voluptatum','2026-06-14 03:57:42','2026-06-14 03:57:42'),(52,'Aut Qui Modi','Foster Emmerich IV','7547443690901',4,'Jakubowski, Gottlieb and Vandervort',1997,'Deserunt a minus veniam iure sapiente. Qui ut atque blanditiis officia cum. Iste consectetur porro ad porro saepe necessitatibus et.','covers/placeholder.jpg',5,5,'UX-005','aut-qui-modi','2026-06-14 03:57:42','2026-06-14 03:57:42'),(53,'Quo Consequatur Dolore','Dr. Gaston Walter IV','6513037425330',9,'Ruecker, Boehm and Casper',1999,'Dolorem ut rerum nesciunt omnis blanditiis rerum amet explicabo. Similique dicta repudiandae nisi aut quia. Veniam unde velit ipsum nisi ipsum modi aut earum. Explicabo et sunt asperiores illo ab accusantium.','covers/placeholder.jpg',5,5,'NT-544','quo-consequatur-dolore','2026-06-14 03:57:42','2026-06-14 03:57:42'),(54,'Non Non Quisquam','Eliseo Schuster','6638562090268',10,'Huels-McGlynn',1997,'Hic at et culpa enim nobis et dolorem aperiam. Est est saepe sunt nisi qui in quidem. Et et deleniti reiciendis aliquam aut incidunt. Voluptates iusto esse reiciendis placeat et distinctio tenetur.',NULL,4,4,'ZK-912','non-non-quisquam','2026-06-14 03:57:42','2026-06-14 03:57:42'),(55,'Quidem Itaque Odio','Herminia Stehr','0205058889469',2,'Hamill, Hudson and Stark',2024,'Eaque qui repudiandae veniam id. Quis sint saepe aut est facere.','covers/placeholder.jpg',2,2,'QF-457','quidem-itaque-odio','2026-06-14 03:57:42','2026-06-14 03:57:42'),(56,'Aspernatur Est Perspiciatis','Dallin Legros','9680771960834',7,'Maggio, Borer and Hill',1994,'Aliquam necessitatibus expedita fugiat iusto facilis et. Consectetur dolore recusandae excepturi veniam eum ipsum dignissimos sint. Molestias voluptate et ut ab asperiores quisquam dolor.',NULL,5,5,'EV-266','aspernatur-est-perspiciatis','2026-06-14 03:57:42','2026-06-14 03:57:42'),(57,'Quisquam Cum Qui','Dr. Titus Buckridge','1881609770261',4,'Hoppe Group',2011,'Ea ut ut reiciendis quis magnam architecto. Sed voluptates possimus laudantium suscipit cumque praesentium. Ullam optio temporibus repellendus assumenda temporibus reprehenderit.','covers/placeholder.jpg',3,3,'WC-734','quisquam-cum-qui','2026-06-14 03:57:42','2026-06-14 03:57:42'),(58,'Vitae Eum Praesentium','Donato Bosco','9400934218364',2,'Miller, Jenkins and Gibson',2017,'Excepturi voluptatibus quis magnam velit minus illo. Aspernatur accusantium unde sequi dicta minima et eos. Rerum tempore in ut nostrum consequuntur.','covers/placeholder.jpg',3,3,'DX-460','vitae-eum-praesentium','2026-06-14 03:57:42','2026-06-14 03:57:42'),(59,'Rerum Similique Pariatur','Precious Conroy','6137561403368',4,'Muller-Cartwright',1997,'Dignissimos perspiciatis sed aliquam explicabo et quia similique. Dolores optio sint illo saepe illum est vero nobis. Ut voluptatem et dicta ipsam.','covers/placeholder.jpg',2,2,'IX-976','rerum-similique-pariatur','2026-06-14 03:57:42','2026-06-14 03:57:42'),(60,'Blanditiis Enim Saepe','Johnson Frami','6521747056249',10,'Gutkowski-Sawayn',2008,'Nam exercitationem reiciendis quae quasi ducimus et voluptatem. Sit suscipit et explicabo quas exercitationem sint beatae. Rerum nobis officiis neque ut neque.','covers/placeholder.jpg',2,2,'OU-005','blanditiis-enim-saepe','2026-06-14 03:57:42','2026-06-14 03:57:42'),(61,'Ad Error Inventore','Josiah Romaguera','7431307780263',9,'Reynolds, Reichel and Hessel',1988,'Et nesciunt ab dolore iusto possimus eum dolore. Qui assumenda magni aut ut eum nulla. Voluptates et voluptatem eum hic. Aspernatur ex dignissimos blanditiis reprehenderit.','covers/placeholder.jpg',4,4,'QO-585','ad-error-inventore','2026-06-14 03:57:42','2026-06-14 03:57:42'),(62,'Molestiae Sit Ipsam','Dr. Brandt Douglas','5494639411591',6,'Cummerata, Auer and Feest',1991,'Laboriosam optio vero aut. Distinctio optio ad et perspiciatis. Rerum in quis necessitatibus harum.','covers/placeholder.jpg',1,1,'FP-556','molestiae-sit-ipsam','2026-06-14 03:57:42','2026-06-14 03:57:42'),(63,'Magnam Aspernatur Sapiente','Garett Hettinger','3917459105601',6,'Flatley Inc',2002,'Voluptas ut eum aliquam sed in. Pariatur voluptas dolorem deleniti animi sequi. Inventore ad est culpa asperiores. Magni quo voluptatem praesentium reprehenderit.','covers/placeholder.jpg',3,3,'RW-293','magnam-aspernatur-sapiente','2026-06-14 03:57:42','2026-06-14 03:57:42'),(64,'Ducimus Voluptas Voluptatibus','Kirsten Corwin','1763461057912',7,'Adams PLC',1983,'Commodi dicta ex aut nam est delectus. Officia dolor cupiditate perspiciatis maxime. Cupiditate consequatur sed dolorem eum corporis sunt quae. Omnis velit sed odit beatae.','covers/placeholder.jpg',5,5,'EH-177','ducimus-voluptas-voluptatibus','2026-06-14 03:57:42','2026-06-14 03:57:42'),(65,'Vitae Similique Corrupti','Elizabeth Conn','6409021195518',5,'Ledner-Luettgen',1980,'Dicta nihil magnam dolores officiis. Quidem earum laborum rerum laborum modi nostrum explicabo.','covers/placeholder.jpg',5,5,'WI-328','vitae-similique-corrupti','2026-06-14 03:57:42','2026-06-14 03:57:42'),(66,'Quo Iure Voluptatem','Mario Kshlerin','6310206375352',5,'Raynor, Murazik and Mosciski',2018,'Ea deserunt voluptas tempora sunt maiores voluptatem excepturi. Architecto quia dolores omnis qui. Velit error reiciendis architecto maiores optio praesentium optio corrupti. Doloribus nobis aut exercitationem impedit vitae unde cupiditate.','covers/placeholder.jpg',3,3,'YK-867','quo-iure-voluptatem','2026-06-14 03:57:42','2026-06-14 03:57:42'),(67,'Quis Veniam Eligendi','Prof. Corbin Hirthe','5441962415938',2,'Morissette-Hauck',2020,'Ab voluptatem odio tempora beatae quia. Alias aspernatur illo qui eos fuga voluptas. Eum praesentium numquam atque assumenda sapiente fugiat fugit.',NULL,5,5,'UT-331','quis-veniam-eligendi','2026-06-14 03:57:42','2026-06-14 03:57:42'),(68,'Illum Vitae Repellat','Evalyn Ruecker DVM','4899602097217',8,'Balistreri Inc',1990,'Rerum optio officia voluptas exercitationem et dolores. Adipisci nihil saepe consequatur ut fuga in recusandae. Sequi et error praesentium repellat sapiente placeat.',NULL,4,4,'AY-288','illum-vitae-repellat','2026-06-14 03:57:42','2026-06-14 03:57:42'),(69,'Placeat Consequatur Necessitatibus','Prof. Orlando Gleichner IV','2233574603616',10,'Jones-Pagac',1998,'Corporis corrupti soluta placeat totam quisquam sunt et dolor. Ab et repellat et iste deserunt. Voluptas pariatur aut quas sit qui odio.',NULL,1,1,'GJ-500','placeat-consequatur-necessitatibus','2026-06-14 03:57:42','2026-06-14 03:57:42'),(70,'Consectetur Consequatur Eos','Theodora Beer','6960227634536',7,'Dickens-Toy',2017,'Praesentium earum cum ipsa. Ad consequatur ut illo aut excepturi. Neque beatae voluptatum omnis voluptates id aut eum. Cumque eos et voluptatem unde.','covers/placeholder.jpg',5,5,'UL-146','consectetur-consequatur-eos','2026-06-14 03:57:42','2026-06-14 03:57:42'),(71,'Enim Eum Tenetur','Prof. Leopoldo Metz','5773287483205',6,'Dickens-Macejkovic',1981,'Facere qui sunt labore porro. Aut natus hic enim dolorem. Odit quia libero molestiae adipisci sunt architecto nihil. Aut qui pariatur ea distinctio fugiat aliquid unde.','covers/placeholder.jpg',2,2,'CH-093','enim-eum-tenetur','2026-06-14 03:57:42','2026-06-14 03:57:42'),(72,'Et Facere Dignissimos','Mr. Olen Russel','4830361066114',3,'Simonis and Sons',2007,'Et voluptas sapiente sit nemo quo vel repellat. Iure dolores nobis voluptatem aliquam. Odio rerum velit magni ducimus quod quaerat. Asperiores et id consequatur blanditiis.','covers/placeholder.jpg',2,2,'QV-470','et-facere-dignissimos','2026-06-14 03:57:42','2026-06-14 03:57:42'),(73,'Sed Blanditiis Ad','Velva Doyle','8089257303654',9,'Kuphal and Sons',1991,'Praesentium quaerat est voluptatem optio voluptates et illo. A ad delectus et placeat asperiores laborum corporis. Reprehenderit odio quae sit et non eligendi modi. Rem sunt ipsum magni recusandae aspernatur nisi beatae.','covers/placeholder.jpg',1,1,'DM-760','sed-blanditiis-ad','2026-06-14 03:57:42','2026-06-14 03:57:42'),(74,'Aut Velit Quis','Berta Veum','9806867860048',5,'Sporer, Will and Borer',1989,'Iusto ipsum et nulla voluptates aliquam. Asperiores nihil omnis aliquam. Est dignissimos qui cumque vel molestias occaecati. Eligendi possimus accusamus accusantium hic officiis quas dicta error. Dolores blanditiis ex officiis eos quae.',NULL,1,1,'HJ-708','aut-velit-quis','2026-06-14 03:57:42','2026-06-14 03:57:42'),(75,'Et Dolores Magni','Jazmin Price','8363215192700',2,'Howe-Rosenbaum',1981,'Vitae accusamus omnis et ut unde. Soluta assumenda nisi provident placeat quo. Sed non deleniti sint optio deleniti dolor dolor.','covers/placeholder.jpg',2,2,'GX-669','et-dolores-magni','2026-06-14 03:57:42','2026-06-14 03:57:42'),(76,'Beatae Excepturi Deserunt','Samanta Parisian','0324486526538',8,'Marks Group',2017,'Illum magnam voluptatem nostrum fugiat atque quisquam beatae. Adipisci perspiciatis hic animi deserunt ullam sapiente qui voluptatem. Id iste optio itaque est non minus. Natus animi iste omnis. Neque magni occaecati beatae ad.',NULL,1,1,'AQ-017','beatae-excepturi-deserunt','2026-06-14 03:57:42','2026-06-14 03:57:42'),(77,'Aut Voluptatem Nobis','Felton Braun','2692528605804',8,'Schimmel, Jacobson and Krajcik',2004,'Illo repudiandae at ut distinctio rerum. Ratione eos ut ad quisquam. Qui saepe rerum qui dolores.','covers/placeholder.jpg',1,1,'RA-553','aut-voluptatem-nobis','2026-06-14 03:57:42','2026-06-14 03:57:42'),(78,'Illum Tempora Tempore','Remington Franecki','3300560447556',10,'Brakus and Sons',2022,'Laudantium est hic quasi est facilis et. Porro voluptates tenetur ut qui et possimus perferendis. Consequatur sed ab in est tempore dicta.','covers/placeholder.jpg',1,1,'OY-000','illum-tempora-tempore','2026-06-14 03:57:42','2026-06-14 03:57:42'),(79,'Reiciendis Et Debitis','Mr. Jayden Halvorson','1546125239128',2,'Ebert, Kunde and Kunze',2015,'Necessitatibus numquam possimus officia praesentium quod omnis. Quod et qui ut et maxime natus qui. Corporis est nulla qui ut voluptatum quae.','covers/placeholder.jpg',5,5,'BJ-324','reiciendis-et-debitis','2026-06-14 03:57:42','2026-06-14 03:57:42'),(80,'Velit Voluptatum Recusandae','Mallory Mosciski','7942608562222',10,'Cremin Inc',2005,'Dignissimos tenetur et velit facere quia. Optio eos magnam iste commodi tempore. Voluptate atque atque voluptate.','covers/placeholder.jpg',3,3,'SO-824','velit-voluptatum-recusandae','2026-06-14 03:57:42','2026-06-14 03:57:42'),(81,'Nisi Quo Sapiente','Ms. Kimberly Price','0072210199812',7,'Schaefer-Schroeder',2003,'Excepturi debitis vitae fugit ea at molestiae. Exercitationem dicta velit corrupti voluptas cum. Est voluptas autem dignissimos. Atque quod itaque quasi nulla.','covers/placeholder.jpg',3,3,'MP-601','nisi-quo-sapiente','2026-06-14 03:57:42','2026-06-14 03:57:42'),(82,'Necessitatibus In Voluptatem','Aisha Dickinson','0387912479766',9,'Rowe, Botsford and Stokes',2016,'Tempore sit dolore in velit dolorum nesciunt non minus. Perspiciatis ullam nulla id omnis iste similique. Et nulla qui nisi quas quam deleniti voluptatibus beatae.',NULL,4,4,'OQ-662','necessitatibus-in-voluptatem','2026-06-14 03:57:42','2026-06-14 03:57:42'),(83,'Ut Est Quo','Mr. Osborne Bashirian','0559244035718',9,'Kautzer Ltd',2007,'Error cumque fugiat modi sit consequatur maiores molestiae. Unde qui voluptatibus tenetur ducimus qui dolores et. Voluptate nulla et et a.',NULL,2,2,'BA-003','ut-est-quo','2026-06-14 03:57:42','2026-06-14 03:57:42'),(84,'Delectus Et Ut','Mrs. Ivory Auer','8351230060837',2,'Krajcik-Hamill',1983,'Aut omnis magni animi ullam ipsa quo mollitia quisquam. Non voluptas magni eaque qui magni repellendus. Ut optio deserunt odit aliquam eveniet. Dolore non commodi et corrupti.','covers/placeholder.jpg',4,4,'IQ-712','delectus-et-ut','2026-06-14 03:57:42','2026-06-14 03:57:42'),(85,'Harum Veritatis Sint','Kasandra Skiles','3021708824927',3,'Dibbert, Kuphal and Towne',1991,'Eos excepturi esse temporibus natus. Nihil consectetur ut reprehenderit sit rerum tempora autem. Dolorum at debitis harum voluptate corrupti illo consequatur.','covers/placeholder.jpg',4,4,'KX-625','harum-veritatis-sint','2026-06-14 03:57:42','2026-06-14 03:57:42'),(86,'Sunt Ut Molestiae','Soledad Larkin','8755601758201',1,'Casper, Boyer and Dooley',2023,'Voluptatem et modi quis sint omnis. Quia beatae quis in et consequuntur aspernatur beatae reiciendis. Reprehenderit repellendus provident qui incidunt quia doloremque quia. Quia et debitis velit repellat minima libero.','covers/placeholder.jpg',3,3,'KD-475','sunt-ut-molestiae','2026-06-14 03:57:42','2026-06-14 03:57:42'),(87,'Qui Provident Nihil','Terrence Block','9434197749306',5,'Halvorson LLC',1992,'Rerum rerum laboriosam ut quas doloribus non et. Amet dolorem ad rem adipisci nam quia consequatur occaecati. Consequatur tempora consequatur vero tenetur laborum dolorem suscipit. Corporis eveniet est iusto at nobis ut magni. Aperiam et repudiandae esse eligendi consequatur soluta ea.','covers/placeholder.jpg',2,2,'HQ-916','qui-provident-nihil','2026-06-14 03:57:42','2026-06-14 03:57:42'),(88,'Totam Deserunt Non','Prof. Haleigh Morar V','0426534604726',1,'Spinka Ltd',2003,'Iste modi voluptatum numquam id et aut quod. Nostrum ab aut aliquid ratione totam enim. Tenetur saepe et accusantium ullam. Voluptas rerum quia debitis ad blanditiis rerum.',NULL,2,2,'PC-373','totam-deserunt-non','2026-06-14 03:57:42','2026-06-14 03:57:42'),(89,'Cum Et Mollitia','Dorthy Toy','8628230907130',8,'O\'Keefe LLC',2018,'Aut voluptatem rerum rerum voluptatem quia dolorem at eius. Et exercitationem eos expedita at itaque odio quia. In nihil eligendi sunt ut nostrum perspiciatis. Officiis excepturi esse dolor voluptatibus quos tempora.','covers/placeholder.jpg',4,4,'TL-722','cum-et-mollitia','2026-06-14 03:57:42','2026-06-14 03:57:42'),(90,'Praesentium Quibusdam Eum','Dr. Carlo Hyatt I','5866091075937',1,'Berge, Barrows and Bashirian',1996,'Facere optio perspiciatis et laboriosam consequatur ut. Quam voluptatem non provident rerum nisi nulla. Ut nihil omnis repudiandae iste vitae consequatur sed.','covers/placeholder.jpg',4,4,'RF-930','praesentium-quibusdam-eum','2026-06-14 03:57:42','2026-06-14 03:57:42'),(91,'Eum Quia Omnis','Elza Rogahn','7013846972989',2,'Torp-Kassulke',1982,'Repudiandae et esse repudiandae voluptatum non vero fugiat. Aut odio quo consequatur ipsam labore et doloremque. Nobis ratione vel rerum culpa porro debitis tempore. Dolorem excepturi architecto aut eaque aut.','covers/placeholder.jpg',1,1,'KX-379','eum-quia-omnis','2026-06-14 03:57:42','2026-06-14 03:57:42'),(92,'Temporibus Deserunt Veniam','Clotilde Quigley','6426977075101',6,'Conn-Hane',1997,'Autem neque atque voluptas et corporis. Autem iusto aut a et modi quos. Corrupti ut incidunt exercitationem aut quas. Quia repellat atque praesentium aspernatur.','covers/placeholder.jpg',1,1,'VO-489','temporibus-deserunt-veniam','2026-06-14 03:57:42','2026-06-14 03:57:42'),(93,'Dolor Nisi Sed','Miss Camille Steuber V','5545142404618',3,'Abshire Inc',1998,'Ea ratione occaecati harum sint quis vitae. Eum sit sit voluptatem accusantium. Commodi rem ullam id tempora qui. Sint quisquam beatae illo error enim ducimus.','covers/placeholder.jpg',4,4,'CH-910','dolor-nisi-sed','2026-06-14 03:57:42','2026-06-14 03:57:42'),(94,'Repudiandae Et Sunt','Roselyn Mante','8092625970193',1,'Ankunding LLC',2014,'Molestiae ut ipsa quia. Laborum harum ut saepe quia et impedit. Id molestiae aut deleniti voluptatem. Ex deleniti velit quia officiis aut natus.',NULL,4,4,'GP-944','repudiandae-et-sunt','2026-06-14 03:57:42','2026-06-14 03:57:42'),(95,'Aliquid Eum Omnis','Ricky Crooks PhD','3982021003810',8,'Reichel PLC',1992,'Vel voluptatum ipsum consequatur. Quam nam voluptate molestias in qui similique sit. Numquam atque quasi hic.','covers/placeholder.jpg',4,4,'DP-572','aliquid-eum-omnis','2026-06-14 03:57:42','2026-06-14 03:57:42'),(96,'Voluptatem Esse Dolor','Diana Krajcik','1490088510119',2,'Goldner-Kuhn',2020,'Fuga ea unde quia quo quam unde delectus. Laboriosam repellendus sint error optio. Dolorem quaerat earum aliquid quisquam quas quia. Quasi voluptas doloremque dignissimos impedit.','covers/placeholder.jpg',3,3,'AG-526','voluptatem-esse-dolor','2026-06-14 03:57:42','2026-06-14 03:57:42'),(97,'Iusto Temporibus Ipsum','German Rosenbaum','0925663476807',3,'Gutkowski Ltd',1996,'Ipsa quo aspernatur animi. Possimus facilis omnis vero sapiente. Necessitatibus sit fugit earum quos assumenda architecto.','covers/placeholder.jpg',1,1,'OR-795','iusto-temporibus-ipsum','2026-06-14 03:57:42','2026-06-14 03:57:42'),(98,'Non Doloremque Et','Ellie Stamm','8641188124448',9,'Hoeger-Nikolaus',2013,'Perspiciatis qui tenetur aut et laboriosam. Et maxime laboriosam culpa rerum. Rerum ut esse totam mollitia eum vel. Incidunt doloremque eos enim.',NULL,2,2,'GX-392','non-doloremque-et','2026-06-14 03:57:42','2026-06-14 03:57:42'),(99,'Odio Esse Dicta','Dorothea Pfannerstill','5582719308261',8,'Runolfsson-Will',1993,'Iste omnis sint voluptatem corrupti laborum. Odio et doloremque nihil qui est. Laboriosam nihil quaerat aut veritatis.',NULL,1,1,'HJ-151','odio-esse-dicta','2026-06-14 03:57:42','2026-06-14 03:57:42'),(100,'Nostrum Voluptatibus Eum','Retha Green MD','6082235044353',1,'Terry-Wilkinson',1999,'Voluptate voluptas eveniet deleniti et quia. Labore et qui tempora saepe ducimus illum. Nihil aut aut et qui ullam eum. Ipsam dicta est voluptatem asperiores atque excepturi quidem.','covers/placeholder.jpg',2,2,'OC-829','nostrum-voluptatibus-eum','2026-06-14 03:57:42','2026-06-14 03:57:42'),(101,'Test book','John Doe','123321',10,'Test publisher',2019,'This is a test book',NULL,2,50,'i9','test-book','2026-06-14 04:01:28','2026-06-14 04:01:28');
/*!40000 ALTER TABLE `books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `borrows`
--

DROP TABLE IF EXISTS `borrows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `borrows` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `book_id` bigint unsigned NOT NULL,
  `borrowed_at` datetime NOT NULL,
  `due_date` date NOT NULL,
  `returned_at` datetime DEFAULT NULL,
  `status` enum('active','returned','overdue') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `borrows_user_id_foreign` (`user_id`),
  KEY `borrows_book_id_foreign` (`book_id`),
  CONSTRAINT `borrows_book_id_foreign` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`) ON DELETE CASCADE,
  CONSTRAINT `borrows_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `borrows`
--

LOCK TABLES `borrows` WRITE;
/*!40000 ALTER TABLE `borrows` DISABLE KEYS */;
/*!40000 ALTER TABLE `borrows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` bigint NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache`
--

LOCK TABLES `cache` WRITE;
/*!40000 ALTER TABLE `cache` DISABLE KEYS */;
INSERT INTO `cache` VALUES ('bookmatch-cache-356a192b7913b04c54574d18c28d46e6395428ab','i:1;',1781429569),('bookmatch-cache-356a192b7913b04c54574d18c28d46e6395428ab:timer','i:1781429569;',1781429569),('bookmatch-cache-livewire-rate-limiter:16d36dff9abd246c67dfac3e63b993a169af77e6','i:1;',1781431036),('bookmatch-cache-livewire-rate-limiter:16d36dff9abd246c67dfac3e63b993a169af77e6:timer','i:1781431036;',1781431036),('bookmatch-cache-spatie.permission.cache','a:3:{s:5:\"alias\";a:4:{s:1:\"a\";s:2:\"id\";s:1:\"b\";s:4:\"name\";s:1:\"c\";s:10:\"guard_name\";s:1:\"r\";s:5:\"roles\";}s:11:\"permissions\";a:6:{i:0;a:4:{s:1:\"a\";i:1;s:1:\"b\";s:12:\"manage-books\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:2;}}i:1;a:4:{s:1:\"a\";i:2;s:1:\"b\";s:14:\"manage-borrows\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:2;}}i:2;a:4:{s:1:\"a\";i:3;s:1:\"b\";s:15:\"approve-ratings\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:2;}}i:3;a:4:{s:1:\"a\";i:4;s:1:\"b\";s:10:\"rate-books\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:3:{i:0;i:1;i:1;i:3;i:2;i:4;}}i:4;a:4:{s:1:\"a\";i:5;s:1:\"b\";s:12:\"borrow-books\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:3:{i:0;i:1;i:1;i:3;i:2;i:4;}}i:5;a:4:{s:1:\"a\";i:6;s:1:\"b\";s:18:\"manage-own-ratings\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:3:{i:0;i:1;i:1;i:3;i:2;i:4;}}}s:5:\"roles\";a:4:{i:0;a:3:{s:1:\"a\";i:1;s:1:\"b\";s:5:\"admin\";s:1:\"c\";s:3:\"web\";}i:1;a:3:{s:1:\"a\";i:2;s:1:\"b\";s:9:\"librarian\";s:1:\"c\";s:3:\"web\";}i:2;a:3:{s:1:\"a\";i:3;s:1:\"b\";s:7:\"student\";s:1:\"c\";s:3:\"web\";}i:3;a:3:{s:1:\"a\";i:4;s:1:\"b\";s:7:\"faculty\";s:1:\"c\";s:3:\"web\";}}}',1781513919);
/*!40000 ALTER TABLE `cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` bigint NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_locks_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_locks`
--

LOCK TABLES `cache_locks` WRITE;
/*!40000 ALTER TABLE `cache_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`),
  KEY `failed_jobs_connection_queue_failed_at_index` (`connection`,`queue`,`failed_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genres`
--

DROP TABLE IF EXISTS `genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `genres` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `genres_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genres`
--

LOCK TABLES `genres` WRITE;
/*!40000 ALTER TABLE `genres` DISABLE KEYS */;
INSERT INTO `genres` VALUES (1,'Computer Science','computer-science','Et ullam minima suscipit itaque perspiciatis officia.','2026-06-14 03:57:42','2026-06-14 03:57:42'),(2,'Mathematics','mathematics','Libero quia suscipit nemo sint rem minima facere.','2026-06-14 03:57:42','2026-06-14 03:57:42'),(3,'Literature','literature','Aut harum quis culpa ea.','2026-06-14 03:57:42','2026-06-14 03:57:42'),(4,'History','history','Enim voluptatem quas dicta et sunt aliquid.','2026-06-14 03:57:42','2026-06-14 03:57:42'),(5,'Physics','physics','Maiores in ea adipisci tempora iste.','2026-06-14 03:57:42','2026-06-14 03:57:42'),(6,'Biology','biology','Aut ea nisi illo enim.','2026-06-14 03:57:42','2026-06-14 03:57:42'),(7,'Engineering','engineering','Ea illo cum et corporis quis a.','2026-06-14 03:57:42','2026-06-14 03:57:42'),(8,'Philosophy','philosophy','Corporis voluptas ullam enim et vel sunt enim.','2026-06-14 03:57:42','2026-06-14 03:57:42'),(9,'Economics','economics','Adipisci illo nobis molestiae dignissimos.','2026-06-14 03:57:42','2026-06-14 03:57:42'),(10,'Arts','arts','Officiis ducimus et et facere error vel tenetur voluptatum.','2026-06-14 03:57:42','2026-06-14 03:57:42');
/*!40000 ALTER TABLE `genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_batches`
--

LOCK TABLES `job_batches` WRITE;
/*!40000 ALTER TABLE `job_batches` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_batches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` smallint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
INSERT INTO `jobs` VALUES (1,'default','{\"uuid\":\"b3758989-9e9d-46e4-b4c0-ecd4f1b6cbc2\",\"displayName\":\"App\\\\Listeners\\\\SendRatingApprovedNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"deleteWhenMissingModels\":false,\"data\":{\"commandName\":\"Illuminate\\\\Events\\\\CallQueuedListener\",\"command\":\"O:36:\\\"Illuminate\\\\Events\\\\CallQueuedListener\\\":28:{s:5:\\\"class\\\";s:44:\\\"App\\\\Listeners\\\\SendRatingApprovedNotification\\\";s:6:\\\"method\\\";s:6:\\\"handle\\\";s:4:\\\"data\\\";a:1:{i:0;O:25:\\\"App\\\\Events\\\\RatingApproved\\\":1:{s:6:\\\"rating\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:17:\\\"App\\\\Models\\\\Rating\\\";s:2:\\\"id\\\";i:300;s:9:\\\"relations\\\";a:2:{i:0;s:4:\\\"user\\\";i:1;s:4:\\\"book\\\";}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}}s:5:\\\"tries\\\";N;s:13:\\\"maxExceptions\\\";N;s:7:\\\"backoff\\\";N;s:10:\\\"retryUntil\\\";N;s:7:\\\"timeout\\\";N;s:13:\\\"failOnTimeout\\\";b:0;s:17:\\\"shouldBeEncrypted\\\";b:0;s:23:\\\"deleteWhenMissingModels\\\";b:0;s:14:\\\"shouldBeUnique\\\";b:0;s:29:\\\"shouldBeUniqueUntilProcessing\\\";b:0;s:8:\\\"uniqueId\\\";N;s:9:\\\"uniqueFor\\\";N;s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:13:\\\"debounceOwner\\\";s:0:\\\"\\\";s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\",\"batchId\":null},\"createdAt\":1781427793,\"delay\":null}',0,NULL,1781427793,1781427793),(2,'default','{\"uuid\":\"7905ee0e-70cf-480a-bec6-4a456ec79719\",\"displayName\":\"App\\\\Listeners\\\\SendRatingApprovedNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"deleteWhenMissingModels\":false,\"data\":{\"commandName\":\"Illuminate\\\\Events\\\\CallQueuedListener\",\"command\":\"O:36:\\\"Illuminate\\\\Events\\\\CallQueuedListener\\\":28:{s:5:\\\"class\\\";s:44:\\\"App\\\\Listeners\\\\SendRatingApprovedNotification\\\";s:6:\\\"method\\\";s:6:\\\"handle\\\";s:4:\\\"data\\\";a:1:{i:0;O:25:\\\"App\\\\Events\\\\RatingApproved\\\":1:{s:6:\\\"rating\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:17:\\\"App\\\\Models\\\\Rating\\\";s:2:\\\"id\\\";i:300;s:9:\\\"relations\\\";a:2:{i:0;s:4:\\\"user\\\";i:1;s:4:\\\"book\\\";}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}}s:5:\\\"tries\\\";N;s:13:\\\"maxExceptions\\\";N;s:7:\\\"backoff\\\";N;s:10:\\\"retryUntil\\\";N;s:7:\\\"timeout\\\";N;s:13:\\\"failOnTimeout\\\";b:0;s:17:\\\"shouldBeEncrypted\\\";b:0;s:23:\\\"deleteWhenMissingModels\\\";b:0;s:14:\\\"shouldBeUnique\\\";b:0;s:29:\\\"shouldBeUniqueUntilProcessing\\\";b:0;s:8:\\\"uniqueId\\\";N;s:9:\\\"uniqueFor\\\";N;s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:13:\\\"debounceOwner\\\";s:0:\\\"\\\";s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\",\"batchId\":null},\"createdAt\":1781427793,\"delay\":null}',0,NULL,1781427793,1781427793),(3,'default','{\"uuid\":\"7e86712b-cce9-4871-8205-6ebaa870a433\",\"displayName\":\"App\\\\Listeners\\\\SendRatingSubmittedNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"deleteWhenMissingModels\":false,\"data\":{\"commandName\":\"Illuminate\\\\Events\\\\CallQueuedListener\",\"command\":\"O:36:\\\"Illuminate\\\\Events\\\\CallQueuedListener\\\":28:{s:5:\\\"class\\\";s:45:\\\"App\\\\Listeners\\\\SendRatingSubmittedNotification\\\";s:6:\\\"method\\\";s:6:\\\"handle\\\";s:4:\\\"data\\\";a:1:{i:0;O:26:\\\"App\\\\Events\\\\RatingSubmitted\\\":2:{s:4:\\\"user\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";i:24;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:4:\\\"book\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\Book\\\";s:2:\\\"id\\\";i:101;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}}s:5:\\\"tries\\\";N;s:13:\\\"maxExceptions\\\";N;s:7:\\\"backoff\\\";N;s:10:\\\"retryUntil\\\";N;s:7:\\\"timeout\\\";N;s:13:\\\"failOnTimeout\\\";b:0;s:17:\\\"shouldBeEncrypted\\\";b:0;s:23:\\\"deleteWhenMissingModels\\\";b:0;s:14:\\\"shouldBeUnique\\\";b:0;s:29:\\\"shouldBeUniqueUntilProcessing\\\";b:0;s:8:\\\"uniqueId\\\";N;s:9:\\\"uniqueFor\\\";N;s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:13:\\\"debounceOwner\\\";s:0:\\\"\\\";s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\",\"batchId\":null},\"createdAt\":1781431653,\"delay\":null}',0,NULL,1781431653,1781431653),(4,'default','{\"uuid\":\"02d9dac7-8f7f-45ed-b015-7cafe76824b9\",\"displayName\":\"App\\\\Listeners\\\\SendRatingSubmittedNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"deleteWhenMissingModels\":false,\"data\":{\"commandName\":\"Illuminate\\\\Events\\\\CallQueuedListener\",\"command\":\"O:36:\\\"Illuminate\\\\Events\\\\CallQueuedListener\\\":28:{s:5:\\\"class\\\";s:45:\\\"App\\\\Listeners\\\\SendRatingSubmittedNotification\\\";s:6:\\\"method\\\";s:6:\\\"handle\\\";s:4:\\\"data\\\";a:1:{i:0;O:26:\\\"App\\\\Events\\\\RatingSubmitted\\\":2:{s:4:\\\"user\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";i:24;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:4:\\\"book\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\Book\\\";s:2:\\\"id\\\";i:101;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}}s:5:\\\"tries\\\";N;s:13:\\\"maxExceptions\\\";N;s:7:\\\"backoff\\\";N;s:10:\\\"retryUntil\\\";N;s:7:\\\"timeout\\\";N;s:13:\\\"failOnTimeout\\\";b:0;s:17:\\\"shouldBeEncrypted\\\";b:0;s:23:\\\"deleteWhenMissingModels\\\";b:0;s:14:\\\"shouldBeUnique\\\";b:0;s:29:\\\"shouldBeUniqueUntilProcessing\\\";b:0;s:8:\\\"uniqueId\\\";N;s:9:\\\"uniqueFor\\\";N;s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:13:\\\"debounceOwner\\\";s:0:\\\"\\\";s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\",\"batchId\":null},\"createdAt\":1781431653,\"delay\":null}',0,NULL,1781431653,1781431653),(5,'default','{\"uuid\":\"257dd57b-224b-4fcb-9cb7-45e0ddba1a8c\",\"displayName\":\"App\\\\Listeners\\\\SendRatingApprovedNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"deleteWhenMissingModels\":false,\"data\":{\"commandName\":\"Illuminate\\\\Events\\\\CallQueuedListener\",\"command\":\"O:36:\\\"Illuminate\\\\Events\\\\CallQueuedListener\\\":28:{s:5:\\\"class\\\";s:44:\\\"App\\\\Listeners\\\\SendRatingApprovedNotification\\\";s:6:\\\"method\\\";s:6:\\\"handle\\\";s:4:\\\"data\\\";a:1:{i:0;O:25:\\\"App\\\\Events\\\\RatingApproved\\\":1:{s:6:\\\"rating\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:17:\\\"App\\\\Models\\\\Rating\\\";s:2:\\\"id\\\";i:301;s:9:\\\"relations\\\";a:2:{i:0;s:4:\\\"user\\\";i:1;s:4:\\\"book\\\";}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}}s:5:\\\"tries\\\";N;s:13:\\\"maxExceptions\\\";N;s:7:\\\"backoff\\\";N;s:10:\\\"retryUntil\\\";N;s:7:\\\"timeout\\\";N;s:13:\\\"failOnTimeout\\\";b:0;s:17:\\\"shouldBeEncrypted\\\";b:0;s:23:\\\"deleteWhenMissingModels\\\";b:0;s:14:\\\"shouldBeUnique\\\";b:0;s:29:\\\"shouldBeUniqueUntilProcessing\\\";b:0;s:8:\\\"uniqueId\\\";N;s:9:\\\"uniqueFor\\\";N;s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:13:\\\"debounceOwner\\\";s:0:\\\"\\\";s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\",\"batchId\":null},\"createdAt\":1781431670,\"delay\":null}',0,NULL,1781431670,1781431670),(6,'default','{\"uuid\":\"a8011455-1939-4e94-8565-674774bd9ca4\",\"displayName\":\"App\\\\Listeners\\\\SendRatingApprovedNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"deleteWhenMissingModels\":false,\"data\":{\"commandName\":\"Illuminate\\\\Events\\\\CallQueuedListener\",\"command\":\"O:36:\\\"Illuminate\\\\Events\\\\CallQueuedListener\\\":28:{s:5:\\\"class\\\";s:44:\\\"App\\\\Listeners\\\\SendRatingApprovedNotification\\\";s:6:\\\"method\\\";s:6:\\\"handle\\\";s:4:\\\"data\\\";a:1:{i:0;O:25:\\\"App\\\\Events\\\\RatingApproved\\\":1:{s:6:\\\"rating\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:17:\\\"App\\\\Models\\\\Rating\\\";s:2:\\\"id\\\";i:301;s:9:\\\"relations\\\";a:2:{i:0;s:4:\\\"user\\\";i:1;s:4:\\\"book\\\";}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}}s:5:\\\"tries\\\";N;s:13:\\\"maxExceptions\\\";N;s:7:\\\"backoff\\\";N;s:10:\\\"retryUntil\\\";N;s:7:\\\"timeout\\\";N;s:13:\\\"failOnTimeout\\\";b:0;s:17:\\\"shouldBeEncrypted\\\";b:0;s:23:\\\"deleteWhenMissingModels\\\";b:0;s:14:\\\"shouldBeUnique\\\";b:0;s:29:\\\"shouldBeUniqueUntilProcessing\\\";b:0;s:8:\\\"uniqueId\\\";N;s:9:\\\"uniqueFor\\\";N;s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:13:\\\"debounceOwner\\\";s:0:\\\"\\\";s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\",\"batchId\":null},\"createdAt\":1781431670,\"delay\":null}',0,NULL,1781431670,1781431670);
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'0001_01_01_000000_create_users_table',1),(2,'0001_01_01_000001_create_cache_table',1),(3,'0001_01_01_000002_create_jobs_table',1),(4,'2026_06_13_133312_create_genres_table',1),(5,'2026_06_13_133313_create_books_table',1),(6,'2026_06_13_133313_create_ratings_table',1),(7,'2026_06_13_133314_create_borrows_table',1),(8,'2026_06_13_133315_create_bookmarks_table',1),(9,'2026_06_13_133316_create_recommendations_table',1),(10,'2026_06_13_134310_create_permission_tables',1),(11,'2026_06_14_000000_create_personal_access_tokens_table',1),(12,'2026_06_14_051742_create_notifications_table',1),(13,'2026_06_14_094936_make_is_approved_nullable_on_ratings_table',2);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `model_has_permissions`
--

DROP TABLE IF EXISTS `model_has_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `model_has_permissions` (
  `permission_id` bigint unsigned NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `model_has_permissions`
--

LOCK TABLES `model_has_permissions` WRITE;
/*!40000 ALTER TABLE `model_has_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `model_has_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `model_has_roles`
--

DROP TABLE IF EXISTS `model_has_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `model_has_roles` (
  `role_id` bigint unsigned NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `model_has_roles`
--

LOCK TABLES `model_has_roles` WRITE;
/*!40000 ALTER TABLE `model_has_roles` DISABLE KEYS */;
INSERT INTO `model_has_roles` VALUES (1,'App\\Models\\User',1),(2,'App\\Models\\User',2),(2,'App\\Models\\User',3),(3,'App\\Models\\User',4),(3,'App\\Models\\User',5),(3,'App\\Models\\User',6),(3,'App\\Models\\User',7),(3,'App\\Models\\User',8),(3,'App\\Models\\User',9),(3,'App\\Models\\User',10),(3,'App\\Models\\User',11),(3,'App\\Models\\User',12),(3,'App\\Models\\User',13),(3,'App\\Models\\User',14),(3,'App\\Models\\User',15),(3,'App\\Models\\User',16),(3,'App\\Models\\User',17),(3,'App\\Models\\User',18),(3,'App\\Models\\User',19),(3,'App\\Models\\User',20),(3,'App\\Models\\User',21),(3,'App\\Models\\User',22),(3,'App\\Models\\User',23),(3,'App\\Models\\User',25);
/*!40000 ALTER TABLE `model_has_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_id` bigint unsigned NOT NULL,
  `data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permissions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` VALUES (1,'manage-books','web','2026-06-14 03:57:42','2026-06-14 03:57:42'),(2,'manage-borrows','web','2026-06-14 03:57:42','2026-06-14 03:57:42'),(3,'approve-ratings','web','2026-06-14 03:57:42','2026-06-14 03:57:42'),(4,'rate-books','web','2026-06-14 03:57:42','2026-06-14 03:57:42'),(5,'borrow-books','web','2026-06-14 03:57:42','2026-06-14 03:57:42'),(6,'manage-own-ratings','web','2026-06-14 03:57:42','2026-06-14 03:57:42');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  KEY `personal_access_tokens_expires_at_index` (`expires_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ratings`
--

DROP TABLE IF EXISTS `ratings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ratings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `book_id` bigint unsigned NOT NULL,
  `rating` tinyint NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci,
  `is_approved` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ratings_user_id_book_id_unique` (`user_id`,`book_id`),
  KEY `ratings_book_id_foreign` (`book_id`),
  CONSTRAINT `ratings_book_id_foreign` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ratings_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=302 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ratings`
--

LOCK TABLES `ratings` WRITE;
/*!40000 ALTER TABLE `ratings` DISABLE KEYS */;
INSERT INTO `ratings` VALUES (1,16,90,3,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(2,19,87,3,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(3,1,58,4,'Beatae sed consequatur ut quia corporis consequatur doloribus nesciunt.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(4,21,2,5,'Voluptas natus aliquam voluptates quis.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(5,5,89,1,'Porro delectus atque hic saepe.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(6,5,5,3,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(7,7,64,1,'Dolorem aperiam vitae doloribus aspernatur unde.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(8,13,34,3,'Veritatis nihil velit qui odit sed.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(9,12,62,1,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(10,2,7,1,'Laborum unde quos est est.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(11,11,11,2,'Aperiam eaque sit sint consequatur dolores ea.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(12,17,32,1,'Harum iste eius adipisci voluptatem nesciunt.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(13,20,15,4,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(14,21,49,2,'Ut accusantium et molestiae.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(15,9,7,4,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(16,7,23,4,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(17,19,43,2,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(18,6,38,3,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(19,1,90,3,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(20,20,24,5,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(21,7,74,4,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(22,5,85,1,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(23,3,98,2,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(24,1,38,3,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(25,11,85,4,'Possimus voluptatem nam quia aut.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(26,1,50,1,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(27,2,82,2,'Ipsum qui dicta rerum quam est vel illo.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(28,11,4,5,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(29,18,35,3,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(30,14,53,3,'Dolores dolorem fugiat qui maiores.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(31,1,95,2,'Perspiciatis occaecati ab libero iusto reiciendis ab veniam.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(32,15,9,2,'Ipsa autem quibusdam veritatis minus libero amet id dolorem.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(33,19,3,1,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(34,21,68,4,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(35,21,70,1,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(36,14,63,3,'Deserunt corporis est ullam enim nihil deserunt dolorum.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(37,8,86,5,'Pariatur atque molestias asperiores.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(38,18,96,2,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(39,4,47,1,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(40,19,29,1,'Velit asperiores quas laudantium doloremque.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(41,19,79,3,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(42,17,87,4,'Enim accusamus quibusdam et assumenda.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(43,2,44,5,'Officia nam et maxime veritatis ratione inventore.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(44,2,27,5,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(45,2,6,1,'Eligendi id deleniti fugiat reiciendis quia molestias voluptatem.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(46,7,85,1,'Tenetur hic sapiente possimus qui.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(47,4,64,5,'Veritatis ex enim aliquid dolor ducimus illum voluptate.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(48,10,60,4,'Dignissimos et ratione tempore nulla labore non aspernatur.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(49,5,34,1,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(50,19,36,2,'Necessitatibus iste voluptatibus mollitia aut consequatur ea tempore.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(51,23,55,2,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(52,11,67,5,'Fugit vel dolorem non dolore itaque et.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(53,21,36,4,'Non eos et repudiandae nesciunt rerum laboriosam quis.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(54,5,11,2,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(55,12,79,4,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(56,17,12,4,'Consequatur hic ipsa libero.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(57,20,6,4,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(58,5,31,3,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(59,19,71,3,'Omnis tempore in aut hic.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(60,4,80,3,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(61,20,59,5,'Et ex ratione maxime amet.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(62,7,87,3,'Quo distinctio a voluptates placeat voluptatem.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(63,12,6,1,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(64,20,43,2,'Quas velit eveniet dignissimos cupiditate.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(65,22,26,3,'Quo ut itaque dolorem doloribus.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(66,7,25,4,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(67,12,73,1,'Est vel nisi rerum quia non laboriosam in.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(68,13,68,5,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(69,22,6,4,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(70,23,64,5,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(71,20,98,1,'Sed nesciunt vel sunt.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(72,3,16,3,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(73,3,90,1,'Nisi vitae perferendis dolor sit voluptas.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(74,6,51,2,'Voluptas ipsa commodi id veniam nulla.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(75,4,26,5,'Perferendis quidem tenetur voluptas libero illum et.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(76,22,62,5,'Officia consectetur quaerat odio ea qui ea.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(77,20,34,2,'Expedita occaecati necessitatibus et ipsa ut.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(78,2,30,2,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(79,16,29,3,'Voluptates ea dolores quis corporis.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(80,6,14,3,'Quam at enim molestiae iusto saepe.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(81,12,42,1,'Ut sit omnis eum harum.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(82,11,100,5,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(83,7,63,2,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(84,6,67,5,'Est ut temporibus quidem est.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(85,5,46,4,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(86,13,45,1,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(87,18,80,1,'Esse quisquam maxime iure soluta et aperiam perferendis.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(88,3,29,2,'Reprehenderit expedita enim molestiae architecto.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(89,15,47,2,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(90,13,38,5,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(91,15,34,3,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(92,23,81,5,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(93,2,63,3,'Cumque autem beatae nemo sint omnis pariatur.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(94,12,53,5,'Rerum in ut veniam porro omnis nam ipsam molestias.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(95,9,24,5,'Pariatur rem aspernatur veniam perspiciatis atque.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(96,10,34,4,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(97,16,52,3,'Quia tempore soluta ab impedit quia quidem et.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(98,16,44,3,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(99,18,11,5,'Doloribus inventore ut consequatur.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(100,15,87,2,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(101,23,35,5,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(102,1,47,5,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(103,21,24,3,'Consequatur voluptatum ad nihil quae voluptatibus minus.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(104,19,18,3,'Voluptatem omnis et earum possimus aliquid et vero.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(105,22,63,4,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(106,16,80,1,'Dolorum labore facilis unde et laudantium eum.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(107,16,43,1,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(108,20,4,1,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(109,18,84,4,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(110,16,64,4,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(111,2,11,1,'Voluptatem maiores enim necessitatibus omnis earum quia.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(112,12,98,2,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(113,4,19,2,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(114,4,3,3,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(115,21,59,1,'Aliquam et nemo nisi eum ut.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(116,22,97,3,'Doloribus aut aut amet voluptatibus enim.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(117,21,77,1,'Accusantium earum iure ad esse voluptas impedit rem.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(118,13,24,5,'Saepe dolores est et molestiae.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(119,17,53,2,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(120,2,14,2,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(121,8,94,3,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(122,22,90,2,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(123,19,61,3,'Eius voluptatem velit voluptas ex cum consequatur.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(124,9,23,2,'Nam aut ratione aut sunt eveniet animi.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(125,21,85,2,'Rem sequi quas beatae labore vel est repellat.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(126,18,52,4,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(127,14,45,3,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(128,12,33,4,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(129,8,99,1,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(130,20,65,1,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(131,12,90,4,'Fuga asperiores officiis quia non voluptatem qui voluptas ea.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(132,11,74,1,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(133,23,96,3,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(134,17,51,1,'Veritatis exercitationem ut eos placeat iusto.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(135,10,28,3,'Nam fuga harum dolor iure et labore ipsum qui.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(136,5,65,5,'Enim eos similique aut nihil.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(137,22,47,5,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(138,21,64,3,'Occaecati cum deleniti consequatur est.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(139,18,34,2,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(140,7,78,5,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(141,7,24,2,'At excepturi minus dolores.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(142,4,83,4,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(143,14,100,3,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(144,5,8,1,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(145,9,99,5,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(146,16,77,2,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(147,21,83,2,'Autem vitae consequuntur et nostrum possimus qui nihil.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(148,22,67,2,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(149,13,49,5,'Distinctio quasi est quisquam recusandae accusamus voluptas.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(150,21,95,5,'Minima consectetur voluptatibus enim expedita et.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(151,17,49,1,'Sequi rerum temporibus eligendi dolores sed nam iure.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(152,20,26,3,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(153,8,31,1,'Quia architecto sint aspernatur.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(154,3,55,4,'Sunt et aliquam minima culpa praesentium fugiat ut sed.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(155,1,24,1,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(156,15,20,1,'Ab dolorem doloremque velit voluptas.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(157,17,17,2,'Magnam commodi veritatis rem in in.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(158,7,77,2,'Laboriosam est harum dicta possimus veritatis beatae.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(159,13,63,1,'Necessitatibus non rem nihil repellat.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(160,15,36,4,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(161,7,79,1,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(162,6,31,4,'Nisi qui ullam quaerat ut error nesciunt animi.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(163,23,6,5,'Voluptatem praesentium nemo qui suscipit qui.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(164,3,3,5,'Adipisci nostrum quod similique officiis recusandae magnam qui.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(165,16,13,4,'Asperiores iure voluptatem rerum quia qui aut explicabo repudiandae.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(166,6,92,1,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(167,22,89,2,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(168,1,54,5,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(169,4,56,2,'Iste error vero necessitatibus.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(170,16,92,2,'Molestiae necessitatibus rem doloremque ex pariatur quisquam.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(171,8,87,5,'Magnam dolores consequatur sint tempora.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(172,23,29,1,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(173,5,70,2,'Dolorem est ipsam cumque perspiciatis quisquam quis minus.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(174,9,78,4,'Quia dignissimos in velit at.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(175,9,85,5,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(176,19,52,1,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(177,18,3,1,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(178,8,57,2,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(179,14,93,2,'Fugit harum veritatis eos consequatur provident molestiae.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(180,4,81,2,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(181,22,20,4,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(182,15,79,3,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(183,4,97,4,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(184,2,43,5,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(185,22,59,3,'Sunt officiis et aut eos quos vel eos.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(186,8,43,1,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(187,13,56,4,'Voluptatem voluptas labore ducimus vero sit occaecati omnis tempora.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(188,14,47,4,'Ullam quidem tempore reiciendis dolor.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(189,1,72,2,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(190,18,98,3,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(191,8,68,1,'Esse omnis sit facere vitae.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(192,21,28,1,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(193,15,35,1,'Totam ut esse maiores ipsum.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(194,18,56,4,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(195,22,73,5,'Facilis aut nihil voluptate odit dolorem.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(196,5,13,2,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(197,3,40,4,'Doloribus officiis doloremque cum odit eos iusto vero.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(198,8,39,2,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(199,2,69,2,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(200,12,76,5,'Soluta fugit recusandae dicta eveniet quisquam eaque.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(201,12,77,3,'Non facere deserunt est magni fuga.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(202,18,42,1,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(203,4,5,5,'Quae facere voluptas tempora velit fugiat accusantium quibusdam.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(204,13,22,3,'Aliquid nobis libero repellendus consequuntur non inventore.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(205,13,65,4,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(206,11,48,5,'Qui sit autem nemo assumenda ea.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(207,18,67,3,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(208,17,66,1,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(209,9,47,2,'Rerum sunt sed tenetur voluptas recusandae magnam.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(210,8,72,2,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(211,23,25,4,'In quisquam dignissimos beatae facilis.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(212,7,70,4,'Qui voluptas voluptatibus facere eligendi provident aut.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(213,14,73,3,'Molestiae facere libero numquam non sed consequatur.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(214,21,73,5,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(215,7,15,3,'Nemo nulla sit error tempore.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(216,10,17,3,'Tempora ipsam ut dolorum ut optio id odit.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(217,7,75,2,'Magnam quia vitae voluptatem fuga laborum voluptas.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(218,22,57,3,'Et delectus accusantium aliquid voluptas ut ut consequatur.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(219,10,65,4,'Voluptas modi ullam ex.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(220,1,27,1,'Qui saepe sit illo aperiam sed quod sit et.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(221,1,63,5,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(222,3,45,4,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(223,3,25,5,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(224,22,58,5,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(225,19,26,5,'Dolores et doloremque quo explicabo voluptatem beatae.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(226,19,12,2,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(227,18,44,5,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(228,15,31,4,'Rerum doloremque atque quia ab fuga rem eum.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(229,23,38,2,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(230,10,11,3,'Doloremque est esse quos eos aut laborum.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(231,22,91,3,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(232,14,75,1,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(233,5,63,5,'Alias a delectus harum eius vel quia.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(234,10,87,3,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(235,21,32,5,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(236,2,8,4,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(237,11,16,5,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(238,14,22,3,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(239,2,41,5,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(240,22,78,4,'Similique est nam est sunt ipsum et suscipit animi.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(241,11,88,5,'Eaque iusto aut provident animi rerum autem saepe.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(242,5,41,2,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(243,18,54,5,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(244,8,3,5,'Ea dicta amet et voluptas dicta eos veritatis.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(245,23,75,3,'Aut facilis eos et beatae rerum sed.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(246,12,92,2,'Corrupti in aut rem non.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(247,17,55,2,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(248,9,41,5,'Consequuntur ut voluptatem quis reiciendis dolor voluptas recusandae.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(249,22,14,4,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(250,9,91,3,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(251,18,43,1,'At vel nulla aut vel natus perspiciatis qui aut.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(252,16,73,4,'Reiciendis consectetur quia consectetur error maiores beatae totam.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(253,9,16,2,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(254,11,79,4,'Optio unde et et dolores consequatur cum incidunt.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(255,14,38,4,'Culpa quia illo molestiae voluptates alias et.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(256,7,12,2,'Iusto et ea facilis soluta mollitia.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(257,12,60,5,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(258,15,96,5,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(259,7,86,1,'Et velit quidem illum ut sapiente qui consequatur.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(260,14,78,2,'Reiciendis doloribus dolor ea voluptate voluptates voluptates cum esse.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(261,16,100,2,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(262,10,62,4,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(263,12,32,3,'Est consequatur velit sit provident iusto omnis.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(264,23,99,5,'Aperiam maxime dolor veritatis qui.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(265,19,98,4,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(266,8,75,3,'Qui veritatis quam et nobis cum delectus.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(267,22,7,2,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(268,1,30,4,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(269,5,92,2,'Eius consequatur qui aut reprehenderit eos error atque.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(270,2,51,3,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(271,23,71,2,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(272,1,83,2,'Sequi sit odio omnis qui non delectus.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(273,23,23,2,'Repudiandae voluptatem quasi harum alias voluptas.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(274,8,46,3,'Aliquid et aut animi voluptate fuga.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(275,20,8,1,'Totam eum beatae sapiente qui minima in cum.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(276,4,55,3,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(277,3,99,1,'Corrupti iure sed saepe officia recusandae.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(278,20,19,1,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(279,1,75,2,'Temporibus animi nulla laboriosam minus ut mollitia.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(280,4,63,4,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(281,1,74,5,'Aut consequatur labore dolores.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(282,18,32,1,'Quo minima eum praesentium.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(283,8,21,5,'Mollitia excepturi quia unde eius quos.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(284,18,19,2,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(285,1,85,3,'Eveniet qui quae pariatur ex.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(286,10,86,3,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(287,14,10,3,'Nisi rerum repudiandae nihil saepe eos incidunt.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(288,8,28,2,'Fugiat est sit consequatur omnis in quis aut.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(289,9,69,5,'Nam dolores odit dicta perferendis voluptatum praesentium dicta.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(290,13,94,2,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(291,18,76,5,'Eos sequi voluptatem soluta nobis quisquam et eaque ullam.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(292,18,20,3,'Sed ducimus sunt ut accusantium.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(293,11,37,1,'Porro aliquid deleniti voluptas ullam fugit ut rem.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(295,19,27,5,NULL,1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(296,12,66,1,'Exercitationem voluptatum voluptas ex quis.',1,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(297,22,55,2,NULL,0,'2026-06-14 03:57:48','2026-06-14 04:54:05'),(301,24,101,4,'test revieww',1,'2026-06-14 05:07:33','2026-06-14 05:07:50');
/*!40000 ALTER TABLE `ratings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recommendations`
--

DROP TABLE IF EXISTS `recommendations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recommendations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `book_id` bigint unsigned NOT NULL,
  `score` double NOT NULL,
  `reason_type` enum('collaborative','genre_based','trending') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `recommendations_user_id_foreign` (`user_id`),
  KEY `recommendations_book_id_foreign` (`book_id`),
  CONSTRAINT `recommendations_book_id_foreign` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`) ON DELETE CASCADE,
  CONSTRAINT `recommendations_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recommendations`
--

LOCK TABLES `recommendations` WRITE;
/*!40000 ALTER TABLE `recommendations` DISABLE KEYS */;
/*!40000 ALTER TABLE `recommendations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_has_permissions`
--

DROP TABLE IF EXISTS `role_has_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_has_permissions` (
  `permission_id` bigint unsigned NOT NULL,
  `role_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `role_has_permissions_role_id_foreign` (`role_id`),
  CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_has_permissions`
--

LOCK TABLES `role_has_permissions` WRITE;
/*!40000 ALTER TABLE `role_has_permissions` DISABLE KEYS */;
INSERT INTO `role_has_permissions` VALUES (1,1),(2,1),(3,1),(4,1),(5,1),(6,1),(1,2),(2,2),(3,2),(4,3),(5,3),(6,3),(4,4),(5,4),(6,4);
/*!40000 ALTER TABLE `role_has_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'admin','web','2026-06-14 03:57:42','2026-06-14 03:57:42'),(2,'librarian','web','2026-06-14 03:57:42','2026-06-14 03:57:42'),(3,'student','web','2026-06-14 03:57:42','2026-06-14 03:57:42'),(4,'faculty','web','2026-06-14 03:57:42','2026-06-14 03:57:42');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES ('7hX4gHfTrU4Gy6LnbXZyJVMga6YMYCCdZtj94GeH',1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','eyJfdG9rZW4iOiJxRlJGbWxXbE14NEVUcnA4RHRSdDF3eVV0SnR6SldINDVVeXQ1elltIiwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119LCJfcHJldmlvdXMiOnsidXJsIjoiaHR0cDpcL1wvYm9va21hdGNoLnRlc3RcL2FkbWluXC9yYXRpbmdzIiwicm91dGUiOiJmaWxhbWVudC5hZG1pbi5yZXNvdXJjZXMucmF0aW5ncy5pbmRleCJ9LCJ1cmwiOltdLCJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI6MSwicGFzc3dvcmRfaGFzaF93ZWIiOiJhZTljOWM5NjhmOWQ5NTBlOWZlY2IzMTZlNjgwODEzNjM1NzIwYzVkMDI0YjBmMDAzMWNlZDM0OWY5OWYyZjRjIiwidGFibGVzIjp7IjBmMGE3MDQyODA3M2ZmMjQ5OWVhYjM1YWVhODQ5ZDg4X2NvbHVtbnMiOlt7InR5cGUiOiJjb2x1bW4iLCJuYW1lIjoibmFtZSIsImxhYmVsIjoiTmFtZSIsImlzSGlkZGVuIjpmYWxzZSwiaXNUb2dnbGVkIjp0cnVlLCJpc1RvZ2dsZWFibGUiOmZhbHNlLCJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiOm51bGx9LHsidHlwZSI6ImNvbHVtbiIsIm5hbWUiOiJlbWFpbCIsImxhYmVsIjoiRW1haWwiLCJpc0hpZGRlbiI6ZmFsc2UsImlzVG9nZ2xlZCI6dHJ1ZSwiaXNUb2dnbGVhYmxlIjpmYWxzZSwiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjpudWxsfSx7InR5cGUiOiJjb2x1bW4iLCJuYW1lIjoicm9sZSIsImxhYmVsIjoiUm9sZSIsImlzSGlkZGVuIjpmYWxzZSwiaXNUb2dnbGVkIjp0cnVlLCJpc1RvZ2dsZWFibGUiOmZhbHNlLCJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiOm51bGx9LHsidHlwZSI6ImNvbHVtbiIsIm5hbWUiOiJyYXRpbmdzX2NvdW50IiwibGFiZWwiOiJSYXRpbmdzIGNvdW50IiwiaXNIaWRkZW4iOmZhbHNlLCJpc1RvZ2dsZWQiOnRydWUsImlzVG9nZ2xlYWJsZSI6dHJ1ZSwiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjpmYWxzZX0seyJ0eXBlIjoiY29sdW1uIiwibmFtZSI6ImJvcnJvd3NfY291bnQiLCJsYWJlbCI6IkJvcnJvd3MgY291bnQiLCJpc0hpZGRlbiI6ZmFsc2UsImlzVG9nZ2xlZCI6dHJ1ZSwiaXNUb2dnbGVhYmxlIjp0cnVlLCJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiOmZhbHNlfSx7InR5cGUiOiJjb2x1bW4iLCJuYW1lIjoiY3JlYXRlZF9hdCIsImxhYmVsIjoiQ3JlYXRlZCBhdCIsImlzSGlkZGVuIjpmYWxzZSwiaXNUb2dnbGVkIjpmYWxzZSwiaXNUb2dnbGVhYmxlIjp0cnVlLCJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiOnRydWV9XSwiMjNmNmM1ZmZkNzI2MzRiYTAyNmJiY2Q3Yjk1ZmMzMjFfY29sdW1ucyI6W3sidHlwZSI6ImNvbHVtbiIsIm5hbWUiOiJ1c2VyLm5hbWUiLCJsYWJlbCI6IlVzZXIiLCJpc0hpZGRlbiI6ZmFsc2UsImlzVG9nZ2xlZCI6dHJ1ZSwiaXNUb2dnbGVhYmxlIjpmYWxzZSwiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjpudWxsfSx7InR5cGUiOiJjb2x1bW4iLCJuYW1lIjoiYm9vay50aXRsZSIsImxhYmVsIjoiQm9vayIsImlzSGlkZGVuIjpmYWxzZSwiaXNUb2dnbGVkIjp0cnVlLCJpc1RvZ2dsZWFibGUiOmZhbHNlLCJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiOm51bGx9LHsidHlwZSI6ImNvbHVtbiIsIm5hbWUiOiJyYXRpbmciLCJsYWJlbCI6IlJhdGluZyIsImlzSGlkZGVuIjpmYWxzZSwiaXNUb2dnbGVkIjp0cnVlLCJpc1RvZ2dsZWFibGUiOmZhbHNlLCJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiOm51bGx9LHsidHlwZSI6ImNvbHVtbiIsIm5hbWUiOiJpc19hcHByb3ZlZCIsImxhYmVsIjoiU3RhdHVzIiwiaXNIaWRkZW4iOmZhbHNlLCJpc1RvZ2dsZWQiOnRydWUsImlzVG9nZ2xlYWJsZSI6ZmFsc2UsImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI6bnVsbH0seyJ0eXBlIjoiY29sdW1uIiwibmFtZSI6ImNyZWF0ZWRfYXQiLCJsYWJlbCI6IkNyZWF0ZWQgYXQiLCJpc0hpZGRlbiI6ZmFsc2UsImlzVG9nZ2xlZCI6ZmFsc2UsImlzVG9nZ2xlYWJsZSI6dHJ1ZSwiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0Ijp0cnVlfV19LCJmaWxhbWVudCI6W119',1781433615),('8WeUI2wWAb0LT6i0wwIV4G1vttDWChJFDbw6qprh',25,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36 Edg/149.0.0.0','eyJfdG9rZW4iOiJLaGhvS3BqOTRTbkdUZmpoaEFyUkpJNHZjWEEzSXlvcHQ1VG9pWDdtIiwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119LCJfcHJldmlvdXMiOnsidXJsIjoiaHR0cDpcL1wvYm9va21hdGNoLnRlc3RcL3NlYXJjaCIsInJvdXRlIjoic2VhcmNoIn0sImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjoyNX0=',1781434091);
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` enum('admin','librarian','student','faculty') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'student',
  `student_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `department` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Admin User','admin@library.edu',NULL,'$2y$12$0hSxs5Lhs1K4213jg/pguOKUfUhW1fuHUii82na6g4OXT24NDfNpO','admin',NULL,NULL,NULL,NULL,'2026-06-14 03:57:42','2026-06-14 03:57:42'),(2,'Ashlynn Greenfelder','librarian1@library.edu',NULL,'$2y$12$I4kj27Z04QGoXGGsUNkIku6BeOmekMNAedI5rufv4JH9yIwAuQUhy','librarian',NULL,NULL,NULL,NULL,'2026-06-14 03:57:43','2026-06-14 03:57:43'),(3,'Hilda Keebler IV','librarian2@library.edu',NULL,'$2y$12$TOBvzPDadQAcMM2twNL/J.XFiSazkdMOsMx3t6FY2D1oArlcgP82a','librarian',NULL,NULL,NULL,NULL,'2026-06-14 03:57:43','2026-06-14 03:57:43'),(4,'Unique Jacobson','student1@library.edu',NULL,'$2y$12$JHOP4qFGnEPWynNFruLoruQTfobtfCSo5sT71TRKufBE.dJ9d8tFe','student','STU-8921','Engineering',NULL,NULL,'2026-06-14 03:57:43','2026-06-14 03:57:43'),(5,'Demarcus Funk','student2@library.edu',NULL,'$2y$12$ON1HRB4ViTxJC29Rs8knw.2RhWbCpjvcfrOZJzZlSIWpCAnUaM/sK','student','STU-4969','Physics',NULL,NULL,'2026-06-14 03:57:43','2026-06-14 03:57:43'),(6,'Mr. Pierce Stanton','student3@library.edu',NULL,'$2y$12$.892TvsmTjDz0K8fpXusdOC1DReG1wdqTaZayYom.b4DggDjHpe3u','student','STU-3194','CS',NULL,NULL,'2026-06-14 03:57:44','2026-06-14 03:57:44'),(7,'Gabe Feil','student4@library.edu',NULL,'$2y$12$k6gtjk5GOUmVmRhVhDTZzODuM68GSYRUJ4.G6MTd0dd97uXbqZjzm','student','STU-2762','Biology',NULL,NULL,'2026-06-14 03:57:44','2026-06-14 03:57:44'),(8,'Prof. Olaf Brown','student5@library.edu',NULL,'$2y$12$at6.mtd9RNFyK.YDcMIG8.8Qvtz6VXXpYoKG/aOdbf3ypdFXxMz0e','student','STU-3798','CS',NULL,NULL,'2026-06-14 03:57:44','2026-06-14 03:57:44'),(9,'Rahsaan Aufderhar','student6@library.edu',NULL,'$2y$12$M4yu6iHV.6ClvqG5cnFYR.IiySz/5OoS6cfVK0qH6FwJT.guimadS','student','STU-5385','Physics',NULL,NULL,'2026-06-14 03:57:44','2026-06-14 03:57:44'),(10,'Kayleigh Lynch','student7@library.edu',NULL,'$2y$12$j1vABoVM6qJGMbPAhGhbhugOHPAb7M/CYZdN98fBBrNWKFSZV7TYi','student','STU-8203','Biology',NULL,NULL,'2026-06-14 03:57:45','2026-06-14 03:57:45'),(11,'Kiarra Bogan','student8@library.edu',NULL,'$2y$12$Js3v4LNHtbK8K3cZ8o9m5O.Y.UOQvU84lp1eUJ1rFvjB.w719VpvS','student','STU-4933','Biology',NULL,NULL,'2026-06-14 03:57:45','2026-06-14 03:57:45'),(12,'Mr. Lew Bailey','student9@library.edu',NULL,'$2y$12$NXlYKAy1nckdRLJSEDmTZeXjOJA9TpCLv8sDukK//a93k7iM9qrDW','student','STU-6762','Engineering',NULL,NULL,'2026-06-14 03:57:45','2026-06-14 03:57:45'),(13,'Dr. Jevon Goldner DVM','student10@library.edu',NULL,'$2y$12$FLwDaflxyI.jkVL8Qoex4eeEygKL.bU4amSvTJ4Z/Yqi6quAGcKgO','student','STU-3902','Biology',NULL,NULL,'2026-06-14 03:57:45','2026-06-14 03:57:45'),(14,'Blaze Keebler','student11@library.edu',NULL,'$2y$12$PlfMCuAuK05RrCPGRCu4T.GLa6t0BXCeRoqr9iBhh3Rd6oQoFmrsa','student','STU-7529','Physics',NULL,NULL,'2026-06-14 03:57:46','2026-06-14 03:57:46'),(15,'Miss Helen Osinski I','student12@library.edu',NULL,'$2y$12$3j8QdwIKPoRn9eEMxNiI8.Ltznd5Q5sNnCq8wIblOinrSzocwdoyW','student','STU-8377','CS',NULL,NULL,'2026-06-14 03:57:46','2026-06-14 03:57:46'),(16,'Laurence Cole','student13@library.edu',NULL,'$2y$12$ax5YGzFJImRYJmvsY5/FDer40/eP1LO/SbYIlh8AI8Z3kI5p6B/q.','student','STU-1109','CS',NULL,NULL,'2026-06-14 03:57:46','2026-06-14 03:57:46'),(17,'Jimmy Labadie Sr.','student14@library.edu',NULL,'$2y$12$fjlIgc3CYlznr3EN.FNBg.CogRPkBvQQyRr6bmJFvU/JpmlvfWVBe','student','STU-4288','Biology',NULL,NULL,'2026-06-14 03:57:46','2026-06-14 03:57:46'),(18,'Sheldon Lehner','student15@library.edu',NULL,'$2y$12$NBCCWKiBj356WZiFJ.9eueOmdRl1OlYxGKFvAGdcKstNNShYbncHy','student','STU-1788','Biology',NULL,NULL,'2026-06-14 03:57:47','2026-06-14 03:57:47'),(19,'Madelyn Sipes','student16@library.edu',NULL,'$2y$12$loAWEBHygXPV2BxpCrk97.53R0to1P6q1aVFcPSMXZQ1QMfnSYyK.','student','STU-6250','Math',NULL,NULL,'2026-06-14 03:57:47','2026-06-14 03:57:47'),(20,'Zaria Kreiger','student17@library.edu',NULL,'$2y$12$E773bAIjoQe6CelQH25F6uUsMU8/pK2aG.espQus4/QkgDNsP6RKC','student','STU-5536','Biology',NULL,NULL,'2026-06-14 03:57:47','2026-06-14 03:57:47'),(21,'Cory Johnston Jr.','student18@library.edu',NULL,'$2y$12$oEW4YM1Y.H.Ij0EZl9bfCujreSzVy34rlewGB2Dl1zeNtVqsER4RG','student','STU-2316','CS',NULL,NULL,'2026-06-14 03:57:47','2026-06-14 03:57:47'),(22,'Ophelia Grimes','student19@library.edu',NULL,'$2y$12$FMY/UvUw/AmznTEGMXPBEeCYDEn.JdprF6k2rFU.jKYE55fymo4/.','student','STU-5281','Engineering',NULL,NULL,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(23,'Maximillia Williamson','student20@library.edu',NULL,'$2y$12$jAvuAs69XW55zKKLXRgXHOIKrbGhPQNWDbFETFp/MdEwIuvade1vS','student','STU-7897','Physics',NULL,NULL,'2026-06-14 03:57:48','2026-06-14 03:57:48'),(24,'test','test@gmail.com',NULL,'$2y$12$dLlE9g8b/WxfWWA4Zu0dxu5yMoOoAXklPSsv/F5nN08WZeApBlmy6','student',NULL,NULL,NULL,NULL,'2026-06-14 05:02:45','2026-06-14 05:03:42'),(25,'test2','test2@gmail.com',NULL,'$2y$12$F8XSnc39RKyxZcxQBSNrEuOEV8jRVReTRsMvWUIshUwDxvZAojnc.','student','123321',NULL,NULL,NULL,'2026-06-14 05:15:26','2026-06-14 05:15:26');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-14 15:54:11
