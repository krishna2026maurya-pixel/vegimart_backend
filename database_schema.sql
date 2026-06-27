-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 25, 2025 at 07:15 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `udaybharat_mart`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `mobile_number` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `name`, `email`, `mobile_number`, `password`, `type`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'UdayBharat', 'admin@admin.com', '6396063416', '$2y$12$/CE9WkmQqcgYDfnS5SyKxeo/bL5G1edrnCh9t2pqKTn3NWtsZN2li', 'admin', 1, '2025-11-25 13:44:46', '2025-11-25 08:14:31'),
(3, 'Sanjay', 'sanjay383@gmail.com', '6390583448', '$2y$12$lDOZqW9S0FvazXtnRj/f..Pd4O9h7XX9XvXteYVU9orNWia0yYRMS', 'admin', 1, '2025-11-25 08:08:27', '2025-11-25 08:13:07');

-- --------------------------------------------------------

--
-- Table structure for table `admin_recharge_transactions`
--

CREATE TABLE `admin_recharge_transactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `amt` decimal(10,2) NOT NULL,
  `applicable_on` varchar(255) NOT NULL DEFAULT 'all_users',
  `expire_on` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admin_recharge_transactions`
--

INSERT INTO `admin_recharge_transactions` (`id`, `amt`, `applicable_on`, `expire_on`, `created_at`, `updated_at`) VALUES
(1, 100.00, 'all_users', '2025-11-30', '2025-11-25 07:16:24', '2025-11-25 07:16:24');

-- --------------------------------------------------------

--
-- Table structure for table `banner_list`
--

