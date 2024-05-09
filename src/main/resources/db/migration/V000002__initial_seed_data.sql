ALTER TABLE `notification_templates` drop column `message`;
ALTER TABLE `notification_templates` add column `message` text;

INSERT INTO `users` (`DTYPE`, `id`, `created`, `created_by`, `modified`, `modified_by`, `next_of_kin_phone`, `address`,
                    `bvn`, `city`, `country`, `date_of_birth`, `email`, `first_name`, `gender`, `is_bvn_verified`,
                    `is_completed_tour`, `is_email_verified`, `is_phone_verified`, `last_name`, `middle_name`,
                    `next_of_kin_address`, `next_of_kin_name`, `password`, `phone`, `state`)
VALUES ('JpaUser', '2b08e375-275d-473e-910d-32700e34b61a', '2020-10-14 20:30:30', NULL, '2020-10-18 13:34:22', NULL, NULL, NULL, '08034813837122212313', NULL,
        NULL, NULL, 'ambagape@gmail.com', 'Tosin', NULL, false, false, true, false, 'Popoola', 'Osahon', NULL, NULL,
        'cbfad02f9ed2a8d1e08d8f74f5303e9eb93637d47f82ab6f1c15871cf8dd0481', '08034813814', NULL);

#Insert data into notification templates

insert into `notification_templates`(`id`, `title`, `message`)
values ('2c324ed6-00e2-11ed-b939-0242ac120002', 'Here is Your Activation Your Account','<html><body><p> Hello <span th:text="$\{recipientName}"></span>,</p><p> Here is the code for activating your account: <br/> <b th:text="$\{code}"></b></p></body></html>');
insert into notification_templates(id, title, message)
values ('b27681a6-00e2-11ed-b939-0242ac120002', 'Paygo Login Notification', '<html><body>Hello <span th:text="$\{recipientName}">, Someone just logged into your account </p></body></html>');
insert into notification_templates(id, title, message)
values ('c7bf8ae4-00e2-11ed-b939-0242ac120002', 'Notification of Transaction on Your Account','<html><body>Hello $\{recipientName},<p> The following jpaTransaction occured on your account: <p/> <p>Amount: $\{amt}<br/>Type:$\{type}<br/>Transaction time:$\{time}</p></body></html>');
insert into notification_templates(id, title, message)
values ('e089bfae-00e2-11ed-b939-0242ac120002', 'You Just Received Money on Paygo','<html><body>Hello $\{recipientName},<p> You have NGN$\{amt} to pickup from any Paygo agent. Details: <p/> <p>Amount: $\{amt}<br/>Reference:$\{remark}<br/>Transaction time:$\{transactTime}</p></body></html>');
insert into notification_templates(id, title, message)
values ('f4cd5de0-00e2-11ed-b939-0242ac120002', 'Welcome to Paygo', 'Hello , You are welcome to Paygo');
insert into notification_templates(id, title, message)
values ('076b1834-00e3-11ed-b939-0242ac120002', 'Your Reset Code', 'Hello <span th:text="$\{recipientName}"></span>, here is your reset code: <b th:text="$\{code}">');

#Insert data into accounts

INSERT INTO `recipients` (`DTYPE`, `id`, `created`, `created_by`, `modified`, `modified_by`, `biller_code`, `user_id`,
                         `bank_code`, `nuban_number`, `title`, `email`, `phone`, `owner_id`)
VALUES ('JpaPaygoBeneficiary', '38e729fc-00e3-11ed-b939-0242ac120002', CURRENT_DATE(), NULL, CURRENT_DATE(), NULL, NULL, NULL, 'NGINLA', '23323232',
        'Paygo MultiGLobal Services', 'ambagape@gmail.com', '08034813837', '2b08e375-275d-473e-910d-32700e34b61a');
INSERT INTO `recipients` (`DTYPE`, `id`, `created`, `created_by`, `modified`, `modified_by`, `biller_code`, `user_id`,
                         `bank_code`, `nuban_number`, `title`, `email`, `phone`, `owner_id`)
VALUES ('JpaBiller', '4b9111a8-00e3-11ed-b939-0242ac120002', CURRENT_DATE(), NULL, CURRENT_DATE(), NULL, NULL, NULL, 'NGINLA', '2323232',
        'Paygo MultiGLobal Services', 'ambagape@gmail.com', '08034813837', NULL);