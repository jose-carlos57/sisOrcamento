CREATE DATABASE  IF NOT EXISTS `madcal_sistema` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `madcal_sistema`;
-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: localhost    Database: madcal_sistema
-- ------------------------------------------------------
-- Server version	8.0.39

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
-- Table structure for table `contas`
--

DROP TABLE IF EXISTS `contas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contas` (
  `id_conta` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(40) NOT NULL,
  `apelido` varchar(40) DEFAULT NULL,
  `telefone` varchar(40) NOT NULL,
  `tipo_conta` varchar(40) DEFAULT NULL,
  `tipo_pessoa` int DEFAULT NULL,
  `cd_status` int NOT NULL,
  PRIMARY KEY (`id_conta`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contas`
--

LOCK TABLES `contas` WRITE;
/*!40000 ALTER TABLE `contas` DISABLE KEYS */;
INSERT INTO `contas` VALUES (1,'carlos','die','(88) 99999-9999','Vendedor',0,1),(2,'ricardo','rick','(55) 55555-5555','Cliente',1,1);
/*!40000 ALTER TABLE `contas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `itens`
--

DROP TABLE IF EXISTS `itens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `itens` (
  `id_itens` int DEFAULT NULL,
  `id_Produtos` int NOT NULL,
  `id_orcamento` int NOT NULL,
  PRIMARY KEY (`id_Produtos`,`id_orcamento`),
  KEY `id_orcamento` (`id_orcamento`),
  CONSTRAINT `itens_ibfk_1` FOREIGN KEY (`id_Produtos`) REFERENCES `produtos` (`id_produtos`),
  CONSTRAINT `itens_ibfk_2` FOREIGN KEY (`id_orcamento`) REFERENCES `orcamento` (`id_orcamento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `itens`
--

LOCK TABLES `itens` WRITE;
/*!40000 ALTER TABLE `itens` DISABLE KEYS */;
INSERT INTO `itens` VALUES (NULL,1,11),(NULL,2,13),(NULL,2,14),(NULL,3,12),(NULL,3,15);
/*!40000 ALTER TABLE `itens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orcamento`
--

DROP TABLE IF EXISTS `orcamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orcamento` (
  `id_orcamento` int NOT NULL AUTO_INCREMENT,
  `nome_cliente` varchar(40) NOT NULL,
  `telefone_cliente` varchar(20) NOT NULL,
  `nome_vendedor` varchar(40) NOT NULL,
  `telefone_vendedor` varchar(40) NOT NULL,
  `forma_pagamento` varchar(40) NOT NULL,
  `tabela_de_preco` int DEFAULT NULL,
  `desconto` varchar(40) DEFAULT NULL,
  `id_produto` int DEFAULT NULL,
  PRIMARY KEY (`id_orcamento`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orcamento`
--

LOCK TABLES `orcamento` WRITE;
/*!40000 ALTER TABLE `orcamento` DISABLE KEYS */;
INSERT INTO `orcamento` VALUES (1,'teste','(44) 44444-4444','teste','(33) 33333-3333','',7,'32',2),(2,'carl0os','(88) 88888-8888','teste','(88) 88888-8888','',7,'32',1),(3,'carlos','(34) 33333-3333','amanda americanas','(66) 66666-6666','',8,'',3),(4,'carlos','(34) 33333-3333','amanda americanas','(66) 66666-6666','',8,'45',3),(5,'carlos','(34) 33333-3333','amanda americanas','(66) 66666-6666','',8,'45',3),(6,'bruno','(11) 11111-1111','marcos','(11) 11111-1111','',6,'',2),(7,'testando','(66) 66666-6666','testado','(66) 66666-6666','Cartão de credito',6,'',5),(8,'Froid','(33) 33333-3333','spiruos','(22) 22222-2222','Cartão de credito',7,'',1),(9,'Froid','(33) 33333-3333','spiruos','(22) 22222-2222','Á vista',7,'44',1),(10,'hyththt','(54) 54564-5645','teste','(44) 44444-4444','Á vista',6,'565',1),(11,'effwef','(33) 42354-5435','teste','(43) 34553-4543','Boleto',7,'',1),(12,'carla','(22) 22222-2222','Ph','(22) 22222-2222','Á vista',7,'23',3),(13,'dqw','(22) 22222-2222','Die','(22) 22222-2222','Boleto',6,'',2),(14,'dqw','(22) 22222-2222','Die','(22) 22222-2222','Boleto',6,'',2),(15,'effef','(22) 22222-2222','efweffwef','(33) 32323-2323','Boleto',7,'',3);
/*!40000 ALTER TABLE `orcamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `politica_de_precos`
--

DROP TABLE IF EXISTS `politica_de_precos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `politica_de_precos` (
  `id_Politica_precos` int NOT NULL AUTO_INCREMENT,
  `idTabela_de_precos` int DEFAULT NULL,
  `id_Produtos` int DEFAULT NULL,
  `Preco` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`id_Politica_precos`),
  KEY `idTabela_de_precos` (`idTabela_de_precos`),
  KEY `id_Produtos` (`id_Produtos`),
  CONSTRAINT `politica_de_precos_ibfk_1` FOREIGN KEY (`idTabela_de_precos`) REFERENCES `tabela_de_precos` (`idTabela_de_precos`),
  CONSTRAINT `politica_de_precos_ibfk_2` FOREIGN KEY (`id_Produtos`) REFERENCES `produtos` (`id_produtos`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `politica_de_precos`
--

LOCK TABLES `politica_de_precos` WRITE;
/*!40000 ALTER TABLE `politica_de_precos` DISABLE KEYS */;
/*!40000 ALTER TABLE `politica_de_precos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produtos`
--

DROP TABLE IF EXISTS `produtos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produtos` (
  `id_produtos` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(45) NOT NULL,
  `unidade_medida` float NOT NULL,
  `cd_status` int NOT NULL,
  PRIMARY KEY (`id_produtos`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produtos`
--

LOCK TABLES `produtos` WRITE;
/*!40000 ALTER TABLE `produtos` DISABLE KEYS */;
INSERT INTO `produtos` VALUES (1,'telha',5,1),(2,'telha',5,1),(3,'cimento',4,1),(4,'cimento-colaa',45,1),(5,'carroça',2,1),(6,'carroça',2,1),(7,'carroça',2,1),(8,'ceramica',4,1),(9,'telha',4.6,1),(10,'telha',4.6,1),(11,'telha',4.6,1),(12,'telha',4.6,1),(13,'telha',4.6,1),(14,'telha',4.6,1),(15,'telha',4.6,1),(16,'teste',3.4,1),(17,'teste',3.4,1),(18,'rferf',54,1),(19,'rferf',54,1),(20,'rferf',54,1),(21,'rferf',54,1),(22,'TESTE',3,1),(23,'lata de tinta',4.5,1),(24,'broca',3,1);
/*!40000 ALTER TABLE `produtos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tabela_de_precos`
--

DROP TABLE IF EXISTS `tabela_de_precos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tabela_de_precos` (
  `idTabela_de_precos` int NOT NULL AUTO_INCREMENT,
  `descricao_tabela_precos` varchar(45) NOT NULL,
  `cd_status` int NOT NULL,
  PRIMARY KEY (`idTabela_de_precos`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tabela_de_precos`
--

LOCK TABLES `tabela_de_precos` WRITE;
/*!40000 ALTER TABLE `tabela_de_precos` DISABLE KEYS */;
/*!40000 ALTER TABLE `tabela_de_precos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-04  9:24:29
