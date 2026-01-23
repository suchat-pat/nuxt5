-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: mysql
-- Generation Time: Jan 23, 2026 at 07:36 AM
-- Server version: 8.0.45
-- PHP Version: 8.3.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `nuxt5`
--

-- --------------------------------------------------------

--
-- Table structure for table `tb_commit`
--

CREATE TABLE `tb_commit` (
  `id_commit` int NOT NULL,
  `id_member` int NOT NULL,
  `id_eva` int NOT NULL,
  `status_commit` varchar(1) NOT NULL,
  `level_commit` varchar(100) NOT NULL,
  `detail_commit` text,
  `signature` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tb_commit`
--

INSERT INTO `tb_commit` (`id_commit`, `id_member`, `id_eva`, `status_commit`, `level_commit`, `detail_commit`, `signature`) VALUES
(1, 2, 1, 'n', 'ประธาน', NULL, NULL),
(2, 3, 1, 'n', 'กรรมการ', NULL, NULL),
(3, 4, 1, 'n', 'เลขา', NULL, NULL),
(7, 6, 3, 'n', 'ประธาน', NULL, NULL),
(8, 5, 3, 'n', 'กรรมการ', NULL, NULL),
(9, 4, 3, 'n', 'เลขา', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tb_doc`
--

CREATE TABLE `tb_doc` (
  `id_doc` int NOT NULL,
  `name_doc` varchar(100) NOT NULL,
  `day_doc` date NOT NULL,
  `file` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tb_doc`
--

INSERT INTO `tb_doc` (`id_doc`, `name_doc`, `day_doc`, `file`) VALUES
(2, 'sda', '2026-01-23', '1769149094656.txt');

-- --------------------------------------------------------

--
-- Table structure for table `tb_eva`
--

CREATE TABLE `tb_eva` (
  `id_eva` int NOT NULL,
  `id_member` int NOT NULL,
  `id_sys` int NOT NULL,
  `status_eva` int NOT NULL,
  `day_eva` date NOT NULL,
  `total_eva` double(10,2) DEFAULT NULL,
  `total_commit` double(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tb_eva`
--

INSERT INTO `tb_eva` (`id_eva`, `id_member`, `id_sys`, `status_eva`, `day_eva`, `total_eva`, `total_commit`) VALUES
(3, 3, 2, 2, '2026-01-08', 16.00, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tb_evadetail`
--

CREATE TABLE `tb_evadetail` (
  `id_eva` int NOT NULL,
  `id_indicate` int NOT NULL,
  `status_eva` int NOT NULL,
  `detail_eva` text NOT NULL,
  `score_member` int DEFAULT NULL,
  `score_commit` int DEFAULT NULL,
  `file_eva` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tb_evadetail`
--

INSERT INTO `tb_evadetail` (`id_eva`, `id_indicate`, `status_eva`, `detail_eva`, `score_member`, `score_commit`, `file_eva`) VALUES
(3, 2, 1, 'wsdsa', 4, NULL, '1769152381006qmx1e6r50m.png');

-- --------------------------------------------------------

--
-- Table structure for table `tb_indicate`
--

CREATE TABLE `tb_indicate` (
  `id_indicate` int NOT NULL,
  `id_topic` int NOT NULL,
  `name_indicate` varchar(100) NOT NULL,
  `detail_indicate` text NOT NULL,
  `point_indicate` int NOT NULL,
  `check_indicate` varchar(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tb_indicate`
--

INSERT INTO `tb_indicate` (`id_indicate`, `id_topic`, `name_indicate`, `detail_indicate`, `point_indicate`, `check_indicate`) VALUES
(2, 3, 'ฟหกฟ', 'หหห', 4, 'n');

-- --------------------------------------------------------

--
-- Table structure for table `tb_member`
--

CREATE TABLE `tb_member` (
  `id_member` int NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `role` enum('ฝ่ายบุคลากร','กรรมการประเมิน','ผู้รับการประเมินผล') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tb_member`
--

INSERT INTO `tb_member` (`id_member`, `first_name`, `last_name`, `email`, `username`, `password`, `role`) VALUES
(1, 'admin', '1', 'admin1@gmail.com', 'aaaa', '$2b$10$.UJ/vvNYLr5wgsf3DOW7M.gSlQO482xQLSqIMOfMp1varfB5LCTAK', 'ฝ่ายบุคลากร'),
(3, 'zzz', 'zz', 'zz@gmail.com', 'zzzz', '$2b$10$QS15wVDlzxgJnbXe0RfDbukUGPzNGeuVw68hw5eSpX21/nOsj3zii', 'ผู้รับการประเมินผล'),
(4, 'sss', 'ss', 'ss@gmail.com', 'ssss', '$2b$10$dwzZDhLXpJGUZbexkyVf0u7PfdFScybfkc733lfDpDFwPlUWdi8LS', 'กรรมการประเมิน'),
(5, 'dd', 'dd', 'dd@gmail.com', 'dddd', '$2b$10$BwbY5WhorMTu74V8Egtgg.AFsFTFmhrNBU3m/T442D3MwCf.SuvXS', 'กรรมการประเมิน'),
(6, 'ff', 'ff', 'ff@gmail.com', 'ffff', '$2b$10$SnkeB1IAjuiGojJf.gVdI.kR7HlThvpbmUJEZcfYXmIjrrDieZKg6', 'กรรมการประเมิน');

-- --------------------------------------------------------

--
-- Table structure for table `tb_system`
--

CREATE TABLE `tb_system` (
  `id_sys` int NOT NULL,
  `day_open` date NOT NULL,
  `day_out` date NOT NULL,
  `round_sys` varchar(1) NOT NULL,
  `year_sys` varchar(4) NOT NULL,
  `status_sys` varchar(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tb_system`
--

INSERT INTO `tb_system` (`id_sys`, `day_open`, `day_out`, `round_sys`, `year_sys`, `status_sys`) VALUES
(2, '2026-01-02', '2026-01-20', '2', '2569', 'y');

-- --------------------------------------------------------

--
-- Table structure for table `tb_topic`
--

CREATE TABLE `tb_topic` (
  `id_topic` int NOT NULL,
  `name_topic` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tb_topic`
--

INSERT INTO `tb_topic` (`id_topic`, `name_topic`) VALUES
(2, 'การจัดกิจกรรมกีฬา'),
(3, 'การจัดกิจกรรมการประเมิน');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tb_commit`
--
ALTER TABLE `tb_commit`
  ADD PRIMARY KEY (`id_commit`);

--
-- Indexes for table `tb_doc`
--
ALTER TABLE `tb_doc`
  ADD PRIMARY KEY (`id_doc`);

--
-- Indexes for table `tb_eva`
--
ALTER TABLE `tb_eva`
  ADD PRIMARY KEY (`id_eva`);

--
-- Indexes for table `tb_indicate`
--
ALTER TABLE `tb_indicate`
  ADD PRIMARY KEY (`id_indicate`);

--
-- Indexes for table `tb_member`
--
ALTER TABLE `tb_member`
  ADD PRIMARY KEY (`id_member`);

--
-- Indexes for table `tb_system`
--
ALTER TABLE `tb_system`
  ADD PRIMARY KEY (`id_sys`);

--
-- Indexes for table `tb_topic`
--
ALTER TABLE `tb_topic`
  ADD PRIMARY KEY (`id_topic`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tb_commit`
--
ALTER TABLE `tb_commit`
  MODIFY `id_commit` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `tb_doc`
--
ALTER TABLE `tb_doc`
  MODIFY `id_doc` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tb_eva`
--
ALTER TABLE `tb_eva`
  MODIFY `id_eva` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tb_indicate`
--
ALTER TABLE `tb_indicate`
  MODIFY `id_indicate` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tb_member`
--
ALTER TABLE `tb_member`
  MODIFY `id_member` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `tb_system`
--
ALTER TABLE `tb_system`
  MODIFY `id_sys` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tb_topic`
--
ALTER TABLE `tb_topic`
  MODIFY `id_topic` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
