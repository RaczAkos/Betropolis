-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2025. Feb 06. 08:28
-- Kiszolgáló verziója: 10.4.28-MariaDB
-- PHP verzió: 8.1.17

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
  `email` varchar(50) NOT NULL,
  `starting_bonus` int(5) NOT NULL,
  `status` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `bonus`
--

INSERT INTO `bonus` (`email`, `starting_bonus`, `status`) VALUES
('example@example.com', 2700, 0);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `game`
--

CREATE TABLE `game` (
  `gameid` int(3) NOT NULL,
  `name` varchar(30) NOT NULL,
  `type-id` int(2) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `game`
--

INSERT INTO `game` (`gameid`, `name`, `type-id`, `description`) VALUES
(1, 'Fruit Frenzy Classic', 1, 'Spin your way to juicy rewards in Fruit Jackpot Frenzy! This vibrant slot game is packed with colorful fruit symbols, exciting bonus rounds, and thrilling multipliers. With every spin, you\'ll have the chance to hit massive jackpots while enjoying the playful, fruity theme. Whether you\'re a casual player or a high roller, the fun never stops in this fruit-filled adventure!'),
(2, 'Crash', 3, NULL),
(3, 'Find Card', 2, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `game-type`
--

CREATE TABLE `game-type` (
  `id` int(2) NOT NULL,
  `category` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `game-type`
--

INSERT INTO `game-type` (`id`, `category`) VALUES
(1, 'slot-machine'),
(2, 'card'),
(3, 'other');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `statistics`
--

CREATE TABLE `statistics` (
  `transactionid` bigint(11) NOT NULL,
  `email` varchar(50) NOT NULL,
  `gameid` int(3) NOT NULL,
  `gain` tinyint(1) NOT NULL,
  `oldbalance` bigint(11) NOT NULL,
  `amount` bigint(11) NOT NULL,
  `newbalance` bigint(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `statistics`
--

INSERT INTO `statistics` (`transactionid`, `email`, `gameid`, `gain`, `oldbalance`, `amount`, `newbalance`) VALUES
(1, 'racz.akoscsaba-2020@keri.mako.hu', 1, 1, 99999, 1, 100000);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `users`
--

CREATE TABLE `users` (
  `email` varchar(50) NOT NULL,
  `age` int(3) NOT NULL,
  `gender` char(1) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL,
  `balance` bigint(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `bonus`
--
ALTER TABLE `bonus`
  ADD PRIMARY KEY (`email`);

--
-- A tábla indexei `game`
--
ALTER TABLE `game`
  ADD PRIMARY KEY (`gameid`);

--
-- A tábla indexei `game-type`
--
ALTER TABLE `game-type`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `statistics`
--
ALTER TABLE `statistics`
  ADD PRIMARY KEY (`transactionid`),
  ADD KEY `email` (`email`,`gameid`);

--
-- A tábla indexei `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`email`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `game`
--
ALTER TABLE `game`
  MODIFY `gameid` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT a táblához `game-type`
--
ALTER TABLE `game-type`
  MODIFY `id` int(2) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT a táblához `statistics`
--
ALTER TABLE `statistics`
  MODIFY `transactionid` bigint(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
