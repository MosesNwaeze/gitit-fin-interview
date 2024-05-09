UPDATE `accounts` set `cached_balance_date` = NOW() WHERE `cached_balance_date` is NULL;
ALTER TABLE `accounts` MODIFY `cached_balance_date` DATETIME DEFAULT NOW(); 

DROP VIEW user_with_wallet_view;

CREATE VIEW user_with_wallet_view as
SELECT u.id, u.email, u.phone, u.bvn, u.first_name, u.last_name, u.middle_name, u.created, u.created_by,
       u.address, u.city, u.modified, u.customer_code, u.modified_by, u.state, u.country, u.date_of_birth, u.gender, u.next_of_kin_name, 
       u.next_of_kin_address, u.pin, u.password, u.is_bvn_verified, u.is_phone_verified, u.is_completed_tour, 
       u.is_disabled, u.is_email_verified, u.next_of_kin_phone, a.id as account_id, SUM(t.credit - t.debit) + COALESCE(a.cached_balance, 0) AS balance
FROM `users` AS u
LEFT JOIN `accounts` AS a ON u.id = a.user_id 
LEFT JOIN `transactions` AS t ON a.id = t.account_id AND t.created > a.cached_balance_date
LEFT JOIN `double_entries` AS de ON de.id = t.double_entry_id AND de.status = 'COMPLETED'
GROUP BY 
    u.id, u.email, u.phone, u.bvn, u.first_name, u.last_name, u.middle_name, u.customer_code, u.created, u.created_by, u.address, u.city,
    u.modified, u.modified_by, u.state, u.country, u.date_of_birth, u.gender, u.next_of_kin_name, 
    u.next_of_kin_address, u.pin, u.password, u.is_bvn_verified, u.is_phone_verified, u.is_completed_tour, 
    u.is_disabled, u.is_email_verified, u.next_of_kin_phone, a.id, a.cached_balance
ORDER BY u.id;
