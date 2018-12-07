-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Dec 06, 2018 at 10:27 PM
-- Server version: 5.7.23
-- PHP Version: 7.2.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `wideworldimporters`
--

DELIMITER $$
--
	-- Functions
	--
CREATE DEFINER=`root`@`localhost` FUNCTION `soundex_match` (`needle` VARCHAR(128), `haystack` TEXT, `splitChar` VARCHAR(1)) RETURNS TINYINT(4) BEGIN
	declare spacePos int;
	declare searchLen int default 0;
	declare curWord varchar(128) default '';
	declare tempStr text default haystack;
	declare tmp text default '';
	declare soundx1 varchar(64) default '';
	declare soundx2 varchar(64) default '';

	set searchLen = length(haystack);
	set spacePos  = locate(splitChar, tempStr);
	set soundx1   = soundex(needle);

	while searchLen > 0 do
	if spacePos = 0 then
		set tmp = tempStr;
		select soundex(tmp) into soundx2;
		if soundx1 = soundx2 then
			return 1;
		else
			return 0;
		end if;
	else
		set tmp = substr(tempStr, 1, spacePos-1);
		set soundx2 = soundex(tmp);
		if soundx1 = soundx2 then
			return 1;
		end if;

		set tempStr = substr(tempStr, spacePos+1);
		set searchLen = length(tempStr);
	end if;

	set spacePos = locate(splitChar, tempStr);
	end while;

	return 0;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `soundex_match_all` (`needle` VARCHAR(255), `haystack` TEXT, `splitChar` VARCHAR(1)) RETURNS TINYINT(4) BEGIN
	/* find the first instance of the splitting character */
	DECLARE comma  INT  DEFAULT 0;
	DECLARE word   TEXT;

	SET comma = LOCATE(splitChar, needle);
	SET word = TRIM(needle);

	if LENGTH(haystack) = 0 then
		return 0;
	elseif comma = 0 then
		/* one word search term */
		return soundex_match(word, haystack, splitChar);
	end if;

	SET word = trim(substr(needle, 1, comma));

	/* Insert each split variable into the word variable */
	REPEAT
		if soundex_match(word, haystack, splitChar) = 0 then
			return 0;
		end if;

		/* get the next word */
		SET needle = trim(substr(needle, comma));
		SET comma  = LOCATE(splitChar, needle);
		if comma = 0 then
			/* last word */
			return soundex_match(needle, haystack, splitChar);
		end if;

		SET word = trim(substr(needle, 1, comma));
	UNTIL length(word) = 0
		END REPEAT;

	return 0;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `colors`
--

