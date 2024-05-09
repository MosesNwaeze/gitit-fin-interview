ALTER TABLE `recipients` DROP FOREIGN KEY `FKp8hvm6lxk2dyn1dkm3ka1sca2`;
ALTER TABLE `recipients` DROP COLUMN `owner_id`;
CREATE TABLE `user_beneficiaries` (
                                    `user_id`  varchar(36) NOT NULL,
                                    `recipient_id`  varchar(36) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

ALTER TABLE `user_beneficiaries` ADD CONSTRAINT `FKghivfgul531vwd7wi9bvsa1s7` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
ALTER TABLE `user_beneficiaries` ADD CONSTRAINT `FKghivfgul531vwd7wi9bvsa1s8` FOREIGN KEY (`recipient_id`) REFERENCES `recipients` (`id`);

ALTER TABLE `recipients` DROP FOREIGN KEY  `FK3041ks22uyyuuw441k5671ah9`;
ALTER TABLE `recipients` DROP COLUMN `user_id`;

ALTER TABLE `users` ADD COLUMN `account_id` varchar(36);
ALTER TABLE `users` ADD CONSTRAINT `FK_recipient_user_ah90` FOREIGN KEY (`account_id`) REFERENCES `recipients` (`id`);
ALTER TABLE `recipients` ADD COLUMN `payment_platform_recipient_id` varchar(100);