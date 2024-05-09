CREATE TABLE `double_entries`( 
  `id` varchar(36) NOT NULL,
  `created` datetime(6) DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(255) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `amount` decimal(19, 2) NOT NULL,
  `transaction_type` varchar(50) DEFAULT NULL,
  `reference` varchar(255) DEFAULT NULL,
  `user_id` varchar(36) NOT NULL,
  `status` varchar(20) DEFAULT 'DRAFT',
  PRIMARY KEY (`id`)
)  ENGINE=InnoDB DEFAULT CHARSET=UTF8;

ALTER TABLE `double_entries`
    ADD CONSTRAINT `fk_double_entry_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `transactions` DROP CONSTRAINT `FKsg7jp0aj6qipr50856wf6vbw1`;

ALTER TABLE `transactions` 
    DROP COLUMN `transaction_time`,
    DROP COLUMN `transaction_type`,
    DROP COLUMN `amount`,
    DROP COLUMN `modified_by`,
    DROP COLUMN `modified`,
    DROP COLUMN `status`,
    DROP COLUMN `user_id`,
    DROP COLUMN `recipient_id`,
    ADD COLUMN `account_id` varchar(36) NOT NULL,
    ADD COLUMN `credit` decimal(19, 2),
    ADD COLUMN `debit` decimal(19, 2),
    ADD COLUMN `double_entry_id` varchar(36) NOT NULL;

ALTER TABLE `transactions`
    ADD CONSTRAINT `fk_transaction_double_entry_id` FOREIGN KEY (`double_entry_id`) REFERENCES `double_entries` (`id`);