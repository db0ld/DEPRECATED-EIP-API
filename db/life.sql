-- phpMyAdmin SQL Dump
-- version 3.3.7deb7
-- http://www.phpmyadmin.net
--
-- Serveur: localhost
-- Généré le : Sam 27 Octobre 2012 à 21:33
-- Version du serveur: 5.1.63
-- Version de PHP: 5.4.7-1~dotdeb.0


--
-- Base de données: `glife`
--

-- --------------------------------------------------------

CREATE TYPE privacy  AS ENUM ('enemy', 'pure', 'hardcore', 'discutable');
CREATE TYPE achievement_progress AS ENUM ('not_planned','planned','in_progress','give_up','done');

--
-- Structure de la table `achievement`
--

CREATE TABLE IF NOT EXISTS "achievement" (
  "id" SERIAL,
  "creation_time" timestamp NOT NULL,
  "modification_time" timestamp NOT NULL,
  "fk_creator_user_id" int NOT NULL,
  "fk_icon_media_id" int DEFAULT NULL,
  "fk_achievement_category_id" int NOT NULL,
  "fk_achivement_parent_id" int DEFAULT NULL,
  "default_privacy" privacy NOT NULL,
  PRIMARY KEY ("id")
) ;

--
-- RELATIONS POUR LA TABLE `achievement`:
--   `fk_achievement_category_id`
--       `achievement_category` -> `id`
--   `fk_achivement_parent_id`
--       `achievement` -> `id`
--   `fk_creator_user_id`
--       `user` -> `id`
--   `fk_icon_media_id`
--       `media` -> `id`
--

--
-- Contenu de la table `achievement`
--


-- --------------------------------------------------------

--
-- Structure de la table `achievement_category`
--

CREATE TABLE IF NOT EXISTS "achievement_category" (
  "id" SERIAL,
  "creation_time" timestamp NOT NULL,
  "modification_time" timestamp NOT NULL,
  "fk_creator_user_id" int NOT NULL,
  "fk_icon_media_id" int DEFAULT NULL,
  "fk_achivement_category_parent_id" int NOT NULL,
  PRIMARY KEY ("id")
)  ;

--
-- RELATIONS POUR LA TABLE `achievement_category`:
--   `fk_achivement_category_parent_id`
--       `achievement_category` -> `id`
--   `fk_creator_user_id`
--       `user` -> `id`
--   `fk_icon_media_id`
--       `media` -> `id`
--

--
-- Contenu de la table `achievement_category`
--


-- --------------------------------------------------------

--
-- Structure de la table `achievement_status`
--

CREATE TABLE IF NOT EXISTS "achievement_status" (
  "id" SERIAL,
  "creation_time" timestamp NOT NULL,
  "modification_time" timestamp NOT NULL,
  "fk_user_id" int NOT NULL,
  "fk_achievement_id" int NOT NULL,
  "state" achievement_progress NOT NULL,
  "privacy" privacy NOT NULL,
  PRIMARY KEY ("id")
)  ;

--
-- RELATIONS POUR LA TABLE `achievement_status`:
--   `fk_achievement_id`
--       `achievement` -> `id`
--   `fk_user_id`
--       `user` -> `id`
--

--
-- Contenu de la table `achievement_status`
--


-- --------------------------------------------------------

--
-- Structure de la table `achievement_status_change`
--

CREATE TABLE IF NOT EXISTS "achievement_status_change" (
  "id" SERIAL,
  "creation_time" timestamp NOT NULL,
  "modification_time" timestamp NOT NULL,
  "fk_achievement_status" int NOT NULL,
  "old_state" achievement_progress NOT NULL,
  "new_state" achievement_progress NOT NULL,
  "message" text NOT NULL,
  PRIMARY KEY ("id")
)  ;

--
-- RELATIONS POUR LA TABLE `achievement_status_change`:
--   `fk_achievement_status`
--       `achievement_status` -> `id`
--

