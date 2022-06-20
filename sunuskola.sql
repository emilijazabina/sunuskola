-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jun 19, 2022 at 11:28 PM
-- Server version: 5.7.31
-- PHP Version: 7.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sunuskola`
--

-- --------------------------------------------------------

--
-- Table structure for table `grupa`
--

DROP TABLE IF EXISTS `grupa`;
CREATE TABLE IF NOT EXISTS `grupa` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vecuma_grupa` varchar(40) NOT NULL,
  `max_dal_sk` int(2) NOT NULL,
  `apraksts` text NOT NULL,
  `vaditaja_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_vaditajs` (`vaditaja_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `nodarbiba`
--

DROP TABLE IF EXISTS `nodarbiba`;
CREATE TABLE IF NOT EXISTS `nodarbiba` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cena` varchar(10) NOT NULL,
  `apraksts` text NOT NULL,
  `grupas_id` int(11) NOT NULL,
  `datums` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_grupa` (`grupas_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `nodarbiba`
--

INSERT INTO `nodarbiba` (`id`, `cena`, `apraksts`, `grupas_id`, `datums`) VALUES
(1, '5.00', 'sedet, blakus', 1, '2022-06-21');

-- --------------------------------------------------------

--
-- Table structure for table `pieslegties`
--

DROP TABLE IF EXISTS `pieslegties`;
CREATE TABLE IF NOT EXISTS `pieslegties` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lietotajvards` varchar(50) NOT NULL,
  `parole` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pieslegties`
--

INSERT INTO `pieslegties` (`id`, `lietotajvards`, `parole`) VALUES
(1, 'tests', 'tests');

-- --------------------------------------------------------

--
-- Table structure for table `pieteikums`
--

DROP TABLE IF EXISTS `pieteikums`;
CREATE TABLE IF NOT EXISTS `pieteikums` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pieteikuma_datums` timestamp NOT NULL,
  `komentars` text,
  `saimnieka_id` int(11) NOT NULL,
  `nodarbibas_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_nodarbiba` (`nodarbibas_id`),
  KEY `fk_saimnieks` (`saimnieka_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pieteikums`
--

INSERT INTO `pieteikums` (`id`, `pieteikuma_datums`, `komentars`, `saimnieka_id`, `nodarbibas_id`) VALUES
(1, '2022-06-19 23:10:11', 'pirma reize', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `pilseta`
--

DROP TABLE IF EXISTS `pilseta`;
CREATE TABLE IF NOT EXISTS `pilseta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nosaukums` varchar(60) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `saimnieks`
--

DROP TABLE IF EXISTS `saimnieks`;
CREATE TABLE IF NOT EXISTS `saimnieks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `telefons` varchar(14) NOT NULL,
  `epasts` varchar(255) NOT NULL,
  `vards` varchar(50) NOT NULL,
  `uzvards` varchar(60) NOT NULL,
  `pieslegums_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_pieslegums` (`pieslegums_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `sunuskola`
--

DROP TABLE IF EXISTS `sunuskola`;
CREATE TABLE IF NOT EXISTS `sunuskola` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nosaukums` varchar(50) NOT NULL,
  `reg_nr` varchar(50) NOT NULL,
  `pilsetas_id` int(11) NOT NULL,
  `adrese` varchar(100) NOT NULL,
  `epasts` varchar(255) NOT NULL,
  `telefons` varchar(14) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_pilseta` (`pilsetas_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `vaditajs`
--

DROP TABLE IF EXISTS `vaditajs`;
CREATE TABLE IF NOT EXISTS `vaditajs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vards` varchar(50) NOT NULL,
  `uzvards` varchar(50) NOT NULL,
  `epasts` varchar(255) NOT NULL,
  `telefons` varchar(14) NOT NULL,
  `pieredze` text NOT NULL,
  `sunuSkolas_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_sunu_skola` (`sunuSkolas_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
