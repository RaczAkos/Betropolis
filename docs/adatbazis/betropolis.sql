-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 17, 2025 at 01:58 AM
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
  `route` varchar(40) NOT NULL,
  `image` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `game`
--

INSERT INTO `game` (`gameid`, `name`, `route`, `image`) VALUES
(1, 'Fruit Frenzy Classic', '/fruit-frenzy-classic', 'fruit-frenzy'),
(2, 'Crash', '/crash', 'dragoncrash'),
(3, 'Find Card', '/find-card', 'findcard');

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
(1, 'john.doe@example.com', 'johndoe', 'Password123.', 'John Doe', 'M', '1990-01-01', 500),
(2, 'jane.smith@example.com', 'janesmith', 'Password123.', 'Jane Smith', 'F', '1992-02-02', 500),
(3, 'bob.jones@example.com', 'bobjones', 'Password123.', 'Bob Jones', 'M', '1985-03-03', 500),
(4, 'alice.martin@example.com', 'alicemartin', 'Password123.', 'Alice Martin', 'F', '1988-04-04', 500),
(5, 'michael.brown@example.com', 'michaelbrown', 'Password123.', 'Michael Brown', 'M', '1995-05-05', 500),
(6, 'susan.davis@example.com', 'susandavis', 'Password123.', 'Susan Davis', 'F', '1991-06-06', 500),
(7, 'steve.wilson@example.com', 'stevewilson', 'Password123.', 'Steve Wilson', 'M', '1987-07-07', 500),
(8, 'emily.moore@example.com', 'emilymoore', 'Password123.', 'Emily Moore', 'F', '1993-08-08', 500),
(9, 'david.taylor@example.com', 'davidtaylor', 'Password123.', 'David Taylor', 'M', '1986-09-09', 500),
(10, 'laura.anderson@example.com', 'lauraanderson', 'Password123.', 'Laura Anderson', 'F', '1994-10-10', 500),
(11, 'james.jackson@example.com', 'jamesjackson', 'Password123.', 'James Jackson', 'M', '1983-11-11', 500),
(12, 'patricia.white@example.com', 'patriciawhite', 'Password123.', 'Patricia White', 'F', '1996-12-12', 500),
(13, 'robert.harris@example.com', 'robertharris', 'Password123.', 'Robert Harris', 'M', '1991-01-13', 500),
(14, 'linda.thomas@example.com', 'lindathomas', 'Password123.', 'Linda Thomas', 'F', '1984-02-14', 500),
(15, 'charles.martinez@example.com', 'charlesmartinez', 'Password123.', 'Charles Martinez', 'M', '1992-03-15', 500),
(16, 'barbara.robinson@example.com', 'barbararobinson', 'Password123.', 'Barbara Robinson', 'F', '1987-04-16', 500),
(17, 'joseph.clark@example.com', 'josephclark', 'Password123.', 'Joseph Clark', 'M', '1990-05-17', 500),
(18, 'margaret.rodriguez@example.com', 'margaretrodriguez', 'Password123.', 'Margaret Rodriguez', 'F', '1993-06-18', 500),
(19, 'thomas.lewis@example.com', 'thomaslewis', 'Password123.', 'Thomas Lewis', 'M', '1988-07-19', 500),
(20, 'sandra.lee@example.com', 'sandralee', 'Password123.', 'Sandra Lee', 'F', '1985-08-20', 500),
(21, 'christopher.walker@example.com', 'christopherwalker', 'Password123.', 'Christopher Walker', 'M', '1994-09-21', 500),
(22, 'kimberly.hall@example.com', 'kimberlyhall', 'Password123.', 'Kimberly Hall', 'F', '1989-10-22', 500),
(23, 'daniel.allen@example.com', 'danielallen', 'Password123.', 'Daniel Allen', 'M', '1991-11-23', 500),
(24, 'nancy.young@example.com', 'nancyyoung', 'Password123.', 'Nancy Young', 'F', '1987-12-24', 500),
(25, 'paul.king@example.com', 'paulking', 'Password123.', 'Paul King', 'M', '1990-01-25', 500),
(26, 'lisa.scott@example.com', 'lisascott', 'Password123.', 'Lisa Scott', 'F', '1993-02-26', 500),
(27, 'mark.adams@example.com', 'markadams', 'Password123.', 'Mark Adams', 'M', '1988-03-27', 500),
(28, 'betty.baker@example.com', 'bettybaker', 'Password123.', 'Betty Baker', 'F', '1985-04-28', 500),
(29, 'donald.gonzalez@example.com', 'donaldgonzalez', 'Password123.', 'Donald Gonzalez', 'M', '1994-05-29', 500),
(30, 'helen.nelson@example.com', 'helennelson', 'Password123.', 'Helen Nelson', 'F', '1991-06-30', 500),
(31, 'george.carter@example.com', 'georgecarter', 'Password123.', 'George Carter', 'M', '1987-07-31', 500),
(32, 'dorothy.mitchell@example.com', 'dorothymitchell', 'Password123.', 'Dorothy Mitchell', 'F', '1990-08-01', 500),
(33, 'kenneth.perez@example.com', 'kennethperez', 'Password123.', 'Kenneth Perez', 'M', '1992-09-02', 500),
(34, 'carol.roberts@example.com', 'carolroberts', 'Password123.', 'Carol Roberts', 'F', '1986-10-03', 500),
(35, 'edward.turner@example.com', 'edwardturner', 'Password123.', 'Edward Turner', 'M', '1989-11-04', 500),
(36, 'michelle.phillips@example.com', 'michellephillips', 'Password123.', 'Michelle Phillips', 'F', '1991-12-05', 500),
(37, 'brian.campbell@example.com', 'briancampbell', 'Password123.', 'Brian Campbell', 'M', '1988-01-06', 500),
(38, 'shirley.parker@example.com', 'shirleyparker', 'Password123.', 'Shirley Parker', 'F', '1987-02-07', 500),
(39, 'ronald.evans@example.com', 'ronaldevans', 'Password123.', 'Ronald Evans', 'M', '1990-03-08', 500),
(40, 'laura.edwards@example.com', 'lauraedwards', 'Password123.', 'Laura Edwards', 'F', '1992-04-09', 500),
(41, 'anthony.collins@example.com', 'anthonycollins', 'Password123.', 'Anthony Collins', 'M', '1985-05-10', 500),
(42, 'cynthia.stewart@example.com', 'cynthiastewart', 'Password123.', 'Cynthia Stewart', 'F', '1993-06-11', 500),
(43, 'kevin.sanchez@example.com', 'kevinsanchez', 'Password123.', 'Kevin Sanchez', 'M', '1986-07-12', 500),
(44, 'sharon.morris@example.com', 'sharonmorris', 'Password123.', 'Sharon Morris', 'F', '1989-08-13', 500),
(45, 'jeffrey.rogers@example.com', 'jeffreyrogers', 'Password123.', 'Jeffrey Rogers', 'M', '1991-09-14', 500),
(46, 'karen.reed@example.com', 'karenreed', 'Password123.', 'Karen Reed', 'F', '1987-10-15', 500),
(47, 'eric.cook@example.com', 'ericcook', 'Password123.', 'Eric Cook', 'M', '1990-11-16', 500),
(48, 'brenda.morgan@example.com', 'brendamorgan', 'Password123.', 'Brenda Morgan', 'F', '1992-12-17', 500),
(49, 'frank.bell@example.com', 'frankbell', 'Password123.', 'Frank Bell', 'M', '1988-01-18', 500),
(50, 'amy.cooper@example.com', 'amycooper', 'Password123.', 'Amy Cooper', 'F', '1991-02-19', 500);

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
('7fdf40710aa63cebbacfda1dd92e8209c36f07eb153e4568945427d95e405131', 1, '2025-04-15 23:17:17');

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
