CREATE TABLE `requirements` (
  `id` varchar(36) NOT NULL,
  `created` datetime(6) DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `requires_approval` bit(1) NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
)  ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE `kyc_levels` (
  `id` varchar(36) NOT NULL,
  `created` datetime(6) DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_pv3fty4rrg8as4m3qhle9fd0o` (`name`)
)  ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE `kyc_level_dependencies` (
  `kyc_level_id` varchar(36) NOT NULL,
  `dependant_kyc_level_id` varchar(36) NOT NULL,
  KEY `FKr7rwfsn3vdh6b4hx6mxkc29cx` (`dependant_kyc_level_id`),
  KEY `FK5viyaujt92bat6t8plu92uyxi` (`kyc_level_id`),
  CONSTRAINT `FK5viyaujt92bat6t8plu92uyxi` FOREIGN KEY (`kyc_level_id`) REFERENCES `kyc_levels` (`id`),
  CONSTRAINT `FKr7rwfsn3vdh6b4hx6mxkc29cx` FOREIGN KEY (`dependant_kyc_level_id`) REFERENCES `kyc_levels` (`id`)
)  ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE `client_provileges` (
  `id` varchar(36) NOT NULL,
  `created` datetime(6) DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_r6jlegjq30m8n3q4ju9i1728b` (`name`)
)  ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE `kyc_level_pivileges` (
  `kyc_level_id` varchar(36) NOT NULL,
  `privilege_id` varchar(36) NOT NULL,
  KEY `FKtjwbeih6qvfhjlvbaq1q2qba3` (`privilege_id`),
  KEY `FK704n2l2tnltiwubkxowe8nhu8` (`kyc_level_id`),
  CONSTRAINT `FK704n2l2tnltiwubkxowe8nhu8` FOREIGN KEY (`kyc_level_id`) REFERENCES `kyc_levels` (`id`),
  CONSTRAINT `FKtjwbeih6qvfhjlvbaq1q2qba3` FOREIGN KEY (`privilege_id`) REFERENCES `client_provileges` (`id`)
)  ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE `kyc_level_requirements` (
  `kyc_level_id` varchar(36) NOT NULL,
  `requirement_id` varchar(36) NOT NULL,
  KEY `FKpaj7i2kcwql74n9jotyq35jhr` (`requirement_id`),
  KEY `FK2pvpg9we1jc275hn8lwufk42t` (`kyc_level_id`),
  CONSTRAINT `FK2pvpg9we1jc275hn8lwufk42t` FOREIGN KEY (`kyc_level_id`) REFERENCES `kyc_levels` (`id`),
  CONSTRAINT `FKpaj7i2kcwql74n9jotyq35jhr` FOREIGN KEY (`requirement_id`) REFERENCES `requirements` (`id`)
)  ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE `user_kyc_levels` (
  `user_id` varchar(36) NOT NULL,
  `kyc_level_id` varchar(36) NOT NULL,
  PRIMARY KEY (`user_id`,`kyc_level_id`),
  KEY `FKbl535r0q6wonnfgc19yl1mdiu` (`kyc_level_id`)
)  ENGINE=InnoDB DEFAULT CHARSET=UTF8;
alter table user_kyc_levels add constraint `FK4go70fidawd6ruotw17wsrnpp` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
alter table user_kyc_levels add CONSTRAINT `FKbl535r0q6wonnfgc19yl1mdiu` FOREIGN KEY (`kyc_level_id`) REFERENCES `kyc_levels` (`id`);