-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 13, 2025 at 11:17 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `betropolis`
--

-- --------------------------------------------------------

--
-- Table structure for table `bonus`
--

CREATE TABLE `bonus` (
  `id` int(11) NOT NULL,
  `email` varchar(50) NOT NULL,
  `starting_bonus` int(5) NOT NULL,
  `status` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bonus`
--

INSERT INTO `bonus` (`id`, `email`, `starting_bonus`, `status`) VALUES
(1, 'example@example.com', 2700, 0);

-- --------------------------------------------------------

--
-- Table structure for table `game`
--

CREATE TABLE `game` (
  `gameid` int(3) NOT NULL,
  `name` varchar(30) NOT NULL,
  `type-id` int(2) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `game`
--

INSERT INTO `game` (`gameid`, `name`, `type-id`, `description`) VALUES
(1, 'Fruit Frenzy Classic', 1, 'Spin your way to juicy rewards in Fruit Jackpot Frenzy! This vibrant slot game is packed with colorful fruit symbols, exciting bonus rounds, and thrilling multipliers. With every spin, you\'ll have the chance to hit massive jackpots while enjoying the playful, fruity theme. Whether you\'re a casual player or a high roller, the fun never stops in this fruit-filled adventure!'),
(2, 'Crash', 3, NULL),
(3, 'Find Card', 2, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `game-type`
--

CREATE TABLE `game-type` (
  `id` int(2) NOT NULL,
  `category` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `game-type`
--

INSERT INTO `game-type` (`id`, `category`) VALUES
(1, 'slot-machine'),
(2, 'card'),
(3, 'other');

-- --------------------------------------------------------

--
-- Table structure for table `statistics`
--

CREATE TABLE `statistics` (
  `id` bigint(11) NOT NULL,
  `email` varchar(50) NOT NULL,
  `gameid` int(3) NOT NULL,
  `gain` tinyint(1) NOT NULL,
  `oldbalance` bigint(11) NOT NULL,
  `amount` bigint(11) NOT NULL,
  `newbalance` bigint(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `email` varchar(50) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL,
  `name` varchar(60) NOT NULL,
  `gender` char(1) NOT NULL,
  `birthdate` date NOT NULL,
  `balance` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `username`, `password`, `name`, `gender`, `birthdate`, `balance`) VALUES
(1, 'john.doe@example.com', 'johndoe', 'password123', 'John Doe', 'M', '1990-01-01', 0),
(2, 'jane.smith@example.com', 'janesmith', 'password123', 'Jane Smith', 'F', '1992-02-02', 0),
(3, 'bob.jones@example.com', 'bobjones', 'password123', 'Bob Jones', 'M', '1985-03-03', 0),
(4, 'alice.martin@example.com', 'alicemartin', 'password123', 'Alice Martin', 'F', '1988-04-04', 0),
(5, 'michael.brown@example.com', 'michaelbrown', 'password123', 'Michael Brown', 'M', '1995-05-05', 0),
(6, 'susan.davis@example.com', 'susandavis', 'password123', 'Susan Davis', 'F', '1991-06-06', 0),
(7, 'steve.wilson@example.com', 'stevewilson', 'password123', 'Steve Wilson', 'M', '1987-07-07', 0),
(8, 'emily.moore@example.com', 'emilymoore', 'password123', 'Emily Moore', 'F', '1993-08-08', 0),
(9, 'david.taylor@example.com', 'davidtaylor', 'password123', 'David Taylor', 'M', '1986-09-09', 0),
(10, 'laura.anderson@example.com', 'lauraanderson', 'password123', 'Laura Anderson', 'F', '1994-10-10', 0),
(11, 'james.jackson@example.com', 'jamesjackson', 'password123', 'James Jackson', 'M', '1983-11-11', 0),
(12, 'patricia.white@example.com', 'patriciawhite', 'password123', 'Patricia White', 'F', '1996-12-12', 0),
(13, 'robert.harris@example.com', 'robertharris', 'password123', 'Robert Harris', 'M', '1991-01-13', 0),
(14, 'linda.thomas@example.com', 'lindathomas', 'password123', 'Linda Thomas', 'F', '1984-02-14', 0),
(15, 'charles.martinez@example.com', 'charlesmartinez', 'password123', 'Charles Martinez', 'M', '1992-03-15', 0),
(16, 'barbara.robinson@example.com', 'barbararobinson', 'password123', 'Barbara Robinson', 'F', '1987-04-16', 0),
(17, 'joseph.clark@example.com', 'josephclark', 'password123', 'Joseph Clark', 'M', '1990-05-17', 0),
(18, 'margaret.rodriguez@example.com', 'margaretrodriguez', 'password123', 'Margaret Rodriguez', 'F', '1993-06-18', 0),
(19, 'thomas.lewis@example.com', 'thomaslewis', 'password123', 'Thomas Lewis', 'M', '1988-07-19', 0),
(20, 'sandra.lee@example.com', 'sandralee', 'password123', 'Sandra Lee', 'F', '1985-08-20', 0),
(21, 'christopher.walker@example.com', 'christopherwalker', 'password123', 'Christopher Walker', 'M', '1994-09-21', 0),
(22, 'kimberly.hall@example.com', 'kimberlyhall', 'password123', 'Kimberly Hall', 'F', '1989-10-22', 0),
(23, 'daniel.allen@example.com', 'danielallen', 'password123', 'Daniel Allen', 'M', '1991-11-23', 0),
(24, 'nancy.young@example.com', 'nancyyoung', 'password123', 'Nancy Young', 'F', '1987-12-24', 0),
(25, 'paul.king@example.com', 'paulking', 'password123', 'Paul King', 'M', '1990-01-25', 0),
(26, 'lisa.scott@example.com', 'lisascott', 'password123', 'Lisa Scott', 'F', '1993-02-26', 0),
(27, 'mark.adams@example.com', 'markadams', 'password123', 'Mark Adams', 'M', '1988-03-27', 0),
(28, 'betty.baker@example.com', 'bettybaker', 'password123', 'Betty Baker', 'F', '1985-04-28', 0),
(29, 'donald.gonzalez@example.com', 'donaldgonzalez', 'password123', 'Donald Gonzalez', 'M', '1994-05-29', 0),
(30, 'helen.nelson@example.com', 'helennelson', 'password123', 'Helen Nelson', 'F', '1991-06-30', 0),
(31, 'george.carter@example.com', 'georgecarter', 'password123', 'George Carter', 'M', '1987-07-31', 0),
(32, 'dorothy.mitchell@example.com', 'dorothymitchell', 'password123', 'Dorothy Mitchell', 'F', '1990-08-01', 0),
(33, 'kenneth.perez@example.com', 'kennethperez', 'password123', 'Kenneth Perez', 'M', '1992-09-02', 0),
(34, 'carol.roberts@example.com', 'carolroberts', 'password123', 'Carol Roberts', 'F', '1986-10-03', 0),
(35, 'edward.turner@example.com', 'edwardturner', 'password123', 'Edward Turner', 'M', '1989-11-04', 0),
(36, 'michelle.phillips@example.com', 'michellephillips', 'password123', 'Michelle Phillips', 'F', '1991-12-05', 0),
(37, 'brian.campbell@example.com', 'briancampbell', 'password123', 'Brian Campbell', 'M', '1988-01-06', 0),
(38, 'shirley.parker@example.com', 'shirleyparker', 'password123', 'Shirley Parker', 'F', '1987-02-07', 0),
(39, 'ronald.evans@example.com', 'ronaldevans', 'password123', 'Ronald Evans', 'M', '1990-03-08', 0),
(40, 'laura.edwards@example.com', 'lauraedwards', 'password123', 'Laura Edwards', 'F', '1992-04-09', 0),
(41, 'anthony.collins@example.com', 'anthonycollins', 'password123', 'Anthony Collins', 'M', '1985-05-10', 0),
(42, 'cynthia.stewart@example.com', 'cynthiastewart', 'password123', 'Cynthia Stewart', 'F', '1993-06-11', 0),
(43, 'kevin.sanchez@example.com', 'kevinsanchez', 'password123', 'Kevin Sanchez', 'M', '1986-07-12', 0),
(44, 'sharon.morris@example.com', 'sharonmorris', 'password123', 'Sharon Morris', 'F', '1989-08-13', 0),
(45, 'jeffrey.rogers@example.com', 'jeffreyrogers', 'password123', 'Jeffrey Rogers', 'M', '1991-09-14', 0),
(46, 'karen.reed@example.com', 'karenreed', 'password123', 'Karen Reed', 'F', '1987-10-15', 0),
(47, 'eric.cook@example.com', 'ericcook', 'password123', 'Eric Cook', 'M', '1990-11-16', 0),
(48, 'brenda.morgan@example.com', 'brendamorgan', 'password123', 'Brenda Morgan', 'F', '1992-12-17', 0),
(49, 'frank.bell@example.com', 'frankbell', 'password123', 'Frank Bell', 'M', '1988-01-18', 0),
(50, 'amy.cooper@example.com', 'amycooper', 'password123', 'Amy Cooper', 'F', '1991-02-19', 0);

-- --------------------------------------------------------

--
-- Table structure for table `user_session`
--

CREATE TABLE `user_session` (
  `id` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `expires_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bonus`
--
ALTER TABLE `bonus`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `game`
--
ALTER TABLE `game`
  ADD PRIMARY KEY (`gameid`);

--
-- Indexes for table `game-type`
--
ALTER TABLE `game-type`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `statistics`
--
ALTER TABLE `statistics`
  ADD PRIMARY KEY (`id`),
  ADD KEY `email` (`email`,`gameid`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_session`
--
ALTER TABLE `user_session`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bonus`
--
ALTER TABLE `bonus`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `game`
--
ALTER TABLE `game`
  MODIFY `gameid` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `game-type`
--
ALTER TABLE `game-type`
  MODIFY `id` int(2) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `statistics`
--
ALTER TABLE `statistics`
  MODIFY `id` bigint(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
