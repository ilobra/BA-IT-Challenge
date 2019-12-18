-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: 2019 m. Grd 16 d. 21:42
-- Server version: 10.4.8-MariaDB
-- PHP Version: 7.3.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `knygu_isdavimas`
--

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `darbuotojai`
--

CREATE TABLE `darbuotojai` (
  `id` int(11) NOT NULL,
  `vardas` varchar(30) NOT NULL,
  `pavarde` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Sukurta duomenų kopija lentelei `darbuotojai`
--

INSERT INTO `darbuotojai` (`id`, `vardas`, `pavarde`) VALUES
(1, 'Jonas', 'Jonaitis');

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `isdavimo_grazinimo_istorija`
--

CREATE TABLE `isdavimo_grazinimo_istorija` (
  `id` int(11) NOT NULL,
  `knygos_isbn` varchar(30) NOT NULL,
  `isdavimo_data` datetime NOT NULL,
  `grazinimo_data` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Sukurta duomenų kopija lentelei `isdavimo_grazinimo_istorija`
--

INSERT INTO `isdavimo_grazinimo_istorija` (`id`, `knygos_isbn`, `isdavimo_data`, `grazinimo_data`) VALUES
(3, 'ISBN 978-3-16-148410-0', '2019-12-02 00:00:00', '2019-12-10 00:00:00'),
(4, 'ISBN 978-3-16-148410-0', '2019-12-10 13:00:00', '2019-12-16 12:00:00');

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `isduotos_knygos`
--

CREATE TABLE `isduotos_knygos` (
  `id` int(11) NOT NULL,
  `knygos_isbn` varchar(30) NOT NULL,
  `skait_id` int(11) NOT NULL,
  `darb_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Sukurta duomenų kopija lentelei `isduotos_knygos`
--

INSERT INTO `isduotos_knygos` (`id`, `knygos_isbn`, `skait_id`, `darb_id`) VALUES
(1, 'ISBN 978-3-16-148410-0', 1, 1),
(2, 'ISBN 978-3-16-148410-0', 2, 1);

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `knygos`
--

CREATE TABLE `knygos` (
  `isbn` varchar(30) NOT NULL,
  `autorius` varchar(50) NOT NULL,
  `pavadinimas` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Sukurta duomenų kopija lentelei `knygos`
--

INSERT INTO `knygos` (`isbn`, `autorius`, `pavadinimas`) VALUES
('ISBN 978-3-16-148410-0', 'Petras Petraitis', 'Aukso gija');

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `negrazintu_istorija`
--

CREATE TABLE `negrazintu_istorija` (
  `id` int(11) NOT NULL,
  `knygos_isbn` varchar(30) NOT NULL,
  `kiek_veluoja` varchar(10) NOT NULL,
  `bauda` varchar(10) NOT NULL,
  `darb_id` int(11) NOT NULL,
  `velavimo_registravimas` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Sukurta duomenų kopija lentelei `negrazintu_istorija`
--

INSERT INTO `negrazintu_istorija` (`id`, `knygos_isbn`, `kiek_veluoja`, `bauda`, `darb_id`, `velavimo_registravimas`) VALUES
(1, 'ISBN 978-3-16-148410-0', '3d.', '30ct', 1, '2019-12-16 15:00:00');

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `skaitytojai`
--

CREATE TABLE `skaitytojai` (
  `id` int(11) NOT NULL,
  `vardas` varchar(30) NOT NULL,
  `pavarde` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Sukurta duomenų kopija lentelei `skaitytojai`
--

INSERT INTO `skaitytojai` (`id`, `vardas`, `pavarde`) VALUES
(1, 'Adomas', 'Adomaitis'),
(2, 'Lina', 'Linaitytė');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `darbuotojai`
--
ALTER TABLE `darbuotojai`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `isdavimo_grazinimo_istorija`
--
ALTER TABLE `isdavimo_grazinimo_istorija`
  ADD PRIMARY KEY (`id`),
  ADD KEY `knygos_isbn` (`knygos_isbn`);

--
-- Indexes for table `isduotos_knygos`
--
ALTER TABLE `isduotos_knygos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `darb_id` (`darb_id`),
  ADD KEY `knygos_isbn` (`knygos_isbn`),
  ADD KEY `skait_id` (`skait_id`);

--
-- Indexes for table `knygos`
--
ALTER TABLE `knygos`
  ADD PRIMARY KEY (`isbn`);

--
-- Indexes for table `negrazintu_istorija`
--
ALTER TABLE `negrazintu_istorija`
  ADD PRIMARY KEY (`id`),
  ADD KEY `knygos_isbn` (`knygos_isbn`),
  ADD KEY `darb_id` (`darb_id`);

--
-- Indexes for table `skaitytojai`
--
ALTER TABLE `skaitytojai`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `darbuotojai`
--
ALTER TABLE `darbuotojai`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `isdavimo_grazinimo_istorija`
--
ALTER TABLE `isdavimo_grazinimo_istorija`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `isduotos_knygos`
--
ALTER TABLE `isduotos_knygos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `negrazintu_istorija`
--
ALTER TABLE `negrazintu_istorija`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `skaitytojai`
--
ALTER TABLE `skaitytojai`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Apribojimai eksportuotom lentelėm
--

--
-- Apribojimai lentelei `isdavimo_grazinimo_istorija`
--
ALTER TABLE `isdavimo_grazinimo_istorija`
  ADD CONSTRAINT `isdavimo_grazinimo_istorija_ibfk_1` FOREIGN KEY (`knygos_isbn`) REFERENCES `knygos` (`isbn`);

--
-- Apribojimai lentelei `isduotos_knygos`
--
ALTER TABLE `isduotos_knygos`
  ADD CONSTRAINT `isduotos_knygos_ibfk_1` FOREIGN KEY (`darb_id`) REFERENCES `darbuotojai` (`id`),
  ADD CONSTRAINT `isduotos_knygos_ibfk_2` FOREIGN KEY (`knygos_isbn`) REFERENCES `knygos` (`isbn`),
  ADD CONSTRAINT `isduotos_knygos_ibfk_3` FOREIGN KEY (`skait_id`) REFERENCES `skaitytojai` (`id`);

--
-- Apribojimai lentelei `negrazintu_istorija`
--
ALTER TABLE `negrazintu_istorija`
  ADD CONSTRAINT `negrazintu_istorija_ibfk_1` FOREIGN KEY (`knygos_isbn`) REFERENCES `knygos` (`isbn`),
  ADD CONSTRAINT `negrazintu_istorija_ibfk_2` FOREIGN KEY (`darb_id`) REFERENCES `darbuotojai` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