CREATE TABLE `colors` (
	`ColorID` int(11) NOT NULL,
	`ColorName` varchar(20) NOT NULL,
	`LastEditedBy` int(11) NOT NULL,
	`ValidFrom` datetime NOT NULL,
	`ValidTo` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `colors`
--

INSERT INTO `colors` (`ColorID`, `ColorName`, `LastEditedBy`, `ValidFrom`, `ValidTo`) VALUES
(1, 'Azure', 1, '2013-01-01 00:00:00', '9999-12-31 23:59:59'),
(2, 'Beige', 1, '2013-01-01 00:00:00', '9999-12-31 23:59:59'),
(3, 'Black', 1, '2013-01-01 00:00:00', '9999-12-31 23:59:59'),
(4, 'Blue', 1, '2013-01-01 00:00:00', '9999-12-31 23:59:59'),
(5, 'Charcoal', 1, '2013-01-01 00:00:00', '9999-12-31 23:59:59'),
(6, 'Chartreuse', 1, '2013-01-01 00:00:00', '9999-12-31 23:59:59'),
(7, 'Cyan', 1, '2013-01-01 00:00:00', '9999-12-31 23:59:59'),
(8, 'Dark Brown', 1, '2013-01-01 00:00:00', '9999-12-31 23:59:59'),
(9, 'Dark Green', 1, '2013-01-01 00:00:00', '9999-12-31 23:59:59'),
(10, 'Fuchsia', 1, '2013-01-01 00:00:00', '9999-12-31 23:59:59'),
(11, 'Gold', 1, '2013-01-01 00:00:00', '9999-12-31 23:59:59'),
(12, 'Steel Gray', 9, '2016-01-01 16:00:00', '9999-12-31 23:59:59'),
(13, 'Hot Pink', 1, '2013-01-01 00:00:00', '9999-12-31 23:59:59'),
(14, 'Indigo', 1, '2013-01-01 00:00:00', '9999-12-31 23:59:59'),
(15, 'Ivory', 1, '2013-01-01 00:00:00', '9999-12-31 23:59:59'),
(16, 'Khaki', 1, '2013-01-01 00:00:00', '9999-12-31 23:59:59'),
(17, 'Lavender', 1, '2013-01-01 00:00:00', '9999-12-31 23:59:59'),
(18, 'Light Brown', 1, '2013-01-01 00:00:00', '9999-12-31 23:59:59'),
(19, 'Light Green', 1, '2013-01-01 00:00:00', '9999-12-31 23:59:59'),
(20, 'Maroon', 1, '2013-01-01 00:00:00', '9999-12-31 23:59:59'),
(21, 'Mauve', 1, '2013-01-01 00:00:00', '9999-12-31 23:59:59'),
(22, 'Navy Blue', 1, '2013-01-01 00:00:00', '9999-12-31 23:59:59'),
(23, 'Olive', 1, '2013-01-01 00:00:00', '9999-12-31 23:59:59'),
(24, 'Orange', 1, '2013-01-01 00:00:00', '9999-12-31 23:59:59'),
(25, 'Plum', 1, '2013-01-01 00:00:00', '9999-12-31 23:59:59'),
(26, 'Puce', 1, '2013-01-01 00:00:00', '9999-12-31 23:59:59'),
(27, 'Purple', 1, '2013-01-01 00:00:00', '9999-12-31 23:59:59'),
(28, 'Red', 1, '2013-01-01 00:00:00', '9999-12-31 23:59:59'),
(29, 'Royal Blue', 1, '2013-01-01 00:00:00', '9999-12-31 23:59:59'),
(30, 'Salmon', 1, '2013-01-01 00:00:00', '9999-12-31 23:59:59'),
(31, 'Silver', 1, '2013-01-01 00:00:00', '9999-12-31 23:59:59'),
(32, 'Tan', 1, '2013-01-01 00:00:00', '9999-12-31 23:59:59'),
(33, 'Teal', 1, '2013-01-01 00:00:00', '9999-12-31 23:59:59'),
(34, 'Wheat', 1, '2013-01-01 00:00:00', '9999-12-31 23:59:59'),
(35, 'White', 1, '2013-01-01 00:00:00', '9999-12-31 23:59:59'),
(36, 'Yellow', 1, '2013-01-01 00:00:00', '9999-12-31 23:59:59');

-- --------------------------------------------------------

--
-- Table structure for table `invoicelines`
--

CREATE TABLE `invoicelines` (
	`InvoiceLineID` int(11) NOT NULL,
	`InvoiceID` int(11) NOT NULL,
	`StockItemID` int(11) NOT NULL,
	`Description` varchar(100) NOT NULL,
	`Quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `invoicelines`
--

INSERT INTO `invoicelines` (`InvoiceLineID`, `InvoiceID`, `StockItemID`, `Description`, `Quantity`) VALUES
(1, 1, 67, 'Ride on toy sedan car (Black) 1/12 scale', 10),
(2, 2, 50, 'Developer joke mug - old C developers never die (White)', 9),
(3, 2, 10, 'USB food flash drive - chocolate bar', 9),
(4, 3, 114, 'Superhero action jacket (Blue) XXL', 3),
(5, 4, 206, 'Permanent marker black 5mm nib (Black) 5mm', 96),
(6, 4, 130, 'Furry gorilla with big eyes slippers (Black) S', 5),
(7, 4, 50, 'Developer joke mug - old C developers never die (White)', 2),
(8, 5, 128, 'Plush shark slippers (Gray) L', 4),
(9, 5, 121, 'Dinosaur battery-powered slippers (Green) XL', 3),
(10, 5, 155, 'Large sized bubblewrap roll 50m', 20),
(11, 6, 150, 'Pack of 12 action figures (variety)', 4),
(12, 6, 40, 'Developer joke mug - (hip, hip, array) (White)', 6),
(13, 6, 126, 'Plush shark slippers (Gray) S', 9),
(14, 7, 39, 'Developer joke mug - inheritance is the OO way to become wealthy (Black)', 9),
(15, 7, 184, 'Shipping carton (Brown) 305x305x305mm', 75),
(16, 7, 9, 'USB food flash drive - banana', 6),
(17, 7, 132, 'Furry gorilla with big eyes slippers (Black) L', 1),
(18, 8, 9, 'USB food flash drive - banana', 4),
(19, 8, 32, 'Developer joke mug - that\'s a hardware problem (White)', 9),
(20, 8, 50, 'Developer joke mug - old C developers never die (White)', 1),
(21, 9, 58, 'RC toy sedan car with remote control (Black) 1/50 scale', 2),
(22, 9, 134, 'Animal with big feet slippers (Brown) S', 4),
(23, 10, 38, 'Developer joke mug - inheritance is the OO way to become wealthy (White)', 5),
(24, 10, 34, 'Developer joke mug - fun was unexpected at this time (White)', 3),
(25, 11, 45, 'Developer joke mug - there are 10 types of people in the world (Black)', 1),
(26, 12, 62, 'RC toy sedan car with remote control (Yellow) 1/50 scale', 5),
(27, 12, 44, 'Developer joke mug - there are 10 types of people in the world (White)', 8),
(28, 13, 156, '10 mm Double sided bubble wrap 10m', 10),
(29, 13, 73, 'Ride on vintage American toy coupe (Red) 1/12 scale', 8),
(30, 14, 111, 'Superhero action jacket (Blue) M', 4),
(31, 14, 163, '32 mm Double sided bubble wrap 20m', 10),
(32, 14, 132, 'Furry gorilla with big eyes slippers (Black) L', 5),
(33, 15, 108, 'Superhero action jacket (Blue) XXS', 6),
(34, 15, 210, 'Packing knife with metal insert blade (Yellow) 18mm', 10),
(35, 16, 115, 'Superhero action jacket (Blue) 3XL', 2),
(36, 17, 133, 'Furry gorilla with big eyes slippers (Black) XL', 10),
(37, 17, 47, 'Developer joke mug - a foo walks into a bar (Black)', 8),
(38, 18, 22, 'DBA joke mug - it depends (White)', 7),
(39, 19, 15, 'USB food flash drive - dessert 10 drive variety pack', 8),
(40, 19, 75, 'Ride on big wheel monster truck (Black) 1/12 scale', 1),
(41, 19, 68, 'Ride on toy sedan car (Red) 1/12 scale', 4),
(42, 20, 111, 'Superhero action jacket (Blue) M', 8),
(43, 21, 144, 'Halloween zombie mask (Light Brown) L', 24),
(44, 21, 121, 'Dinosaur battery-powered slippers (Green) XL', 2),
(45, 21, 54, 'IT joke mug - that behavior is by design (White)', 3),
(46, 22, 128, 'Plush shark slippers (Gray) L', 1),
(47, 22, 158, '10 mm Double sided bubble wrap 50m', 30),
(48, 23, 21, 'DBA joke mug - you might be a DBA if (Black)', 4),
(49, 23, 69, 'Ride on toy sedan car (Blue) 1/12 scale', 5),
(50, 23, 137, 'Animal with big feet slippers (Brown) XL', 9),
(51, 24, 70, 'Ride on toy sedan car (Green) 1/12 scale', 2),
(52, 24, 210, 'Packing knife with metal insert blade (Yellow) 18mm', 5),
(53, 25, 35, 'Developer joke mug - fun was unexpected at this time (Black)', 5),
(54, 25, 14, 'USB food flash drive - fortune cookie', 2),
(55, 26, 42, 'Developer joke mug - understanding recursion requires understanding recursion (White)', 1),
(56, 27, 121, 'Dinosaur battery-powered slippers (Green) XL', 9),
(57, 27, 48, 'Developer joke mug - this code was generated by a tool (White)', 1),
(58, 28, 147, 'Halloween skull mask (Gray) M', 12),
(59, 28, 33, 'Developer joke mug - that\'s a hardware problem (Black)', 4),
(60, 28, 170, '20 mm Anti static bubble wrap (Blue) 50m', 40),
(61, 29, 125, 'Ogre battery-powered slippers (Green) XL', 4),
(62, 29, 104, 'Alien officer hoodie (Black) 3XL', 7),
(63, 30, 60, 'RC toy sedan car with remote control (Blue) 1/50 scale', 4),
(64, 31, 44, 'Developer joke mug - there are 10 types of people in the world (White)', 5),
(65, 31, 213, 'Air cushion film 200mmx100mm 325m', 7),
(66, 31, 61, 'RC toy sedan car with remote control (Green) 1/50 scale', 3),
(67, 32, 66, 'RC big wheel monster truck with remote control (Black) 1/50 scale', 8),
(68, 32, 63, 'RC toy sedan car with remote control (Pink) 1/50 scale', 4),
(69, 32, 125, 'Ogre battery-powered slippers (Green) XL', 10),
(70, 33, 207, 'Permanent marker blue 5mm nib (Blue) 5mm', 12),
(71, 34, 168, '20 mm Anti static bubble wrap (Blue) 10m', 10),
(72, 34, 123, 'Ogre battery-powered slippers (Green) M', 9),
(73, 34, 2, 'USB rocket launcher (Gray)', 8),
(74, 34, 27, 'DBA joke mug - SELECT caffeine FROM mug (Black)', 1),
(75, 34, 5, 'USB food flash drive - hamburger', 1),
(76, 35, 60, 'RC toy sedan car with remote control (Blue) 1/50 scale', 8),
(77, 36, 133, 'Furry gorilla with big eyes slippers (Black) XL', 1),
(78, 36, 35, 'Developer joke mug - fun was unexpected at this time (Black)', 10),
(79, 36, 134, 'Animal with big feet slippers (Brown) S', 4),
(80, 36, 120, 'Dinosaur battery-powered slippers (Green) L', 6),
(81, 37, 35, 'Developer joke mug - fun was unexpected at this time (Black)', 10),
(82, 38, 57, 'IT joke mug - hardware: part of the computer that can be kicked (Black)', 2),
(83, 39, 51, 'Developer joke mug - old C developers never die (Black)', 7),
(84, 39, 43, 'Developer joke mug - understanding recursion requires understanding recursion (Black)', 3),
(85, 39, 15, 'USB food flash drive - dessert 10 drive variety pack', 1),
(86, 40, 66, 'RC big wheel monster truck with remote control (Black) 1/50 scale', 8),
(87, 40, 120, 'Dinosaur battery-powered slippers (Green) L', 9),
(88, 41, 112, 'Superhero action jacket (Blue) L', 3),
(89, 41, 214, 'Air cushion film 200mmx200mm 325m', 2),
(90, 42, 115, 'Superhero action jacket (Blue) 3XL', 6),
(91, 42, 40, 'Developer joke mug - (hip, hip, array) (White)', 10),
(92, 42, 162, '32 mm Double sided bubble wrap 10m', 100),
(93, 43, 94, '\"The Gu\" red shirt XML tag t-shirt (Black) L', 24),
(94, 43, 110, 'Superhero action jacket (Blue) S', 2),
(95, 44, 71, 'Ride on toy sedan car (Yellow) 1/12 scale', 10),
(96, 44, 182, 'Shipping carton (Brown) 457x279x279mm', 200),
(97, 45, 164, '32 mm Double sided bubble wrap 50m', 50),
(98, 46, 89, '\"The Gu\" red shirt XML tag t-shirt (Black) 3XS', 72),
(99, 46, 171, '32 mm Anti static bubble wrap (Blue) 10m', 90),
(100, 47, 167, '10 mm Anti static bubble wrap (Blue) 50m', 50),
(101, 47, 219, 'Void fill 400 L bag (White) 400L', 80),
(102, 47, 72, 'Ride on toy sedan car (Pink) 1/12 scale', 9),
(103, 48, 100, '\"The Gu\" red shirt XML tag t-shirt (Black) 6XL', 72),
(104, 48, 151, 'Pack of 12 action figures (male)', 8),
(105, 49, 156, '10 mm Double sided bubble wrap 10m', 100),
(106, 50, 209, 'Packing knife with metal insert blade (Yellow) 9mm', 45),
(107, 51, 95, '\"The Gu\" red shirt XML tag t-shirt (Black) XL', 24),
(108, 52, 195, 'Black and orange handle with care despatch tape  48mmx75m', 72),
(109, 53, 146, 'Halloween skull mask (Gray) S', 48),
(110, 53, 76, '\"The Gu\" red shirt XML tag t-shirt (White) 3XS', 84),
(111, 53, 99, '\"The Gu\" red shirt XML tag t-shirt (Black) 5XL', 24),
(112, 53, 170, '20 mm Anti static bubble wrap (Blue) 50m', 90),
(113, 54, 181, 'Shipping carton (Brown) 356x229x229mm', 75),
(114, 55, 94, '\"The Gu\" red shirt XML tag t-shirt (Black) L', 84),
(115, 55, 200, 'Black and yellow heavy despatch tape 48mmx100m', 96),
(116, 55, 99, '\"The Gu\" red shirt XML tag t-shirt (Black) 5XL', 84),
(117, 56, 81, '\"The Gu\" red shirt XML tag t-shirt (White) L', 84),
(118, 56, 100, '\"The Gu\" red shirt XML tag t-shirt (Black) 6XL', 96),
(119, 57, 64, 'RC vintage American toy coupe with remote control (Red) 1/50 scale', 6),
(120, 58, 41, 'Developer joke mug - (hip, hip, array) (Black)', 10),
(121, 58, 54, 'IT joke mug - that behavior is by design (White)', 9),
(122, 58, 168, '20 mm Anti static bubble wrap (Blue) 10m', 50),
(123, 59, 191, 'Black and orange fragile despatch tape 48mmx75m', 288),
(124, 59, 88, '\"The Gu\" red shirt XML tag t-shirt (White) 7XL', 108),
(125, 59, 167, '10 mm Anti static bubble wrap (Blue) 50m', 60),
(126, 60, 165, '10 mm Anti static bubble wrap (Blue) 10m', 70),
(127, 60, 50, 'Developer joke mug - old C developers never die (White)', 9),
(128, 61, 7, 'USB food flash drive - pizza slice', 2),
(129, 62, 194, 'Black and orange glass with care despatch tape  48mmx100m', 168),
(130, 63, 92, '\"The Gu\" red shirt XML tag t-shirt (Black) S', 72),
(131, 64, 84, '\"The Gu\" red shirt XML tag t-shirt (White) 3XL', 36),
(132, 65, 198, 'Black and orange this way up despatch tape  48mmx100m', 72),
(133, 65, 202, 'Red and white urgent  heavy despatch tape  48mmx100m', 96),
(134, 65, 99, '\"The Gu\" red shirt XML tag t-shirt (Black) 5XL', 48),
(135, 65, 197, 'Black and orange this way up despatch tape 48mmx75m', 96),
(136, 66, 163, '32 mm Double sided bubble wrap 20m', 50),
(137, 67, 167, '10 mm Anti static bubble wrap (Blue) 50m', 50),
(138, 68, 85, '\"The Gu\" red shirt XML tag t-shirt (White) 4XL', 48),
(139, 69, 138, 'Furry animal socks (Pink) S', 120),
(140, 70, 191, 'Black and orange fragile despatch tape 48mmx75m', 144),
(141, 70, 55, 'IT joke mug - that behavior is by design (Black)', 3),
(142, 71, 109, 'Superhero action jacket (Blue) XS', 7),
(143, 71, 18, 'DBA joke mug - daaaaaa-ta (White)', 7),
(144, 72, 210, 'Packing knife with metal insert blade (Yellow) 18mm', 45),
(145, 72, 197, 'Black and orange this way up despatch tape 48mmx75m', 96),
(146, 73, 162, '32 mm Double sided bubble wrap 10m', 40),
(147, 73, 141, 'Furry animal socks (Pink) XL', 108),
(148, 74, 183, 'Shipping carton (Brown) 480x270x320mm', 100),
(149, 75, 147, 'Halloween skull mask (Gray) M', 60),
(150, 76, 170, '20 mm Anti static bubble wrap (Blue) 50m', 30),
(151, 76, 172, '32 mm Anti static bubble wrap (Blue) 20m', 70),
(152, 77, 172, '32 mm Anti static bubble wrap (Blue) 20m', 90),
(153, 77, 148, 'Halloween skull mask (Gray) L', 36),
(154, 78, 165, '10 mm Anti static bubble wrap (Blue) 10m', 40),
(155, 78, 80, '\"The Gu\" red shirt XML tag t-shirt (White) M', 12),
(156, 78, 166, '10 mm Anti static bubble wrap (Blue) 20m', 90),
(157, 79, 138, 'Furry animal socks (Pink) S', 84),
(158, 80, 214, 'Air cushion film 200mmx200mm 325m', 10),
(159, 80, 36, 'Developer joke mug - when your hammer is C++ (White)', 6),
(160, 80, 118, 'Dinosaur battery-powered slippers (Green) S', 5),
(161, 81, 120, 'Dinosaur battery-powered slippers (Green) L', 8),
(162, 81, 112, 'Superhero action jacket (Blue) L', 4),
(163, 82, 30, 'Developer joke mug - Oct 31 = Dec 25 (White)', 9),
(164, 82, 46, 'Developer joke mug - a foo walks into a bar (White)', 9),
(165, 83, 172, '32 mm Anti static bubble wrap (Blue) 20m', 100),
(166, 83, 148, 'Halloween skull mask (Gray) L', 72),
(167, 83, 28, 'DBA joke mug - two types of DBAs (White)', 2),
(168, 83, 194, 'Black and orange glass with care despatch tape  48mmx100m', 24),
(169, 84, 130, 'Furry gorilla with big eyes slippers (Black) S', 8),
(170, 84, 22, 'DBA joke mug - it depends (White)', 4),
(171, 85, 23, 'DBA joke mug - it depends (Black)', 9),
(172, 85, 200, 'Black and yellow heavy despatch tape 48mmx100m', 144),
(173, 86, 145, 'Halloween zombie mask (Light Brown) XL', 72),
(174, 86, 60, 'RC toy sedan car with remote control (Blue) 1/50 scale', 6),
(175, 87, 148, 'Halloween skull mask (Gray) L', 84),
(176, 87, 126, 'Plush shark slippers (Gray) S', 10),
(177, 88, 208, 'Permanent marker red 5mm nib (Red) 5mm', 36),
(178, 88, 23, 'DBA joke mug - it depends (Black)', 9),
(179, 88, 71, 'Ride on toy sedan car (Yellow) 1/12 scale', 4),
(180, 89, 129, 'Plush shark slippers (Gray) XL', 6),
(181, 89, 58, 'RC toy sedan car with remote control (Black) 1/50 scale', 10),
(182, 89, 33, 'Developer joke mug - that\'s a hardware problem (Black)', 10),
(183, 90, 92, '\"The Gu\" red shirt XML tag t-shirt (Black) S', 60),
(184, 90, 50, 'Developer joke mug - old C developers never die (White)', 4),
(185, 90, 184, 'Shipping carton (Brown) 305x305x305mm', 75),
(186, 90, 128, 'Plush shark slippers (Gray) L', 4),
(187, 91, 118, 'Dinosaur battery-powered slippers (Green) S', 1),
(188, 91, 88, '\"The Gu\" red shirt XML tag t-shirt (White) 7XL', 108),
(189, 91, 63, 'RC toy sedan car with remote control (Pink) 1/50 scale', 8),
(190, 92, 36, 'Developer joke mug - when your hammer is C++ (White)', 4),
(191, 92, 29, 'DBA joke mug - two types of DBAs (Black)', 4),
(192, 93, 33, 'Developer joke mug - that\'s a hardware problem (Black)', 8),
(193, 93, 121, 'Dinosaur battery-powered slippers (Green) XL', 7),
(194, 93, 128, 'Plush shark slippers (Gray) L', 8),
(195, 94, 23, 'DBA joke mug - it depends (Black)', 10),
(196, 94, 142, 'Halloween zombie mask (Light Brown) S', 12),
(197, 95, 55, 'IT joke mug - that behavior is by design (Black)', 5),
(198, 95, 191, 'Black and orange fragile despatch tape 48mmx75m', 252),
(199, 95, 16, 'DBA joke mug - mind if I join you? (White)', 1),
(200, 95, 117, 'Superhero action jacket (Blue) 5XL', 7);

-- --------------------------------------------------------

--
-- Table structure for table `invoices`
--

CREATE TABLE `invoices` (
	`InvoiceID` int(11) NOT NULL,
	`CustomerID` int(11) NOT NULL,
	`BillToCustomerID` int(11) NOT NULL,
	`InvoiceDate` date NOT NULL,
	`CustomerPurchaseOrderNumber` varchar(20) DEFAULT NULL,
	`TotalDryItems` int(11) NOT NULL,
	`TotalChillerItems` int(11) DEFAULT NULL,
	`ConfirmedDeliveryTime` datetime DEFAULT NULL,
	`ConfirmedReceivedBy` varchar(4000) DEFAULT NULL,
	`LastEditedWhen` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `invoices`
--

INSERT INTO `invoices` (`InvoiceID`, `CustomerID`, `BillToCustomerID`, `InvoiceDate`, `CustomerPurchaseOrderNumber`, `TotalDryItems`, `TotalChillerItems`, `ConfirmedDeliveryTime`, `ConfirmedReceivedBy`, `LastEditedWhen`) VALUES
(1, 832, 832, '2013-01-01', '12126', 1, 0, '2013-01-02 07:05:00', 'Aakriti Byrraju', '2013-01-02 07:00:00'),
(2, 803, 803, '2013-01-01', '15342', 2, 0, '2013-01-02 07:10:00', 'Bala Dixit', '2013-01-02 07:00:00'),
(3, 105, 1, '2013-01-01', '12211', 1, 0, '2013-01-02 07:15:00', 'Sung-Hwan Hwang', '2013-01-02 07:00:00'),
(4, 57, 1, '2013-01-01', '17129', 3, 0, '2013-01-02 07:20:00', 'Aile Mae', '2013-01-02 07:00:00'),
(5, 905, 905, '2013-01-01', '10369', 3, 0, '2013-01-02 07:25:00', 'Sara Huiting', '2013-01-02 07:00:00'),
(6, 976, 976, '2013-01-01', '13383', 3, 0, '2013-01-02 07:30:00', 'Alinne Matos', '2013-01-02 07:00:00'),
(7, 575, 401, '2013-01-01', '17913', 4, 0, '2013-01-02 07:35:00', 'Dattaatraeya Tottempudi', '2013-01-02 07:00:00'),
(8, 964, 964, '2013-01-01', '14518', 3, 0, '2013-01-02 07:40:00', 'Ingrida Zeltina', '2013-01-02 07:00:00'),
(9, 77, 1, '2013-01-01', '17577', 2, 0, '2013-01-02 07:45:00', 'Airi Vassiljev', '2013-01-02 07:00:00'),
(10, 191, 1, '2013-01-01', '18030', 2, 0, '2013-01-02 07:50:00', 'Ester Ahmadian', '2013-01-02 07:00:00'),
(11, 586, 401, '2013-01-01', '17639', 1, 0, '2013-01-02 07:55:00', 'Anete Kundzina', '2013-01-02 07:00:00'),
(12, 529, 401, '2013-01-01', '10941', 2, 0, '2013-01-02 08:00:00', 'Seo-yeon Rim', '2013-01-02 07:00:00'),
(13, 473, 401, '2013-01-01', '16374', 2, 0, '2013-01-02 08:05:00', 'Doru Munteanu', '2013-01-02 07:00:00'),
(14, 870, 870, '2013-01-01', '17521', 3, 0, '2013-01-02 08:10:00', 'In-Su Bae', '2013-01-02 07:00:00'),
(15, 991, 991, '2013-01-01', '11911', 2, 0, '2013-01-02 08:15:00', 'Valter Viiding', '2013-01-02 07:00:00'),
(16, 414, 401, '2013-01-01', '10690', 1, 0, '2013-01-02 08:20:00', 'Lan Chu', '2013-01-02 07:00:00'),
(17, 910, 910, '2013-01-01', '10255', 2, 0, '2013-01-02 08:25:00', 'Elina Kaleja', '2013-01-02 07:00:00'),
(18, 949, 949, '2013-01-01', '16825', 1, 0, '2013-01-02 08:30:00', 'Seo-yun Paik', '2013-01-02 07:00:00'),
(19, 973, 973, '2013-01-01', '12227', 3, 0, '2013-01-02 08:35:00', 'Kumar Kamei', '2013-01-02 07:00:00'),
(20, 884, 884, '2013-01-01', '16793', 1, 0, '2013-01-02 08:40:00', 'Anindya Ghatak', '2013-01-02 07:00:00'),
(21, 173, 1, '2013-01-01', '12467', 3, 0, '2013-01-02 08:45:00', 'Raju Atluri', '2013-01-02 07:00:00'),
(22, 890, 890, '2013-01-01', '13700', 2, 0, '2013-01-02 08:50:00', 'Olya Izmaylov', '2013-01-02 07:00:00'),
(23, 189, 1, '2013-01-01', '11503', 3, 0, '2013-01-02 08:55:00', 'Sara Charlton', '2013-01-02 07:00:00'),
(24, 873, 873, '2013-01-01', '13916', 2, 0, '2013-01-02 09:00:00', 'Hana Hlouskova', '2013-01-02 07:00:00'),
(25, 497, 401, '2013-01-01', '17783', 2, 0, '2013-01-02 09:05:00', 'Vitezslav Holy', '2013-01-02 07:00:00'),
(26, 484, 401, '2013-01-01', '13042', 1, 0, '2013-01-02 09:10:00', 'Am Lo', '2013-01-02 07:00:00'),
(27, 89, 1, '2013-01-01', '10411', 2, 0, '2013-01-02 09:15:00', 'Aakarsha Nookala', '2013-01-02 07:00:00'),
(28, 148, 1, '2013-01-01', '15084', 3, 0, '2013-01-02 09:20:00', 'Marcella Napolitani', '2013-01-02 07:00:00'),
(29, 972, 972, '2013-01-01', '11389', 2, 0, '2013-01-02 09:25:00', 'Lakshmi Benipal', '2013-01-02 07:00:00'),
(30, 567, 401, '2013-01-01', '12559', 1, 0, '2013-01-02 09:30:00', 'Severins Polis', '2013-01-02 07:00:00'),
(31, 92, 1, '2013-01-01', '19457', 3, 0, '2013-01-02 09:35:00', 'Coralie Emond', '2013-01-02 07:00:00'),
(32, 811, 811, '2013-01-01', '18468', 3, 0, '2013-01-02 09:40:00', 'Surendra Sahu', '2013-01-02 07:00:00'),
(33, 10, 1, '2013-01-01', '14486', 1, 0, '2013-01-02 09:45:00', 'Siddhartha Parkar', '2013-01-02 07:00:00'),
(34, 862, 862, '2013-01-01', '19057', 5, 0, '2013-01-02 09:50:00', 'Lana Goransson', '2013-01-02 07:00:00'),
(35, 431, 401, '2013-01-01', '18036', 1, 0, '2013-01-02 09:55:00', 'Selma Seppanen', '2013-01-02 07:00:00'),
(36, 908, 908, '2013-01-01', '13079', 4, 0, '2013-01-02 10:00:00', 'Sumati Bhat', '2013-01-02 07:00:00'),
(37, 995, 995, '2013-01-01', '19402', 1, 0, '2013-01-02 10:05:00', 'Kumar Naicker', '2013-01-02 07:00:00'),
(38, 910, 910, '2013-01-01', '15267', 1, 0, '2013-01-02 10:10:00', 'Elina Kaleja', '2013-01-02 07:00:00'),
(39, 545, 401, '2013-01-01', '12781', 3, 0, '2013-01-02 10:15:00', 'Mina Bagheri', '2013-01-02 07:00:00'),
(40, 1000, 1000, '2013-01-01', '17334', 2, 0, '2013-01-02 10:20:00', 'Krishnam Allu', '2013-01-02 07:00:00'),
(41, 415, 401, '2013-01-01', '16645', 2, 0, '2013-01-02 10:25:00', 'Maurice English', '2013-01-02 07:00:00'),
(42, 423, 401, '2013-01-02', '13260', 3, 0, '2013-01-03 07:05:00', 'Aamdaal Kamasamudram', '2013-01-03 07:00:00'),
(43, 463, 401, '2013-01-02', '16070', 2, 0, '2013-01-03 07:10:00', 'Daedeepya Thota', '2013-01-03 07:00:00'),
(44, 467, 401, '2013-01-02', '14159', 2, 0, '2013-01-03 07:15:00', 'Pongrit Srisati', '2013-01-03 07:00:00'),
(45, 832, 832, '2013-01-02', '12126', 1, 0, '2013-01-03 07:20:00', 'Aakriti Byrraju', '2013-01-03 07:00:00'),
(46, 803, 803, '2013-01-02', '15342', 2, 0, '2013-01-03 07:25:00', 'Bala Dixit', '2013-01-03 07:00:00'),
(47, 105, 1, '2013-01-02', '12211', 3, 0, '2013-01-03 07:30:00', 'Sung-Hwan Hwang', '2013-01-03 07:00:00'),
(48, 905, 905, '2013-01-02', '10369', 2, 0, '2013-01-03 07:35:00', 'Sara Huiting', '2013-01-03 07:00:00'),
(49, 575, 401, '2013-01-02', '17913', 1, 0, '2013-01-03 07:40:00', 'Dattaatraeya Tottempudi', '2013-01-03 07:00:00'),
(50, 964, 964, '2013-01-02', '14518', 1, 0, '2013-01-03 07:45:00', 'Ingrida Zeltina', '2013-01-03 07:00:00'),
(51, 77, 1, '2013-01-02', '17577', 1, 0, '2013-01-03 07:50:00', 'Airi Vassiljev', '2013-01-03 07:00:00'),
(52, 191, 1, '2013-01-02', '18030', 1, 0, '2013-01-03 07:55:00', 'Ester Ahmadian', '2013-01-03 07:00:00'),
(53, 586, 401, '2013-01-02', '17639', 4, 0, '2013-01-03 08:00:00', 'Anete Kundzina', '2013-01-03 07:00:00'),
(54, 529, 401, '2013-01-02', '10941', 1, 0, '2013-01-03 08:05:00', 'Seo-yeon Rim', '2013-01-03 07:00:00'),
(55, 473, 401, '2013-01-02', '16374', 3, 0, '2013-01-03 08:10:00', 'Doru Munteanu', '2013-01-03 07:00:00'),
(56, 870, 870, '2013-01-02', '17521', 2, 0, '2013-01-03 08:15:00', 'In-Su Bae', '2013-01-03 07:00:00'),
(57, 414, 401, '2013-01-02', '10690', 1, 0, '2013-01-03 08:20:00', 'Lan Chu', '2013-01-03 07:00:00'),
(58, 910, 910, '2013-01-02', '10255', 3, 0, '2013-01-03 08:25:00', 'Elina Kaleja', '2013-01-03 07:00:00'),
(59, 949, 949, '2013-01-02', '16825', 3, 0, '2013-01-03 08:30:00', 'Seo-yun Paik', '2013-01-03 07:00:00'),
(60, 973, 973, '2013-01-02', '12227', 2, 0, '2013-01-03 08:35:00', 'Kumar Kamei', '2013-01-03 07:00:00'),
(61, 884, 884, '2013-01-02', '16793', 1, 0, '2013-01-03 08:40:00', 'Anindya Ghatak', '2013-01-03 07:00:00'),
(62, 173, 1, '2013-01-02', '12467', 1, 0, '2013-01-03 08:45:00', 'Raju Atluri', '2013-01-03 07:00:00'),
(63, 189, 1, '2013-01-02', '11503', 1, 0, '2013-01-03 08:50:00', 'Sara Charlton', '2013-01-03 07:00:00'),
(64, 497, 401, '2013-01-02', '17783', 1, 0, '2013-01-03 08:55:00', 'Vitezslav Holy', '2013-01-03 07:00:00'),
(65, 484, 401, '2013-01-02', '13042', 4, 0, '2013-01-03 09:00:00', 'Am Lo', '2013-01-03 07:00:00'),
(66, 89, 1, '2013-01-02', '10411', 1, 0, '2013-01-03 09:05:00', 'Aakarsha Nookala', '2013-01-03 07:00:00'),
(67, 148, 1, '2013-01-02', '15084', 1, 0, '2013-01-03 09:10:00', 'Marcella Napolitani', '2013-01-03 07:00:00'),
(68, 972, 972, '2013-01-02', '11389', 1, 0, '2013-01-03 09:15:00', 'Lakshmi Benipal', '2013-01-03 07:00:00'),
(69, 567, 401, '2013-01-02', '12559', 1, 0, '2013-01-03 09:20:00', 'Severins Polis', '2013-01-03 07:00:00'),
(70, 92, 1, '2013-01-02', '19457', 2, 0, '2013-01-03 09:25:00', 'Coralie Emond', '2013-01-03 07:00:00'),
(71, 811, 811, '2013-01-02', '18468', 2, 0, '2013-01-03 09:30:00', 'Surendra Sahu', '2013-01-03 07:00:00'),
(72, 10, 1, '2013-01-02', '14486', 2, 0, '2013-01-03 09:35:00', 'Siddhartha Parkar', '2013-01-03 07:00:00'),
(73, 431, 401, '2013-01-02', '18036', 2, 0, '2013-01-03 09:40:00', 'Selma Seppanen', '2013-01-03 07:00:00'),
(74, 908, 908, '2013-01-02', '13079', 1, 0, '2013-01-03 09:45:00', 'Sumati Bhat', '2013-01-03 07:00:00'),
(75, 995, 995, '2013-01-02', '19402', 1, 0, '2013-01-03 09:50:00', 'Kumar Naicker', '2013-01-03 07:00:00'),
(76, 910, 910, '2013-01-02', '15267', 2, 0, '2013-01-03 09:55:00', 'Elina Kaleja', '2013-01-03 07:00:00'),
(77, 545, 401, '2013-01-02', '12781', 2, 0, '2013-01-03 10:00:00', 'Mina Bagheri', '2013-01-03 07:00:00'),
(78, 1000, 1000, '2013-01-02', '17334', 3, 0, '2013-01-03 10:05:00', 'Krishnam Allu', '2013-01-03 07:00:00'),
(79, 415, 401, '2013-01-02', '16645', 1, 0, '2013-01-03 10:10:00', 'Maurice English', '2013-01-03 07:00:00'),
(80, 543, 401, '2013-01-02', '17591', 3, 0, '2013-01-03 10:15:00', 'Abhaya Rambhatla', '2013-01-03 07:00:00'),
(81, 456, 401, '2013-01-02', '14618', 2, 0, '2013-01-03 10:20:00', 'Subhash Matondkar', '2013-01-03 07:00:00'),
(82, 487, 401, '2013-01-02', '19857', 2, 0, '2013-01-03 10:25:00', 'Jan Zeman', '2013-01-03 07:00:00'),
(83, 154, 1, '2013-01-02', '17849', 4, 0, '2013-01-03 10:30:00', 'Gui-Hyun Ji', '2013-01-03 07:00:00'),
(84, 111, 1, '2013-01-02', '10947', 2, 0, '2013-01-03 10:35:00', 'Adam Dvorak', '2013-01-03 07:00:00'),
(85, 585, 401, '2013-01-02', '11610', 2, 0, '2013-01-03 10:40:00', 'Asha Mudigonda', '2013-01-03 07:00:00'),
(86, 128, 1, '2013-01-02', '14853', 2, 0, '2013-01-03 10:45:00', 'Jure Grabensek', '2013-01-03 07:00:00'),
(87, 473, 401, '2013-01-02', '10821', 2, 0, '2013-01-03 10:50:00', 'Doru Munteanu', '2013-01-03 07:00:00'),
(88, 58, 1, '2013-01-02', '15491', 3, 0, '2013-01-03 10:55:00', 'Pratap Varghese', '2013-01-03 07:00:00'),
(89, 586, 401, '2013-01-02', '14474', 3, 0, '2013-01-03 11:00:00', 'Anete Kundzina', '2013-01-03 07:00:00'),
(90, 910, 910, '2013-01-02', '10079', 4, 0, '2013-01-03 11:05:00', 'Elina Kaleja', '2013-01-03 07:00:00'),
(91, 82, 1, '2013-01-02', '11612', 3, 0, '2013-01-03 11:10:00', 'Rakesh Nishad', '2013-01-03 07:00:00'),
(92, 3, 1, '2013-01-02', '11991', 2, 0, '2013-01-03 11:15:00', 'Bhaargav Rambhatla', '2013-01-03 07:00:00'),
(93, 857, 857, '2013-01-02', '19321', 3, 0, '2013-01-03 11:20:00', 'Clarissa Manfrin', '2013-01-03 07:00:00'),
(94, 453, 401, '2013-01-02', '10210', 2, 0, '2013-01-03 11:25:00', 'Bryan Helms', '2013-01-03 07:00:00'),
(95, 457, 401, '2013-01-02', '14970', 5, 0, '2013-01-03 11:30:00', 'Eesvaraavu Ankitham', '2013-01-03 07:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `packagetypes`
--

CREATE TABLE `packagetypes` (
	`PackageTypeID` int(11) NOT NULL,
	`PackageTypeName` varchar(50) NOT NULL,
	`LastEditedBy` int(11) NOT NULL,
	`ValidFrom` datetime NOT NULL,
	`ValidTo` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `packagetypes`
--

INSERT INTO `packagetypes` (`PackageTypeID`, `PackageTypeName`, `LastEditedBy`, `ValidFrom`, `ValidTo`) VALUES
(1, 'Bag', 1, '2013-01-01 00:00:00', '9999-12-31 23:59:59'),
(2, 'Block', 1, '2013-01-01 00:00:00', '9999-12-31 23:59:59'),
(3, 'Bottle', 1, '2013-01-01 00:00:00', '9999-12-31 23:59:59'),
(4, 'Box', 1, '2013-01-01 00:00:00', '9999-12-31 23:59:59'),
(5, 'Can', 1, '2013-01-01 00:00:00', '9999-12-31 23:59:59'),
(6, 'Carton', 1, '2013-01-01 00:00:00', '9999-12-31 23:59:59'),
(7, 'Each', 1, '2013-01-01 00:00:00', '9999-12-31 23:59:59'),
(8, 'Kg', 1, '2013-01-01 00:00:00', '9999-12-31 23:59:59'),
(9, 'Packet', 1, '2013-01-01 00:00:00', '9999-12-31 23:59:59'),
(10, 'Pair', 1, '2013-01-01 00:00:00', '9999-12-31 23:59:59'),
(11, 'Pallet', 1, '2013-01-01 00:00:00', '9999-12-31 23:59:59'),
(12, 'Tray', 1, '2013-01-01 00:00:00', '9999-12-31 23:59:59'),
(13, 'Tub ', 1, '2013-01-01 00:00:00', '9999-12-31 23:59:59'),
(14, 'Tube', 1, '2013-01-01 00:00:00', '9999-12-31 23:59:59');

-- --------------------------------------------------------

--
-- Table structure for table `specialdeals`
--

CREATE TABLE `specialdeals` (
	`SpecialDealID` int(11) NOT NULL,
	`StockItemID` int(11) DEFAULT NULL,
	`CustomerID` int(11) DEFAULT NULL,
	`BuyingGroupID` int(11) DEFAULT NULL,
	`CustomerCategoryID` int(11) DEFAULT NULL,
	`StockGroupID` int(11) DEFAULT NULL,
	`DealDescription` varchar(30) NOT NULL,
	`StartDate` date NOT NULL,
	`EndDate` date NOT NULL,
	`DiscountAmount` decimal(18,2) DEFAULT NULL,
	`DiscountPercentage` decimal(18,3) DEFAULT NULL,
	`UnitPrice` decimal(18,2) DEFAULT NULL,
	`LastEditedBy` int(11) NOT NULL,
	`LastEditedWhen` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `specialdeals`
--

INSERT INTO `specialdeals` (`SpecialDealID`, `StockItemID`, `CustomerID`, `BuyingGroupID`, `CustomerCategoryID`, `StockGroupID`, `DealDescription`, `StartDate`, `EndDate`, `DiscountAmount`, `DiscountPercentage`, `UnitPrice`, `LastEditedBy`, `LastEditedWhen`) VALUES
(1, 0, 0, 2, 0, 7, '10% 1st qtr USB Wingtip', '2016-01-01', '2016-03-31', '0.00', '10.000', '0.00', 2, '2015-12-31 16:00:00'),
(2, 0, 0, 1, 0, 7, '15% 2nd qtr USB Tailspin', '2016-04-01', '2016-06-30', '0.00', '15.000', '0.00', 2, '2015-12-31 16:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `stockgroups`
--

CREATE TABLE `stockgroups` (
	`StockGroupID` int(11) NOT NULL,
	`StockGroupName` varchar(50) NOT NULL,
	`LastEditedBy` int(11) NOT NULL,
	`ValidFrom` datetime NOT NULL,
	`ValidTo` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `stockgroups`
--

INSERT INTO `stockgroups` (`StockGroupID`, `StockGroupName`, `LastEditedBy`, `ValidFrom`, `ValidTo`) VALUES
(1, 'Novelty Items', 1, '2013-01-01 00:00:00', '9999-12-31 23:59:59'),
(2, 'Clothing', 1, '2013-01-01 00:00:00', '9999-12-31 23:59:59'),
(3, 'Mugs', 1, '2013-01-01 00:00:00', '9999-12-31 23:59:59'),
(4, 'T-Shirts', 1, '2013-01-01 00:00:00', '9999-12-31 23:59:59'),
(5, 'Airline Novelties', 1, '2013-01-01 00:00:00', '9999-12-31 23:59:59'),
(6, 'Computing Novelties', 1, '2013-01-01 00:00:00', '9999-12-31 23:59:59'),
(7, 'USB Novelties', 1, '2013-01-01 00:00:00', '9999-12-31 23:59:59'),
(8, 'Furry Footwear', 9, '2016-01-01 16:00:00', '9999-12-31 23:59:59'),
(9, 'Toys', 1, '2013-01-01 00:00:00', '9999-12-31 23:59:59'),
(10, 'Packaging Materials', 1, '2013-01-01 00:00:00', '9999-12-31 23:59:59');

-- --------------------------------------------------------

--
-- Table structure for table `stockitemholdings`
--

CREATE TABLE `stockitemholdings` (
	`StockItemID` int(11) NOT NULL,
	`QuantityOnHand` int(11) NOT NULL,
	`BinLocation` varchar(20) NOT NULL,
	`LastStocktakeQuantity` int(11) NOT NULL,
	`LastCostPrice` decimal(18,2) NOT NULL,
	`ReorderLevel` int(11) NOT NULL,
	`TargetStockLevel` int(11) NOT NULL,
	`LastEditedBy` int(11) NOT NULL,
	`LastEditedWhen` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `stockitemholdings`
--

INSERT INTO `stockitemholdings` (`StockItemID`, `QuantityOnHand`, `BinLocation`, `LastStocktakeQuantity`, `LastCostPrice`, `ReorderLevel`, `TargetStockLevel`, `LastEditedBy`, `LastEditedWhen`) VALUES
(1, 175609, 'L-1', 171341, '9.50', 20, 100, 16, '2016-05-31 07:00:00'),
(2, 165538, 'L-1', 161435, '9.50', 20, 100, 3, '2016-05-31 12:00:00'),
(3, 253190, 'L-2', 246900, '11.25', 10, 120, 3, '2016-05-31 12:00:00'),
(4, 208109, 'L-3', 202964, '12.00', 5, 100, 3, '2016-05-31 12:00:00'),
(5, 199064, 'L-3', 194162, '12.00', 5, 100, 3, '2016-05-31 12:00:00'),
(6, 196995, 'L-3', 192127, '12.00', 5, 100, 3, '2016-05-31 12:00:00'),
(7, 205295, 'L-3', 200201, '12.00', 5, 100, 16, '2016-05-31 07:00:00'),
(8, 412277, 'L-3', 401980, '88.50', 10, 200, 16, '2016-05-31 07:00:00'),
(9, 192749, 'L-3', 187968, '12.00', 5, 100, 3, '2016-05-31 12:00:00'),
(10, 222572, 'L-3', 217048, '12.00', 5, 100, 3, '2016-05-31 12:00:00'),
(11, 203148, 'L-3', 198084, '12.00', 5, 100, 3, '2016-05-31 12:00:00'),
(12, 200406, 'L-3', 195396, '12.00', 5, 100, 3, '2016-05-31 12:00:00'),
(13, 197453, 'L-3', 192553, '12.00', 5, 100, 3, '2016-05-31 12:00:00'),
(14, 192358, 'L-3', 187553, '12.00', 5, 100, 3, '2016-05-31 12:00:00'),
(15, 398290, 'L-3', 388445, '88.50', 10, 200, 16, '2016-05-31 07:00:00'),
(16, 51836, 'K-9', 50541, '4.50', 15, 40, 16, '2016-05-31 07:00:00'),
(17, 62428, 'K-9', 60923, '4.50', 15, 40, 3, '2016-05-31 12:00:00'),
(18, 89207, 'K-9', 86985, '4.50', 15, 40, 16, '2016-05-31 07:00:00'),
(19, 68800, 'K-9', 67153, '4.50', 15, 40, 3, '2016-05-31 12:00:00'),
(20, 66722, 'K-9', 65070, '4.50', 15, 40, 3, '2016-05-31 12:00:00'),
(21, 68683, 'K-9', 67023, '4.50', 15, 40, 3, '2016-05-31 12:00:00'),
(22, 72747, 'K-9', 70913, '4.50', 15, 40, 16, '2016-05-31 07:00:00'),
(23, 56283, 'K-9', 54910, '4.50', 15, 40, 3, '2016-05-31 12:00:00'),
(24, 57083, 'K-9', 55653, '4.50', 15, 40, 3, '2016-05-31 12:00:00'),
(25, 47106, 'K-9', 45926, '4.50', 15, 40, 3, '2016-05-31 12:00:00'),
(26, 61071, 'K-9', 59557, '4.50', 15, 40, 3, '2016-05-31 12:00:00'),
(27, 47747, 'K-9', 46561, '4.50', 15, 40, 16, '2016-05-31 07:00:00'),
(28, 53851, 'K-9', 52451, '4.50', 15, 40, 3, '2016-05-31 12:00:00'),
(29, 80978, 'K-9', 78955, '4.50', 15, 40, 16, '2016-05-31 07:00:00'),
(30, 49248, 'K-9', 48000, '4.50', 15, 40, 3, '2016-05-31 12:00:00'),
(31, 79604, 'K-9', 77666, '4.50', 15, 40, 3, '2016-05-31 12:00:00'),
(32, 47512, 'K-9', 46276, '4.50', 15, 40, 3, '2016-05-31 12:00:00'),
(33, 60005, 'K-9', 58527, '4.50', 15, 40, 3, '2016-05-31 12:00:00'),
(34, 65583, 'K-9', 63953, '4.50', 15, 40, 3, '2016-05-31 12:00:00'),
(35, 75803, 'K-9', 74021, '4.50', 15, 40, 3, '2016-05-31 12:00:00'),
(36, 49459, 'K-9', 48215, '4.50', 15, 40, 16, '2016-05-31 07:00:00'),
(37, 61318, 'K-9', 59755, '4.50', 15, 40, 16, '2016-05-31 07:00:00'),
(38, 58431, 'K-9', 57002, '4.50', 15, 40, 16, '2016-05-31 07:00:00'),
(39, 66353, 'K-9', 64705, '4.50', 15, 40, 3, '2016-05-31 12:00:00'),
(40, 82969, 'K-9', 80939, '4.50', 15, 40, 3, '2016-05-31 12:00:00'),
(41, 79138, 'K-9', 77229, '4.50', 15, 40, 16, '2016-05-31 07:00:00'),
(42, 61075, 'K-9', 59525, '4.50', 15, 40, 3, '2016-05-31 12:00:00'),
(43, 59174, 'K-9', 57721, '4.50', 15, 40, 3, '2016-05-31 12:00:00'),
(44, 76861, 'K-9', 74947, '4.50', 15, 40, 16, '2016-05-31 07:00:00'),
(45, 54430, 'K-9', 53140, '4.50', 15, 40, 3, '2016-05-31 12:00:00'),
(46, 85243, 'K-9', 83222, '4.50', 15, 40, 3, '2016-05-31 12:00:00'),
(47, 57652, 'K-9', 56273, '4.50', 15, 40, 3, '2016-05-31 12:00:00'),
(48, 65779, 'K-9', 64176, '4.50', 15, 40, 3, '2016-05-31 12:00:00'),
(49, 51545, 'K-9', 50253, '4.50', 15, 40, 3, '2016-05-31 12:00:00'),
(50, 81085, 'K-9', 79076, '4.50', 15, 40, 16, '2016-05-31 07:00:00'),
(51, 47656, 'K-9', 46445, '4.50', 15, 40, 3, '2016-05-31 12:00:00'),
(52, 51289, 'K-9', 49996, '4.50', 15, 40, 3, '2016-05-31 12:00:00'),
(53, 58061, 'K-9', 56601, '4.50', 15, 40, 3, '2016-05-31 12:00:00'),
(54, 95786, 'K-9', 93497, '4.50', 15, 40, 16, '2016-05-31 07:00:00'),
(55, 83130, 'K-9', 81127, '4.50', 15, 40, 16, '2016-05-31 07:00:00'),
(56, 59403, 'K-9', 57960, '4.50', 15, 40, 3, '2016-05-31 12:00:00'),
(57, 72743, 'K-9', 70989, '4.50', 15, 40, 3, '2016-05-31 12:00:00'),
(58, 174043, 'J-12', 169781, '12.50', 20, 100, 3, '2016-05-31 12:00:00'),
(59, 190946, 'J-12', 186270, '12.50', 20, 100, 3, '2016-05-31 12:00:00'),
(60, 165484, 'J-12', 161392, '12.50', 20, 100, 3, '2016-05-31 12:00:00'),
(61, 163823, 'J-12', 159729, '12.50', 20, 100, 3, '2016-05-31 12:00:00'),
(62, 180856, 'J-12', 176339, '12.50', 20, 100, 3, '2016-05-31 12:00:00'),
(63, 190886, 'J-12', 186159, '12.50', 20, 100, 3, '2016-05-31 12:00:00'),
(64, 213248, 'J-12', 208012, '15.00', 20, 100, 16, '2016-05-31 07:00:00'),
(65, 164183, 'J-12', 160108, '15.00', 20, 100, 16, '2016-05-31 07:00:00'),
(66, 172525, 'J-12', 168159, '15.50', 20, 100, 3, '2016-05-31 12:00:00'),
(67, 93588, 'J-13', 91282, '145.00', 10, 50, 3, '2016-05-31 12:00:00'),
(68, 90953, 'J-13', 88735, '145.00', 10, 50, 3, '2016-05-31 12:00:00'),
(69, 96791, 'J-13', 94441, '145.00', 10, 50, 3, '2016-05-31 12:00:00'),
(70, 83287, 'J-13', 81218, '145.00', 10, 50, 16, '2016-05-31 07:00:00'),
(71, 112020, 'J-13', 109296, '145.00', 10, 50, 16, '2016-05-31 07:00:00'),
(72, 116147, 'J-13', 113273, '145.00', 10, 50, 16, '2016-05-31 07:00:00'),
(73, 106477, 'J-13', 103789, '155.00', 10, 50, 3, '2016-05-31 12:00:00'),
(74, 80341, 'J-13', 78368, '155.00', 10, 50, 3, '2016-05-31 12:00:00'),
(75, 80823, 'J-14', 78776, '205.00', 10, 50, 3, '2016-05-31 12:00:00'),
(76, 129929, 'K-1', 127169, '7.00', 5, 20, 3, '2016-05-31 12:00:00'),
(77, 27, 'K-1', 15, '7.00', 5, 20, 16, '2016-05-31 07:00:00'),
(78, 16, 'K-1', 28, '7.00', 5, 20, 3, '2016-05-31 12:00:00'),
(79, 24895, 'K-1', 24871, '7.00', 5, 20, 16, '2016-05-31 07:00:00'),
(80, 20, 'K-1', 8, '7.00', 5, 20, 3, '2016-05-31 12:00:00'),
(81, 106773, 'K-1', 103977, '7.00', 5, 20, 3, '2016-05-31 12:00:00'),
(82, 6706, 'K-1', 7254, '7.50', 5, 20, 3, '2016-05-31 12:00:00'),
(83, 224185, 'K-1', 218581, '7.50', 5, 20, 3, '2016-05-31 12:00:00'),
(84, 5439, 'K-1', 5871, '8.00', 5, 20, 16, '2016-05-31 07:00:00'),
(85, 56210, 'K-1', 54554, '8.00', 5, 20, 16, '2016-05-31 07:00:00'),
(86, 3, 'K-1', 15, '8.00', 5, 20, 3, '2016-05-31 12:00:00'),
(87, 53392, 'K-1', 52048, '8.00', 5, 20, 3, '2016-05-31 12:00:00'),
(88, 148350, 'K-1', 145218, '8.50', 5, 20, 3, '2016-05-31 12:00:00'),
(89, 81703, 'K-2', 79687, '7.00', 5, 20, 3, '2016-05-31 12:00:00'),
(90, 75663, 'K-2', 74523, '7.00', 5, 20, 3, '2016-05-31 12:00:00'),
(91, 76373, 'K-2', 75125, '7.00', 5, 20, 3, '2016-05-31 12:00:00'),
(92, 82253, 'K-2', 79805, '7.00', 5, 20, 3, '2016-05-31 12:00:00'),
(93, 277914, 'K-2', 271398, '7.00', 5, 20, 16, '2016-05-31 07:00:00'),
(94, 157255, 'K-2', 153163, '7.00', 5, 20, 3, '2016-05-31 12:00:00'),
(95, 48, 'K-2', 12, '7.50', 5, 20, 16, '2016-05-31 07:00:00'),
(96, 402445, 'K-2', 392305, '7.50', 5, 20, 3, '2016-05-31 12:00:00'),
(97, 525771, 'K-2', 512667, '8.00', 5, 20, 3, '2016-05-31 12:00:00'),
(98, 25, 'K-2', 1, '8.00', 5, 20, 16, '2016-05-31 07:00:00'),
(99, 282132, 'K-2', 275232, '8.00', 5, 20, 3, '2016-05-31 12:00:00'),
(100, 277863, 'K-2', 270723, '8.00', 5, 20, 16, '2016-05-31 07:00:00'),
(101, 51036, 'K-2', 50232, '8.50', 5, 20, 16, '2016-05-31 07:00:00'),
(102, 6702, 'K-3', 6584, '17.00', 5, 10, 3, '2016-05-31 12:00:00'),
(103, 13020, 'K-3', 12699, '17.00', 5, 10, 16, '2016-05-31 07:00:00'),
(104, 14596, 'K-3', 14233, '17.00', 5, 10, 16, '2016-05-31 07:00:00'),
(105, 23213, 'K-3', 22601, '17.00', 5, 10, 16, '2016-05-31 07:00:00'),
(106, 10874, 'K-3', 10628, '17.00', 5, 10, 3, '2016-05-31 12:00:00'),
(107, 10843, 'K-4', 10568, '19.00', 5, 10, 16, '2016-05-31 07:00:00'),
(108, 6342, 'K-4', 6229, '19.00', 5, 10, 3, '2016-05-31 12:00:00'),
(109, 27052, 'K-4', 26392, '19.00', 5, 10, 3, '2016-05-31 12:00:00'),
(110, 19426, 'K-4', 19004, '19.00', 5, 10, 3, '2016-05-31 12:00:00'),
(111, 8498, 'K-4', 8304, '22.00', 5, 10, 3, '2016-05-31 12:00:00'),
(112, 11076, 'K-4', 10807, '22.00', 5, 10, 3, '2016-05-31 12:00:00'),
(113, 7057, 'K-4', 6865, '22.00', 5, 10, 3, '2016-05-31 12:00:00'),
(114, 6971, 'K-4', 6763, '22.00', 5, 10, 16, '2016-05-31 07:00:00'),
(115, 16909, 'K-4', 16517, '24.00', 5, 10, 3, '2016-05-31 12:00:00'),
(116, 10988, 'K-4', 10689, '24.00', 5, 10, 3, '2016-05-31 12:00:00'),
(117, 14824, 'K-4', 14434, '24.00', 5, 10, 3, '2016-05-31 12:00:00'),
(118, 58218, 'K-5', 56838, '8.00', 10, 30, 3, '2016-05-31 12:00:00'),
(119, 49638, 'K-5', 48459, '8.00', 10, 30, 16, '2016-05-31 07:00:00'),
(120, 68104, 'K-5', 66446, '8.00', 10, 30, 3, '2016-05-31 12:00:00'),
(121, 39597, 'K-5', 38679, '8.50', 10, 30, 3, '2016-05-31 12:00:00'),
(122, 38905, 'K-5', 37924, '8.00', 10, 30, 3, '2016-05-31 12:00:00'),
(123, 45839, 'K-5', 44709, '8.00', 10, 30, 3, '2016-05-31 12:00:00'),
(124, 40953, 'K-5', 39935, '8.00', 10, 30, 3, '2016-05-31 12:00:00'),
(125, 39732, 'K-5', 38726, '8.50', 10, 30, 3, '2016-05-31 12:00:00'),
(126, 44071, 'K-5', 43012, '8.00', 10, 30, 3, '2016-05-31 12:00:00'),
(127, 41393, 'K-5', 40386, '8.00', 10, 30, 3, '2016-05-31 12:00:00'),
(128, 64026, 'K-5', 62435, '8.00', 10, 30, 3, '2016-05-31 12:00:00'),
(129, 49855, 'K-5', 48640, '8.50', 10, 30, 3, '2016-05-31 12:00:00'),
(130, 60311, 'K-5', 58828, '8.00', 10, 30, 3, '2016-05-31 12:00:00'),
(131, 37392, 'K-5', 36517, '8.00', 10, 30, 3, '2016-05-31 12:00:00'),
(132, 43436, 'K-5', 42372, '8.00', 10, 30, 3, '2016-05-31 12:00:00'),
(133, 56220, 'K-5', 54892, '8.50', 10, 30, 3, '2016-05-31 12:00:00'),
(134, 41994, 'K-5', 40941, '8.00', 10, 30, 16, '2016-05-31 07:00:00'),
(135, 37481, 'K-5', 36567, '8.00', 10, 30, 16, '2016-05-31 07:00:00'),
(136, 39284, 'K-5', 38336, '8.00', 10, 30, 16, '2016-05-31 07:00:00'),
(137, 45624, 'K-5', 44519, '8.50', 10, 30, 3, '2016-05-31 12:00:00'),
(138, 501745, 'K-6', 489469, '1.50', 20, 100, 3, '2016-05-31 12:00:00'),
(139, 126418, 'K-6', 123058, '1.50', 20, 100, 3, '2016-05-31 12:00:00'),
(140, 570360, 'K-6', 556908, '1.50', 20, 100, 3, '2016-05-31 12:00:00'),
(141, 328315, 'K-6', 320227, '1.50', 20, 100, 3, '2016-05-31 12:00:00'),
(142, 323812, 'K-7', 316168, '19.00', 12, 150, 3, '2016-05-31 12:00:00'),
(143, 378187, 'K-7', 368623, '19.00', 12, 150, 16, '2016-05-31 07:00:00'),
(144, 379166, 'K-7', 369698, '19.00', 12, 150, 3, '2016-05-31 12:00:00'),
(145, 248519, 'K-7', 242015, '19.00', 12, 150, 16, '2016-05-31 07:00:00'),
(146, 327221, 'K-7', 319481, '15.00', 12, 150, 3, '2016-05-31 12:00:00'),
(147, 354456, 'K-7', 345708, '15.00', 12, 150, 16, '2016-05-31 07:00:00'),
(148, 274041, 'K-7', 267057, '15.00', 12, 150, 3, '2016-05-31 12:00:00'),
(149, 229551, 'K-7', 223599, '15.00', 12, 150, 3, '2016-05-31 12:00:00'),
(150, 31743, 'K-8', 30952, '5.50', 5, 20, 3, '2016-05-31 12:00:00'),
(151, 37881, 'K-8', 36962, '5.50', 5, 20, 3, '2016-05-31 12:00:00'),
(152, 31300, 'K-8', 30489, '5.50', 5, 20, 16, '2016-05-31 07:00:00'),
(153, 168635, 'D-1', 164905, '2.20', 20, 50, 16, '2016-05-31 07:00:00'),
(154, 105320, 'D-1', 103270, '10.00', 20, 50, 16, '2016-05-31 07:00:00'),
(155, 440171, 'D-1', 428681, '13.00', 20, 50, 3, '2016-05-31 12:00:00'),
(156, 172675, 'D-1', 168195, '7.50', 20, 50, 3, '2016-05-31 12:00:00'),
(157, 46925, 'D-1', 46155, '14.00', 20, 50, 3, '2016-05-31 12:00:00'),
(158, 26193, 'D-1', 25703, '56.00', 20, 50, 3, '2016-05-31 12:00:00'),
(159, 48746, 'D-1', 47736, '8.00', 20, 50, 16, '2016-05-31 07:00:00'),
(160, 250461, 'D-1', 244121, '15.00', 20, 50, 3, '2016-05-31 12:00:00'),
(161, 188962, 'D-1', 184422, '16.00', 20, 50, 3, '2016-05-31 12:00:00'),
(162, 269785, 'D-1', 263455, '9.90', 20, 50, 3, '2016-05-31 12:00:00'),
(163, 108019, 'D-1', 105389, '14.00', 20, 50, 3, '2016-05-31 12:00:00'),
(164, 68906, 'D-1', 67356, '59.00', 20, 50, 3, '2016-05-31 12:00:00'),
(165, 187313, 'D-1', 182723, '17.00', 20, 50, 16, '2016-05-31 07:00:00'),
(166, 149668, 'D-1', 146308, '23.00', 20, 50, 3, '2016-05-31 12:00:00'),
(167, 308519, 'D-1', 301429, '45.00', 20, 50, 16, '2016-05-31 07:00:00'),
(168, 112946, 'D-1', 109736, '12.00', 20, 50, 16, '2016-05-31 07:00:00'),
(169, 68707, 'D-1', 67267, '21.00', 20, 50, 3, '2016-05-31 12:00:00'),
(170, 274265, 'D-1', 267845, '55.00', 20, 50, 3, '2016-05-31 12:00:00'),
(171, 128136, 'D-1', 125016, '16.00', 20, 50, 16, '2016-05-31 07:00:00'),
(172, 291347, 'D-1', 284067, '23.00', 20, 50, 3, '2016-05-31 12:00:00'),
(173, 103958, 'D-1', 101188, '47.00', 20, 50, 16, '2016-05-31 07:00:00'),
(174, 8879, 'D-2', 8702, '110.00', 2, 3, 3, '2016-05-31 12:00:00'),
(175, 15106, 'D-2', 14697, '110.00', 2, 3, 3, '2016-05-31 12:00:00'),
(176, 41251, 'D-2', 40230, '110.00', 2, 3, 3, '2016-05-31 12:00:00'),
(177, 58292, 'D-3', 57592, '0.55', 50, 100, 3, '2016-05-31 12:00:00'),
(178, 117043, 'D-3', 114368, '1.10', 50, 100, 16, '2016-05-31 07:00:00'),
(179, 214030, 'D-3', 209130, '0.55', 50, 100, 3, '2016-05-31 12:00:00'),
(180, 318572, 'D-3', 311847, '0.60', 50, 100, 16, '2016-05-31 07:00:00'),
(181, 64432, 'D-3', 65282, '0.56', 50, 100, 3, '2016-05-31 12:00:00'),
(182, 326007, 'D-3', 317357, '0.60', 50, 100, 3, '2016-05-31 12:00:00'),
(183, 62224, 'D-3', 62149, '1.20', 50, 100, 3, '2016-05-31 12:00:00'),
(184, 38, 'D-3', 38, '1.90', 50, 100, 3, '2016-05-31 12:00:00'),
(185, 723037, 'D-3', 706837, '1.05', 50, 100, 3, '2016-05-31 12:00:00'),
(186, 422709, 'D-3', 412434, '1.10', 50, 100, 3, '2016-05-31 12:00:00'),
(187, 1034169, 'D-3', 1009444, '0.45', 50, 100, 3, '2016-05-31 12:00:00'),
(188, 208903, 'D-3', 204003, '0.36', 50, 100, 3, '2016-05-31 12:00:00'),
(189, 324375, 'D-4', 316731, '1.70', 20, 50, 3, '2016-05-31 12:00:00'),
(190, 50246, 'D-4', 48746, '1.80', 20, 50, 16, '2016-05-31 07:00:00'),
(191, 686530, 'D-4', 668962, '1.80', 20, 50, 3, '2016-05-31 12:00:00'),
(192, 618169, 'D-4', 604525, '2.30', 20, 50, 3, '2016-05-31 12:00:00'),
(193, 50, 'D-4', 74, '1.60', 20, 50, 16, '2016-05-31 07:00:00'),
(194, 204993, 'D-4', 200529, '2.00', 20, 50, 3, '2016-05-31 12:00:00'),
(195, 59592, 'D-4', 57648, '1.30', 20, 50, 3, '2016-05-31 12:00:00'),
(196, 654741, 'D-4', 638949, '2.00', 20, 50, 16, '2016-05-31 07:00:00'),
(197, 263108, 'D-4', 255716, '1.70', 20, 50, 3, '2016-05-31 12:00:00'),
(198, 54862, 'D-4', 54454, '1.95', 20, 50, 3, '2016-05-31 12:00:00'),
(199, 5447, 'D-4', 4991, '1.50', 20, 50, 3, '2016-05-31 12:00:00'),
(200, 56445, 'D-4', 57069, '2.40', 20, 50, 3, '2016-05-31 12:00:00'),
(201, 153241, 'D-4', 148369, '1.60', 20, 50, 3, '2016-05-31 12:00:00'),
(202, 68654, 'D-4', 68606, '2.05', 20, 50, 16, '2016-05-31 07:00:00'),
(203, 4253, 'D-4', 4643, '17.00', 20, 30, 3, '2016-05-31 12:00:00'),
(204, 24, 'D-4', 24, '17.00', 20, 30, 16, '2016-05-31 07:00:00'),
(205, 169152, 'D-4', 165562, '17.00', 20, 30, 3, '2016-05-31 12:00:00'),
(206, 306414, 'D-5', 299778, '1.70', 50, 200, 3, '2016-05-31 12:00:00'),
(207, 250156, 'D-5', 244504, '1.70', 50, 200, 3, '2016-05-31 12:00:00'),
(208, 251435, 'D-5', 245531, '1.70', 50, 200, 3, '2016-05-31 12:00:00'),
(209, 104161, 'D-7', 101691, '0.90', 20, 50, 16, '2016-05-31 07:00:00'),
(210, 128179, 'D-7', 125214, '1.20', 20, 50, 3, '2016-05-31 12:00:00'),
(211, 273217, 'D-7', 266757, '2.60', 20, 50, 3, '2016-05-31 12:00:00'),
(212, 248979, 'D-7', 243069, '2.05', 20, 50, 3, '2016-05-31 12:00:00'),
(213, 20946, 'D-8', 20443, '35.00', 20, 30, 3, '2016-05-31 12:00:00'),
(214, 16642, 'D-8', 16226, '54.00', 20, 30, 3, '2016-05-31 12:00:00'),
(215, 12530, 'D-8', 12296, '1140.00', 1, 2, 3, '2016-05-31 12:00:00'),
(216, 47902, 'D-9', 47472, '6.00', 10, 40, 3, '2016-05-31 12:00:00'),
(217, 128916, 'D-9', 126526, '16.00', 10, 40, 3, '2016-05-31 12:00:00'),
(218, 107072, 'D-9', 104442, '18.00', 10, 40, 16, '2016-05-31 07:00:00'),
(219, 108124, 'D-9', 106114, '26.00', 10, 40, 3, '2016-05-31 12:00:00'),
(220, 90360, 'CH-1', 71112, '4.75', 240, 500, 16, '2016-05-31 07:00:00'),
(221, 48228, 'CH-2', 38748, '8.75', 120, 250, 3, '2016-05-31 12:00:00'),
(222, 69336, 'CH-3', 56568, '4.75', 240, 500, 3, '2016-05-31 12:00:00'),
(223, 74256, 'CH-4', 58464, '4.75', 240, 500, 3, '2016-05-31 12:00:00'),
(224, 67488, 'CH-5', 53136, '4.75', 240, 500, 3, '2016-05-31 12:00:00'),
(225, 119560, 'CH-6', 95920, '4.75', 240, 500, 16, '2016-05-31 07:00:00'),
(226, 155856, 'CH-7', 122544, '4.75', 240, 500, 3, '2016-05-31 12:00:00'),
(227, 245352, 'CH-8', 193848, '4.75', 240, 500, 3, '2016-05-31 12:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `stockitems`
--

CREATE TABLE `stockitems` (
	`StockItemID` int(11) NOT NULL,
	`StockItemName` varchar(100) NOT NULL,
	`ColorID` int(11) DEFAULT NULL,
	`UnitPackageID` int(11) NOT NULL,
	`OuterPackageID` int(11) NOT NULL,
	`Brand` varchar(50) DEFAULT NULL,
	`Size` varchar(20) DEFAULT NULL,
	`LeadTimeDays` int(11) NOT NULL,
	`QuantityPerOuter` int(11) NOT NULL,
	`IsChillerStock` tinyint(1) NOT NULL,
	`TaxRate` decimal(18,3) NOT NULL,
	`UnitPrice` decimal(18,2) NOT NULL,
	`RecommendedRetailPrice` decimal(18,2) DEFAULT NULL,
	`TypicalWeightPerUnit` decimal(18,3) NOT NULL,
	`MarketingComments` longtext,
	`InternalComments` longtext,
	`Photo` longtext,
	`CustomFields` longtext,
	`Tags` longtext,
	`SearchDetails` longtext NOT NULL,
	`LastEditedBy` int(11) NOT NULL,
	`ValidFrom` datetime NOT NULL,
	`ValidTo` datetime NOT NULL,
	`YouTubeID` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `stockitems`
--

INSERT INTO `stockitems` (`StockItemID`, `StockItemName`, `ColorID`, `UnitPackageID`, `OuterPackageID`, `Brand`, `Size`, `LeadTimeDays`, `QuantityPerOuter`, `IsChillerStock`, `TaxRate`, `UnitPrice`, `RecommendedRetailPrice`, `TypicalWeightPerUnit`, `MarketingComments`, `InternalComments`, `Photo`, `CustomFields`, `Tags`, `SearchDetails`, `LastEditedBy`, `ValidFrom`, `ValidTo`, `YouTubeID`) VALUES
(1, 'USB missile launcher (Green)', 0, 7, 7, '', '', 14, 1, 0, '15.000', '25.00', '37.38', '0.300', 'Complete with 12 projectiles', '', '[\"https://images-na.ssl-images-amazon.com/images/I/41S4zh7hFeL._SY450_.jpg\",\"https://www.getdigital.eu/web/getdigital/gfx/products/__generated__resized/380x380/Raketenwerfer_gruen_main-2.jpg\"]', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"USB Powered\"] }', '[\"USB Powered\"]', 'USB missile launcher (Green) Complete with 12 projectiles', 1, '2016-05-31 23:11:00', '9999-12-31 23:59:59', '8yDkraOEgmM'),
(2, 'USB rocket launcher (Gray)', 12, 7, 7, '', '', 14, 1, 0, '15.000', '25.00', '37.38', '0.300', 'Complete with 12 projectiles', '', '[\"https://cdn.instructables.com/FBI/U7EK/FJPYEPM3/FBIU7EKFJPYEPM3.LARGE.jpg\",\"http://www.rngtng.com/files/2015/05/img8077_14925.jpg\"]', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"USB Powered\"] }', '[\"USB Powered\"]', 'USB rocket launcher (Gray) Complete with 12 projectiles', 1, '2016-05-31 23:11:00', '9999-12-31 23:59:59', 'h12y-CcSYjE'),
(3, 'Office cube periscope (Black)', 3, 7, 6, '', '', 14, 10, 0, '15.000', '18.50', '27.66', '0.250', 'Need to see over your cubicle wall? This is just what\'s needed.', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [] }', '[]', 'Office cube periscope (Black) Need to see over your cubicle wall? This is just what\'s needed.', 1, '2016-05-31 23:00:00', '9999-12-31 23:59:59', NULL),
(4, 'USB food flash drive - sushi roll', 0, 7, 7, '', '', 14, 1, 0, '15.000', '32.00', '47.84', '0.050', '', '', '[\"https://sc02.alicdn.com/kf/HTB1XGnXSpXXXXaPXpXXq6xXFXXXg/food-usb-series-of-Japanese-sushi-usb.jpg\",\"https://www.cubicpromote.com.au/media/catalog/product/cache/1/image/380x380/9df78eab33525d08d6e5fb8d27136e95/6/3/637ea59b3e3d3105a83b9ffc59619311_1.jpg\"]', '{ \"CountryOfManufacture\": \"Japan\", \"Tags\": [\"32GB\",\"USB Powered\"] }', '[\"32GB\",\"USB Powered\"]', 'USB food flash drive - sushi roll ', 1, '2016-05-31 23:11:00', '9999-12-31 23:59:59', 'pk-cpCMVaI4'),
(5, 'USB food flash drive - hamburger', 0, 7, 7, '', '', 14, 1, 0, '15.000', '32.00', '47.84', '0.050', '', '', '[\"https://images-na.ssl-images-amazon.com/images/I/41qlSCbZfCL._SX355_.jpg\",\"https://cdn.chv.me/images/thumbnails/Browse-Chinavasion-com-for-XWvnt02w.jpg.thumb_400x400.jpg\"]', '{ \"CountryOfManufacture\": \"Japan\", \"Tags\": [\"16GB\",\"USB Powered\"] }', '[\"16GB\",\"USB Powered\"]', 'USB food flash drive - hamburger ', 1, '2016-05-31 23:11:00', '9999-12-31 23:59:59', 'Ddx_p8kWx70'),
(6, 'USB food flash drive - hot dog', 0, 7, 7, '', '', 14, 1, 0, '15.000', '32.00', '47.84', '0.050', '', '', '', '{ \"CountryOfManufacture\": \"Japan\", \"Tags\": [\"32GB\",\"USB Powered\"] }', '[\"32GB\",\"USB Powered\"]', 'USB food flash drive - hot dog ', 1, '2016-05-31 23:11:00', '9999-12-31 23:59:59', NULL),
(7, 'USB food flash drive - pizza slice', 0, 7, 7, '', '', 14, 1, 0, '15.000', '32.00', '47.84', '0.050', '', '', '', '{ \"CountryOfManufacture\": \"Japan\", \"Tags\": [\"16GB\",\"USB Powered\"] }', '[\"16GB\",\"USB Powered\"]', 'USB food flash drive - pizza slice ', 1, '2016-05-31 23:11:00', '9999-12-31 23:59:59', NULL),
(8, 'USB food flash drive - dim sum 10 drive variety pack', 0, 9, 9, '', '', 14, 1, 0, '15.000', '240.00', '358.80', '0.500', '', '', '', '{ \"CountryOfManufacture\": \"Japan\", \"Tags\": [\"32GB\",\"USB Powered\"] }', '[\"32GB\",\"USB Powered\"]', 'USB food flash drive - dim sum 10 drive variety pack ', 1, '2016-05-31 23:11:00', '9999-12-31 23:59:59', NULL),
(9, 'USB food flash drive - banana', 0, 7, 7, '', '', 14, 1, 0, '15.000', '32.00', '47.84', '0.050', '', '', '', '{ \"CountryOfManufacture\": \"Japan\", \"Tags\": [\"16GB\",\"USB Powered\"] }', '[\"16GB\",\"USB Powered\"]', 'USB food flash drive - banana ', 1, '2016-05-31 23:11:00', '9999-12-31 23:59:59', NULL),
(10, 'USB food flash drive - chocolate bar', 0, 7, 7, '', '', 14, 1, 0, '15.000', '32.00', '47.84', '0.050', '', '', '', '{ \"CountryOfManufacture\": \"Japan\", \"Tags\": [\"32GB\",\"USB Powered\"] }', '[\"32GB\",\"USB Powered\"]', 'USB food flash drive - chocolate bar ', 1, '2016-05-31 23:11:00', '9999-12-31 23:59:59', NULL),
(11, 'USB food flash drive - cookie', 0, 7, 7, '', '', 14, 1, 0, '15.000', '32.00', '47.84', '0.050', '', '', '', '{ \"CountryOfManufacture\": \"Japan\", \"Tags\": [\"16GB\",\"USB Powered\"] }', '[\"16GB\",\"USB Powered\"]', 'USB food flash drive - cookie ', 1, '2016-05-31 23:11:00', '9999-12-31 23:59:59', NULL),
(12, 'USB food flash drive - donut', 0, 7, 7, '', '', 14, 1, 0, '15.000', '32.00', '47.84', '0.050', '', '', '', '{ \"CountryOfManufacture\": \"Japan\", \"Tags\": [\"32GB\",\"USB Powered\"] }', '[\"32GB\",\"USB Powered\"]', 'USB food flash drive - donut ', 1, '2016-05-31 23:11:00', '9999-12-31 23:59:59', NULL),
(13, 'USB food flash drive - shrimp cocktail', 0, 7, 7, '', '', 14, 1, 0, '15.000', '32.00', '47.84', '0.050', '', '', '', '{ \"CountryOfManufacture\": \"Japan\", \"Tags\": [\"16GB\",\"USB Powered\"] }', '[\"16GB\",\"USB Powered\"]', 'USB food flash drive - shrimp cocktail ', 1, '2016-05-31 23:11:00', '9999-12-31 23:59:59', NULL),
(14, 'USB food flash drive - fortune cookie', 0, 7, 7, '', '', 14, 1, 0, '15.000', '32.00', '47.84', '0.050', '', '', '', '{ \"CountryOfManufacture\": \"Japan\", \"Tags\": [\"32GB\",\"USB Powered\"] }', '[\"32GB\",\"USB Powered\"]', 'USB food flash drive - fortune cookie ', 1, '2016-05-31 23:11:00', '9999-12-31 23:59:59', NULL),
(15, 'USB food flash drive - dessert 10 drive variety pack', 0, 9, 9, '', '', 14, 1, 0, '15.000', '240.00', '358.80', '0.500', '', '', '', '{ \"CountryOfManufacture\": \"Japan\", \"Tags\": [\"16GB\",\"USB Powered\"] }', '[\"16GB\",\"USB Powered\"]', 'USB food flash drive - dessert 10 drive variety pack ', 1, '2016-05-31 23:11:00', '9999-12-31 23:59:59', NULL),
(16, 'DBA joke mug - mind if I join you? (White)', 35, 7, 7, '', '', 12, 1, 0, '15.000', '13.00', '19.44', '0.150', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Comedy\"] }', '[\"Comedy\"]', 'DBA joke mug - mind if I join you? (White) ', 1, '2016-05-31 23:10:00', '9999-12-31 23:59:59', NULL),
(17, 'DBA joke mug - mind if I join you? (Black)', 3, 7, 7, '', '', 12, 1, 0, '15.000', '13.00', '19.44', '0.150', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Comedy\"] }', '[\"Comedy\"]', 'DBA joke mug - mind if I join you? (Black) ', 1, '2016-05-31 23:10:00', '9999-12-31 23:59:59', NULL),
(18, 'DBA joke mug - daaaaaa-ta (White)', 35, 7, 7, '', '', 12, 1, 0, '15.000', '13.00', '19.44', '0.150', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Comedy\"] }', '[\"Comedy\"]', 'DBA joke mug - daaaaaa-ta (White) ', 1, '2016-05-31 23:10:00', '9999-12-31 23:59:59', NULL),
(19, 'DBA joke mug - daaaaaa-ta (Black)', 3, 7, 7, '', '', 12, 1, 0, '15.000', '13.00', '19.44', '0.150', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Comedy\"] }', '[\"Comedy\"]', 'DBA joke mug - daaaaaa-ta (Black) ', 1, '2016-05-31 23:10:00', '9999-12-31 23:59:59', NULL),
(20, 'DBA joke mug - you might be a DBA if (White)', 35, 7, 7, '', '', 12, 1, 0, '15.000', '13.00', '19.44', '0.150', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Comedy\"] }', '[\"Comedy\"]', 'DBA joke mug - you might be a DBA if (White) ', 1, '2016-05-31 23:10:00', '9999-12-31 23:59:59', NULL),
(21, 'DBA joke mug - you might be a DBA if (Black)', 3, 7, 7, '', '', 12, 1, 0, '15.000', '13.00', '19.44', '0.150', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Comedy\"] }', '[\"Comedy\"]', 'DBA joke mug - you might be a DBA if (Black) ', 1, '2016-05-31 23:10:00', '9999-12-31 23:59:59', NULL),
(22, 'DBA joke mug - it depends (White)', 35, 7, 7, '', '', 12, 1, 0, '15.000', '13.00', '19.44', '0.150', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Comedy\"] }', '[\"Comedy\"]', 'DBA joke mug - it depends (White) ', 1, '2016-05-31 23:10:00', '9999-12-31 23:59:59', NULL),
(23, 'DBA joke mug - it depends (Black)', 3, 7, 7, '', '', 12, 1, 0, '15.000', '13.00', '19.44', '0.150', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Comedy\"] }', '[\"Comedy\"]', 'DBA joke mug - it depends (Black) ', 1, '2016-05-31 23:10:00', '9999-12-31 23:59:59', NULL),
(24, 'DBA joke mug - I will get you in order (White)', 35, 7, 7, '', '', 12, 1, 0, '15.000', '13.00', '19.44', '0.150', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Comedy\"] }', '[\"Comedy\"]', 'DBA joke mug - I will get you in order (White) ', 1, '2016-05-31 23:10:00', '9999-12-31 23:59:59', NULL),
(25, 'DBA joke mug - I will get you in order (Black)', 3, 7, 7, '', '', 12, 1, 0, '15.000', '13.00', '19.44', '0.150', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Comedy\"] }', '[\"Comedy\"]', 'DBA joke mug - I will get you in order (Black) ', 1, '2016-05-31 23:10:00', '9999-12-31 23:59:59', NULL),
(26, 'DBA joke mug - SELECT caffeine FROM mug (White)', 35, 7, 7, '', '', 12, 1, 0, '15.000', '13.00', '19.44', '0.150', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Comedy\"] }', '[\"Comedy\"]', 'DBA joke mug - SELECT caffeine FROM mug (White) ', 1, '2016-05-31 23:10:00', '9999-12-31 23:59:59', NULL),
(27, 'DBA joke mug - SELECT caffeine FROM mug (Black)', 3, 7, 7, '', '', 12, 1, 0, '15.000', '13.00', '19.44', '0.150', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Comedy\"] }', '[\"Comedy\"]', 'DBA joke mug - SELECT caffeine FROM mug (Black) ', 1, '2016-05-31 23:10:00', '9999-12-31 23:59:59', NULL),
(28, 'DBA joke mug - two types of DBAs (White)', 35, 7, 7, '', '', 12, 1, 0, '15.000', '13.00', '19.44', '0.150', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Comedy\"] }', '[\"Comedy\"]', 'DBA joke mug - two types of DBAs (White) ', 1, '2016-05-31 23:10:00', '9999-12-31 23:59:59', NULL),
(29, 'DBA joke mug - two types of DBAs (Black)', 3, 7, 7, '', '', 12, 1, 0, '15.000', '13.00', '19.44', '0.150', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Comedy\"] }', '[\"Comedy\"]', 'DBA joke mug - two types of DBAs (Black) ', 1, '2016-05-31 23:10:00', '9999-12-31 23:59:59', NULL),
(30, 'Developer joke mug - Oct 31 = Dec 25 (White)', 35, 7, 7, '', '', 12, 1, 0, '15.000', '13.00', '19.44', '0.150', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Comedy\"] }', '[\"Comedy\"]', 'Developer joke mug - Oct 31 = Dec 25 (White) ', 1, '2016-05-31 23:10:00', '9999-12-31 23:59:59', NULL),
(31, 'Developer joke mug - Oct 31 = Dec 25 (Black)', 3, 7, 7, '', '', 12, 1, 0, '15.000', '13.00', '19.44', '0.150', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Comedy\"] }', '[\"Comedy\"]', 'Developer joke mug - Oct 31 = Dec 25 (Black) ', 1, '2016-05-31 23:10:00', '9999-12-31 23:59:59', NULL),
(32, 'Developer joke mug - that\'s a hardware problem (White)', 35, 7, 7, '', '', 12, 1, 0, '15.000', '13.00', '19.44', '0.150', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Comedy\"] }', '[\"Comedy\"]', 'Developer joke mug - that\'s a hardware problem (White) ', 1, '2016-05-31 23:10:00', '9999-12-31 23:59:59', NULL),
(33, 'Developer joke mug - that\'s a hardware problem (Black)', 3, 7, 7, '', '', 12, 1, 0, '15.000', '13.00', '19.44', '0.150', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Comedy\"] }', '[\"Comedy\"]', 'Developer joke mug - that\'s a hardware problem (Black) ', 1, '2016-05-31 23:10:00', '9999-12-31 23:59:59', NULL),
(34, 'Developer joke mug - fun was unexpected at this time (White)', 35, 7, 7, '', '', 12, 1, 0, '15.000', '13.00', '19.44', '0.150', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Comedy\"] }', '[\"Comedy\"]', 'Developer joke mug - fun was unexpected at this time (White) ', 1, '2016-05-31 23:10:00', '9999-12-31 23:59:59', NULL),
(35, 'Developer joke mug - fun was unexpected at this time (Black)', 3, 7, 7, '', '', 12, 1, 0, '15.000', '13.00', '19.44', '0.150', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Comedy\"] }', '[\"Comedy\"]', 'Developer joke mug - fun was unexpected at this time (Black) ', 1, '2016-05-31 23:10:00', '9999-12-31 23:59:59', NULL),
(36, 'Developer joke mug - when your hammer is C++ (White)', 35, 7, 7, '', '', 12, 1, 0, '15.000', '13.00', '19.44', '0.150', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Comedy\"] }', '[\"Comedy\"]', 'Developer joke mug - when your hammer is C++ (White) ', 1, '2016-05-31 23:10:00', '9999-12-31 23:59:59', NULL),
(37, 'Developer joke mug - when your hammer is C++ (Black)', 3, 7, 7, '', '', 12, 1, 0, '15.000', '13.00', '19.44', '0.150', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Comedy\"] }', '[\"Comedy\"]', 'Developer joke mug - when your hammer is C++ (Black) ', 1, '2016-05-31 23:10:00', '9999-12-31 23:59:59', NULL),
(38, 'Developer joke mug - inheritance is the OO way to become wealthy (White)', 35, 7, 7, '', '', 12, 1, 0, '15.000', '13.00', '19.44', '0.150', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Comedy\"] }', '[\"Comedy\"]', 'Developer joke mug - inheritance is the OO way to become wealthy (White) ', 1, '2016-05-31 23:10:00', '9999-12-31 23:59:59', NULL),
(39, 'Developer joke mug - inheritance is the OO way to become wealthy (Black)', 3, 7, 7, '', '', 12, 1, 0, '15.000', '13.00', '19.44', '0.150', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Comedy\"] }', '[\"Comedy\"]', 'Developer joke mug - inheritance is the OO way to become wealthy (Black) ', 1, '2016-05-31 23:10:00', '9999-12-31 23:59:59', NULL),
(40, 'Developer joke mug - (hip, hip, array) (White)', 35, 7, 7, '', '', 12, 1, 0, '15.000', '13.00', '19.44', '0.150', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Comedy\"] }', '[\"Comedy\"]', 'Developer joke mug - (hip, hip, array) (White) ', 1, '2016-05-31 23:10:00', '9999-12-31 23:59:59', NULL),
(41, 'Developer joke mug - (hip, hip, array) (Black)', 3, 7, 7, '', '', 12, 1, 0, '15.000', '13.00', '19.44', '0.150', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Comedy\"] }', '[\"Comedy\"]', 'Developer joke mug - (hip, hip, array) (Black) ', 1, '2016-05-31 23:10:00', '9999-12-31 23:59:59', NULL),
(42, 'Developer joke mug - understanding recursion requires understanding recursion (White)', 35, 7, 7, '', '', 12, 1, 0, '15.000', '13.00', '19.44', '0.150', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Comedy\"] }', '[\"Comedy\"]', 'Developer joke mug - understanding recursion requires understanding recursion (White) ', 1, '2016-05-31 23:10:00', '9999-12-31 23:59:59', NULL),
(43, 'Developer joke mug - understanding recursion requires understanding recursion (Black)', 3, 7, 7, '', '', 12, 1, 0, '15.000', '13.00', '19.44', '0.150', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Comedy\"] }', '[\"Comedy\"]', 'Developer joke mug - understanding recursion requires understanding recursion (Black) ', 1, '2016-05-31 23:10:00', '9999-12-31 23:59:59', NULL),
(44, 'Developer joke mug - there are 10 types of people in the world (White)', 35, 7, 7, '', '', 12, 1, 0, '15.000', '13.00', '19.44', '0.150', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Comedy\"] }', '[\"Comedy\"]', 'Developer joke mug - there are 10 types of people in the world (White) ', 1, '2016-05-31 23:10:00', '9999-12-31 23:59:59', NULL),
(45, 'Developer joke mug - there are 10 types of people in the world (Black)', 3, 7, 7, '', '', 12, 1, 0, '15.000', '13.00', '19.44', '0.150', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Comedy\"] }', '[\"Comedy\"]', 'Developer joke mug - there are 10 types of people in the world (Black) ', 1, '2016-05-31 23:10:00', '9999-12-31 23:59:59', NULL),
(46, 'Developer joke mug - a foo walks into a bar (White)', 35, 7, 7, '', '', 12, 1, 0, '15.000', '13.00', '19.44', '0.150', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Comedy\"] }', '[\"Comedy\"]', 'Developer joke mug - a foo walks into a bar (White) ', 1, '2016-05-31 23:10:00', '9999-12-31 23:59:59', NULL),
(47, 'Developer joke mug - a foo walks into a bar (Black)', 3, 7, 7, '', '', 12, 1, 0, '15.000', '13.00', '19.44', '0.150', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Comedy\"] }', '[\"Comedy\"]', 'Developer joke mug - a foo walks into a bar (Black) ', 1, '2016-05-31 23:10:00', '9999-12-31 23:59:59', NULL),
(48, 'Developer joke mug - this code was generated by a tool (White)', 35, 7, 7, '', '', 12, 1, 0, '15.000', '13.00', '19.44', '0.150', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Comedy\"] }', '[\"Comedy\"]', 'Developer joke mug - this code was generated by a tool (White) ', 1, '2016-05-31 23:10:00', '9999-12-31 23:59:59', NULL),
(49, 'Developer joke mug - this code was generated by a tool (Black)', 3, 7, 7, '', '', 12, 1, 0, '15.000', '13.00', '19.44', '0.150', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Comedy\"] }', '[\"Comedy\"]', 'Developer joke mug - this code was generated by a tool (Black) ', 1, '2016-05-31 23:10:00', '9999-12-31 23:59:59', NULL),
(50, 'Developer joke mug - old C developers never die (White)', 35, 7, 7, '', '', 12, 1, 0, '15.000', '13.00', '19.44', '0.150', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Comedy\"] }', '[\"Comedy\"]', 'Developer joke mug - old C developers never die (White) ', 1, '2016-05-31 23:10:00', '9999-12-31 23:59:59', NULL),
(51, 'Developer joke mug - old C developers never die (Black)', 3, 7, 7, '', '', 12, 1, 0, '15.000', '13.00', '19.44', '0.150', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Comedy\"] }', '[\"Comedy\"]', 'Developer joke mug - old C developers never die (Black) ', 1, '2016-05-31 23:10:00', '9999-12-31 23:59:59', NULL),
(52, 'IT joke mug - keyboard not found ÔÇª press F1 to continue (White)', 35, 7, 7, '', '', 12, 1, 0, '15.000', '13.00', '19.44', '0.150', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Comedy\"] }', '[\"Comedy\"]', 'IT joke mug - keyboard not found ÔÇª press F1 to continue (White) ', 1, '2016-05-31 23:10:00', '9999-12-31 23:59:59', NULL),
(53, 'IT joke mug - keyboard not found ÔÇª press F1 to continue (Black)', 3, 7, 7, '', '', 12, 1, 0, '15.000', '13.00', '19.44', '0.150', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Comedy\"] }', '[\"Comedy\"]', 'IT joke mug - keyboard not found ÔÇª press F1 to continue (Black) ', 1, '2016-05-31 23:10:00', '9999-12-31 23:59:59', NULL),
(54, 'IT joke mug - that behavior is by design (White)', 35, 7, 7, '', '', 12, 1, 0, '15.000', '13.00', '19.44', '0.150', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Comedy\"] }', '[\"Comedy\"]', 'IT joke mug - that behavior is by design (White) ', 1, '2016-05-31 23:10:00', '9999-12-31 23:59:59', NULL),
(55, 'IT joke mug - that behavior is by design (Black)', 3, 7, 7, '', '', 12, 1, 0, '15.000', '13.00', '19.44', '0.150', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Comedy\"] }', '[\"Comedy\"]', 'IT joke mug - that behavior is by design (Black) ', 1, '2016-05-31 23:10:00', '9999-12-31 23:59:59', NULL),
(56, 'IT joke mug - hardware: part of the computer that can be kicked (White)', 35, 7, 7, '', '', 12, 1, 0, '15.000', '13.00', '19.44', '0.150', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Comedy\"] }', '[\"Comedy\"]', 'IT joke mug - hardware: part of the computer that can be kicked (White) ', 1, '2016-05-31 23:10:00', '9999-12-31 23:59:59', NULL),
(57, 'IT joke mug - hardware: part of the computer that can be kicked (Black)', 3, 7, 7, '', '', 12, 1, 0, '15.000', '13.00', '19.44', '0.150', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Comedy\"] }', '[\"Comedy\"]', 'IT joke mug - hardware: part of the computer that can be kicked (Black) ', 1, '2016-05-31 23:10:00', '9999-12-31 23:59:59', NULL),
(58, 'RC toy sedan car with remote control (Black) 1/50 scale', 3, 7, 7, 'Northwind', '1/50 scale', 14, 1, 0, '15.000', '25.00', '37.38', '1.500', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Radio Control\",\"Realistic Sound\"], \"MinimumAge\": \"10\" }', '[\"Radio Control\",\"Realistic Sound\"]', 'RC toy sedan car with remote control (Black) 1/50 scale ', 1, '2016-05-31 23:02:00', '9999-12-31 23:59:59', NULL),
(59, 'RC toy sedan car with remote control (Red) 1/50 scale', 28, 7, 7, 'Northwind', '1/50 scale', 14, 1, 0, '15.000', '25.00', '37.38', '1.500', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Radio Control\",\"Realistic Sound\"], \"MinimumAge\": \"10\" }', '[\"Radio Control\",\"Realistic Sound\"]', 'RC toy sedan car with remote control (Red) 1/50 scale ', 1, '2016-05-31 23:02:00', '9999-12-31 23:59:59', NULL),
(60, 'RC toy sedan car with remote control (Blue) 1/50 scale', 4, 7, 7, 'Northwind', '1/50 scale', 14, 1, 0, '15.000', '25.00', '37.38', '1.500', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Radio Control\",\"Realistic Sound\"], \"MinimumAge\": \"10\" }', '[\"Radio Control\",\"Realistic Sound\"]', 'RC toy sedan car with remote control (Blue) 1/50 scale ', 1, '2016-05-31 23:02:00', '9999-12-31 23:59:59', NULL),
(61, 'RC toy sedan car with remote control (Green) 1/50 scale', 0, 7, 7, 'Northwind', '1/50 scale', 14, 1, 0, '15.000', '25.00', '37.38', '1.500', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Radio Control\",\"Realistic Sound\"], \"MinimumAge\": \"10\" }', '[\"Radio Control\",\"Realistic Sound\"]', 'RC toy sedan car with remote control (Green) 1/50 scale ', 1, '2016-05-31 23:02:00', '9999-12-31 23:59:59', NULL),
(62, 'RC toy sedan car with remote control (Yellow) 1/50 scale', 36, 7, 7, 'Northwind', '1/50 scale', 14, 1, 0, '15.000', '25.00', '37.38', '1.500', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Radio Control\",\"Realistic Sound\"], \"MinimumAge\": \"10\" }', '[\"Radio Control\",\"Realistic Sound\"]', 'RC toy sedan car with remote control (Yellow) 1/50 scale ', 1, '2016-05-31 23:02:00', '9999-12-31 23:59:59', NULL),
(63, 'RC toy sedan car with remote control (Pink) 1/50 scale', 0, 7, 7, 'Northwind', '1/50 scale', 14, 1, 0, '15.000', '25.00', '37.38', '1.500', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Radio Control\",\"Realistic Sound\"], \"MinimumAge\": \"10\" }', '[\"Radio Control\",\"Realistic Sound\"]', 'RC toy sedan car with remote control (Pink) 1/50 scale ', 1, '2016-05-31 23:02:00', '9999-12-31 23:59:59', NULL),
(64, 'RC vintage American toy coupe with remote control (Red) 1/50 scale', 28, 7, 7, 'Northwind', '1/50 scale', 14, 1, 0, '15.000', '30.00', '44.85', '1.700', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Radio Control\",\"Realistic Sound\",\"Vintage\"], \"MinimumAge\": \"10\" }', '[\"Radio Control\",\"Realistic Sound\",\"Vintage\"]', 'RC vintage American toy coupe with remote control (Red) 1/50 scale ', 1, '2016-05-31 23:03:00', '9999-12-31 23:59:59', NULL),
(65, 'RC vintage American toy coupe with remote control (Black) 1/50 scale', 3, 7, 7, 'Northwind', '1/50 scale', 14, 1, 0, '15.000', '30.00', '44.85', '1.700', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Radio Control\",\"Realistic Sound\",\"Vintage\"], \"MinimumAge\": \"10\" }', '[\"Radio Control\",\"Realistic Sound\",\"Vintage\"]', 'RC vintage American toy coupe with remote control (Black) 1/50 scale ', 1, '2016-05-31 23:03:00', '9999-12-31 23:59:59', NULL),
(66, 'RC big wheel monster truck with remote control (Black) 1/50 scale', 3, 7, 7, 'Northwind', '1/50 scale', 14, 1, 0, '15.000', '45.00', '67.28', '1.800', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Radio Control\",\"Realistic Sound\"], \"MinimumAge\": \"10\" }', '[\"Radio Control\",\"Realistic Sound\"]', 'RC big wheel monster truck with remote control (Black) 1/50 scale ', 1, '2016-05-31 23:02:00', '9999-12-31 23:59:59', NULL),
(67, 'Ride on toy sedan car (Black) 1/12 scale', 3, 7, 7, 'Northwind', '1/12 scale', 14, 1, 0, '15.000', '230.00', '343.85', '15.000', 'Suits child to 20 kg', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"So Realistic\"] }', '[\"So Realistic\"]', 'Ride on toy sedan car (Black) 1/12 scale Suits child to 20 kg', 1, '2016-05-31 23:06:00', '9999-12-31 23:59:59', NULL),
(68, 'Ride on toy sedan car (Red) 1/12 scale', 28, 7, 7, 'Northwind', '1/12 scale', 14, 1, 0, '15.000', '230.00', '343.85', '15.000', 'Suits child to 20 kg', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"So Realistic\"] }', '[\"So Realistic\"]', 'Ride on toy sedan car (Red) 1/12 scale Suits child to 20 kg', 1, '2016-05-31 23:06:00', '9999-12-31 23:59:59', NULL),
(69, 'Ride on toy sedan car (Blue) 1/12 scale', 4, 7, 7, 'Northwind', '1/12 scale', 14, 1, 0, '15.000', '230.00', '343.85', '15.000', 'Suits child to 20 kg', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"So Realistic\"] }', '[\"So Realistic\"]', 'Ride on toy sedan car (Blue) 1/12 scale Suits child to 20 kg', 1, '2016-05-31 23:06:00', '9999-12-31 23:59:59', NULL),
(70, 'Ride on toy sedan car (Green) 1/12 scale', 0, 7, 7, 'Northwind', '1/12 scale', 14, 1, 0, '15.000', '230.00', '343.85', '15.000', 'Suits child to 20 kg', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"So Realistic\"] }', '[\"So Realistic\"]', 'Ride on toy sedan car (Green) 1/12 scale Suits child to 20 kg', 1, '2016-05-31 23:06:00', '9999-12-31 23:59:59', NULL),
(71, 'Ride on toy sedan car (Yellow) 1/12 scale', 36, 7, 7, 'Northwind', '1/12 scale', 14, 1, 0, '15.000', '230.00', '343.85', '15.000', 'Suits child to 20 kg', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"So Realistic\"] }', '[\"So Realistic\"]', 'Ride on toy sedan car (Yellow) 1/12 scale Suits child to 20 kg', 1, '2016-05-31 23:06:00', '9999-12-31 23:59:59', NULL),
(72, 'Ride on toy sedan car (Pink) 1/12 scale', 0, 7, 7, 'Northwind', '1/12 scale', 14, 1, 0, '15.000', '230.00', '343.85', '15.000', 'Suits child to 20 kg', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"So Realistic\"] }', '[\"So Realistic\"]', 'Ride on toy sedan car (Pink) 1/12 scale Suits child to 20 kg', 1, '2016-05-31 23:06:00', '9999-12-31 23:59:59', NULL),
(73, 'Ride on vintage American toy coupe (Red) 1/12 scale', 28, 7, 7, 'Northwind', '1/12 scale', 14, 1, 0, '15.000', '285.00', '426.08', '18.000', 'Suits child to 20 kg', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Vintage\",\"So Realistic\"] }', '[\"Vintage\",\"So Realistic\"]', 'Ride on vintage American toy coupe (Red) 1/12 scale Suits child to 20 kg', 1, '2016-05-31 23:06:00', '9999-12-31 23:59:59', NULL),
(74, 'Ride on vintage American toy coupe (Black) 1/12 scale', 3, 7, 7, 'Northwind', '1/12 scale', 14, 1, 0, '15.000', '285.00', '426.08', '18.000', 'Suits child to 20 kg', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Vintage\",\"So Realistic\"] }', '[\"Vintage\",\"So Realistic\"]', 'Ride on vintage American toy coupe (Black) 1/12 scale Suits child to 20 kg', 1, '2016-05-31 23:06:00', '9999-12-31 23:59:59', NULL),
(75, 'Ride on big wheel monster truck (Black) 1/12 scale', 3, 7, 7, 'Northwind', '1/12 scale', 14, 1, 0, '15.000', '345.00', '515.78', '21.000', 'Suits child to 20 kg', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"So Realistic\"] }', '[\"So Realistic\"]', 'Ride on big wheel monster truck (Black) 1/12 scale Suits child to 20 kg', 1, '2016-05-31 23:06:00', '9999-12-31 23:59:59', NULL),
(76, '\"The Gu\" red shirt XML tag t-shirt (White) 3XS', 35, 7, 6, '', '3XS', 7, 12, 0, '15.000', '18.00', '26.91', '0.250', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [], \"Range\": \"Children\" }', '[]', '\"The Gu\" red shirt XML tag t-shirt (White) 3XS ', 1, '2016-05-31 23:00:00', '9999-12-31 23:59:59', NULL),
(77, '\"The Gu\" red shirt XML tag t-shirt (White) XXS', 35, 7, 6, '', 'XXS', 7, 12, 0, '15.000', '18.00', '26.91', '0.250', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [], \"Range\": \"Children\" }', '[]', '\"The Gu\" red shirt XML tag t-shirt (White) XXS ', 1, '2016-05-31 23:00:00', '9999-12-31 23:59:59', NULL),
(78, '\"The Gu\" red shirt XML tag t-shirt (White) XS', 35, 7, 6, '', 'XS', 7, 12, 0, '15.000', '18.00', '26.91', '0.250', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [], \"Range\": \"Children\" }', '[]', '\"The Gu\" red shirt XML tag t-shirt (White) XS ', 1, '2016-05-31 23:00:00', '9999-12-31 23:59:59', NULL),
(79, '\"The Gu\" red shirt XML tag t-shirt (White) S', 35, 7, 6, '', 'S', 7, 12, 0, '15.000', '18.00', '26.91', '0.300', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [], \"Range\": \"Children\" }', '[]', '\"The Gu\" red shirt XML tag t-shirt (White) S ', 1, '2016-05-31 23:00:00', '9999-12-31 23:59:59', NULL),
(80, '\"The Gu\" red shirt XML tag t-shirt (White) M', 35, 7, 6, '', 'M', 7, 12, 0, '15.000', '18.00', '26.91', '0.350', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [], \"Range\": \"Teens/Young Adult\" }', '[]', '\"The Gu\" red shirt XML tag t-shirt (White) M ', 1, '2016-05-31 23:00:00', '9999-12-31 23:59:59', NULL),
(81, '\"The Gu\" red shirt XML tag t-shirt (White) L', 35, 7, 6, '', 'L', 7, 12, 0, '15.000', '18.00', '26.91', '0.350', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [], \"Range\": \"Adult\" }', '[]', '\"The Gu\" red shirt XML tag t-shirt (White) L ', 1, '2016-05-31 23:00:00', '9999-12-31 23:59:59', NULL),
(82, '\"The Gu\" red shirt XML tag t-shirt (White) XL', 35, 7, 6, '', 'XL', 7, 12, 0, '15.000', '18.00', '26.91', '0.350', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [], \"Range\": \"Adult\" }', '[]', '\"The Gu\" red shirt XML tag t-shirt (White) XL ', 1, '2016-05-31 23:00:00', '9999-12-31 23:59:59', NULL),
(83, '\"The Gu\" red shirt XML tag t-shirt (White) XXL', 35, 7, 6, '', 'XXL', 7, 12, 0, '15.000', '18.00', '26.91', '0.400', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [], \"Range\": \"Adult\" }', '[]', '\"The Gu\" red shirt XML tag t-shirt (White) XXL ', 1, '2016-05-31 23:00:00', '9999-12-31 23:59:59', NULL),
(84, '\"The Gu\" red shirt XML tag t-shirt (White) 3XL', 35, 7, 6, '', '3XL', 7, 12, 0, '15.000', '18.00', '26.91', '0.400', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [], \"Range\": \"Adult\" }', '[]', '\"The Gu\" red shirt XML tag t-shirt (White) 3XL ', 1, '2016-05-31 23:00:00', '9999-12-31 23:59:59', NULL),
(85, '\"The Gu\" red shirt XML tag t-shirt (White) 4XL', 35, 7, 6, '', '4XL', 7, 12, 0, '15.000', '18.00', '26.91', '0.400', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [], \"Range\": \"Adult\" }', '[]', '\"The Gu\" red shirt XML tag t-shirt (White) 4XL ', 1, '2016-05-31 23:00:00', '9999-12-31 23:59:59', NULL),
(86, '\"The Gu\" red shirt XML tag t-shirt (White) 5XL', 35, 7, 6, '', '5XL', 7, 12, 0, '15.000', '18.00', '26.91', '0.400', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [], \"Range\": \"Adult\" }', '[]', '\"The Gu\" red shirt XML tag t-shirt (White) 5XL ', 1, '2016-05-31 23:00:00', '9999-12-31 23:59:59', NULL),
(87, '\"The Gu\" red shirt XML tag t-shirt (White) 6XL', 35, 7, 6, '', '6XL', 7, 12, 0, '15.000', '18.00', '26.91', '0.400', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [], \"Range\": \"Adult\" }', '[]', '\"The Gu\" red shirt XML tag t-shirt (White) 6XL ', 1, '2016-05-31 23:00:00', '9999-12-31 23:59:59', NULL),
(88, '\"The Gu\" red shirt XML tag t-shirt (White) 7XL', 35, 7, 6, '', '7XL', 7, 12, 0, '15.000', '18.00', '26.91', '0.450', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [], \"Range\": \"Adult\" }', '[]', '\"The Gu\" red shirt XML tag t-shirt (White) 7XL ', 1, '2016-05-31 23:00:00', '9999-12-31 23:59:59', NULL),
(89, '\"The Gu\" red shirt XML tag t-shirt (Black) 3XS', 3, 7, 6, '', '3XS', 7, 12, 0, '15.000', '18.00', '26.91', '0.250', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [], \"Range\": \"Children\" }', '[]', '\"The Gu\" red shirt XML tag t-shirt (Black) 3XS ', 1, '2016-05-31 23:00:00', '9999-12-31 23:59:59', NULL),
(90, '\"The Gu\" red shirt XML tag t-shirt (Black) XXS', 3, 7, 6, '', 'XXS', 7, 12, 0, '15.000', '18.00', '26.91', '0.250', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [], \"Range\": \"Children\" }', '[]', '\"The Gu\" red shirt XML tag t-shirt (Black) XXS ', 1, '2016-05-31 23:00:00', '9999-12-31 23:59:59', NULL),
(91, '\"The Gu\" red shirt XML tag t-shirt (Black) XS', 3, 7, 6, '', 'XS', 7, 12, 0, '15.000', '18.00', '26.91', '0.250', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [], \"Range\": \"Children\" }', '[]', '\"The Gu\" red shirt XML tag t-shirt (Black) XS ', 1, '2016-05-31 23:00:00', '9999-12-31 23:59:59', NULL),
(92, '\"The Gu\" red shirt XML tag t-shirt (Black) S', 3, 7, 6, '', 'S', 7, 12, 0, '15.000', '18.00', '26.91', '0.300', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [], \"Range\": \"Children\" }', '[]', '\"The Gu\" red shirt XML tag t-shirt (Black) S ', 1, '2016-05-31 23:00:00', '9999-12-31 23:59:59', NULL),
(93, '\"The Gu\" red shirt XML tag t-shirt (Black) M', 3, 7, 6, '', 'M', 7, 12, 0, '15.000', '18.00', '26.91', '0.350', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [], \"Range\": \"Teens/Young Adult\" }', '[]', '\"The Gu\" red shirt XML tag t-shirt (Black) M ', 1, '2016-05-31 23:00:00', '9999-12-31 23:59:59', NULL),
(94, '\"The Gu\" red shirt XML tag t-shirt (Black) L', 3, 7, 6, '', 'L', 7, 12, 0, '15.000', '18.00', '26.91', '0.350', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [], \"Range\": \"Adult\" }', '[]', '\"The Gu\" red shirt XML tag t-shirt (Black) L ', 1, '2016-05-31 23:00:00', '9999-12-31 23:59:59', NULL),
(95, '\"The Gu\" red shirt XML tag t-shirt (Black) XL', 3, 7, 6, '', 'XL', 7, 12, 0, '15.000', '18.00', '26.91', '0.350', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [], \"Range\": \"Adult\" }', '[]', '\"The Gu\" red shirt XML tag t-shirt (Black) XL ', 1, '2016-05-31 23:00:00', '9999-12-31 23:59:59', NULL),
(96, '\"The Gu\" red shirt XML tag t-shirt (Black) XXL', 3, 7, 6, '', 'XXL', 7, 12, 0, '15.000', '18.00', '26.91', '0.400', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [], \"Range\": \"Adult\" }', '[]', '\"The Gu\" red shirt XML tag t-shirt (Black) XXL ', 1, '2016-05-31 23:00:00', '9999-12-31 23:59:59', NULL),
(97, '\"The Gu\" red shirt XML tag t-shirt (Black) 3XL', 3, 7, 6, '', '3XL', 7, 12, 0, '15.000', '18.00', '26.91', '0.400', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [], \"Range\": \"Adult\" }', '[]', '\"The Gu\" red shirt XML tag t-shirt (Black) 3XL ', 1, '2016-05-31 23:00:00', '9999-12-31 23:59:59', NULL),
(98, '\"The Gu\" red shirt XML tag t-shirt (Black) 4XL', 3, 7, 6, '', '4XL', 7, 12, 0, '15.000', '18.00', '26.91', '0.400', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [], \"Range\": \"Adult\" }', '[]', '\"The Gu\" red shirt XML tag t-shirt (Black) 4XL ', 1, '2016-05-31 23:00:00', '9999-12-31 23:59:59', NULL),
(99, '\"The Gu\" red shirt XML tag t-shirt (Black) 5XL', 3, 7, 6, '', '5XL', 7, 12, 0, '15.000', '18.00', '26.91', '0.400', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [], \"Range\": \"Adult\" }', '[]', '\"The Gu\" red shirt XML tag t-shirt (Black) 5XL ', 1, '2016-05-31 23:00:00', '9999-12-31 23:59:59', NULL),
(100, '\"The Gu\" red shirt XML tag t-shirt (Black) 6XL', 3, 7, 6, '', '6XL', 7, 12, 0, '15.000', '18.00', '26.91', '0.400', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [], \"Range\": \"Adult\" }', '[]', '\"The Gu\" red shirt XML tag t-shirt (Black) 6XL ', 1, '2016-05-31 23:00:00', '9999-12-31 23:59:59', NULL),
(101, '\"The Gu\" red shirt XML tag t-shirt (Black) 7XL', 3, 7, 6, '', '7XL', 7, 12, 0, '15.000', '18.00', '26.91', '0.450', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [], \"Range\": \"Adult\" }', '[]', '\"The Gu\" red shirt XML tag t-shirt (Black) 7XL ', 1, '2016-05-31 23:00:00', '9999-12-31 23:59:59', NULL),
(102, 'Alien officer hoodie (Black) XL', 3, 7, 7, '', 'XL', 12, 1, 0, '15.000', '35.00', '52.33', '0.400', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [], \"Range\": \"Adult\" }', '[]', 'Alien officer hoodie (Black) XL ', 1, '2016-05-31 23:00:00', '9999-12-31 23:59:59', NULL),
(103, 'Alien officer hoodie (Black) XXL', 3, 7, 7, '', 'XXL', 12, 1, 0, '15.000', '35.00', '52.33', '0.400', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [], \"Range\": \"Adult\" }', '[]', 'Alien officer hoodie (Black) XXL ', 1, '2016-05-31 23:00:00', '9999-12-31 23:59:59', NULL),
(104, 'Alien officer hoodie (Black) 3XL', 3, 7, 7, '', '3XL', 12, 1, 0, '15.000', '35.00', '52.33', '0.400', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [], \"Range\": \"Adult\" }', '[]', 'Alien officer hoodie (Black) 3XL ', 1, '2016-05-31 23:00:00', '9999-12-31 23:59:59', NULL),
(105, 'Alien officer hoodie (Black) 4XL', 3, 7, 7, '', '4XL', 12, 1, 0, '15.000', '35.00', '52.33', '0.400', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [], \"Range\": \"Adult\" }', '[]', 'Alien officer hoodie (Black) 4XL ', 1, '2016-05-31 23:00:00', '9999-12-31 23:59:59', NULL),
(106, 'Alien officer hoodie (Black) 5XL', 3, 7, 7, '', '5XL', 12, 1, 0, '15.000', '35.00', '52.33', '0.400', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [], \"Range\": \"Adult\" }', '[]', 'Alien officer hoodie (Black) 5XL ', 1, '2016-05-31 23:00:00', '9999-12-31 23:59:59', NULL),
(107, 'Superhero action jacket (Blue) 3XS', 4, 7, 7, '', '3XS', 12, 1, 0, '15.000', '25.00', '37.38', '0.300', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [], \"Range\": \"Children\" }', '[]', 'Superhero action jacket (Blue) 3XS ', 1, '2016-05-31 23:00:00', '9999-12-31 23:59:59', NULL),
(108, 'Superhero action jacket (Blue) XXS', 4, 7, 7, '', 'XXS', 12, 1, 0, '15.000', '25.00', '37.38', '0.300', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [], \"Range\": \"Children\" }', '[]', 'Superhero action jacket (Blue) XXS ', 1, '2016-05-31 23:00:00', '9999-12-31 23:59:59', NULL),
(109, 'Superhero action jacket (Blue) XS', 4, 7, 7, '', 'XS', 12, 1, 0, '15.000', '25.00', '37.38', '0.300', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [], \"Range\": \"Children\" }', '[]', 'Superhero action jacket (Blue) XS ', 1, '2016-05-31 23:00:00', '9999-12-31 23:59:59', NULL),
(110, 'Superhero action jacket (Blue) S', 4, 7, 7, '', 'S', 12, 1, 0, '15.000', '25.00', '37.38', '0.300', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [], \"Range\": \"Children\" }', '[]', 'Superhero action jacket (Blue) S ', 1, '2016-05-31 23:00:00', '9999-12-31 23:59:59', NULL),
(111, 'Superhero action jacket (Blue) M', 4, 7, 7, '', 'M', 12, 1, 0, '15.000', '30.00', '44.85', '0.350', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [], \"Range\": \"Teens/Young Adult\" }', '[]', 'Superhero action jacket (Blue) M ', 1, '2016-05-31 23:00:00', '9999-12-31 23:59:59', NULL),
(112, 'Superhero action jacket (Blue) L', 4, 7, 7, '', 'L', 12, 1, 0, '15.000', '30.00', '44.85', '0.350', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [], \"Range\": \"Adult\" }', '[]', 'Superhero action jacket (Blue) L ', 1, '2016-05-31 23:00:00', '9999-12-31 23:59:59', NULL),
(113, 'Superhero action jacket (Blue) XL', 4, 7, 7, '', 'XL', 12, 1, 0, '15.000', '30.00', '44.85', '0.350', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [], \"Range\": \"Adult\" }', '[]', 'Superhero action jacket (Blue) XL ', 1, '2016-05-31 23:00:00', '9999-12-31 23:59:59', NULL),
(114, 'Superhero action jacket (Blue) XXL', 4, 7, 7, '', 'XXL', 12, 1, 0, '15.000', '30.00', '44.85', '0.350', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [], \"Range\": \"Adult\" }', '[]', 'Superhero action jacket (Blue) XXL ', 1, '2016-05-31 23:00:00', '9999-12-31 23:59:59', NULL),
(115, 'Superhero action jacket (Blue) 3XL', 4, 7, 7, '', '3XL', 12, 1, 0, '15.000', '34.00', '50.83', '0.400', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [], \"Range\": \"Adult\" }', '[]', 'Superhero action jacket (Blue) 3XL ', 1, '2016-05-31 23:00:00', '9999-12-31 23:59:59', NULL),
(116, 'Superhero action jacket (Blue) 4XL', 4, 7, 7, '', '4XL', 12, 1, 0, '15.000', '34.00', '50.83', '0.400', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [], \"Range\": \"Adult\" }', '[]', 'Superhero action jacket (Blue) 4XL ', 1, '2016-05-31 23:00:00', '9999-12-31 23:59:59', NULL),
(117, 'Superhero action jacket (Blue) 5XL', 4, 7, 7, '', '5XL', 12, 1, 0, '15.000', '34.00', '50.83', '0.400', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [], \"Range\": \"Adult\" }', '[]', 'Superhero action jacket (Blue) 5XL ', 1, '2016-05-31 23:00:00', '9999-12-31 23:59:59', NULL),
(118, 'Dinosaur battery-powered slippers (Green) S', 0, 7, 7, '', 'S', 12, 1, 0, '15.000', '32.00', '47.84', '0.350', 'Realistic sound of undergrowth being trampled while walking', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Comfortable\",\"Long Battery Life\"], \"Range\": \"Children\" }', '[\"Comfortable\",\"Long Battery Life\"]', 'Dinosaur battery-powered slippers (Green) S Realistic sound of undergrowth being trampled while walking', 1, '2016-05-31 23:08:00', '9999-12-31 23:59:59', NULL),
(119, 'Dinosaur battery-powered slippers (Green) M', 0, 7, 7, '', 'M', 12, 1, 0, '15.000', '32.00', '47.84', '0.350', 'Realistic sound of undergrowth being trampled while walking', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Comfortable\",\"Long Battery Life\"], \"Range\": \"Teens/Young Adult\" }', '[\"Comfortable\",\"Long Battery Life\"]', 'Dinosaur battery-powered slippers (Green) M Realistic sound of undergrowth being trampled while walking', 1, '2016-05-31 23:08:00', '9999-12-31 23:59:59', NULL),
(120, 'Dinosaur battery-powered slippers (Green) L', 0, 7, 7, '', 'L', 12, 1, 0, '15.000', '32.00', '47.84', '0.350', 'Realistic sound of undergrowth being trampled while walking', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Comfortable\",\"Long Battery Life\"], \"Range\": \"Adult\" }', '[\"Comfortable\",\"Long Battery Life\"]', 'Dinosaur battery-powered slippers (Green) L Realistic sound of undergrowth being trampled while walking', 1, '2016-05-31 23:08:00', '9999-12-31 23:59:59', NULL),
(121, 'Dinosaur battery-powered slippers (Green) XL', 0, 7, 7, '', 'XL', 12, 1, 0, '15.000', '32.00', '47.84', '0.400', 'Realistic sound of undergrowth being trampled while walking', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Comfortable\",\"Long Battery Life\"], \"Range\": \"Adult\" }', '[\"Comfortable\",\"Long Battery Life\"]', 'Dinosaur battery-powered slippers (Green) XL Realistic sound of undergrowth being trampled while walking', 1, '2016-05-31 23:08:00', '9999-12-31 23:59:59', NULL),
(122, 'Ogre battery-powered slippers (Green) S', 0, 7, 7, '', 'S', 12, 1, 0, '15.000', '32.00', '47.84', '0.350', 'Realistic heavy walking sound', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Comfortable\",\"Long Battery Life\"], \"Range\": \"Children\" }', '[\"Comfortable\",\"Long Battery Life\"]', 'Ogre battery-powered slippers (Green) S Realistic heavy walking sound', 1, '2016-05-31 23:08:00', '9999-12-31 23:59:59', NULL),
(123, 'Ogre battery-powered slippers (Green) M', 0, 7, 7, '', 'M', 12, 1, 0, '15.000', '32.00', '47.84', '0.350', 'Realistic heavy walking sound', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Comfortable\",\"Long Battery Life\"], \"Range\": \"Teens/Young Adult\" }', '[\"Comfortable\",\"Long Battery Life\"]', 'Ogre battery-powered slippers (Green) M Realistic heavy walking sound', 1, '2016-05-31 23:08:00', '9999-12-31 23:59:59', NULL),
(124, 'Ogre battery-powered slippers (Green) L', 0, 7, 7, '', 'L', 12, 1, 0, '15.000', '32.00', '47.84', '0.350', 'Realistic heavy walking sound', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Comfortable\",\"Long Battery Life\"], \"Range\": \"Adult\" }', '[\"Comfortable\",\"Long Battery Life\"]', 'Ogre battery-powered slippers (Green) L Realistic heavy walking sound', 1, '2016-05-31 23:08:00', '9999-12-31 23:59:59', NULL),
(125, 'Ogre battery-powered slippers (Green) XL', 0, 7, 7, '', 'XL', 12, 1, 0, '15.000', '32.00', '47.84', '0.400', 'Realistic heavy walking sound', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Comfortable\",\"Long Battery Life\"], \"Range\": \"Adult\" }', '[\"Comfortable\",\"Long Battery Life\"]', 'Ogre battery-powered slippers (Green) XL Realistic heavy walking sound', 1, '2016-05-31 23:08:00', '9999-12-31 23:59:59', NULL),
(126, 'Plush shark slippers (Gray) S', 12, 7, 7, '', 'S', 12, 1, 0, '15.000', '32.00', '47.84', '0.350', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Comfortable\",\"Long Battery Life\"], \"Range\": \"Children\" }', '[\"Comfortable\",\"Long Battery Life\"]', 'Plush shark slippers (Gray) S ', 1, '2016-05-31 23:08:00', '9999-12-31 23:59:59', NULL),
(127, 'Plush shark slippers (Gray) M', 12, 7, 7, '', 'M', 12, 1, 0, '15.000', '32.00', '47.84', '0.350', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Comfortable\",\"Long Battery Life\"], \"Range\": \"Teens/Young Adult\" }', '[\"Comfortable\",\"Long Battery Life\"]', 'Plush shark slippers (Gray) M ', 1, '2016-05-31 23:08:00', '9999-12-31 23:59:59', NULL),
(128, 'Plush shark slippers (Gray) L', 12, 7, 7, '', 'L', 12, 1, 0, '15.000', '32.00', '47.84', '0.350', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Comfortable\",\"Long Battery Life\"], \"Range\": \"Adult\" }', '[\"Comfortable\",\"Long Battery Life\"]', 'Plush shark slippers (Gray) L ', 1, '2016-05-31 23:08:00', '9999-12-31 23:59:59', NULL),
(129, 'Plush shark slippers (Gray) XL', 12, 7, 7, '', 'XL', 12, 1, 0, '15.000', '32.00', '47.84', '0.400', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Comfortable\",\"Long Battery Life\"], \"Range\": \"Adult\" }', '[\"Comfortable\",\"Long Battery Life\"]', 'Plush shark slippers (Gray) XL ', 1, '2016-05-31 23:08:00', '9999-12-31 23:59:59', NULL),
(130, 'Furry gorilla with big eyes slippers (Black) S', 3, 7, 7, '', 'S', 12, 1, 0, '15.000', '32.00', '47.84', '0.350', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Comfortable\",\"Long Battery Life\"], \"Range\": \"Children\" }', '[\"Comfortable\",\"Long Battery Life\"]', 'Furry gorilla with big eyes slippers (Black) S ', 1, '2016-05-31 23:08:00', '9999-12-31 23:59:59', NULL),
(131, 'Furry gorilla with big eyes slippers (Black) M', 3, 7, 7, '', 'M', 12, 1, 0, '15.000', '32.00', '47.84', '0.350', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Comfortable\",\"Long Battery Life\"], \"Range\": \"Teens/Young Adult\" }', '[\"Comfortable\",\"Long Battery Life\"]', 'Furry gorilla with big eyes slippers (Black) M ', 1, '2016-05-31 23:08:00', '9999-12-31 23:59:59', NULL),
(132, 'Furry gorilla with big eyes slippers (Black) L', 3, 7, 7, '', 'L', 12, 1, 0, '15.000', '32.00', '47.84', '0.350', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Comfortable\",\"Long Battery Life\"], \"Range\": \"Adult\" }', '[\"Comfortable\",\"Long Battery Life\"]', 'Furry gorilla with big eyes slippers (Black) L ', 1, '2016-05-31 23:08:00', '9999-12-31 23:59:59', NULL),
(133, 'Furry gorilla with big eyes slippers (Black) XL', 3, 7, 7, '', 'XL', 12, 1, 0, '15.000', '32.00', '47.84', '0.400', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Comfortable\",\"Long Battery Life\"], \"Range\": \"Adult\" }', '[\"Comfortable\",\"Long Battery Life\"]', 'Furry gorilla with big eyes slippers (Black) XL ', 1, '2016-05-31 23:08:00', '9999-12-31 23:59:59', NULL),
(134, 'Animal with big feet slippers (Brown) S', 0, 7, 7, '', 'S', 12, 1, 0, '15.000', '32.00', '47.84', '0.350', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Comfortable\",\"Long Battery Life\"], \"Range\": \"Children\" }', '[\"Comfortable\",\"Long Battery Life\"]', 'Animal with big feet slippers (Brown) S ', 1, '2016-05-31 23:08:00', '9999-12-31 23:59:59', NULL),
(135, 'Animal with big feet slippers (Brown) M', 0, 7, 7, '', 'M', 12, 1, 0, '15.000', '32.00', '47.84', '0.350', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Comfortable\",\"Long Battery Life\"], \"Range\": \"Teens/Young Adult\" }', '[\"Comfortable\",\"Long Battery Life\"]', 'Animal with big feet slippers (Brown) M ', 1, '2016-05-31 23:08:00', '9999-12-31 23:59:59', NULL),
(136, 'Animal with big feet slippers (Brown) L', 0, 7, 7, '', 'L', 12, 1, 0, '15.000', '32.00', '47.84', '0.350', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Comfortable\",\"Long Battery Life\"], \"Range\": \"Adult\" }', '[\"Comfortable\",\"Long Battery Life\"]', 'Animal with big feet slippers (Brown) L ', 1, '2016-05-31 23:08:00', '9999-12-31 23:59:59', NULL),
(137, 'Animal with big feet slippers (Brown) XL', 0, 7, 7, '', 'XL', 12, 1, 0, '15.000', '32.00', '47.84', '0.400', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Comfortable\",\"Long Battery Life\"], \"Range\": \"Adult\" }', '[\"Comfortable\",\"Long Battery Life\"]', 'Animal with big feet slippers (Brown) XL ', 1, '2016-05-31 23:08:00', '9999-12-31 23:59:59', NULL),
(138, 'Furry animal socks (Pink) S', 0, 10, 9, '', 'S', 12, 12, 0, '15.000', '5.00', '7.48', '0.100', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [], \"Range\": \"Children\" }', '[]', 'Furry animal socks (Pink) S ', 1, '2016-05-31 23:00:00', '9999-12-31 23:59:59', NULL);
INSERT INTO `stockitems` (`StockItemID`, `StockItemName`, `ColorID`, `UnitPackageID`, `OuterPackageID`, `Brand`, `Size`, `LeadTimeDays`, `QuantityPerOuter`, `IsChillerStock`, `TaxRate`, `UnitPrice`, `RecommendedRetailPrice`, `TypicalWeightPerUnit`, `MarketingComments`, `InternalComments`, `Photo`, `CustomFields`, `Tags`, `SearchDetails`, `LastEditedBy`, `ValidFrom`, `ValidTo`, `YouTubeID`) VALUES
(139, 'Furry animal socks (Pink) M', 0, 10, 9, '', 'M', 12, 12, 0, '15.000', '5.00', '7.48', '0.100', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [], \"Range\": \"Teens/Young Adult\" }', '[]', 'Furry animal socks (Pink) M ', 1, '2016-05-31 23:00:00', '9999-12-31 23:59:59', NULL),
(140, 'Furry animal socks (Pink) L', 0, 10, 9, '', 'L', 12, 12, 0, '15.000', '5.00', '7.48', '0.100', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [], \"Range\": \"Adult\" }', '[]', 'Furry animal socks (Pink) L ', 1, '2016-05-31 23:00:00', '9999-12-31 23:59:59', NULL),
(141, 'Furry animal socks (Pink) XL', 0, 10, 9, '', 'XL', 12, 12, 0, '15.000', '5.00', '7.48', '0.100', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [], \"Range\": \"Adult\" }', '[]', 'Furry animal socks (Pink) XL ', 1, '2016-05-31 23:00:00', '9999-12-31 23:59:59', NULL),
(142, 'Halloween zombie mask (Light Brown) S', 18, 7, 6, '', 'S', 12, 12, 0, '15.000', '18.00', '26.91', '0.300', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Halloween Fun\"], \"Range\": \"Children\" }', '[\"Halloween Fun\"]', 'Halloween zombie mask (Light Brown) S ', 1, '2016-05-31 23:04:00', '9999-12-31 23:59:59', NULL),
(143, 'Halloween zombie mask (Light Brown) M', 18, 7, 6, '', 'M', 12, 12, 0, '15.000', '18.00', '26.91', '0.300', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Halloween Fun\"], \"Range\": \"Teens/Young Adult\" }', '[\"Halloween Fun\"]', 'Halloween zombie mask (Light Brown) M ', 1, '2016-05-31 23:04:00', '9999-12-31 23:59:59', NULL),
(144, 'Halloween zombie mask (Light Brown) L', 18, 7, 6, '', 'L', 12, 12, 0, '15.000', '18.00', '26.91', '0.300', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Halloween Fun\"], \"Range\": \"Adult\" }', '[\"Halloween Fun\"]', 'Halloween zombie mask (Light Brown) L ', 1, '2016-05-31 23:04:00', '9999-12-31 23:59:59', NULL),
(145, 'Halloween zombie mask (Light Brown) XL', 18, 7, 6, '', 'XL', 12, 12, 0, '15.000', '18.00', '26.91', '0.300', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Halloween Fun\"], \"Range\": \"Adult\" }', '[\"Halloween Fun\"]', 'Halloween zombie mask (Light Brown) XL ', 1, '2016-05-31 23:04:00', '9999-12-31 23:59:59', NULL),
(146, 'Halloween skull mask (Gray) S', 12, 7, 6, '', 'S', 12, 12, 0, '15.000', '18.00', '26.91', '0.300', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Halloween Fun\"], \"Range\": \"Children\" }', '[\"Halloween Fun\"]', 'Halloween skull mask (Gray) S ', 1, '2016-05-31 23:04:00', '9999-12-31 23:59:59', NULL),
(147, 'Halloween skull mask (Gray) M', 12, 7, 6, '', 'M', 12, 12, 0, '15.000', '18.00', '26.91', '0.300', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Halloween Fun\"], \"Range\": \"Teens/Young Adult\" }', '[\"Halloween Fun\"]', 'Halloween skull mask (Gray) M ', 1, '2016-05-31 23:04:00', '9999-12-31 23:59:59', NULL),
(148, 'Halloween skull mask (Gray) L', 12, 7, 6, '', 'L', 12, 12, 0, '15.000', '18.00', '26.91', '0.300', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Halloween Fun\"], \"Range\": \"Adult\" }', '[\"Halloween Fun\"]', 'Halloween skull mask (Gray) L ', 1, '2016-05-31 23:04:00', '9999-12-31 23:59:59', NULL),
(149, 'Halloween skull mask (Gray) XL', 12, 7, 6, '', 'XL', 12, 12, 0, '15.000', '18.00', '26.91', '0.300', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Halloween Fun\"], \"Range\": \"Adult\" }', '[\"Halloween Fun\"]', 'Halloween skull mask (Gray) XL ', 1, '2016-05-31 23:04:00', '9999-12-31 23:59:59', NULL),
(150, 'Pack of 12 action figures (variety)', 0, 9, 9, '', '', 2, 1, 0, '15.000', '16.00', '23.92', '0.250', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Super Value\"] }', '[\"Super Value\"]', 'Pack of 12 action figures (variety) ', 1, '2016-05-31 23:05:00', '9999-12-31 23:59:59', NULL),
(151, 'Pack of 12 action figures (male)', 0, 9, 9, '', '', 2, 1, 0, '15.000', '16.00', '23.92', '0.250', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Super Value\"] }', '[\"Super Value\"]', 'Pack of 12 action figures (male) ', 1, '2016-05-31 23:05:00', '9999-12-31 23:59:59', NULL),
(152, 'Pack of 12 action figures (female)', 0, 9, 9, '', '', 2, 1, 0, '15.000', '16.00', '23.92', '0.250', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Super Value\"] }', '[\"Super Value\"]', 'Pack of 12 action figures (female) ', 1, '2016-05-31 23:05:00', '9999-12-31 23:59:59', NULL),
(153, 'Small sized bubblewrap roll 10m', 0, 7, 7, '', '10m', 14, 10, 0, '15.000', '4.50', '6.73', '5.000', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', 'Small sized bubblewrap roll 10m ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(154, 'Medium sized bubblewrap roll 20m', 0, 7, 7, '', '20m', 14, 10, 0, '15.000', '20.00', '29.90', '6.000', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', 'Medium sized bubblewrap roll 20m ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(155, 'Large sized bubblewrap roll 50m', 0, 7, 7, '', '50m', 14, 10, 0, '15.000', '24.00', '35.88', '10.000', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', 'Large sized bubblewrap roll 50m ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(156, '10 mm Double sided bubble wrap 10m', 0, 7, 7, '', '10m', 14, 10, 0, '15.000', '15.00', '22.43', '5.000', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', '10 mm Double sided bubble wrap 10m ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(157, '10 mm Double sided bubble wrap 20m', 0, 7, 7, '', '20m', 14, 10, 0, '15.000', '30.00', '44.85', '6.000', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', '10 mm Double sided bubble wrap 20m ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(158, '10 mm Double sided bubble wrap 50m', 0, 7, 7, '', '50m', 14, 10, 0, '15.000', '105.00', '156.98', '10.000', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', '10 mm Double sided bubble wrap 50m ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(159, '20 mm Double sided bubble wrap 10m', 0, 7, 7, '', '10m', 14, 10, 0, '15.000', '18.00', '26.91', '5.000', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', '20 mm Double sided bubble wrap 10m ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(160, '20 mm Double sided bubble wrap 20m', 0, 7, 7, '', '20m', 14, 10, 0, '15.000', '33.00', '49.34', '6.000', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', '20 mm Double sided bubble wrap 20m ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(161, '20 mm Double sided bubble wrap 50m', 0, 7, 7, '', '50m', 14, 10, 0, '15.000', '108.00', '161.46', '10.000', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', '20 mm Double sided bubble wrap 50m ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(162, '32 mm Double sided bubble wrap 10m', 0, 7, 7, '', '10m', 14, 10, 0, '15.000', '22.00', '32.89', '5.000', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', '32 mm Double sided bubble wrap 10m ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(163, '32 mm Double sided bubble wrap 20m', 0, 7, 7, '', '20m', 14, 10, 0, '15.000', '37.00', '55.32', '6.000', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', '32 mm Double sided bubble wrap 20m ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(164, '32 mm Double sided bubble wrap 50m', 0, 7, 7, '', '50m', 14, 10, 0, '15.000', '112.00', '167.44', '10.000', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', '32 mm Double sided bubble wrap 50m ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(165, '10 mm Anti static bubble wrap (Blue) 10m', 4, 7, 7, '', '10m', 14, 10, 0, '15.000', '26.00', '38.87', '5.000', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', '10 mm Anti static bubble wrap (Blue) 10m ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(166, '10 mm Anti static bubble wrap (Blue) 20m', 4, 7, 7, '', '20m', 14, 10, 0, '15.000', '42.00', '62.79', '6.000', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', '10 mm Anti static bubble wrap (Blue) 20m ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(167, '10 mm Anti static bubble wrap (Blue) 50m', 4, 7, 7, '', '50m', 14, 10, 0, '15.000', '99.00', '148.01', '10.000', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', '10 mm Anti static bubble wrap (Blue) 50m ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(168, '20 mm Anti static bubble wrap (Blue) 10m', 4, 7, 7, '', '10m', 14, 10, 0, '15.000', '29.00', '43.36', '5.000', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', '20 mm Anti static bubble wrap (Blue) 10m ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(169, '20 mm Anti static bubble wrap (Blue) 20m', 4, 7, 7, '', '20m', 14, 10, 0, '15.000', '45.00', '67.28', '6.000', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', '20 mm Anti static bubble wrap (Blue) 20m ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(170, '20 mm Anti static bubble wrap (Blue) 50m', 4, 7, 7, '', '50m', 14, 10, 0, '15.000', '102.00', '152.49', '10.000', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', '20 mm Anti static bubble wrap (Blue) 50m ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(171, '32 mm Anti static bubble wrap (Blue) 10m', 4, 7, 7, '', '10m', 14, 10, 0, '15.000', '32.00', '47.84', '5.000', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', '32 mm Anti static bubble wrap (Blue) 10m ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(172, '32 mm Anti static bubble wrap (Blue) 20m', 4, 7, 7, '', '20m', 14, 10, 0, '15.000', '48.00', '71.76', '6.000', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', '32 mm Anti static bubble wrap (Blue) 20m ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(173, '32 mm Anti static bubble wrap (Blue) 50m', 4, 7, 7, '', '50m', 14, 10, 0, '15.000', '105.00', '156.98', '10.000', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', '32 mm Anti static bubble wrap (Blue) 50m ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(174, 'Bubblewrap dispenser (Black) 1.5m', 3, 7, 7, '', '1.5m', 14, 1, 0, '15.000', '240.00', '358.80', '10.000', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', 'Bubblewrap dispenser (Black) 1.5m ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(175, 'Bubblewrap dispenser (Blue) 1.5m', 4, 7, 7, '', '1.5m', 14, 1, 0, '15.000', '240.00', '358.80', '10.000', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', 'Bubblewrap dispenser (Blue) 1.5m ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(176, 'Bubblewrap dispenser (Red) 1.5m', 28, 7, 7, '', '1.5m', 14, 1, 0, '15.000', '240.00', '358.80', '10.000', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', 'Bubblewrap dispenser (Red) 1.5m ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(177, 'Shipping carton (Brown) 413x285x187mm', 0, 7, 7, '', '413x285x187mm', 14, 25, 0, '15.000', '1.05', '1.57', '0.300', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', 'Shipping carton (Brown) 413x285x187mm ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(178, 'Shipping carton (Brown) 500x310x310mm', 0, 7, 7, '', '500x310x310mm', 14, 25, 0, '15.000', '2.55', '3.81', '0.400', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', 'Shipping carton (Brown) 500x310x310mm ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(179, 'Shipping carton (Brown) 229x229x229mm', 0, 7, 7, '', '229x229x229mm', 14, 25, 0, '15.000', '1.05', '1.57', '0.300', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', 'Shipping carton (Brown) 229x229x229mm ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(180, 'Shipping carton (Brown) 279x254x217mm', 0, 7, 7, '', '279x254x217mm', 14, 25, 0, '15.000', '1.11', '1.66', '0.300', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', 'Shipping carton (Brown) 279x254x217mm ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(181, 'Shipping carton (Brown) 356x229x229mm', 0, 7, 7, '', '356x229x229mm', 14, 25, 0, '15.000', '1.14', '1.70', '0.400', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', 'Shipping carton (Brown) 356x229x229mm ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(182, 'Shipping carton (Brown) 457x279x279mm', 0, 7, 7, '', '457x279x279mm', 14, 25, 0, '15.000', '1.28', '1.91', '0.400', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', 'Shipping carton (Brown) 457x279x279mm ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(183, 'Shipping carton (Brown) 480x270x320mm', 0, 7, 7, '', '480x270x320mm', 14, 25, 0, '15.000', '2.74', '4.10', '0.400', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', 'Shipping carton (Brown) 480x270x320mm ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(184, 'Shipping carton (Brown) 305x305x305mm', 0, 7, 7, '', '305x305x305mm', 14, 25, 0, '15.000', '3.50', '5.23', '0.300', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', 'Shipping carton (Brown) 305x305x305mm ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(185, 'Shipping carton (Brown) 356x356x279mm', 0, 7, 7, '', '356x356x279mm', 14, 25, 0, '15.000', '2.04', '3.05', '0.300', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', 'Shipping carton (Brown) 356x356x279mm ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(186, 'Shipping carton (Brown) 457x457x457mm', 0, 7, 7, '', '457x457x457mm', 14, 25, 0, '15.000', '2.10', '3.14', '0.400', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', 'Shipping carton (Brown) 457x457x457mm ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(187, 'Express post box 5kg (White) 350x280x130mm', 0, 7, 7, '', '350x280x130mm', 14, 25, 0, '15.000', '0.95', '1.42', '0.200', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', 'Express post box 5kg (White) 350x280x130mm ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(188, '3 kg Courier post bag (White) 300x190x95mm', 0, 7, 7, '', '300x190x95mm', 14, 25, 0, '15.000', '0.66', '0.99', '0.100', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', '3 kg Courier post bag (White) 300x190x95mm ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(189, 'Clear packaging tape 48mmx75m', 0, 7, 7, '', '48mmx75m', 14, 26, 0, '15.000', '2.90', '4.34', '0.500', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', 'Clear packaging tape 48mmx75m ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(190, 'Clear packaging tape 48mmx100m', 0, 7, 7, '', '48mmx100m', 14, 20, 0, '15.000', '3.50', '5.23', '0.700', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', 'Clear packaging tape 48mmx100m ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(191, 'Black and orange fragile despatch tape 48mmx75m', 0, 7, 7, '', '48mmx75m', 14, 36, 0, '15.000', '3.70', '5.53', '0.500', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', 'Black and orange fragile despatch tape 48mmx75m ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(192, 'Black and orange fragile despatch tape 48mmx100m', 0, 7, 7, '', '48mmx100m', 14, 36, 0, '15.000', '4.10', '6.13', '0.700', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', 'Black and orange fragile despatch tape 48mmx100m ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(193, 'Black and orange glass with care despatch tape 48mmx75m', 0, 7, 7, '', '48mmx75m', 14, 24, 0, '15.000', '3.70', '5.53', '0.500', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', 'Black and orange glass with care despatch tape 48mmx75m ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(194, 'Black and orange glass with care despatch tape  48mmx100m', 0, 7, 7, '', '48mmx100m', 14, 24, 0, '15.000', '4.10', '6.13', '0.700', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', 'Black and orange glass with care despatch tape  48mmx100m ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(195, 'Black and orange handle with care despatch tape  48mmx75m', 0, 7, 7, '', '48mmx75m', 14, 24, 0, '15.000', '3.70', '5.53', '0.500', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', 'Black and orange handle with care despatch tape  48mmx75m ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(196, 'Black and orange handle with care despatch tape  48mmx100m', 0, 7, 7, '', '48mmx100m', 14, 24, 0, '15.000', '4.10', '6.13', '0.700', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', 'Black and orange handle with care despatch tape  48mmx100m ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(197, 'Black and orange this way up despatch tape 48mmx75m', 0, 7, 7, '', '48mmx75m', 14, 24, 0, '15.000', '3.70', '5.53', '0.500', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', 'Black and orange this way up despatch tape 48mmx75m ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(198, 'Black and orange this way up despatch tape  48mmx100m', 0, 7, 7, '', '48mmx100m', 14, 24, 0, '15.000', '4.10', '6.13', '0.700', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', 'Black and orange this way up despatch tape  48mmx100m ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(199, 'Black and yellow heavy despatch tape  48mmx75m', 0, 7, 7, '', '48mmx75m', 14, 24, 0, '15.000', '3.70', '5.53', '0.500', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', 'Black and yellow heavy despatch tape  48mmx75m ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(200, 'Black and yellow heavy despatch tape 48mmx100m', 0, 7, 7, '', '48mmx100m', 14, 24, 0, '15.000', '4.10', '6.13', '0.700', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', 'Black and yellow heavy despatch tape 48mmx100m ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(201, 'Red and white urgent despatch tape 48mmx75m', 0, 7, 7, '', '48mmx75m', 14, 24, 0, '15.000', '3.70', '5.53', '0.500', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', 'Red and white urgent despatch tape 48mmx75m ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(202, 'Red and white urgent  heavy despatch tape  48mmx100m', 0, 7, 7, '', '48mmx100m', 14, 24, 0, '15.000', '4.10', '6.13', '0.700', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', 'Red and white urgent  heavy despatch tape  48mmx100m ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(203, 'Tape dispenser (Black)', 0, 7, 7, '', '', 20, 10, 0, '15.000', '32.00', '47.84', '1.000', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', 'Tape dispenser (Black) ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(204, 'Tape dispenser (Red)', 0, 7, 7, '', '', 20, 10, 0, '15.000', '32.00', '47.84', '1.000', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', 'Tape dispenser (Red) ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(205, 'Tape dispenser (Blue)', 0, 7, 7, '', '', 20, 10, 0, '15.000', '32.00', '47.84', '1.000', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', 'Tape dispenser (Blue) ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(206, 'Permanent marker black 5mm nib (Black) 5mm', 0, 7, 7, '', '5mm', 14, 12, 0, '15.000', '2.70', '4.04', '0.100', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', 'Permanent marker black 5mm nib (Black) 5mm ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(207, 'Permanent marker blue 5mm nib (Blue) 5mm', 0, 7, 7, '', '5mm', 14, 12, 0, '15.000', '2.70', '4.04', '0.100', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', 'Permanent marker blue 5mm nib (Blue) 5mm ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(208, 'Permanent marker red 5mm nib (Red) 5mm', 0, 7, 7, '', '5mm', 14, 12, 0, '15.000', '2.70', '4.04', '0.100', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', 'Permanent marker red 5mm nib (Red) 5mm ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(209, 'Packing knife with metal insert blade (Yellow) 9mm', 0, 7, 7, '', '9mm', 14, 5, 0, '15.000', '1.89', '2.83', '0.500', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', 'Packing knife with metal insert blade (Yellow) 9mm ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(210, 'Packing knife with metal insert blade (Yellow) 18mm', 0, 7, 7, '', '18mm', 14, 5, 0, '15.000', '2.40', '3.59', '0.500', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', 'Packing knife with metal insert blade (Yellow) 18mm ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(211, 'Small 9mm replacement blades 9mm', 0, 7, 7, '', '9mm', 14, 10, 0, '15.000', '4.10', '6.13', '0.700', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', 'Small 9mm replacement blades 9mm ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(212, 'Large  replacement blades 18mm', 0, 7, 7, '', '18mm', 14, 10, 0, '15.000', '4.30', '6.43', '0.800', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', 'Large  replacement blades 18mm ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(213, 'Air cushion film 200mmx100mm 325m', 0, 7, 7, '', '325m', 14, 1, 0, '15.000', '87.00', '130.07', '5.000', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', 'Air cushion film 200mmx100mm 325m ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(214, 'Air cushion film 200mmx200mm 325m', 0, 7, 7, '', '325m', 14, 1, 0, '15.000', '90.00', '134.55', '6.000', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', 'Air cushion film 200mmx200mm 325m ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(215, 'Air cushion machine (Blue)', 0, 7, 7, '', '', 20, 1, 0, '15.000', '1899.00', '2839.01', '10.000', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', 'Air cushion machine (Blue) ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(216, 'Void fill 100 L bag (White) 100L', 0, 7, 7, '', '100L', 14, 10, 0, '15.000', '12.50', '18.69', '0.250', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', 'Void fill 100 L bag (White) 100L ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(217, 'Void fill 200 L bag (White) 200L', 0, 7, 7, '', '200L', 14, 10, 0, '15.000', '25.00', '37.38', '0.500', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', 'Void fill 200 L bag (White) 200L ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(218, 'Void fill 300 L bag (White) 300L', 0, 7, 7, '', '300L', 14, 10, 0, '15.000', '37.50', '56.06', '0.750', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', 'Void fill 300 L bag (White) 300L ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(219, 'Void fill 400 L bag (White) 400L', 0, 7, 7, '', '400L', 14, 10, 0, '15.000', '50.00', '74.75', '1.000', '', '', '', '{ \"CountryOfManufacture\": \"China\", \"Tags\": [\"Limited Stock\"] }', '[\"Limited Stock\"]', 'Void fill 400 L bag (White) 400L ', 1, '2016-05-31 23:12:00', '9999-12-31 23:59:59', NULL),
(220, 'Novelty chilli chocolates 250g', 0, 1, 6, '', '250g', 3, 24, 1, '10.000', '8.55', '12.23', '0.250', 'Watch your friends faces when they eat these', '', '', '{ \"CountryOfManufacture\": \"USA\", \"ShelfLife\": \"7 days\", \"Tags\": [] }', '[]', 'Novelty chilli chocolates 250g Watch your friends faces when they eat these', 1, '2016-05-31 23:00:00', '9999-12-31 23:59:59', NULL),
(221, 'Novelty chilli chocolates 500g', 0, 1, 6, '', '500g', 3, 12, 1, '10.000', '14.50', '20.74', '0.500', 'Watch your friends faces when they eat these', '', '', '{ \"CountryOfManufacture\": \"USA\", \"ShelfLife\": \"7 days\", \"Tags\": [] }', '[]', 'Novelty chilli chocolates 500g Watch your friends faces when they eat these', 1, '2016-05-31 23:00:00', '9999-12-31 23:59:59', NULL),
(222, 'Chocolate beetles 250g', 0, 1, 6, '', '250g', 3, 24, 1, '10.000', '8.55', '12.23', '0.250', 'Perfect for your child\'s party', '', '', '{ \"CountryOfManufacture\": \"USA\", \"ShelfLife\": \"7 days\", \"Tags\": [] }', '[]', 'Chocolate beetles 250g Perfect for your child\'s party', 1, '2016-05-31 23:00:00', '9999-12-31 23:59:59', NULL),
(223, 'Chocolate echidnas 250g', 0, 1, 6, '', '250g', 3, 24, 1, '10.000', '8.55', '12.23', '0.250', 'Perfect for your child\'s party', '', '', '{ \"CountryOfManufacture\": \"USA\", \"ShelfLife\": \"7 days\", \"Tags\": [] }', '[]', 'Chocolate echidnas 250g Perfect for your child\'s party', 1, '2016-05-31 23:00:00', '9999-12-31 23:59:59', NULL),
(224, 'Chocolate frogs 250g', 0, 1, 6, '', '250g', 3, 24, 1, '10.000', '8.55', '12.23', '0.250', 'Perfect for your child\'s party', '', '', '{ \"CountryOfManufacture\": \"USA\", \"ShelfLife\": \"7 days\", \"Tags\": [] }', '[]', 'Chocolate frogs 250g Perfect for your child\'s party', 1, '2016-05-31 23:00:00', '9999-12-31 23:59:59', NULL),
(225, 'Chocolate sharks 250g', 0, 1, 6, '', '250g', 3, 24, 1, '10.000', '8.55', '12.23', '0.250', 'Perfect for your child\'s party', '', '', '{ \"CountryOfManufacture\": \"USA\", \"ShelfLife\": \"7 days\", \"Tags\": [] }', '[]', 'Chocolate sharks 250g Perfect for your child\'s party', 1, '2016-05-31 23:00:00', '9999-12-31 23:59:59', NULL),
(226, 'White chocolate snow balls 250g', 0, 1, 6, '', '250g', 3, 24, 1, '10.000', '8.55', '12.23', '0.250', 'Perfect for your child\'s party', '', '', '{ \"CountryOfManufacture\": \"USA\", \"ShelfLife\": \"7 days\", \"Tags\": [] }', '[]', 'White chocolate snow balls 250g Perfect for your child\'s party', 1, '2016-05-31 23:00:00', '9999-12-31 23:59:59', NULL),
(227, 'White chocolate moon rocks 250g', 0, 1, 6, '', '250g', 3, 24, 1, '10.000', '8.55', '12.23', '0.250', 'Perfect for your child\'s party', '', '', '{ \"CountryOfManufacture\": \"USA\", \"ShelfLife\": \"7 days\", \"Tags\": [] }', '[]', 'White chocolate moon rocks 250g Perfect for your child\'s party', 1, '2016-05-31 23:00:00', '9999-12-31 23:59:59', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `stockitemstockgroups`
--

CREATE TABLE `stockitemstockgroups` (
	`StockItemStockGroupID` int(11) NOT NULL,
	`StockItemID` int(11) NOT NULL,
	`StockGroupID` int(11) NOT NULL,
	`LastEditedBy` int(11) NOT NULL,
	`LastEditedWhen` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `stockitemstockgroups`
--

INSERT INTO `stockitemstockgroups` (`StockItemStockGroupID`, `StockItemID`, `StockGroupID`, `LastEditedBy`, `LastEditedWhen`) VALUES
(1, 1, 6, 1, '2013-01-01 00:00:00'),
(2, 1, 1, 1, '2013-01-01 00:00:00'),
(3, 1, 7, 1, '2013-01-01 00:00:00'),
(4, 2, 6, 1, '2013-01-01 00:00:00'),
(5, 2, 1, 1, '2013-01-01 00:00:00'),
(6, 2, 7, 1, '2013-01-01 00:00:00'),
(7, 3, 6, 1, '2013-01-01 00:00:00'),
(8, 3, 1, 1, '2013-01-01 00:00:00'),
(9, 4, 6, 1, '2013-01-01 00:00:00'),
(10, 4, 1, 1, '2013-01-01 00:00:00'),
(11, 4, 7, 1, '2013-01-01 00:00:00'),
(12, 5, 6, 1, '2013-01-01 00:00:00'),
(13, 5, 1, 1, '2013-01-01 00:00:00'),
(14, 5, 7, 1, '2013-01-01 00:00:00'),
(15, 6, 6, 1, '2013-01-01 00:00:00'),
(16, 6, 1, 1, '2013-01-01 00:00:00'),
(17, 6, 7, 1, '2013-01-01 00:00:00'),
(18, 7, 6, 1, '2013-01-01 00:00:00'),
(19, 7, 1, 1, '2013-01-01 00:00:00'),
(20, 7, 7, 1, '2013-01-01 00:00:00'),
(21, 8, 6, 1, '2013-01-01 00:00:00'),
(22, 8, 1, 1, '2013-01-01 00:00:00'),
(23, 8, 7, 1, '2013-01-01 00:00:00'),
(24, 9, 6, 1, '2013-01-01 00:00:00'),
(25, 9, 1, 1, '2013-01-01 00:00:00'),
(26, 9, 7, 1, '2013-01-01 00:00:00'),
(27, 10, 6, 1, '2013-01-01 00:00:00'),
(28, 10, 1, 1, '2013-01-01 00:00:00'),
(29, 10, 7, 1, '2013-01-01 00:00:00'),
(30, 11, 6, 1, '2013-01-01 00:00:00'),
(31, 11, 1, 1, '2013-01-01 00:00:00'),
(32, 11, 7, 1, '2013-01-01 00:00:00'),
(33, 12, 6, 1, '2013-01-01 00:00:00'),
(34, 12, 1, 1, '2013-01-01 00:00:00'),
(35, 12, 7, 1, '2013-01-01 00:00:00'),
(36, 13, 6, 1, '2013-01-01 00:00:00'),
(37, 13, 1, 1, '2013-01-01 00:00:00'),
(38, 13, 7, 1, '2013-01-01 00:00:00'),
(39, 14, 6, 1, '2013-01-01 00:00:00'),
(40, 14, 1, 1, '2013-01-01 00:00:00'),
(41, 14, 7, 1, '2013-01-01 00:00:00'),
(42, 15, 6, 1, '2013-01-01 00:00:00'),
(43, 15, 1, 1, '2013-01-01 00:00:00'),
(44, 15, 7, 1, '2013-01-01 00:00:00'),
(45, 16, 6, 1, '2013-01-01 00:00:00'),
(46, 16, 3, 1, '2013-01-01 00:00:00'),
(47, 16, 1, 1, '2013-01-01 00:00:00'),
(48, 17, 6, 1, '2013-01-01 00:00:00'),
(49, 17, 3, 1, '2013-01-01 00:00:00'),
(50, 17, 1, 1, '2013-01-01 00:00:00'),
(51, 18, 6, 1, '2013-01-01 00:00:00'),
(52, 18, 3, 1, '2013-01-01 00:00:00'),
(53, 18, 1, 1, '2013-01-01 00:00:00'),
(54, 19, 6, 1, '2013-01-01 00:00:00'),
(55, 19, 3, 1, '2013-01-01 00:00:00'),
(56, 19, 1, 1, '2013-01-01 00:00:00'),
(57, 20, 6, 1, '2013-01-01 00:00:00'),
(58, 20, 3, 1, '2013-01-01 00:00:00'),
(59, 20, 1, 1, '2013-01-01 00:00:00'),
(60, 21, 6, 1, '2013-01-01 00:00:00'),
(61, 21, 3, 1, '2013-01-01 00:00:00'),
(62, 21, 1, 1, '2013-01-01 00:00:00'),
(63, 22, 6, 1, '2013-01-01 00:00:00'),
(64, 22, 3, 1, '2013-01-01 00:00:00'),
(65, 22, 1, 1, '2013-01-01 00:00:00'),
(66, 23, 6, 1, '2013-01-01 00:00:00'),
(67, 23, 3, 1, '2013-01-01 00:00:00'),
(68, 23, 1, 1, '2013-01-01 00:00:00'),
(69, 24, 6, 1, '2013-01-01 00:00:00'),
(70, 24, 3, 1, '2013-01-01 00:00:00'),
(71, 24, 1, 1, '2013-01-01 00:00:00'),
(72, 25, 6, 1, '2013-01-01 00:00:00'),
(73, 25, 3, 1, '2013-01-01 00:00:00'),
(74, 25, 1, 1, '2013-01-01 00:00:00'),
(75, 26, 6, 1, '2013-01-01 00:00:00'),
(76, 26, 3, 1, '2013-01-01 00:00:00'),
(77, 26, 1, 1, '2013-01-01 00:00:00'),
(78, 27, 6, 1, '2013-01-01 00:00:00'),
(79, 27, 3, 1, '2013-01-01 00:00:00'),
(80, 27, 1, 1, '2013-01-01 00:00:00'),
(81, 28, 6, 1, '2013-01-01 00:00:00'),
(82, 28, 3, 1, '2013-01-01 00:00:00'),
(83, 28, 1, 1, '2013-01-01 00:00:00'),
(84, 29, 6, 1, '2013-01-01 00:00:00'),
(85, 29, 3, 1, '2013-01-01 00:00:00'),
(86, 29, 1, 1, '2013-01-01 00:00:00'),
(87, 30, 6, 1, '2013-01-01 00:00:00'),
(88, 30, 3, 1, '2013-01-01 00:00:00'),
(89, 30, 1, 1, '2013-01-01 00:00:00'),
(90, 31, 6, 1, '2013-01-01 00:00:00'),
(91, 31, 3, 1, '2013-01-01 00:00:00'),
(92, 31, 1, 1, '2013-01-01 00:00:00'),
(93, 32, 6, 1, '2013-01-01 00:00:00'),
(94, 32, 3, 1, '2013-01-01 00:00:00'),
(95, 32, 1, 1, '2013-01-01 00:00:00'),
(96, 33, 6, 1, '2013-01-01 00:00:00'),
(97, 33, 3, 1, '2013-01-01 00:00:00'),
(98, 33, 1, 1, '2013-01-01 00:00:00'),
(99, 34, 6, 1, '2013-01-01 00:00:00'),
(100, 34, 3, 1, '2013-01-01 00:00:00'),
(101, 34, 1, 1, '2013-01-01 00:00:00'),
(102, 35, 6, 1, '2013-01-01 00:00:00'),
(103, 35, 3, 1, '2013-01-01 00:00:00'),
(104, 35, 1, 1, '2013-01-01 00:00:00'),
(105, 36, 6, 1, '2013-01-01 00:00:00'),
(106, 36, 3, 1, '2013-01-01 00:00:00'),
(107, 36, 1, 1, '2013-01-01 00:00:00'),
(108, 37, 6, 1, '2013-01-01 00:00:00'),
(109, 37, 3, 1, '2013-01-01 00:00:00'),
(110, 37, 1, 1, '2013-01-01 00:00:00'),
(111, 38, 6, 1, '2013-01-01 00:00:00'),
(112, 38, 3, 1, '2013-01-01 00:00:00'),
(113, 38, 1, 1, '2013-01-01 00:00:00'),
(114, 39, 6, 1, '2013-01-01 00:00:00'),
(115, 39, 3, 1, '2013-01-01 00:00:00'),
(116, 39, 1, 1, '2013-01-01 00:00:00'),
(117, 40, 6, 1, '2013-01-01 00:00:00'),
(118, 40, 3, 1, '2013-01-01 00:00:00'),
(119, 40, 1, 1, '2013-01-01 00:00:00'),
(120, 41, 6, 1, '2013-01-01 00:00:00'),
(121, 41, 3, 1, '2013-01-01 00:00:00'),
(122, 41, 1, 1, '2013-01-01 00:00:00'),
(123, 42, 6, 1, '2013-01-01 00:00:00'),
(124, 42, 3, 1, '2013-01-01 00:00:00'),
(125, 42, 1, 1, '2013-01-01 00:00:00'),
(126, 43, 6, 1, '2013-01-01 00:00:00'),
(127, 43, 3, 1, '2013-01-01 00:00:00'),
(128, 43, 1, 1, '2013-01-01 00:00:00'),
(129, 44, 6, 1, '2013-01-01 00:00:00'),
(130, 44, 3, 1, '2013-01-01 00:00:00'),
(131, 44, 1, 1, '2013-01-01 00:00:00'),
(132, 45, 6, 1, '2013-01-01 00:00:00'),
(133, 45, 3, 1, '2013-01-01 00:00:00'),
(134, 45, 1, 1, '2013-01-01 00:00:00'),
(135, 46, 6, 1, '2013-01-01 00:00:00'),
(136, 46, 3, 1, '2013-01-01 00:00:00'),
(137, 46, 1, 1, '2013-01-01 00:00:00'),
(138, 47, 6, 1, '2013-01-01 00:00:00'),
(139, 47, 3, 1, '2013-01-01 00:00:00'),
(140, 47, 1, 1, '2013-01-01 00:00:00'),
(141, 48, 6, 1, '2013-01-01 00:00:00'),
(142, 48, 3, 1, '2013-01-01 00:00:00'),
(143, 48, 1, 1, '2013-01-01 00:00:00'),
(144, 49, 6, 1, '2013-01-01 00:00:00'),
(145, 49, 3, 1, '2013-01-01 00:00:00'),
(146, 49, 1, 1, '2013-01-01 00:00:00'),
(147, 50, 6, 1, '2013-01-01 00:00:00'),
(148, 50, 3, 1, '2013-01-01 00:00:00'),
(149, 50, 1, 1, '2013-01-01 00:00:00'),
(150, 51, 6, 1, '2013-01-01 00:00:00'),
(151, 51, 3, 1, '2013-01-01 00:00:00'),
(152, 51, 1, 1, '2013-01-01 00:00:00'),
(153, 52, 6, 1, '2013-01-01 00:00:00'),
(154, 52, 3, 1, '2013-01-01 00:00:00'),
(155, 52, 1, 1, '2013-01-01 00:00:00'),
(156, 53, 6, 1, '2013-01-01 00:00:00'),
(157, 53, 3, 1, '2013-01-01 00:00:00'),
(158, 53, 1, 1, '2013-01-01 00:00:00'),
(159, 54, 6, 1, '2013-01-01 00:00:00'),
(160, 54, 3, 1, '2013-01-01 00:00:00'),
(161, 54, 1, 1, '2013-01-01 00:00:00'),
(162, 55, 6, 1, '2013-01-01 00:00:00'),
(163, 55, 3, 1, '2013-01-01 00:00:00'),
(164, 55, 1, 1, '2013-01-01 00:00:00'),
(165, 56, 6, 1, '2013-01-01 00:00:00'),
(166, 56, 3, 1, '2013-01-01 00:00:00'),
(167, 56, 1, 1, '2013-01-01 00:00:00'),
(168, 57, 6, 1, '2013-01-01 00:00:00'),
(169, 57, 3, 1, '2013-01-01 00:00:00'),
(170, 57, 1, 1, '2013-01-01 00:00:00'),
(171, 58, 1, 1, '2013-01-01 00:00:00'),
(172, 58, 9, 1, '2013-01-01 00:00:00'),
(173, 59, 1, 1, '2013-01-01 00:00:00'),
(174, 59, 9, 1, '2013-01-01 00:00:00'),
(175, 60, 1, 1, '2013-01-01 00:00:00'),
(176, 60, 9, 1, '2013-01-01 00:00:00'),
(177, 61, 1, 1, '2013-01-01 00:00:00'),
(178, 61, 9, 1, '2013-01-01 00:00:00'),
(179, 62, 1, 1, '2013-01-01 00:00:00'),
(180, 62, 9, 1, '2013-01-01 00:00:00'),
(181, 63, 1, 1, '2013-01-01 00:00:00'),
(182, 63, 9, 1, '2013-01-01 00:00:00'),
(183, 64, 1, 1, '2013-01-01 00:00:00'),
(184, 64, 9, 1, '2013-01-01 00:00:00'),
(185, 65, 1, 1, '2013-01-01 00:00:00'),
(186, 65, 9, 1, '2013-01-01 00:00:00'),
(187, 66, 1, 1, '2013-01-01 00:00:00'),
(188, 66, 9, 1, '2013-01-01 00:00:00'),
(189, 67, 1, 1, '2013-01-01 00:00:00'),
(190, 67, 9, 1, '2013-01-01 00:00:00'),
(191, 68, 1, 1, '2013-01-01 00:00:00'),
(192, 68, 9, 1, '2013-01-01 00:00:00'),
(193, 69, 1, 1, '2013-01-01 00:00:00'),
(194, 69, 9, 1, '2013-01-01 00:00:00'),
(195, 70, 1, 1, '2013-01-01 00:00:00'),
(196, 70, 9, 1, '2013-01-01 00:00:00'),
(197, 71, 1, 1, '2013-01-01 00:00:00'),
(198, 71, 9, 1, '2013-01-01 00:00:00'),
(199, 72, 1, 1, '2013-01-01 00:00:00'),
(200, 72, 9, 1, '2013-01-01 00:00:00'),
(201, 73, 1, 1, '2013-01-01 00:00:00'),
(202, 73, 9, 1, '2013-01-01 00:00:00'),
(203, 74, 1, 1, '2013-01-01 00:00:00'),
(204, 74, 9, 1, '2013-01-01 00:00:00'),
(205, 75, 1, 1, '2013-01-01 00:00:00'),
(206, 75, 9, 1, '2013-01-01 00:00:00'),
(207, 76, 2, 1, '2013-01-01 00:00:00'),
(208, 76, 6, 1, '2013-01-01 00:00:00'),
(209, 76, 4, 1, '2013-01-01 00:00:00'),
(210, 77, 2, 1, '2013-01-01 00:00:00'),
(211, 77, 6, 1, '2013-01-01 00:00:00'),
(212, 77, 4, 1, '2013-01-01 00:00:00'),
(213, 78, 2, 1, '2013-01-01 00:00:00'),
(214, 78, 6, 1, '2013-01-01 00:00:00'),
(215, 78, 4, 1, '2013-01-01 00:00:00'),
(216, 79, 2, 1, '2013-01-01 00:00:00'),
(217, 79, 6, 1, '2013-01-01 00:00:00'),
(218, 79, 4, 1, '2013-01-01 00:00:00'),
(219, 80, 2, 1, '2013-01-01 00:00:00'),
(220, 80, 6, 1, '2013-01-01 00:00:00'),
(221, 80, 4, 1, '2013-01-01 00:00:00'),
(222, 81, 2, 1, '2013-01-01 00:00:00'),
(223, 81, 6, 1, '2013-01-01 00:00:00'),
(224, 81, 4, 1, '2013-01-01 00:00:00'),
(225, 82, 2, 1, '2013-01-01 00:00:00'),
(226, 82, 6, 1, '2013-01-01 00:00:00'),
(227, 82, 4, 1, '2013-01-01 00:00:00'),
(228, 83, 2, 1, '2013-01-01 00:00:00'),
(229, 83, 6, 1, '2013-01-01 00:00:00'),
(230, 83, 4, 1, '2013-01-01 00:00:00'),
(231, 84, 2, 1, '2013-01-01 00:00:00'),
(232, 84, 6, 1, '2013-01-01 00:00:00'),
(233, 84, 4, 1, '2013-01-01 00:00:00'),
(234, 85, 2, 1, '2013-01-01 00:00:00'),
(235, 85, 6, 1, '2013-01-01 00:00:00'),
(236, 85, 4, 1, '2013-01-01 00:00:00'),
(237, 86, 2, 1, '2013-01-01 00:00:00'),
(238, 86, 6, 1, '2013-01-01 00:00:00'),
(239, 86, 4, 1, '2013-01-01 00:00:00'),
(240, 87, 2, 1, '2013-01-01 00:00:00'),
(241, 87, 6, 1, '2013-01-01 00:00:00'),
(242, 87, 4, 1, '2013-01-01 00:00:00'),
(243, 88, 2, 1, '2013-01-01 00:00:00'),
(244, 88, 6, 1, '2013-01-01 00:00:00'),
(245, 88, 4, 1, '2013-01-01 00:00:00'),
(246, 89, 2, 1, '2013-01-01 00:00:00'),
(247, 89, 6, 1, '2013-01-01 00:00:00'),
(248, 89, 4, 1, '2013-01-01 00:00:00'),
(249, 90, 2, 1, '2013-01-01 00:00:00'),
(250, 90, 6, 1, '2013-01-01 00:00:00'),
(251, 90, 4, 1, '2013-01-01 00:00:00'),
(252, 91, 2, 1, '2013-01-01 00:00:00'),
(253, 91, 6, 1, '2013-01-01 00:00:00'),
(254, 91, 4, 1, '2013-01-01 00:00:00'),
(255, 92, 2, 1, '2013-01-01 00:00:00'),
(256, 92, 6, 1, '2013-01-01 00:00:00'),
(257, 92, 4, 1, '2013-01-01 00:00:00'),
(258, 93, 2, 1, '2013-01-01 00:00:00'),
(259, 93, 6, 1, '2013-01-01 00:00:00'),
(260, 93, 4, 1, '2013-01-01 00:00:00'),
(261, 94, 2, 1, '2013-01-01 00:00:00'),
(262, 94, 6, 1, '2013-01-01 00:00:00'),
(263, 94, 4, 1, '2013-01-01 00:00:00'),
(264, 95, 2, 1, '2013-01-01 00:00:00'),
(265, 95, 6, 1, '2013-01-01 00:00:00'),
(266, 95, 4, 1, '2013-01-01 00:00:00'),
(267, 96, 2, 1, '2013-01-01 00:00:00'),
(268, 96, 6, 1, '2013-01-01 00:00:00'),
(269, 96, 4, 1, '2013-01-01 00:00:00'),
(270, 97, 2, 1, '2013-01-01 00:00:00'),
(271, 97, 6, 1, '2013-01-01 00:00:00'),
(272, 97, 4, 1, '2013-01-01 00:00:00'),
(273, 98, 2, 1, '2013-01-01 00:00:00'),
(274, 98, 6, 1, '2013-01-01 00:00:00'),
(275, 98, 4, 1, '2013-01-01 00:00:00'),
(276, 99, 2, 1, '2013-01-01 00:00:00'),
(277, 99, 6, 1, '2013-01-01 00:00:00'),
(278, 99, 4, 1, '2013-01-01 00:00:00'),
(279, 100, 2, 1, '2013-01-01 00:00:00'),
(280, 100, 6, 1, '2013-01-01 00:00:00'),
(281, 100, 4, 1, '2013-01-01 00:00:00'),
(282, 101, 2, 1, '2013-01-01 00:00:00'),
(283, 101, 6, 1, '2013-01-01 00:00:00'),
(284, 101, 4, 1, '2013-01-01 00:00:00'),
(285, 102, 2, 1, '2013-01-01 00:00:00'),
(286, 103, 2, 1, '2013-01-01 00:00:00'),
(287, 104, 2, 1, '2013-01-01 00:00:00'),
(288, 105, 2, 1, '2013-01-01 00:00:00'),
(289, 106, 2, 1, '2013-01-01 00:00:00'),
(290, 107, 2, 1, '2013-01-01 00:00:00'),
(291, 108, 2, 1, '2013-01-01 00:00:00'),
(292, 109, 2, 1, '2013-01-01 00:00:00'),
(293, 110, 2, 1, '2013-01-01 00:00:00'),
(294, 111, 2, 1, '2013-01-01 00:00:00'),
(295, 112, 2, 1, '2013-01-01 00:00:00'),
(296, 113, 2, 1, '2013-01-01 00:00:00'),
(297, 114, 2, 1, '2013-01-01 00:00:00'),
(298, 115, 2, 1, '2013-01-01 00:00:00'),
(299, 116, 2, 1, '2013-01-01 00:00:00'),
(300, 117, 2, 1, '2013-01-01 00:00:00'),
(301, 118, 2, 1, '2013-01-01 00:00:00'),
(302, 118, 8, 1, '2013-01-01 00:00:00'),
(303, 119, 2, 1, '2013-01-01 00:00:00'),
(304, 119, 8, 1, '2013-01-01 00:00:00'),
(305, 120, 2, 1, '2013-01-01 00:00:00'),
(306, 120, 8, 1, '2013-01-01 00:00:00'),
(307, 121, 2, 1, '2013-01-01 00:00:00'),
(308, 121, 8, 1, '2013-01-01 00:00:00'),
(309, 122, 2, 1, '2013-01-01 00:00:00'),
(310, 122, 8, 1, '2013-01-01 00:00:00'),
(311, 123, 2, 1, '2013-01-01 00:00:00'),
(312, 123, 8, 1, '2013-01-01 00:00:00'),
(313, 124, 2, 1, '2013-01-01 00:00:00'),
(314, 124, 8, 1, '2013-01-01 00:00:00'),
(315, 125, 2, 1, '2013-01-01 00:00:00'),
(316, 125, 8, 1, '2013-01-01 00:00:00'),
(317, 126, 2, 1, '2013-01-01 00:00:00'),
(318, 126, 8, 1, '2013-01-01 00:00:00'),
(319, 127, 2, 1, '2013-01-01 00:00:00'),
(320, 127, 8, 1, '2013-01-01 00:00:00'),
(321, 128, 2, 1, '2013-01-01 00:00:00'),
(322, 128, 8, 1, '2013-01-01 00:00:00'),
(323, 129, 2, 1, '2013-01-01 00:00:00'),
(324, 129, 8, 1, '2013-01-01 00:00:00'),
(325, 130, 2, 1, '2013-01-01 00:00:00'),
(326, 130, 8, 1, '2013-01-01 00:00:00'),
(327, 131, 2, 1, '2013-01-01 00:00:00'),
(328, 131, 8, 1, '2013-01-01 00:00:00'),
(329, 132, 2, 1, '2013-01-01 00:00:00'),
(330, 132, 8, 1, '2013-01-01 00:00:00'),
(331, 133, 2, 1, '2013-01-01 00:00:00'),
(332, 133, 8, 1, '2013-01-01 00:00:00'),
(333, 134, 2, 1, '2013-01-01 00:00:00'),
(334, 134, 8, 1, '2013-01-01 00:00:00'),
(335, 135, 2, 1, '2013-01-01 00:00:00'),
(336, 135, 8, 1, '2013-01-01 00:00:00'),
(337, 136, 2, 1, '2013-01-01 00:00:00'),
(338, 136, 8, 1, '2013-01-01 00:00:00'),
(339, 137, 2, 1, '2013-01-01 00:00:00'),
(340, 137, 8, 1, '2013-01-01 00:00:00'),
(341, 138, 2, 1, '2013-01-01 00:00:00'),
(342, 138, 8, 1, '2013-01-01 00:00:00'),
(343, 139, 2, 1, '2013-01-01 00:00:00'),
(344, 139, 8, 1, '2013-01-01 00:00:00'),
(345, 140, 2, 1, '2013-01-01 00:00:00'),
(346, 140, 8, 1, '2013-01-01 00:00:00'),
(347, 141, 2, 1, '2013-01-01 00:00:00'),
(348, 141, 8, 1, '2013-01-01 00:00:00'),
(349, 142, 2, 1, '2013-01-01 00:00:00'),
(350, 142, 1, 1, '2013-01-01 00:00:00'),
(351, 143, 2, 1, '2013-01-01 00:00:00'),
(352, 143, 1, 1, '2013-01-01 00:00:00'),
(353, 144, 2, 1, '2013-01-01 00:00:00'),
(354, 144, 1, 1, '2013-01-01 00:00:00'),
(355, 145, 2, 1, '2013-01-01 00:00:00'),
(356, 145, 1, 1, '2013-01-01 00:00:00'),
(357, 146, 2, 1, '2013-01-01 00:00:00'),
(358, 146, 1, 1, '2013-01-01 00:00:00'),
(359, 147, 2, 1, '2013-01-01 00:00:00'),
(360, 147, 1, 1, '2013-01-01 00:00:00'),
(361, 148, 2, 1, '2013-01-01 00:00:00'),
(362, 148, 1, 1, '2013-01-01 00:00:00'),
(363, 149, 2, 1, '2013-01-01 00:00:00'),
(364, 149, 1, 1, '2013-01-01 00:00:00'),
(365, 150, 9, 1, '2013-01-01 00:00:00'),
(366, 151, 9, 1, '2013-01-01 00:00:00'),
(367, 152, 9, 1, '2013-01-01 00:00:00'),
(368, 153, 10, 1, '2013-01-01 00:00:00'),
(369, 154, 10, 1, '2013-01-01 00:00:00'),
(370, 155, 10, 1, '2013-01-01 00:00:00'),
(371, 156, 10, 1, '2013-01-01 00:00:00'),
(372, 157, 10, 1, '2013-01-01 00:00:00'),
(373, 158, 10, 1, '2013-01-01 00:00:00'),
(374, 159, 10, 1, '2013-01-01 00:00:00'),
(375, 160, 10, 1, '2013-01-01 00:00:00'),
(376, 161, 10, 1, '2013-01-01 00:00:00'),
(377, 162, 10, 1, '2013-01-01 00:00:00'),
(378, 163, 10, 1, '2013-01-01 00:00:00'),
(379, 164, 10, 1, '2013-01-01 00:00:00'),
(380, 165, 10, 1, '2013-01-01 00:00:00'),
(381, 166, 10, 1, '2013-01-01 00:00:00'),
(382, 167, 10, 1, '2013-01-01 00:00:00'),
(383, 168, 10, 1, '2013-01-01 00:00:00'),
(384, 169, 10, 1, '2013-01-01 00:00:00'),
(385, 170, 10, 1, '2013-01-01 00:00:00'),
(386, 171, 10, 1, '2013-01-01 00:00:00'),
(387, 172, 10, 1, '2013-01-01 00:00:00'),
(388, 173, 10, 1, '2013-01-01 00:00:00'),
(389, 174, 10, 1, '2013-01-01 00:00:00'),
(390, 175, 10, 1, '2013-01-01 00:00:00'),
(391, 176, 10, 1, '2013-01-01 00:00:00'),
(392, 177, 10, 1, '2013-01-01 00:00:00'),
(393, 178, 10, 1, '2013-01-01 00:00:00'),
(394, 179, 10, 1, '2013-01-01 00:00:00'),
(395, 180, 10, 1, '2013-01-01 00:00:00'),
(396, 181, 10, 1, '2013-01-01 00:00:00'),
(397, 182, 10, 1, '2013-01-01 00:00:00'),
(398, 183, 10, 1, '2013-01-01 00:00:00'),
(399, 184, 10, 1, '2013-01-01 00:00:00'),
(400, 185, 10, 1, '2013-01-01 00:00:00'),
(401, 186, 10, 1, '2013-01-01 00:00:00'),
(402, 187, 10, 1, '2013-01-01 00:00:00'),
(403, 188, 10, 1, '2013-01-01 00:00:00'),
(404, 189, 10, 1, '2013-01-01 00:00:00'),
(405, 190, 10, 1, '2013-01-01 00:00:00'),
(406, 191, 10, 1, '2013-01-01 00:00:00'),
(407, 192, 10, 1, '2013-01-01 00:00:00'),
(408, 193, 10, 1, '2013-01-01 00:00:00'),
(409, 194, 10, 1, '2013-01-01 00:00:00'),
(410, 195, 10, 1, '2013-01-01 00:00:00'),
(411, 196, 10, 1, '2013-01-01 00:00:00'),
(412, 197, 10, 1, '2013-01-01 00:00:00'),
(413, 198, 10, 1, '2013-01-01 00:00:00'),
(414, 199, 10, 1, '2013-01-01 00:00:00'),
(415, 200, 10, 1, '2013-01-01 00:00:00'),
(416, 201, 10, 1, '2013-01-01 00:00:00'),
(417, 202, 10, 1, '2013-01-01 00:00:00'),
(418, 203, 10, 1, '2013-01-01 00:00:00'),
(419, 204, 10, 1, '2013-01-01 00:00:00'),
(420, 205, 10, 1, '2013-01-01 00:00:00'),
(421, 206, 10, 1, '2013-01-01 00:00:00'),
(422, 207, 10, 1, '2013-01-01 00:00:00'),
(423, 208, 10, 1, '2013-01-01 00:00:00'),
(424, 209, 10, 1, '2013-01-01 00:00:00'),
(425, 210, 10, 1, '2013-01-01 00:00:00'),
(426, 211, 10, 1, '2013-01-01 00:00:00'),
(427, 212, 10, 1, '2013-01-01 00:00:00'),
(428, 213, 10, 1, '2013-01-01 00:00:00'),
(429, 214, 10, 1, '2013-01-01 00:00:00'),
(430, 215, 10, 1, '2013-01-01 00:00:00'),
(431, 216, 10, 1, '2013-01-01 00:00:00'),
(432, 217, 10, 1, '2013-01-01 00:00:00'),
(433, 218, 10, 1, '2013-01-01 00:00:00'),
(434, 219, 10, 1, '2013-01-01 00:00:00'),
(435, 220, 1, 1, '2016-01-01 00:00:00'),
(436, 221, 1, 1, '2016-01-01 00:00:00'),
(437, 222, 1, 1, '2016-01-02 00:00:00'),
(438, 223, 1, 1, '2016-01-02 00:00:00'),
(439, 224, 1, 1, '2016-01-04 00:00:00'),
(440, 225, 1, 1, '2016-01-04 00:00:00'),
(441, 226, 1, 1, '2016-01-05 00:00:00'),
(442, 227, 1, 1, '2016-01-05 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `useraccounts`
--

CREATE TABLE `useraccounts` (
	`userid` int(11) NOT NULL,
	`email` varchar(255) NOT NULL,
	`wachtwoord` varchar(255) NOT NULL,
	`voornaam` varchar(45) NOT NULL,
	`achternaam` varchar(45) NOT NULL,
	`postcode` varchar(45) NOT NULL,
	`straat` varchar(45) NOT NULL,
	`huisnummer` int(11) NOT NULL,
	`stad` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `useraccounts`
--

INSERT INTO `useraccounts` (`userid`, `email`, `wachtwoord`, `voornaam`, `achternaam`, `postcode`, `straat`, `huisnummer`, `stad`) VALUES
(1, 'test@test.com', '$argon2i$v=19$m=1024,t=2,p=2$Nm8uMWlqNE5sWWtCSkpJVA$DrakHLaOOTehFzs+OOZwS+9E6HNtwEvc8/5W/aurxJQ', 'Test', 'Account', '1234AB', 'Teststraat', 9, 'Test');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `colors`
--
ALTER TABLE `colors`
	ADD PRIMARY KEY (`ColorID`),
	ADD UNIQUE KEY `UQ_Warehouse_Colors_ColorName` (`ColorName`),
	ADD KEY `FK_Warehouse_Colors_Application_People` (`LastEditedBy`);

--
-- Indexes for table `invoicelines`
--
ALTER TABLE `invoicelines`
	ADD PRIMARY KEY (`InvoiceLineID`),
	ADD KEY `FK_Sales_InvoiceLines_InvoiceID` (`InvoiceID`),
	ADD KEY `FK_Sales_InvoiceLines_StockItemID` (`StockItemID`),
	ADD KEY `NCCX_Sales_InvoiceLines` (`InvoiceID`,`StockItemID`,`Quantity`) USING BTREE;

--
-- Indexes for table `invoices`
--
ALTER TABLE `invoices`
	ADD PRIMARY KEY (`InvoiceID`);

--
-- Indexes for table `packagetypes`
--
ALTER TABLE `packagetypes`
	ADD PRIMARY KEY (`PackageTypeID`),
	ADD UNIQUE KEY `UQ_Warehouse_PackageTypes_PackageTypeName` (`PackageTypeName`),
	ADD KEY `FK_Warehouse_PackageTypes_Application_People` (`LastEditedBy`);

--
-- Indexes for table `specialdeals`
--
ALTER TABLE `specialdeals`
	ADD PRIMARY KEY (`SpecialDealID`),
	ADD KEY `FK_Sales_SpecialDeals_StockItemID` (`StockItemID`),
	ADD KEY `FK_Sales_SpecialDeals_CustomerID` (`CustomerID`),
	ADD KEY `FK_Sales_SpecialDeals_BuyingGroupID` (`BuyingGroupID`),
	ADD KEY `FK_Sales_SpecialDeals_CustomerCategoryID` (`CustomerCategoryID`),
	ADD KEY `FK_Sales_SpecialDeals_StockGroupID` (`StockGroupID`),
	ADD KEY `FK_Sales_SpecialDeals_Application_People` (`LastEditedBy`);

--
-- Indexes for table `stockgroups`
--
ALTER TABLE `stockgroups`
	ADD PRIMARY KEY (`StockGroupID`),
	ADD UNIQUE KEY `UQ_Warehouse_StockGroups_StockGroupName` (`StockGroupName`),
	ADD KEY `FK_Warehouse_StockGroups_Application_People` (`LastEditedBy`);

--
-- Indexes for table `stockitemholdings`
--
ALTER TABLE `stockitemholdings`
	ADD PRIMARY KEY (`StockItemID`),
	ADD KEY `FK_Warehouse_StockItemHoldings_Application_People` (`LastEditedBy`);

--
-- Indexes for table `stockitems`
--
ALTER TABLE `stockitems`
	ADD PRIMARY KEY (`StockItemID`),
	ADD UNIQUE KEY `UQ_Warehouse_StockItems_StockItemName` (`StockItemName`),
	ADD KEY `FK_Warehouse_StockItems_ColorID` (`ColorID`),
	ADD KEY `FK_Warehouse_StockItems_UnitPackageID` (`UnitPackageID`),
	ADD KEY `FK_Warehouse_StockItems_OuterPackageID` (`OuterPackageID`),
	ADD KEY `FK_Warehouse_StockItems_Application_People` (`LastEditedBy`);

--
-- Indexes for table `stockitemstockgroups`
--
ALTER TABLE `stockitemstockgroups`
	ADD PRIMARY KEY (`StockItemStockGroupID`),
	ADD UNIQUE KEY `UQ_StockItemStockGroups_StockItemID_Lookup` (`StockItemID`,`StockGroupID`),
	ADD UNIQUE KEY `UQ_StockItemStockGroups_StockGroupID_Lookup` (`StockGroupID`,`StockItemID`),
	ADD KEY `FK_Warehouse_StockItemStockGroups_Application_People` (`LastEditedBy`);

--
-- Indexes for table `useraccounts`
--
ALTER TABLE `useraccounts`
	ADD PRIMARY KEY (`userid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `invoicelines`
--
ALTER TABLE `invoicelines`
	MODIFY `InvoiceLineID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=201;

--
-- AUTO_INCREMENT for table `useraccounts`
--
ALTER TABLE `useraccounts`
	MODIFY `userid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `invoicelines`
--
ALTER TABLE `invoicelines`
	ADD CONSTRAINT `FK_Sales_InvoiceLines_InvoiceID_Sales_Invoices` FOREIGN KEY (`InvoiceID`) REFERENCES `invoices` (`InvoiceID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
	ADD CONSTRAINT `FK_Sales_InvoiceLines_StockItemID_Warehouse_StockItems` FOREIGN KEY (`StockItemID`) REFERENCES `stockitems` (`StockItemID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `stockitemholdings`
--
ALTER TABLE `stockitemholdings`
	ADD CONSTRAINT `PKFK_Warehouse_StockItemHoldings_StockItemID_Warehouse_StockIt23` FOREIGN KEY (`StockItemID`) REFERENCES `stockitems` (`StockItemID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `stockitemstockgroups`
--
ALTER TABLE `stockitemstockgroups`
	ADD CONSTRAINT `FK_Warehouse_StockItemStockGroups_StockGroupID_Warehouse_Stock18` FOREIGN KEY (`StockGroupID`) REFERENCES `stockgroups` (`StockGroupID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
	ADD CONSTRAINT `FK_Warehouse_StockItemStockGroups_StockItemID_Warehouse_StockI17` FOREIGN KEY (`StockItemID`) REFERENCES `stockitems` (`StockItemID`) ON DELETE NO ACTION ON UPDATE NO ACTION;
