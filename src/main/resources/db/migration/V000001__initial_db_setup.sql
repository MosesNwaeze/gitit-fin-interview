-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Apr 22, 2021 at 12:06 PM
-- Server version: 5.7.30-0ubuntu0.16.04.1
-- PHP Version: 7.0.33-29+ubuntu16.04.1+deb.sury.org+1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `paygo`
--

-- --------------------------------------------------------

--
-- Table structure for table `agent`
--

CREATE TABLE `agents`
(
    `id`  varchar(36) NOT NULL,
    `created`           datetime     DEFAULT NULL,
    `created_by`        varchar(255) DEFAULT NULL,
    `modified`          datetime     DEFAULT NULL,
    `modified_by`       varchar(255) DEFAULT NULL,
    `business_address`  varchar(255) NOT NULL,
    `business_name`     varchar(255) NOT NULL,
    `city`              varchar(255) NOT NULL,
    `country`           varchar(255) NOT NULL,
    `description`       varchar(255) NOT NULL,
    `is_approved`       bit(1)       DEFAULT NULL,
    `state`             varchar(255) NOT NULL,
    `utility_bill`      varchar(255) NOT NULL,
    `identification_id` varchar(36)  NOT NULL,
    `user_id`          varchar(36) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

-- --------------------------------------------------------

--
-- Table structure for table `banned_token`
--

CREATE TABLE `banned_tokens`
(
    `id` varchar(36) NOT NULL,
    `created`     datetime     DEFAULT NULL,
    `created_by`  varchar(255) DEFAULT NULL,
    `modified`    datetime     DEFAULT NULL,
    `modified_by` varchar(255) DEFAULT NULL,
    `token`       varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

-- --------------------------------------------------------

--
-- Table structure for table `funding_account`
--

CREATE TABLE `funding_accounts`
(
    `id`  varchar(36) NOT NULL,
    `created`      datetime     DEFAULT NULL,
    `created_by`   varchar(255) DEFAULT NULL,
    `account_name` varchar(255) NOT NULL,
    `account_no`   varchar(255) NOT NULL,
    `bank_code`    varchar(255) NOT NULL,
    `bank_name`    varchar(255) NOT NULL,
    `currency`     varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

-- --------------------------------------------------------

--
-- Table structure for table `hibernate_sequence`
--


-- --------------------------------------------------------

--
-- Table structure for table `id`
--

CREATE TABLE `ids`
(
    `id` varchar(36) NOT NULL,
    `created`     datetime     DEFAULT NULL,
    `created_by`  varchar(255) DEFAULT NULL,
    `modified`    datetime     DEFAULT NULL,
    `modified_by` varchar(255) DEFAULT NULL,
    `exp_date`    date         DEFAULT NULL,
    `issue_date`  date         DEFAULT NULL,
    `number`      varchar(255) NOT NULL,
    `status`      varchar(255) DEFAULT NULL,
    `type`        varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

-- --------------------------------------------------------

--
-- Table structure for table `notification`
--

CREATE TABLE `notifications`
(
    `id`  varchar(36) NOT NULL,
    `created`      datetime     DEFAULT NULL,
    `created_by`   varchar(255) DEFAULT NULL,
    `modified`     datetime     DEFAULT NULL,
    `modified_by`  varchar(255) DEFAULT NULL,
    `message`      varchar(255) DEFAULT NULL,
    `status`       varchar(255) DEFAULT NULL,
    `title`        varchar(255) DEFAULT NULL,
    `type`         varchar(255) DEFAULT NULL,
    `recipient_id` varchar(36) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;


-- --------------------------------------------------------

--
-- Table structure for table `notification_template`
--

CREATE TABLE `notification_templates`
(
    `id` varchar(36) NOT NULL,
    `created`     datetime     DEFAULT NULL,
    `created_by`  varchar(255) DEFAULT NULL,
    `modified`    datetime     DEFAULT NULL,
    `modified_by` varchar(255) DEFAULT NULL,
    `message`     varchar(255) DEFAULT NULL,
    `title`       varchar(255) DEFAULT NULL,
    `type`        varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

-- --------------------------------------------------------

--
-- Table structure for table `payment_method`
--

CREATE TABLE `payment_methods`
(
    `DTYPE`             varchar(31) NOT NULL,
    `id`  varchar(36) NOT NULL,
    `created`           datetime       DEFAULT NULL,
    `created_by`        varchar(255)   DEFAULT NULL,
    `modified`          datetime       DEFAULT NULL,
    `modified_by`       varchar(255)   DEFAULT NULL,
    `authorization_code` varchar(255)   DEFAULT NULL,
    `account_name`      varchar(255)   DEFAULT NULL,
    `account_no`        varchar(255)   DEFAULT NULL,
    `bank_code`         varchar(255)   DEFAULT NULL,
    `bin`               varchar(255)   DEFAULT NULL,
    `country`           varchar(255)   DEFAULT NULL,
    `expiry`            varchar(255)   DEFAULT NULL,
    `issuer`            varchar(255)   DEFAULT NULL,
    `last_4_digits`     varchar(255)   DEFAULT NULL,
    `type`              varchar(255)   DEFAULT NULL,
    `balance`           decimal(19, 2) DEFAULT NULL,
    `ledger_balance`    decimal(19, 2) DEFAULT NULL,
    `owner_id`          varchar(36) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;


-- --------------------------------------------------------

--
-- Table structure for table `recipient`
--

CREATE TABLE `recipients`
(
    `DTYPE`        varchar(31) NOT NULL,
    `id`  varchar(36) NOT NULL,
    `created`      datetime     DEFAULT NULL,
    `created_by`   varchar(255) DEFAULT NULL,
    `modified`     datetime     DEFAULT NULL,
    `modified_by`  varchar(255) DEFAULT NULL,
    `biller_code`  varchar(255) DEFAULT NULL,
    `bank_code`    varchar(255) DEFAULT NULL,
    `nuban_number` varchar(10)  DEFAULT NULL,
    `title`        varchar(255) DEFAULT NULL,
    `email`        varchar(255) DEFAULT NULL,
    `phone`        varchar(255) DEFAULT NULL,
    `owner_id`     varchar(36) DEFAULT NULL,
    `user_id`      varchar(36) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;


-- --------------------------------------------------------

--
-- Table structure for table `recurring_transactions`
--

CREATE TABLE `recurring_transactions`
(
    `id`  varchar(36) NOT NULL,
    `created`                    datetime     DEFAULT NULL,
    `created_by`                 varchar(255) DEFAULT NULL,
    `modified`                   datetime     DEFAULT NULL,
    `modified_by`                varchar(255) DEFAULT NULL,
    `interval_between_occurence` int(11) DEFAULT NULL,
    `interval_type`              varchar(255) DEFAULT NULL,
    `status`                     varchar(255) DEFAULT NULL,
    `transaction_id`             varchar(36) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

-- --------------------------------------------------------

--
-- Table structure for table `setting`
--

CREATE TABLE `settings`
(
    `id` varchar(36) NOT NULL,
    `created`     datetime     DEFAULT NULL,
    `created_by`  varchar(255) DEFAULT NULL,
    `modified`    datetime     DEFAULT NULL,
    `modified_by` varchar(255) DEFAULT NULL,
    `name`        varchar(255) NOT NULL,
    `value`       varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions`
(
    `id`  varchar(36) NOT NULL,
    `created`          datetime     DEFAULT NULL,
    `created_by`       varchar(255) DEFAULT NULL,
    `modified`         datetime     DEFAULT NULL,
    `modified_by`      varchar(255) DEFAULT NULL,
    `pin`              varchar(255) DEFAULT NULL,
    `amount`           decimal(19, 2) NOT NULL,
    `remark`           varchar(255)   NOT NULL,
    `reference`        varchar(255) DEFAULT NULL,
    `status`           varchar(255)   NOT NULL,
    `transaction_time` datetime     DEFAULT NULL,
    `transaction_type` varchar(255)   NOT NULL,
    `user_id`          varchar(36) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;


-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users`
(
    `DTYPE`               varchar(31)  NOT NULL,
    `id`  varchar(36)     NOT NULL,
    `created`             datetime     DEFAULT NULL,
    `created_by`          varchar(255) DEFAULT NULL,
    `modified`            datetime     DEFAULT NULL,
    `modified_by`         varchar(255) DEFAULT NULL,
    `next_of_kin_phone`   varchar(255) DEFAULT NULL,
    `address`             varchar(255) DEFAULT NULL,
    `bvn`                 varchar(255) DEFAULT NULL,
    `city`                varchar(255) DEFAULT NULL,
    `country`             varchar(255) DEFAULT NULL,
    `date_of_birth`       date         DEFAULT NULL,
    `email`               varchar(255) NOT NULL,
    `first_name`          varchar(255) NOT NULL,
    `gender`              varchar(255) DEFAULT NULL,
    `is_bvn_verified`     bit(1)       DEFAULT NULL,
    `is_completed_tour`   bit(1)       DEFAULT NULL,
    `is_email_verified`   bit(1)       DEFAULT NULL,
    `is_phone_verified`   bit(1)       DEFAULT NULL,
    `last_name`           varchar(255) NOT NULL,
    `middle_name`         varchar(255) DEFAULT NULL,
    `next_of_kin_address` varchar(255) DEFAULT NULL,
    `next_of_kin_name`    varchar(255) DEFAULT NULL,
    `password`            varchar(255) DEFAULT NULL,
    `phone`               varchar(255) DEFAULT NULL,
    `state`               varchar(255) DEFAULT NULL,
    `funding_account_id`   varchar(36) DEFAULT NULL,
    `customer_code`       varchar(50),
    `pin`                 varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `agent`
--
ALTER TABLE `agents`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `banned_token`
--
ALTER TABLE `banned_tokens`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `funding_accounts`
--
ALTER TABLE `funding_accounts`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `id`
--
ALTER TABLE `ids`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notification`
--
ALTER TABLE `notifications`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notification_template`
--
ALTER TABLE `notification_templates`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_method`
--
ALTER TABLE `payment_methods`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `recipient`
--
ALTER TABLE `recipients`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `recurring_transactions`
--
ALTER TABLE `recurring_transactions`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `setting`
--
ALTER TABLE `settings`
    ADD PRIMARY KEY (`id`);
ALTER TABLE `settings` ADD CONSTRAINT `UK_bk4oycm648x0ox633r4m22b7d` UNIQUE (`name`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
    ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
    ADD PRIMARY KEY (`id`);
ALTER TABLE `users` ADD UNIQUE KEY `UK_bjt4nqf1ww1uibdj29i3c3gqb` (`bvn`);
ALTER TABLE `users` ADD UNIQUE KEY `UK_ob8kqyqqgmefl0aco34akdtpe` (`email`);
ALTER TABLE `users` ADD UNIQUE KEY `UK_589idila9li6a4arw1t8ht1gx` (`phone`);

--
-- Constraints for dumped tables
--
--
-- Constraints for table `agent`
--
ALTER TABLE `agents`
    ADD CONSTRAINT `FKghivfgul531vwd7wi9mysa1s7` FOREIGN KEY (`identification_id`) REFERENCES `ids` (`id`);
ALTER TABLE `agents` ADD CONSTRAINT `FKneqbqf7p5lfvciwroct25kasc` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `notification`
--
ALTER TABLE `notifications`
    ADD CONSTRAINT `FKqnduwq6ix2pxx1add03905i1i` FOREIGN KEY (`recipient_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `payment_method`
--
ALTER TABLE `payment_methods`
    ADD CONSTRAINT `FK8elunovv4gk3fytub6ehvtb3a` FOREIGN KEY (`owner_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `recipient`
--
ALTER TABLE `recipients`
    ADD CONSTRAINT `FK3041ks22uyyuuw441k5671ah9` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
ALTER TABLE `recipients`  ADD CONSTRAINT `FKp8hvm6lxk2dyn1dkm3ka1sca2` FOREIGN KEY (`owner_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `recurring_transactions`
--
ALTER TABLE `recurring_transactions`
    ADD CONSTRAINT `FK3lpe5c70b4kb920lkywxm8md0` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`);

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
    ADD CONSTRAINT `FKsg7jp0aj6qipr50856wf6vbw1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
    ADD CONSTRAINT `FKh0xlxrjaihq1116f7b38qs5di` FOREIGN KEY (`funding_account_id`) REFERENCES `funding_accounts` (`id`);


/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

