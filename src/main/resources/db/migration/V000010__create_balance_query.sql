CREATE VIEW user_with_wallet_view as
SELECT u.*, COALESCE(SUM(t.amount), 0) as balance
FROM `users` AS u
         LEFT JOIN `transactions` AS t on u.account_id = t.recipient_id and t.status = 1
GROUP BY u.id;