CREATE TABLE `banner_list` (
  `id` int(11) NOT NULL,
  `banner_image` text NOT NULL,
  `sno` int(11) NOT NULL,
  `added_date_time` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `banner_list`
--

INSERT INTO `banner_list` (`id`, `banner_image`, `sno`, `added_date_time`) VALUES
(1, '01KAXK351B9D1R988V8A9G7DBD.jpg', 1, '2025-11-25 07:53:20'),
(2, '01KAXK8Z14M1CC9AB9PNEA3MCS.jpg', 2, '2025-11-25 07:59:30'),
(3, '01KAXKQ10MMFBT8ND17HRFYDVQ.png', 3, '2025-11-25 08:06:30');

-- --------------------------------------------------------

--
-- Table structure for table `brand_list`
--

CREATE TABLE `brand_list` (
  `id` int(11) NOT NULL,
  `brand_name` text NOT NULL,
  `icon` text NOT NULL,
  `added_date_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `brand_list`
--

INSERT INTO `brand_list` (`id`, `brand_name`, `icon`, `added_date_time`) VALUES
(1, 'Amul', '01KAVERQAQBHT4DJRGEPJE9K87.jpg', '2025-11-24 17:32:15'),
(2, 'Kashmeri', '01KAVESP1BHHD65N6V9W11YSJQ.jpg', '2025-11-24 17:32:46');

-- --------------------------------------------------------

--
-- Table structure for table `cart_list`
--

CREATE TABLE `cart_list` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` int(11) NOT NULL,
  `added_date_time` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cart_list`
--

INSERT INTO `cart_list` (`id`, `user_id`, `product_id`, `quantity`, `added_date_time`, `created_at`, `updated_at`) VALUES
(111, 2, 36, 16, '2025-11-13 12:39:21', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `category_type`
--

CREATE TABLE `category_type` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `category_type`
--

INSERT INTO `category_type` (`id`, `name`, `slug`, `description`, `image`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Grocery & Essentials', 'grocery-essentials', 'Online retail of daily essentials like groceries, ...', '3d-apple-illustration.jpg', 1, '2025-10-30 04:59:19', '2025-11-24 11:47:51'),
(2, 'Fashion & Apparel', 'fashion-apparel', 'Selling clothing, footwear, and fashion accessories...', NULL, 1, '2025-10-30 04:59:19', '2025-10-30 04:59:19'),
(3, 'Electronics & Gadgets', 'electronics-gadgets', 'Retail of smartphones, accessories, and consumer electronics...', NULL, 1, '2025-10-30 04:59:19', '2025-10-30 04:59:19'),
(4, 'Home & Kitchen', 'home-kitchen', 'Products for home improvement, kitchenware, and décor...', NULL, 1, '2025-10-30 04:59:19', '2025-10-30 04:59:19'),
(5, 'Beauty & Personal Care', 'beauty-personal-care', 'Cosmetics, grooming, and skincare products for all...', NULL, 1, '2025-10-30 04:59:19', '2025-10-30 04:59:19'),
(6, 'Health & Wellness', 'health-wellness', 'Pharmacy, supplements, and fitness-related products...', NULL, 1, '2025-10-30 04:59:19', '2025-10-30 04:59:19'),
(7, 'Baby & Kids', 'baby-kids', 'Products for infants and kids including food, toys...', NULL, 1, '2025-10-30 04:59:19', '2025-10-30 04:59:19'),
(8, 'Pet Supplies', 'pet-supplies', 'Pet food, toys, accessories, and grooming items.', NULL, 1, '2025-10-30 04:59:19', '2025-10-30 04:59:19'),
(9, 'Stationery & Office', 'stationery-office', 'Office supplies, books, and school stationery.', NULL, 1, '2025-10-30 04:59:19', '2025-10-30 04:59:19'),
(10, 'Sports & Outdoor', 'sports-outdoor', 'Sports gear, fitness accessories, and outdoor equipment...', NULL, 1, '2025-10-30 04:59:19', '2025-10-30 04:59:19'),
(11, 'Electronics & Gadgets', 'electronics-gadgets', 'Retail of smartphones, accessories, and consumer electronics', NULL, 1, '2025-11-23 04:20:31', '2025-11-23 04:20:31'),
(12, 'Fashion & Apparel', 'fashion-apparel', 'Selling clothing, footwear, and fashion accessories', NULL, 1, '2025-11-23 04:20:31', '2025-11-23 04:20:31'),
(13, 'Grocery & Essentials', 'grocery-essentials', 'Online retail of daily essentials like groceries', NULL, 1, '2025-11-23 04:20:31', '2025-11-23 04:20:31'),
(14, 'testting', 'testing', 'this is testing', '3d-apple-illustration.jpg', 1, '2025-11-23 06:25:50', '2025-11-23 06:33:35');

-- --------------------------------------------------------

--
-- Table structure for table `coupon_code_list`
--

CREATE TABLE `coupon_code_list` (
  `id` int(11) NOT NULL,
  `coupon_code` text NOT NULL,
  `min_order_value` double NOT NULL,
  `max_discount` double NOT NULL,
  `description` text NOT NULL,
  `validate` datetime NOT NULL,
  `is_active` int(11) NOT NULL,
  `discount_value` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `coupon_code_list`
--

INSERT INTO `coupon_code_list` (`id`, `coupon_code`, `min_order_value`, `max_discount`, `description`, `validate`, `is_active`, `discount_value`) VALUES
(1, 'T20', 99, 50, 'This is testing coupan code', '2025-11-30 14:32:02', 1, 100);

-- --------------------------------------------------------

--
-- Table structure for table `delivery_boys`
--

CREATE TABLE `delivery_boys` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `father_name` varchar(150) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `email` varchar(150) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `gender` enum('Male','Female','Other') NOT NULL,
  `gps_address` text DEFAULT NULL,
  `gps_lat` decimal(10,8) DEFAULT NULL,
  `gps_long` decimal(11,8) DEFAULT NULL,
  `district` varchar(100) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `profile_photot` varchar(255) DEFAULT NULL,
  `aadhar_front` varchar(255) DEFAULT NULL,
  `aadhar_back` varchar(255) DEFAULT NULL,
  `driving_license` varchar(255) DEFAULT NULL,
  `vechile_registration_card` varchar(255) DEFAULT NULL,
  `bank_name` varchar(150) DEFAULT NULL,
  `bank_account_number` varchar(50) DEFAULT NULL,
  `bank_ifcs_code` varchar(20) DEFAULT NULL,
  `bank_branch` varchar(150) DEFAULT NULL,
  `account_holder_name` varchar(150) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1 COMMENT '1=Active, 0=Inactive',
  `is_verified` tinyint(1) DEFAULT 0 COMMENT '1=Verified, 0=Not Verified',
  `is_available` tinyint(1) DEFAULT 1 COMMENT '1=Available, 0=Not Available',
  `wallet_balance` decimal(10,2) DEFAULT 0.00,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fiberbase_token` varchar(255) DEFAULT NULL,
  `vehicle_type` varchar(255) DEFAULT NULL,
  `otp` int(11) DEFAULT NULL,
  `is_deleted` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `delivery_boys`
--

INSERT INTO `delivery_boys` (`id`, `name`, `father_name`, `phone`, `email`, `password`, `gender`, `gps_address`, `gps_lat`, `gps_long`, `district`, `city`, `profile_photot`, `aadhar_front`, `aadhar_back`, `driving_license`, `vechile_registration_card`, `bank_name`, `bank_account_number`, `bank_ifcs_code`, `bank_branch`, `account_holder_name`, `is_active`, `is_verified`, `is_available`, `wallet_balance`, `created_at`, `updated_at`, `fiberbase_token`, `vehicle_type`, `otp`, `is_deleted`) VALUES
(1, 'Pankaj Yadav', 'Rajat Rajput', '34558146319', 'pankaj@gmail.com', '$2y$12$Ye12PoyPfOpgsuv3wLyXu.rxP7CYLYk56vOIwuzkyHIguUuFLv92W', 'Male', 'OM Plaza Paratement Indranagar Lucknow', 82.90120990, 82.90120990, 'BTK', 'Lucknow', '01KAVJD8ERAC8CPTY5XEQ8T86C.jpg', '01KAVJD8FAK948KMZQWTF6607N.jpg', '01KAVJD8FVMQF8WW7CDACQ683A.jpg', '01KAVJD8GTH8F2M5TBMZW4NJG8.jpg', '01KAVJD8HTHXZ5T0M501TRJVF4.png', 'HDFC', '025485785', 'HDFC08G', 'Munshi Puliya', 'Rajat Rajput', 1, 1, 1, 750.00, '2025-10-31 05:16:50', '2025-11-24 18:35:54', 'dXNImGfjRX-V3_Qcw34muZ:APA91bF6i3s2wDUQn8HmDY0uQnTAyvqUMTp-54hf42uGjXgg_KROyjyN08D2b822Nnj1X0wJbclx3NCZDeYeMZHVvmCzodgMTmvLVX34paSimapL2FktnD8', 'Two Vehiler', 0, 1),
(2, 'Pankaj Yadav', 'Rajat Rajput', '7845896558', 'pankaj@gmail.com', '$2y$12$uWo1Pyq631EbU44iY27o1.rsU0LyacO8eiZ08rOGt7MTK1bIpEOjS', 'Male', 'OM Plaza Paratement Indranagar Lucknow', 26.88904900, 80.98833460, 'BTK', 'Lucknow', NULL, NULL, NULL, NULL, NULL, 'HDFC', '025485785', 'HDFC08G', 'Munshi Puliya', 'Rajat Rajput', 1, 1, 1, 0.00, '2025-11-06 10:17:03', '2025-11-12 19:59:54', 'cPIgWUiOT86jaessN_OQF7:APA91bFCXOolavGjpZJA-kW36ac...', NULL, 2539, 0),
(3, 'Pankaj Yadav', 'Rajat Rajput', '7845896586', 'pankaj@gmail.com', '$2y$12$1fEhxMFYsyI7WnzPL9h65e.U.z/NiO3MMYyz4XrFuDxknTph65TnK', 'Male', 'OM Plaza Paratement Indranagar Lucknow', 26.88904900, 80.98833460, 'BTK', 'Lucknow', '1762424287_owner3.jpg', '1762424287_RC1.jpg', '1762424287_RC1.jpg', '1762424287_RC1.jpg', '1762424287_punch-1659696343-prod-var.jpg', 'HDFC', '025485785', 'HDFC08G', 'Munshi Puliya', 'Rajat Rajput', 0, 0, 0, 0.00, '2025-11-06 10:18:07', '2025-11-12 19:57:21', 'cPIgWUiOT86jaessN_OQF7:APA91bFCXOolavGjpZJA-kW36ac...', NULL, 7799, 0),
(4, 'Pankaj Yadav', 'Rajat Rajput', '9689589658', 'pankaj@gmail.com', '$2y$12$w.cYcanzPYkghHy8i8qpkebINSbpbDmeQCH3.lLAkyoGVUJegiV32', 'Male', 'OM Plaza Paratement Indranagar Lucknow', 83.78012099, 25.04655484, 'BTK', 'Lucknow', NULL, NULL, NULL, NULL, NULL, 'HDFC', '025485785', 'HDFC08G', 'Munshi Puliya', 'Rajat Rajput', 0, 0, 0, 0.00, '2025-11-07 08:27:40', '2025-11-12 19:58:36', 'cPIgWUiOT86jaessN_OQF7:APA91bFCXOolavGjpZJA-kW36ac...', NULL, 1136, 0),
(5, 'sttw', 'yeyeyeye', '3232323121', 'demo@gmail.com', '$2y$12$A8iwPDeo35WmkUkoFL5QgOFZ/o9giaZNvbsn3.w6EQaLcSXAqshy2', 'Male', 'Harahua, , Harhua, Varanasi Division 221105, India', 82.90120990, 82.90120990, 'india', 'Harhua', '1762506302_1000079265.jpg', '1762506302_1000079255.jpg', '1762506302_1000079253.jpg', '1762506302_1000079255.jpg', '1762506302_1000079251.jpg', 'fa w', '31242424242424352', 'gstststdgst', 'yete w', 'yetsts', 0, 0, 0, 0.00, '2025-11-07 09:05:02', '2025-11-12 19:58:33', 'cPIgWUiOT86jaessN_OQF7:APA91bFCXOolavGjpZJA-kW36ac...', NULL, 4135, 0),
(6, 'sttw', 'yeyeyeye', '3232323124', 'demo@gmail.com', '$2y$12$ehraHf4ykRlIIJ33k0XEr.z0DJeqtOUVGI9.J4mvDud7LYVT.Yw6y', 'Male', 'Harahua, , Harhua, Varanasi Division 221105, India', 82.90120990, 82.90120990, 'india', 'Harhua', '1762506387_1000079265.jpg', '1762506387_1000079255.jpg', '1762506387_1000079253.jpg', '1762506387_1000079255.jpg', '1762506387_1000079251.jpg', 'fa w', '31242424242424352', 'gstststdgst', 'yete w', 'yetsts', 1, 1, 1, 0.00, '2025-11-07 09:06:27', '2025-11-12 19:58:25', 'cPIgWUiOT86jaessN_OQF7:APA91bFCXOolavGjpZJA-kW36ac...', NULL, 827, 0),
(7, 'sttw', 'yeyeyeye', '3232323144', 'demo@gmail.com', '$2y$12$/YZEPWvTsukVKrKe8FFrpON5FtC95cPRKbEr4V/UIIrWD1pgq0N1G', 'Male', 'Harahua, , Harhua, Varanasi Division 221105, India', 82.90120990, 82.90120990, 'india', 'Harhua', '1762506465_1000079265.jpg', '1762506465_1000079255.jpg', '1762506465_1000079253.jpg', '1762506465_1000079255.jpg', '1762506465_1000079251.jpg', 'fa w', '31242424242424352', 'gstststdgst', 'yete w', 'yetsts', 0, 0, 0, 0.00, '2025-11-07 09:07:46', '2025-11-12 19:58:22', 'cPIgWUiOT86jaessN_OQF7:APA91bFCXOolavGjpZJA-kW36ac...', NULL, 185, 0),
(9, 'sttw', 'yeyeyeye', '3232323146', 'demo@gmail.com', '$2y$12$DlpNdkK1pzLu1Bze2Nu3H.ycJvgQV.ugONgn1HrllOjt8gaTRdEqS', 'Male', 'Harahua, , Harhua, Varanasi Division 221105, India', 82.90120990, 82.90120990, 'india', 'Harhua', '1762506611_1000079265.jpg', '1762506611_1000079255.jpg', '1762506611_1000079253.jpg', '1762506611_1000079255.jpg', '1762506611_1000079251.jpg', 'fa w', '31242424242424352', 'gstststdgst', 'yete w', 'yetsts', 0, 0, 0, 0.00, '2025-11-07 09:10:11', '2025-11-12 19:58:16', 'cPIgWUiOT86jaessN_OQF7:APA91bFCXOolavGjpZJA-kW36ac...', NULL, 8425, 0),
(10, 'sttw', 'yeyeyeye', '3232323147', 'demo@gmail.com', '$2y$12$yQDz74iUulkv7Kf/GRF1vOPOmFHi5hX4LE3vt1YK5LdANvRj0kK7K', 'Male', 'Harahua, , Harhua, Varanasi Division 221105, India', 82.90120990, 82.90120990, 'india', 'Harhua', '1762506728_1000079265.jpg', '1762506728_1000079255.jpg', '1762506728_1000079253.jpg', '1762506728_1000079255.jpg', '1762506728_1000079251.jpg', 'fa w', '31242424242424352', 'gstststdgst', 'yete w', 'yetsts', 1, 1, 1, 0.00, '2025-11-07 09:12:08', '2025-11-09 11:27:32', 'dXNImGfjRX-V3_Qcw34muZ:APA91bF6i3s2wDUQn8HmDY0uQnTAyvqUMTp-54hf42uGjXgg_KROyjyN08D2b822Nnj1X0wJbclx3NCZDeYeMZHVvmCzodgMTmvLVX34paSimapL2FktnD8', NULL, 5979, 0),
(11, 'sttw', 'yeyeyeye', '3232323149', 'demo@gmail.com', '$2y$12$J5B6kYO88n7i8Q90NY6AXOTSpLNT5PFDO3UGVxvoH1b.5uwACILLe', 'Male', 'Harahua, , Harhua, Varanasi Division 221105, India', 82.90120990, 82.90120990, 'india', 'Harhua', '1762506807_1000079265.jpg', '1762506807_1000079255.jpg', '1762506807_1000079253.jpg', '1762506807_1000079255.jpg', '1762506807_1000079251.jpg', 'fa w', '31242424242424352', 'gstststdgst', 'yete w', 'yetsts', 1, 1, 1, 0.00, '2025-11-07 09:13:27', '2025-11-12 19:59:23', 'cPIgWUiOT86jaessN_OQF7:APA91bFCXOolavGjpZJA-kW36ac...', NULL, 284, 0),
(12, 'sttw', 'yeyeyeye', '3232323148', 'demo@gmail.com', '$2y$12$HoarGH6sccxRw6jgbN0/jeVJzKw.SvBa6UCZIx6PY31dYXdJttyLS', 'Male', 'Harahua, , Harhua, Varanasi Division 221105, India', 82.90120990, 82.90120990, 'india', 'Harhua', '1762506864_1000079265.jpg', '1762506864_1000079255.jpg', '1762506864_1000079253.jpg', '1762506864_1000079255.jpg', '1762506864_1000079251.jpg', 'fa w', '31242424242424352', 'gstststdgst', 'yete w', 'yetsts', 1, 1, 1, 0.00, '2025-11-07 09:14:24', '2025-11-12 19:59:38', 'cPIgWUiOT86jaessN_OQF7:APA91bFCXOolavGjpZJA-kW36ac...', NULL, 1148, 0),
(13, 'krishna', 'ram', '8423485660', 'demo@gmail.com', '$2y$12$HoarGH6sccxRw6jgbN0/jeVJzKw.SvBa6UCZIx6PY31...', 'Male', 'Harahua, , Harhua, Varanasi Division 221105, India', 25.37909990, 82.90234010, 'india', 'Harhua', '1762752151_31953.jpg', '1762752151_31879.jpg', '1762752151_31639.jpg', '1762752151_31773.jpg', '1762752151_30906.jpg', 'Indian overseas Bank', '54848562948465056', 'ioba003224', 'hdhdj', 'krishna kumar maurya', 1, 1, 1, 1500.00, '2025-11-10 05:22:32', '2025-11-17 06:37:13', 'dXNImGfjRX-V3_Qcw34muZ:APA91bF6i3s2wDUQn8HmDY0uQnTAyvqUMTp-54hf42uGjXgg_KROyjyN08D2b822Nnj1X0wJbclx3NCZDeYeMZHVvmCzodgMTmvLVX34paSimapL2FktnD8', NULL, 4213, 0),
(14, 'krishna2', 'kk', '8423485666', 'demo@gmail.com', '$2y$12$djeQYSDy4I71HZphVk6qi.Sjx/LM.r2VE9wV6h0vyOzGQ88KwhCqG', 'Male', 'Harahua, , Harhua, Varanasi Division 221105, India', 25.38552570, 82.90128750, 'india', 'Harhua', '1762843091_1000079265.jpg', '1762843091_1000079261.jpg', '1762843091_1000079255.jpg', '1762843091_1000079253.jpg', '1762843091_1000079253.jpg', 'bh', '5655958925635', 'fhhj', 'gnj', 'gjjj', 1, 1, 1, 3755.00, '2025-11-11 06:38:11', '2025-11-22 04:55:55', 'cDEtwn4YTWGYdOSCzGjr5L:APA91bGbh94OzBj5SA2TbR9tYObVJq2nqT91rdjn1VlRdDSDge0MjMsxLd80JFVP4tYa2t706eS37j86RQ5mHd6YxYsre1EuYDmRwL6SHlQ9t_vpO7Z-uyY', NULL, 975, 0),
(15, 'kh', 'hfhg', '8458485628', 'demo@gmail.com', '$2y$12$Xag0Io/YnFyvk4hCbdf0ker/VvGqVTWwcdsPfIf.i1vnbrTkSvNzS', 'Male', '7VRH+983, , Gangapur, Varanasi Division 221302, India', 25.29057500, 82.87729830, 'india', 'Gangapur', '1763404465_34173.jpg', '1763404465_34177.jpg', '1763404465_34171.jpg', '1763404465_34173.jpg', '1763404465_34175.jpg', 'vgggdf', '555565899999999', 'io s', 'htgg', 'vfdgbsv', 0, 0, 0, 0.00, '2025-11-17 18:34:25', '2025-11-24 18:54:19', 'eUdl7vGFRIe0dQ19yS4sNT:APA91bHd7bQfHoTAHCuLE6N7a7wkrbl5Q8dbieI-z53fap1zlxgo7UDmw4-isCNyPJDt5kuNufhBn06iv-m0ce2pSQAyqeJwfvsiYoyLzkZ-zBMGy-l_4RA', NULL, 1517, 1),
(16, 'krishna 3', 'ggg', '1111111111', 'demo@gmail.com', '$2y$12$dP0rphEkMfWy0acpubt.t.3Of/lcmgAL.nlUgTqeXTqQE5SzmHIVK', 'Male', 'Harahua, , Harhua, Varanasi Division 221105, India', 25.38552400, 82.90123870, 'india', 'Harhua', '1763462865_1000079265.jpg', '1763462865_1000079253.jpg', '1763462865_1000079253.jpg', '1763462865_1000079265.jpg', '1763462865_1000079253.jpg', 'hdyd', '65353235353535353', 'hfhf', 'hff', 'hfhfuf', 0, 0, 0, 0.00, '2025-11-18 10:47:46', '2025-11-19 06:51:52', 'cDEtwn4YTWGYdOSCzGjr5L:APA91bGbh94OzBj5SA2TbR9tYObVJq2nqT91rdjn1VlRdDSDge0MjMsxLd80JFVP4tYa2t706eS37j86RQ5mHd6YxYsre1EuYDmRwL6SHlQ9t_vpO7Z-uyY', NULL, 1998, 0),
(17, 'Shivay yadav singh ko', 'Rajat Rajput', '6396063455', 'shivay@gmail.com', '$2y$12$8ROlMmYHK9oEpVYhkxyTPuBZV8xg4DnWQcL3y23obmObIl4Dabjle', 'Male', 'Om apartment, Flat 201', 24.56556226, 84.54643110, 'BTK', 'Uttam Nagar', '01KAVK29KC7ZCQF67A0WPB3CZX.jpg', '01KAVK29KXJB1W5YT4GAD9QV48.jpg', '01KAVK29M9P23ATVP2M5Q11R8W.jpg', '01KAVK29MSQB4P213D2T4PJN8Q.jpg', '01KAVK29N7E7997TQ9Q2D4SDDC.jpg', 'HDFC', '98787684', 'HDFC08G', NULL, 'Rajat Rajput', 1, 1, 1, 0.00, '2025-11-24 18:47:23', '2025-11-24 18:47:23', NULL, 'Two Vehiler', NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `delivery_boy_wallet_transactions`
--

CREATE TABLE `delivery_boy_wallet_transactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `delivery_boy_id` bigint(20) UNSIGNED NOT NULL,
  `amt` decimal(10,2) NOT NULL,
  `operation_type` enum('credit','debit') NOT NULL,
  `remark` text DEFAULT NULL,
  `status` enum('pending','completed','failed') NOT NULL DEFAULT 'pending',
  `is_send_to_admin` tinyint(1) NOT NULL DEFAULT 0,
  `is_send_to_vendor` tinyint(1) NOT NULL DEFAULT 0,
  `added_date_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `booking_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `delivery_boy_wallet_transactions`
--

INSERT INTO `delivery_boy_wallet_transactions` (`id`, `delivery_boy_id`, `amt`, `operation_type`, `remark`, `status`, `is_send_to_admin`, `is_send_to_vendor`, `added_date_time`, `booking_id`, `created_at`, `updated_at`) VALUES
(12, 14, 1705.00, 'credit', 'COD collected for Order #68', 'completed', 0, 0, '2025-11-17 16:08:55', 68, '2025-11-17 16:08:55', '2025-11-17 16:08:55'),
(13, 14, 750.00, 'credit', 'COD collected for Order #82', 'completed', 0, 0, '2025-11-19 14:04:26', 82, '2025-11-19 14:04:26', '2025-11-19 14:04:26'),
(14, 14, 750.00, 'credit', 'COD collected for Order #83', 'completed', 0, 0, '2025-11-19 14:11:58', 83, '2025-11-19 14:11:58', '2025-11-19 14:11:58'),
(15, 14, 750.00, 'credit', 'COD collected for Order #86', 'completed', 0, 0, '2025-11-19 14:44:10', 86, '2025-11-19 14:44:10', '2025-11-19 14:44:10');

-- --------------------------------------------------------

--
-- Table structure for table `delivery_charges`
--

CREATE TABLE `delivery_charges` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `from_km` int(11) NOT NULL,
  `to_km` int(11) NOT NULL,
  `min_order_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `delivery_charge` decimal(8,2) NOT NULL DEFAULT 0.00,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `delivery_charges`
--

INSERT INTO `delivery_charges` (`id`, `from_km`, `to_km`, `min_order_amount`, `delivery_charge`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 5, 10, 99.00, 50.00, 1, '2025-11-25 08:39:20', '2025-11-25 08:39:20');

-- --------------------------------------------------------

--
-- Table structure for table `login`
--

CREATE TABLE `login` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `mobile_no` varchar(255) NOT NULL,
  `is_verified` tinyint(1) NOT NULL DEFAULT 0,
  `fiberbase_token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `gps_lat` double DEFAULT NULL,
  `gps_long` double DEFAULT NULL,
  `wallet_balance` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `login`
--

INSERT INTO `login` (`id`, `mobile_no`, `is_verified`, `fiberbase_token`, `created_at`, `updated_at`, `gps_lat`, `gps_long`, `wallet_balance`) VALUES
(1, '8423485660', 1, 'faG1f39CS4-pkTjEQ_IeUI:APA91bHv4hYybHnoO-P3CYqQS2JLF9oqs3Dl9z3lDYEvZUpHG3ba3yM_6KC9Di4c8VS6ydkRuNFSkaGbyD-LLHj3fok6pZewV6SQVC3lrBVZ8n2dOG85eQo', '2025-10-29 18:06:05', '2025-11-25 07:16:24', 25.2101542, 83.02064575, 100),
(2, '9152616125', 1, 'eMOSUWfPRgujaL3hMo2SHK:APA91bFdpnCRycaZc2wKni1zfxs92UN35cKs2ss5puitnLHmNyKoEVCQIboEpz-4zw36Cuivo6VDbHH5qURJOG-bfqfAZg0WlxDMAGHogI1BPCQwpO4dRLc', '2025-10-31 16:27:19', '2025-11-25 07:16:24', 25.3851418, 82.901062, 100),
(3, '7011993705', 1, 'eVE4uv_xThW5Ev_Ho7lbur:APA91bF0PK99LiXSYa2CMc1t-pu_L3wO7ZtKu5G1Xvq6xjdnFBTzZgMhl-G_oRGYy6B5E1iHamdg0MqipjKttYNpVGE-SYWvD2jxYCqJrKLCLj-3102YAbI', '2025-11-01 01:19:09', '2025-11-25 07:16:24', 21.1479416, 73.0951218, 100),
(6, '7433004444', 1, 'c1zmSu4ITuGXHNTDuMpLPp:APA91bHEYBNahWkeGcot0HdZyO1Q0AkScZLmxb0XqMmwcZEvjVAsYT1apEnbBUIUJeA7aze4D15AzK28wgSJ4ukIcxAVh7i4YJ-P3ISg0Mo25DaTJmNaAHg', '2025-11-14 18:07:12', '2025-11-25 07:16:24', NULL, NULL, 100);

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2025_11_25_123758_add_wallet_balance_to_login_table', 1),
(2, '2025_11_25_123554_create_admin_recharge_transactions_table', 2),
(3, '2025_11_25_131023_alter_banner_list_table', 3),
(4, '2025_11_25_144815_create_notification_list_table', 4),
(5, '2025_11_25_145223_update_notification_list_table', 5);

-- --------------------------------------------------------

--
-- Table structure for table `notification_list`
--

CREATE TABLE `notification_list` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  `added_date_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0,
  `image` varchar(255) DEFAULT NULL,
  `read_status` tinyint(1) NOT NULL DEFAULT 0,
  `for_type` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notification_list`
--

INSERT INTO `notification_list` (`id`, `user_id`, `title`, `message`, `type`, `added_date_time`, `is_deleted`, `image`, `read_status`, `for_type`) VALUES
(9, 1, 'Special Offer', 'This  is testing msg of notification ', 'Offer', '2025-11-25 10:27:46', 0, '01KAXVREGSA57GCFS81C7K1G4B.png', 0, 'Admin'),
(10, 2, 'Special Offer', 'This  is testing msg of notification ', 'Offer', '2025-11-25 10:27:48', 0, '01KAXVREGSA57GCFS81C7K1G4B.png', 0, 'Admin'),
(11, 3, 'Special Offer', 'This  is testing msg of notification ', 'Offer', '2025-11-25 10:27:49', 0, '01KAXVREGSA57GCFS81C7K1G4B.png', 0, 'Admin'),
(12, 6, 'Special Offer', 'This  is testing msg of notification ', 'Offer', '2025-11-25 10:27:50', 0, '01KAXVREGSA57GCFS81C7K1G4B.png', 0, 'Admin');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_number` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `total_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `admin_commission` decimal(10,2) NOT NULL DEFAULT 0.00,
  `delivery_charge` decimal(10,2) NOT NULL DEFAULT 0.00,
  `shipping_address` bigint(20) UNSIGNED NOT NULL,
  `payment_method` varchar(100) NOT NULL,
  `payment_status` varchar(100) DEFAULT 'pending',
  `status` tinyint(1) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `delivery_boy_id` int(11) NOT NULL DEFAULT 0,
  `pickup_otp` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `order_number`, `user_id`, `total_amount`, `admin_commission`, `delivery_charge`, `shipping_address`, `payment_method`, `payment_status`, `status`, `created_at`, `updated_at`, `delivery_boy_id`, `pickup_otp`) VALUES
(2, 'ORD-1762270292-1', 1, 1500.00, 75.00, 0.00, 4, 'COD', 'pending', 0, '2025-11-04 22:31:32', '2025-11-04 22:31:32', 0, '0'),
(5, 'ORD-1762272773-1', 1, 750.00, 37.50, 0.00, 4, 'COD', 'pending', 4, '2025-11-04 23:12:53', '2025-11-04 23:12:53', 0, '0'),
(6, 'ORD-1762273392-1', 1, 1500.00, 75.00, 0.00, 4, 'COD', 'pending', 2, '2025-11-04 23:23:12', '2025-11-10 01:00:31', 10, '0'),
(7, 'ORD-1762273725-1', 1, 750.00, 37.50, 0.00, 4, 'COD', 'pending', 1, '2025-11-04 23:28:45', '2025-11-10 01:05:46', 0, '0'),
(8, 'ORD-1762273931-1', 1, 750.00, 37.50, 0.00, 4, 'COD', 'pending', 5, '2025-11-04 23:32:11', '2025-11-10 01:12:27', 0, '0'),
(9, 'ORD-1762273995-1', 1, 750.00, 37.50, 0.00, 4, 'COD', 'pending', 1, '2025-11-04 23:33:15', '2025-11-10 01:12:38', 0, '0'),
(10, 'ORD-1762312988-1', 1, 750.00, 37.50, 0.00, 4, 'COD', 'pending', 1, '2025-11-05 10:23:08', '2025-11-10 12:23:35', 0, '0'),
(11, 'ORD-1762414756-1', 1, 10.00, 0.50, 0.00, 0, 'ONLINE', 'pending', 1, '2025-11-06 14:39:16', '2025-11-11 13:38:48', 0, '3795'),
(12, 'ORD-1762415043-1', 1, 10.00, 0.50, 0.00, 0, 'COD', 'pending', 1, '2025-11-06 14:44:03', '2025-11-12 13:36:04', 0, '8696'),
(13, 'ORD-1762415119-1', 1, 10.00, 0.50, 0.00, 0, 'COD', 'pending', 1, '2025-11-06 14:45:19', '2025-11-06 14:45:19', 0, '0'),
(14, 'ORD-1762421200-1', 1, 30.00, 1.50, 0.00, 0, 'ONLINE', 'pending', 1, '2025-11-06 16:26:40', '2025-11-14 23:33:31', 0, '2235'),
(15, 'ORD-1762422104-1', 1, 2250.00, 112.50, 0.00, 0, 'COD', 'pending', 1, '2025-11-06 16:41:44', '2025-11-15 15:07:10', 0, '5134'),
(16, 'ORD-1762422414-1', 1, 100.00, 5.00, 0.00, 0, 'COD', 'pending', 1, '2025-11-06 16:46:54', '2025-11-15 17:01:07', 0, '6750'),
(17, 'ORD-1762422678-1', 1, 20.00, 1.00, 0.00, 4, 'COD', 'pending', 2, '2025-11-06 16:51:18', '2025-11-06 16:51:18', 1, '0'),
(18, 'ORD-1762427356-1', 1, 90.00, 4.50, 0.00, 0, 'COD', 'pending', 1, '2025-11-06 18:09:16', '2025-11-15 17:57:34', 0, '3692'),
(19, 'ORD-1762427415-1', 1, 10.00, 0.50, 0.00, 0, 'COD', 'pending', 1, '2025-11-06 18:10:15', '2025-11-17 14:08:35', 0, '7763'),
(20, 'ORD-1762428404-1', 1, 20.00, 1.00, 0.00, 0, 'ONLINE', 'pending', 1, '2025-11-06 18:26:44', '2025-11-18 16:39:26', 0, '6978'),
(21, 'ORD-1762428471-1', 1, 1500.00, 75.00, 0.00, 0, 'COD', 'pending', 1, '2025-11-06 18:27:51', '2025-11-20 15:15:10', 0, '4665'),
(22, 'ORD-1762429222-1', 1, 20.00, 1.00, 0.00, 0, 'ONLINE', 'pending', 1, '2025-11-06 18:40:22', '2025-11-10 13:17:24', 0, '0'),
(23, 'ORD-1762429308-1', 1, 30.00, 1.50, 0.00, 0, 'COD', 'pending', 1, '2025-11-06 18:41:48', '2025-11-20 15:15:24', 0, '5288'),
(24, 'ORD-1762429525-1', 1, 1500.00, 75.00, 0.00, 0, 'COD', 'pending', 3, '2025-11-06 18:45:25', '2025-11-20 15:23:41', 14, '6824'),
(25, 'ORD-1762430257-1', 1, 20.00, 1.00, 0.00, 0, 'ONLINE', 'pending', 1, '2025-11-06 18:57:37', '2025-11-18 16:46:03', 0, '5915'),
(26, 'ORD-1762431009-1', 1, 10.00, 0.50, 0.00, 0, 'COD', 'pending', 5, '2025-11-06 19:10:09', '2025-11-19 14:55:27', 0, '0'),
(27, 'ORD-1762491837-1', 1, 30.00, 1.50, 0.00, 0, 'ONLINE', 'pending', 1, '2025-11-07 12:03:57', '2025-11-19 14:54:50', 0, '3153'),
(28, 'ORD-1762492480-1', 1, 90.00, 4.50, 0.00, 0, 'ONLINE', 'pending', 1, '2025-11-07 12:14:40', '2025-11-20 15:18:26', 0, '9015'),
(29, 'ORD-1762493021-1', 1, 90.00, 4.50, 0.00, 4, 'ONLINE', 'confrim', 1, '2025-11-07 12:23:41', '2025-11-10 13:01:46', 1, '6349'),
(30, 'ORD-1762501528-1', 1, 90.00, 4.50, 0.00, 0, 'COD', 'pending', 1, '2025-11-07 14:45:28', '2025-11-10 00:22:21', 0, '0'),
(31, 'ORD-1762756781-1', 1, 135.00, 6.75, 0.00, 0, 'COD', 'pending', 1, '2025-11-10 13:39:41', '2025-11-18 16:45:46', 0, '2711'),
(32, 'ORD-1762757182-1', 1, 885.00, 44.25, 0.00, 0, 'ONLINE', 'pending', 1, '2025-11-10 13:46:22', '2025-11-20 15:25:39', 0, '9226'),
(34, 'ORD-1762758840-1', 1, 750.00, 37.50, 0.00, 4, 'COD', 'confirm', 1, '2025-11-10 14:14:00', '2025-11-10 15:44:43', 1, '1747'),
(35, 'ORD-1762764061-1', 1, 20.00, 1.00, 0.00, 0, 'ONLINE', 'pending', 1, '2025-11-10 15:41:01', '2025-11-20 15:25:47', 0, '6680'),
(36, 'ORD-1762764144-1', 1, 145.00, 7.25, 0.00, 0, 'COD', 'pending', 1, '2025-11-10 15:42:24', '2025-11-10 15:45:46', 0, NULL),
(37, 'ORD-1762764403-1', 1, 1500.00, 75.00, 0.00, 0, 'COD', 'pending', 1, '2025-11-10 15:46:43', '2025-11-20 15:30:10', 0, '9282'),
(38, 'ORD-1762764478-1', 1, 750.00, 37.50, 0.00, 0, 'COD', 'pending', 1, '2025-11-10 15:47:58', '2025-11-20 15:34:49', 0, '6742'),
(39, 'ORD-1762764574-1', 1, 1500.00, 75.00, 0.00, 0, 'ONLINE', 'pending', 1, '2025-11-10 15:49:34', '2025-11-18 16:38:43', 0, '9956'),
(40, 'ORD-1762765409-1', 1, 90.00, 4.50, 0.00, 0, 'COD', 'pending', 5, '2025-11-10 16:03:29', '2025-11-17 17:53:59', 0, NULL),
(41, 'ORD-1762765444-1', 1, 10.00, 0.50, 0.00, 0, 'COD', 'pending', 1, '2025-11-10 16:04:04', '2025-11-10 18:27:45', 0, NULL),
(42, 'ORD-1762797857-1', 1, 1500.00, 75.00, 0.00, 0, 'COD', 'pending', 1, '2025-11-11 01:04:17', '2025-11-11 01:34:19', 0, NULL),
(45, 'ORD-1762800158-1', 1, 750.00, 37.50, 0.00, 4, 'COD', 'pending', 1, '2025-11-11 01:42:38', '2025-11-11 01:47:11', 0, NULL),
(46, 'ORD-1762805948-1', 1, 750.00, 37.50, 0.00, 4, 'COD', 'confirm', 4, '2025-11-11 03:19:08', '2025-11-11 04:41:30', 13, '8409'),
(47, 'ORD-1762857302-1', 1, 750.00, 37.50, 0.00, 4, 'COD', 'pending', 1, '2025-11-11 17:35:02', '2025-11-17 15:38:49', 13, '7837'),
(48, 'ORD-1763011273-1', 1, 840.00, 42.00, 0.00, 2, 'ONLINE', 'pending', 1, '2025-11-13 12:21:13', '2025-11-13 13:57:58', 0, '9377'),
(49, 'ORD-1763013232-1', 1, 10.00, 0.50, 0.00, 2, 'ONLINE', 'pending', 1, '2025-11-13 12:53:52', '2025-11-13 13:46:47', 0, '4855'),
(50, 'ORD-1763013427-1', 1, 10.00, 0.50, 0.00, 4, 'ONLINE', 'pending', 1, '2025-11-13 12:57:07', '2025-11-18 17:48:15', 0, '8849'),
(51, 'ORD-1763013577-1', 1, 10.00, 0.50, 0.00, 4, 'ONLINE', 'pending', 1, '2025-11-13 12:59:37', '2025-11-13 13:04:46', 0, '8589'),
(52, 'ORD-1763014549-1', 1, 90.00, 4.50, 0.00, 4, 'ONLINE', 'pending', 1, '2025-11-13 13:15:49', '2025-11-13 13:24:49', 0, '9712'),
(53, 'ORD-1763014783-1', 1, 750.00, 37.50, 0.00, 4, 'ONLINE', 'pending', 2, '2025-11-13 13:19:43', '2025-11-15 18:19:21', 14, '5223'),
(54, 'ORD-1763015311-1', 1, 180.00, 9.00, 0.00, 4, 'COD', 'pending', 1, '2025-11-13 13:28:31', '2025-11-13 13:28:55', 0, '4008'),
(55, 'ORD-1763016081-1', 1, 10.00, 0.50, 0.00, 4, 'COD', 'pending', 2, '2025-11-15 13:41:21', '2025-11-15 18:16:45', 14, '9679'),
(56, 'ORD-1763017155-1', 1, 10.00, 0.50, 0.00, 4, 'COD', 'pending', 1, '2025-11-13 13:59:15', '2025-11-15 15:13:07', 14, '5534'),
(57, 'ORD-1763017225-1', 1, 10.00, 0.50, 0.00, 4, 'COD', 'pending', 5, '2025-11-13 14:00:25', '2025-11-17 17:42:07', 0, NULL),
(58, 'ORD-1763018394-1', 1, 750.00, 37.50, 0.00, 4, 'COD', 'pending', 1, '2025-11-13 14:19:54', '2025-11-17 17:41:07', 0, '9185'),
(59, 'ORD-1763018536-1', 1, 750.00, 37.50, 0.00, 4, 'COD', 'pending', 1, '2025-11-13 14:22:16', '2025-11-17 17:40:54', 0, '5807'),
(60, 'ORD-1763019051-1', 1, 10.00, 0.50, 0.00, 4, 'COD', 'pending', 1, '2025-11-13 14:30:51', '2025-11-17 17:39:52', 0, '2687'),
(61, 'ORD-1763019144-1', 1, 10.00, 0.50, 0.00, 4, 'COD', 'pending', 1, '2025-11-13 14:32:24', '2025-11-17 17:38:24', 0, '4705'),
(62, 'ORD-1763019257-1', 1, 750.00, 37.50, 0.00, 4, 'COD', 'pending', 1, '2025-11-13 14:34:17', '2025-11-15 15:13:01', 14, '6806'),
(63, 'ORD-1763019548-1', 1, 10.00, 0.50, 0.00, 4, 'COD', 'pending', 2, '2025-11-13 14:39:08', '2025-11-15 15:12:55', 14, '1285'),
(64, 'ORD-1763019623-1', 1, 2250.00, 112.50, 0.00, 4, 'COD', 'pending', 2, '2025-11-13 14:40:23', '2025-11-13 18:56:44', 14, '8351'),
(65, 'ORD-1763058170-1', 1, 10.00, 0.50, 0.00, 4, 'COD', 'pending', 2, '2025-11-14 01:22:50', '2025-11-15 15:09:34', 14, '6037'),
(66, 'ORD-1763058462-1', 1, 90.00, 4.50, 0.00, 4, 'COD', 'pending', 0, '2025-11-14 01:27:42', '2025-11-14 01:27:42', 0, NULL),
(67, 'ORD-1763058514-1', 1, 10.00, 0.50, 0.00, 4, 'COD', 'pending', 0, '2025-11-14 01:28:34', '2025-11-14 01:28:34', 0, NULL),
(68, 'ORD-1763193528-1', 1, 1705.00, 85.25, 0.00, 4, 'COD', 'confirm', 4, '2025-11-17 14:58:48', '2025-11-17 16:08:55', 14, '7519'),
(69, 'ORD-1763363979-1', 1, 30.00, 1.50, 0.00, 2, 'COD', 'pending', 1, '2025-11-17 14:19:39', '2025-11-17 14:53:33', 0, '9310'),
(70, 'ORD-1763373922-1', 1, 20.00, 1.00, 0.00, 2, 'COD', 'pending', 1, '2025-11-17 17:05:22', '2025-11-17 17:06:37', 0, '4416'),
(71, 'ORD-1763374095-1', 1, 750.00, 37.50, 0.00, 4, 'COD', 'pending', 1, '2025-11-17 17:08:15', '2025-11-17 17:28:19', 0, '1080'),
(72, 'ORD-1763374113-1', 1, 10.00, 0.50, 0.00, 4, 'COD', 'pending', 1, '2025-11-17 17:08:33', '2025-11-17 17:12:06', 0, '4364'),
(73, 'ORD-1763374134-1', 1, 190.00, 9.50, 0.00, 4, 'COD', 'pending', 2, '2025-11-17 17:08:54', '2025-11-17 17:12:40', 14, '8756'),
(74, 'ORD-1763448921-1', 1, 20.00, 1.00, 0.00, 4, 'COD', 'pending', 1, '2025-11-18 13:55:21', '2025-11-19 13:51:10', 0, '8919'),
(75, 'ORD-1763449546-1', 1, 20.00, 1.00, 0.00, 4, 'COD', 'pending', 1, '2025-11-18 14:05:46', '2025-11-20 15:34:58', 0, '9933'),
(76, 'ORD-1763449874-1', 1, 760.00, 38.00, 0.00, 4, 'COD', 'pending', 2, '2025-11-18 14:11:14', '2025-11-20 15:18:39', 14, '2227'),
(77, 'ORD-1763531287-1', 1, 30.00, 1.50, 0.00, 6, 'COD', 'pending', 1, '2025-11-19 12:48:07', '2025-11-20 15:30:49', 0, '9348'),
(78, 'ORD-1763531443-1', 1, 10.00, 0.50, 0.00, 6, 'COD', 'pending', 1, '2025-11-19 12:50:43', '2025-11-20 15:31:38', 0, '5261'),
(79, 'ORD-1763531773-1', 1, 1500.00, 75.00, 0.00, 6, 'COD', 'pending', 2, '2025-11-19 12:56:13', '2025-11-20 15:35:18', 14, '4649'),
(80, 'ORD-1763531838-1', 1, 10.00, 0.50, 0.00, 6, 'COD', 'pending', 0, '2025-11-19 12:57:18', '2025-11-19 12:57:18', 0, NULL),
(81, 'ORD-1763531879-1', 1, 10.00, 0.50, 0.00, 6, 'COD', 'pending', 2, '2025-11-19 12:57:59', '2025-11-19 12:59:27', 14, '9215'),
(82, 'ORD-1763535552-1', 1, 750.00, 37.50, 0.00, 3, 'COD', 'confirm', 4, '2025-11-19 13:59:12', '2025-11-19 14:04:26', 14, '9718'),
(83, 'ORD-1763535894-1', 1, 750.00, 37.50, 0.00, 6, 'COD', 'confirm', 4, '2025-11-19 14:04:54', '2025-11-19 14:11:58', 14, '8148'),
(84, 'ORD-1763536691-1', 1, 50.00, 2.50, 0.00, 7, 'COD', 'pending', 3, '2025-11-19 14:18:11', '2025-11-19 14:31:33', 14, '6017'),
(85, 'ORD-1763537699-1', 1, 10.00, 0.50, 0.00, 4, 'COD', 'pending', 2, '2025-11-19 14:34:59', '2025-11-20 15:16:26', 14, '5032'),
(86, 'ORD-1763538069-1', 1, 750.00, 37.50, 0.00, 7, 'COD', 'confirm', 4, '2025-11-19 14:41:09', '2025-11-19 14:44:10', 14, '1200'),
(87, 'ORD-1763627872-1', 1, 1500.00, 75.00, 0.00, 7, 'COD', 'pending', 1, '2025-11-20 15:37:52', '2025-11-20 15:38:14', 0, '3602'),
(88, 'ORD-1763627983-1', 1, 10.00, 0.50, 0.00, 7, 'COD', 'pending', 3, '2025-11-20 15:39:43', '2025-11-20 15:41:02', 14, '6631');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `total` decimal(10,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `vendor_id` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `quantity`, `price`, `total`, `created_at`, `updated_at`, `vendor_id`) VALUES
(2, 2, 28, 2, 750.00, 1500.00, '2025-11-04 22:31:32', '2025-11-04 22:31:32', 0),
(3, 5, 29, 1, 750.00, 750.00, '2025-11-04 23:12:53', '2025-11-04 23:12:53', 0),
(4, 6, 29, 2, 750.00, 1500.00, '2025-11-04 23:23:12', '2025-11-04 23:23:12', 2),
(5, 7, 29, 1, 750.00, 750.00, '2025-11-04 23:28:45', '2025-11-04 23:28:45', 2),
(6, 8, 29, 1, 750.00, 750.00, '2025-11-04 23:32:11', '2025-11-04 23:32:11', 2),
(7, 9, 29, 1, 750.00, 750.00, '2025-11-04 23:33:15', '2025-11-04 23:33:15', 2),
(8, 10, 29, 1, 750.00, 750.00, '2025-11-05 10:23:08', '2025-11-05 10:23:08', 2),
(9, 11, 25, 1, 10.00, 10.00, '2025-11-06 14:39:16', '2025-11-06 14:39:16', 2),
(10, 12, 27, 1, 10.00, 10.00, '2025-11-06 14:44:03', '2025-11-06 14:44:03', 2),
(11, 13, 26, 1, 10.00, 10.00, '2025-11-06 14:45:19', '2025-11-06 14:45:19', 2),
(12, 14, 27, 1, 10.00, 10.00, '2025-11-06 16:26:40', '2025-11-06 16:26:40', 2),
(13, 14, 26, 1, 10.00, 10.00, '2025-11-06 16:26:40', '2025-11-06 16:26:40', 2),
(14, 14, 25, 1, 10.00, 10.00, '2025-11-06 16:26:40', '2025-11-06 16:26:40', 2),
(15, 15, 31, 1, 750.00, 750.00, '2025-11-06 16:41:44', '2025-11-06 16:41:44', 2),
(16, 15, 32, 1, 750.00, 750.00, '2025-11-06 16:41:44', '2025-11-06 16:41:44', 2),
(17, 15, 30, 1, 750.00, 750.00, '2025-11-06 16:41:44', '2025-11-06 16:41:44', 2),
(18, 16, 23, 1, 90.00, 90.00, '2025-11-06 16:46:54', '2025-11-06 16:46:54', 2),
(19, 16, 24, 1, 10.00, 10.00, '2025-11-06 16:46:54', '2025-11-06 16:46:54', 2),
(20, 17, 26, 1, 10.00, 10.00, '2025-11-06 16:51:18', '2025-11-06 16:51:18', 2),
(21, 17, 27, 1, 10.00, 10.00, '2025-11-06 16:51:18', '2025-11-06 16:51:18', 2),
(22, 18, 23, 1, 90.00, 90.00, '2025-11-06 18:09:16', '2025-11-06 18:09:16', 2),
(23, 19, 26, 1, 10.00, 10.00, '2025-11-06 18:10:15', '2025-11-06 18:10:15', 2),
(24, 20, 27, 1, 10.00, 10.00, '2025-11-06 18:26:44', '2025-11-06 18:26:44', 2),
(25, 20, 35, 1, 10.00, 10.00, '2025-11-06 18:26:44', '2025-11-06 18:26:44', 2),
(26, 21, 28, 1, 750.00, 750.00, '2025-11-06 18:27:51', '2025-11-06 18:27:51', 2),
(27, 21, 29, 1, 750.00, 750.00, '2025-11-06 18:27:51', '2025-11-06 18:27:51', 2),
(28, 22, 39, 1, 10.00, 10.00, '2025-11-06 18:40:22', '2025-11-06 18:40:22', 2),
(29, 22, 41, 1, 10.00, 10.00, '2025-11-06 18:40:22', '2025-11-06 18:40:22', 2),
(30, 23, 37, 3, 10.00, 30.00, '2025-11-06 18:41:48', '2025-11-06 18:41:48', 2),
(31, 24, 31, 1, 750.00, 750.00, '2025-11-06 18:45:25', '2025-11-06 18:45:25', 2),
(32, 24, 30, 1, 750.00, 750.00, '2025-11-06 18:45:25', '2025-11-06 18:45:25', 2),
(33, 25, 34, 1, 10.00, 10.00, '2025-11-06 18:57:37', '2025-11-06 18:57:37', 2),
(34, 25, 33, 1, 10.00, 10.00, '2025-11-06 18:57:37', '2025-11-06 18:57:37', 2),
(35, 26, 33, 1, 10.00, 10.00, '2025-11-06 19:10:09', '2025-11-06 19:10:09', 2),
(36, 27, 37, 1, 10.00, 10.00, '2025-11-07 12:03:57', '2025-11-07 12:03:57', 2),
(37, 27, 38, 1, 10.00, 10.00, '2025-11-07 12:03:57', '2025-11-07 12:03:57', 2),
(38, 27, 36, 1, 10.00, 10.00, '2025-11-07 12:03:57', '2025-11-07 12:03:57', 2),
(39, 28, 23, 1, 90.00, 90.00, '2025-11-07 12:14:40', '2025-11-07 12:14:40', 2),
(40, 29, 23, 1, 90.00, 90.00, '2025-11-07 12:23:41', '2025-11-07 12:23:41', 2),
(41, 30, 23, 1, 90.00, 90.00, '2025-11-07 14:45:28', '2025-11-07 14:45:28', 2),
(42, 31, 23, 1, 90.00, 90.00, '2025-11-10 13:39:41', '2025-11-10 13:39:41', 2),
(43, 31, 1, 1, 45.00, 45.00, '2025-11-10 13:39:41', '2025-11-10 13:39:41', 1),
(44, 32, 23, 1, 90.00, 90.00, '2025-11-10 13:46:22', '2025-11-10 13:46:22', 2),
(45, 32, 1, 1, 45.00, 45.00, '2025-11-10 13:46:22', '2025-11-10 13:46:22', 1),
(46, 32, 30, 1, 750.00, 750.00, '2025-11-10 13:46:22', '2025-11-10 13:46:22', 2),
(48, 34, 29, 1, 750.00, 750.00, '2025-11-10 14:14:00', '2025-11-10 14:14:00', 2),
(49, 35, 26, 2, 10.00, 20.00, '2025-11-10 15:41:01', '2025-11-10 15:41:01', 2),
(50, 36, 23, 1, 90.00, 90.00, '2025-11-10 15:42:24', '2025-11-10 15:42:24', 2),
(51, 36, 24, 1, 10.00, 10.00, '2025-11-10 15:42:24', '2025-11-10 15:42:24', 2),
(52, 36, 1, 1, 45.00, 45.00, '2025-11-10 15:42:24', '2025-11-10 15:42:24', 1),
(53, 37, 31, 1, 750.00, 750.00, '2025-11-10 15:46:43', '2025-11-10 15:46:43', 2),
(54, 37, 28, 1, 750.00, 750.00, '2025-11-10 15:46:43', '2025-11-10 15:46:43', 2),
(55, 38, 31, 1, 750.00, 750.00, '2025-11-10 15:47:58', '2025-11-10 15:47:58', 2),
(56, 39, 31, 1, 750.00, 750.00, '2025-11-10 15:49:34', '2025-11-10 15:49:34', 2),
(57, 39, 32, 1, 750.00, 750.00, '2025-11-10 15:49:34', '2025-11-10 15:49:34', 2),
(58, 40, 23, 1, 90.00, 90.00, '2025-11-10 16:03:29', '2025-11-10 16:03:29', 2),
(59, 41, 39, 1, 10.00, 10.00, '2025-11-10 16:04:04', '2025-11-10 16:04:04', 2),
(60, 42, 30, 1, 750.00, 750.00, '2025-11-11 01:04:17', '2025-11-11 01:04:17', 2),
(61, 42, 29, 1, 750.00, 750.00, '2025-11-11 01:04:17', '2025-11-11 01:04:17', 2),
(64, 45, 29, 1, 750.00, 750.00, '2025-11-11 01:42:38', '2025-11-11 01:42:38', 2),
(65, 46, 29, 1, 750.00, 750.00, '2025-11-11 03:19:08', '2025-11-11 03:19:08', 2),
(66, 47, 29, 1, 750.00, 750.00, '2025-11-11 17:35:02', '2025-11-11 17:35:02', 2),
(67, 48, 23, 1, 90.00, 90.00, '2025-11-13 12:21:13', '2025-11-13 12:21:13', 2),
(68, 48, 31, 1, 750.00, 750.00, '2025-11-13 12:21:13', '2025-11-13 12:21:13', 2),
(69, 49, 26, 1, 10.00, 10.00, '2025-11-13 12:53:52', '2025-11-13 12:53:52', 2),
(70, 50, 27, 1, 10.00, 10.00, '2025-11-13 12:57:07', '2025-11-13 12:57:07', 2),
(71, 51, 27, 1, 10.00, 10.00, '2025-11-13 12:59:37', '2025-11-13 12:59:37', 2),
(72, 52, 23, 1, 90.00, 90.00, '2025-11-13 13:15:49', '2025-11-13 13:15:49', 2),
(73, 53, 32, 1, 750.00, 750.00, '2025-11-13 13:19:43', '2025-11-13 13:19:43', 2),
(74, 54, 23, 2, 90.00, 180.00, '2025-11-13 13:28:31', '2025-11-13 13:28:31', 2),
(75, 55, 37, 1, 10.00, 10.00, '2025-11-13 13:41:21', '2025-11-13 13:41:21', 2),
(76, 56, 27, 1, 10.00, 10.00, '2025-11-13 13:59:15', '2025-11-13 13:59:15', 2),
(77, 57, 25, 1, 10.00, 10.00, '2025-11-13 14:00:25', '2025-11-13 14:00:25', 2),
(78, 58, 28, 1, 750.00, 750.00, '2025-11-13 14:19:54', '2025-11-13 14:19:54', 2),
(79, 59, 31, 1, 750.00, 750.00, '2025-11-13 14:22:16', '2025-11-13 14:22:16', 2),
(80, 60, 27, 1, 10.00, 10.00, '2025-11-13 14:30:51', '2025-11-13 14:30:51', 2),
(81, 61, 27, 1, 10.00, 10.00, '2025-11-13 14:32:24', '2025-11-13 14:32:24', 2),
(82, 62, 31, 1, 750.00, 750.00, '2025-11-13 14:34:17', '2025-11-13 14:34:17', 2),
(83, 63, 24, 1, 10.00, 10.00, '2025-11-13 14:39:08', '2025-11-13 14:39:08', 2),
(84, 64, 31, 3, 750.00, 2250.00, '2025-11-13 14:40:23', '2025-11-13 14:40:23', 2),
(85, 65, 26, 1, 10.00, 10.00, '2025-11-14 01:22:50', '2025-11-14 01:22:50', 2),
(86, 66, 23, 1, 90.00, 90.00, '2025-11-14 01:27:42', '2025-11-14 01:27:42', 1),
(87, 67, 24, 1, 10.00, 10.00, '2025-11-14 01:28:34', '2025-11-14 01:28:34', 4),
(88, 68, 31, 1, 750.00, 750.00, '2025-11-15 14:58:48', '2025-11-15 14:58:48', 2),
(89, 68, 27, 4, 10.00, 40.00, '2025-11-15 14:58:48', '2025-11-15 14:58:48', 2),
(90, 68, 26, 1, 10.00, 10.00, '2025-11-15 14:58:48', '2025-11-15 14:58:48', 2),
(91, 68, 25, 1, 10.00, 10.00, '2025-11-15 14:58:48', '2025-11-15 14:58:48', 2),
(92, 68, 24, 1, 10.00, 10.00, '2025-11-15 14:58:48', '2025-11-15 14:58:48', 4),
(93, 68, 23, 1, 90.00, 90.00, '2025-11-15 14:58:48', '2025-11-15 14:58:48', 1),
(94, 68, 1, 1, 45.00, 45.00, '2025-11-15 14:58:48', '2025-11-15 14:58:48', 1),
(95, 68, 32, 1, 750.00, 750.00, '2025-11-15 14:58:48', '2025-11-15 14:58:48', 2),
(96, 69, 26, 1, 10.00, 10.00, '2025-11-17 14:19:39', '2025-11-17 14:19:39', 2),
(97, 69, 27, 1, 10.00, 10.00, '2025-11-17 14:19:39', '2025-11-17 14:19:39', 2),
(98, 69, 25, 1, 10.00, 10.00, '2025-11-17 14:19:39', '2025-11-17 14:19:39', 2),
(99, 70, 35, 1, 10.00, 10.00, '2025-11-17 17:05:22', '2025-11-17 17:05:22', 2),
(100, 70, 34, 1, 10.00, 10.00, '2025-11-17 17:05:22', '2025-11-17 17:05:22', 2),
(101, 71, 32, 1, 750.00, 750.00, '2025-11-17 17:08:15', '2025-11-17 17:08:15', 2),
(102, 72, 34, 1, 10.00, 10.00, '2025-11-17 17:08:33', '2025-11-17 17:08:33', 2),
(103, 73, 39, 1, 10.00, 10.00, '2025-11-17 17:08:54', '2025-11-17 17:08:54', 2),
(104, 73, 42, 1, 180.00, 180.00, '2025-11-17 17:08:54', '2025-11-17 17:08:54', 2),
(105, 74, 24, 1, 10.00, 10.00, '2025-11-18 13:55:21', '2025-11-18 13:55:21', 4),
(106, 74, 26, 1, 10.00, 10.00, '2025-11-18 13:55:21', '2025-11-18 13:55:21', 2),
(107, 75, 26, 1, 10.00, 10.00, '2025-11-18 14:05:46', '2025-11-18 14:05:46', 2),
(108, 75, 27, 1, 10.00, 10.00, '2025-11-18 14:05:46', '2025-11-18 14:05:46', 2),
(109, 76, 31, 1, 750.00, 750.00, '2025-11-18 14:11:14', '2025-11-18 14:11:14', 2),
(110, 76, 41, 1, 10.00, 10.00, '2025-11-18 14:11:14', '2025-11-18 14:11:14', 2),
(111, 77, 26, 1, 10.00, 10.00, '2025-11-19 12:48:07', '2025-11-19 12:48:07', 2),
(112, 77, 25, 1, 10.00, 10.00, '2025-11-19 12:48:07', '2025-11-19 12:48:07', 2),
(113, 77, 27, 1, 10.00, 10.00, '2025-11-19 12:48:07', '2025-11-19 12:48:07', 2),
(114, 78, 26, 1, 10.00, 10.00, '2025-11-19 12:50:43', '2025-11-19 12:50:43', 2),
(115, 79, 31, 1, 750.00, 750.00, '2025-11-19 12:56:13', '2025-11-19 12:56:13', 2),
(116, 79, 30, 1, 750.00, 750.00, '2025-11-19 12:56:13', '2025-11-19 12:56:13', 2),
(117, 80, 24, 1, 10.00, 10.00, '2025-11-19 12:57:18', '2025-11-19 12:57:18', 4),
(118, 81, 37, 1, 10.00, 10.00, '2025-11-19 12:57:59', '2025-11-19 12:57:59', 2),
(119, 82, 31, 1, 750.00, 750.00, '2025-11-19 13:59:12', '2025-11-19 13:59:12', 2),
(120, 83, 31, 1, 750.00, 750.00, '2025-11-19 14:04:54', '2025-11-19 14:04:54', 2),
(121, 84, 26, 5, 10.00, 50.00, '2025-11-19 14:18:11', '2025-11-19 14:18:11', 2),
(122, 85, 27, 1, 10.00, 10.00, '2025-11-19 14:34:59', '2025-11-19 14:34:59', 2),
(123, 86, 28, 1, 750.00, 750.00, '2025-11-19 14:41:09', '2025-11-19 14:41:09', 2),
(124, 87, 31, 1, 750.00, 750.00, '2025-11-20 15:37:52', '2025-11-20 15:37:52', 2),
(125, 87, 30, 1, 750.00, 750.00, '2025-11-20 15:37:52', '2025-11-20 15:37:52', 2),
(126, 88, 39, 1, 10.00, 10.00, '2025-11-20 15:39:43', '2025-11-20 15:39:43', 2);

-- --------------------------------------------------------

--
-- Table structure for table `other_data`
--

CREATE TABLE `other_data` (
  `id` int(11) NOT NULL,
  `gst_percent` double NOT NULL,
  `company_name` text NOT NULL,
  `company_photo` text NOT NULL,
  `added_date_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `other_data`
--

INSERT INTO `other_data` (`id`, `gst_percent`, `company_name`, `company_photo`, `added_date_time`) VALUES
(1, 15, 'UdhayBharat', '01KAXMT8FAD46NAP07QYDHA5T2.jpg', '2025-11-25 13:56:25');

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_image_list`
--

CREATE TABLE `product_image_list` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `image` text NOT NULL,
  `added_date_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product_image_list`
--

INSERT INTO `product_image_list` (`id`, `product_id`, `image`, `added_date_time`) VALUES
(3, 47, '01KAVCYE59EM5H6YVABCFPD9YS.jpg', '2025-11-24 17:00:25'),
(4, 0, '01KAVBS4NSW0DZ39J13KCSYMBQ.jpg', '2025-11-24 11:10:03'),
(5, 47, '01KAVCSH9CGGNY8SYKBCPQXEGB.jpg', '2025-11-24 11:27:44'),
(6, 47, '01KAVCZ8Z2D23SVXE6BPZ34KEX.jpg', '2025-11-24 11:30:52'),
(7, 47, '01KAVD2QD2FC6VMNE4PYZGR8SM.png', '2025-11-24 11:32:45'),
(8, 48, '01KAVDW2NF1X9XHA52PBM6Y41X.jpg', '2025-11-24 11:46:36');

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `key` varchar(255) NOT NULL,
  `value` text DEFAULT NULL,
  `type` varchar(255) NOT NULL DEFAULT 'string',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subcategory_list`
--

CREATE TABLE `subcategory_list` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `cat_type_id` int(11) NOT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `discription` text DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `added_date_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `subcategory_list`
--

INSERT INTO `subcategory_list` (`id`, `cat_type_id`, `category_id`, `name`, `image`, `discription`, `status`, `added_date_time`, `created_at`, `updated_at`) VALUES
(1, 2, 31, 'Fresh Fruits', '', 'Seasonal and tropical fruits freshly sourced.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(2, 0, 11, 'Leafy Greens', '', 'Spinach, coriander, and other leafy vegetables.', 1, '2025-11-24 12:54:03', '2025-10-30 04:54:21', '2025-11-24 07:24:03'),
(3, 0, 11, 'Root Vegetables', '', 'Potatoes, carrots, onions, and garlic.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(4, 0, 11, 'Exotic Vegetables', '', 'Broccoli, zucchini, and bell peppers.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(5, 0, 11, 'Herbs & Seasoning', '', 'Mint, basil, curry leaves, and more.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(6, 0, 12, 'Milk & Curd', '01KAVE29HG1EDWT5BY209GC3BF.jpg', 'Fresh milk, curd, and paneer.', 1, '2025-11-24 17:20:00', '2025-10-30 04:54:21', '2025-11-24 11:50:00'),
(7, 0, 12, 'Bread & Buns', '', 'White, brown, and multigrain breads.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(8, 0, 12, 'Butter & Cheese', '01KAVE394YBAZ7VWMXVN57GZT0.jpg', 'Dairy spreads and cheese varieties.', 1, '2025-11-24 17:20:32', '2025-10-30 04:54:21', '2025-11-24 11:50:32'),
(9, 0, 12, 'Cakes & Pastries', '', 'Freshly baked desserts and pastries.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(10, 0, 12, 'Bakery Snacks', '', 'Puffs, croissants, and tea-time snacks.', 1, '2025-11-24 12:55:03', '2025-10-30 04:54:21', '2025-11-24 07:25:03'),
(11, 0, 13, 'Chips & Wafers', '', 'Potato chips, banana chips, and more.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(12, 0, 13, 'Biscuits & Cookies', '', 'Cream biscuits and healthy cookies.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(13, 0, 13, 'Namkeen & Mixtures', '', 'Indian savory mixes and farsan.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(14, 0, 13, 'Popcorn & Cornflakes', '', 'Ready-to-eat light snacks.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(15, 0, 13, 'Chocolates & Candies', '', 'Sweet treats for all ages.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(16, 0, 14, 'Soft Drinks', '', 'Cola, soda, and fizzy drinks.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(17, 0, 14, 'Juices', '', 'Packaged fruit and vegetable juices.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(18, 0, 14, 'Tea & Coffee', '', 'Instant coffee, green tea, and powders.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(19, 0, 14, 'Energy Drinks', '', 'Health and energy beverages.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(20, 0, 14, 'Water & Soda', '', 'Mineral water and soda bottles.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(21, 0, 15, 'Rice & Grains', '', 'Basmati rice, brown rice, and more.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(22, 0, 15, 'Atta & Flours', '', 'Whole wheat, multigrain, and maida.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(23, 0, 15, 'Pulses & Dal', '', 'Lentils, beans, and peas.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(24, 0, 15, 'Salt & Sugar', '', 'Kitchen essentials for every home.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(25, 0, 15, 'Cooking Oil & Ghee', '', 'Refined oils and pure ghee.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(26, 0, 16, 'Hair Care', '', 'Shampoos, oils, and conditioners.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(27, 0, 16, 'Skin Care', '', 'Lotions, creams, and moisturizers.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(28, 0, 16, 'Oral Care', '', 'Toothpaste, brushes, and mouthwash.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(29, 0, 16, 'Deodorants & Perfumes', '', 'Fragrance and body sprays.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(30, 0, 16, 'Hygiene Essentials', '', 'Sanitary and personal hygiene items.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(31, 0, 17, 'Cleaners', '', 'Surface and glass cleaners.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(32, 0, 17, 'Detergents', '', 'Powders, liquids, and bars.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(33, 0, 17, 'Fresheners', '', 'Air and room fresheners.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(34, 0, 17, 'Paper Products', '', 'Tissues, napkins, and rolls.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(35, 0, 17, 'Utility Tools', '', 'Cleaning brushes and tools.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(36, 0, 18, 'Diapers & Wipes', '', 'Baby diapers and wet wipes.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(37, 0, 18, 'Baby Food', '', 'Infant cereals and baby snacks.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(38, 0, 18, 'Bath & Hygiene', '', 'Shampoo, lotion, and powder.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(39, 0, 18, 'Feeding Accessories', '', 'Bottles, nipples, and cups.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(40, 0, 18, 'Baby Toys', '', 'Soft and learning toys.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(41, 0, 19, 'Chicken', '', 'Fresh and frozen chicken.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(42, 0, 19, 'Fish', '', 'Freshwater and seawater fish.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(43, 0, 19, 'Eggs', '', 'Farm fresh eggs.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(44, 0, 19, 'Mutton', '', 'Tender and premium cuts.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(45, 0, 19, 'Seafood', '', 'Prawns, crab, and shellfish.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(46, 0, 20, 'Dog Food', '', 'Dry and wet food for dogs.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(47, 0, 20, 'Cat Food', '', 'Whiskas and meo cat foods.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(48, 0, 20, 'Pet Grooming', '', 'Shampoo, brush, and towels.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(49, 0, 20, 'Accessories', '', 'Leashes, collars, and toys.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(50, 0, 20, 'Pet Health', '', 'Vitamins and supplements.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(51, 0, 21, 'Cornflakes', '', 'Classic and flavored cornflakes.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(52, 0, 21, 'Oats', '', 'Rolled and instant oats.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(53, 0, 21, 'Muesli', '', 'Healthy breakfast mix.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(54, 0, 21, 'Honey & Jams', '', 'Sweet spreads for bread.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(55, 0, 21, 'Peanut Butter', '', 'Protein-rich nut spread.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(56, 0, 22, 'Instant Noodles', '', 'Masala and cup noodles.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(57, 0, 22, 'Ready-to-Cook Meals', '', 'Packaged meal kits.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(58, 0, 22, 'Pasta & Macaroni', '', 'Italian-style pasta dishes.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(59, 0, 22, 'Soup Mixes', '', 'Instant soup powders.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(60, 0, 22, 'Vermicelli', '', 'For sweet and savory recipes.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(61, 0, 23, 'Powdered Masalas', '', 'Turmeric, chilli, coriander.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(62, 0, 23, 'Whole Spices', '', 'Cumin, mustard, and cloves.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(63, 0, 23, 'Blended Masalas', '', 'Curry and garam masala.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(64, 0, 23, 'Salt & Sugar', '', 'Table salt and brown sugar.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(65, 0, 23, 'Herbs', '', 'Oregano, thyme, basil.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(66, 0, 24, 'Almonds', '', 'Premium badam.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(67, 0, 24, 'Cashews', '', 'Whole and roasted cashews.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(68, 0, 24, 'Raisins', '', 'Golden and black kishmish.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(69, 0, 24, 'Pistachios', '', 'Roasted pista nuts.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(70, 0, 24, 'Mixed Dry Fruits', '', 'Healthy mixed packs.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(71, 0, 25, 'Protein Powder', '', 'Whey and plant-based proteins.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(72, 0, 25, 'Energy Bars', '', 'Nutritious energy bars.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(73, 0, 25, 'Health Drinks', '', 'Nutritional beverages.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(74, 0, 25, 'Vitamins & Supplements', '', 'Daily wellness supplements.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(75, 0, 25, 'Weight Management', '', 'Slimming and keto products.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(76, 0, 26, 'Frozen Snacks', '', 'Samosa, fries, and nuggets.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(77, 0, 26, 'Frozen Veggies', '', 'Peas, corn, and mixed veggies.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(78, 0, 26, 'Parathas', '', 'Ready-to-cook parathas.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(79, 0, 26, 'Ice Creams', '', 'Family packs and cones.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(80, 0, 26, 'Frozen Meats', '', 'Pre-cooked meat items.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(81, 0, 27, 'Detergent Powder', '', 'Popular washing powders.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(82, 0, 27, 'Dishwash', '', 'Liquid and bars.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(83, 0, 27, 'Floor Cleaners', '', 'Disinfectant and phenyl.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(84, 0, 27, 'Toilet Cleaners', '', 'Hygienic bathroom cleaners.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(85, 0, 27, 'Mops & Brushes', '', 'Cleaning essentials.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(86, 0, 28, 'Pens & Pencils', '', 'Ball pens and gel pens.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(87, 0, 28, 'Notebooks', '', 'School and office notebooks.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(88, 0, 28, 'Files & Folders', '', 'Office organization items.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(89, 0, 28, 'Art Supplies', '', 'Crayons, paints, and brushes.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(90, 0, 28, 'Office Essentials', '', 'Staplers, clips, and markers.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(91, 0, 29, 'Makeup', '', 'Lipsticks, compacts, and more.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(92, 0, 29, 'Skincare', '', 'Cleansers and moisturizers.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(93, 0, 29, 'Haircare', '', 'Oils, masks, and styling.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(94, 0, 29, 'Fragrances', '', 'Perfumes and mists.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(95, 0, 29, 'Men Grooming', '', 'Beard oils and shaving kits.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(96, 0, 30, 'Chargers & Cables', '', 'USB and Type-C accessories.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(97, 0, 30, 'Batteries', '', 'AA, AAA, and coin batteries.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(98, 0, 30, 'Earphones', '', 'Wired and Bluetooth audio.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(99, 0, 30, 'Mobile Accessories', '', 'Covers and screen guards.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(100, 0, 30, 'Power Banks', '', 'Portable charging devices.', 1, '2025-10-30 04:54:21', '2025-10-30 04:54:21', '2025-10-30 04:54:21'),
(102, 1, 11, 'testting', '01KATYJ8J59866YR5S54MGA4CA.jpg', 'This is testing subcaegories', 1, '2025-11-24 12:51:03', '2025-11-24 07:10:53', '2025-11-24 07:19:06'),
(103, 1, 11, 'testting smg', '01KATYR1TKSAN9DCRA286DVX0T.jpg', 'hitnndzun', 1, '2025-11-24 12:52:15', '2025-11-24 07:22:15', '2025-11-24 07:22:15');

-- --------------------------------------------------------

--
-- Table structure for table `user_address_list`
--

CREATE TABLE `user_address_list` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `address_name` varchar(255) NOT NULL,
  `address_mobile_number` varchar(255) NOT NULL,
  `house_apartment_no` varchar(255) DEFAULT NULL,
  `street` text NOT NULL,
  `area` text NOT NULL,
  `city` text NOT NULL,
  `state` text NOT NULL,
  `pin_code` int(11) NOT NULL,
  `landmark` text NOT NULL,
  `address_type` text NOT NULL,
  `gps_address` text NOT NULL,
  `gps_lat` double NOT NULL,
  `gps_long` double NOT NULL,
  `added_date_time` datetime NOT NULL DEFAULT current_timestamp(),
  `is_default` int(11) NOT NULL,
  `is_deleted` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_address_list`
--

INSERT INTO `user_address_list` (`id`, `user_id`, `address_name`, `address_mobile_number`, `house_apartment_no`, `street`, `area`, `city`, `state`, `pin_code`, `landmark`, `address_type`, `gps_address`, `gps_lat`, `gps_long`, `added_date_time`, `is_default`, `is_deleted`) VALUES
(1, 1, 'Rajan', '6396063416', '65/2 204 om paza Apratment', 'Indragnagr', 'Munshi Puliya', 'Lucknow', 'Uttar Pradesh', 226016, 'In fornt of moon Bulding', 'Office', 'Lucknow Uttar Pradesh', 25.2101542, 83.02064575, '2025-10-31 07:50:59', 0, 0),
(2, 1, 'jgh', '6588545588', '', '', '', '', '', 221105, 'hhg', 'Office', 'Harahua, Harhua, Uttar Pradesh', 25.385506645185174, 82.90122237056494, '2025-11-01 10:59:57', 0, 0),
(3, 1, 'jgh', '6588545588', '', '9VJW+HQ', '', 'Bazar Patti', 'Uttar Pradesh', 221105, 'hhg', 'Office', '9VJW+HQ, Bazar Patti, Uttar Pradesh', 25.381788754971822, 82.89432607591152, '2025-11-01 11:14:20', 0, 0),
(4, 1, 'Rajan', '6396063416', '65/2 204 om paza Apratment', 'Indragnagr', 'Munshi Puliya', 'Lucknow', 'Uttar Pradesh', 226016, 'In fornt of moon Bulding', 'Office', 'Lucknow Uttar Pradesh', 25.2101542, 83.02064575, '2025-11-02 05:24:10', 1, 0),
(5, 1, 'krishna', '8423485660', '', 'Harahua', '', 'Harhua', 'Uttar Pradesh', 221105, 'pillar number 30', 'Home', 'Harahua, Harhua, Uttar Pradesh', 25.385526939692966, 82.90126964449883, '2025-11-19 05:31:43', 0, 0),
(6, 1, 'krishna', '8423485660', '', 'Vill', '', 'Varanasi', 'Uttar Pradesh', 221105, '', 'Office', 'Vill, Varanasi, Uttar Pradesh', 25.390543819102454, 82.90613383054733, '2025-11-19 05:47:55', 0, 0),
(7, 1, 'ram', '2336554148', '', '9VGX+QFR', '', 'Bhagtupur', 'Uttar Pradesh', 221105, '', 'Home', '9VGX+QFR, Bhagtupur, Uttar Pradesh', 25.37694902574076, 82.89856296032667, '2025-11-19 07:16:44', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `user_wallet_transactions`
--

CREATE TABLE `user_wallet_transactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `amt` decimal(10,2) NOT NULL,
  `operation_type` enum('credit','debit') NOT NULL,
  `remark` text DEFAULT NULL,
  `status` int(11) NOT NULL,
  `is_send_to_admin` tinyint(1) NOT NULL DEFAULT 0,
  `is_send_to_vendor` tinyint(1) NOT NULL DEFAULT 0,
  `added_date_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `booking_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `applicable_on` int(11) NOT NULL,
  `applicable_on_amt` double NOT NULL,
  `is_recharge` int(11) NOT NULL,
  `payment_id` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_wallet_transactions`
--

INSERT INTO `user_wallet_transactions` (`id`, `user_id`, `amt`, `operation_type`, `remark`, `status`, `is_send_to_admin`, `is_send_to_vendor`, `added_date_time`, `booking_id`, `created_at`, `updated_at`, `applicable_on`, `applicable_on_amt`, `is_recharge`, `payment_id`) VALUES
(4, 1, 120.00, 'credit', 'Wallet added', 0, 1, 0, '2025-11-22 08:35:55', 0, '2025-11-22 07:39:27', '2025-11-22 07:39:27', 399, 0, 0, ''),
(5, 1, 10.00, 'credit', 'Your Recharge successfully!', 0, 0, 0, '2025-11-22 08:34:33', 0, '2025-11-22 15:33:50', '2025-11-22 15:33:50', 0, 0, 0, ''),
(6, 1, 10.00, 'credit', 'Your Recharge successfully!', 0, 0, 0, '2025-11-22 15:36:01', 0, '2025-11-22 15:36:01', '2025-11-22 15:36:01', 0, 0, 0, ''),
(7, 1, 10.00, 'credit', 'Your Recharge successfully!', 0, 0, 0, '2025-11-22 16:02:42', 0, '2025-11-22 16:02:42', '2025-11-22 16:02:42', 0, 0, 1, ''),
(8, 1, 100.00, 'credit', 'Your Recharge successfully!', 0, 0, 0, '2025-11-22 16:03:56', 0, '2025-11-22 16:03:56', '2025-11-22 16:03:56', 0, 0, 1, ''),
(9, 1, 10.00, 'credit', 'Your Recharge successfully!', 0, 0, 0, '2025-11-22 16:09:50', 0, '2025-11-22 16:09:50', '2025-11-22 16:09:50', 0, 0, 1, 'dsmbfy379y899');

-- --------------------------------------------------------

--
-- Table structure for table `vendors`
--

CREATE TABLE `vendors` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `mobile_number` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `shop_name` varchar(255) DEFAULT NULL,
  `shop_category` varchar(255) DEFAULT NULL,
  `business_type` varchar(255) DEFAULT NULL,
  `gst_number` varchar(255) DEFAULT NULL,
  `pan_number` varchar(255) DEFAULT NULL,
  `licence_number` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `pincode` varchar(255) DEFAULT NULL,
  `landmark` varchar(255) DEFAULT NULL,
  `services_coverage` varchar(255) DEFAULT NULL,
  `shop_image` varchar(255) DEFAULT NULL,
  `aadhar_front` varchar(255) DEFAULT NULL,
  `aadhar_back` varchar(255) DEFAULT NULL,
  `gps_lat` varchar(255) DEFAULT NULL,
  `gps_long` varchar(255) DEFAULT NULL,
  `gps_location` varchar(255) DEFAULT NULL,
  `is_verified` varchar(255) DEFAULT NULL,
  `is_bestseller` varchar(255) DEFAULT NULL,
  `wallet_balance` decimal(10,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `fiberbase_token` varchar(255) DEFAULT '',
  `handling_charge` varchar(255) DEFAULT '',
  `gst_certificate` varchar(255) DEFAULT '',
  `pan_card` varchar(255) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `vendors`
--

INSERT INTO `vendors` (`id`, `full_name`, `email`, `mobile_number`, `password`, `shop_name`, `shop_category`, `business_type`, `gst_number`, `pan_number`, `licence_number`, `address`, `country`, `state`, `city`, `pincode`, `landmark`, `services_coverage`, `shop_image`, `aadhar_front`, `aadhar_back`, `gps_lat`, `gps_long`, `gps_location`, `is_verified`, `is_bestseller`, `wallet_balance`, `created_at`, `updated_at`, `fiberbase_token`, `handling_charge`, `gst_certificate`, `pan_card`) VALUES
(1, 'Shnaker', 'hudbu@gmail.com', '6396063420', '$2y$12$q/S6NWItIq.6VQawZR.4fOkmj1h3Z55HULa.5Xih.IzxoMiqZfaaW', 'Rajat All In One Shop', '1', 'Retails', 'jhf7y48904u', 'GDUS838G', '', 'Tedipuliya', 'India', 'Uttar Pradesh', 'Banarsh', '226016', 'Near Vishwnath temple', '20', '1761682085_shop_image_ownerphoto.avif', '1761682085_aadhar_front_punch-1659696343-prod-var.jpg', '1761682085_aadhar_back_pexels-mehmoodyousafzaii-20539380.jpg', '45.16113.244', '45.24446464', 'Shri Kashi Vishwanath Temple', '1', '1', 0.00, '2025-10-29 03:08:05', '2025-11-17 12:59:08', 'eMOSUWfPRgujaL3hMo2SHK:APA91bFdpnCRycaZc2wKni1zfxs92UN35cKs2ss5puitnLHmNyKoEVCQIboEpz-4zw36Cuivo6VDbHH5qURJOG-bfqfAZg0WlxDMAGHogI1BPCQwpO4dRLc', '0', '1761682085_shop_image_ownerphoto.avif', '1761682085_shop_image_ownerphoto.avif'),
(2, 'krishna', '@gmail.com', '8423485666', '$2y$12$/zkY.WKsld1lrFs1WwmBCeqvJOX19XQZ6ojRunVdVyWzlUseE7azW', 'krishna grocery 1', '', '1', '27ABCDE1234F1Z5', 'FRHPM5675J', '312542484584', '', 'india', 'null', 'null', 'null', '', '6.0', '1761682085_shop_image_ownerphoto.avif', '1761815965_aadhar_front_1000079171.jpg', '1761815965_aadhar_back_1000079253.jpg', '25.3790999', '82.9023401', 'Harahua, Harahua, , Harhua, Uttar Pradesh, 221105, India', '1', '1', 0.00, '2025-10-29 12:26:52', '2025-11-22 19:29:23', 'c1OSlHpEQGuQh6euDr_wY9:APA91bHnc8gZVTRMNaQiKhLclcmCeZ3mAXzzM6DeYijliUTfRlU5L5GIrlZIM9HDbOTMSNNpHPw9rpyKNkT8BiHJ33MCC2p_zOyTFGpg7FHuA13vUDp82J8', '0', '1763381868_gst_certificate_34445.jpg', '1763381868_pan_card_34445.jpg'),
(3, 'krishna', 'krishna6maurya@gmail.com', '8423485666', '$2y$12$48qhajWetEujIl8nP5Ri4e6TgJffEbKfEll7I07VjnNXvia9lnaVG', '', '', '', '', '', '', '', 'india', '', '', '', '', '10', NULL, NULL, NULL, '', '', '', '1', '1', 0.00, '2025-10-30 15:57:09', '2025-11-18 01:05:49', 'cUGjFExKRnufchASyYVyhl:APA91bFUHmmcB4N-qb8_GIq2hAdXt8QuWj0pE5JJcNJfG6QVF6B1dVLh-1zVrg5asl4EpE5v9jCAZzWgcWk9ARResBbUXvl-ivp1GpyUppEHRR50WhhCpTc', '0', '', ''),
(4, 'Shnaker', 'hudbu@gmail.com', '6396063421', '$2y$12$ZkFYeah8YiGTltx4uz9tge7fEKHmjZlOQHyXcuposkgXsqYhY.dI2', 'Rajat All In One Shop', '1', 'Retails', 'jhf7y48904u', 'GDUS838G', '', 'Tedipuliya', 'India', 'Uttar Pradesh', 'Banarsh', '226016', 'Near Vishwnath temple', '20', NULL, NULL, NULL, '25.3108532', '83.0106783', 'Shri Kashi Vishwanath Temple', '1', '1', 0.00, '2025-10-31 10:09:09', '2025-10-31 10:09:09', '', '0', '', ''),
(5, 'Shnaker', 'hudbu@gmail.com', '6396063422', '$2y$12$aGaDretX6USIjpU9thtLT.02Leoj7HeT9PmCOpL9L53Wy8eVT3tDO', 'Rajat All In One Shop', '1', 'Retails', 'jhf7y48904u', 'GDUS838G', '', 'Tedipuliya', 'India', 'Uttar Pradesh', 'Banarsh', '226016', 'Near Vishwnath temple', '20', '1763442218_shop_image_home_page2.jpg', '1763442218_aadhar_front_home_page2.jpg', '1763442218_aadhar_back_home_page2.jpg', '25.3108532', '83.0106783', 'Shri Kashi Vishwanath Temple', '0', NULL, 0.00, '2025-11-18 12:03:38', '2025-11-18 12:03:38', '', '20', '1763442218_gst_certificate_home_page2.jpg', '1763442218_pan_card_home_page2.jpg'),
(6, 'kkkhh', '@gmail.com', '2323228808', '$2y$12$/sG6F7l177FjOuMQzzc.OumAYvMpy4aH5Kx3r8S9vTyjiOQ7aBCFC', '', '', '', '', '', '', '', 'india', '', '', '', '', '10', NULL, NULL, NULL, '', '', '', '0', NULL, 0.00, '2025-11-19 17:33:07', '2025-11-19 17:33:07', '', '', '', ''),
(7, 'kkkhh', 'gh@gmail.com', '2323228806', '$2y$12$Cn4j/DJw8lX8aDQwyuSrLOLEjj/qgH95PG6XaI5fmmze/A68rOXRC', '', '', '', '', '', '', '', 'india', '', '', '', '', '10', NULL, NULL, NULL, '', '', '', '0', NULL, 0.00, '2025-11-19 17:34:35', '2025-11-19 17:34:35', '', '', '', ''),
(8, 'kkkhh', 'gh@gmail.com', '2323228804', '$2y$12$CVmxXEOkNf84Kg8zVhOateWDDmCNI9Mgn8cYN3PrbXXBuARkSrpLG', '', '', '', '', '', '', '', 'india', '', '', '', '', '10', NULL, NULL, NULL, '', '', '', '0', NULL, 0.00, '2025-11-19 17:36:30', '2025-11-19 17:36:30', '', '', '', ''),
(9, 'kkkhh', 'gh@gmail.com', '2323228801', '$2y$12$SZ/GCy1rFjcshv2rGKKAX.MvcbMXaaghIH7J4WT43VS9hh4YChI46', '', '', '', '', '', '', '', 'india', '', '', '', '', '10', NULL, NULL, NULL, '', '', '', '0', NULL, 0.00, '2025-11-19 17:37:35', '2025-11-19 17:37:35', '', '', '', ''),
(10, 'jjh', 'krishna6maurya@gmail.com', '2554554844', '$2y$12$kzOxbdeLLa0ID.yOoebhOe9C6cQvr0JkWHATLPSm5HM5jj5vGmD2.', '', '', '', '', '', '', '', 'india', '', '', '', '', '10', NULL, NULL, NULL, '', '', '', '0', NULL, 0.00, '2025-11-19 17:44:11', '2025-11-19 17:44:11', '', '', '', ''),
(11, 'jjh', 'krishna6maurya@gmail.com', '2554554840', '$2y$12$spHVmFWzmowIc43b10VzdOZGn0WvPLLYPkotl0ki6moJv8fM8j3i6', '', '', '', '', '', '', '', 'india', '', '', '', '', '10', NULL, NULL, NULL, '', '', '', '0', NULL, 0.00, '2025-11-19 17:50:41', '2025-11-19 17:50:41', '', '', '', ''),
(12, 'jjh', 'krishna6maurya@gmail.com', '2554554843', '$2y$12$Bw4rrqrsC.OTCmWW0f6IuOZmc1C/OKFVeDHJy.8SJbi7NUgdCIQSm', '', '', '', '', '', '', '', 'india', '', '', '', '', '10', NULL, NULL, NULL, '', '', '', '0', NULL, 0.00, '2025-11-19 17:51:54', '2025-11-19 17:51:54', '', '', '', ''),
(13, 'hhh', 'ggf@gmail.com', '5248656598', '$2y$12$q2mNQb91ncbLBgNPQ2zsk.81vlZXrLz7dLnfNUdnEVIaX6ucZuNye', '', '', '', '', '', '', '', 'india', '', '', '', '', '10', NULL, NULL, NULL, '', '', '', '0', NULL, 0.00, '2025-11-19 17:55:45', '2025-11-19 17:55:45', '', '', '', ''),
(14, 'hhh', 'ggf@gmail.com', '5248656594', '$2y$12$KNajJvbQfmz9CfimHBkQSetrHwWwhE296dKLHiWaRxMZPEtBn/.6O', 'hhh', '', '3', '09AAACH7409R1ZZ', 'FRHPM4646J', '142566250548', '', 'india', 'Uttar Pradesh', 'Harhua', '221105', '', '12.5', '1763550180_shop_image_1000079265.jpg', '1763550180_aadhar_front_1000079255.jpg', '1763550180_aadhar_back_1000079252.jpg', '25.3855272', '82.9012687', 'Harahua, Harahua, , Harhua, Uttar Pradesh, 221105, India', '0', NULL, 0.00, '2025-11-19 18:03:00', '2025-11-19 18:03:00', '', '', '', ''),
(15, 'cc', 'gf@gnail.com', '6528272758', '$2y$12$5yavtkWsl1XQZ3roG3Aed.rMMxq6fIW9q7b7CBuJ1qZonP.ptBwRm', '', '', '', '', '', '', '', 'india', '', '', '', '', '3', NULL, NULL, NULL, '', '', '', '0', NULL, 0.00, '2025-11-19 18:07:22', '2025-11-19 18:07:22', '', '', '', ''),
(16, 'cc', 'gf@gnail.com', '6528272750', '$2y$12$AkPImuOkCE5tsVpn0zhzletWxIJ2y9vNJOcYHm887OPBjOPqbhhaG', '', '', '', '', '', '', '', 'india', '', '', '', '', '3', NULL, NULL, NULL, '', '', '', '0', NULL, 0.00, '2025-11-19 18:09:02', '2025-11-19 18:09:02', '', '', '', ''),
(17, 'cc', 'gf@gnail.com', '6528272754', '$2y$12$ga90ZarM/01gvmSRQE0htu7nmHUuQsmBtCAZkgwNRQNBOxvwLXhMK', 'hsdtts', '', '3', '09AAACH6857R1ZZ', 'FRHPM4574J', '568686767686', '', 'india', 'Uttar Pradesh', 'Harhua', '221105', '', '2.0', '1763550709_shop_image_1000079265.jpg', '1763550709_aadhar_front_1000079255.jpg', '1763550709_aadhar_back_1000079253.jpg', '25.385522', '82.9012829', 'Harahua, Harahua, , Harhua, Uttar Pradesh, 221105, India', '0', NULL, 0.00, '2025-11-19 18:10:03', '2025-11-19 18:11:49', '', '', '', ''),
(18, 'b', 'udfu@gmail.com', '8423376683', '$2y$12$Jts0Q7JDmJ.BdDd23Cnvs.CJ.Sy8M9UosWqBZYeMXCvf1eKV/8vqO', 'ncbcch', '', '3', '09AAACH7409R1ZZ', 'FRHPM5654J', '555353565676', '', 'india', 'Uttar Pradesh', 'Harhua', '221105', '', '3.0', '1763551120_shop_image_1000079265.jpg', '1763551120_aadhar_front_1000079253.jpg', '1763551120_aadhar_back_1000079265.jpg', '25.3855266', '82.9012252', 'Harahua, Harahua, , Harhua, Uttar Pradesh, 221105, India', '0', NULL, 0.00, '2025-11-19 18:17:06', '2025-11-19 18:18:40', '', '', '', ''),
(19, 'b b', 'chf@gmail.com', '3835353535', '$2y$12$sdHioHtYsUes8r2kSwvspu/LaIR8JgfU03JPQkH9SVW1oLK4dE63S', 'xff', NULL, '4', '09AAACH7409R1ZZ', 'FRHPM6875J', '555455882587', NULL, 'india', 'Uttar Pradesh', 'Harhua', '221105', NULL, '3.0', '3d-apple-illustration.jpg', 'arrangement-black-friday-shopping-carts-with-copy-space.jpg', 'arrangement-black-friday-shopping-carts-with-copy-space.jpg', '25.3855251', '82.9012846', 'Harahua, Harahua, , Harhua, Uttar Pradesh, 221105, India', '1', '1', 0.00, '2025-11-19 18:20:14', '2025-11-23 05:07:20', 'cUGjFExKRnufchASyYVyhl:APA91bFUHmmcB4N-qb8_GIq2hAdXt8QuWj0pE5JJcNJfG6QVF6B1dVLh-1zVrg5asl4EpE5v9jCAZzWgcWk9ARResBbUXvl-ivp1GpyUppEHRR50WhhCpTc', NULL, 'arrangement-black-friday-shopping-carts-with-copy-space.jpg', 'arrangement-black-friday-shopping-carts-with-copy-space.jpg'),
(20, 'Shnaker', 'hudbu@gmail.com', '6396063423', '$2y$12$iRz1ZQ/LhCUEplubIexhRuIdJMrMHJosOOUQF45Ax0/pfO8/..HIm', 'Rajat All In One Shop', '1', 'Retails', 'jhf7y48904u', 'GDUS838G', NULL, 'Tedipuliya', 'India', 'Uttar Pradesh', 'Banarsh', '226016', 'Near Vishwnath temple', '20', NULL, NULL, NULL, '25.3108532', '83.0106783', 'Shri Kashi Vishwanath Temple', '1', NULL, 0.00, '2025-11-21 12:36:21', '2025-11-23 05:08:30', '', '20', '', ''),
(21, 'kbhj', '8423485666', '3666025559', '$2y$12$dFpzh0885NZMTtEIUtgK4ePKr6Ksy7vv8f05wZ0syIFgM1APXRfC2', 'ghh', NULL, '4', '27ABCDE1234F2Z5', 'FRHPM5764J', '228454585558', NULL, 'india', 'Uttar Pradesh', 'Jamindarsan', '221302', '', '3.0', '1763748071_shop_image_1000079265.jpg', '1763748071_aadhar_front_1000079255.jpg', '1763748071_aadhar_back_1000079255.jpg', '25.2891267', '82.8787733', '7VQH+M82, 7VQH+M82, , Jamindarsan, Uttar Pradesh, 221302, India', '1', NULL, 0.00, '2025-11-22 01:01:11', '2025-11-23 05:08:43', 'cUGjFExKRnufchASyYVyhl:APA91bFUHmmcB4N-qb8_GIq2hAdXt8QuWj0pE5JJcNJfG6QVF6B1dVLh-1zVrg5asl4EpE5v9jCAZzWgcWk9ARResBbUXvl-ivp1GpyUppEHRR50WhhCpTc', '', '', ''),
(22, 'sakshi Tiwari', 'dev.info@gmail.com', '9152616125', '$2y$12$LTxCHQDObu25GSDeH/gKPOr5jYy1iw9SgN7NwfBNdhMJnzJhocTUe', '', NULL, '', '', '', '', NULL, 'india', '', '', '', '', '10', NULL, NULL, NULL, '', '', '', '0', NULL, 0.00, '2025-11-22 19:32:22', '2025-11-22 19:37:09', 'c1OSlHpEQGuQh6euDr_wY9:APA91bHnc8gZVTRMNaQiKhLclcmCeZ3mAXzzM6DeYijliUTfRlU5L5GIrlZIM9HDbOTMSNNpHPw9rpyKNkT8BiHJ33MCC2p_zOyTFGpg7FHuA13vUDp82J8', '', '', ''),
(23, 'sakshi Tiwari', 'dev.info@gmail.com', '6355452285', '$2y$12$HRpe8PGKG3eEJduWHGCCcuocuOLj9lnE5r/9ioqM1n6JXw6mXFra2', 'kirana store', NULL, '4', '09ABCDE1234F1Z5', 'ABCDE1234F', '703890690633', NULL, 'india', 'Uttar Pradesh', 'Harhua', '221105', '', '35', NULL, NULL, NULL, '25.385525', '82.9012827', 'Harahua, Harahua, , Harhua, Uttar Pradesh, 221105, India', '0', NULL, 0.00, '2025-11-22 19:35:52', '2025-11-22 19:35:52', '', '', '', ''),
(24, 'sakshi Tiwari', 'dev.info@gmail.com', '9324626511', '$2y$12$vDfJ5p.1wduGseDYoSTi9uU21g5BucDToJMQStydLf1EEJnkg05DG', 'kirana store', NULL, '4', '09ABCDE1234F1Z5', 'ABCDE1234F', '703890690633', NULL, 'india', 'Uttar Pradesh', 'Harhua', '221105', '', '35', NULL, NULL, NULL, '25.385525', '82.9012827', 'Harahua, Harahua, , Harhua, Uttar Pradesh, 221105, India', '0', NULL, 0.00, '2025-11-22 19:36:35', '2025-11-22 22:39:51', 'c1OSlHpEQGuQh6euDr_wY9:APA91bHnc8gZVTRMNaQiKhLclcmCeZ3mAXzzM6DeYijliUTfRlU5L5GIrlZIM9HDbOTMSNNpHPw9rpyKNkT8BiHJ33MCC2p_zOyTFGpg7FHuA13vUDp82J8', '', '', ''),
(25, 'Test Vendor', 'test@vendor.com', '9876543210', NULL, 'Test Shop', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Test City', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1000.00, '2025-11-23 03:53:38', '2025-11-23 03:53:38', '', '', '', ''),
(26, 'Rajat Rajput', 'rajat837@gmail.com', '6396063416', '$2y$12$yBat3ZT06XyoT7XiXXkjqOKUCGQ.NAyRylub7DPGahZuxqV7IaE1y', 'Rajat All In One Shop', '3', 'Retails', 'kjbfisiudnkjnskj', 'hbkjfdnkjvnn', 'hbdskjnsdkj', 'WX88+RHF Bhuiyan mata mandir, Unity City Colony, Kalyanpur (West), Lucknow, Uttar Pradesh 226022', 'India', 'Uttar Pradesh', 'Lucknow', '226022', 'Munshi Puliya', '50', '3d-apple-illustration.jpg', '3d-apple-illustration.jpg', '3d-apple-illustration.jpg', '24.565562255', '84.5464311', 'OM Plaza Apartment Indra Nagar Munshi Puliya Lucknow Uttar Pradesh ', '1', '1', 0.00, '2025-11-23 04:14:41', '2025-11-23 05:13:56', NULL, '40', '3d-apple-illustration.jpg', '3d-apple-illustration.jpg'),
(27, 'Sanjay Kumar yadav', 'sanjay383@gmail.com', '6396063416', '$2y$12$omRp5dFcXYU.q4ECndrXUOp0hCl/6Je6IWbO0Ul/G2o81L.q5bU8q', 'Sanja All In One Shop', '2', 'Retails', '09AAACH7409R1ZZ', 'FRHPM6875J', '555455882587', 'WX88+RHF Bhuiyan mata mandir, Unity City Colony, Kalyanpur (West), Lucknow, Uttar Pradesh 226022', 'India', 'Uttar Pradesh', 'Lucknow', '226022', 'Munshi Puliya', '50', '3d-apple-illustration.jpg', 'arrangement-black-friday-shopping-carts-with-copy-space.jpg', 'arrangement-black-friday-shopping-carts-with-copy-space.jpg', '24.565562255', '82.9012846', 'Lucknow Munsi Puliya', '1', '1', 0.00, '2025-11-23 05:51:32', '2025-11-23 05:52:17', NULL, '50', 'arrangement-black-friday-shopping-carts-with-copy-space.jpg', 'arrangement-black-friday-shopping-carts-with-copy-space.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `vendor_add_products`
--

CREATE TABLE `vendor_add_products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `vendor_id` bigint(20) UNSIGNED NOT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `cat_type_id` int(11) NOT NULL,
  `category` varchar(255) DEFAULT NULL,
  `subcategory` varchar(255) DEFAULT NULL,
  `low_category` varchar(255) DEFAULT NULL,
  `brand` varchar(255) DEFAULT NULL,
  `product_label` varchar(255) DEFAULT NULL,
  `quantity` varchar(255) DEFAULT NULL,
  `volume` varchar(255) DEFAULT NULL,
  `mrp` varchar(255) DEFAULT NULL,
  `selling_price` varchar(255) DEFAULT NULL,
  `gst` varchar(255) DEFAULT NULL,
  `total_amt` double NOT NULL,
  `product_description` text DEFAULT NULL,
  `product_images` varchar(255) DEFAULT NULL,
  `add_info_title` varchar(255) DEFAULT NULL,
  `add_info_desc` text DEFAULT NULL,
  `stock_status` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `vendor_add_products`
--

INSERT INTO `vendor_add_products` (`id`, `vendor_id`, `product_name`, `cat_type_id`, `category`, `subcategory`, `low_category`, `brand`, `product_label`, `quantity`, `volume`, `mrp`, `selling_price`, `gst`, `total_amt`, `product_description`, `product_images`, `add_info_title`, `add_info_desc`, `stock_status`, `description`, `created_at`, `updated_at`) VALUES
(1, 1, 'Buffallo Butter Milk', 1, '11', '4', '0', 'UdyaBharat', 'Apple', '1', 'kg', '64', '45', '5', 0, 'This product is soled by the Udhat Bharat Application this is is kashmieri Aplle', '1761802187_apple-1302430_1280.jpg', 'This is a info tititle', 'THis is a infro Desc', '50', 'This is a info tititle', '2025-10-30 12:29:47', '2025-10-30 12:29:47'),
(22, 1, 'Buffallo Butter Milk', 0, '1', '1', '', 'UdyaBharat', 'Apple', '1', 'kg', '64', '45', '5', 0, 'This product is soled by the Udhat Bharat Application this is is kashmieri Aplle', '1761892227_bg-removed_(2).png', 'This is a info tititle', 'THis is a infro Desc', '50', 'This is a info tititle', '2025-10-31 13:29:25', '2025-11-08 11:43:11'),
(23, 1, 'Shimla mirch', 0, '11', '4', 'null', NULL, 'Inclusive of all taxes', '70', NULL, '180', '90', '18', 0, NULL, '1761899042_scaled_27992.jpg', NULL, NULL, NULL, NULL, '2025-10-31 15:24:03', '2025-10-31 15:24:03'),
(24, 4, 'Shimla mirch', 0, '11', '4', 'null', NULL, 'Inclusive of all taxes', '70', NULL, '12', '10', '18', 0, NULL, '1761899377_scaled_27805.jpg', NULL, NULL, NULL, NULL, '2025-10-31 15:29:37', '2025-10-31 15:29:37'),
(25, 2, 'Tomato', 0, '11', '4', 'null', NULL, 'Inclusive of all taxes', '70', NULL, '12', '10', '18', 0, NULL, '1761899394_scaled_27805.jpg', NULL, NULL, NULL, NULL, '2025-10-31 15:29:54', '2025-10-31 15:29:54'),
(26, 2, 'Onion', 0, '11', '4', 'null', NULL, 'Inclusive of all taxes', '70', 'kg', '12', '10', '18', 0, NULL, '1761899438_scaled_27999.jpg', NULL, NULL, NULL, NULL, '2025-10-31 15:30:38', '2025-10-31 15:30:38'),
(27, 2, 'Lemon 🍋', 1, '11', '2', 'null', NULL, 'Exclusive of all taxes', '70', 'pcs', '12', '10', '5', 0, NULL, '1763448387_scaled_1000079241.jpg', 'add info', 'this is the lemon juice 🥤', NULL, NULL, '2025-10-31 15:35:46', '2025-11-18 13:46:27'),
(28, 2, 'Anik Ghee', 0, '12', '4', 'null', NULL, 'Inclusive of all taxes', '70', NULL, '900', '750', '18', 0, NULL, '1761899797_scaled_27858.jpg', NULL, NULL, NULL, NULL, '2025-10-31 15:36:37', '2025-10-31 15:36:37'),
(29, 2, 'Patanjali', 0, '12', '4', 'null', NULL, 'Inclusive of all taxes', '70', NULL, '900', '750', '18', 0, NULL, '1761899914_scaled_27862.jpg', NULL, NULL, NULL, NULL, '2025-10-31 15:38:34', '2025-10-31 15:38:34'),
(30, 2, 'Amul ghee', 0, '12', '4', 'null', NULL, 'Inclusive of all taxes', '70', NULL, '900', '750', '18', 0, NULL, '1761900024_scaled_27856.jpg', NULL, NULL, NULL, NULL, '2025-10-31 15:40:24', '2025-10-31 15:40:24'),
(31, 2, 'Namaste india desi ghee', 0, '12', '4', 'null', NULL, 'Inclusive of all taxes', '70', NULL, '900', '750', '18', 0, NULL, '1761900070_scaled_27855.jpg', NULL, NULL, NULL, NULL, '2025-10-31 15:41:10', '2025-10-31 15:41:10'),
(32, 2, 'paras desi ghee', 0, '12', '4', 'null', NULL, 'Inclusive of all taxes', '70', NULL, '900', '750', '18', 0, NULL, '1761900104_scaled_27857.jpg', NULL, NULL, NULL, NULL, '2025-10-31 15:41:44', '2025-10-31 15:41:44'),
(33, 2, 'Monaco buiskit', 0, '13', '12', 'null', NULL, 'Inclusive of all taxes', '70', NULL, '12', '10', '18', 0, NULL, '1761900173_scaled_20212.jpg', NULL, NULL, '50', NULL, '2025-10-31 15:42:53', '2025-10-31 15:42:53'),
(34, 2, 'Crack zack', 0, '13', '12', 'null', NULL, 'Exclusive of all taxes', '70', NULL, '12', '10', '18', 0, NULL, '1761900193_scaled_20214.jpg', NULL, NULL, NULL, NULL, '2025-10-31 15:43:13', '2025-10-31 15:43:13'),
(35, 2, 'Moms magic', 0, '13', '12', 'null', NULL, 'Exclusive of all taxes', '70', NULL, '12', '10', '18', 0, NULL, '1761900229_scaled_20210.jpg', NULL, NULL, NULL, NULL, '2025-10-31 15:43:49', '2025-10-31 15:43:49'),
(36, 2, 'Goodday', 0, '13', '12', 'null', NULL, 'Exclusive of all taxes', '70', NULL, '12', '10', '18', 0, NULL, '1761900256_scaled_20218.jpg', NULL, NULL, NULL, NULL, '2025-10-31 15:44:16', '2025-10-31 15:44:16'),
(37, 2, 'Hide and seek', 0, '13', '12', 'null', NULL, 'Exclusive of all taxes', '70', NULL, '12', '10', '18', 0, NULL, '1761900305_scaled_20216.jpg', NULL, NULL, NULL, NULL, '2025-10-31 15:45:05', '2025-10-31 15:45:05'),
(38, 2, 'Hide and seek Parle', 0, '13', '12', 'null', NULL, 'Exclusive of all taxes', '70', NULL, '12', '10', '18', 0, NULL, '1761900335_scaled_20208.jpg', NULL, NULL, NULL, NULL, '2025-10-31 15:45:35', '2025-10-31 15:45:35'),
(39, 2, 'whole form rice', 0, '15', '21', 'null', NULL, 'Inclusive of all taxes', '70', NULL, '12', '10', '18', 0, NULL, '1761900432_scaled_27971.jpg', NULL, NULL, NULL, NULL, '2025-10-31 15:47:12', '2025-10-31 15:47:12'),
(40, 2, 'basmati rice', 0, '15', '21', 'null', NULL, 'Exclusive of all taxes', '70', NULL, '12', '10', '18', 0, NULL, '1761900465_scaled_27975.jpg', NULL, NULL, NULL, NULL, '2025-10-31 15:47:45', '2025-10-31 15:47:45'),
(41, 2, 'Nature land rice', 0, '15', '21', 'null', NULL, 'Inclusive of all taxes', '70', NULL, '12', '10', '18', 0, NULL, '1761900506_scaled_27958.jpg', NULL, NULL, NULL, NULL, '2025-10-31 15:48:26', '2025-10-31 15:48:26'),
(42, 2, 'Nature land rice', 0, '15', '22', 'null', NULL, 'Exclusive of all taxes', '70', NULL, '200', '180', '18', 0, '', '1761900555_scaled_27944.jpg', NULL, NULL, NULL, NULL, '2025-10-31 15:49:15', '2025-10-31 15:49:15'),
(43, 1, 'Buffallo Butter Milk', 1, '1', '1', '', '1', 'Tax Incluede', '1', 'kg', '500', '400', '2', 0, '', '1763386572_OIP_(20)_no_bg.png', 'Fresh Milk', 'This product is soled by the Udhat Bharat Application this is is Fresh Milk from the', '50', NULL, '2025-11-17 20:23:35', '2025-11-17 20:36:12'),
(45, 22, 'ORANGES', 1, '11', '1', NULL, NULL, 'Exclusive of all taxes', '1', 'Kg', '20', '15', '18', 0, NULL, '1763815375_scaled_1000314066.jpg', 'vegetable', 'fresh vegetables (organic)', '10', NULL, '2025-11-22 19:41:53', '2025-11-22 19:42:55'),
(46, 24, 'paneer', 1, '23', '63', NULL, NULL, 'Inclusive of all taxes', '6', 'Kg', '50', '48', '18', 0, NULL, '1763826251_scaled_1000314090.jpg', 'Fresh', 'Make delicious food 🥑', '10', NULL, '2025-11-22 22:44:11', '2025-11-22 22:44:11'),
(47, 27, 'Amul Milk', 1, '12', '6', NULL, '1', 'This is testing product level', '1', 'liter', '45', '35', '15.00', 40.25, 'This is product decsription', '01KAV4GC01EJYY1AMZDPVANTAT.jpg', 'Apout Amul Milk', 'This is a milk of amul brand give the each and every necceary potirens and vitamines', '50', 'this is description', '2025-11-24 08:41:55', '2025-11-24 09:02:55'),
(48, 27, 'Amul Butter', 1, '12', '8', NULL, '1', 'This is testing product level', '100', 'gram 1 peace', '25', '22', '15', 25.3, NULL, '01KAVDPQE1J3F2RZT2RQRHFZ2C.jpg', 'All tax included', 'Amull Butter Description', '100', NULL, '2025-11-24 11:43:41', '2025-11-24 11:43:41');

-- --------------------------------------------------------

--
-- Table structure for table `vendor_business_types`
--

CREATE TABLE `vendor_business_types` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `business_type_name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `vendor_business_types`
--

INSERT INTO `vendor_business_types` (`id`, `business_type_name`, `description`, `created_at`, `updated_at`) VALUES
(1, 'Grocery & Essentials', 'Online retail of daily essentials like groceries, vegetables, and personal care items.', '2025-10-30 04:59:19', '2025-10-30 04:59:19'),
(2, 'Fashion & Apparel', 'Selling clothing, footwear, and fashion accessories for men, women, and kids.', '2025-10-30 04:59:19', '2025-10-30 04:59:19'),
(3, 'Electronics & Gadgets', 'Retail of smartphones, accessories, and consumer electronics.', '2025-10-30 04:59:19', '2025-10-30 04:59:19'),
(4, 'Home & Kitchen', 'Products for home improvement, kitchenware, and décor.', '2025-10-30 04:59:19', '2025-10-30 04:59:19'),
(5, 'Beauty & Personal Care', 'Cosmetics, grooming, and skincare products for all genders.', '2025-10-30 04:59:19', '2025-10-30 04:59:19'),
(6, 'Health & Wellness', 'Pharmacy, supplements, and fitness-related products.', '2025-10-30 04:59:19', '2025-10-30 04:59:19'),
(7, 'Baby & Kids', 'Products for infants and kids including food, toys, and clothing.', '2025-10-30 04:59:19', '2025-10-30 04:59:19'),
(8, 'Pet Supplies', 'Pet food, toys, accessories, and grooming items.', '2025-10-30 04:59:19', '2025-10-30 04:59:19'),
(9, 'Stationery & Office', 'Office supplies, books, and school stationery.', '2025-10-30 04:59:19', '2025-10-30 04:59:19'),
(10, 'Sports & Outdoor', 'Sports gear, fitness accessories, and outdoor equipment.', '2025-10-30 04:59:19', '2025-10-30 04:59:19');

-- --------------------------------------------------------

--
-- Table structure for table `vendor_categories`
--

CREATE TABLE `vendor_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `category_name` varchar(255) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `category_image` text NOT NULL,
  `cat_type_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `vendor_categories`
--

INSERT INTO `vendor_categories` (`id`, `category_name`, `description`, `created_at`, `updated_at`, `category_image`, `cat_type_id`) VALUES
(11, 'Fruits & Vegetables', 'Fresh fruits, leafy greens, and daily vegetables for your kitchen.', '2025-10-29 04:45:13', '2025-10-29 04:45:13', '', 1),
(12, 'Dairy & Bakery', 'Milk, curd, cheese, butter, bread, and other bakery essentials.', '2025-10-29 04:45:13', '2025-11-24 11:49:13', 'arrangement-black-friday-shopping-carts-with-copy-space.jpg', 1),
(13, 'Snacks & Munchies', 'Chips, biscuits, namkeen, chocolates, and other quick bites.', '2025-10-29 04:45:13', '2025-10-29 04:45:13', '', 1),
(14, 'Beverages', 'Soft drinks, juices, tea, coffee, and energy drinks.', '2025-10-29 04:45:13', '2025-10-29 04:45:13', '', 1),
(15, 'Staples & Grocery', 'Daily essentials like rice, pulses, atta, sugar, and cooking oils.', '2025-10-29 04:45:13', '2025-10-29 04:45:13', '', 1),
(16, 'Personal Care', 'Shampoo, soap, toothpaste, deodorant, and hygiene products.', '2025-10-29 04:45:13', '2025-10-29 04:45:13', '', 1),
(17, 'Household Essentials', 'Cleaning supplies, detergents, and home care products.', '2025-10-29 04:45:13', '2025-10-29 04:45:13', '', 1),
(18, 'Baby Care', 'Diapers, baby wipes, baby food, and personal care items for infants.', '2025-10-29 04:45:13', '2025-10-29 04:45:13', '', 1),
(19, 'Meat & Seafood', 'Fresh chicken, fish, eggs, and seafood products.', '2025-10-29 04:45:13', '2025-10-29 04:45:13', '', 1),
(20, 'Pet Care', 'Pet food, grooming supplies, and accessories for dogs and cats.', '2025-10-29 04:45:13', '2025-10-29 04:45:13', '', 1),
(21, 'Breakfast & Cereals', 'Cornflakes, oats, muesli, honey, and spreads.', '2025-10-29 04:45:13', '2025-10-29 04:45:13', '', 1),
(22, 'Instant Food & Noodles', 'Ready-to-cook meals, noodles, and pasta.', '2025-10-29 04:45:13', '2025-10-29 04:45:13', '', 1),
(23, 'Masala & Spices', 'Salt, masala powders, and whole spices for cooking.', '2025-10-29 04:45:13', '2025-10-29 04:45:13', '', 1),
(24, 'Dry Fruits & Nuts', 'Cashews, almonds, raisins, and other healthy snacks.', '2025-10-29 04:45:13', '2025-10-29 04:45:13', '', 1),
(25, 'Health & Nutrition', 'Protein powders, supplements, and health drinks.', '2025-10-29 04:45:13', '2025-10-29 04:45:13', '', 1),
(26, 'Frozen Foods', 'Frozen snacks, peas, parathas, and ice creams.', '2025-10-29 04:45:13', '2025-10-29 04:45:13', '', 1),
(27, 'Cleaning & Laundry', 'Laundry detergent, dishwash, and home cleaners.', '2025-10-29 04:45:13', '2025-10-29 04:45:13', '', 1),
(28, 'Stationery & Office Supplies', 'Pens, notebooks, and daily office essentials.', '2025-10-29 04:45:13', '2025-10-29 04:45:13', '', 1),
(29, 'Beauty & Grooming', 'Makeup, skincare, haircare, and grooming items.', '2025-10-29 04:45:13', '2025-10-29 04:45:13', '', 1),
(30, 'Electronics & Accessories', 'Batteries, cables, chargers, and small electronic items.', '2025-10-29 04:45:13', '2025-10-29 04:45:13', '', 1),
(31, 'Testing category 1', 'This is testing category ', '2025-11-23 10:59:03', '2025-11-23 11:28:34', 'arrangement-black-friday-shopping-carts-with-copy-space.jpg', 2),
(33, 'Testing categor', 'this is a testin categories', '2025-11-23 11:05:41', '2025-11-23 11:30:15', 'arrangement-black-friday-shopping-carts-with-copy-space.jpg', 2),
(34, 'Testing categor iurpi', 'this is second category', '2025-11-23 11:17:16', '2025-11-23 11:17:16', '01KARSSNEZAAKVH2GRQ77CER41.jpg', 2),
(35, 'Testing categoryu3y98', 'This is valid testing categories\n', '2025-11-23 11:19:30', '2025-11-23 11:19:30', '01KARSXQMKMR2EWZHQEJTSSD8B.jpg', 2),
(36, 'Testing categorykjnkjnjn', 'kbibhkkjnjn', '2025-11-23 11:31:06', '2025-11-23 11:31:06', 'arrangement-black-friday-shopping-carts-with-copy-space.jpg', 2),
(37, 'Testing category 1bkbbkkjn', 'hbhbhbjhbhbhjb', '2025-11-23 11:37:03', '2025-11-23 11:37:03', 'arrangement-black-friday-shopping-carts-with-copy-space.jpg', 2),
(38, 'htftyfgyhv', 'b b bv bv ', '2025-11-23 11:40:38', '2025-11-23 11:40:38', '3d-apple-illustration.jpg', 2),
(39, 'raiatr', 'mnmn n ', '2025-11-23 11:42:09', '2025-11-23 11:42:09', '3d-apple-illustration.jpg', 2),
(40, 'rsajan', 'hjbjhbjhbjhb', '2025-11-23 11:45:24', '2025-11-23 11:45:24', '3d-apple-illustration.jpg', 2);

-- --------------------------------------------------------

--
-- Table structure for table `vendor_wallet_transactions`
--

CREATE TABLE `vendor_wallet_transactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `vendor_id` bigint(20) UNSIGNED NOT NULL,
  `amt` decimal(10,2) NOT NULL,
  `operation_type` enum('credit','debit') NOT NULL,
  `remark` text DEFAULT NULL,
  `status` enum('pending','completed','failed') NOT NULL DEFAULT 'pending',
  `is_send_to_admin` tinyint(1) NOT NULL DEFAULT 0,
  `is_send_to_vendor` tinyint(1) NOT NULL DEFAULT 0,
  `added_date_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `booking_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `verify_otps`
--

CREATE TABLE `verify_otps` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `login_id` bigint(20) UNSIGNED NOT NULL,
  `mobile_no` varchar(255) NOT NULL,
  `otp` varchar(255) NOT NULL,
  `is_verified` tinyint(1) NOT NULL DEFAULT 0,
  `attempts` int(11) NOT NULL DEFAULT 0,
  `is_used` tinyint(1) NOT NULL DEFAULT 0,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `verify_otps`
--

INSERT INTO `verify_otps` (`id`, `login_id`, `mobile_no`, `otp`, `is_verified`, `attempts`, `is_used`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 1, '8423485660', '215259', 0, 0, 0, '2025-10-29 18:11:05', '2025-10-29 18:06:05', '2025-10-29 18:06:05'),
(2, 1, '8423485660', '329879', 0, 0, 0, '2025-10-29 18:12:13', '2025-10-29 18:07:13', '2025-10-29 18:07:13'),
(3, 1, '8423485660', '375196', 0, 0, 1, '2025-10-29 18:12:46', '2025-10-29 18:07:46', '2025-10-29 18:07:54'),
(4, 1, '8423485660', '129386', 0, 0, 1, '2025-10-30 14:03:30', '2025-10-30 13:58:30', '2025-10-30 13:58:40'),
(5, 1, '8423485660', '121958', 0, 0, 1, '2025-10-30 15:46:02', '2025-10-30 15:41:02', '2025-10-30 15:41:10'),
(6, 1, '8423485660', '295345', 0, 0, 0, '2025-10-30 16:25:39', '2025-10-30 16:20:39', '2025-10-30 16:20:39'),
(7, 1, '8423485660', '416959', 0, 1, 0, '2025-10-30 16:25:48', '2025-10-30 16:20:48', '2025-10-30 16:20:57'),
(8, 1, '8423485660', '513294', 0, 0, 1, '2025-10-30 16:26:01', '2025-10-30 16:21:01', '2025-10-30 16:21:09'),
(9, 1, '8423485660', '423719', 0, 0, 1, '2025-10-30 20:56:03', '2025-10-30 20:51:03', '2025-10-30 20:51:11'),
(10, 1, '8423485660', '961034', 0, 0, 1, '2025-10-31 12:48:54', '2025-10-31 12:43:54', '2025-10-31 12:44:02'),
(11, 1, '8423485660', '788039', 0, 0, 1, '2025-10-31 13:09:23', '2025-10-31 13:04:23', '2025-10-31 13:04:32'),
(12, 1, '8423485660', '255698', 0, 0, 0, '2025-10-31 14:45:24', '2025-10-31 14:40:24', '2025-10-31 14:40:24'),
(13, 1, '8423485660', '496031', 0, 0, 1, '2025-10-31 14:45:31', '2025-10-31 14:40:31', '2025-10-31 14:40:38'),
(14, 1, '8423485660', '437195', 0, 0, 1, '2025-10-31 15:36:21', '2025-10-31 15:31:21', '2025-10-31 15:31:29'),
(15, 2, '9152616125', '521812', 0, 0, 1, '2025-10-31 16:32:19', '2025-10-31 16:27:19', '2025-10-31 16:27:28'),
(16, 1, '8423485660', '331958', 0, 0, 0, '2025-10-31 16:32:28', '2025-10-31 16:27:28', '2025-10-31 16:27:28'),
(17, 1, '8423485660', '793493', 0, 0, 1, '2025-10-31 16:32:42', '2025-10-31 16:27:42', '2025-10-31 16:27:52'),
(18, 1, '8423485660', '594389', 0, 0, 0, '2025-10-31 19:17:11', '2025-10-31 19:12:11', '2025-10-31 19:12:11'),
(19, 1, '8423485660', '267050', 0, 0, 1, '2025-10-31 19:17:19', '2025-10-31 19:12:19', '2025-10-31 19:12:27'),
(20, 1, '8423485660', '981823', 0, 1, 0, '2025-10-31 19:19:16', '2025-10-31 19:14:16', '2025-10-31 19:14:24'),
(21, 1, '8423485660', '573333', 0, 0, 1, '2025-10-31 19:19:30', '2025-10-31 19:14:30', '2025-10-31 19:14:40'),
(22, 1, '8423485660', '384281', 0, 0, 0, '2025-10-31 19:51:56', '2025-10-31 19:46:56', '2025-10-31 19:46:56'),
(23, 1, '8423485660', '323625', 0, 1, 0, '2025-10-31 19:52:15', '2025-10-31 19:47:15', '2025-10-31 19:47:25'),
(24, 1, '8423485660', '546562', 0, 0, 1, '2025-11-01 01:16:28', '2025-11-01 01:11:28', '2025-11-01 01:11:37'),
(25, 3, '7011993705', '712838', 0, 0, 0, '2025-11-01 01:24:09', '2025-11-01 01:19:09', '2025-11-01 01:19:09'),
(26, 3, '7011993705', '663625', 0, 0, 0, '2025-11-01 01:24:43', '2025-11-01 01:19:43', '2025-11-01 01:19:43'),
(29, 3, '7011993705', '600036', 0, 0, 1, '2025-11-01 01:37:45', '2025-11-01 01:32:45', '2025-11-01 01:32:53'),
(30, 1, '8423485660', '227724', 0, 0, 0, '2025-11-01 01:38:17', '2025-11-01 01:33:17', '2025-11-01 01:33:17'),
(31, 1, '8423485660', '319336', 0, 0, 1, '2025-11-01 12:20:56', '2025-11-01 12:15:56', '2025-11-01 12:16:05'),
(32, 1, '8423485660', '832310', 0, 0, 0, '2025-11-02 17:37:17', '2025-11-02 17:32:17', '2025-11-02 17:32:17'),
(33, 1, '8423485660', '230634', 0, 0, 0, '2025-11-02 17:38:33', '2025-11-02 17:33:33', '2025-11-02 17:33:33'),
(34, 1, '8423485660', '223588', 0, 0, 0, '2025-11-03 13:01:09', '2025-11-03 12:56:09', '2025-11-03 12:56:09'),
(35, 1, '8423485660', '640957', 0, 0, 1, '2025-11-03 13:02:59', '2025-11-03 12:57:59', '2025-11-03 12:58:09'),
(36, 1, '8423485660', '666758', 0, 0, 0, '2025-11-04 23:21:03', '2025-11-04 23:16:03', '2025-11-04 23:16:03'),
(37, 1, '8423485660', '344411', 0, 1, 0, '2025-11-04 23:21:11', '2025-11-04 23:16:11', '2025-11-04 23:16:21'),
(38, 1, '8423485660', '316732', 0, 0, 1, '2025-11-04 23:21:25', '2025-11-04 23:16:25', '2025-11-04 23:16:34'),
(39, 1, '8423485660', '613311', 0, 0, 1, '2025-11-05 01:06:29', '2025-11-05 01:01:29', '2025-11-05 01:01:37'),
(40, 3, '7011993705', '810683', 0, 0, 0, '2025-11-05 17:04:15', '2025-11-05 16:59:15', '2025-11-05 16:59:15'),
(41, 3, '7011993705', '316032', 0, 1, 0, '2025-11-05 17:04:56', '2025-11-05 16:59:56', '2025-11-05 17:00:35'),
(42, 3, '7011993705', '154481', 0, 0, 0, '2025-11-05 17:05:44', '2025-11-05 17:00:44', '2025-11-05 17:00:44'),
(43, 3, '7011993705', '909513', 0, 0, 1, '2025-11-05 17:05:52', '2025-11-05 17:00:52', '2025-11-05 17:01:02'),
(44, 1, '8423485660', '349629', 0, 0, 0, '2025-11-06 14:06:26', '2025-11-06 14:01:26', '2025-11-06 14:01:26'),
(45, 1, '8423485660', '613414', 0, 0, 1, '2025-11-06 14:06:35', '2025-11-06 14:01:35', '2025-11-06 14:01:44'),
(46, 1, '8423485660', '979244', 0, 0, 0, '2025-11-06 22:39:48', '2025-11-06 22:34:48', '2025-11-06 22:34:48'),
(47, 1, '8423485660', '206315', 0, 0, 0, '2025-11-07 03:03:50', '2025-11-07 02:58:50', '2025-11-07 02:58:50'),
(48, 1, '8423485660', '243865', 0, 0, 1, '2025-11-07 12:05:56', '2025-11-07 12:00:56', '2025-11-07 12:01:04'),
(49, 1, '8423485660', '212737', 0, 0, 1, '2025-11-07 16:42:48', '2025-11-07 16:37:48', '2025-11-07 16:38:11'),
(50, 1, '8423485660', '495603', 0, 0, 1, '2025-11-10 15:44:46', '2025-11-10 15:39:46', '2025-11-10 15:39:55'),
(51, 1, '8423485660', '812246', 0, 0, 1, '2025-11-12 01:24:03', '2025-11-12 01:19:03', '2025-11-12 01:19:11'),
(52, 1, '8423485660', '558137', 0, 0, 0, '2025-11-13 05:17:11', '2025-11-13 05:12:11', '2025-11-13 05:12:11'),
(53, 1, '8423485660', '919610', 0, 0, 0, '2025-11-13 05:18:05', '2025-11-13 05:13:05', '2025-11-13 05:13:05'),
(54, 1, '8423485660', '823809', 0, 0, 0, '2025-11-13 09:58:00', '2025-11-13 09:53:00', '2025-11-13 09:53:00'),
(55, 1, '8423485660', '186947', 0, 1, 0, '2025-11-13 09:58:06', '2025-11-13 09:53:06', '2025-11-13 09:53:15'),
(56, 1, '8423485660', '830136', 0, 0, 1, '2025-11-13 09:58:19', '2025-11-13 09:53:19', '2025-11-13 09:53:29'),
(57, 1, '8423485660', '174549', 0, 0, 0, '2025-11-13 10:18:46', '2025-11-13 10:13:46', '2025-11-13 10:13:46'),
(58, 3, '7011993705', '393752', 0, 0, 1, '2025-11-13 11:02:16', '2025-11-13 10:57:16', '2025-11-13 10:57:24'),
(59, 1, '8423485660', '835587', 0, 0, 1, '2025-11-13 12:21:18', '2025-11-13 12:16:18', '2025-11-13 12:16:25'),
(60, 2, '9152616125', '350846', 0, 0, 0, '2025-11-13 12:35:51', '2025-11-13 12:30:51', '2025-11-13 12:30:51'),
(61, 2, '9152616125', '129283', 0, 0, 1, '2025-11-13 12:35:59', '2025-11-13 12:30:59', '2025-11-13 12:31:10'),
(62, 2, '9152616125', '524379', 0, 0, 0, '2025-11-13 12:36:51', '2025-11-13 12:31:51', '2025-11-13 12:31:51'),
(63, 2, '9152616125', '755420', 0, 0, 0, '2025-11-13 12:37:12', '2025-11-13 12:32:12', '2025-11-13 12:32:12'),
(64, 2, '9152616125', '972833', 0, 0, 1, '2025-11-13 12:37:24', '2025-11-13 12:32:24', '2025-11-13 12:32:33'),
(65, 1, '8423485660', '427422', 0, 1, 0, '2025-11-13 13:00:19', '2025-11-13 12:55:19', '2025-11-13 12:55:27'),
(66, 1, '8423485660', '652424', 0, 0, 1, '2025-11-13 13:00:35', '2025-11-13 12:55:35', '2025-11-13 12:55:43'),
(67, 1, '8423485660', '294621', 0, 0, 0, '2025-11-13 16:49:52', '2025-11-13 16:44:52', '2025-11-13 16:44:52'),
(68, 1, '8423485660', '761733', 0, 0, 0, '2025-11-13 16:53:17', '2025-11-13 16:48:17', '2025-11-13 16:48:17'),
(69, 1, '8423485660', '572545', 0, 0, 1, '2025-11-13 16:53:59', '2025-11-13 16:48:59', '2025-11-13 16:49:06'),
(70, 2, '9152616125', '563648', 0, 0, 0, '2025-11-13 17:06:08', '2025-11-13 17:01:08', '2025-11-13 17:01:08'),
(71, 2, '9152616125', '526721', 0, 0, 0, '2025-11-13 17:06:36', '2025-11-13 17:01:36', '2025-11-13 17:01:36'),
(72, 2, '9152616125', '920988', 0, 0, 0, '2025-11-13 17:10:26', '2025-11-13 17:05:26', '2025-11-13 17:05:26'),
(73, 2, '9152616125', '381437', 0, 1, 0, '2025-11-13 17:27:09', '2025-11-13 17:22:09', '2025-11-13 17:24:33'),
(74, 2, '9152616125', '943035', 0, 1, 0, '2025-11-13 17:29:33', '2025-11-13 17:24:33', '2025-11-13 17:25:50'),
(75, 2, '9152616125', '700608', 0, 0, 0, '2025-11-13 17:30:50', '2025-11-13 17:25:50', '2025-11-13 17:25:50'),
(76, 2, '9152616125', '413171', 0, 0, 0, '2025-11-13 17:31:46', '2025-11-13 17:26:46', '2025-11-13 17:26:46'),
(77, 2, '9152616125', '450641', 0, 0, 0, '2025-11-13 17:46:22', '2025-11-13 17:41:22', '2025-11-13 17:41:22'),
(78, 2, '9152616125', '385911', 0, 0, 0, '2025-11-13 17:54:50', '2025-11-13 17:49:50', '2025-11-13 17:49:50'),
(79, 2, '9152616125', '199590', 0, 0, 0, '2025-11-13 17:59:15', '2025-11-13 17:54:15', '2025-11-13 17:54:15'),
(80, 2, '9152616125', '134741', 0, 0, 0, '2025-11-13 18:01:27', '2025-11-13 17:56:27', '2025-11-13 17:56:27'),
(81, 2, '9152616125', '875561', 0, 0, 0, '2025-11-13 18:05:17', '2025-11-13 18:00:17', '2025-11-13 18:00:17'),
(82, 2, '9152616125', '121756', 0, 0, 0, '2025-11-13 18:05:34', '2025-11-13 18:00:34', '2025-11-13 18:00:34'),
(83, 2, '9152616125', '938465', 0, 0, 0, '2025-11-13 18:06:01', '2025-11-13 18:01:01', '2025-11-13 18:01:01'),
(84, 2, '9152616125', '338320', 0, 1, 0, '2025-11-13 18:08:09', '2025-11-13 18:03:09', '2025-11-13 18:05:11'),
(85, 2, '9152616125', '869795', 0, 1, 0, '2025-11-13 18:10:11', '2025-11-13 18:05:11', '2025-11-13 18:05:37'),
(86, 2, '9152616125', '126539', 0, 0, 0, '2025-11-13 18:10:37', '2025-11-13 18:05:37', '2025-11-13 18:05:37'),
(87, 2, '9152616125', '417373', 0, 0, 0, '2025-11-13 18:13:57', '2025-11-13 18:08:57', '2025-11-13 18:08:57'),
(88, 2, '9152616125', '415706', 0, 0, 0, '2025-11-13 18:16:22', '2025-11-13 18:11:22', '2025-11-13 18:11:22'),
(89, 2, '9152616125', '861251', 0, 0, 0, '2025-11-13 18:17:43', '2025-11-13 18:12:43', '2025-11-13 18:12:43'),
(90, 2, '9152616125', '380000', 0, 0, 0, '2025-11-13 18:22:33', '2025-11-13 18:17:33', '2025-11-13 18:17:33'),
(91, 2, '9152616125', '935536', 0, 0, 0, '2025-11-13 18:22:49', '2025-11-13 18:17:49', '2025-11-13 18:17:49'),
(92, 2, '9152616125', '351768', 0, 0, 0, '2025-11-13 18:41:11', '2025-11-13 18:36:11', '2025-11-13 18:36:11'),
(93, 2, '9152616125', '626176', 0, 0, 0, '2025-11-13 18:41:52', '2025-11-13 18:36:52', '2025-11-13 18:36:52'),
(94, 2, '9152616125', '667866', 0, 0, 0, '2025-11-13 19:11:48', '2025-11-13 19:06:48', '2025-11-13 19:06:48'),
(95, 2, '9152616125', '630400', 0, 0, 0, '2025-11-13 19:20:08', '2025-11-13 19:15:08', '2025-11-13 19:15:08'),
(96, 2, '9152616125', '437784', 0, 0, 0, '2025-11-13 19:20:19', '2025-11-13 19:15:19', '2025-11-13 19:15:19'),
(97, 2, '9152616125', '221727', 0, 0, 0, '2025-11-13 19:21:57', '2025-11-13 19:16:57', '2025-11-13 19:16:57'),
(98, 2, '9152616125', '195133', 0, 0, 0, '2025-11-13 19:22:52', '2025-11-13 19:17:52', '2025-11-13 19:17:52'),
(99, 2, '9152616125', '506667', 0, 0, 0, '2025-11-13 19:25:19', '2025-11-13 19:20:19', '2025-11-13 19:20:19'),
(100, 2, '9152616125', '815194', 0, 0, 0, '2025-11-13 19:43:59', '2025-11-13 19:38:59', '2025-11-13 19:38:59'),
(101, 1, '8423485660', '103119', 0, 0, 1, '2025-11-13 23:33:38', '2025-11-13 23:28:38', '2025-11-13 23:28:47'),
(102, 1, '8423485660', '573606', 0, 0, 1, '2025-11-14 01:25:28', '2025-11-14 01:20:28', '2025-11-14 01:20:38'),
(103, 2, '9152616125', '528479', 0, 0, 0, '2025-11-14 08:47:25', '2025-11-14 08:42:25', '2025-11-14 08:42:25'),
(104, 2, '9152616125', '530588', 0, 0, 0, '2025-11-14 08:54:47', '2025-11-14 08:49:47', '2025-11-14 08:49:47'),
(105, 2, '9152616125', '923847', 0, 0, 0, '2025-11-14 09:02:14', '2025-11-14 08:57:14', '2025-11-14 08:57:14'),
(106, 2, '9152616125', '309975', 0, 0, 0, '2025-11-14 09:08:27', '2025-11-14 09:03:27', '2025-11-14 09:03:27'),
(107, 2, '9152616125', '652595', 0, 0, 0, '2025-11-14 09:09:14', '2025-11-14 09:04:14', '2025-11-14 09:04:14'),
(108, 2, '9152616125', '893832', 0, 1, 0, '2025-11-14 09:09:54', '2025-11-14 09:04:54', '2025-11-14 09:05:41'),
(109, 2, '9152616125', '938592', 0, 1, 0, '2025-11-14 09:11:14', '2025-11-14 09:06:14', '2025-11-14 09:06:50'),
(110, 2, '9152616125', '468072', 0, 0, 0, '2025-11-14 11:54:34', '2025-11-14 11:49:34', '2025-11-14 11:49:34'),
(111, 2, '9152616125', '668698', 0, 0, 0, '2025-11-14 11:58:31', '2025-11-14 11:53:31', '2025-11-14 11:53:31'),
(112, 2, '9152616125', '590733', 0, 0, 0, '2025-11-14 12:03:16', '2025-11-14 11:58:16', '2025-11-14 11:58:16'),
(113, 2, '9152616125', '128983', 0, 0, 1, '2025-11-14 12:19:58', '2025-11-14 12:14:58', '2025-11-14 12:15:26'),
(114, 2, '9152616125', '372326', 0, 0, 1, '2025-11-14 12:29:43', '2025-11-14 12:24:43', '2025-11-14 12:25:01'),
(115, 2, '9152616125', '738388', 0, 0, 1, '2025-11-14 12:32:12', '2025-11-14 12:27:12', '2025-11-14 12:27:31'),
(116, 2, '9152616125', '828273', 0, 0, 1, '2025-11-14 12:35:21', '2025-11-14 12:30:21', '2025-11-14 12:30:35'),
(117, 2, '9152616125', '215767', 0, 1, 1, '2025-11-14 12:37:13', '2025-11-14 12:32:13', '2025-11-14 12:32:51'),
(118, 2, '9152616125', '768590', 0, 0, 0, '2025-11-14 12:37:13', '2025-11-14 12:32:13', '2025-11-14 12:32:13'),
(119, 2, '9152616125', '215550', 0, 1, 0, '2025-11-14 13:02:36', '2025-11-14 12:57:36', '2025-11-14 12:57:42'),
(120, 2, '9152616125', '769841', 0, 0, 0, '2025-11-14 13:02:36', '2025-11-14 12:57:36', '2025-11-14 12:57:36'),
(121, 2, '9152616125', '439256', 0, 0, 0, '2025-11-14 13:02:36', '2025-11-14 12:57:36', '2025-11-14 12:57:36'),
(122, 2, '9152616125', '827286', 0, 0, 0, '2025-11-14 13:02:36', '2025-11-14 12:57:36', '2025-11-14 12:57:36'),
(123, 2, '9152616125', '639092', 0, 0, 0, '2025-11-14 13:02:36', '2025-11-14 12:57:36', '2025-11-14 12:57:36'),
(124, 2, '9152616125', '560531', 0, 0, 0, '2025-11-14 13:02:36', '2025-11-14 12:57:36', '2025-11-14 12:57:36'),
(125, 2, '9152616125', '115923', 0, 0, 0, '2025-11-14 13:02:36', '2025-11-14 12:57:36', '2025-11-14 12:57:36'),
(126, 2, '9152616125', '901030', 0, 2, 0, '2025-11-14 13:16:33', '2025-11-14 13:11:33', '2025-11-14 13:12:20'),
(127, 2, '9152616125', '567130', 0, 0, 0, '2025-11-14 13:16:33', '2025-11-14 13:11:33', '2025-11-14 13:11:33'),
(128, 2, '9152616125', '941733', 0, 0, 0, '2025-11-14 13:16:33', '2025-11-14 13:11:33', '2025-11-14 13:11:33'),
(129, 2, '9152616125', '221923', 0, 0, 0, '2025-11-14 13:16:33', '2025-11-14 13:11:33', '2025-11-14 13:11:33'),
(130, 2, '9152616125', '237272', 0, 0, 0, '2025-11-14 13:16:33', '2025-11-14 13:11:33', '2025-11-14 13:11:33'),
(131, 2, '9152616125', '315427', 0, 0, 0, '2025-11-14 13:16:33', '2025-11-14 13:11:33', '2025-11-14 13:11:33'),
(132, 2, '9152616125', '105018', 0, 0, 0, '2025-11-14 13:16:33', '2025-11-14 13:11:33', '2025-11-14 13:11:33'),
(133, 2, '9152616125', '411097', 0, 0, 0, '2025-11-14 13:16:33', '2025-11-14 13:11:33', '2025-11-14 13:11:33'),
(134, 2, '9152616125', '411360', 0, 0, 0, '2025-11-14 13:18:51', '2025-11-14 13:13:51', '2025-11-14 13:13:51'),
(135, 2, '9152616125', '542629', 0, 0, 0, '2025-11-14 13:18:51', '2025-11-14 13:13:51', '2025-11-14 13:13:51'),
(136, 2, '9152616125', '812701', 0, 0, 0, '2025-11-14 13:18:51', '2025-11-14 13:13:51', '2025-11-14 13:13:51'),
(137, 2, '9152616125', '471130', 0, 0, 0, '2025-11-14 13:21:15', '2025-11-14 13:16:15', '2025-11-14 13:16:15'),
(138, 2, '9152616125', '809052', 0, 0, 0, '2025-11-14 13:21:15', '2025-11-14 13:16:15', '2025-11-14 13:16:15'),
(139, 2, '9152616125', '653541', 0, 0, 0, '2025-11-14 13:21:15', '2025-11-14 13:16:15', '2025-11-14 13:16:15'),
(140, 2, '9152616125', '793334', 0, 0, 0, '2025-11-14 13:21:16', '2025-11-14 13:16:16', '2025-11-14 13:16:16'),
(141, 2, '9152616125', '260448', 0, 0, 0, '2025-11-14 13:23:19', '2025-11-14 13:18:19', '2025-11-14 13:18:19'),
(142, 2, '9152616125', '663949', 0, 0, 0, '2025-11-14 13:23:19', '2025-11-14 13:18:19', '2025-11-14 13:18:19'),
(143, 2, '9152616125', '829624', 0, 0, 0, '2025-11-14 13:23:19', '2025-11-14 13:18:19', '2025-11-14 13:18:19'),
(144, 2, '9152616125', '555046', 0, 0, 0, '2025-11-14 13:26:43', '2025-11-14 13:21:43', '2025-11-14 13:21:43'),
(145, 2, '9152616125', '756816', 0, 0, 0, '2025-11-14 13:26:43', '2025-11-14 13:21:43', '2025-11-14 13:21:43'),
(146, 2, '9152616125', '109099', 0, 0, 0, '2025-11-14 13:26:44', '2025-11-14 13:21:44', '2025-11-14 13:21:44'),
(147, 2, '9152616125', '192078', 0, 0, 0, '2025-11-14 13:48:45', '2025-11-14 13:43:45', '2025-11-14 13:43:45'),
(148, 2, '9152616125', '980244', 0, 0, 0, '2025-11-14 13:48:45', '2025-11-14 13:43:45', '2025-11-14 13:43:45'),
(149, 2, '9152616125', '813204', 0, 0, 0, '2025-11-14 13:48:46', '2025-11-14 13:43:46', '2025-11-14 13:43:46'),
(150, 2, '9152616125', '167861', 0, 0, 0, '2025-11-14 14:00:47', '2025-11-14 13:55:47', '2025-11-14 13:55:47'),
(151, 2, '9152616125', '234914', 0, 0, 0, '2025-11-14 14:00:47', '2025-11-14 13:55:47', '2025-11-14 13:55:47'),
(152, 2, '9152616125', '982083', 0, 0, 0, '2025-11-14 14:00:47', '2025-11-14 13:55:47', '2025-11-14 13:55:47'),
(153, 2, '9152616125', '803225', 0, 0, 0, '2025-11-14 14:00:47', '2025-11-14 13:55:47', '2025-11-14 13:55:47'),
(154, 2, '9152616125', '747354', 0, 0, 0, '2025-11-14 14:00:47', '2025-11-14 13:55:47', '2025-11-14 13:55:47'),
(155, 2, '9152616125', '627000', 0, 0, 0, '2025-11-14 14:00:47', '2025-11-14 13:55:47', '2025-11-14 13:55:47'),
(156, 2, '9152616125', '840521', 0, 0, 0, '2025-11-14 14:00:47', '2025-11-14 13:55:47', '2025-11-14 13:55:47'),
(157, 2, '9152616125', '179646', 0, 0, 0, '2025-11-14 14:00:47', '2025-11-14 13:55:47', '2025-11-14 13:55:47'),
(158, 1, '8423485660', '638618', 0, 0, 0, '2025-11-14 15:27:00', '2025-11-14 15:22:00', '2025-11-14 15:22:00'),
(159, 1, '8423485660', '750243', 0, 0, 0, '2025-11-14 15:27:29', '2025-11-14 15:22:29', '2025-11-14 15:22:29'),
(160, 1, '8423485660', '698856', 0, 0, 0, '2025-11-14 15:36:47', '2025-11-14 15:31:47', '2025-11-14 15:31:47'),
(161, 1, '8423485660', '584894', 0, 0, 0, '2025-11-14 15:36:53', '2025-11-14 15:31:53', '2025-11-14 15:31:53'),
(162, 1, '8423485660', '622323', 0, 0, 0, '2025-11-14 16:11:38', '2025-11-14 16:06:38', '2025-11-14 16:06:38'),
(163, 1, '8423485660', '528764', 0, 0, 1, '2025-11-14 16:11:47', '2025-11-14 16:06:47', '2025-11-14 16:06:55'),
(164, 2, '9152616125', '773593', 0, 0, 0, '2025-11-14 16:55:57', '2025-11-14 16:50:57', '2025-11-14 16:50:57'),
(165, 2, '9152616125', '179841', 0, 0, 0, '2025-11-14 16:55:57', '2025-11-14 16:50:57', '2025-11-14 16:50:57'),
(166, 2, '9152616125', '941579', 0, 0, 0, '2025-11-14 16:55:57', '2025-11-14 16:50:57', '2025-11-14 16:50:57'),
(167, 2, '9152616125', '786597', 0, 0, 1, '2025-11-14 16:56:17', '2025-11-14 16:51:17', '2025-11-14 16:51:31'),
(168, 2, '9152616125', '472722', 0, 0, 0, '2025-11-14 16:59:08', '2025-11-14 16:54:08', '2025-11-14 16:54:08'),
(169, 2, '9152616125', '546212', 0, 0, 0, '2025-11-14 16:59:08', '2025-11-14 16:54:08', '2025-11-14 16:54:08'),
(170, 2, '9152616125', '342054', 0, 0, 1, '2025-11-14 16:59:52', '2025-11-14 16:54:52', '2025-11-14 16:55:04'),
(171, 2, '9152616125', '926909', 0, 0, 0, '2025-11-14 17:07:22', '2025-11-14 17:02:22', '2025-11-14 17:02:22'),
(172, 2, '9152616125', '396113', 0, 0, 0, '2025-11-14 17:07:22', '2025-11-14 17:02:22', '2025-11-14 17:02:22'),
(173, 2, '9152616125', '275657', 0, 0, 0, '2025-11-14 17:07:22', '2025-11-14 17:02:22', '2025-11-14 17:02:22'),
(174, 2, '9152616125', '758333', 0, 0, 0, '2025-11-14 17:07:22', '2025-11-14 17:02:22', '2025-11-14 17:02:22'),
(175, 2, '9152616125', '437586', 0, 0, 1, '2025-11-14 17:07:38', '2025-11-14 17:02:38', '2025-11-14 17:03:21'),
(176, 2, '9152616125', '571678', 0, 1, 1, '2025-11-14 17:08:41', '2025-11-14 17:03:41', '2025-11-14 17:04:13'),
(177, 2, '9152616125', '558285', 0, 0, 0, '2025-11-14 17:14:09', '2025-11-14 17:09:09', '2025-11-14 17:09:09'),
(178, 2, '9152616125', '426061', 0, 0, 1, '2025-11-14 17:15:36', '2025-11-14 17:10:36', '2025-11-14 17:10:47'),
(182, 2, '9152616125', '866681', 0, 0, 0, '2025-11-14 17:28:06', '2025-11-14 17:23:06', '2025-11-14 17:23:06'),
(183, 2, '9152616125', '837326', 0, 0, 1, '2025-11-14 17:30:13', '2025-11-14 17:25:13', '2025-11-14 17:26:36'),
(184, 2, '9152616125', '334811', 0, 0, 0, '2025-11-14 17:35:23', '2025-11-14 17:30:23', '2025-11-14 17:30:23'),
(185, 2, '9152616125', '533309', 0, 0, 0, '2025-11-14 17:35:23', '2025-11-14 17:30:23', '2025-11-14 17:30:23'),
(186, 2, '9152616125', '337075', 0, 0, 0, '2025-11-14 17:35:23', '2025-11-14 17:30:23', '2025-11-14 17:30:23'),
(187, 2, '9152616125', '804693', 0, 5, 0, '2025-11-14 17:35:40', '2025-11-14 17:30:40', '2025-11-14 17:31:27'),
(188, 2, '9152616125', '138859', 0, 0, 0, '2025-11-14 17:35:40', '2025-11-14 17:30:40', '2025-11-14 17:30:40'),
(189, 2, '9152616125', '892589', 0, 0, 0, '2025-11-14 17:35:40', '2025-11-14 17:30:40', '2025-11-14 17:30:40'),
(190, 2, '9152616125', '421735', 0, 6, 0, '2025-11-14 17:37:47', '2025-11-14 17:32:47', '2025-11-14 17:34:18'),
(191, 2, '9152616125', '305562', 0, 0, 0, '2025-11-14 17:37:47', '2025-11-14 17:32:47', '2025-11-14 17:32:47'),
(192, 2, '9152616125', '506313', 0, 2, 0, '2025-11-14 17:42:28', '2025-11-14 17:37:28', '2025-11-14 17:37:55'),
(193, 2, '9152616125', '433372', 0, 0, 0, '2025-11-14 17:42:28', '2025-11-14 17:37:28', '2025-11-14 17:37:28'),
(194, 2, '9152616125', '529368', 0, 0, 1, '2025-11-14 17:45:21', '2025-11-14 17:40:21', '2025-11-14 17:40:37'),
(195, 6, '7433004444', '424690', 0, 0, 0, '2025-11-14 18:12:12', '2025-11-14 18:07:12', '2025-11-14 18:07:12'),
(196, 6, '7433004444', '420441', 0, 0, 1, '2025-11-14 18:12:28', '2025-11-14 18:07:28', '2025-11-14 18:07:36'),
(197, 1, '8423485660', '743447', 0, 0, 0, '2025-11-14 18:16:18', '2025-11-14 18:11:18', '2025-11-14 18:11:18'),
(198, 1, '8423485660', '833397', 0, 0, 1, '2025-11-14 18:16:24', '2025-11-14 18:11:24', '2025-11-14 18:11:34'),
(199, 2, '9152616125', '786294', 0, 0, 0, '2025-11-14 19:20:05', '2025-11-14 19:15:05', '2025-11-14 19:15:05'),
(200, 1, '8423485660', '908996', 0, 0, 0, '2025-11-14 22:21:01', '2025-11-14 22:16:01', '2025-11-14 22:16:01'),
(201, 1, '8423485660', '601414', 0, 0, 1, '2025-11-15 13:56:58', '2025-11-15 13:51:58', '2025-11-15 13:52:05'),
(202, 1, '8423485660', '328091', 0, 0, 1, '2025-11-15 17:25:37', '2025-11-15 17:20:37', '2025-11-15 17:20:45'),
(203, 1, '8423485660', '725198', 0, 1, 0, '2025-11-17 14:22:45', '2025-11-17 14:17:45', '2025-11-17 14:17:53'),
(204, 1, '8423485660', '506786', 0, 0, 1, '2025-11-17 14:22:59', '2025-11-17 14:17:59', '2025-11-17 14:18:08'),
(205, 1, '8423485660', '834876', 0, 0, 1, '2025-11-17 17:09:35', '2025-11-17 17:04:35', '2025-11-17 17:04:43'),
(206, 1, '8423485660', '577511', 0, 0, 1, '2025-11-17 17:12:46', '2025-11-17 17:07:46', '2025-11-17 17:07:56'),
(207, 1, '8423485660', '970711', 0, 0, 1, '2025-11-17 23:05:45', '2025-11-17 23:00:45', '2025-11-17 23:00:55'),
(208, 1, '8423485660', '286277', 0, 0, 1, '2025-11-18 12:49:39', '2025-11-18 12:44:39', '2025-11-18 12:44:50'),
(209, 1, '8423485660', '266465', 0, 0, 0, '2025-11-18 18:42:04', '2025-11-18 18:37:04', '2025-11-18 18:37:04'),
(210, 1, '8423485660', '114960', 0, 0, 1, '2025-11-18 18:42:10', '2025-11-18 18:37:10', '2025-11-18 18:37:17'),
(211, 1, '8423485660', '883201', 0, 0, 0, '2025-11-18 18:46:44', '2025-11-18 18:41:44', '2025-11-18 18:41:44'),
(212, 1, '8423485660', '405082', 0, 0, 1, '2025-11-18 18:46:55', '2025-11-18 18:41:55', '2025-11-18 18:42:04'),
(213, 1, '8423485660', '272438', 0, 0, 1, '2025-11-18 18:50:58', '2025-11-18 18:45:58', '2025-11-18 18:46:09'),
(214, 2, '9152616125', '922587', 0, 1, 0, '2025-11-18 19:26:33', '2025-11-18 19:21:33', '2025-11-18 19:22:53'),
(215, 2, '9152616125', '478275', 0, 0, 1, '2025-11-18 19:26:49', '2025-11-18 19:21:49', '2025-11-18 19:22:10'),
(216, 2, '9152616125', '639495', 0, 0, 1, '2025-11-18 19:27:26', '2025-11-18 19:22:26', '2025-11-18 19:22:53'),
(217, 2, '9152616125', '209958', 0, 1, 0, '2025-11-18 19:28:17', '2025-11-18 19:23:17', '2025-11-18 19:23:46'),
(218, 2, '9152616125', '366814', 0, 0, 1, '2025-11-18 19:28:33', '2025-11-18 19:23:33', '2025-11-18 19:23:46'),
(219, 2, '9152616125', '803189', 0, 1, 0, '2025-11-18 19:29:42', '2025-11-18 19:24:42', '2025-11-18 19:25:14'),
(220, 2, '9152616125', '627276', 0, 0, 1, '2025-11-18 19:30:00', '2025-11-18 19:25:00', '2025-11-18 19:25:14'),
(221, 2, '9152616125', '435664', 0, 2, 0, '2025-11-18 19:30:29', '2025-11-18 19:25:29', '2025-11-18 19:26:49'),
(222, 2, '9152616125', '148957', 0, 0, 0, '2025-11-18 19:30:29', '2025-11-18 19:25:29', '2025-11-18 19:25:29'),
(223, 2, '9152616125', '320100', 0, 0, 1, '2025-11-18 19:32:08', '2025-11-18 19:27:08', '2025-11-18 19:27:25'),
(224, 2, '9152616125', '488888', 0, 0, 1, '2025-11-18 19:43:55', '2025-11-18 19:38:55', '2025-11-18 19:39:14'),
(225, 2, '9152616125', '153773', 0, 0, 0, '2025-11-18 19:43:55', '2025-11-18 19:38:55', '2025-11-18 19:38:55'),
(226, 2, '9152616125', '217454', 0, 0, 0, '2025-11-18 19:43:55', '2025-11-18 19:38:55', '2025-11-18 19:38:55'),
(227, 1, '8423485660', '597524', 0, 0, 1, '2025-11-18 21:21:02', '2025-11-18 21:16:02', '2025-11-18 21:16:11'),
(232, 1, '8423485660', '784811', 0, 0, 1, '2025-11-19 01:12:32', '2025-11-19 01:07:32', '2025-11-19 01:07:40'),
(233, 1, '8423485660', '676994', 0, 0, 1, '2025-11-19 01:15:50', '2025-11-19 01:10:50', '2025-11-19 01:10:59'),
(234, 1, '8423485660', '923913', 0, 0, 0, '2025-11-19 01:16:42', '2025-11-19 01:11:42', '2025-11-19 01:11:42'),
(235, 1, '8423485660', '529426', 0, 0, 0, '2025-11-19 01:16:49', '2025-11-19 01:11:49', '2025-11-19 01:11:49'),
(236, 1, '8423485660', '349812', 0, 0, 1, '2025-11-19 01:16:59', '2025-11-19 01:11:59', '2025-11-19 01:12:09'),
(237, 1, '8423485660', '147675', 0, 1, 1, '2025-11-19 01:17:24', '2025-11-19 01:12:24', '2025-11-19 01:12:41'),
(238, 1, '8423485660', '575794', 0, 0, 1, '2025-11-19 01:18:45', '2025-11-19 01:13:45', '2025-11-19 01:13:53'),
(239, 2, '9152616125', '485454', 0, 0, 1, '2025-11-19 13:49:04', '2025-11-19 13:44:04', '2025-11-19 13:44:12'),
(240, 1, '8423485660', '869266', 0, 0, 1, '2025-11-19 13:57:46', '2025-11-19 13:52:46', '2025-11-19 13:52:54'),
(258, 1, '8423485660', '772646', 0, 0, 1, '2025-11-20 12:30:21', '2025-11-20 12:25:21', '2025-11-20 12:25:32'),
(260, 1, '8423485660', '180229', 0, 0, 1, '2025-11-21 01:08:52', '2025-11-21 01:03:52', '2025-11-21 01:04:04'),
(261, 2, '9152616125', '465864', 0, 0, 1, '2025-11-21 08:52:17', '2025-11-21 08:47:17', '2025-11-21 08:48:28'),
(262, 2, '9152616125', '544363', 0, 0, 0, '2025-11-21 09:02:40', '2025-11-21 08:57:40', '2025-11-21 08:57:40'),
(263, 2, '9152616125', '405552', 0, 0, 0, '2025-11-21 09:02:53', '2025-11-21 08:57:53', '2025-11-21 08:57:53'),
(264, 2, '9152616125', '604257', 0, 0, 0, '2025-11-21 09:02:53', '2025-11-21 08:57:53', '2025-11-21 08:57:53'),
(265, 2, '9152616125', '629321', 0, 3, 0, '2025-11-21 09:02:54', '2025-11-21 08:57:54', '2025-11-21 08:58:08'),
(266, 2, '9152616125', '738115', 0, 0, 0, '2025-11-21 09:20:21', '2025-11-21 09:15:21', '2025-11-21 09:15:21'),
(267, 2, '9152616125', '706821', 0, 0, 0, '2025-11-21 09:20:21', '2025-11-21 09:15:21', '2025-11-21 09:15:21'),
(268, 2, '9152616125', '271766', 0, 0, 0, '2025-11-21 09:20:21', '2025-11-21 09:15:22', '2025-11-21 09:15:22'),
(269, 2, '9152616125', '481025', 0, 0, 0, '2025-11-21 09:20:22', '2025-11-21 09:15:22', '2025-11-21 09:15:22'),
(270, 2, '9152616125', '293564', 0, 0, 0, '2025-11-21 09:20:22', '2025-11-21 09:15:22', '2025-11-21 09:15:22'),
(271, 2, '9152616125', '267694', 0, 0, 0, '2025-11-21 09:20:22', '2025-11-21 09:15:22', '2025-11-21 09:15:22'),
(272, 2, '9152616125', '965457', 0, 0, 0, '2025-11-21 09:20:23', '2025-11-21 09:15:23', '2025-11-21 09:15:23'),
(273, 2, '9152616125', '783009', 0, 0, 0, '2025-11-21 09:20:23', '2025-11-21 09:15:23', '2025-11-21 09:15:23'),
(274, 2, '9152616125', '143443', 0, 0, 0, '2025-11-21 09:20:23', '2025-11-21 09:15:23', '2025-11-21 09:15:23'),
(275, 2, '9152616125', '998047', 0, 0, 0, '2025-11-21 09:20:23', '2025-11-21 09:15:23', '2025-11-21 09:15:23'),
(276, 2, '9152616125', '310509', 0, 0, 0, '2025-11-21 09:20:23', '2025-11-21 09:15:23', '2025-11-21 09:15:23'),
(277, 2, '9152616125', '193183', 0, 0, 0, '2025-11-21 09:20:23', '2025-11-21 09:15:23', '2025-11-21 09:15:23'),
(278, 2, '9152616125', '321486', 0, 0, 0, '2025-11-21 09:20:23', '2025-11-21 09:15:23', '2025-11-21 09:15:23'),
(279, 2, '9152616125', '295796', 0, 0, 0, '2025-11-21 09:20:23', '2025-11-21 09:15:23', '2025-11-21 09:15:23'),
(280, 2, '9152616125', '998478', 0, 0, 0, '2025-11-21 16:07:32', '2025-11-21 16:02:32', '2025-11-21 16:02:32'),
(281, 2, '9152616125', '863686', 0, 0, 0, '2025-11-21 16:07:33', '2025-11-21 16:02:33', '2025-11-21 16:02:33'),
(282, 2, '9152616125', '205191', 0, 0, 0, '2025-11-21 16:08:44', '2025-11-21 16:03:44', '2025-11-21 16:03:44'),
(283, 2, '9152616125', '868759', 0, 0, 1, '2025-11-21 16:08:45', '2025-11-21 16:03:45', '2025-11-21 16:04:09'),
(284, 2, '9152616125', '772269', 0, 0, 0, '2025-11-21 16:08:45', '2025-11-21 16:03:45', '2025-11-21 16:03:45'),
(285, 2, '9152616125', '214124', 0, 0, 0, '2025-11-21 16:14:45', '2025-11-21 16:09:45', '2025-11-21 16:09:45'),
(286, 2, '9152616125', '141604', 0, 0, 0, '2025-11-21 16:14:46', '2025-11-21 16:09:46', '2025-11-21 16:09:46'),
(287, 2, '9152616125', '769500', 0, 0, 0, '2025-11-21 16:14:46', '2025-11-21 16:09:46', '2025-11-21 16:09:46'),
(288, 2, '9152616125', '138948', 0, 0, 0, '2025-11-21 16:14:47', '2025-11-21 16:09:47', '2025-11-21 16:09:47'),
(289, 2, '9152616125', '437325', 0, 0, 0, '2025-11-21 16:14:47', '2025-11-21 16:09:47', '2025-11-21 16:09:47'),
(290, 2, '9152616125', '620346', 0, 0, 0, '2025-11-21 16:14:47', '2025-11-21 16:09:47', '2025-11-21 16:09:47'),
(291, 2, '9152616125', '246844', 0, 0, 0, '2025-11-21 16:14:47', '2025-11-21 16:09:47', '2025-11-21 16:09:47'),
(292, 2, '9152616125', '377764', 0, 0, 0, '2025-11-21 16:14:48', '2025-11-21 16:09:48', '2025-11-21 16:09:48'),
(293, 2, '9152616125', '985374', 0, 0, 0, '2025-11-21 16:15:43', '2025-11-21 16:10:43', '2025-11-21 16:10:43'),
(294, 2, '9152616125', '831688', 0, 0, 0, '2025-11-21 16:15:43', '2025-11-21 16:10:43', '2025-11-21 16:10:43'),
(295, 2, '9152616125', '407661', 0, 0, 0, '2025-11-21 16:15:43', '2025-11-21 16:10:43', '2025-11-21 16:10:43'),
(296, 2, '9152616125', '802825', 0, 0, 0, '2025-11-21 16:15:43', '2025-11-21 16:10:43', '2025-11-21 16:10:43'),
(297, 2, '9152616125', '681982', 0, 0, 0, '2025-11-21 16:15:43', '2025-11-21 16:10:43', '2025-11-21 16:10:43'),
(298, 2, '9152616125', '789904', 0, 0, 0, '2025-11-21 16:15:43', '2025-11-21 16:10:43', '2025-11-21 16:10:43'),
(299, 2, '9152616125', '818637', 0, 0, 0, '2025-11-21 16:15:44', '2025-11-21 16:10:44', '2025-11-21 16:10:44'),
(300, 2, '9152616125', '708761', 0, 0, 0, '2025-11-21 16:15:44', '2025-11-21 16:10:44', '2025-11-21 16:10:44'),
(301, 2, '9152616125', '937247', 0, 0, 1, '2025-11-21 16:15:45', '2025-11-21 16:10:45', '2025-11-21 16:11:03'),
(302, 2, '9152616125', '633637', 0, 0, 0, '2025-11-21 16:23:49', '2025-11-21 16:18:49', '2025-11-21 16:18:49'),
(303, 2, '9152616125', '422695', 0, 0, 0, '2025-11-21 16:23:50', '2025-11-21 16:18:50', '2025-11-21 16:18:50'),
(304, 2, '9152616125', '868533', 0, 0, 0, '2025-11-21 16:23:50', '2025-11-21 16:18:50', '2025-11-21 16:18:50'),
(305, 2, '9152616125', '251701', 0, 0, 0, '2025-11-22 11:26:18', '2025-11-22 11:21:18', '2025-11-22 11:21:18'),
(306, 2, '9152616125', '312885', 0, 0, 0, '2025-11-22 11:26:19', '2025-11-22 11:21:19', '2025-11-22 11:21:19'),
(307, 2, '9152616125', '931197', 0, 0, 0, '2025-11-22 11:26:20', '2025-11-22 11:21:20', '2025-11-22 11:21:20'),
(308, 2, '9152616125', '921910', 0, 0, 0, '2025-11-22 11:26:20', '2025-11-22 11:21:20', '2025-11-22 11:21:20'),
(309, 2, '9152616125', '765697', 0, 0, 0, '2025-11-22 11:26:20', '2025-11-22 11:21:20', '2025-11-22 11:21:20'),
(310, 1, '8423485660', '466887', 0, 0, 0, '2025-11-22 12:08:36', '2025-11-22 12:03:36', '2025-11-22 12:03:36'),
(311, 1, '8423485660', '532845', 0, 0, 1, '2025-11-22 12:08:44', '2025-11-22 12:03:44', '2025-11-22 12:03:54'),
(312, 2, '9152616125', '549687', 0, 0, 0, '2025-11-22 23:02:37', '2025-11-22 22:57:37', '2025-11-22 22:57:37'),
(313, 2, '9152616125', '445533', 0, 0, 0, '2025-11-22 23:02:41', '2025-11-22 22:57:41', '2025-11-22 22:57:41'),
(314, 2, '9152616125', '285041', 0, 0, 0, '2025-11-22 23:02:59', '2025-11-22 22:57:59', '2025-11-22 22:57:59'),
(315, 2, '9152616125', '531578', 0, 0, 0, '2025-11-22 23:03:04', '2025-11-22 22:58:04', '2025-11-22 22:58:04');

-- --------------------------------------------------------

--
-- Table structure for table `wish_list`
--

CREATE TABLE `wish_list` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `added_date_time` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `wish_list`
--

INSERT INTO `wish_list` (`id`, `user_id`, `product_id`, `added_date_time`) VALUES
(53, 7, 24, '2025-11-19 01:02:01');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `admin_recharge_transactions`
--
ALTER TABLE `admin_recharge_transactions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `banner_list`
--
ALTER TABLE `banner_list`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `brand_list`
--
ALTER TABLE `brand_list`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cart_list`
--
ALTER TABLE `cart_list`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cart_list_user_id_foreign` (`user_id`),
  ADD KEY `cart_list_product_id_foreign` (`product_id`);

--
-- Indexes for table `category_type`
--
ALTER TABLE `category_type`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `coupon_code_list`
--
ALTER TABLE `coupon_code_list`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `delivery_boys`
--
ALTER TABLE `delivery_boys`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `phone` (`phone`);

--
-- Indexes for table `delivery_boy_wallet_transactions`
--
ALTER TABLE `delivery_boy_wallet_transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `delivery_boy_wallet_transactions_delivery_boy_id_foreign` (`delivery_boy_id`),
  ADD KEY `delivery_boy_wallet_transactions_booking_id_foreign` (`booking_id`);

--
-- Indexes for table `delivery_charges`
--
ALTER TABLE `delivery_charges`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notification_list`
--
ALTER TABLE `notification_list`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_items_order_id_foreign` (`order_id`);

--
-- Indexes for table `other_data`
--
ALTER TABLE `other_data`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `product_image_list`
--
ALTER TABLE `product_image_list`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subcategory_list`
--
ALTER TABLE `subcategory_list`
  ADD PRIMARY KEY (`id`),
  ADD KEY `subcategory_list_category_id_foreign` (`category_id`);

--
-- Indexes for table `user_address_list`
--
ALTER TABLE `user_address_list`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_addresses_user_id_foreign` (`user_id`);

--
-- Indexes for table `user_wallet_transactions`
--
ALTER TABLE `user_wallet_transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_wallet_transactions_user_id_foreign` (`user_id`),
  ADD KEY `user_wallet_transactions_booking_id_foreign` (`booking_id`);

--
-- Indexes for table `vendors`
--
ALTER TABLE `vendors`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `vendor_add_products`
--
ALTER TABLE `vendor_add_products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `vendor_add_products_vendor_id_foreign` (`vendor_id`);

--
-- Indexes for table `vendor_business_types`
--
ALTER TABLE `vendor_business_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `vendor_categories`
--
ALTER TABLE `vendor_categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `vendor_categories_category_name_unique` (`category_name`);

--
-- Indexes for table `vendor_wallet_transactions`
--
ALTER TABLE `vendor_wallet_transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `vendor_wallet_transactions_vendor_id_foreign` (`vendor_id`),
  ADD KEY `vendor_wallet_transactions_booking_id_foreign` (`booking_id`);

--
-- Indexes for table `verify_otps`
--
ALTER TABLE `verify_otps`
  ADD PRIMARY KEY (`id`),
  ADD KEY `verify_otps_login_id_foreign` (`login_id`);

--
-- Indexes for table `wish_list`
--
ALTER TABLE `wish_list`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `admin_recharge_transactions`
--
ALTER TABLE `admin_recharge_transactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `banner_list`
--
ALTER TABLE `banner_list`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `brand_list`
--
ALTER TABLE `brand_list`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `cart_list`
--
ALTER TABLE `cart_list`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=244;

--
-- AUTO_INCREMENT for table `category_type`
--
ALTER TABLE `category_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `coupon_code_list`
--
ALTER TABLE `coupon_code_list`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `delivery_boys`
--
ALTER TABLE `delivery_boys`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `delivery_boy_wallet_transactions`
--
ALTER TABLE `delivery_boy_wallet_transactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `delivery_charges`
--
ALTER TABLE `delivery_charges`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `login`
--
ALTER TABLE `login`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `notification_list`
--
ALTER TABLE `notification_list`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=89;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=127;

--
-- AUTO_INCREMENT for table `other_data`
--
ALTER TABLE `other_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_image_list`
--
ALTER TABLE `product_image_list`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subcategory_list`
--
ALTER TABLE `subcategory_list`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=104;

--
-- AUTO_INCREMENT for table `user_address_list`
--
ALTER TABLE `user_address_list`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `user_wallet_transactions`
--
ALTER TABLE `user_wallet_transactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `vendors`
--
ALTER TABLE `vendors`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `vendor_add_products`
--
ALTER TABLE `vendor_add_products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `vendor_business_types`
--
ALTER TABLE `vendor_business_types`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `vendor_categories`
--
ALTER TABLE `vendor_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `vendor_wallet_transactions`
--
ALTER TABLE `vendor_wallet_transactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `verify_otps`
--
ALTER TABLE `verify_otps`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=317;

--
-- AUTO_INCREMENT for table `wish_list`
--
ALTER TABLE `wish_list`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=77;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cart_list`
--
ALTER TABLE `cart_list`
  ADD CONSTRAINT `cart_list_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `vendor_add_products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cart_list_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `login` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `delivery_boy_wallet_transactions`
--
ALTER TABLE `delivery_boy_wallet_transactions`
  ADD CONSTRAINT `delivery_boy_wallet_transactions_booking_id_foreign` FOREIGN KEY (`booking_id`) REFERENCES `orders` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `subcategory_list`
--
ALTER TABLE `subcategory_list`
  ADD CONSTRAINT `subcategory_list_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `vendor_categories` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_address_list`
--
ALTER TABLE `user_address_list`
  ADD CONSTRAINT `user_addresses_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `login` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_wallet_transactions`
--
ALTER TABLE `user_wallet_transactions`
  ADD CONSTRAINT `user_wallet_transactions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `login` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `vendor_add_products`
--
ALTER TABLE `vendor_add_products`
  ADD CONSTRAINT `vendor_add_products_vendor_id_foreign` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `vendor_wallet_transactions`
--
ALTER TABLE `vendor_wallet_transactions`
  ADD CONSTRAINT `vendor_wallet_transactions_booking_id_foreign` FOREIGN KEY (`booking_id`) REFERENCES `orders` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `vendor_wallet_transactions_vendor_id_foreign` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `verify_otps`
--
ALTER TABLE `verify_otps`
  ADD CONSTRAINT `verify_otps_login_id_foreign` FOREIGN KEY (`login_id`) REFERENCES `login` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
