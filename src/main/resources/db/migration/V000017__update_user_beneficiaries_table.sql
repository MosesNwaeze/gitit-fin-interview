ALTER TABLE `user_beneficiaries` 
    ADD COLUMN `id`  varchar(36) NOT NULL,
    ADD COLUMN `created` datetime,
    ADD COLUMN `last_used` datetime;

ALTER TABLE `user_beneficiaries` 
    ADD PRIMARY KEY(`id`);