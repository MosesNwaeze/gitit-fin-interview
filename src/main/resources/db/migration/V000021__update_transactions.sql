UPDATE `transactions` SET `credit` = 0.00 WHERE `credit` IS NULL;
UPDATE `transactions` SET `debit` = 0.00 WHERE `debit` IS NULL;
ALTER TABLE `transactions` MODIFY `credit` decimal(19,2) DEFAULT 0.00; 
ALTER TABLE `transactions` MODIFY `debit` decimal(19,2) DEFAULT 0.00; 