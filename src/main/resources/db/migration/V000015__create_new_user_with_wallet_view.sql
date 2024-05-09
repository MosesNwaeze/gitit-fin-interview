DROP VIEW user_with_wallet_view;

ALTER TABLE `users` DROP CONSTRAINT `FK_recipient_user_ah90`;
ALTER TABLE `users` DROP COLUMN `account_id`;

CREATE VIEW user_with_wallet_view as
SELECT u.id, u.email, u.phone, u.bvn, u.first_name, u.last_name, u.middle_name, u.created, u.created_by,
u.address, u.city, u.modified, u.customer_code, u.modified_by, u.state, u.country, u.date_of_birth, u.gender, u.next_of_kin_name, 
u.next_of_kin_address, u.pin, u.password, u.is_bvn_verified, u.is_phone_verified, u.is_completed_tour, 
u.is_disabled, u.is_email_verified, u.next_of_kin_phone, a.id as account_id, coalesce(SUM(t.credit - t.debit),0) AS balance
FROM `users` AS u
         LEFT JOIN `accounts` AS a on u.id = a.user_id LEFT JOIN `transactions` AS t on a.id = t.account_id 
GROUP BY 
    a.id, u.email, u.phone, u.bvn, u.first_name, u.last_name, u.middle_name, u.customer_code, u.created, u.created_by, u.address, u.city, u.address, u.city,
u.modified, modified_by, u.state, u.country, u.date_of_birth, u.gender, u.next_of_kin_name, 
u.next_of_kin_address, u.pin, u.password, u.is_bvn_verified, u.is_phone_verified, u.is_completed_tour, 
u.is_disabled, u.is_email_verified, u.next_of_kin_phone
ORDER BY
    u.id;