-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Φιλοξενητής: 127.0.0.1
-- Χρόνος δημιουργίας: 19 Μάη 2022 στις 12:03:24
-- Έκδοση διακομιστή: 10.4.14-MariaDB
-- Έκδοση PHP: 7.4.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Βάση δεδομένων: `parkhubcity`
--

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `e_tickets`
--

CREATE TABLE `e_tickets` (
  `user_id` varchar(25) NOT NULL,
  `price` int(200) NOT NULL,
  `parking_id` varchar(20) NOT NULL,
  `type_vehicle` enum('car','mootorbike') NOT NULL,
  `vehicle_id` int(20) NOT NULL,
  `time` date NOT NULL,
  `type_space` int(20) NOT NULL,
  `space_name` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `gifts`
--

CREATE TABLE `gifts` (
  `gift_name` varchar(20) NOT NULL,
  `points_` int(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `one_take_customer`
--

CREATE TABLE `one_take_customer` (
  `otc_id` varchar(25) NOT NULL,
  `otc_username` varchar(25) NOT NULL,
  `vehicle_id` varchar(20) NOT NULL,
  `time` date NOT NULL,
  `otc_parking_id` varchar(25) NOT NULL,
  `parking_space` int(20) NOT NULL,
  `points` int(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `parking`
--

CREATE TABLE `parking` (
  `parking_id` varchar(25) NOT NULL,
  `address` varchar(35) NOT NULL,
  `floors` int(10) NOT NULL,
  `number_spaces` int(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `payment`
--

CREATE TABLE `payment` (
  `user_username` varchar(25) NOT NULL,
  `payment_methods` enum('cripto','PayPal','masterCard') NOT NULL,
  `price` int(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `subscriber`
--

CREATE TABLE `subscriber` (
  `id_subscriber` varchar(25) NOT NULL,
  `subscriber_username` varchar(25) NOT NULL,
  `subscriber_vehicle_id` varchar(20) NOT NULL,
  `time` date NOT NULL,
  `subscriber_parking_id` varchar(25) NOT NULL,
  `subscriber_parking_name` varchar(20) NOT NULL,
  `parking_space` int(20) NOT NULL,
  `points` int(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `user`
--

CREATE TABLE `user` (
  `id` varchar(25) NOT NULL,
  `username` varchar(25) NOT NULL,
  `surname` varchar(25) NOT NULL,
  `name` varchar(20) NOT NULL,
  `password` int(20) NOT NULL,
  `email` varchar(25) NOT NULL,
  `vehicle_id` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `vehicle`
--

CREATE TABLE `vehicle` (
  `vehicle_id` varchar(20) NOT NULL,
  `type_vehicle` enum('car','motorbike') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Ευρετήρια για άχρηστους πίνακες
--

--
-- Ευρετήρια για πίνακα `e_tickets`
--
ALTER TABLE `e_tickets`
  ADD KEY `user_id` (`user_id`,`parking_id`,`type_vehicle`);

--
-- Ευρετήρια για πίνακα `one_take_customer`
--
ALTER TABLE `one_take_customer`
  ADD KEY `otc_id` (`otc_id`,`otc_username`,`vehicle_id`,`otc_parking_id`),
  ADD KEY `vehicle_id` (`vehicle_id`),
  ADD KEY `otc_parking_id` (`otc_parking_id`);

--
-- Ευρετήρια για πίνακα `parking`
--
ALTER TABLE `parking`
  ADD PRIMARY KEY (`parking_id`);

--
-- Ευρετήρια για πίνακα `payment`
--
ALTER TABLE `payment`
  ADD KEY `user_username` (`user_username`);

--
-- Ευρετήρια για πίνακα `subscriber`
--
ALTER TABLE `subscriber`
  ADD KEY `id_subscriber` (`id_subscriber`,`subscriber_username`,`subscriber_vehicle_id`,`subscriber_parking_id`);

--
-- Ευρετήρια για πίνακα `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`,`username`),
  ADD KEY `vehicle_id` (`vehicle_id`);

--
-- Ευρετήρια για πίνακα `vehicle`
--
ALTER TABLE `vehicle`
  ADD PRIMARY KEY (`vehicle_id`,`type_vehicle`);

--
-- Περιορισμοί για άχρηστους πίνακες
--

--
-- Περιορισμοί για πίνακα `e_tickets`
--
ALTER TABLE `e_tickets`
  ADD CONSTRAINT `e_tickets_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE;

--
-- Περιορισμοί για πίνακα `one_take_customer`
--
ALTER TABLE `one_take_customer`
  ADD CONSTRAINT `one_take_customer_ibfk_1` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicle` (`vehicle_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `one_take_customer_ibfk_2` FOREIGN KEY (`otc_parking_id`) REFERENCES `parking` (`parking_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `one_take_customer_ibfk_3` FOREIGN KEY (`otc_id`) REFERENCES `user` (`id`) ON DELETE CASCADE;

--
-- Περιορισμοί για πίνακα `subscriber`
--
ALTER TABLE `subscriber`
  ADD CONSTRAINT `subscriber_ibfk_1` FOREIGN KEY (`id_subscriber`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `subscriber_ibfk_2` FOREIGN KEY (`subscriber_parking_id`) REFERENCES `parking` (`parking_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `subscriber_ibfk_3` FOREIGN KEY (`subscriber_vehicle_id`) REFERENCES `vehicle` (`vehicle_id`) ON DELETE CASCADE;
COMMIT;
--
-- Inserts για user
--INSERT INTO user (id,username,surname,name,password,email,vehicle_id)
VALUES('001','NikolakisN','Nikolaou','Nikos','1234567a','nikosnik@hotmail.com','AXN125'),
('002','ElenakiG','Georgiou','Eleni','1234567b','elenigeo@gmail.com','ABZ347'),
('003','Bioagg','Bill','Aggelopoulos','pousairebio','bioagg@gmail.com','BKP869'),
('004','Tsampikos','Alexis','Tsampas','tsabahmanas','alextsp@gmail.com','EMT346');


/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
