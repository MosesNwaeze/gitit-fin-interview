CREATE TABLE `accounts` (
  `DTYPE` varchar(31) NOT NULL,
  `id` varchar(36) NOT NULL,
  `created` datetime(6) DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(255) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `cached_balance` decimal(19, 2) DEFAULT 0,
  `cached_balance_date` datetime(6) NOT NULL,
  `user_id` varchar(36) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
)  ENGINE=InnoDB DEFAULT CHARSET=UTF8;

ALTER TABLE `accounts` ADD CONSTRAINT `fk_accounts_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

INSERT INTO `accounts` (`DTYPE`, `id`, `created`, `created_by`, `modified`, `modified_by`, `note`, `user_id`, `name`, `cached_balance_date`)
    VALUES ('JpaAssetAccount', '74ac4b6f-f879-4d3c-b69e-62bcf18d63a8', CURRENT_DATE(), 'root', CURRENT_DATE(), 'root', 'no note', '2b08e375-275d-473e-910d-32700e34b61a', 'Paystack', CURRENT_DATE());

INSERT INTO `accounts` (`DTYPE`, `id`, `created`, `created_by`, `modified`, `modified_by`, `note`, `user_id`, `name`, `cached_balance_date`)
    VALUES ('JpaAssetAccount', 'e1f92d08-1b9f-4824-97f6-3c4c9a267d5d', CURRENT_DATE(), 'root', CURRENT_DATE(), 'root', 'no note', '2b08e375-275d-473e-910d-32700e34b61a', 'Flutterwave', CURRENT_DATE());

INSERT INTO `accounts` (`DTYPE`, `id`, `created`, `created_by`, `modified`, `modified_by`, `note`, `user_id`, `name`, `cached_balance_date`)
    VALUES ('JpaRevenueAccount', 'a2b5c6d7-8e9f-4a1c-b3d0-7f6e5e4d3c2a', CURRENT_DATE(), 'root', CURRENT_DATE(), 'root', 'no note', '2b08e375-275d-473e-910d-32700e34b61a', 'Revenues', CURRENT_DATE());


INSERT INTO `settings` (`id`,`created`,`modified`,`name`,`value`) VALUES ('6dbf8e73-29d6-4f63-8a4c-ec9b1af0eab7','2020-10-14 20:30:30','2020-10-14 20:30:30','PAYSTACK_ACCOUNT','74ac4b6f-f879-4d3c-b69e-62bcf18d63a8');
INSERT INTO `settings` (`id`,`created`,`modified`,`name`,`value`) VALUES ('d51ac37b-8ea9-4c35-9621-4eaa9c36c740','2020-10-14 20:30:30','2020-10-14 20:30:30','FLUTTERWAVE_ACCOUNT','e1f92d08-1b9f-4824-97f6-3c4c9a267d5d');
INSERT INTO `settings` (`id`,`created`,`modified`,`name`,`value`) VALUES ('25e70f94-6718-4b42-a599-8c5f1d3d8a75','2020-10-14 20:30:30','2020-10-14 20:30:30','REVENUE_ACCOUNT','a2b5c6d7-8e9f-4a1c-b3d0-7f6e5e4d3c2a');