--
-- Contenu de la table `achievement_status_change`
--


-- --------------------------------------------------------

--
-- Structure de la table `achievement_status_change_approvals`
--

CREATE TABLE IF NOT EXISTS "achievement_status_change_approvals" (
  "id" SERIAL,
  "creation_time" timestamp NOT NULL,
  "modification_time" timestamp NOT NULL,
  "fk_achievement_status_change" int NOT NULL,
  "fk_user_id" int NOT NULL,
  "approval" boolean NOT NULL,
  PRIMARY KEY ("id")
)  ;

--
-- RELATIONS POUR LA TABLE `achievement_status_change_approvals`:
--   `fk_achievement_status_change`
--       `achievement_status_change` -> `id`
--   `fk_user_id`
--       `user` -> `id`
--

--
-- Contenu de la table `achievement_status_change_approvals`
--


-- --------------------------------------------------------

--
-- Structure de la table `achievement_status_change_messages`
--

CREATE TABLE IF NOT EXISTS "achievement_status_change_messages" (
  "id" SERIAL,
  "creation_time" timestamp NOT NULL,
  "modification_time" timestamp NOT NULL,
  "fk_achievement_status_change" int NOT NULL,
  "fk_user_id" int NOT NULL,
  "message" text NOT NULL,
  PRIMARY KEY ("id")
) ;

--
-- RELATIONS POUR LA TABLE `achievement_status_change_messages`:
--   `fk_achievement_status_change`
--       `achievement_status_change` -> `id`
--   `fk_user_id`
--       `user` -> `id`
--

--
-- Contenu de la table `achievement_status_change_messages`
--


-- --------------------------------------------------------

--
-- Structure de la table `api_auth`
--

CREATE TABLE IF NOT EXISTS "api_auth" (
  "id" SERIAL,
  "creation_time" timestamp NOT NULL,
  "modification_time" timestamp NOT NULL,
  "expiration_time" timestamp NOT NULL,
  "fk_user_id" int NOT NULL,
  "fk_api_client_id" int NOT NULL,
  "token" varchar(40) NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT tokenunique1 UNIQUE ("token")
)  ;

--
-- RELATIONS POUR LA TABLE `api_auth`:
--   `fk_api_client_id`
--       `api_auth` -> `id`
--   `fk_user_id`
--       `user` -> `id`
--

--
-- Contenu de la table `api_auth`
--


-- --------------------------------------------------------

--
-- Structure de la table `api_client`
--

CREATE TABLE IF NOT EXISTS "api_client" (
  "id" SERIAL,
  "creation_time" timestamp NOT NULL,
  "modification_time" timestamp NOT NULL,
  "fk_creator_user_id" int NOT NULL,
  "name" varchar(64) NOT NULL,
  "secret" varchar(40) NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT nameunique1 UNIQUE ("name"),
  CONSTRAINT secretunique2 UNIQUE ("secret")
)  ;

--
-- RELATIONS POUR LA TABLE `api_client`:
--   `fk_creator_user_id`
--       `user` -> `id`
--

--
-- Contenu de la table `api_client`
--


-- --------------------------------------------------------

--
-- Structure de la table `i18n_achievement`
--

CREATE TABLE IF NOT EXISTS "i18n_achievement" (
  "id" SERIAL,
  "creation_time" timestamp NOT NULL,
  "modification_time" timestamp NOT NULL,
  "fk_achievement_category_id" int NOT NULL,
  "fk_locale_id" int NOT NULL,
  "title" text NOT NULL,
  "description" text NOT NULL,
  PRIMARY KEY ("id")
)  ;

--
-- RELATIONS POUR LA TABLE `i18n_achievement`:
--   `fk_achievement_category_id`
--       `achievement` -> `id`
--   `fk_locale_id`
--       `locale` -> `id`
--

--
-- Contenu de la table `i18n_achievement`
--


