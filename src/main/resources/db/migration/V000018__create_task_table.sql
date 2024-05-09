CREATE TABLE `background_tasks` (
    `id` varchar(36) NOT NULL, 
    `status` varchar(20) NOT NULL,
    `json_data` TEXT,
    `created` datetime DEFAULT NULL,
    `created_by` varchar(255) DEFAULT NULL,
    `modified` datetime DEFAULT NULL,
    `modified_by` varchar(255) DEFAULT NULL
);