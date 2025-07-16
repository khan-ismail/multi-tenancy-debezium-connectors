CREATE DATABASE ejabberd;

USE ejabberd;

--
-- Table structure for table `admin_users`
--
CREATE TABLE `admin_users` (
    `id` varchar(36) NOT NULL,
    `username` varchar(191) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
    `role_id` varchar(36) DEFAULT NULL,
    `site_id` int DEFAULT NULL,
    `email` varchar(100) DEFAULT NULL,
    `first_name_english` varchar(100) DEFAULT NULL,
    `first_name_arabic` varchar(100) DEFAULT NULL,
    `last_name_english` varchar(100) DEFAULT NULL,
    `last_name_arabic` varchar(100) DEFAULT NULL,
    `mobile_number` varchar(20) DEFAULT NULL,
    `is_active` tinyint DEFAULT '1',
    `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `deleted_at` timestamp NULL DEFAULT NULL,
    `created_by` varchar(36) DEFAULT NULL,
    `updated_by` varchar(36) DEFAULT NULL,
    `deleted_by` varchar(36) DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `fk_users_role_id_idx` (`role_id`),
    KEY `fk_admin_users_site_id_idx` (`site_id`),
    CONSTRAINT `fk_admin_users_role_id` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
    CONSTRAINT `fk_admin_users_site_id` FOREIGN KEY (`site_id`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb3;

--
-- Table structure for table `agents`
--
CREATE TABLE `agents` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `username` varchar(191) NOT NULL,
    `role_id` varchar(36) NOT NULL,
    `site_id` int DEFAULT NULL,
    `email` varchar(100) DEFAULT NULL,
    `first_name_english` varchar(100) NOT NULL,
    `first_name_arabic` varchar(100) NOT NULL,
    `last_name_english` varchar(100) DEFAULT NULL,
    `last_name_arabic` varchar(100) DEFAULT NULL,
    `mobile_number` varchar(20) DEFAULT NULL,
    `image` varchar(255) DEFAULT NULL,
    `is_active` tinyint DEFAULT '1',
    `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `deleted_at` timestamp NULL DEFAULT NULL,
    `created_by` varchar(36) DEFAULT NULL,
    `updated_by` varchar(36) DEFAULT NULL,
    `deleted_by` varchar(36) DEFAULT NULL,
    `last_selected` datetime DEFAULT CURRENT_TIMESTAMP,
    `last_interaction_start_time` datetime DEFAULT NULL,
    `last_interaction_end_time` datetime DEFAULT NULL,
    `is_available` tinyint DEFAULT '0',
    `xmpp_username` varchar(191) DEFAULT NULL,
    `is_smart_assist` tinyint DEFAULT '0',
    PRIMARY KEY (`id`),
    UNIQUE KEY `unique_username` (`username`),
    KEY `fk_users_role_id_idx` (`role_id`),
    KEY `agents_is_active_IDX` (`is_active`, `is_available`) USING BTREE,
    KEY `fk_agents_site_id_idx` (`site_id`),
    CONSTRAINT `fk_agents_role_id` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT `fk_agents_site_id` FOREIGN KEY (`site_id`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1458 DEFAULT CHARSET = utf8mb3;

--
-- Table structure for table `archive`
--
CREATE TABLE `archive` (
    `username` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `server_host` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'xmpp-dev.ace.online',
    `timestamp` bigint unsigned NOT NULL,
    `peer` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `bare_peer` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `xml` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `txt` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `id` bigint unsigned NOT NULL AUTO_INCREMENT,
    `message_id` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
    `kind` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `nick` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `broadcast_id` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    `broadcastmsg_id` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `origin_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    UNIQUE KEY `id` (`id`),
    KEY `i_username` (`username`) USING BTREE,
    KEY `i_peer` (`peer`) USING BTREE,
    KEY `i_bare_peer` (`bare_peer`) USING BTREE,
    KEY `i_archive_sh_username_bare_peer` (
        `server_host`,
        `username`,
        `bare_peer`
    ) USING BTREE,
    KEY `i_archive_sh_timestamp` (`server_host`, `timestamp`) USING BTREE,
    KEY `i_archive_sh_username_timestamp` (
        `server_host`,
        `username`,
        `timestamp`
    ) USING BTREE,
    KEY `i_archive_sh_username_peer` (
        `server_host`,
        `username`,
        `peer`
    ) USING BTREE,
    KEY `i_archive_sh_username_origin_id` (
        `server_host`,
        `username`,
        `origin_id` (191)
    ) USING BTREE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `archive_prefs`
--
CREATE TABLE `archive_prefs` (
    `username` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `server_host` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'xmpp-dev.ace.online',
    `def` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `always` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `never` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`server_host`, `username`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `audit_log`
--
CREATE TABLE `audit_log` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `table_name` varchar(100) NOT NULL,
    `entity_id` varchar(50) NOT NULL,
    `action` enum('CREATE', 'UPDATE', 'DELETE') NOT NULL,
    `changed_by` varchar(255) NOT NULL,
    `old_data` json DEFAULT NULL,
    `new_data` json DEFAULT NULL,
    `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 6232 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

--
-- Table structure for table `bosh`
--
CREATE TABLE `bosh` (
    `sid` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `node` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `pid` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    UNIQUE KEY `i_bosh_sid` (`sid` (75))
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `call_queue`
--
CREATE TABLE `call_queue` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `caller_jid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `to_user` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `room_id` varchar(255) NOT NULL,
    `call_link` varchar(255) DEFAULT NULL,
    `caller_name` varchar(255) DEFAULT NULL,
    `call_time` varchar(255) DEFAULT NULL,
    `call_type` varchar(50) DEFAULT NULL,
    `user_domain` varchar(255) DEFAULT NULL,
    `caller_socket_id` varchar(255) DEFAULT NULL,
    `queue_number` int DEFAULT NULL,
    `status` varchar(50) DEFAULT 'PENDING',
    `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    `room_link` varchar(255) DEFAULT NULL,
    `call_status` varchar(50) DEFAULT NULL,
    `call_mode` varchar(50) DEFAULT NULL,
    `behaviour` varchar(50) DEFAULT NULL,
    `called_type` varchar(50) DEFAULT NULL,
    `service_id` int DEFAULT NULL,
    `retries` int DEFAULT '0',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 2202 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

--
-- Table structure for table `call_recordings`
--
CREATE TABLE `call_recordings` (
    `id` int NOT NULL AUTO_INCREMENT,
    `room_id` varchar(245) NOT NULL,
    `username` varchar(245) NOT NULL,
    `pod_name` varchar(245) NOT NULL,
    `file_path` varchar(245) DEFAULT NULL,
    `thumbimage` varchar(245) DEFAULT NULL,
    `record_path` varchar(245) NOT NULL,
    `record_stop_by` varchar(245) DEFAULT NULL,
    `duration` int DEFAULT NULL,
    `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `record_file` varchar(245) DEFAULT NULL,
    `is_pod_deleted` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
    `record_ended` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
    `local_video_deleted` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 324 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

--
-- Table structure for table `caps_features`
--
CREATE TABLE `caps_features` (
    `node` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `subnode` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `feature` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    KEY `i_caps_features_node_subnode` (`node` (75), `subnode` (75))
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `chat_access_tokens`
--
CREATE TABLE `chat_access_tokens` (
    `id` int unsigned NOT NULL AUTO_INCREMENT,
    `jid` varchar(191) DEFAULT NULL,
    `username` varchar(191) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
    `token` varchar(2048) DEFAULT NULL,
    `token_expiry_time` varchar(255) DEFAULT NULL,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `scopes` varchar(255) DEFAULT NULL,
    `device_type` varchar(255) DEFAULT NULL,
    `device_id` varchar(40) DEFAULT NULL,
    `client_ip` varchar(255) DEFAULT NULL,
    `remember_token` varchar(255) DEFAULT NULL,
    `user_id` int DEFAULT NULL,
    `refresh_token` varchar(2048) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `chat_access_tokens_index1` (`token`)
) ENGINE = InnoDB AUTO_INCREMENT = 24071 DEFAULT CHARSET = latin1;

--
-- Table structure for table `chat_data_export`
--
CREATE TABLE `chat_data_export` (
    `id` int NOT NULL AUTO_INCREMENT,
    `username` varchar(100) NOT NULL,
    `start_date` date NOT NULL,
    `end_date` date NOT NULL,
    `chat_type` varchar(10) NOT NULL COMMENT 'possible values single/group/all',
    `export_type` varchar(5) NOT NULL COMMENT 'possible values csv/json',
    `request_id` varchar(150) NOT NULL,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `status` varchar(10) NOT NULL COMMENT 'possible values queued/inprogress/completed/failed',
    `file_token` varchar(200) DEFAULT NULL,
    `count` bigint DEFAULT NULL,
    `started_at` timestamp NULL DEFAULT NULL,
    `ended_at` timestamp NULL DEFAULT NULL,
    `error_log` text,
    `license_key` varchar(200) NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 41 DEFAULT CHARSET = latin1;

--
-- Table structure for table `chat_logs`
--
CREATE TABLE `chat_logs` (
    `id` int NOT NULL AUTO_INCREMENT,
    `username` varchar(194) NOT NULL,
    `device_type` varchar(15) NOT NULL,
    `device_os` varchar(50) NOT NULL,
    `device_model` varchar(50) NOT NULL,
    `app_version` varchar(50) NOT NULL,
    `status` tinyint(1) NOT NULL DEFAULT '0',
    `description` text NOT NULL,
    `file_token` varchar(500) DEFAULT NULL,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` datetime NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = latin1;

--
-- Table structure for table `chat_media_files`
--
CREATE TABLE `chat_media_files` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `file_token` varchar(500) DEFAULT NULL,
    `from_user` varchar(255) DEFAULT NULL,
    `group_id` varchar(255) DEFAULT NULL,
    `mime_type` varchar(255) DEFAULT NULL,
    `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
    `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `broadcast_id` varchar(255) DEFAULT NULL,
    `type` varchar(45) DEFAULT NULL,
    `original_file` varchar(255) DEFAULT NULL,
    `to_users` text,
    `message_id` varchar(500) DEFAULT NULL,
    `file_path` varchar(500) DEFAULT NULL,
    `is_active` int DEFAULT NULL,
    `interaction_id` bigint DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `file_token` (`file_token`),
    KEY `message_id` (`message_id`),
    KEY `type` (`type`),
    KEY `from_user` (`from_user`),
    KEY `chat_media_files_interaction_id_IDX` (`interaction_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 87035 DEFAULT CHARSET = latin1;

--
-- Table structure for table `chat_message_edit_history`
--
CREATE TABLE `chat_message_edit_history` (
    `id` int NOT NULL AUTO_INCREMENT,
    `from_user` varchar(100) DEFAULT NULL,
    `to_user` varchar(100) DEFAULT NULL,
    `chat_type` varchar(10) DEFAULT NULL,
    `message_id` varchar(150) DEFAULT NULL,
    `edit_message_id` varchar(150) DEFAULT NULL,
    `msg` mediumtext,
    `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 13853 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

--
-- Table structure for table `chat_otp`
--
CREATE TABLE `chat_otp` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `otp` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
    `username` varchar(191) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
    `status` int DEFAULT NULL,
    `created_at` datetime DEFAULT NULL,
    `mobile_number` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
    `email_id` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
    `uuid` varchar(255) DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 950 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

--
-- Table structure for table `chat_recent`
--
CREATE TABLE `chat_recent` (
    `id` int NOT NULL AUTO_INCREMENT,
    `from_user` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `to_user` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `message_id` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `message_from` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `notification_to` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `txt` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `chat_type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `message_type` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `status` tinyint NOT NULL DEFAULT '0',
    `favourite_status` tinyint(1) DEFAULT '0',
    `recall_status` tinyint(1) NOT NULL DEFAULT '0',
    `unread` int NOT NULL DEFAULT '0',
    `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `message_time` bigint NOT NULL,
    `mute_status` int NOT NULL DEFAULT '0',
    `archive_status` int NOT NULL DEFAULT '0',
    `meta_data` json DEFAULT NULL,
    `topic_id` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    PRIMARY KEY (`id`),
    UNIQUE KEY `from_to_user` (`from_user`, `to_user`),
    KEY `chat_type` (`chat_type`),
    KEY `archive_status` (`archive_status`),
    KEY `status` (`status`),
    KEY `recall` (`recall_status`),
    KEY `created_at` (`created_at`),
    KEY `to_user` (`to_user`)
) ENGINE = InnoDB AUTO_INCREMENT = 161187 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `chat_recent_topic`
--

CREATE TABLE `chat_recent_topic` (
    `id` int NOT NULL AUTO_INCREMENT,
    `from_user` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `to_user` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `message_id` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `message_from` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `notification_to` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `txt` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `chat_type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `message_type` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `broadcast_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
    `broadcast_msg_id` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
    `status` tinyint NOT NULL DEFAULT '0',
    `favourite_status` tinyint(1) DEFAULT '0',
    `recall_status` tinyint(1) NOT NULL DEFAULT '0',
    `unread` int NOT NULL DEFAULT '0',
    `topic_id` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `message_time` bigint NOT NULL,
    `mute_status` int NOT NULL DEFAULT '0',
    `archive_status` int NOT NULL DEFAULT '0',
    `meta_data` json DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `from_to_user` (
        `from_user`,
        `to_user`,
        `topic_id`
    ),
    KEY `topic_id` (`topic_id`),
    KEY `recent_index` (`to_user`),
    KEY `chat_type` (`chat_type`)
) ENGINE = InnoDB AUTO_INCREMENT = 227 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `chat_servers`
--

CREATE TABLE `chat_servers` (
    `id` int NOT NULL AUTO_INCREMENT,
    `config_id` int DEFAULT NULL,
    `url` varchar(300) DEFAULT NULL,
    `username` varchar(45) DEFAULT NULL,
    `password` varchar(45) DEFAULT NULL,
    `is_turn` int DEFAULT '0',
    `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 7 DEFAULT CHARSET = latin1;

--
-- Table structure for table `chat_settings`
--

CREATE TABLE `chat_settings` (
    `id` int NOT NULL AUTO_INCREMENT,
    `domain` varchar(50) NOT NULL,
    `license_key` varchar(255) DEFAULT NULL,
    `license_expiry` datetime DEFAULT NULL,
    `admin_user` varchar(50) NOT NULL,
    `mail_login` varchar(3) NOT NULL,
    `video_limit` int NOT NULL,
    `audio_limit` int NOT NULL,
    `recall_time` int NOT NULL,
    `private_time` int NOT NULL,
    `status` tinyint NOT NULL,
    `feedback_from` varchar(25) NOT NULL,
    `feedback_to` varchar(30) NOT NULL,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `xmpp_server` varchar(200) DEFAULT NULL,
    `signal_server` varchar(205) DEFAULT NULL,
    `xmpp_host` varchar(200) DEFAULT NULL,
    `xmpp_domain` varchar(200) DEFAULT NULL,
    `google_translate` varchar(45) DEFAULT NULL,
    `notification_help` varchar(45) DEFAULT NULL,
    `xmpp_port` int DEFAULT NULL,
    `sdk_url` varchar(255) DEFAULT NULL,
    `pin_expire_days` int NOT NULL DEFAULT '0',
    `pin_timeout` int NOT NULL DEFAULT '0',
    `file_size_limit` int NOT NULL,
    `sip_server` varchar(100) DEFAULT NULL,
    `livestreaming_enabled` tinyint(1) DEFAULT '0',
    `livestreaming_signalserver` varchar(255) DEFAULT NULL,
    `sipcall_enabled` tinyint(1) DEFAULT '0',
    `chat_backup_type` varchar(45) DEFAULT NULL,
    `chat_backup_frequency` varchar(45) DEFAULT NULL,
    `call_routing_server` varchar(100) DEFAULT NULL,
    `settings` int DEFAULT '1',
    `xmpp_port_web` varchar(6) DEFAULT NULL,
    `iv` varchar(50) DEFAULT NULL,
    `iv_profile` varchar(50) DEFAULT NULL,
    `group_chat` tinyint(1) DEFAULT '1',
    `attachment` tinyint(1) DEFAULT '1',
    `image_attachment` tinyint(1) DEFAULT '1',
    `video_attachment` tinyint(1) DEFAULT '1',
    `audio_attachment` tinyint(1) DEFAULT '1',
    `document_attachment` tinyint(1) DEFAULT '1',
    `contact_attachment` tinyint(1) DEFAULT '1',
    `location_attachment` tinyint(1) DEFAULT '1',
    `one2one_call` tinyint(1) DEFAULT '1',
    `group_call` tinyint(1) DEFAULT '1',
    `recentchat_search` tinyint(1) DEFAULT '1',
    `star_message` tinyint(1) DEFAULT '1',
    `clear_chat` tinyint(1) DEFAULT '1',
    `delete_chat` tinyint(1) DEFAULT '1',
    `translation` tinyint(1) DEFAULT '1',
    `block` tinyint(1) DEFAULT '1',
    `report` tinyint(1) DEFAULT '1',
    `delete_message` tinyint(1) DEFAULT '1',
    `view_all_medias` tinyint(1) DEFAULT '1',
    `chat_history` tinyint(1) DEFAULT '1',
    `call_reconnection_time_out` int DEFAULT '60',
    `call_retries` int DEFAULT '1',
    `call_invite_limit` int DEFAULT '50',
    `log_domain` varchar(150) DEFAULT NULL,
    `long_call_alert_roles` varchar(500) DEFAULT 'Supervisor',
    PRIMARY KEY (`id`),
    KEY `license_key` (`license_key`)
) ENGINE = InnoDB AUTO_INCREMENT = 2793 DEFAULT CHARSET = latin1;

--
-- Table structure for table `chat_users`
--

CREATE TABLE `chat_users` (
    `username` varchar(191) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
    `email` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
    `name` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
    `status_msg` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
    `device_token` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
    `country_code` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
    `mobile_number` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
    `resource` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
    `mode` int DEFAULT '0',
    `notification` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
    `image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
    `device_type` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
    `status` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
    `created_at` timestamp NULL DEFAULT NULL,
    `is_block` int NOT NULL DEFAULT '0',
    `device_os_version` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
    `voip_device_token` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
    `license_key` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
    `user_identifier` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
    `archive` int NOT NULL DEFAULT '1',
    `contact_permission` int NOT NULL DEFAULT '1',
    `is_delete_inprogrees` int NOT NULL DEFAULT '0',
    `metadata` json DEFAULT NULL,
    PRIMARY KEY (`username`),
    KEY `License` (`license_key`),
    KEY `device_token` (`device_token`),
    KEY `device_type` (`device_type`),
    KEY `identifier` (`user_identifier`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb3 COLLATE = utf8mb3_unicode_ci;

--
-- Table structure for table `chat_users_details`
--

CREATE TABLE `chat_users_details` (
    `id` int NOT NULL AUTO_INCREMENT,
    `username` varchar(200) NOT NULL,
    `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
    `device_id` varchar(50) DEFAULT '',
    `device_token` varchar(500) DEFAULT '',
    `voip_device_token` varchar(500) DEFAULT '',
    `mode` tinyint(1) DEFAULT '0',
    `device_type` varchar(10) DEFAULT '',
    `device_os_version` varchar(15) DEFAULT '',
    `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
    `last_logged_in_at` datetime DEFAULT CURRENT_TIMESTAMP,
    `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
    `user_type` varchar(5) NOT NULL DEFAULT 'U',
    `push_server_type` varchar(5) DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `username` (`username`),
    KEY `device_id` (`device_id`),
    KEY `password` (`password`),
    KEY `idx_last_logged_in_at` (`last_logged_in_at`) USING BTREE,
    KEY `idx_username_last_logged_in_at` (
        `username`,
        `last_logged_in_at`
    ) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 73330 DEFAULT CHARSET = latin1;

--
-- Table structure for table `client_call_logs`
--

CREATE TABLE `client_call_logs` (
    `id` int NOT NULL AUTO_INCREMENT,
    `room_id` varchar(100) NOT NULL,
    `created_user` varchar(255) NOT NULL,
    `from_user` varchar(255) NOT NULL,
    `to_user` varchar(255) NOT NULL,
    `user_list` text,
    `invite_user_list` text,
    `call_type` varchar(45) DEFAULT NULL,
    `call_mode` varchar(45) DEFAULT NULL,
    `group_id` varchar(255) DEFAULT NULL,
    `caller_device` varchar(45) DEFAULT NULL,
    `session_status` varchar(100) DEFAULT NULL,
    `start_time` varchar(100) NOT NULL DEFAULT '0',
    `end_time` varchar(100) NOT NULL DEFAULT '0',
    `call_time` varchar(100) NOT NULL DEFAULT '0',
    `call_state` tinyint(1) DEFAULT NULL,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `deleted_at` timestamp NULL DEFAULT NULL,
    `metadata` json DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `room_id` (`room_id`),
    KEY `created_user` (`created_user`)
) ENGINE = InnoDB AUTO_INCREMENT = 46989 DEFAULT CHARSET = latin1;

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `name` varchar(191) NOT NULL,
    `nin` varchar(191) DEFAULT NULL,
    `mobile_no` varchar(15) DEFAULT NULL,
    `email` varchar(100) DEFAULT NULL,
    `sign_language` tinyint DEFAULT '0',
    `confidentiality_agreement` tinyint DEFAULT '0',
    `preferred_language` varchar(50) DEFAULT 'en',
    `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 10393 DEFAULT CHARSET = utf8mb3;

--
-- Table structure for table `deleted_accounts`
--

CREATE TABLE `deleted_accounts` (
    `id` int NOT NULL AUTO_INCREMENT,
    `username` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `reason` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `feedback` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 741 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `feedback`
--

CREATE TABLE `feedback` (
    `id` int NOT NULL AUTO_INCREMENT,
    `username` varchar(194) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `feeback_id` int DEFAULT NULL,
    `device_type` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `device_os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `device_model` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `app_version` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `status` tinyint(1) DEFAULT '0',
    `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `image` longblob,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 1094 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `group_update`
--

CREATE TABLE `group_update` (
    `groupid` varchar(191) NOT NULL,
    `update_count` int NOT NULL DEFAULT '0',
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`groupid`),
    KEY `groupid` (`groupid`)
) ENGINE = InnoDB DEFAULT CHARSET = latin1;

--
-- Table structure for table `interactions`
--

CREATE TABLE `interactions` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `customer_id` bigint NOT NULL,
    `service_group_id` int NOT NULL,
    `type` varchar(10) NOT NULL,
    `start_time` timestamp NULL DEFAULT NULL,
    `end_time` timestamp NULL DEFAULT NULL,
    `status` varchar(50) DEFAULT NULL,
    `user_left_time` timestamp NULL DEFAULT NULL,
    `call_timeout` timestamp NULL DEFAULT NULL,
    `lobby_leaving_reason` json DEFAULT NULL,
    `room_id` varchar(255) DEFAULT NULL,
    `call_link` varchar(255) DEFAULT NULL,
    `user_domain` varchar(255) DEFAULT NULL,
    `caller_socket_id` varchar(255) DEFAULT NULL,
    `room_link` varchar(255) DEFAULT NULL,
    `call_status` varchar(50) DEFAULT NULL,
    `retries` int DEFAULT '0',
    `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `call_duration` bigint GENERATED ALWAYS AS (
        timestampdiff(
            SECOND,
            `start_time`,
            `end_time`
        )
    ) VIRTUAL,
    `has_visited_feedback_page` tinyint DEFAULT '0',
    `visit_source` varchar(20) DEFAULT NULL,
    `device_information` json DEFAULT NULL,
    `has_visited_lobby_leave_page` tinyint DEFAULT '0',
    `call_ended_by` varchar(20) DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `fk_interactions_service_group_id_idx` (`service_group_id`),
    KEY `fk_interactions_customer_id_idx` (`customer_id`),
    KEY `interactions_room_link_IDX` (`room_link`) USING BTREE,
    KEY `interactions_call_status_IDX` (
        `call_status`,
        `status`,
        `service_group_id`
    ) USING BTREE,
    KEY `interactions_service_group_id_IDX` (
        `service_group_id`,
        `start_time`,
        `end_time`
    ) USING BTREE,
    CONSTRAINT `fk_interactions_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT `fk_interactions_service_group_id` FOREIGN KEY (`service_group_id`) REFERENCES `service_groups` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 16611 DEFAULT CHARSET = utf8mb3;

--
-- Table structure for table `interaction_agent_mapping`
--

CREATE TABLE `interaction_agent_mapping` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `interaction_id` bigint DEFAULT NULL,
    `agent_id` bigint DEFAULT NULL,
    `service_group_id` int DEFAULT NULL,
    `call_triggered_at` timestamp NULL DEFAULT NULL,
    `joined_time` timestamp NULL DEFAULT NULL,
    `left_time` timestamp NULL DEFAULT NULL,
    `call_status` varchar(50) DEFAULT NULL,
    `transfer_initiator_id` bigint DEFAULT NULL,
    `transfer_initiated_at` timestamp NULL DEFAULT NULL,
    `transfer_reason` text,
    `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `call_duration` bigint GENERATED ALWAYS AS (
        timestampdiff(
            SECOND,
            `joined_time`,
            `left_time`
        )
    ) VIRTUAL,
    `initiator_id` bigint DEFAULT NULL,
    `initiated_at` timestamp NULL DEFAULT NULL,
    `reason` text,
    `call_mode` varchar(100) DEFAULT 'agent_call',
    `auto_assign_type` varchar(100) DEFAULT 'agent',
    `is_auto_accept` tinyint DEFAULT '0',
    PRIMARY KEY (`id`),
    KEY `fk_interaction_agent_mapping_service_group_id_idx` (`service_group_id`),
    KEY `fk_interaction_agent_mapping_agent_id_idx` (`agent_id`),
    KEY `interaction_agent_mapping_call_status_IDX` (
        `call_status`,
        `service_group_id`
    ) USING BTREE,
    KEY `interaction_agent_mapping_agent_id_IDX` (
        `agent_id`,
        `interaction_id`,
        `call_status`,
        `joined_time`
    ) USING BTREE,
    KEY `interaction_agent_mapping_agent_id_IDX1` (
        `agent_id`,
        `joined_time`,
        `left_time`
    ) USING BTREE,
    KEY `interaction_agent_mapping_interaction_id_IDX` (
        `interaction_id`,
        `call_status`
    ) USING BTREE,
    KEY `iam_call_status_IDX` (`call_status`) USING BTREE,
    CONSTRAINT `fk_interaction_agent_mapping_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `agents` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT `fk_interaction_agent_mapping_interaction_id` FOREIGN KEY (`interaction_id`) REFERENCES `interactions` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT `fk_interaction_agent_mapping_service_group_id` FOREIGN KEY (`service_group_id`) REFERENCES `service_groups` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 26400 DEFAULT CHARSET = utf8mb3;

--
-- Table structure for table `interaction_analysis`
--

CREATE TABLE `interaction_analysis` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `interaction_id` bigint NOT NULL,
    `customer_sentiment` text NOT NULL,
    `customer_sentiment_score` int NOT NULL,
    `agent_sentiment` text NOT NULL,
    `agent_sentiment_score` int NOT NULL,
    `conversation_sentiment` text,
    `sentiment_score` int DEFAULT NULL,
    `main_topic` text,
    `summary_text` text,
    `action` text,
    `action_type` varchar(255) DEFAULT NULL,
    `transcript` text,
    `summary` text,
    `type` varchar(255) DEFAULT NULL,
    `response_quality` text,
    `next_step` text,
    `domain` varchar(255) DEFAULT NULL,
    `subdomain` varchar(255) DEFAULT NULL,
    `agent_performance` text,
    `customer_emotional_state` text,
    `problem_status` text,
    `resolution_details` text,
    `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `agent_evaluation` json DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `interaction_id_UNIQUE` (`interaction_id`),
    KEY `fk_interaction_analysis_interaction_id_idx` (`interaction_id`),
    KEY `idx_customer_sentiment` (`customer_sentiment` (100)),
    CONSTRAINT `fk_interaction_analysis_interaction_id` FOREIGN KEY (`interaction_id`) REFERENCES `interactions` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 3210 DEFAULT CHARSET = utf8mb3;

--
-- Table structure for table `interaction_feedback`
--

CREATE TABLE `interaction_feedback` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `interaction_id` bigint NOT NULL,
    `feedback_type` varchar(100) NOT NULL,
    `agent_id` bigint DEFAULT NULL,
    `customer_id` bigint DEFAULT NULL,
    `feedback_question_english` text NOT NULL,
    `feedback_question_arabic` text,
    `feedback_rating` int NOT NULL,
    `feedback_comments_english` text,
    `feedback_comments_arabic` text,
    `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `fk_interaction_feedback_agent_id_idx` (`agent_id`),
    KEY `fk_interaction_feedback_customer_id_idx` (`customer_id`),
    KEY `interaction_feedback_interaction_id_IDX` (
        `interaction_id`,
        `customer_id`
    ) USING BTREE,
    KEY `if_interaction_id_agent_id_IDX` (`interaction_id`, `agent_id`) USING BTREE,
    CONSTRAINT `fk_interaction_feedback_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `agents` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT `fk_interaction_feedback_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT `fk_interaction_feedback_interaction_id` FOREIGN KEY (`interaction_id`) REFERENCES `interactions` (`id`) ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 6018 DEFAULT CHARSET = utf8mb3;

--
-- Table structure for table `interaction_log`
--

CREATE TABLE `interaction_log` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `interaction_id` bigint DEFAULT NULL,
    `log_type` varchar(100) DEFAULT NULL,
    `transcript` text,
    `recording_url` varchar(255) DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb3;

--
-- Table structure for table `irc_custom`
--

CREATE TABLE `irc_custom` (
    `jid` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `host` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY `i_irc_custom_jid_host` (`jid` (75), `host` (75)) USING BTREE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `last`
--

CREATE TABLE `last` (
    `username` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `server_host` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'xmpp-dev.ace.online',
    `status` tinyint NOT NULL DEFAULT '0',
    `seconds` int NOT NULL,
    `presence` tinyint(1) NOT NULL DEFAULT '0',
    `state` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`server_host`, `username`),
    KEY `seconds` (`seconds`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `license_lookup`
--

CREATE TABLE `license_lookup` (
    `id` int NOT NULL AUTO_INCREMENT,
    `lkey` text NOT NULL,
    `flag` int NOT NULL DEFAULT '0',
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 5 DEFAULT CHARSET = latin1;

--
-- Table structure for table `mail_templates`
--

CREATE TABLE `mail_templates` (
    `id` int NOT NULL AUTO_INCREMENT,
    `scenario` varchar(255) NOT NULL,
    `template_en` text NOT NULL,
    `template_ar` text NOT NULL,
    `subject_en` varchar(255) NOT NULL,
    `subject_ar` varchar(255) NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 4 DEFAULT CHARSET = utf8mb3;

--
-- Table structure for table `masdr_services`
--

CREATE TABLE `masdr_services` (
    `id` int NOT NULL AUTO_INCREMENT,
    `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
    `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `deleted_at` datetime DEFAULT NULL,
    `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
    `deleted_by` int DEFAULT NULL,
    `created_by` int DEFAULT NULL,
    `updated_by` int DEFAULT NULL,
    `name_arabic` varchar(90) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 4 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `media_call_logs`
--

CREATE TABLE `media_call_logs` (
    `id` int NOT NULL AUTO_INCREMENT,
    `room_id` varchar(100) DEFAULT NULL,
    `room_link` varchar(15) DEFAULT NULL,
    `from_user` varchar(50) DEFAULT NULL,
    `to_user` varchar(50) DEFAULT NULL,
    `call_status` enum(
        'CALLING',
        'ENDED',
        'BUSY',
        'ATTENDED'
    ) DEFAULT NULL,
    `start_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `end_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `called_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `called_type` enum('AUDIO', 'VIDEO') DEFAULT NULL,
    `call_mode` enum('ONETOONE', 'ONETOMANY') DEFAULT NULL,
    `caller_device` varchar(255) DEFAULT NULL,
    `group_id` varchar(255) DEFAULT NULL,
    `behaviour` varchar(10) NOT NULL DEFAULT 'call',
    `metadata` json DEFAULT NULL,
    `masdr_services` int DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `room_link` (`room_link`)
) ENGINE = InnoDB DEFAULT CHARSET = latin1;

--
-- Table structure for table `media_logs`
--

CREATE TABLE `media_logs` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `interaction_id` bigint NOT NULL,
    `room_id` varchar(245) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
    `file_path` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
    `thumbimage` varchar(245) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
    `record_path` varchar(245) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
    `record_stop_by` varchar(245) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
    `duration` int DEFAULT NULL,
    `record_file` varchar(245) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
    `record_ended` tinyint NOT NULL DEFAULT '0',
    `local_video_deleted` tinyint NOT NULL DEFAULT '0',
    `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
    `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
    `video_conversion_status` varchar(245) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `interaction_id_UNIQUE` (`interaction_id`),
    KEY `media_logs_interaction_id_IDX` (`interaction_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7773 DEFAULT CHARSET = utf8mb3 COLLATE = utf8mb3_unicode_ci;

--
-- Table structure for table `media_pod_logs`
--

CREATE TABLE `media_pod_logs` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `media_logs_id` bigint NOT NULL,
    `pod_name` varchar(245) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
    `is_pod_deleted` tinyint NOT NULL DEFAULT '0',
    `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
    `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `fk_media_pod_logs_media_logs_id_idx` (`media_logs_id`),
    CONSTRAINT `fk_media_pod_logs_media_logs_id` FOREIGN KEY (`media_logs_id`) REFERENCES `media_logs` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 5600 DEFAULT CHARSET = utf8mb3 COLLATE = utf8mb3_unicode_ci;

--
-- Table structure for table `message_favourite`
--

CREATE TABLE `message_favourite` (
    `id` int NOT NULL AUTO_INCREMENT,
    `favourite_user` varchar(180) NOT NULL,
    `message_id` varchar(150) NOT NULL,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `idx_message_favourite` (
        `favourite_user`,
        `message_id`
    ),
    KEY `to_user` (`favourite_user`),
    KEY `message_id` (`message_id`),
    KEY `created_at` (`created_at`)
) ENGINE = InnoDB AUTO_INCREMENT = 3913 DEFAULT CHARSET = latin1;

--
-- Table structure for table `message_status`
--

CREATE TABLE `message_status` (
    `id` int NOT NULL AUTO_INCREMENT,
    `from_user` varchar(100) NOT NULL,
    `to_user` varchar(100) NOT NULL,
    `message_id` varchar(150) NOT NULL,
    `message_type` varchar(10) NOT NULL DEFAULT '0',
    `chat_type` varchar(10) NOT NULL,
    `status` tinyint NOT NULL DEFAULT '0',
    `recent` tinyint NOT NULL DEFAULT '0',
    `recall_status` tinyint unsigned NOT NULL DEFAULT '0',
    `favourite_status` tinyint NOT NULL DEFAULT '0',
    `favourite_by` varchar(191) NOT NULL DEFAULT '0',
    `favourite_date` datetime DEFAULT NULL,
    `deleted_status` tinyint NOT NULL DEFAULT '0',
    `deleted_by` varchar(191) NOT NULL DEFAULT '0',
    `blocked` varchar(250) NOT NULL DEFAULT '0',
    `from_notification` varchar(191) NOT NULL,
    `to_notification` varchar(100) NOT NULL,
    `message_notification` int NOT NULL,
    `txt` mediumtext NOT NULL,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `received_at` datetime NOT NULL,
    `seen_at` datetime NOT NULL,
    `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `message_time` bigint NOT NULL,
    `meta_data` json DEFAULT NULL,
    `edit_message_id` varchar(150) NOT NULL,
    `topic_id` varchar(45) NOT NULL DEFAULT '',
    `edit_status` tinyint NOT NULL DEFAULT '0',
    `interaction_id` bigint DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `unique_index` (
        `message_id`,
        `from_user`,
        `to_user`,
        `id`
    ),
    KEY `deleted_by` (`deleted_by`),
    KEY `message_status_msg_id` (`message_id`),
    KEY `from_user_to_user` (`from_user`, `to_user`),
    KEY `to_user` (`to_user`),
    KEY `id_index` (
        `id`,
        `deleted_status`,
        `deleted_by`,
        `blocked`,
        `from_user`,
        `to_user`
    ),
    KEY `created_at` (`created_at`),
    KEY `message_notification` (`message_notification`),
    KEY `blocked` (`blocked`),
    KEY `deleted_status` (`deleted_status`),
    KEY `recall_status` (`recall_status`),
    KEY `favourite_by` (`favourite_by`),
    KEY `favourite_status` (`favourite_status`)
) ENGINE = InnoDB AUTO_INCREMENT = 20122 DEFAULT CHARSET = latin1;

--
-- Table structure for table `migration_file_details`
--

CREATE TABLE `migration_file_details` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `username` varchar(200) NOT NULL,
    `file_token` varchar(200) NOT NULL,
    `filename` varchar(200) NOT NULL,
    `status` varchar(10) NOT NULL,
    `total` int DEFAULT '0',
    `processed` int DEFAULT '0',
    `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    `started_at` timestamp NULL DEFAULT NULL,
    `completed_at` timestamp NULL DEFAULT NULL,
    `error_log` text,
    `validation_errors` longtext,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 12 DEFAULT CHARSET = latin1;

--
-- Table structure for table `mix_channel`
--

CREATE TABLE `mix_channel` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `channel` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `service` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `username` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `domain` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `jid` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `hidden` tinyint(1) NOT NULL,
    `hmac_key` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `license_key` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `metadata` json DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `i_mix_channel_serv` (`service` (191)),
    KEY `i_mix_channel` (`channel`)
) ENGINE = InnoDB AUTO_INCREMENT = 13777 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `mix_pam`
--

CREATE TABLE `mix_pam` (
    `pam_id` bigint NOT NULL AUTO_INCREMENT,
    `username` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `server_host` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'xmpp-dev.ace.online',
    `channel` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `service` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `affiliation` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `is_block` int NOT NULL DEFAULT '0',
    PRIMARY KEY (`pam_id`),
    UNIQUE KEY `i_mix_pam` (
        `username` (191),
        `server_host`,
        `channel`,
        `service` (191)
    ),
    KEY `i_mix_chan_usr` (`channel`, `username` (191))
) ENGINE = InnoDB AUTO_INCREMENT = 57403 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `mix_participant`
--

CREATE TABLE `mix_participant` (
    `participant_id` bigint NOT NULL AUTO_INCREMENT,
    `channel` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `service` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `username` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `domain` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `jid` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `nick` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`participant_id`),
    UNIQUE KEY `i_mix_participant` (
        `channel` (191),
        `service` (191),
        `username` (191),
        `domain` (191)
    ),
    KEY `i_mix_chan_usr` (
        `channel` (191),
        `username` (191)
    )
) ENGINE = InnoDB AUTO_INCREMENT = 59961 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `mix_subscription`
--

CREATE TABLE `mix_subscription` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `channel` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `service` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `username` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `domain` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `node` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `jid` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `i_mix_subscription` (
        `channel` (153),
        `service` (153),
        `username` (153),
        `domain` (153),
        `node` (153)
    ),
    KEY `i_mix_subscription_chan_serv_node` (
        `channel` (191),
        `service` (191),
        `node` (191)
    )
) ENGINE = InnoDB AUTO_INCREMENT = 137538 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `motd`
--

CREATE TABLE `motd` (
    `username` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `server_host` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'xmpp-dev.ace.online',
    `xml` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`server_host`, `username`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `mqtt_pub`
--

CREATE TABLE `mqtt_pub` (
    `username` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `server_host` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'xmpp-dev.ace.online',
    `resource` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `topic` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `qos` tinyint NOT NULL,
    `payload` blob NOT NULL,
    `payload_format` tinyint NOT NULL,
    `content_type` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `response_topic` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `correlation_data` blob NOT NULL,
    `user_properties` blob NOT NULL,
    `expiry` int unsigned NOT NULL,
    UNIQUE KEY `i_mqtt_topic_server` (`topic` (191), `server_host`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `muc_online_room`
--

CREATE TABLE `muc_online_room` (
    `name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `host` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `server_host` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'xmpp-dev.ace.online',
    `node` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `pid` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    UNIQUE KEY `i_muc_online_room_name_host` (`name` (75), `host` (75)) USING BTREE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `muc_online_users`
--

CREATE TABLE `muc_online_users` (
    `username` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `server` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `resource` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `host` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `server_host` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'xmpp-dev.ace.online',
    `node` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    UNIQUE KEY `i_muc_online_users` (
        `username` (75),
        `server` (75),
        `resource` (75),
        `name` (75),
        `host` (75)
    ) USING BTREE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `muc_registered`
--

CREATE TABLE `muc_registered` (
    `jid` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `host` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `server_host` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'xmpp-dev.ace.online',
    `nick` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY `i_muc_registered_jid_host` (`jid` (75), `host` (75)) USING BTREE,
    KEY `i_muc_registered_nick` (`nick` (75)) USING BTREE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `muc_room`
--

CREATE TABLE `muc_room` (
    `name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `host` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `server_host` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'xmpp-dev.ace.online',
    `opts` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY `i_muc_room_name_host` (`name` (75), `host` (75)) USING BTREE,
    KEY `i_muc_room_host_created_at` (`host` (75), `created_at`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `muc_room_subscribers`
--

CREATE TABLE `muc_room_subscribers` (
    `room` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `host` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `jid` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `nick` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `nodes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY `i_muc_room_subscribers_host_room_jid` (`host`, `room`, `jid`),
    KEY `i_muc_room_subscribers_host_jid` (`host`, `jid`) USING BTREE,
    KEY `i_muc_room_subscribers_jid` (`jid`) USING BTREE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `oauth_client`
--

CREATE TABLE `oauth_client` (
    `client_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `client_name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `grant_type` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `options` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`client_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `oauth_token`
--

CREATE TABLE `oauth_token` (
    `token` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `jid` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `scope` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `expire` bigint NOT NULL,
    PRIMARY KEY (`token`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `privacy_default_list`
--

CREATE TABLE `privacy_default_list` (
    `username` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `server_host` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'xmpp-dev.ace.online',
    `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`server_host`, `username`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `privacy_list`
--

CREATE TABLE `privacy_list` (
    `username` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `server_host` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'xmpp-dev.ace.online',
    `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `id` bigint unsigned NOT NULL AUTO_INCREMENT,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY `id` (`id`),
    UNIQUE KEY `i_privacy_list_sh_username_name` (
        `server_host`,
        `username` (75),
        `name` (75)
    ) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 316 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `privacy_list_data`
--

CREATE TABLE `privacy_list_data` (
    `id` bigint DEFAULT NULL,
    `t` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `action` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `ord` decimal(10, 0) NOT NULL,
    `match_all` tinyint(1) NOT NULL,
    `match_iq` tinyint(1) NOT NULL,
    `match_message` tinyint(1) NOT NULL,
    `match_presence_in` tinyint(1) NOT NULL,
    `match_presence_out` tinyint(1) NOT NULL,
    KEY `i_privacy_list_data_id` (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `private_storage`
--

CREATE TABLE `private_storage` (
    `username` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `server_host` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'xmpp-dev.ace.online',
    `namespace` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (
        `server_host`,
        `username`,
        `namespace`
    )
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `proxy65`
--

CREATE TABLE `proxy65` (
    `sid` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `pid_t` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `pid_i` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `node_t` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `node_i` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `jid_i` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    UNIQUE KEY `i_proxy65_sid` (`sid` (191)),
    KEY `i_proxy65_jid` (`jid_i` (191))
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `pubsub_item`
--

CREATE TABLE `pubsub_item` (
    `nodeid` bigint DEFAULT NULL,
    `itemid` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `publisher` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `creation` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `modification` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `payload` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `message_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `timestamp` bigint unsigned NOT NULL,
    UNIQUE KEY `i_pubsub_item_tuple` (`nodeid`, `itemid` (36)),
    KEY `i_pubsub_item_itemid` (`itemid` (36)),
    KEY `pubsub_msg_id_index` (`message_id`),
    CONSTRAINT `pubsub_item_ibfk_1` FOREIGN KEY (`nodeid`) REFERENCES `pubsub_node` (`nodeid`) ON DELETE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `pubsub_node`
--

CREATE TABLE `pubsub_node` (
    `host` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `node` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `parent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `plugin` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `type` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `nodeid` bigint NOT NULL AUTO_INCREMENT,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`nodeid`),
    UNIQUE KEY `i_pubsub_node_tuple` (`host` (20), `node` (120)),
    KEY `i_pubsub_node_parent` (`parent` (120))
) ENGINE = InnoDB AUTO_INCREMENT = 13275 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `pubsub_node_option`
--

CREATE TABLE `pubsub_node_option` (
    `nodeid` bigint DEFAULT NULL,
    `name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `val` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    KEY `i_pubsub_node_option_nodeid` (`nodeid`),
    CONSTRAINT `pubsub_node_option_ibfk_1` FOREIGN KEY (`nodeid`) REFERENCES `pubsub_node` (`nodeid`) ON DELETE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `pubsub_node_owner`
--

CREATE TABLE `pubsub_node_owner` (
    `nodeid` bigint DEFAULT NULL,
    `owner` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    KEY `i_pubsub_node_owner_nodeid` (`nodeid`),
    CONSTRAINT `pubsub_node_owner_ibfk_1` FOREIGN KEY (`nodeid`) REFERENCES `pubsub_node` (`nodeid`) ON DELETE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `pubsub_state`
--

CREATE TABLE `pubsub_state` (
    `nodeid` bigint DEFAULT NULL,
    `jid` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `affiliation` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `subscriptions` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `stateid` bigint NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (`stateid`),
    UNIQUE KEY `i_pubsub_state_tuple` (`nodeid`, `jid` (60)),
    KEY `i_pubsub_state_jid` (`jid` (60)),
    CONSTRAINT `pubsub_state_ibfk_1` FOREIGN KEY (`nodeid`) REFERENCES `pubsub_node` (`nodeid`) ON DELETE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 48363 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `pubsub_subscription_opt`
--

CREATE TABLE `pubsub_subscription_opt` (
    `subid` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `opt_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `opt_value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    UNIQUE KEY `i_pubsub_subscription_opt` (`subid` (32), `opt_name`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `push_session`
--

CREATE TABLE `push_session` (
    `username` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `server_host` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'xmpp-dev.ace.online',
    `timestamp` bigint NOT NULL,
    `service` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `node` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `xml` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (
        `server_host`,
        `username` (191),
        `timestamp`
    ),
    UNIQUE KEY `i_push_session_susn` (
        `server_host`,
        `username` (191),
        `service` (191),
        `node` (191)
    ),
    KEY `i_push_session_sh_username_timestamp` (
        `server_host`,
        `username` (191),
        `timestamp`
    )
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `reports`
--

CREATE TABLE `reports` (
    `id` int NOT NULL AUTO_INCREMENT,
    `reported` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `serialized_message` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `reported_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 728 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
    `id` varchar(36) NOT NULL,
    `name_english` varchar(60) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
    `name_arabic` varchar(60) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
    `description_english` varchar(500) DEFAULT NULL,
    `description_arabic` varchar(500) DEFAULT NULL,
    `is_active` tinyint DEFAULT '1',
    `is_editable` tinyint DEFAULT '0',
    `created_at` timestamp NULL DEFAULT NULL,
    `updated_at` timestamp NULL DEFAULT NULL,
    `created_by` varchar(36) DEFAULT NULL,
    `updated_by` varchar(36) DEFAULT NULL,
    `deleted_by` varchar(36) DEFAULT NULL,
    `deleted_at` timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `unique_roles_name` (`name_english`),
    UNIQUE KEY `unique_roles_name_arabic` (`name_arabic`),
    KEY `fk_roles_created_by_idx` (`created_by`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb3 COMMENT = 'To store the user roles';

--
-- Table structure for table `rostergroups`
--

CREATE TABLE `rostergroups` (
    `username` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `server_host` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'xmpp-dev.ace.online',
    `jid` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `grp` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    KEY `i_rosterg_sh_user_jid` (
        `server_host`,
        `username` (75),
        `jid` (75)
    )
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `rosterusers`
--

CREATE TABLE `rosterusers` (
    `username` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `server_host` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'xmpp-dev.ace.online',
    `jid` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `jid_username` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `nick` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `subscription` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `ask` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `askmessage` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `server` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `subscribe` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `type` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    `license_key` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    UNIQUE KEY `i_rosteru_sh_user_jid` (
        `server_host`,
        `username` (75),
        `jid` (75)
    ),
    KEY `jid_username` (`jid_username`),
    KEY `i_rosteru_sh_jid` (`server_host`, `jid`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `roster_version`
--

CREATE TABLE `roster_version` (
    `username` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `server_host` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'xmpp-dev.ace.online',
    `version` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`server_host`, `username`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `route`
--

CREATE TABLE `route` (
    `domain` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `server_host` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `node` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `pid` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `local_hint` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    UNIQUE KEY `i_route` (
        `domain` (75),
        `server_host` (75),
        `node` (75),
        `pid` (75)
    )
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `service_groups`
--

CREATE TABLE `service_groups` (
    `id` int NOT NULL AUTO_INCREMENT,
    `name_english` varchar(60) NOT NULL,
    `slug` varchar(100) NOT NULL,
    `name_arabic` varchar(60) NOT NULL,
    `description_english` varchar(250) DEFAULT NULL,
    `description_arabic` varchar(250) DEFAULT NULL,
    `site_name` varchar(100) DEFAULT NULL,
    `is_parent` tinyint DEFAULT '1',
    `parent_id` int DEFAULT NULL,
    `is_active` tinyint DEFAULT '1',
    `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `deleted_at` timestamp NULL DEFAULT NULL,
    `created_by` varchar(36) DEFAULT NULL,
    `updated_by` varchar(36) DEFAULT NULL,
    `deleted_by` varchar(36) DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `slug_UNIQUE` (`slug`),
    KEY `fk_service_groups_parent_id_idx` (`parent_id`),
    KEY `service_groups_parent_id_IDX` (
        `parent_id`,
        `is_parent`,
        `deleted_at`
    ) USING BTREE,
    CONSTRAINT `fk_service_groups_parent_id` FOREIGN KEY (`parent_id`) REFERENCES `service_groups` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 223 DEFAULT CHARSET = utf8mb3 COMMENT = 'To store service group information under sites and tenants.';

--
-- Table structure for table `service_group_kpis`
--

CREATE TABLE `service_group_kpis` (
    `id` int NOT NULL AUTO_INCREMENT,
    `service_group_id` int NOT NULL,
    `name` varchar(255) NOT NULL,
    `description` text NOT NULL,
    `value` varchar(10) DEFAULT NULL,
    `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `created_by` varchar(36) DEFAULT NULL,
    `updated_by` varchar(36) DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `fk_kpis_service_group_id` (`service_group_id`),
    KEY `service_group_kpis_service_group_id_IDX` (`service_group_id`, `name`) USING BTREE,
    CONSTRAINT `fk_kpis_service_group_id` FOREIGN KEY (`service_group_id`) REFERENCES `service_groups` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 151 DEFAULT CHARSET = utf8mb3 COMMENT = 'Stores KPI values for service groups.';

--
-- Table structure for table `service_group_members`
--

CREATE TABLE `service_group_members` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `agent_id` bigint NOT NULL,
    `service_group_id` int NOT NULL,
    `assigned_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    `transferred_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `removed_at` timestamp NULL DEFAULT NULL,
    `assigned_by` varchar(36) DEFAULT NULL,
    `transferred_by` varchar(36) DEFAULT NULL,
    `removed_by` varchar(36) DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `unique_user_service_group` (
        `agent_id`,
        `service_group_id`
    ),
    KEY `fk_sgm_service_group_id` (`service_group_id`),
    CONSTRAINT `fk_service_group_members_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `agents` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT `fk_sgm_service_group_id` FOREIGN KEY (`service_group_id`) REFERENCES `service_groups` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1374 DEFAULT CHARSET = utf8mb3;

--
-- Table structure for table `service_group_messages`
--

CREATE TABLE `service_group_messages` (
    `id` int NOT NULL AUTO_INCREMENT,
    `service_group_id` int NOT NULL,
    `language` enum('English', 'Arabic') NOT NULL,
    `message` text NOT NULL,
    `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `created_by` varchar(36) DEFAULT NULL,
    `updated_by` varchar(36) DEFAULT NULL,
    `name` varchar(255) NOT NULL,
    `description` text NOT NULL,
    PRIMARY KEY (`id`),
    KEY `fk_messages_service_group_id` (`service_group_id`),
    CONSTRAINT `fk_messages_service_group_id` FOREIGN KEY (`service_group_id`) REFERENCES `service_groups` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 9 DEFAULT CHARSET = utf8mb3 COMMENT = 'Stores messages for service groups outside working hours.';

--
-- Table structure for table `service_group_working_days`
--

CREATE TABLE `service_group_working_days` (
    `id` int NOT NULL AUTO_INCREMENT,
    `service_group_id` int NOT NULL,
    `days` enum(
        'Monday',
        'Tuesday',
        'Wednesday',
        'Thursday',
        'Friday',
        'Saturday',
        'Sunday'
    ) NOT NULL,
    `start_time` time NOT NULL DEFAULT '00:00:01',
    `end_time` time NOT NULL,
    `break_time` time DEFAULT '01:00:00',
    `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `created_by` varchar(36) DEFAULT NULL,
    `updated_by` varchar(36) DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `fk_working_days_service_group_id` (`service_group_id`),
    CONSTRAINT `fk_working_days_service_group_id` FOREIGN KEY (`service_group_id`) REFERENCES `service_groups` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 310 DEFAULT CHARSET = utf8mb3 COMMENT = 'Stores the working days of service groups.';

--
-- Table structure for table `sites`
--

CREATE TABLE `sites` (
    `id` int NOT NULL AUTO_INCREMENT,
    `name_english` varchar(100) NOT NULL,
    `name_arabic` varchar(100) NOT NULL,
    `description_english` varchar(500) DEFAULT NULL,
    `description_arabic` varchar(500) DEFAULT NULL,
    `is_active` tinyint DEFAULT '1',
    `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `deleted_at` timestamp NULL DEFAULT NULL,
    `created_by` varchar(36) DEFAULT NULL,
    `updated_by` varchar(36) DEFAULT NULL,
    `deleted_by` varchar(36) DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `name_english_UNIQUE` (`name_english`),
    UNIQUE KEY `name_arabic_UNIQUE` (`name_arabic`)
) ENGINE = InnoDB AUTO_INCREMENT = 56 DEFAULT CHARSET = utf8mb3;

--
-- Table structure for table `sm`
--

CREATE TABLE `sm` (
    `usec` bigint NOT NULL,
    `pid` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `node` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `username` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `server_host` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'xmpp-dev.ace.online',
    `resource` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `priority` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`usec`, `pid` (75)),
    KEY `i_sm_node` (`node` (75)),
    KEY `i_sm_sh_username` (`server_host`, `username`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `spool`
--

CREATE TABLE `spool` (
    `username` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `server_host` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'xmpp-dev.ace.online',
    `xml` mediumblob NOT NULL,
    `seq` bigint unsigned NOT NULL AUTO_INCREMENT,
    `message_id` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `chat_type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `message` mediumblob,
    `web_resource` tinyint(1) NOT NULL DEFAULT '0',
    `status` tinyint(1) NOT NULL DEFAULT '0',
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `to_user` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    `device_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    `admin_delivered` tinyint(1) NOT NULL DEFAULT '0',
    UNIQUE KEY `seq` (`seq`),
    KEY `i_spool_created_at` (`created_at`) USING BTREE,
    KEY `i_spool_message_id` (`message_id`),
    KEY `i_spool_sh_username` (`server_host`, `username`) USING BTREE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `sr_group`
--

CREATE TABLE `sr_group` (
    `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `server_host` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'xmpp-dev.ace.online',
    `opts` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY `i_sr_group_sh_name` (`server_host`, `name`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `sr_user`
--

CREATE TABLE `sr_user` (
    `jid` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `server_host` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'xmpp-dev.ace.online',
    `grp` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY `i_sr_user_sh_jid_group` (`server_host`, `jid`, `grp`),
    KEY `i_sr_user_sh_grp` (`server_host`, `grp`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `tenant_configurations`
--

CREATE TABLE `tenant_configurations` (
    `id` int NOT NULL AUTO_INCREMENT,
    `average_customer_rating` varchar(10) DEFAULT NULL,
    `average_call_duration` time DEFAULT NULL,
    `average_waiting_time` time DEFAULT NULL,
    `after_hours_message_english` text,
    `after_hours_message_arabic` text,
    `call_duration_alert` enum('yes', 'no') DEFAULT NULL,
    `alert_time` time DEFAULT NULL,
    `notification_auto_close_time` time DEFAULT NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT `tenant_configurations_chk_1` CHECK (
        (
            `average_customer_rating` between 1 and 5
        )
    )
) ENGINE = InnoDB AUTO_INCREMENT = 4 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

--
-- Table structure for table `admin_users`
--

CREATE DATABASE ejabberd_test;

USE ejabberd_test;

CREATE TABLE `admin_users` (
    `id` varchar(36) NOT NULL,
    `username` varchar(191) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
    `role_id` varchar(36) DEFAULT NULL,
    `email` varchar(100) DEFAULT NULL,
    `first_name_english` varchar(100) DEFAULT NULL,
    `first_name_arabic` varchar(100) DEFAULT NULL,
    `last_name_english` varchar(100) DEFAULT NULL,
    `last_name_arabic` varchar(100) DEFAULT NULL,
    `mobile_number` varchar(20) DEFAULT NULL,
    `is_active` tinyint DEFAULT '1',
    `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `deleted_at` timestamp NULL DEFAULT NULL,
    `created_by` varchar(36) DEFAULT NULL,
    `updated_by` varchar(36) DEFAULT NULL,
    `deleted_by` varchar(36) DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `fk_users_role_id_idx` (`role_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb3;

--
-- Table structure for table `agents`
--

CREATE TABLE `agents` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `username` varchar(191) NOT NULL,
    `role_id` varchar(36) NOT NULL,
    `email` varchar(100) DEFAULT NULL,
    `first_name_english` varchar(100) NOT NULL,
    `first_name_arabic` varchar(100) NOT NULL,
    `last_name_english` varchar(100) DEFAULT NULL,
    `last_name_arabic` varchar(100) DEFAULT NULL,
    `mobile_number` varchar(20) DEFAULT NULL,
    `image` varchar(255) DEFAULT NULL,
    `is_active` tinyint DEFAULT '1',
    `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `deleted_at` timestamp NULL DEFAULT NULL,
    `created_by` varchar(36) DEFAULT NULL,
    `updated_by` varchar(36) DEFAULT NULL,
    `deleted_by` varchar(36) DEFAULT NULL,
    `last_selected` datetime DEFAULT CURRENT_TIMESTAMP,
    `last_interaction_start_time` datetime DEFAULT NULL,
    `last_interaction_end_time` datetime DEFAULT NULL,
    `is_available` tinyint DEFAULT '0',
    `xmpp_username` varchar(191) DEFAULT NULL,
    `is_smart_assist` tinyint DEFAULT '0',
    PRIMARY KEY (`id`),
    UNIQUE KEY `unique_username` (`username`),
    KEY `fk_users_role_id_idx` (`role_id`),
    KEY `agents_is_active_IDX` (`is_active`, `is_available`) USING BTREE,
    CONSTRAINT `fk_agents_role_id` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 374 DEFAULT CHARSET = utf8mb3;

--
-- Table structure for table `archive`
--

CREATE TABLE `archive` (
    `username` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `server_host` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'xmpp-dev.ace.online',
    `timestamp` bigint unsigned NOT NULL,
    `peer` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `bare_peer` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `xml` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `txt` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `id` bigint unsigned NOT NULL AUTO_INCREMENT,
    `message_id` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
    `kind` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `nick` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `broadcast_id` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    `broadcastmsg_id` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `origin_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    UNIQUE KEY `id` (`id`),
    KEY `i_username` (`username`) USING BTREE,
    KEY `i_peer` (`peer`) USING BTREE,
    KEY `i_bare_peer` (`bare_peer`) USING BTREE,
    KEY `i_archive_sh_username_bare_peer` (
        `server_host`,
        `username`,
        `bare_peer`
    ) USING BTREE,
    KEY `i_archive_sh_timestamp` (`server_host`, `timestamp`) USING BTREE,
    KEY `i_archive_sh_username_timestamp` (
        `server_host`,
        `username`,
        `timestamp`
    ) USING BTREE,
    KEY `i_archive_sh_username_peer` (
        `server_host`,
        `username`,
        `peer`
    ) USING BTREE,
    KEY `i_archive_sh_username_origin_id` (
        `server_host`,
        `username`,
        `origin_id` (191)
    ) USING BTREE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `archive_prefs`
--

CREATE TABLE `archive_prefs` (
    `username` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `server_host` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'xmpp-dev.ace.online',
    `def` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `always` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `never` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`server_host`, `username`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `audit_log`
--

CREATE TABLE `audit_log` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `table_name` varchar(100) NOT NULL,
    `entity_id` varchar(50) NOT NULL,
    `action` enum('CREATE', 'UPDATE', 'DELETE') NOT NULL,
    `changed_by` varchar(255) NOT NULL,
    `old_data` json DEFAULT NULL,
    `new_data` json DEFAULT NULL,
    `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 3286 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

--
-- Table structure for table `bosh`
--

CREATE TABLE `bosh` (
    `sid` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `node` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `pid` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    UNIQUE KEY `i_bosh_sid` (`sid` (75))
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `call_queue`
--

CREATE TABLE `call_queue` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `caller_jid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `to_user` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `room_id` varchar(255) NOT NULL,
    `call_link` varchar(255) DEFAULT NULL,
    `caller_name` varchar(255) DEFAULT NULL,
    `call_time` varchar(255) DEFAULT NULL,
    `call_type` varchar(50) DEFAULT NULL,
    `user_domain` varchar(255) DEFAULT NULL,
    `caller_socket_id` varchar(255) DEFAULT NULL,
    `queue_number` int DEFAULT NULL,
    `status` varchar(50) DEFAULT 'PENDING',
    `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    `room_link` varchar(255) DEFAULT NULL,
    `call_status` varchar(50) DEFAULT NULL,
    `call_mode` varchar(50) DEFAULT NULL,
    `behaviour` varchar(50) DEFAULT NULL,
    `called_type` varchar(50) DEFAULT NULL,
    `service_id` int DEFAULT NULL,
    `retries` int DEFAULT '0',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 2202 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

--
-- Table structure for table `call_recordings`
--

CREATE TABLE `call_recordings` (
    `id` int NOT NULL AUTO_INCREMENT,
    `room_id` varchar(245) NOT NULL,
    `username` varchar(245) NOT NULL,
    `pod_name` varchar(245) NOT NULL,
    `file_path` varchar(245) DEFAULT NULL,
    `thumbimage` varchar(245) DEFAULT NULL,
    `record_path` varchar(245) NOT NULL,
    `record_stop_by` varchar(245) DEFAULT NULL,
    `duration` int DEFAULT NULL,
    `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `record_file` varchar(245) DEFAULT NULL,
    `is_pod_deleted` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
    `record_ended` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
    `local_video_deleted` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 324 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

--
-- Table structure for table `caps_features`
--

CREATE TABLE `caps_features` (
    `node` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `subnode` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `feature` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    KEY `i_caps_features_node_subnode` (`node` (75), `subnode` (75))
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `chat_access_tokens`
--

CREATE TABLE `chat_access_tokens` (
    `id` int unsigned NOT NULL AUTO_INCREMENT,
    `jid` varchar(191) DEFAULT NULL,
    `username` varchar(191) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
    `token` varchar(2048) DEFAULT NULL,
    `token_expiry_time` varchar(255) DEFAULT NULL,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `scopes` varchar(255) DEFAULT NULL,
    `device_type` varchar(255) DEFAULT NULL,
    `device_id` varchar(40) DEFAULT NULL,
    `client_ip` varchar(255) DEFAULT NULL,
    `remember_token` varchar(255) DEFAULT NULL,
    `user_id` int DEFAULT NULL,
    `refresh_token` varchar(2048) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `chat_access_tokens_index1` (`token`)
) ENGINE = InnoDB AUTO_INCREMENT = 22553 DEFAULT CHARSET = latin1;

--
-- Table structure for table `chat_data_export`
--

CREATE TABLE `chat_data_export` (
    `id` int NOT NULL AUTO_INCREMENT,
    `username` varchar(100) NOT NULL,
    `start_date` date NOT NULL,
    `end_date` date NOT NULL,
    `chat_type` varchar(10) NOT NULL COMMENT 'possible values single/group/all',
    `export_type` varchar(5) NOT NULL COMMENT 'possible values csv/json',
    `request_id` varchar(150) NOT NULL,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `status` varchar(10) NOT NULL COMMENT 'possible values queued/inprogress/completed/failed',
    `file_token` varchar(200) DEFAULT NULL,
    `count` bigint DEFAULT NULL,
    `started_at` timestamp NULL DEFAULT NULL,
    `ended_at` timestamp NULL DEFAULT NULL,
    `error_log` text,
    `license_key` varchar(200) NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 41 DEFAULT CHARSET = latin1;

--
-- Table structure for table `chat_logs`
--

CREATE TABLE `chat_logs` (
    `id` int NOT NULL AUTO_INCREMENT,
    `username` varchar(194) NOT NULL,
    `device_type` varchar(15) NOT NULL,
    `device_os` varchar(50) NOT NULL,
    `device_model` varchar(50) NOT NULL,
    `app_version` varchar(50) NOT NULL,
    `status` tinyint(1) NOT NULL DEFAULT '0',
    `description` text NOT NULL,
    `file_token` varchar(500) DEFAULT NULL,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` datetime NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = latin1;

--
-- Table structure for table `chat_media_files`
--

CREATE TABLE `chat_media_files` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `file_token` varchar(500) DEFAULT NULL,
    `from_user` varchar(255) DEFAULT NULL,
    `group_id` varchar(255) DEFAULT NULL,
    `mime_type` varchar(255) DEFAULT NULL,
    `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
    `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `broadcast_id` varchar(255) DEFAULT NULL,
    `type` varchar(45) DEFAULT NULL,
    `original_file` varchar(255) DEFAULT NULL,
    `to_users` text,
    `message_id` varchar(500) DEFAULT NULL,
    `file_path` varchar(500) DEFAULT NULL,
    `is_active` int DEFAULT NULL,
    `interaction_id` bigint DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `file_token` (`file_token`),
    KEY `message_id` (`message_id`),
    KEY `type` (`type`),
    KEY `from_user` (`from_user`),
    KEY `chat_media_files_interaction_id_IDX` (`interaction_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 86884 DEFAULT CHARSET = latin1;

--
-- Table structure for table `chat_message_edit_history`
--

CREATE TABLE `chat_message_edit_history` (
    `id` int NOT NULL AUTO_INCREMENT,
    `from_user` varchar(100) DEFAULT NULL,
    `to_user` varchar(100) DEFAULT NULL,
    `chat_type` varchar(10) DEFAULT NULL,
    `message_id` varchar(150) DEFAULT NULL,
    `edit_message_id` varchar(150) DEFAULT NULL,
    `msg` mediumtext,
    `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 13329 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

--
-- Table structure for table `interaction_analysis`
--

CREATE TABLE `interaction_analysis` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `interaction_id` bigint NOT NULL,
    `customer_sentiment` text NOT NULL,
    `customer_sentiment_score` int NOT NULL,
    `agent_sentiment` text NOT NULL,
    `agent_sentiment_score` int NOT NULL,
    `conversation_sentiment` text,
    `sentiment_score` int DEFAULT NULL,
    `main_topic` text,
    `summary_text` text,
    `action` text,
    `action_type` varchar(255) DEFAULT NULL,
    `transcript` text,
    `summary` text,
    `type` varchar(255) DEFAULT NULL,
    `response_quality` text,
    `next_step` text,
    `domain` varchar(255) DEFAULT NULL,
    `subdomain` varchar(255) DEFAULT NULL,
    `agent_performance` text,
    `customer_emotional_state` text,
    `problem_status` text,
    `resolution_details` text,
    `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `agent_evaluation` json DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `interaction_id_UNIQUE` (`interaction_id`),
    KEY `fk_interaction_analysis_interaction_id_idx` (`interaction_id`),
    KEY `idx_customer_sentiment` (`customer_sentiment` (100)),
    CONSTRAINT `fk_interaction_analysis_interaction_id` FOREIGN KEY (`interaction_id`) REFERENCES `interactions` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 3094 DEFAULT CHARSET = utf8mb3;

--
-- Table structure for table `interaction_feedback`
--

CREATE TABLE `interaction_feedback` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `interaction_id` bigint NOT NULL,
    `feedback_type` varchar(100) NOT NULL,
    `agent_id` bigint DEFAULT NULL,
    `customer_id` bigint DEFAULT NULL,
    `feedback_question_english` text NOT NULL,
    `feedback_question_arabic` text,
    `feedback_rating` int NOT NULL,
    `feedback_comments_english` text,
    `feedback_comments_arabic` text,
    `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `fk_interaction_feedback_agent_id_idx` (`agent_id`),
    KEY `fk_interaction_feedback_customer_id_idx` (`customer_id`),
    KEY `interaction_feedback_interaction_id_IDX` (
        `interaction_id`,
        `customer_id`
    ) USING BTREE,
    KEY `if_interaction_id_agent_id_IDX` (`interaction_id`, `agent_id`) USING BTREE,
    CONSTRAINT `fk_interaction_feedback_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `agents` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT `fk_interaction_feedback_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT `fk_interaction_feedback_interaction_id` FOREIGN KEY (`interaction_id`) REFERENCES `interactions` (`id`) ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 5420 DEFAULT CHARSET = utf8mb3;

--
-- Table structure for table `interaction_log`
--

CREATE TABLE `interaction_log` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `interaction_id` bigint DEFAULT NULL,
    `log_type` varchar(100) DEFAULT NULL,
    `transcript` text,
    `recording_url` varchar(255) DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb3;

--
-- Table structure for table `interaction_recording_transcripts`
--

CREATE TABLE `interaction_recording_transcripts` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `interaction_id` varchar(100) NOT NULL,
    `speaker` varchar(50) NOT NULL,
    `start_time_seconds` decimal(10, 2) DEFAULT NULL,
    `transcript_message` text,
    `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb3;

--
-- Table structure for table `irc_custom`
--

CREATE TABLE `irc_custom` (
    `jid` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `host` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY `i_irc_custom_jid_host` (`jid` (75), `host` (75)) USING BTREE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `last`
--

CREATE TABLE `last` (
    `username` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `server_host` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'xmpp-dev.ace.online',
    `status` tinyint NOT NULL DEFAULT '0',
    `seconds` int NOT NULL,
    `presence` tinyint(1) NOT NULL DEFAULT '0',
    `state` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`server_host`, `username`),
    KEY `seconds` (`seconds`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `license_lookup`
--

CREATE TABLE `license_lookup` (
    `id` int NOT NULL AUTO_INCREMENT,
    `lkey` text NOT NULL,
    `flag` int NOT NULL DEFAULT '0',
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 5 DEFAULT CHARSET = latin1;

--
-- Table structure for table `masdr_services`
--

CREATE TABLE `masdr_services` (
    `id` int NOT NULL AUTO_INCREMENT,
    `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
    `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `deleted_at` datetime DEFAULT NULL,
    `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
    `deleted_by` int DEFAULT NULL,
    `created_by` int DEFAULT NULL,
    `updated_by` int DEFAULT NULL,
    `name_arabic` varchar(90) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 4 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `media_call_logs`
--

CREATE TABLE `media_call_logs` (
    `id` int NOT NULL AUTO_INCREMENT,
    `room_id` varchar(100) DEFAULT NULL,
    `room_link` varchar(15) DEFAULT NULL,
    `from_user` varchar(50) DEFAULT NULL,
    `to_user` varchar(50) DEFAULT NULL,
    `call_status` enum(
        'CALLING',
        'ENDED',
        'BUSY',
        'ATTENDED'
    ) DEFAULT NULL,
    `start_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `end_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `called_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `called_type` enum('AUDIO', 'VIDEO') DEFAULT NULL,
    `call_mode` enum('ONETOONE', 'ONETOMANY') DEFAULT NULL,
    `caller_device` varchar(255) DEFAULT NULL,
    `group_id` varchar(255) DEFAULT NULL,
    `behaviour` varchar(10) NOT NULL DEFAULT 'call',
    `metadata` json DEFAULT NULL,
    `masdr_services` int DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `room_link` (`room_link`)
) ENGINE = InnoDB DEFAULT CHARSET = latin1;

--
-- Table structure for table `media_logs`
--

CREATE TABLE `media_logs` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `interaction_id` bigint NOT NULL,
    `room_id` varchar(245) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
    `file_path` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
    `thumbimage` varchar(245) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
    `record_path` varchar(245) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
    `record_stop_by` varchar(245) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
    `duration` int DEFAULT NULL,
    `record_file` varchar(245) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
    `record_ended` tinyint NOT NULL DEFAULT '0',
    `local_video_deleted` tinyint NOT NULL DEFAULT '0',
    `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
    `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
    `video_conversion_status` varchar(245) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `interaction_id_UNIQUE` (`interaction_id`),
    KEY `media_logs_interaction_id_IDX` (`interaction_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7315 DEFAULT CHARSET = utf8mb3 COLLATE = utf8mb3_unicode_ci;

--
-- Table structure for table `media_pod_logs`
--

CREATE TABLE `media_pod_logs` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `media_logs_id` bigint NOT NULL,
    `pod_name` varchar(245) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
    `is_pod_deleted` tinyint NOT NULL DEFAULT '0',
    `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
    `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `fk_media_pod_logs_media_logs_id_idx` (`media_logs_id`),
    CONSTRAINT `fk_media_pod_logs_media_logs_id` FOREIGN KEY (`media_logs_id`) REFERENCES `media_logs` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 5600 DEFAULT CHARSET = utf8mb3 COLLATE = utf8mb3_unicode_ci;

--
-- Table structure for table `message_favourite`
--

CREATE TABLE `message_favourite` (
    `id` int NOT NULL AUTO_INCREMENT,
    `favourite_user` varchar(180) NOT NULL,
    `message_id` varchar(150) NOT NULL,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `idx_message_favourite` (
        `favourite_user`,
        `message_id`
    ),
    KEY `to_user` (`favourite_user`),
    KEY `message_id` (`message_id`),
    KEY `created_at` (`created_at`)
) ENGINE = InnoDB AUTO_INCREMENT = 3913 DEFAULT CHARSET = latin1;

--
-- Table structure for table `message_status`
--

CREATE TABLE `message_status` (
    `id` int NOT NULL AUTO_INCREMENT,
    `from_user` varchar(100) NOT NULL,
    `to_user` varchar(100) NOT NULL,
    `message_id` varchar(150) NOT NULL,
    `message_type` varchar(10) NOT NULL DEFAULT '0',
    `chat_type` varchar(10) NOT NULL,
    `status` tinyint NOT NULL DEFAULT '0',
    `recent` tinyint NOT NULL DEFAULT '0',
    `recall_status` tinyint unsigned NOT NULL DEFAULT '0',
    `favourite_status` tinyint NOT NULL DEFAULT '0',
    `favourite_by` varchar(191) NOT NULL DEFAULT '0',
    `favourite_date` datetime DEFAULT NULL,
    `deleted_status` tinyint NOT NULL DEFAULT '0',
    `deleted_by` varchar(191) NOT NULL DEFAULT '0',
    `blocked` varchar(250) NOT NULL DEFAULT '0',
    `from_notification` varchar(191) NOT NULL,
    `to_notification` varchar(100) NOT NULL,
    `message_notification` int NOT NULL,
    `txt` mediumtext NOT NULL,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `received_at` datetime NOT NULL,
    `seen_at` datetime NOT NULL,
    `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `message_time` bigint NOT NULL,
    `meta_data` json DEFAULT NULL,
    `edit_message_id` varchar(150) NOT NULL,
    `topic_id` varchar(45) NOT NULL DEFAULT '',
    `edit_status` tinyint NOT NULL DEFAULT '0',
    `interaction_id` bigint DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `unique_index` (
        `message_id`,
        `from_user`,
        `to_user`,
        `id`
    ),
    KEY `deleted_by` (`deleted_by`),
    KEY `message_status_msg_id` (`message_id`),
    KEY `from_user_to_user` (`from_user`, `to_user`),
    KEY `to_user` (`to_user`),
    KEY `id_index` (
        `id`,
        `deleted_status`,
        `deleted_by`,
        `blocked`,
        `from_user`,
        `to_user`
    ),
    KEY `created_at` (`created_at`),
    KEY `message_notification` (`message_notification`),
    KEY `blocked` (`blocked`),
    KEY `deleted_status` (`deleted_status`),
    KEY `recall_status` (`recall_status`),
    KEY `favourite_by` (`favourite_by`),
    KEY `favourite_status` (`favourite_status`)
) ENGINE = InnoDB AUTO_INCREMENT = 18062 DEFAULT CHARSET = latin1;

--
-- Table structure for table `migration_file_details`
--

CREATE TABLE `migration_file_details` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `username` varchar(200) NOT NULL,
    `file_token` varchar(200) NOT NULL,
    `filename` varchar(200) NOT NULL,
    `status` varchar(10) NOT NULL,
    `total` int DEFAULT '0',
    `processed` int DEFAULT '0',
    `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    `started_at` timestamp NULL DEFAULT NULL,
    `completed_at` timestamp NULL DEFAULT NULL,
    `error_log` text,
    `validation_errors` longtext,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 12 DEFAULT CHARSET = latin1;

--
-- Table structure for table `mix_channel`
--

CREATE TABLE `mix_channel` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `channel` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `service` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `username` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `domain` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `jid` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `hidden` tinyint(1) NOT NULL,
    `hmac_key` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `license_key` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `metadata` json DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `i_mix_channel_serv` (`service` (191)),
    KEY `i_mix_channel` (`channel`)
) ENGINE = InnoDB AUTO_INCREMENT = 13166 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `mix_pam`
--

CREATE TABLE `mix_pam` (
    `pam_id` bigint NOT NULL AUTO_INCREMENT,
    `username` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `server_host` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'xmpp-dev.ace.online',
    `channel` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `service` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `affiliation` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `is_block` int NOT NULL DEFAULT '0',
    PRIMARY KEY (`pam_id`),
    UNIQUE KEY `i_mix_pam` (
        `username` (191),
        `server_host`,
        `channel`,
        `service` (191)
    ),
    KEY `i_mix_chan_usr` (`channel`, `username` (191))
) ENGINE = InnoDB AUTO_INCREMENT = 55924 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `mix_participant`
--

CREATE TABLE `mix_participant` (
    `participant_id` bigint NOT NULL AUTO_INCREMENT,
    `channel` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `service` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `username` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `domain` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `jid` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `nick` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`participant_id`),
    UNIQUE KEY `i_mix_participant` (
        `channel` (191),
        `service` (191),
        `username` (191),
        `domain` (191)
    ),
    KEY `i_mix_chan_usr` (
        `channel` (191),
        `username` (191)
    )
) ENGINE = InnoDB AUTO_INCREMENT = 58474 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `mix_subscription`
--

CREATE TABLE `mix_subscription` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `channel` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `service` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `username` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `domain` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `node` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `jid` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `i_mix_subscription` (
        `channel` (153),
        `service` (153),
        `username` (153),
        `domain` (153),
        `node` (153)
    ),
    KEY `i_mix_subscription_chan_serv_node` (
        `channel` (191),
        `service` (191),
        `node` (191)
    )
) ENGINE = InnoDB AUTO_INCREMENT = 134577 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `motd`
--

CREATE TABLE `motd` (
    `username` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `server_host` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'xmpp-dev.ace.online',
    `xml` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`server_host`, `username`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `mqtt_pub`
--

CREATE TABLE `mqtt_pub` (
    `username` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `server_host` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'xmpp-dev.ace.online',
    `resource` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `topic` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `qos` tinyint NOT NULL,
    `payload` blob NOT NULL,
    `payload_format` tinyint NOT NULL,
    `content_type` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `response_topic` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `correlation_data` blob NOT NULL,
    `user_properties` blob NOT NULL,
    `expiry` int unsigned NOT NULL,
    UNIQUE KEY `i_mqtt_topic_server` (`topic` (191), `server_host`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `muc_online_room`
--

CREATE TABLE `muc_online_room` (
    `name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `host` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `server_host` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'xmpp-dev.ace.online',
    `node` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `pid` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    UNIQUE KEY `i_muc_online_room_name_host` (`name` (75), `host` (75)) USING BTREE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `muc_online_users`
--

CREATE TABLE `muc_online_users` (
    `username` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `server` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `resource` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `host` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `server_host` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'xmpp-dev.ace.online',
    `node` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    UNIQUE KEY `i_muc_online_users` (
        `username` (75),
        `server` (75),
        `resource` (75),
        `name` (75),
        `host` (75)
    ) USING BTREE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `muc_registered`
--

CREATE TABLE `muc_registered` (
    `jid` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `host` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `server_host` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'xmpp-dev.ace.online',
    `nick` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY `i_muc_registered_jid_host` (`jid` (75), `host` (75)) USING BTREE,
    KEY `i_muc_registered_nick` (`nick` (75)) USING BTREE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `muc_room`
--

CREATE TABLE `muc_room` (
    `name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `host` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `server_host` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'xmpp-dev.ace.online',
    `opts` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY `i_muc_room_name_host` (`name` (75), `host` (75)) USING BTREE,
    KEY `i_muc_room_host_created_at` (`host` (75), `created_at`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `muc_room_subscribers`
--

CREATE TABLE `muc_room_subscribers` (
    `room` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `host` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `jid` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `nick` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `nodes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY `i_muc_room_subscribers_host_room_jid` (`host`, `room`, `jid`),
    KEY `i_muc_room_subscribers_host_jid` (`host`, `jid`) USING BTREE,
    KEY `i_muc_room_subscribers_jid` (`jid`) USING BTREE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `oauth_client`
--

CREATE TABLE `oauth_client` (
    `client_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `client_name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `grant_type` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `options` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`client_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `oauth_token`
--

CREATE TABLE `oauth_token` (
    `token` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `jid` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `scope` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `expire` bigint NOT NULL,
    PRIMARY KEY (`token`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `privacy_default_list`
--

CREATE TABLE `privacy_default_list` (
    `username` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `server_host` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'xmpp-dev.ace.online',
    `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`server_host`, `username`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `privacy_list`
--

CREATE TABLE `privacy_list` (
    `username` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `server_host` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'xmpp-dev.ace.online',
    `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `id` bigint unsigned NOT NULL AUTO_INCREMENT,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY `id` (`id`),
    UNIQUE KEY `i_privacy_list_sh_username_name` (
        `server_host`,
        `username` (75),
        `name` (75)
    ) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 316 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `privacy_list_data`
--

CREATE TABLE `privacy_list_data` (
    `id` bigint DEFAULT NULL,
    `t` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `action` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `ord` decimal(10, 0) NOT NULL,
    `match_all` tinyint(1) NOT NULL,
    `match_iq` tinyint(1) NOT NULL,
    `match_message` tinyint(1) NOT NULL,
    `match_presence_in` tinyint(1) NOT NULL,
    `match_presence_out` tinyint(1) NOT NULL,
    KEY `i_privacy_list_data_id` (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `private_storage`
--

CREATE TABLE `private_storage` (
    `username` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `server_host` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'xmpp-dev.ace.online',
    `namespace` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (
        `server_host`,
        `username`,
        `namespace`
    )
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `proxy65`
--

CREATE TABLE `proxy65` (
    `sid` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `pid_t` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `pid_i` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `node_t` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `node_i` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `jid_i` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    UNIQUE KEY `i_proxy65_sid` (`sid` (191)),
    KEY `i_proxy65_jid` (`jid_i` (191))
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `pubsub_item`
--

CREATE TABLE `pubsub_item` (
    `nodeid` bigint DEFAULT NULL,
    `itemid` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `publisher` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `creation` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `modification` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `payload` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `message_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `timestamp` bigint unsigned NOT NULL,
    UNIQUE KEY `i_pubsub_item_tuple` (`nodeid`, `itemid` (36)),
    KEY `i_pubsub_item_itemid` (`itemid` (36)),
    KEY `pubsub_msg_id_index` (`message_id`),
    CONSTRAINT `pubsub_item_ibfk_1` FOREIGN KEY (`nodeid`) REFERENCES `pubsub_node` (`nodeid`) ON DELETE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `pubsub_node`
--

CREATE TABLE `pubsub_node` (
    `host` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `node` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `parent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `plugin` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `type` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `nodeid` bigint NOT NULL AUTO_INCREMENT,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`nodeid`),
    UNIQUE KEY `i_pubsub_node_tuple` (`host` (20), `node` (120)),
    KEY `i_pubsub_node_parent` (`parent` (120))
) ENGINE = InnoDB AUTO_INCREMENT = 13275 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `pubsub_node_option`
--

CREATE TABLE `pubsub_node_option` (
    `nodeid` bigint DEFAULT NULL,
    `name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `val` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    KEY `i_pubsub_node_option_nodeid` (`nodeid`),
    CONSTRAINT `pubsub_node_option_ibfk_1` FOREIGN KEY (`nodeid`) REFERENCES `pubsub_node` (`nodeid`) ON DELETE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `pubsub_node_owner`
--

CREATE TABLE `pubsub_node_owner` (
    `nodeid` bigint DEFAULT NULL,
    `owner` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    KEY `i_pubsub_node_owner_nodeid` (`nodeid`),
    CONSTRAINT `pubsub_node_owner_ibfk_1` FOREIGN KEY (`nodeid`) REFERENCES `pubsub_node` (`nodeid`) ON DELETE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `pubsub_state`
--

CREATE TABLE `pubsub_state` (
    `nodeid` bigint DEFAULT NULL,
    `jid` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `affiliation` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `subscriptions` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `stateid` bigint NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (`stateid`),
    UNIQUE KEY `i_pubsub_state_tuple` (`nodeid`, `jid` (60)),
    KEY `i_pubsub_state_jid` (`jid` (60)),
    CONSTRAINT `pubsub_state_ibfk_1` FOREIGN KEY (`nodeid`) REFERENCES `pubsub_node` (`nodeid`) ON DELETE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 48363 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `pubsub_subscription_opt`
--

CREATE TABLE `pubsub_subscription_opt` (
    `subid` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `opt_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `opt_value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    UNIQUE KEY `i_pubsub_subscription_opt` (`subid` (32), `opt_name`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `push_session`
--

CREATE TABLE `push_session` (
    `username` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `server_host` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'xmpp-dev.ace.online',
    `timestamp` bigint NOT NULL,
    `service` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `node` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `xml` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (
        `server_host`,
        `username` (191),
        `timestamp`
    ),
    UNIQUE KEY `i_push_session_susn` (
        `server_host`,
        `username` (191),
        `service` (191),
        `node` (191)
    ),
    KEY `i_push_session_sh_username_timestamp` (
        `server_host`,
        `username` (191),
        `timestamp`
    )
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `reports`
--
CREATE TABLE `reports` (
    `id` int NOT NULL AUTO_INCREMENT,
    `reported` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `serialized_message` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `reported_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 728 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `roles`
--
CREATE TABLE `roles` (
    `id` varchar(36) NOT NULL,
    `name_english` varchar(60) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
    `name_arabic` varchar(60) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
    `description_english` varchar(500) DEFAULT NULL,
    `description_arabic` varchar(500) DEFAULT NULL,
    `is_editable` tinyint DEFAULT '0',
    `created_at` timestamp NULL DEFAULT NULL,
    `updated_at` timestamp NULL DEFAULT NULL,
    `created_by` varchar(36) DEFAULT NULL,
    `updated_by` varchar(36) DEFAULT NULL,
    `is_active` tinyint DEFAULT '1',
    `deleted_by` varchar(36) DEFAULT NULL,
    `deleted_at` timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `unique_roles_name` (`name_english`),
    UNIQUE KEY `unique_roles_name_arabic` (`name_arabic`),
    KEY `fk_roles_created_by_idx` (`created_by`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb3 COMMENT = 'To store the user roles';

--
-- Table structure for table `rostergroups`
--
CREATE TABLE `rostergroups` (
    `username` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `server_host` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'xmpp-dev.ace.online',
    `jid` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `grp` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    KEY `i_rosterg_sh_user_jid` (
        `server_host`,
        `username` (75),
        `jid` (75)
    )
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `rosterusers`
--
CREATE TABLE `rosterusers` (
    `username` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `server_host` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'xmpp-dev.ace.online',
    `jid` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `jid_username` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `nick` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `subscription` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `ask` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `askmessage` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `server` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `subscribe` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `type` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    `license_key` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    UNIQUE KEY `i_rosteru_sh_user_jid` (
        `server_host`,
        `username` (75),
        `jid` (75)
    ),
    KEY `jid_username` (`jid_username`),
    KEY `i_rosteru_sh_jid` (`server_host`, `jid`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `roster_version`
--
CREATE TABLE `roster_version` (
    `username` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `server_host` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'xmpp-dev.ace.online',
    `version` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`server_host`, `username`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `route`
--
CREATE TABLE `route` (
    `domain` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `server_host` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `node` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `pid` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `local_hint` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    UNIQUE KEY `i_route` (
        `domain` (75),
        `server_host` (75),
        `node` (75),
        `pid` (75)
    )
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `service_groups`
--
CREATE TABLE `service_groups` (
    `id` int NOT NULL AUTO_INCREMENT,
    `name_english` varchar(60) NOT NULL,
    `slug` varchar(100) NOT NULL,
    `name_arabic` varchar(60) NOT NULL,
    `description_english` varchar(250) DEFAULT NULL,
    `description_arabic` varchar(250) DEFAULT NULL,
    `site_name` varchar(100) DEFAULT NULL,
    `is_parent` tinyint DEFAULT '1',
    `parent_id` int DEFAULT NULL,
    `is_active` tinyint DEFAULT '1',
    `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `deleted_at` timestamp NULL DEFAULT NULL,
    `created_by` varchar(36) DEFAULT NULL,
    `updated_by` varchar(36) DEFAULT NULL,
    `deleted_by` varchar(36) DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `slug_UNIQUE` (`slug`),
    KEY `fk_service_groups_parent_id_idx` (`parent_id`),
    KEY `service_groups_parent_id_IDX` (
        `parent_id`,
        `is_parent`,
        `deleted_at`
    ) USING BTREE,
    CONSTRAINT `fk_service_groups_parent_id` FOREIGN KEY (`parent_id`) REFERENCES `service_groups` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 105 DEFAULT CHARSET = utf8mb3 COMMENT = 'To store service group information under sites and tenants.';

--
-- Table structure for table `service_group_kpis`
--
CREATE TABLE `service_group_kpis` (
    `id` int NOT NULL AUTO_INCREMENT,
    `service_group_id` int NOT NULL,
    `name` varchar(255) NOT NULL,
    `description` text NOT NULL,
    `value` varchar(10) DEFAULT NULL,
    `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `created_by` varchar(36) DEFAULT NULL,
    `updated_by` varchar(36) DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `fk_kpis_service_group_id` (`service_group_id`),
    KEY `service_group_kpis_service_group_id_IDX` (`service_group_id`, `name`) USING BTREE,
    CONSTRAINT `fk_kpis_service_group_id` FOREIGN KEY (`service_group_id`) REFERENCES `service_groups` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 157 DEFAULT CHARSET = utf8mb3 COMMENT = 'Stores KPI values for service groups.';

--
-- Table structure for table `service_group_members`
--
CREATE TABLE `service_group_members` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `agent_id` bigint NOT NULL,
    `service_group_id` int NOT NULL,
    `assigned_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    `transferred_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `removed_at` timestamp NULL DEFAULT NULL,
    `assigned_by` varchar(36) DEFAULT NULL,
    `transferred_by` varchar(36) DEFAULT NULL,
    `removed_by` varchar(36) DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `unique_user_service_group` (
        `agent_id`,
        `service_group_id`
    ),
    KEY `fk_sgm_service_group_id` (`service_group_id`),
    CONSTRAINT `fk_service_group_members_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `agents` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT `fk_sgm_service_group_id` FOREIGN KEY (`service_group_id`) REFERENCES `service_groups` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 306 DEFAULT CHARSET = utf8mb3;

--
-- Table structure for table `service_group_messages`
--
CREATE TABLE `service_group_messages` (
    `id` int NOT NULL AUTO_INCREMENT,
    `service_group_id` int NOT NULL,
    `language` enum('English', 'Arabic') NOT NULL,
    `message` text NOT NULL,
    `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `created_by` varchar(36) DEFAULT NULL,
    `updated_by` varchar(36) DEFAULT NULL,
    `name` varchar(255) NOT NULL,
    `description` text NOT NULL,
    PRIMARY KEY (`id`),
    KEY `fk_messages_service_group_id` (`service_group_id`),
    CONSTRAINT `fk_messages_service_group_id` FOREIGN KEY (`service_group_id`) REFERENCES `service_groups` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 9 DEFAULT CHARSET = utf8mb3 COMMENT = 'Stores messages for service groups outside working hours.';

--
-- Table structure for table `service_group_working_days`
--
CREATE TABLE `service_group_working_days` (
    `id` int NOT NULL AUTO_INCREMENT,
    `service_group_id` int NOT NULL,
    `days` enum(
        'Monday',
        'Tuesday',
        'Wednesday',
        'Thursday',
        'Friday',
        'Saturday',
        'Sunday'
    ) NOT NULL,
    `start_time` time NOT NULL DEFAULT '00:00:01',
    `end_time` time NOT NULL,
    `break_time` time DEFAULT '01:00:00',
    `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `created_by` varchar(36) DEFAULT NULL,
    `updated_by` varchar(36) DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `fk_working_days_service_group_id` (`service_group_id`),
    CONSTRAINT `fk_working_days_service_group_id` FOREIGN KEY (`service_group_id`) REFERENCES `service_groups` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 315 DEFAULT CHARSET = utf8mb3 COMMENT = 'Stores the working days of service groups.';

--
-- Table structure for table `sm`
--
CREATE TABLE `sm` (
    `usec` bigint NOT NULL,
    `pid` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `node` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `username` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `server_host` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'xmpp-dev.ace.online',
    `resource` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `priority` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`usec`, `pid` (75)),
    KEY `i_sm_node` (`node` (75)),
    KEY `i_sm_sh_username` (`server_host`, `username`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `spool`
--
CREATE TABLE `spool` (
    `username` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `server_host` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'xmpp-dev.ace.online',
    `xml` mediumblob NOT NULL,
    `seq` bigint unsigned NOT NULL AUTO_INCREMENT,
    `message_id` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `chat_type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `message` mediumblob,
    `web_resource` tinyint(1) NOT NULL DEFAULT '0',
    `status` tinyint(1) NOT NULL DEFAULT '0',
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `to_user` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    `device_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    `admin_delivered` tinyint(1) NOT NULL DEFAULT '0',
    UNIQUE KEY `seq` (`seq`),
    KEY `i_spool_created_at` (`created_at`) USING BTREE,
    KEY `i_spool_message_id` (`message_id`),
    KEY `i_spool_sh_username` (`server_host`, `username`) USING BTREE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `sr_group`
--
CREATE TABLE `sr_group` (
    `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `server_host` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'xmpp-dev.ace.online',
    `opts` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY `i_sr_group_sh_name` (`server_host`, `name`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `sr_user`
--
CREATE TABLE `sr_user` (
    `jid` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `server_host` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'xmpp-dev.ace.online',
    `grp` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY `i_sr_user_sh_jid_group` (`server_host`, `jid`, `grp`),
    KEY `i_sr_user_sh_grp` (`server_host`, `grp`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `tenant_configurations`
--
CREATE TABLE `tenant_configurations` (
    `id` int NOT NULL AUTO_INCREMENT,
    `average_customer_rating` varchar(10) DEFAULT NULL,
    `average_call_duration` time DEFAULT NULL,
    `average_waiting_time` time DEFAULT NULL,
    `after_hours_message_english` text,
    `after_hours_message_arabic` text,
    `call_duration_alert` enum('yes', 'no') DEFAULT NULL,
    `alert_time` time DEFAULT NULL,
    `notification_auto_close_time` time DEFAULT NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT `tenant_configurations_chk_1` CHECK (
        (
            `average_customer_rating` between 1 and 5
        )
    )
) ENGINE = InnoDB AUTO_INCREMENT = 4 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

--
-- Table structure for table `topic_data`
--
CREATE TABLE `topic_data` (
    `id` int NOT NULL AUTO_INCREMENT,
    `topic_id` varchar(50) NOT NULL,
    `topic_name` varchar(50) DEFAULT NULL,
    `license_key` varchar(255) NOT NULL DEFAULT '',
    `meta_data` json NOT NULL,
    `created_by` varchar(100) DEFAULT NULL,
    `created_at` varchar(45) DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `topic_id_UNIQUE` (`topic_id`)
) ENGINE = InnoDB AUTO_INCREMENT = 1192 DEFAULT CHARSET = utf8mb3;

--
-- Table structure for table `topic_data_old`
--
CREATE TABLE `topic_data_old` (
    `id` int DEFAULT NULL,
    `topic_id` text,
    `topic_name` text,
    `meta_data` text,
    `created_by` text,
    `created_at` text
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

--
-- Table structure for table `users`
--
CREATE TABLE `users` (
    `username` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `server_host` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'xmpp-dev-phazero.contus.us',
    `password` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `ws_password` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `serverkey` varchar(128) NOT NULL DEFAULT '',
    `salt` varchar(128) NOT NULL DEFAULT '',
    `iterationcount` int DEFAULT '0',
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `is_admin` tinyint NOT NULL DEFAULT '0',
    `busy_message` varchar(255) DEFAULT 'I am Busy',
    `busy_status` tinyint DEFAULT '0',
    `is_available` tinyint(1) NOT NULL DEFAULT '1',
    `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `last_selected` datetime DEFAULT NULL,
    PRIMARY KEY (`server_host`, `username`)
) ENGINE = InnoDB DEFAULT CHARSET = latin1;

--
-- Table structure for table `users_contacts`
--
CREATE TABLE `users_contacts` (
    `id` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `username` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `mobile_number` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `name` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `license_key` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    PRIMARY KEY (`id`, `created_at`),
    KEY `username` (`username`),
    KEY `created_at` (`created_at`),
    KEY `mobile_number` (`mobile_number`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `user_service_shift_log`
--
CREATE TABLE `user_service_shift_log` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `user_id` bigint NOT NULL,
    `service_group_id` int DEFAULT NULL,
    `shift_start_time` timestamp NULL DEFAULT NULL,
    `shift_end_time` timestamp NULL DEFAULT NULL,
    `shift_break_time` timestamp NULL DEFAULT NULL,
    `log_date` date DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 3947 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

--
-- Table structure for table `user_session_log`
--
CREATE TABLE `user_session_log` (
    `session_id` bigint NOT NULL AUTO_INCREMENT,
    `user_id` bigint NOT NULL,
    `current_status_code` tinyint DEFAULT NULL,
    `current_status_name` varchar(100) DEFAULT NULL,
    `online_duration` bigint DEFAULT '0',
    `offline_duration` bigint DEFAULT '0',
    `away_duration` bigint DEFAULT '0',
    `call_duration` bigint DEFAULT '0',
    `log_date` date DEFAULT NULL,
    `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`session_id`)
) ENGINE = InnoDB AUTO_INCREMENT = 401 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

--
-- Table structure for table `user_session_logs`
--
CREATE TABLE `user_session_logs` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `user_id` bigint NOT NULL,
    `status_code` tinyint NOT NULL,
    `status_name` varchar(100) NOT NULL,
    `start_time` timestamp NULL DEFAULT NULL,
    `end_time` timestamp NULL DEFAULT NULL,
    `log_date` date DEFAULT NULL,
    `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `user_session_logs_user_id_IDX` (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 62838 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

--
-- Table structure for table `vcard`
--
CREATE TABLE `vcard` (
    `username` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `server_host` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'xmpp-dev.ace.online',
    `vcard` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `is_delete` tinyint(1) NOT NULL DEFAULT '0',
    `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`server_host`, `username`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `vcard_search`
--
CREATE TABLE `vcard_search` (
    `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `lusername` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `server_host` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'xmpp-dev.ace.online',
    `fn` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `lfn` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `family` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `lfamily` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `given` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `lgiven` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `middle` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `lmiddle` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `nickname` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
    `lnickname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `bday` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `lbday` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `ctry` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `lctry` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `locality` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `llocality` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `email` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
    `lemail` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `image` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `limage` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `thumbimage` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '',
    `lthumbimage` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '',
    `status` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `lstatus` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `mobilenumber` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `lmobilenumber` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `orgname` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `lorgname` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `orgunit` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `lorgunit` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `is_block` int NOT NULL DEFAULT '0',
    `history` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
    PRIMARY KEY (`server_host`, `lusername`),
    KEY `i_vcard_search_lfamily` (`lfamily`),
    KEY `i_vcard_search_lgiven` (`lgiven`),
    KEY `i_vcard_search_lmiddle` (`lmiddle`),
    KEY `i_vcard_search_lnickname` (`lnickname`),
    KEY `i_vcard_search_lbday` (`lbday`),
    KEY `i_vcard_search_lctry` (`lctry`),
    KEY `i_vcard_search_llocality` (`llocality`),
    KEY `i_vcard_search_lemail` (`lemail`),
    KEY `i_vcard_search_lorgname` (`lorgname`),
    KEY `i_vcard_search_lorgunit` (`lorgunit`),
    KEY `i_vcard_search_lmobilenumber` (`lmobilenumber`),
    KEY `i_vcard_search_lfn` (`username`),
    KEY `lusername` (`lusername`),
    KEY `i_vcard_search_sh_lfn` (`server_host`, `lfn`),
    KEY `i_vcard_search_sh_llocality` (`server_host`, `llocality`),
    KEY `i_vcard_search_sh_lnickname` (`server_host`, `lnickname`),
    KEY `i_vcard_search_sh_lctry` (`server_host`, `lctry`),
    KEY `i_vcard_search_sh_lgiven` (`server_host`, `lgiven`),
    KEY `i_vcard_search_sh_lmiddle` (`server_host`, `lmiddle`),
    KEY `i_vcard_search_sh_lorgname` (`server_host`, `lorgname`),
    KEY `i_vcard_search_sh_lfamily` (`server_host`, `lfamily`),
    KEY `i_vcard_search_sh_lbday` (`server_host`, `lbday`),
    KEY `i_vcard_search_sh_lemail` (`server_host`, `lemail`),
    KEY `i_vcard_search_sh_lorgunit` (`server_host`, `lorgunit`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `vcard_xupdate`
--
CREATE TABLE `vcard_xupdate` (
    `username` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `hash` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`username`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `topic_data`
--
CREATE TABLE `topic_data` (
    `id` int NOT NULL AUTO_INCREMENT,
    `topic_id` varchar(50) NOT NULL,
    `topic_name` varchar(50) DEFAULT NULL,
    `license_key` varchar(255) NOT NULL DEFAULT '',
    `meta_data` json NOT NULL,
    `created_by` varchar(100) DEFAULT NULL,
    `created_at` varchar(45) DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `topic_id_UNIQUE` (`topic_id`)
) ENGINE = InnoDB AUTO_INCREMENT = 1192 DEFAULT CHARSET = utf8mb3;

--
-- Table structure for table `topic_data_old`
--
CREATE TABLE `topic_data_old` (
    `id` int DEFAULT NULL,
    `topic_id` text,
    `topic_name` text,
    `meta_data` text,
    `created_by` text,
    `created_at` text
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

--
-- Table structure for table `users`
--
CREATE TABLE `users` (
    `username` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `server_host` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'xmpp-dev-phazero.contus.us',
    `password` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `ws_password` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    `serverkey` varchar(128) NOT NULL DEFAULT '',
    `salt` varchar(128) NOT NULL DEFAULT '',
    `iterationcount` int DEFAULT '0',
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `is_admin` tinyint NOT NULL DEFAULT '0',
    `busy_message` varchar(255) DEFAULT 'I am Busy',
    `busy_status` tinyint DEFAULT '0',
    `is_available` tinyint(1) NOT NULL DEFAULT '1',
    `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `last_selected` datetime DEFAULT NULL,
    PRIMARY KEY (`server_host`, `username`)
) ENGINE = InnoDB DEFAULT CHARSET = latin1;

--
-- Table structure for table `users_contacts`
--
CREATE TABLE `users_contacts` (
    `id` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `username` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `mobile_number` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `name` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `license_key` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    PRIMARY KEY (`id`, `created_at`),
    KEY `username` (`username`),
    KEY `created_at` (`created_at`),
    KEY `mobile_number` (`mobile_number`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `user_service_shift_log`
--
CREATE TABLE `user_service_shift_log` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `user_id` bigint NOT NULL,
    `service_group_id` int DEFAULT NULL,
    `shift_start_time` timestamp NULL DEFAULT NULL,
    `shift_end_time` timestamp NULL DEFAULT NULL,
    `shift_break_time` timestamp NULL DEFAULT NULL,
    `log_date` date DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 5085 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

--
-- Table structure for table `user_session_log`
--
CREATE TABLE `user_session_log` (
    `session_id` bigint NOT NULL AUTO_INCREMENT,
    `user_id` bigint NOT NULL,
    `current_status_code` tinyint DEFAULT NULL,
    `current_status_name` varchar(100) DEFAULT NULL,
    `online_duration` bigint DEFAULT '0',
    `offline_duration` bigint DEFAULT '0',
    `away_duration` bigint DEFAULT '0',
    `call_duration` bigint DEFAULT '0',
    `log_date` date DEFAULT NULL,
    `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`session_id`)
) ENGINE = InnoDB AUTO_INCREMENT = 401 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

--
-- Table structure for table `user_session_logs`
--
CREATE TABLE `user_session_logs` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `user_id` bigint NOT NULL,
    `status_code` tinyint NOT NULL,
    `status_name` varchar(100) NOT NULL,
    `start_time` timestamp NULL DEFAULT NULL,
    `end_time` timestamp NULL DEFAULT NULL,
    `log_date` date DEFAULT NULL,
    `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `user_session_logs_user_id_IDX` (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 70728 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

--
-- Table structure for table `vcard`
--
CREATE TABLE `vcard` (
    `username` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `server_host` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'xmpp-dev.ace.online',
    `vcard` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `is_delete` tinyint(1) NOT NULL DEFAULT '0',
    `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`server_host`, `username`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `vcard_search`
--
CREATE TABLE `vcard_search` (
    `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `lusername` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `server_host` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'xmpp-dev.ace.online',
    `fn` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `lfn` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `family` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `lfamily` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `given` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `lgiven` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `middle` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `lmiddle` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `nickname` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
    `lnickname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `bday` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `lbday` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `ctry` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `lctry` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `locality` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `llocality` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `email` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
    `lemail` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `image` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `limage` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `thumbimage` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '',
    `lthumbimage` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '',
    `status` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `lstatus` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `mobilenumber` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `lmobilenumber` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `orgname` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `lorgname` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `orgunit` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `lorgunit` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `is_block` int NOT NULL DEFAULT '0',
    `history` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
    PRIMARY KEY (`server_host`, `lusername`),
    KEY `i_vcard_search_lfamily` (`lfamily`),
    KEY `i_vcard_search_lgiven` (`lgiven`),
    KEY `i_vcard_search_lmiddle` (`lmiddle`),
    KEY `i_vcard_search_lnickname` (`lnickname`),
    KEY `i_vcard_search_lbday` (`lbday`),
    KEY `i_vcard_search_lctry` (`lctry`),
    KEY `i_vcard_search_llocality` (`llocality`),
    KEY `i_vcard_search_lemail` (`lemail`),
    KEY `i_vcard_search_lorgname` (`lorgname`),
    KEY `i_vcard_search_lorgunit` (`lorgunit`),
    KEY `i_vcard_search_lmobilenumber` (`lmobilenumber`),
    KEY `i_vcard_search_lfn` (`username`),
    KEY `lusername` (`lusername`),
    KEY `i_vcard_search_sh_lfn` (`server_host`, `lfn`),
    KEY `i_vcard_search_sh_llocality` (`server_host`, `llocality`),
    KEY `i_vcard_search_sh_lnickname` (`server_host`, `lnickname`),
    KEY `i_vcard_search_sh_lctry` (`server_host`, `lctry`),
    KEY `i_vcard_search_sh_lgiven` (`server_host`, `lgiven`),
    KEY `i_vcard_search_sh_lmiddle` (`server_host`, `lmiddle`),
    KEY `i_vcard_search_sh_lorgname` (`server_host`, `lorgname`),
    KEY `i_vcard_search_sh_lfamily` (`server_host`, `lfamily`),
    KEY `i_vcard_search_sh_lbday` (`server_host`, `lbday`),
    KEY `i_vcard_search_sh_lemail` (`server_host`, `lemail`),
    KEY `i_vcard_search_sh_lorgunit` (`server_host`, `lorgunit`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

--
-- Table structure for table `vcard_xupdate`
--
CREATE TABLE `vcard_xupdate` (
    `username` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `hash` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`username`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;