-- --------------------------------------------------------

--
-- Structure de la table `i18n_achievement_category`
--

CREATE TABLE IF NOT EXISTS "i18n_achievement_category" (
  "id" SERIAL,
  "creation_time" timestamp NOT NULL,
  "modification_time" timestamp NOT NULL,
  "fk_achievement_category_id" int NOT NULL,
  "fk_locale_id" int NOT NULL,
  "title" text NOT NULL,
  "description" text NOT NULL,
  PRIMARY KEY ("id")
)  ;

--
-- RELATIONS POUR LA TABLE `i18n_achievement_category`:
--   `fk_achievement_category_id`
--       `achievement_category` -> `id`
--   `fk_locale_id`
--       `locale` -> `id`
--

--
-- Contenu de la table `i18n_achievement_category`
--


-- --------------------------------------------------------

--
-- Structure de la table `locale`
--

CREATE TABLE IF NOT EXISTS "locale" (
  "id" SERIAL,
  "creation_time" timestamp NOT NULL,
  "modification_time" timestamp NOT NULL,
  "iso_code" varchar(5) NOT NULL,
  "local_name" varchar(128) NOT NULL,
  "english_name" varchar(128) NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT iso_codeunique1 UNIQUE ("iso_code")
)  ;

--
-- Contenu de la table `locale`
--


-- --------------------------------------------------------

--
-- Structure de la table `media`
--

CREATE TABLE IF NOT EXISTS "media" (
  "id" SERIAL,
  "creation_time" timestamp NOT NULL,
  "modification_time" timestamp NOT NULL,
  "fk_creator_user_id" int NOT NULL,
  "type" varchar(8) NOT NULL,
  "path" varchar(256) NOT NULL,
  "metadata" text,
  PRIMARY KEY ("id"),
  CONSTRAINT pathunique1 UNIQUE ("path")
)  ;

--
-- RELATIONS POUR LA TABLE `media`:
--   `fk_creator_user_id`
--       `user` -> `id`
--

--
-- Contenu de la table `media`
--


-- --------------------------------------------------------

--
-- Structure de la table `user`
--

CREATE TABLE IF NOT EXISTS "user" (
  "id" SERIAL,
  "creation_time" timestamp NOT NULL,
  "modification_time" timestamp NOT NULL,
  "login" varchar(64) NOT NULL,
  "firstname" varchar(128) NOT NULL,
  "surname" varchar(128) NOT NULL,
  "gender" varchar(64) NOT NULL,
  "birthdate" date DEFAULT NULL,
  "email" varchar(255) NOT NULL,
  "password_hash" varchar(8) NOT NULL,
  "password_salt" varchar(40) NOT NULL,
  "fk_avatar_media_id" int DEFAULT NULL,
  "fk_locale_id" int NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT emailunique1 UNIQUE ("email"),
  CONSTRAINT loginunique2 UNIQUE ("login")
)  ;

--
-- RELATIONS POUR LA TABLE `user`:
--   `fk_avatar_media_id`
--       `media` -> `id`
--   `fk_locale_id`
--       `locale` -> `id`
--

--
-- Contenu de la table `user`
--


-- --------------------------------------------------------

--
-- Structure de la table `user_friendship`
--

CREATE TABLE IF NOT EXISTS "user_friendship" (
  "id" SERIAL,
  "creation_time" timestamp NOT NULL,
  "modification_time" timestamp NOT NULL,
  "fk_user1_id" int NOT NULL,
  "user1_privacy" privacy NOT NULL,
  "fk_user2_id" int NOT NULL,
  "user2_privacy" privacy NOT NULL,
  PRIMARY KEY ("id")
)  ;

--
-- RELATIONS POUR LA TABLE `user_friendship`:
--   `fk_user1_id`
--       `user` -> `id`
--   `fk_user2_id`
--       `user` -> `id`
--

--
-- Contenu de la table `user_friendship`
--

