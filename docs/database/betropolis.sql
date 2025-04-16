-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2025. Ápr 16. 04:10
-- Kiszolgáló verziója: 10.4.32-MariaDB
-- PHP verzió: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `betropolis`
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `bonus`
--

CREATE TABLE `bonus` (
  `id` int(11) NOT NULL,
  `email` varchar(50) NOT NULL,
  `starting_bonus` int(5) NOT NULL,
  `status` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `bonus`
--

INSERT INTO `bonus` (`id`, `email`, `starting_bonus`, `status`) VALUES
(1, 'example@example.com', 2700, 0),
(2, 'pityi.panna@mail.com', 4500, 1);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `friends`
--

CREATE TABLE `friends` (
  `id` int(11) NOT NULL,
  `friend1` int(11) NOT NULL,
  `friend2` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `friends`
--

INSERT INTO `friends` (`id`, `friend1`, `friend2`, `status`) VALUES
(5, 3, 1, 0),
(6, 2, 3, 0),
(7, 2, 1, 0),
(8, 59, 2, 1),
(9, 1, 59, 1),
(10, 58, 4, 1);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `friend_requests`
--

CREATE TABLE `friend_requests` (
  `id` int(11) NOT NULL,
  `senderId` int(11) NOT NULL,
  `sentToId` int(11) NOT NULL,
  `status` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `friend_requests`
--

INSERT INTO `friend_requests` (`id`, `senderId`, `sentToId`, `status`) VALUES
(2, 1, 3, 'accepted'),
(3, 3, 2, 'accepted'),
(4, 1, 2, 'accepted'),
(5, 3, 4, 'deleted'),
(6, 59, 1, 'deleted'),
(7, 59, 2, 'deleted'),
(8, 59, 4, 'deleted'),
(9, 4, 58, 'accepted'),
(10, 2, 59, 'accepted'),
(11, 59, 4, 'deleted'),
(12, 59, 1, 'accepted'),
(13, 59, 4, 'active');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `game`
--

CREATE TABLE `game` (
  `gameid` int(3) NOT NULL,
  `name` varchar(30) NOT NULL,
  `route` varchar(40) NOT NULL,
  `image` varchar(50) NOT NULL,
  `font` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `game`
--

INSERT INTO `game` (`gameid`, `name`, `route`, `image`, `font`) VALUES
(1, 'Fruit Frenzy Classic', '/fruit-frenzy-classic', 'fruitslotbg.jfif', 'orangek'),
(2, 'Crash', '/crash', 'dragon.jfif', 'dracutaz'),
(3, 'Find Card', '/find-card', 'findcardbg.jfif', 'borgens');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `statistics`
--

CREATE TABLE `statistics` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `gameid` int(3) NOT NULL,
  `gain` int(11) NOT NULL,
  `oldbalance` bigint(11) NOT NULL,
  `newbalance` bigint(11) NOT NULL,
  `date` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `statistics`
--

INSERT INTO `statistics` (`id`, `user_id`, `gameid`, `gain`, `oldbalance`, `newbalance`, `date`) VALUES
(1, 58, 2, -1000, 13000, 12000, ''),
(2, 58, 2, 2000, 12000, 14000, ''),
(3, 1, 1, -10, 472, 462, '2025. 04. 02. 19:29:30'),
(4, 1, 1, -10, 462, 452, '2025. 04. 02. 19:29:35'),
(5, 1, 1, -10, 452, 442, '2025. 04. 02. 20:18:18'),
(6, 1, 1, -10, 442, 432, '2025. 04. 02. 20:18:23'),
(7, 1, 1, -10, 432, 422, '2025. 04. 02. 20:18:27'),
(8, 1, 1, -10, 422, 412, '2025. 04. 02. 20:18:32'),
(9, 1, 1, -10, 412, 402, '2025. 04. 02. 20:18:37'),
(10, 1, 1, -10, 402, 392, '2025. 04. 02. 20:18:41'),
(11, 1, 1, -10, 392, 382, '2025. 04. 02. 20:18:46'),
(12, 1, 1, -10, 382, 372, '2025. 04. 02. 20:18:51'),
(13, 1, 1, -10, 372, 362, '2025. 04. 02. 20:18:55'),
(14, 1, 1, -10, 362, 352, '2025. 04. 02. 20:19:18'),
(15, 1, 1, -10, 352, 342, '2025. 04. 02. 20:22:28'),
(16, 1, 1, -10, 342, 332, '2025. 04. 02. 20:22:33'),
(17, 1, 1, -10, 332, 322, '2025. 04. 02. 20:22:38'),
(18, 1, 1, -10, 322, 312, '2025. 04. 02. 20:22:43'),
(19, 1, 1, -10, 312, 302, '2025. 04. 02. 20:22:48'),
(20, 1, 1, -10, 302, 292, '2025. 04. 02. 20:22:52'),
(21, 1, 1, -10, 292, 282, '2025. 04. 02. 20:22:57'),
(22, 1, 1, -10, 282, 272, '2025. 04. 02. 20:23:02'),
(23, 1, 1, -10, 272, 262, '2025. 04. 02. 20:23:06'),
(24, 1, 1, -10, 262, 252, '2025. 04. 02. 20:23:11'),
(25, 1, 1, -10, 252, 242, '2025. 04. 02. 20:23:16'),
(26, 1, 1, -10, 242, 232, '2025. 04. 02. 20:23:20'),
(27, 1, 1, -10, 232, 222, '2025. 04. 02. 20:23:25'),
(28, 1, 1, -10, 222, 212, '2025. 04. 02. 20:23:29'),
(29, 1, 1, -10, 212, 202, '2025. 04. 02. 20:23:34'),
(30, 1, 1, -10, 202, 192, '2025. 04. 02. 20:23:39'),
(31, 1, 1, -10, 192, 182, '2025. 04. 02. 20:23:43'),
(32, 1, 1, -10, 182, 172, '2025. 04. 02. 20:23:48'),
(33, 1, 1, -10, 172, 162, '2025. 04. 02. 20:23:53'),
(34, 1, 1, -10, 162, 152, '2025. 04. 02. 20:23:57'),
(35, 1, 1, -10, 152, 142, '2025. 04. 02. 20:24:02'),
(36, 1, 1, -10, 142, 132, '2025. 04. 02. 20:24:07'),
(37, 1, 1, 1000, 132, 1132, '2025. 04. 02. 20:24:10'),
(38, 1, 1, -10, 1132, 1122, '2025. 04. 02. 20:24:11'),
(39, 1, 1, -10, 1122, 1112, '2025. 04. 02. 20:24:16'),
(40, 1, 1, -10, 1112, 1102, '2025. 04. 02. 20:24:20'),
(41, 1, 1, -10, 1102, 1092, '2025. 04. 02. 20:24:25'),
(42, 1, 1, -10, 1092, 1082, '2025. 04. 02. 20:24:30'),
(43, 1, 1, -10, 1082, 1072, '2025. 04. 02. 20:24:34'),
(44, 1, 1, -10, 1072, 1062, '2025. 04. 02. 20:24:39'),
(45, 1, 1, -10, 1062, 1052, '2025. 04. 02. 20:24:44'),
(46, 1, 2, -11, 1052, 1041, '2025. 04. 03. 10:13:18'),
(47, 1, 2, 22, 1041, 1063, '2025. 04. 03. 10:13:22'),
(48, 1, 2, -11, 1063, 1052, '2025. 04. 03. 10:13:29'),
(49, 1, 2, 22, 1052, 1074, '2025. 04. 03. 10:13:33'),
(50, 1, 2, -11, 1074, 1063, '2025. 04. 03. 10:13:41'),
(51, 1, 2, 22, 1063, 1085, '2025. 04. 03. 10:13:45'),
(52, 1, 2, -11, 1085, 1074, '2025. 04. 03. 10:13:58'),
(53, 1, 2, 22, 1074, 1096, '2025. 04. 03. 10:14:02'),
(54, 1, 2, -715, 1096, 381, '2025. 04. 03. 10:14:17'),
(55, 1, 2, 1430, 381, 1811, '2025. 04. 03. 10:14:21'),
(56, 1, 2, -715, 1811, 1096, '2025. 04. 03. 10:14:31'),
(57, 1, 2, -715, 1096, 381, '2025. 04. 03. 10:14:35'),
(58, 1, 2, 1430, 381, 1811, '2025. 04. 03. 10:14:39'),
(59, 1, 2, -715, 1811, 1096, '2025. 04. 03. 10:14:48'),
(60, 1, 2, 1430, 1096, 2526, '2025. 04. 03. 10:14:52'),
(61, 1, 2, -715, 2526, 1811, '2025. 04. 03. 10:15:02'),
(62, 1, 2, -715, 1811, 1096, '2025. 04. 03. 10:15:07'),
(63, 1, 2, 1430, 1096, 2526, '2025. 04. 03. 10:15:11'),
(64, 1, 2, -715, 2526, 1811, '2025. 04. 03. 10:15:14'),
(65, 1, 2, 358, 1811, 2169, '2025. 04. 03. 10:15:16'),
(66, 1, 2, -715, 2169, 1454, '2025. 04. 03. 10:15:18'),
(67, 1, 2, 1430, 1454, 2884, '2025. 04. 03. 10:15:22'),
(68, 1, 2, -715, 2884, 2169, '2025. 04. 03. 10:15:28'),
(69, 1, 2, 1430, 2169, 3599, '2025. 04. 03. 10:15:32'),
(70, 1, 2, -715, 3599, 2884, '2025. 04. 03. 10:15:42'),
(71, 1, 2, 1430, 2884, 4314, '2025. 04. 03. 10:15:46'),
(72, 1, 2, -2000, 4314, 2314, '2025. 04. 03. 10:16:18'),
(73, 1, 2, 5000, 2314, 7314, '2025. 04. 03. 10:16:24'),
(74, 1, 2, -2000, 7314, 5314, '2025. 04. 03. 10:16:27'),
(75, 1, 2, 5000, 5314, 10314, '2025. 04. 03. 10:16:33'),
(76, 1, 1, -10, 10314, 10304, '2025. 04. 03. 11:05:14'),
(77, 1, 1, -10, 10304, 10294, '2025. 04. 03. 11:11:37'),
(78, 1, 1, -10, 10294, 10284, '2025. 04. 03. 11:11:45'),
(79, 1, 1, -10, 10284, 10274, '2025. 04. 03. 11:12:39'),
(80, 1, 1, -10, 10274, 10264, '2025. 04. 03. 11:13:34'),
(81, 1, 1, -10, 10264, 10254, '2025. 04. 03. 11:13:49'),
(82, 1, 1, -10, 10254, 10244, '2025. 04. 03. 11:13:58'),
(83, 1, 1, -10, 10244, 10234, '2025. 04. 03. 11:14:02'),
(84, 1, 1, -10, 10234, 10224, '2025. 04. 03. 11:14:05'),
(85, 1, 1, -10, 10224, 10214, '2025. 04. 03. 11:14:07'),
(86, 1, 1, -10, 10214, 10204, '2025. 04. 03. 11:14:12'),
(87, 1, 1, -10, 10204, 10194, '2025. 04. 03. 11:14:16'),
(88, 1, 1, -10, 10194, 10184, '2025. 04. 03. 11:14:21'),
(89, 1, 1, -10, 10184, 10174, '2025. 04. 03. 11:14:26'),
(90, 1, 1, -10, 10174, 10164, '2025. 04. 03. 11:14:30'),
(91, 1, 1, -10, 10164, 10154, '2025. 04. 03. 11:14:35'),
(92, 1, 1, -10, 10154, 10144, '2025. 04. 03. 11:14:39'),
(93, 1, 1, -10, 10144, 10134, '2025. 04. 03. 11:14:44'),
(94, 1, 1, -10, 10134, 10124, '2025. 04. 03. 11:14:49'),
(95, 1, 1, -10, 10124, 10114, '2025. 04. 03. 11:14:53'),
(96, 1, 1, -10, 10114, 10104, '2025. 04. 03. 11:14:58'),
(97, 1, 1, -10, 10104, 10094, '2025. 04. 03. 11:15:03'),
(98, 1, 1, -10, 10094, 10084, '2025. 04. 03. 11:15:07'),
(99, 1, 1, -10, 10084, 10074, '2025. 04. 03. 11:15:12'),
(100, 1, 1, -10, 10074, 10064, '2025. 04. 03. 11:15:17'),
(101, 1, 1, -10, 10064, 10054, '2025. 04. 03. 11:15:21'),
(102, 1, 1, -10, 10054, 10044, '2025. 04. 03. 11:15:26'),
(103, 1, 1, -10, 10044, 10034, '2025. 04. 03. 11:15:31'),
(104, 1, 1, -10, 10034, 10024, '2025. 04. 03. 11:15:35'),
(105, 1, 1, -10, 10024, 10014, '2025. 04. 03. 11:15:40'),
(106, 1, 1, -10, 10014, 10004, '2025. 04. 03. 11:15:45'),
(107, 1, 1, -10, 10004, 9994, '2025. 04. 03. 11:15:49'),
(108, 1, 1, -10, 9994, 9984, '2025. 04. 03. 11:15:54'),
(109, 1, 1, -10, 9984, 9974, '2025. 04. 03. 11:15:58'),
(110, 1, 1, -10, 9974, 9964, '2025. 04. 03. 11:16:03'),
(111, 1, 1, -10, 9964, 9954, '2025. 04. 03. 11:16:08'),
(112, 1, 1, -10, 9954, 9944, '2025. 04. 03. 11:16:12'),
(113, 1, 1, -10, 9944, 9934, '2025. 04. 03. 11:16:17'),
(114, 1, 1, -10, 9934, 9924, '2025. 04. 03. 11:16:22'),
(115, 1, 1, -10, 9924, 9914, '2025. 04. 03. 11:16:26'),
(116, 1, 1, -10, 9914, 9904, '2025. 04. 03. 11:16:31'),
(117, 1, 1, -10, 9904, 9894, '2025. 04. 03. 11:16:36'),
(118, 1, 1, -10, 9894, 9884, '2025. 04. 03. 11:17:15'),
(119, 1, 1, -10, 9884, 9874, '2025. 04. 03. 11:17:20'),
(120, 1, 1, -10, 9874, 9864, '2025. 04. 03. 11:17:24'),
(121, 1, 1, -10, 9864, 9854, '2025. 04. 03. 11:19:09'),
(122, 1, 1, -10, 9854, 9844, '2025. 04. 03. 11:19:14'),
(123, 1, 1, -10, 9844, 9834, '2025. 04. 03. 11:19:37'),
(124, 1, 1, -10, 9834, 9824, '2025. 04. 03. 11:19:42'),
(125, 1, 1, -10, 9824, 9814, '2025. 04. 03. 11:19:46'),
(126, 1, 1, -10, 9814, 9804, '2025. 04. 03. 11:20:00'),
(127, 1, 1, -10, 9804, 9794, '2025. 04. 03. 11:20:05'),
(128, 1, 1, -10, 9794, 9784, '2025. 04. 03. 11:20:09'),
(129, 1, 1, -10, 9784, 9774, '2025. 04. 03. 11:20:14'),
(130, 1, 1, -10, 9774, 9764, '2025. 04. 03. 11:20:19'),
(131, 1, 1, 1000, 9764, 10764, '2025. 04. 03. 11:20:30'),
(132, 1, 1, -10, 10764, 10754, '2025. 04. 03. 11:21:29'),
(133, 1, 1, -10, 10754, 10744, '2025. 04. 03. 11:21:34'),
(134, 1, 1, -10, 10744, 10734, '2025. 04. 03. 11:21:38'),
(135, 1, 1, -10, 10734, 10724, '2025. 04. 03. 11:23:01'),
(136, 1, 1, -10, 10724, 10714, '2025. 04. 03. 11:24:22'),
(137, 1, 1, -10, 10714, 10704, '2025. 04. 03. 11:25:47'),
(138, 1, 1, -10, 10704, 10694, '2025. 04. 03. 11:26:30'),
(139, 1, 1, -10, 10694, 10684, '2025. 04. 03. 11:29:41'),
(140, 1, 1, -10, 10684, 10674, '2025. 04. 03. 11:29:46'),
(141, 1, 1, 1000, 10674, 11674, '2025. 04. 03. 11:29:49'),
(142, 1, 1, -10, 11674, 11664, '2025. 04. 03. 11:29:59'),
(143, 1, 1, -10, 11664, 11654, '2025. 04. 03. 11:30:04'),
(144, 1, 1, -10, 11654, 11644, '2025. 04. 03. 11:30:08'),
(145, 1, 1, -10, 11644, 11634, '2025. 04. 03. 11:30:13'),
(146, 1, 1, -10, 11634, 11624, '2025. 04. 03. 11:30:17'),
(147, 1, 1, -10, 11624, 11614, '2025. 04. 03. 11:30:22'),
(148, 1, 1, -10, 11614, 11604, '2025. 04. 03. 11:30:33'),
(149, 1, 1, 1000, 11604, 12604, '2025. 04. 03. 11:30:37'),
(150, 1, 1, -10, 12604, 12594, '2025. 04. 03. 11:30:38'),
(151, 1, 1, -10, 12594, 12584, '2025. 04. 03. 11:30:48'),
(152, 1, 1, -10, 12584, 12574, '2025. 04. 03. 11:31:42'),
(153, 1, 1, -10, 12574, 12564, '2025. 04. 03. 11:35:48'),
(154, 1, 1, -10, 12564, 12554, '2025. 04. 03. 11:35:53'),
(155, 1, 1, -10, 12554, 12544, '2025. 04. 03. 11:35:57'),
(156, 1, 1, -10, 12544, 12534, '2025. 04. 03. 11:36:02'),
(157, 1, 1, -10, 12534, 12524, '2025. 04. 03. 11:36:37'),
(158, 1, 1, 1500, 12524, 14024, '2025. 04. 03. 11:37:03'),
(159, 1, 1, -10, 14024, 14014, '2025. 04. 03. 11:37:04'),
(160, 1, 1, -10, 14014, 14004, '2025. 04. 03. 11:37:58'),
(161, 1, 1, -10, 14004, 13994, '2025. 04. 03. 11:38:18'),
(162, 1, 1, -10, 13994, 13984, '2025. 04. 03. 11:39:01'),
(163, 1, 1, -10, 13984, 13974, '2025. 04. 03. 11:39:06'),
(164, 1, 1, -10, 13974, 13964, '2025. 04. 03. 11:39:34'),
(165, 1, 1, -10, 13964, 13954, '2025. 04. 03. 11:40:12'),
(166, 1, 1, -10, 13954, 13944, '2025. 04. 03. 11:40:17'),
(167, 1, 1, -10, 13944, 13934, '2025. 04. 03. 11:40:21'),
(168, 1, 1, -10, 13934, 13924, '2025. 04. 03. 11:40:26'),
(169, 1, 1, -10, 13924, 13914, '2025. 04. 03. 11:40:31'),
(170, 1, 1, -10, 13914, 13904, '2025. 04. 03. 11:40:35'),
(171, 1, 1, -11, 13904, 13893, '2025. 04. 03. 11:40:39'),
(172, 1, 1, -10, 13893, 13883, '2025. 04. 03. 11:40:40'),
(173, 1, 1, -11, 13883, 13872, '2025. 04. 03. 11:40:44'),
(174, 1, 1, -10, 13872, 13862, '2025. 04. 03. 11:40:44'),
(175, 1, 1, -10, 13862, 13852, '2025. 04. 03. 11:40:49'),
(176, 1, 1, -10, 13852, 13842, '2025. 04. 03. 11:40:54'),
(177, 1, 1, -10, 13842, 13832, '2025. 04. 03. 11:40:58'),
(178, 1, 1, -10, 13832, 13822, '2025. 04. 03. 11:41:03'),
(179, 1, 1, -10, 13822, 13812, '2025. 04. 03. 11:41:08'),
(180, 1, 1, -10, 13812, 13802, '2025. 04. 03. 11:41:12'),
(181, 1, 1, -10, 13802, 13792, '2025. 04. 03. 11:41:17'),
(182, 1, 1, -10, 13792, 13782, '2025. 04. 03. 11:41:21'),
(183, 1, 1, -10, 13782, 13772, '2025. 04. 03. 11:41:26'),
(184, 1, 1, -10, 13772, 13762, '2025. 04. 03. 11:41:31'),
(185, 1, 1, -10, 13762, 13752, '2025. 04. 03. 11:41:35'),
(186, 1, 1, -10, 13752, 13742, '2025. 04. 03. 11:41:40'),
(187, 1, 1, -10, 13742, 13732, '2025. 04. 03. 11:41:45'),
(188, 1, 1, -10, 13732, 13722, '2025. 04. 03. 11:41:49'),
(189, 1, 1, -10, 13722, 13712, '2025. 04. 03. 11:41:56'),
(190, 1, 1, -10, 13712, 13702, '2025. 04. 03. 11:42:01'),
(191, 1, 1, -10, 13702, 13692, '2025. 04. 03. 11:42:06'),
(192, 1, 1, -10, 13692, 13682, '2025. 04. 03. 11:42:11');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `users`
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
  `avatar` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `users`
--

INSERT INTO `users` (`id`, `email`, `username`, `password`, `name`, `gender`, `birthdate`, `balance`, `lang`, `avatar`) VALUES
(1, 'john.doe@example.com', 'johndoe', 'Password123.', 'John Doe', 0, '1990-01-01', 15682, 'en', 1),
(2, 'jane.smith@example.com', 'janesmith', 'Password123.', 'Jane Smith', 0, '1992-02-02', 500, 'en', 1),
(3, 'bob.jones@example.com', 'bobjones', 'Password123.', 'Bob Jones', 0, '1985-03-03', 500, 'en', 1),
(4, 'alice.martin@example.com', 'alicemartin', 'Password123.', 'Alice Martin', 0, '1988-04-04', 500, 'en', 1),
(5, 'michael.brown@example.com', 'michaelbrown', 'Password123.', 'Michael Brown', 0, '1995-05-05', 500, 'en', 1),
(6, 'susan.davis@example.com', 'susandavis', 'Password123.', 'Susan Davis', 0, '1991-06-06', 500, 'en', 1),
(7, 'steve.wilson@example.com', 'stevewilson', 'Password123.', 'Steve Wilson', 0, '1987-07-07', 500, 'en', 1),
(8, 'emily.moore@example.com', 'emilymoore', 'Password123.', 'Emily Moore', 0, '1993-08-08', 500, 'en', 1),
(9, 'david.taylor@example.com', 'davidtaylor', 'Password123.', 'David Taylor', 0, '1986-09-09', 500, 'en', 1),
(10, 'laura.anderson@example.com', 'lauraanderson', 'Password123.', 'Laura Anderson', 0, '1994-10-10', 500, 'en', 1),
(11, 'james.jackson@example.com', 'jamesjackson', 'Password123.', 'James Jackson', 0, '1983-11-11', 500, 'en', 1),
(12, 'patricia.white@example.com', 'patriciawhite', 'Password123.', 'Patricia White', 0, '1996-12-12', 500, 'en', 1),
(13, 'robert.harris@example.com', 'robertharris', 'Password123.', 'Robert Harris', 0, '1991-01-13', 500, 'en', 1),
(14, 'linda.thomas@example.com', 'lindathomas', 'Password123.', 'Linda Thomas', 0, '1984-02-14', 500, 'en', 1),
(15, 'charles.martinez@example.com', 'charlesmartinez', 'Password123.', 'Charles Martinez', 0, '1992-03-15', 500, 'en', 1),
(16, 'barbara.robinson@example.com', 'barbararobinson', 'Password123.', 'Barbara Robinson', 0, '1987-04-16', 500, 'en', 1),
(17, 'joseph.clark@example.com', 'josephclark', 'Password123.', 'Joseph Clark', 0, '1990-05-17', 500, 'en', 1),
(18, 'margaret.rodriguez@example.com', 'margaretrodriguez', 'Password123.', 'Margaret Rodriguez', 0, '1993-06-18', 500, 'en', 1),
(19, 'thomas.lewis@example.com', 'thomaslewis', 'Password123.', 'Thomas Lewis', 0, '1988-07-19', 500, 'en', 1),
(20, 'sandra.lee@example.com', 'sandralee', 'Password123.', 'Sandra Lee', 0, '1985-08-20', 500, 'en', 1),
(21, 'christopher.walker@example.com', 'christopherwalker', 'Password123.', 'Christopher Walker', 0, '1994-09-21', 500, 'en', 1),
(22, 'kimberly.hall@example.com', 'kimberlyhall', 'Password123.', 'Kimberly Hall', 0, '1989-10-22', 500, 'en', 1),
(23, 'daniel.allen@example.com', 'danielallen', 'Password123.', 'Daniel Allen', 0, '1991-11-23', 500, 'en', 1),
(24, 'nancy.young@example.com', 'nancyyoung', 'Password123.', 'Nancy Young', 0, '1987-12-24', 500, 'en', 1),
(25, 'paul.king@example.com', 'paulking', 'Password123.', 'Paul King', 0, '1990-01-25', 500, 'en', 1),
(26, 'lisa.scott@example.com', 'lisascott', 'Password123.', 'Lisa Scott', 0, '1993-02-26', 500, 'en', 1),
(27, 'mark.adams@example.com', 'markadams', 'Password123.', 'Mark Adams', 0, '1988-03-27', 500, 'en', 1),
(28, 'betty.baker@example.com', 'bettybaker', 'Password123.', 'Betty Baker', 0, '1985-04-28', 500, 'en', 1),
(29, 'donald.gonzalez@example.com', 'donaldgonzalez', 'Password123.', 'Donald Gonzalez', 0, '1994-05-29', 500, 'en', 1),
(30, 'helen.nelson@example.com', 'helennelson', 'Password123.', 'Helen Nelson', 0, '1991-06-30', 500, 'en', 1),
(31, 'george.carter@example.com', 'georgecarter', 'Password123.', 'George Carter', 0, '1987-07-31', 500, 'en', 1),
(32, 'dorothy.mitchell@example.com', 'dorothymitchell', 'Password123.', 'Dorothy Mitchell', 0, '1990-08-01', 500, 'en', 1),
(33, 'kenneth.perez@example.com', 'kennethperez', 'Password123.', 'Kenneth Perez', 0, '1992-09-02', 500, 'en', 1),
(34, 'carol.roberts@example.com', 'carolroberts', 'Password123.', 'Carol Roberts', 0, '1986-10-03', 500, 'en', 1),
(35, 'edward.turner@example.com', 'edwardturner', 'Password123.', 'Edward Turner', 0, '1989-11-04', 500, 'en', 1),
(36, 'michelle.phillips@example.com', 'michellephillips', 'Password123.', 'Michelle Phillips', 0, '1991-12-05', 500, 'en', 1),
(37, 'brian.campbell@example.com', 'briancampbell', 'Password123.', 'Brian Campbell', 0, '1988-01-06', 500, 'en', 1),
(38, 'shirley.parker@example.com', 'shirleyparker', 'Password123.', 'Shirley Parker', 0, '1987-02-07', 500, 'en', 1),
(39, 'ronald.evans@example.com', 'ronaldevans', 'Password123.', 'Ronald Evans', 0, '1990-03-08', 500, 'en', 1),
(40, 'laura.edwards@example.com', 'lauraedwards', 'Password123.', 'Laura Edwards', 0, '1992-04-09', 500, 'en', 1),
(41, 'anthony.collins@example.com', 'anthonycollins', 'Password123.', 'Anthony Collins', 0, '1985-05-10', 500, 'en', 1),
(42, 'cynthia.stewart@example.com', 'cynthiastewart', 'Password123.', 'Cynthia Stewart', 0, '1993-06-11', 500, 'en', 1),
(43, 'kevin.sanchez@example.com', 'kevinsanchez', 'Password123.', 'Kevin Sanchez', 0, '1986-07-12', 500, 'en', 1),
(44, 'sharon.morris@example.com', 'sharonmorris', 'Password123.', 'Sharon Morris', 0, '1989-08-13', 500, 'en', 1),
(45, 'jeffrey.rogers@example.com', 'jeffreyrogers', 'Password123.', 'Jeffrey Rogers', 0, '1991-09-14', 500, 'en', 1),
(46, 'karen.reed@example.com', 'karenreed', 'Password123.', 'Karen Reed', 0, '1987-10-15', 500, 'en', 1),
(47, 'eric.cook@example.com', 'ericcook', 'Password123.', 'Eric Cook', 0, '1990-11-16', 500, 'en', 1),
(48, 'brenda.morgan@example.com', 'brendamorgan', 'Password123.', 'Brenda Morgan', 0, '1992-12-17', 500, 'en', 1),
(49, 'frank.bell@example.com', 'frankbell', 'Password123.', 'Frank Bell', 0, '1988-01-18', 500, 'en', 1),
(50, 'amy.cooper@example.com', 'amycooper', 'Password123.', 'Amy Cooper', 0, '1991-02-19', 500, 'en', 1),
(58, 'iskola@mail.com', 'iskolai', 'Password1234!', 'iskolai', 0, '2007-03-03', 14000, 'hu-HU', 1),
(59, 'panna@mail.com', 'panna', '1', 'Pityi Panna', 1, '2007-03-27', 4500, 'en', 1),
(64, 'eeeee@ee.ee', 'avdavd', 'Password123.', 'A A', 1, '2007-04-03', 0, 'hu-HU', 1);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `user_session`
--

CREATE TABLE `user_session` (
  `id` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `expires_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `user_session`
--

INSERT INTO `user_session` (`id`, `user_id`, `expires_at`) VALUES
('162dffa81afe5e522ab1956e45f487cbed486b055108522bc0fd4020a56ecd74', 64, '2025-05-16 04:06:56'),
('532a35e7294cf130246a309cc8d6078b6716a31ee89d60eb4dddcc0d30d40ac7', 58, '2025-05-09 21:50:03'),
('5a541c4b61e7e918d9478cbf1617378238922c3383b2c7e8e99e82a4c741168a', 58, '2025-04-29 17:51:21'),
('5a7bc5390037b0e4761965cba7ca9060e1b814fa2c8e7e5c78dd6377954d4ef5', 58, '2025-04-27 09:32:20');

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `bonus`
--
ALTER TABLE `bonus`
  ADD PRIMARY KEY (`id`),
  ADD KEY `email` (`email`);

--
-- A tábla indexei `friends`
--
ALTER TABLE `friends`
  ADD PRIMARY KEY (`id`),
  ADD KEY `friend1` (`friend1`,`friend2`);

--
-- A tábla indexei `friend_requests`
--
ALTER TABLE `friend_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `senderId` (`senderId`,`sentToId`);

--
-- A tábla indexei `game`
--
ALTER TABLE `game`
  ADD PRIMARY KEY (`gameid`);

--
-- A tábla indexei `statistics`
--
ALTER TABLE `statistics`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `user_id` (`user_id`,`gameid`);

--
-- A tábla indexei `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email_3` (`email`,`username`),
  ADD KEY `email` (`email`),
  ADD KEY `email_2` (`email`);

--
-- A tábla indexei `user_session`
--
ALTER TABLE `user_session`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `bonus`
--
ALTER TABLE `bonus`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT a táblához `friends`
--
ALTER TABLE `friends`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT a táblához `friend_requests`
--
ALTER TABLE `friend_requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT a táblához `game`
--
ALTER TABLE `game`
  MODIFY `gameid` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT a táblához `statistics`
--
ALTER TABLE `statistics`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=193;

--
-- AUTO_INCREMENT a táblához `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
