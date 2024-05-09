ALTER TABLE `double_entries` DROP COLUMN `transaction_type`; 
ALTER TABLE `double_entries` ADD CONSTRAINT `double_entries_reference_unique` UNIQUE(`reference`); 
ALTER TABLE `double_entries` MODIFY `reference` varchar(50) NOT NULL;
ALTER TABLE `double_entries` MODIFY `status` varchar(20) NOT NULL; 
CREATE INDEX `idx_double_entries_status` ON double_entries(status); 