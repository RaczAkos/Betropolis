-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2025. Jan 07. 11:55
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
-- Tábla szerkezet ehhez a táblához `game`
--

CREATE TABLE `game` (
  `gameid` int(3) NOT NULL,
  `name` varchar(30) NOT NULL,
  `type` varchar(20) NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `game`
--

INSERT INTO `game` (`gameid`, `name`, `type`, `description`) VALUES
(1, 'Fruit Jackpot Frenzy', 'slot', 'Spin your way to juicy rewards in Fruit Jackpot Frenzy! This vibrant slot game is packed with colorful fruit symbols, exciting bonus rounds, and thrilling multipliers. With every spin, you\'ll have the chance to hit massive jackpots while enjoying the playful, fruity theme. Whether you\'re a casual player or a high roller, the fun never stops in this fruit-filled adventure!');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `transactions`
--

CREATE TABLE `transactions` (
  `transactionid` bigint(11) NOT NULL,
  `email` varchar(50) NOT NULL,
  `gameid` int(3) NOT NULL,
  `gain` tinyint(1) NOT NULL,
  `oldbalance` bigint(11) NOT NULL,
  `amount` bigint(11) NOT NULL,
  `newbalance` bigint(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `transactions`
--

INSERT INTO `transactions` (`transactionid`, `email`, `gameid`, `gain`, `oldbalance`, `amount`, `newbalance`) VALUES
(1, 'racz.akoscsaba-2020@keri.mako.hu', 1, 1, 99999, 1, 100000);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `user`
--

CREATE TABLE `user` (
  `email` varchar(50) NOT NULL,
  `firstname` varchar(20) NOT NULL,
  `lastname` varchar(20) NOT NULL,
  `age` int(3) NOT NULL,
  `gender` char(1) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL,
  `balance` bigint(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `user`
--

INSERT INTO `user` (`email`, `firstname`, `lastname`, `age`, `gender`, `username`, `password`, `balance`) VALUES
('racz.akoscsaba-2020@keri.mako.', 'Akos', 'Racz', 19, 'M', 'Zsakosakiraj', 'admin', 99999),
('racz.akoscsaba-2020@keri.mako.hu', 'Akos', 'Racz', 19, 'M', 'Zsakosakiraj', 'admin', 99999);

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `game`
--
ALTER TABLE `game`
  ADD PRIMARY KEY (`gameid`);

--
-- A tábla indexei `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`transactionid`),
  ADD KEY `email` (`email`,`gameid`);

--
-- A tábla indexei `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`email`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `transactions`
--
ALTER TABLE `transactions`
  MODIFY `transactionid` bigint(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
