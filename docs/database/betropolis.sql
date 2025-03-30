-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 30, 2025 at 04:08 AM
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
-- Table structure for table `friends`
--

CREATE TABLE `friends` (
  `id` int(11) NOT NULL,
  `friend1` int(11) NOT NULL,
  `friend2` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `friends`
--

INSERT INTO `friends` (`id`, `friend1`, `friend2`) VALUES
(5, 3, 1);

-- --------------------------------------------------------

--
-- Table structure for table `friend_requests`
--

CREATE TABLE `friend_requests` (
  `id` int(11) NOT NULL,
  `senderId` int(11) NOT NULL,
  `sentToId` int(11) NOT NULL,
  `status` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `friend_requests`
--

INSERT INTO `friend_requests` (`id`, `senderId`, `sentToId`, `status`) VALUES
(2, 1, 3, 'accepted'),
(3, 3, 2, 'active'),
(4, 1, 2, 'active'),
(5, 3, 4, 'active');

-- --------------------------------------------------------

--
-- Table structure for table `game`
--

CREATE TABLE `game` (
  `gameid` int(3) NOT NULL,
  `name` varchar(30) NOT NULL,
  `route` varchar(40) NOT NULL,
  `image` varchar(50) NOT NULL,
  `font` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `game`
--

INSERT INTO `game` (`gameid`, `name`, `route`, `image`, `font`) VALUES
(1, 'Fruit Frenzy Classic', '/fruit-frenzy-classic', 'fruitslotbg.jfif', 'orangek'),
(2, 'Crash', '/crash', 'dragon.jfif', 'dracutaz'),
(3, 'Find Card', '/find-card', 'findcardbg.jfif', 'borgens');

-- --------------------------------------------------------

--
-- Table structure for table `statistics`
--

CREATE TABLE `statistics` (
  `id` bigint(11) NOT NULL,
  `gameid` int(3) NOT NULL,
  `gain` tinyint(1) NOT NULL,
  `oldbalance` bigint(11) NOT NULL,
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
  `gender` tinyint(1) NOT NULL,
  `birthdate` date NOT NULL,
  `balance` bigint(20) NOT NULL,
  `lang` varchar(10) NOT NULL DEFAULT 'en',
  `avatar` varchar(51) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `username`, `password`, `name`, `gender`, `birthdate`, `balance`, `lang`, `avatar`) VALUES
(1, 'john.doe@example.com', 'johndoe', 'Password123.', 'John Doe', 0, '1990-01-01', 500, 'hu-HU', ''),
(2, 'jane.smith@example.com', 'janesmith', 'Password123.', 'Jane Smith', 0, '1992-02-02', 500, 'en', ''),
(3, 'bob.jones@example.com', 'bobjones', 'Password123.', 'Bob Jones', 0, '1985-03-03', 500, 'en', ''),
(4, 'alice.martin@example.com', 'alicemartin', 'Password123.', 'Alice Martin', 0, '1988-04-04', 500, 'en', ''),
(5, 'michael.brown@example.com', 'michaelbrown', 'Password123.', 'Michael Brown', 0, '1995-05-05', 500, 'en', ''),
(6, 'susan.davis@example.com', 'susandavis', 'Password123.', 'Susan Davis', 0, '1991-06-06', 500, 'en', ''),
(7, 'steve.wilson@example.com', 'stevewilson', 'Password123.', 'Steve Wilson', 0, '1987-07-07', 500, 'en', ''),
(8, 'emily.moore@example.com', 'emilymoore', 'Password123.', 'Emily Moore', 0, '1993-08-08', 500, 'en', ''),
(9, 'david.taylor@example.com', 'davidtaylor', 'Password123.', 'David Taylor', 0, '1986-09-09', 500, 'en', ''),
(10, 'laura.anderson@example.com', 'lauraanderson', 'Password123.', 'Laura Anderson', 0, '1994-10-10', 500, 'en', ''),
(11, 'james.jackson@example.com', 'jamesjackson', 'Password123.', 'James Jackson', 0, '1983-11-11', 500, 'en', ''),
(12, 'patricia.white@example.com', 'patriciawhite', 'Password123.', 'Patricia White', 0, '1996-12-12', 500, 'en', ''),
(13, 'robert.harris@example.com', 'robertharris', 'Password123.', 'Robert Harris', 0, '1991-01-13', 500, 'en', ''),
(14, 'linda.thomas@example.com', 'lindathomas', 'Password123.', 'Linda Thomas', 0, '1984-02-14', 500, 'en', ''),
(15, 'charles.martinez@example.com', 'charlesmartinez', 'Password123.', 'Charles Martinez', 0, '1992-03-15', 500, 'en', ''),
(16, 'barbara.robinson@example.com', 'barbararobinson', 'Password123.', 'Barbara Robinson', 0, '1987-04-16', 500, 'en', ''),
(17, 'joseph.clark@example.com', 'josephclark', 'Password123.', 'Joseph Clark', 0, '1990-05-17', 500, 'en', ''),
(18, 'margaret.rodriguez@example.com', 'margaretrodriguez', 'Password123.', 'Margaret Rodriguez', 0, '1993-06-18', 500, 'en', ''),
(19, 'thomas.lewis@example.com', 'thomaslewis', 'Password123.', 'Thomas Lewis', 0, '1988-07-19', 500, 'en', ''),
(20, 'sandra.lee@example.com', 'sandralee', 'Password123.', 'Sandra Lee', 0, '1985-08-20', 500, 'en', ''),
(21, 'christopher.walker@example.com', 'christopherwalker', 'Password123.', 'Christopher Walker', 0, '1994-09-21', 500, 'en', ''),
(22, 'kimberly.hall@example.com', 'kimberlyhall', 'Password123.', 'Kimberly Hall', 0, '1989-10-22', 500, 'en', ''),
(23, 'daniel.allen@example.com', 'danielallen', 'Password123.', 'Daniel Allen', 0, '1991-11-23', 500, 'en', ''),
(24, 'nancy.young@example.com', 'nancyyoung', 'Password123.', 'Nancy Young', 0, '1987-12-24', 500, 'en', ''),
(25, 'paul.king@example.com', 'paulking', 'Password123.', 'Paul King', 0, '1990-01-25', 500, 'en', ''),
(26, 'lisa.scott@example.com', 'lisascott', 'Password123.', 'Lisa Scott', 0, '1993-02-26', 500, 'en', ''),
(27, 'mark.adams@example.com', 'markadams', 'Password123.', 'Mark Adams', 0, '1988-03-27', 500, 'en', ''),
(28, 'betty.baker@example.com', 'bettybaker', 'Password123.', 'Betty Baker', 0, '1985-04-28', 500, 'en', ''),
(29, 'donald.gonzalez@example.com', 'donaldgonzalez', 'Password123.', 'Donald Gonzalez', 0, '1994-05-29', 500, 'en', ''),
(30, 'helen.nelson@example.com', 'helennelson', 'Password123.', 'Helen Nelson', 0, '1991-06-30', 500, 'en', ''),
(31, 'george.carter@example.com', 'georgecarter', 'Password123.', 'George Carter', 0, '1987-07-31', 500, 'en', ''),
(32, 'dorothy.mitchell@example.com', 'dorothymitchell', 'Password123.', 'Dorothy Mitchell', 0, '1990-08-01', 500, 'en', ''),
(33, 'kenneth.perez@example.com', 'kennethperez', 'Password123.', 'Kenneth Perez', 0, '1992-09-02', 500, 'en', ''),
(34, 'carol.roberts@example.com', 'carolroberts', 'Password123.', 'Carol Roberts', 0, '1986-10-03', 500, 'en', ''),
(35, 'edward.turner@example.com', 'edwardturner', 'Password123.', 'Edward Turner', 0, '1989-11-04', 500, 'en', ''),
(36, 'michelle.phillips@example.com', 'michellephillips', 'Password123.', 'Michelle Phillips', 0, '1991-12-05', 500, 'en', ''),
(37, 'brian.campbell@example.com', 'briancampbell', 'Password123.', 'Brian Campbell', 0, '1988-01-06', 500, 'en', ''),
(38, 'shirley.parker@example.com', 'shirleyparker', 'Password123.', 'Shirley Parker', 0, '1987-02-07', 500, 'en', ''),
(39, 'ronald.evans@example.com', 'ronaldevans', 'Password123.', 'Ronald Evans', 0, '1990-03-08', 500, 'en', ''),
(40, 'laura.edwards@example.com', 'lauraedwards', 'Password123.', 'Laura Edwards', 0, '1992-04-09', 500, 'en', ''),
(41, 'anthony.collins@example.com', 'anthonycollins', 'Password123.', 'Anthony Collins', 0, '1985-05-10', 500, 'en', ''),
(42, 'cynthia.stewart@example.com', 'cynthiastewart', 'Password123.', 'Cynthia Stewart', 0, '1993-06-11', 500, 'en', ''),
(43, 'kevin.sanchez@example.com', 'kevinsanchez', 'Password123.', 'Kevin Sanchez', 0, '1986-07-12', 500, 'en', ''),
(44, 'sharon.morris@example.com', 'sharonmorris', 'Password123.', 'Sharon Morris', 0, '1989-08-13', 500, 'en', ''),
(45, 'jeffrey.rogers@example.com', 'jeffreyrogers', 'Password123.', 'Jeffrey Rogers', 0, '1991-09-14', 500, 'en', ''),
(46, 'karen.reed@example.com', 'karenreed', 'Password123.', 'Karen Reed', 0, '1987-10-15', 500, 'en', ''),
(47, 'eric.cook@example.com', 'ericcook', 'Password123.', 'Eric Cook', 0, '1990-11-16', 500, 'en', ''),
(48, 'brenda.morgan@example.com', 'brendamorgan', 'Password123.', 'Brenda Morgan', 0, '1992-12-17', 500, 'en', ''),
(49, 'frank.bell@example.com', 'frankbell', 'Password123.', 'Frank Bell', 0, '1988-01-18', 500, 'en', ''),
(50, 'amy.cooper@example.com', 'amycooper', 'Password123.', 'Amy Cooper', 0, '1991-02-19', 500, 'en', ''),
(51, '', '', '', '', 0, '0000-00-00', 500, 'en', ''),
(58, 'iskolai@gmail.com', 'iskolai', 'Password1234!', 'iskolai', 0, '2007-03-03', 3820, 'en', '/src/lib/media/images/avatars/male_avatars/avatar_8');

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
-- Dumping data for table `user_session`
--

INSERT INTO `user_session` (`id`, `user_id`, `expires_at`) VALUES
('5a7bc5390037b0e4761965cba7ca9060e1b814fa2c8e7e5c78dd6377954d4ef5', 58, '2025-04-27 09:32:20');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bonus`
--
ALTER TABLE `bonus`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `friends`
--
ALTER TABLE `friends`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `friend_requests`
--
ALTER TABLE `friend_requests`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `game`
--
ALTER TABLE `game`
  ADD PRIMARY KEY (`gameid`);

--
-- Indexes for table `statistics`
--
ALTER TABLE `statistics`
  ADD PRIMARY KEY (`id`),
  ADD KEY `email` (`gameid`);

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
-- AUTO_INCREMENT for table `friends`
--
ALTER TABLE `friends`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `friend_requests`
--
ALTER TABLE `friend_requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `game`
--
ALTER TABLE `game`
  MODIFY `gameid` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `statistics`
--
ALTER TABLE `statistics`
  MODIFY `id` bigint(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
