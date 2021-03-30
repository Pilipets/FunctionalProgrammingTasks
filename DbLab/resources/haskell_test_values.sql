USE haskell_test;

LOCK TABLES `authors` WRITE;
INSERT INTO `authors` VALUES (1,'Author1','author1@gmail.com','+380509293701'),(2,'Author2','author2@gmail.com','+380509293702'),(3,'Author3','author3@gmail.com','+380509293703'),(4,'Author4','author4@gmail.com','+380509293704'),(5,'Author5','author5@gmail.com','+380509293705');
UNLOCK TABLES;

LOCK TABLES `legals` WRITE;
INSERT INTO `legals` VALUES (1,'rule1','registration_info1','agreement1'),(2,'rule2','registration_info2','agreement2'),(3,'rule3','registration_info3','agreement3'),(4,'rule4','registration_info4','agreement4'),(5,'rule5','registration_info5','agreement5');
UNLOCK TABLES;

LOCK TABLES `services` WRITE;
INSERT INTO `services` VALUES (1,'service1','annotation1','version1',4,4747,1,1,1,1),(2,'service2','annotation2','v2.0',14,53,1,1,2,2),(3,'service3','annotation3','v3',243,46546,2,3,3,3),(4,'service4','annotation4','v4',243,45456,3,4,4,4),(5,'service5','annotation5','v5',24,363,3,5,5,5);
UNLOCK TABLES;

LOCK TABLES `stats` WRITE;
INSERT INTO `stats` VALUES (1,90,500),(2,85,457),(3,35,256),(4,89,747),(5,94,375);
UNLOCK TABLES;

LOCK TABLES `types` WRITE;
INSERT INTO `types` VALUES (1,'ForStudents'),(2,'Internal'),(3,'Open');
UNLOCK TABLES;