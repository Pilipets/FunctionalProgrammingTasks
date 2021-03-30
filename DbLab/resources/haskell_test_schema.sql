USE haskell_test;


DROP TABLE IF EXISTS `authors`;
CREATE TABLE `authors` (
  `idauthor` int NOT NULL AUTO_INCREMENT,
  `name` varchar(80) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`idauthor`),
  UNIQUE KEY `idauthor_UNIQUE` (`idauthor`)
) ENGINE=InnoDB AUTO_INCREMENT=373 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `legals`;
CREATE TABLE `legals` (
  `idlegals` int NOT NULL AUTO_INCREMENT,
  `rules` varchar(255) DEFAULT NULL,
  `registration_info` varchar(255) DEFAULT NULL,
  `agreement` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`idlegals`),
  UNIQUE KEY `idlegals_UNIQUE` (`idlegals`)
) ENGINE=InnoDB AUTO_INCREMENT=160 DEFAULT CHARSET=utf8;



DROP TABLE IF EXISTS `services`;
CREATE TABLE `services` (
  `idService` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `annotation` varchar(45) DEFAULT NULL,
  `version` varchar(45) DEFAULT NULL,
  `created` int DEFAULT NULL,
  `eol` int DEFAULT NULL,
  `typeid` int DEFAULT NULL,
  `authorid` int DEFAULT NULL,
  `legalsid` int DEFAULT NULL,
  `statsid` int DEFAULT NULL,
  PRIMARY KEY (`idService`),
  UNIQUE KEY `idService_UNIQUE` (`idService`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=162 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `stats`;
CREATE TABLE `stats` (
  `idstats` int NOT NULL AUTO_INCREMENT,
  `users_registered` int unsigned DEFAULT '0',
  `popularity` int DEFAULT '0',
  PRIMARY KEY (`idstats`),
  UNIQUE KEY `idstats_UNIQUE` (`idstats`)
) ENGINE=InnoDB AUTO_INCREMENT=190 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `types`;
CREATE TABLE `types` (
  `idtypes` int NOT NULL AUTO_INCREMENT,
  `typename` varchar(45) NOT NULL,
  PRIMARY KEY (`idtypes`),
  UNIQUE KEY `idtypes_UNIQUE` (`idtypes`),
  UNIQUE KEY `typename_UNIQUE` (`typename`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;