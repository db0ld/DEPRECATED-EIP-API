--
-- PostgreSQL database dump
--

-- Dumped from database version 9.2.2
-- Dumped by pg_dump version 9.2.2
-- Started on 2013-01-07 00:10:39

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 210 (class 3079 OID 11727)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2196 (class 0 OID 0)
-- Dependencies: 210
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- TOC entry 556 (class 1247 OID 16406)
-- Name: achievement_progress; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE achievement_progress AS ENUM (
    'not_planned',
    'planned',
    'in_progress',
    'give_up',
    'done'
);


--
-- TOC entry 553 (class 1247 OID 16396)
-- Name: privacy; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE privacy AS ENUM (
    'enemy',
    'pure',
    'hardcore',
    'discutable'
);


SET default_with_oids = false;

--
-- TOC entry 169 (class 1259 OID 16419)
-- Name: achievement; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE achievement (
    id integer NOT NULL,
    creation_time timestamp without time zone NOT NULL,
    modification_time timestamp without time zone NOT NULL,
    fk_creator_user_id integer NOT NULL,
    fk_icon_media_id integer,
    fk_achievement_category_id integer NOT NULL,
    fk_achievement_parent_id integer,
    default_privacy privacy NOT NULL
);


--
-- TOC entry 171 (class 1259 OID 16427)
-- Name: achievement_category; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE achievement_category (
    id integer NOT NULL,
    creation_time timestamp without time zone NOT NULL,
    modification_time timestamp without time zone NOT NULL,
    fk_creator_user_id integer NOT NULL,
    fk_icon_media_id integer,
    fk_achievement_category_parent_id integer NOT NULL
);


--
-- TOC entry 170 (class 1259 OID 16425)
-- Name: achievement_category_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE achievement_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2197 (class 0 OID 0)
-- Dependencies: 170
-- Name: achievement_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE achievement_category_id_seq OWNED BY achievement_category.id;


--
-- TOC entry 168 (class 1259 OID 16417)
-- Name: achievement_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE achievement_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2198 (class 0 OID 0)
-- Dependencies: 168
-- Name: achievement_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE achievement_id_seq OWNED BY achievement.id;


--
-- TOC entry 177 (class 1259 OID 16454)
-- Name: vote; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE vote (
    id integer NOT NULL,
    creation_time timestamp without time zone NOT NULL,
    modification_time timestamp without time zone NOT NULL,
    fk_voteable_id integer NOT NULL,
    fk_user_id integer NOT NULL,
    vote integer
);


--
-- TOC entry 176 (class 1259 OID 16452)
-- Name: achievement_status_change_approvals_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE achievement_status_change_approvals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2199 (class 0 OID 0)
-- Dependencies: 176
-- Name: achievement_status_change_approvals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE achievement_status_change_approvals_id_seq OWNED BY vote.id;


--
-- TOC entry 175 (class 1259 OID 16443)
-- Name: user_achievement_status; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE user_achievement_status (
    id integer NOT NULL,
    creation_time timestamp without time zone NOT NULL,
    modification_time timestamp without time zone NOT NULL,
    fk_user_status integer NOT NULL,
    new_state achievement_progress NOT NULL,
    fk_user_achievement integer NOT NULL,
    old_state achievement_progress
);


--
-- TOC entry 174 (class 1259 OID 16441)
-- Name: achievement_status_change_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE achievement_status_change_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2200 (class 0 OID 0)
-- Dependencies: 174
-- Name: achievement_status_change_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE achievement_status_change_id_seq OWNED BY user_achievement_status.id;


--
-- TOC entry 179 (class 1259 OID 16462)
-- Name: comment; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE comment (
    id integer NOT NULL,
    creation_time timestamp without time zone NOT NULL,
    modification_time timestamp without time zone NOT NULL,
    fk_commentable_id integer NOT NULL,
    fk_user_id integer NOT NULL,
    comment text NOT NULL,
    fk_media_id integer,
    fk_comment_id integer
);


--
-- TOC entry 178 (class 1259 OID 16460)
-- Name: achievement_status_change_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE achievement_status_change_messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2201 (class 0 OID 0)
-- Dependencies: 178
-- Name: achievement_status_change_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE achievement_status_change_messages_id_seq OWNED BY comment.id;


--
-- TOC entry 173 (class 1259 OID 16435)
-- Name: user_achievements; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE user_achievements (
    id integer NOT NULL,
    creation_time timestamp without time zone NOT NULL,
    modification_time timestamp without time zone NOT NULL,
    fk_user_id integer NOT NULL,
    fk_achievement_id integer NOT NULL,
    state achievement_progress NOT NULL,
    privacy privacy NOT NULL
);


--
-- TOC entry 172 (class 1259 OID 16433)
-- Name: achievement_status_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE achievement_status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2202 (class 0 OID 0)
-- Dependencies: 172
-- Name: achievement_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE achievement_status_id_seq OWNED BY user_achievements.id;


--
-- TOC entry 181 (class 1259 OID 16473)
-- Name: api_auth; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE api_auth (
    id integer NOT NULL,
    creation_time timestamp without time zone NOT NULL,
    modification_time timestamp without time zone NOT NULL,
    expiration_time timestamp without time zone NOT NULL,
    fk_user_id integer NOT NULL,
    fk_api_client_id integer NOT NULL,
    token character varying(40) NOT NULL
);


--
-- TOC entry 180 (class 1259 OID 16471)
-- Name: api_auth_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE api_auth_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2203 (class 0 OID 0)
-- Dependencies: 180
-- Name: api_auth_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE api_auth_id_seq OWNED BY api_auth.id;


--
-- TOC entry 183 (class 1259 OID 16483)
-- Name: api_client; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE api_client (
    id integer NOT NULL,
    creation_time timestamp without time zone NOT NULL,
    modification_time timestamp without time zone NOT NULL,
    fk_creator_user_id integer NOT NULL,
    name character varying(64) NOT NULL,
    secret character varying(40) NOT NULL
);


--
-- TOC entry 182 (class 1259 OID 16481)
-- Name: api_client_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE api_client_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2204 (class 0 OID 0)
-- Dependencies: 182
-- Name: api_client_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE api_client_id_seq OWNED BY api_client.id;


--
-- TOC entry 205 (class 1259 OID 40972)
-- Name: commentable; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE commentable (
    id integer NOT NULL,
    creation_time timestamp without time zone NOT NULL,
    modification_time timestamp without time zone NOT NULL
);


--
-- TOC entry 204 (class 1259 OID 40970)
-- Name: commentable_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE commentable_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2205 (class 0 OID 0)
-- Dependencies: 204
-- Name: commentable_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE commentable_id_seq OWNED BY commentable.id;


--
-- TOC entry 203 (class 1259 OID 24630)
-- Name: flagged_content; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE flagged_content (
    id integer NOT NULL,
    creation_time timestamp without time zone NOT NULL,
    modification_time timestamp without time zone NOT NULL,
    fk_user_id integer,
    url text NOT NULL
);


--
-- TOC entry 202 (class 1259 OID 24628)
-- Name: flagged_content_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE flagged_content_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2206 (class 0 OID 0)
-- Dependencies: 202
-- Name: flagged_content_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE flagged_content_id_seq OWNED BY flagged_content.id;


--
-- TOC entry 185 (class 1259 OID 16495)
-- Name: i18n_achievement; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE i18n_achievement (
    id integer NOT NULL,
    creation_time timestamp without time zone NOT NULL,
    modification_time timestamp without time zone NOT NULL,
    fk_achievement_id integer NOT NULL,
    fk_locale_id integer NOT NULL,
    title text NOT NULL,
    description text NOT NULL
);


--
-- TOC entry 187 (class 1259 OID 16506)
-- Name: i18n_achievement_category; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE i18n_achievement_category (
    id integer NOT NULL,
    creation_time timestamp without time zone NOT NULL,
    modification_time timestamp without time zone NOT NULL,
    fk_achievement_category_id integer NOT NULL,
    fk_locale_id integer NOT NULL,
    title text NOT NULL,
    description text NOT NULL
);


--
-- TOC entry 186 (class 1259 OID 16504)
-- Name: i18n_achievement_category_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE i18n_achievement_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2207 (class 0 OID 0)
-- Dependencies: 186
-- Name: i18n_achievement_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE i18n_achievement_category_id_seq OWNED BY i18n_achievement_category.id;


--
-- TOC entry 184 (class 1259 OID 16493)
-- Name: i18n_achievement_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE i18n_achievement_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2208 (class 0 OID 0)
-- Dependencies: 184
-- Name: i18n_achievement_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE i18n_achievement_id_seq OWNED BY i18n_achievement.id;


--
-- TOC entry 189 (class 1259 OID 16517)
-- Name: locale; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE locale (
    id integer NOT NULL,
    creation_time timestamp without time zone NOT NULL,
    modification_time timestamp without time zone NOT NULL,
    iso_code character varying(5) NOT NULL,
    local_name character varying(128) NOT NULL,
    english_name character varying(128) NOT NULL
);


--
-- TOC entry 188 (class 1259 OID 16515)
-- Name: locale_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE locale_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2209 (class 0 OID 0)
-- Dependencies: 188
-- Name: locale_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE locale_id_seq OWNED BY locale.id;


--
-- TOC entry 191 (class 1259 OID 16527)
-- Name: media; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE media (
    id integer NOT NULL,
    creation_time timestamp without time zone NOT NULL,
    modification_time timestamp without time zone NOT NULL,
    fk_creator_user_id integer NOT NULL,
    type character varying(8) NOT NULL,
    path character varying(256) NOT NULL,
    metadata text
);


--
-- TOC entry 190 (class 1259 OID 16525)
-- Name: media_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE media_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2210 (class 0 OID 0)
-- Dependencies: 190
-- Name: media_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE media_id_seq OWNED BY media.id;


--
-- TOC entry 193 (class 1259 OID 16540)
-- Name: user; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "user" (
    id integer NOT NULL,
    creation_time timestamp without time zone NOT NULL,
    modification_time timestamp without time zone NOT NULL,
    login character varying(64) NOT NULL,
    firstname character varying(128) NOT NULL,
    surname character varying(128) NOT NULL,
    gender character varying(64) NOT NULL,
    birthdate date,
    email character varying(255) NOT NULL,
    password_hash character varying(8) NOT NULL,
    password_salt character varying(40) NOT NULL,
    fk_avatar_media_id integer,
    fk_locale_id integer NOT NULL,
    email_code character varying(64),
    verified boolean DEFAULT false NOT NULL
);


--
-- TOC entry 197 (class 1259 OID 24581)
-- Name: user_achievement_categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE user_achievement_categories (
    id integer NOT NULL,
    creation_time timestamp without time zone NOT NULL,
    modification_time timestamp without time zone NOT NULL,
    fk_user_id integer NOT NULL,
    fk_achievement_category_id integer NOT NULL
);


--
-- TOC entry 196 (class 1259 OID 24579)
-- Name: user_achievement_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_achievement_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2211 (class 0 OID 0)
-- Dependencies: 196
-- Name: user_achievement_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_achievement_categories_id_seq OWNED BY user_achievement_categories.id;


--
-- TOC entry 195 (class 1259 OID 16555)
-- Name: user_friendship; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE user_friendship (
    id integer NOT NULL,
    creation_time timestamp without time zone NOT NULL,
    modification_time timestamp without time zone NOT NULL,
    fk_user1_id integer NOT NULL,
    user1_privacy privacy NOT NULL,
    fk_user2_id integer NOT NULL,
    user2_privacy privacy NOT NULL
);


--
-- TOC entry 194 (class 1259 OID 16553)
-- Name: user_friendship_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_friendship_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2212 (class 0 OID 0)
-- Dependencies: 194
-- Name: user_friendship_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_friendship_id_seq OWNED BY user_friendship.id;


--
-- TOC entry 192 (class 1259 OID 16538)
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2213 (class 0 OID 0)
-- Dependencies: 192
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_id_seq OWNED BY "user".id;


--
-- TOC entry 201 (class 1259 OID 24612)
-- Name: user_role; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE user_role (
    id integer NOT NULL,
    creation_time timestamp without time zone NOT NULL,
    modification_time timestamp without time zone NOT NULL,
    fk_user_id integer NOT NULL,
    role character varying(64)
);


--
-- TOC entry 200 (class 1259 OID 24610)
-- Name: user_role_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2214 (class 0 OID 0)
-- Dependencies: 200
-- Name: user_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_role_id_seq OWNED BY user_role.id;


--
-- TOC entry 209 (class 1259 OID 41017)
-- Name: user_status; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE user_status (
    id integer NOT NULL,
    creation_time timestamp without time zone NOT NULL,
    modification_time timestamp without time zone NOT NULL,
    fk_user_id integer NOT NULL,
    fk_commentable_id integer NOT NULL,
    fk_voteable_id integer NOT NULL,
    status character varying(500) NOT NULL
);


--
-- TOC entry 208 (class 1259 OID 41015)
-- Name: user_status_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2215 (class 0 OID 0)
-- Dependencies: 208
-- Name: user_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_status_id_seq OWNED BY user_status.id;


--
-- TOC entry 199 (class 1259 OID 24599)
-- Name: user_thirdparty_creds; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE user_thirdparty_creds (
    id integer NOT NULL,
    creation_time timestamp without time zone NOT NULL,
    modification_time timestamp without time zone NOT NULL,
    provider character varying(32) NOT NULL,
    account_id character varying(128) NOT NULL,
    fk_user_id integer NOT NULL
);


--
-- TOC entry 198 (class 1259 OID 24597)
-- Name: user_thirdparty_creds_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_thirdparty_creds_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2216 (class 0 OID 0)
-- Dependencies: 198
-- Name: user_thirdparty_creds_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_thirdparty_creds_id_seq OWNED BY user_thirdparty_creds.id;


--
-- TOC entry 207 (class 1259 OID 40980)
-- Name: voteable; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE voteable (
    id integer NOT NULL,
    creation_time timestamp without time zone NOT NULL,
    modification_time timestamp without time zone NOT NULL
);


--
-- TOC entry 206 (class 1259 OID 40978)
-- Name: voteable_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE voteable_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2217 (class 0 OID 0)
-- Dependencies: 206
-- Name: voteable_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE voteable_id_seq OWNED BY voteable.id;


--
-- TOC entry 2050 (class 2604 OID 16422)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY achievement ALTER COLUMN id SET DEFAULT nextval('achievement_id_seq'::regclass);


--
-- TOC entry 2051 (class 2604 OID 16430)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY achievement_category ALTER COLUMN id SET DEFAULT nextval('achievement_category_id_seq'::regclass);


--
-- TOC entry 2056 (class 2604 OID 16476)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY api_auth ALTER COLUMN id SET DEFAULT nextval('api_auth_id_seq'::regclass);


--
-- TOC entry 2057 (class 2604 OID 16486)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY api_client ALTER COLUMN id SET DEFAULT nextval('api_client_id_seq'::regclass);


--
-- TOC entry 2055 (class 2604 OID 16465)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY comment ALTER COLUMN id SET DEFAULT nextval('achievement_status_change_messages_id_seq'::regclass);


--
-- TOC entry 2069 (class 2604 OID 40975)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY commentable ALTER COLUMN id SET DEFAULT nextval('commentable_id_seq'::regclass);


--
-- TOC entry 2068 (class 2604 OID 24633)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY flagged_content ALTER COLUMN id SET DEFAULT nextval('flagged_content_id_seq'::regclass);


--
-- TOC entry 2058 (class 2604 OID 16498)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY i18n_achievement ALTER COLUMN id SET DEFAULT nextval('i18n_achievement_id_seq'::regclass);


--
-- TOC entry 2059 (class 2604 OID 16509)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY i18n_achievement_category ALTER COLUMN id SET DEFAULT nextval('i18n_achievement_category_id_seq'::regclass);


--
-- TOC entry 2060 (class 2604 OID 16520)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY locale ALTER COLUMN id SET DEFAULT nextval('locale_id_seq'::regclass);


--
-- TOC entry 2061 (class 2604 OID 16530)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY media ALTER COLUMN id SET DEFAULT nextval('media_id_seq'::regclass);


--
-- TOC entry 2062 (class 2604 OID 16543)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "user" ALTER COLUMN id SET DEFAULT nextval('user_id_seq'::regclass);


--
-- TOC entry 2065 (class 2604 OID 24584)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_achievement_categories ALTER COLUMN id SET DEFAULT nextval('user_achievement_categories_id_seq'::regclass);


--
-- TOC entry 2053 (class 2604 OID 16446)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_achievement_status ALTER COLUMN id SET DEFAULT nextval('achievement_status_change_id_seq'::regclass);


--
-- TOC entry 2052 (class 2604 OID 16438)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_achievements ALTER COLUMN id SET DEFAULT nextval('achievement_status_id_seq'::regclass);


--
-- TOC entry 2064 (class 2604 OID 16558)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_friendship ALTER COLUMN id SET DEFAULT nextval('user_friendship_id_seq'::regclass);


--
-- TOC entry 2067 (class 2604 OID 24615)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_role ALTER COLUMN id SET DEFAULT nextval('user_role_id_seq'::regclass);


--
-- TOC entry 2071 (class 2604 OID 41020)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_status ALTER COLUMN id SET DEFAULT nextval('user_status_id_seq'::regclass);


--
-- TOC entry 2066 (class 2604 OID 24602)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_thirdparty_creds ALTER COLUMN id SET DEFAULT nextval('user_thirdparty_creds_id_seq'::regclass);


--
-- TOC entry 2054 (class 2604 OID 16457)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY vote ALTER COLUMN id SET DEFAULT nextval('achievement_status_change_approvals_id_seq'::regclass);


--
-- TOC entry 2070 (class 2604 OID 40983)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY voteable ALTER COLUMN id SET DEFAULT nextval('voteable_id_seq'::regclass);


--
-- TOC entry 2079 (class 2606 OID 16432)
-- Name: achievement_category_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY achievement_category
    ADD CONSTRAINT achievement_category_pkey PRIMARY KEY (id);


--
-- TOC entry 2073 (class 2606 OID 16424)
-- Name: achievement_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY achievement
    ADD CONSTRAINT achievement_pkey PRIMARY KEY (id);


--
-- TOC entry 2099 (class 2606 OID 16478)
-- Name: api_auth_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY api_auth
    ADD CONSTRAINT api_auth_pkey PRIMARY KEY (id);


--
-- TOC entry 2105 (class 2606 OID 16488)
-- Name: api_client_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY api_client
    ADD CONSTRAINT api_client_pkey PRIMARY KEY (id);


--
-- TOC entry 2095 (class 2606 OID 40999)
-- Name: comment_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY comment
    ADD CONSTRAINT comment_pkey PRIMARY KEY (id);


--
-- TOC entry 2149 (class 2606 OID 40977)
-- Name: commentable_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY commentable
    ADD CONSTRAINT commentable_pkey PRIMARY KEY (id);


--
-- TOC entry 2129 (class 2606 OID 16550)
-- Name: emailunique1; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT emailunique1 UNIQUE (email);


--
-- TOC entry 2147 (class 2606 OID 24638)
-- Name: flagged_content_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY flagged_content
    ADD CONSTRAINT flagged_content_pkey PRIMARY KEY (id);


--
-- TOC entry 2118 (class 2606 OID 16514)
-- Name: i18n_achievement_category_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY i18n_achievement_category
    ADD CONSTRAINT i18n_achievement_category_pkey PRIMARY KEY (id);


--
-- TOC entry 2114 (class 2606 OID 16503)
-- Name: i18n_achievement_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY i18n_achievement
    ADD CONSTRAINT i18n_achievement_pkey PRIMARY KEY (id);


--
-- TOC entry 2120 (class 2606 OID 16524)
-- Name: iso_codeunique1; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY locale
    ADD CONSTRAINT iso_codeunique1 UNIQUE (iso_code);


--
-- TOC entry 2122 (class 2606 OID 16522)
-- Name: locale_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY locale
    ADD CONSTRAINT locale_pkey PRIMARY KEY (id);


--
-- TOC entry 2133 (class 2606 OID 16552)
-- Name: loginunique2; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT loginunique2 UNIQUE (login);


--
-- TOC entry 2125 (class 2606 OID 16535)
-- Name: media_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY media
    ADD CONSTRAINT media_pkey PRIMARY KEY (id);


--
-- TOC entry 2108 (class 2606 OID 16490)
-- Name: nameunique1; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY api_client
    ADD CONSTRAINT nameunique1 UNIQUE (name);


--
-- TOC entry 2127 (class 2606 OID 16537)
-- Name: pathunique1; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY media
    ADD CONSTRAINT pathunique1 UNIQUE (path);


--
-- TOC entry 2110 (class 2606 OID 16492)
-- Name: secretunique2; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY api_client
    ADD CONSTRAINT secretunique2 UNIQUE (secret);


--
-- TOC entry 2103 (class 2606 OID 16480)
-- Name: tokenunique1; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY api_auth
    ADD CONSTRAINT tokenunique1 UNIQUE (token);


--
-- TOC entry 2141 (class 2606 OID 24586)
-- Name: user_achievement_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_achievement_categories
    ADD CONSTRAINT user_achievement_categories_pkey PRIMARY KEY (id);


--
-- TOC entry 2089 (class 2606 OID 41042)
-- Name: user_achievement_status_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_achievement_status
    ADD CONSTRAINT user_achievement_status_pkey PRIMARY KEY (id);


--
-- TOC entry 2086 (class 2606 OID 16440)
-- Name: user_achievements_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_achievements
    ADD CONSTRAINT user_achievements_pkey PRIMARY KEY (id);


--
-- TOC entry 2139 (class 2606 OID 16560)
-- Name: user_friendship_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_friendship
    ADD CONSTRAINT user_friendship_pkey PRIMARY KEY (id);


--
-- TOC entry 2135 (class 2606 OID 16548)
-- Name: user_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- TOC entry 2145 (class 2606 OID 24617)
-- Name: user_role_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_role
    ADD CONSTRAINT user_role_pkey PRIMARY KEY (id);


--
-- TOC entry 2153 (class 2606 OID 41025)
-- Name: user_status_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_status
    ADD CONSTRAINT user_status_pkey PRIMARY KEY (id);


--
-- TOC entry 2143 (class 2606 OID 24604)
-- Name: user_thirdparty_creds_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_thirdparty_creds
    ADD CONSTRAINT user_thirdparty_creds_pkey PRIMARY KEY (id);


--
-- TOC entry 2093 (class 2606 OID 40987)
-- Name: vote_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY vote
    ADD CONSTRAINT vote_pkey PRIMARY KEY (id);


--
-- TOC entry 2151 (class 2606 OID 40985)
-- Name: voteable_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY voteable
    ADD CONSTRAINT voteable_pkey PRIMARY KEY (id);


--
-- TOC entry 2080 (class 1259 OID 16620)
-- Name: fki_achievement_category_fk_achievement_category_parent_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_achievement_category_fk_achievement_category_parent_id ON achievement_category USING btree (fk_achievement_category_parent_id);


--
-- TOC entry 2081 (class 1259 OID 16608)
-- Name: fki_achievement_category_fk_creator_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_achievement_category_fk_creator_user_id ON achievement_category USING btree (fk_creator_user_id);


--
-- TOC entry 2082 (class 1259 OID 16614)
-- Name: fki_achievement_category_fk_icon_media_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_achievement_category_fk_icon_media_id ON achievement_category USING btree (fk_icon_media_id);


--
-- TOC entry 2074 (class 1259 OID 16602)
-- Name: fki_achievement_fk_achievement_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_achievement_fk_achievement_id ON achievement USING btree (fk_achievement_parent_id);


--
-- TOC entry 2090 (class 1259 OID 16644)
-- Name: fki_achievement_status_change_approvals_fk_achievement_status_c; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_achievement_status_change_approvals_fk_achievement_status_c ON vote USING btree (fk_voteable_id);


--
-- TOC entry 2091 (class 1259 OID 16650)
-- Name: fki_achievement_status_change_approvals_fk_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_achievement_status_change_approvals_fk_user_id ON vote USING btree (fk_user_id);


--
-- TOC entry 2087 (class 1259 OID 16638)
-- Name: fki_achievement_status_change_fk_achievement_status_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_achievement_status_change_fk_achievement_status_id ON user_achievement_status USING btree (fk_user_status);


--
-- TOC entry 2096 (class 1259 OID 16656)
-- Name: fki_achievement_status_change_message_fk_achievement_status_cha; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_achievement_status_change_message_fk_achievement_status_cha ON comment USING btree (fk_commentable_id);


--
-- TOC entry 2097 (class 1259 OID 16662)
-- Name: fki_achievement_status_change_message_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_achievement_status_change_message_user_id ON comment USING btree (fk_user_id);


--
-- TOC entry 2083 (class 1259 OID 16632)
-- Name: fki_achievement_status_fk_achievement_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_achievement_status_fk_achievement_id ON user_achievements USING btree (fk_achievement_id);


--
-- TOC entry 2084 (class 1259 OID 16626)
-- Name: fki_achievement_status_fk_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_achievement_status_fk_user_id ON user_achievements USING btree (fk_user_id);


--
-- TOC entry 2075 (class 1259 OID 16596)
-- Name: fki_achivement_fk_achivement_category_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_achivement_fk_achivement_category_id ON achievement USING btree (fk_achievement_category_id);


--
-- TOC entry 2100 (class 1259 OID 16674)
-- Name: fki_api_auth_fk_api_client_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_api_auth_fk_api_client_id ON api_auth USING btree (fk_api_client_id);


--
-- TOC entry 2101 (class 1259 OID 16668)
-- Name: fki_api_auth_fk_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_api_auth_fk_user_id ON api_auth USING btree (fk_user_id);


--
-- TOC entry 2106 (class 1259 OID 16680)
-- Name: fki_api_client_fk_creator_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_api_client_fk_creator_user_id ON api_client USING btree (fk_creator_user_id);


--
-- TOC entry 2111 (class 1259 OID 16567)
-- Name: fki_const_achivement_category_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_const_achivement_category_id ON i18n_achievement USING btree (fk_achievement_id);


--
-- TOC entry 2112 (class 1259 OID 16573)
-- Name: fki_const_locale_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_const_locale_id ON i18n_achievement USING btree (fk_locale_id);


--
-- TOC entry 2076 (class 1259 OID 16585)
-- Name: fki_const_media_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_const_media_id ON achievement USING btree (fk_icon_media_id);


--
-- TOC entry 2077 (class 1259 OID 16579)
-- Name: fki_const_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_const_user_id ON achievement USING btree (fk_creator_user_id);


--
-- TOC entry 2115 (class 1259 OID 16696)
-- Name: fki_i18n_achievement_category_fk_achievement_category_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_i18n_achievement_category_fk_achievement_category_id ON i18n_achievement_category USING btree (fk_achievement_category_id);


--
-- TOC entry 2116 (class 1259 OID 16702)
-- Name: fki_i18n_achievement_category_locale_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_i18n_achievement_category_locale_id ON i18n_achievement_category USING btree (fk_locale_id);


--
-- TOC entry 2123 (class 1259 OID 16708)
-- Name: fki_media_fk_creator_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_media_fk_creator_user_id ON media USING btree (fk_creator_user_id);


--
-- TOC entry 2130 (class 1259 OID 16714)
-- Name: fki_user_fk_avatar_media_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_user_fk_avatar_media_id ON "user" USING btree (fk_avatar_media_id);


--
-- TOC entry 2131 (class 1259 OID 16720)
-- Name: fki_user_fk_locale_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_user_fk_locale_id ON "user" USING btree (fk_locale_id);


--
-- TOC entry 2136 (class 1259 OID 16726)
-- Name: fki_user_friendship_fk_user1_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_user_friendship_fk_user1_id ON user_friendship USING btree (fk_user1_id);


--
-- TOC entry 2137 (class 1259 OID 16732)
-- Name: fki_user_friendship_fk_user2_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_user_friendship_fk_user2_id ON user_friendship USING btree (fk_user2_id);


--
-- TOC entry 2160 (class 2606 OID 16615)
-- Name: achievement_category_fk_achievement_category_parent_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY achievement_category
    ADD CONSTRAINT achievement_category_fk_achievement_category_parent_id FOREIGN KEY (fk_achievement_category_parent_id) REFERENCES achievement_category(id);


--
-- TOC entry 2158 (class 2606 OID 16603)
-- Name: achievement_category_fk_creator_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY achievement_category
    ADD CONSTRAINT achievement_category_fk_creator_user_id FOREIGN KEY (fk_creator_user_id) REFERENCES "user"(id);


--
-- TOC entry 2159 (class 2606 OID 16609)
-- Name: achievement_category_fk_icon_media_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY achievement_category
    ADD CONSTRAINT achievement_category_fk_icon_media_id FOREIGN KEY (fk_icon_media_id) REFERENCES media(id);


--
-- TOC entry 2156 (class 2606 OID 16591)
-- Name: achievement_fk_achievement_category_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY achievement
    ADD CONSTRAINT achievement_fk_achievement_category_id FOREIGN KEY (fk_achievement_category_id) REFERENCES achievement(id);


--
-- TOC entry 2157 (class 2606 OID 16597)
-- Name: achievement_fk_achievement_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY achievement
    ADD CONSTRAINT achievement_fk_achievement_id FOREIGN KEY (fk_achievement_parent_id) REFERENCES achievement(id);


--
-- TOC entry 2154 (class 2606 OID 16580)
-- Name: achievement_fk_media_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY achievement
    ADD CONSTRAINT achievement_fk_media_id FOREIGN KEY (fk_icon_media_id) REFERENCES media(id);


--
-- TOC entry 2155 (class 2606 OID 16574)
-- Name: achievement_fk_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY achievement
    ADD CONSTRAINT achievement_fk_user_id FOREIGN KEY (fk_creator_user_id) REFERENCES "user"(id);


--
-- TOC entry 2171 (class 2606 OID 16669)
-- Name: api_auth_fk_api_client_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY api_auth
    ADD CONSTRAINT api_auth_fk_api_client_id FOREIGN KEY (fk_api_client_id) REFERENCES api_client(id);


--
-- TOC entry 2170 (class 2606 OID 16663)
-- Name: api_auth_fk_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY api_auth
    ADD CONSTRAINT api_auth_fk_user_id FOREIGN KEY (fk_user_id) REFERENCES "user"(id);


--
-- TOC entry 2172 (class 2606 OID 16675)
-- Name: api_client_fk_creator_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY api_client
    ADD CONSTRAINT api_client_fk_creator_user_id FOREIGN KEY (fk_creator_user_id) REFERENCES "user"(id);


--
-- TOC entry 2167 (class 2606 OID 41000)
-- Name: comment_fk_commentable_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY comment
    ADD CONSTRAINT comment_fk_commentable_id FOREIGN KEY (fk_commentable_id) REFERENCES commentable(id);


--
-- TOC entry 2169 (class 2606 OID 41010)
-- Name: comment_fk_media_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY comment
    ADD CONSTRAINT comment_fk_media_id FOREIGN KEY (fk_media_id) REFERENCES media(id);


--
-- TOC entry 2168 (class 2606 OID 41005)
-- Name: comment_fk_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY comment
    ADD CONSTRAINT comment_fk_user_id FOREIGN KEY (fk_user_id) REFERENCES "user"(id);


--
-- TOC entry 2186 (class 2606 OID 32768)
-- Name: flagged_content_fk_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY flagged_content
    ADD CONSTRAINT flagged_content_fk_user_id_fkey FOREIGN KEY (fk_user_id) REFERENCES "user"(id);


--
-- TOC entry 2175 (class 2606 OID 16691)
-- Name: i18n_achievement_category_fk_achievement_category_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY i18n_achievement_category
    ADD CONSTRAINT i18n_achievement_category_fk_achievement_category_id FOREIGN KEY (fk_achievement_category_id) REFERENCES achievement_category(id);


--
-- TOC entry 2176 (class 2606 OID 16697)
-- Name: i18n_achievement_category_locale_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY i18n_achievement_category
    ADD CONSTRAINT i18n_achievement_category_locale_id FOREIGN KEY (fk_locale_id) REFERENCES achievement(id);


--
-- TOC entry 2173 (class 2606 OID 16681)
-- Name: i18n_achievement_fk_achievement_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY i18n_achievement
    ADD CONSTRAINT i18n_achievement_fk_achievement_id FOREIGN KEY (fk_achievement_id) REFERENCES achievement(id);


--
-- TOC entry 2174 (class 2606 OID 16686)
-- Name: i18n_achievement_fk_locale_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY i18n_achievement
    ADD CONSTRAINT i18n_achievement_fk_locale_id FOREIGN KEY (fk_locale_id) REFERENCES i18n_achievement_category(id);


--
-- TOC entry 2177 (class 2606 OID 16703)
-- Name: media_fk_creator_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY media
    ADD CONSTRAINT media_fk_creator_user_id FOREIGN KEY (fk_creator_user_id) REFERENCES "user"(id);


--
-- TOC entry 2183 (class 2606 OID 24592)
-- Name: user_achievement_categories_fk_achievement_category; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_achievement_categories
    ADD CONSTRAINT user_achievement_categories_fk_achievement_category FOREIGN KEY (fk_achievement_category_id) REFERENCES achievement_category(id);


--
-- TOC entry 2182 (class 2606 OID 24587)
-- Name: user_achievement_categories_fk_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_achievement_categories
    ADD CONSTRAINT user_achievement_categories_fk_user_id FOREIGN KEY (fk_user_id) REFERENCES "user"(id);


--
-- TOC entry 2164 (class 2606 OID 41048)
-- Name: user_achievement_status_fk_user_achievement_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_achievement_status
    ADD CONSTRAINT user_achievement_status_fk_user_achievement_id FOREIGN KEY (fk_user_achievement) REFERENCES user_achievements(id);


--
-- TOC entry 2163 (class 2606 OID 41043)
-- Name: user_achievement_status_fk_user_status; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_achievement_status
    ADD CONSTRAINT user_achievement_status_fk_user_status FOREIGN KEY (fk_user_status) REFERENCES user_status(id);


--
-- TOC entry 2161 (class 2606 OID 40960)
-- Name: user_achievements_fk_achievement_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_achievements
    ADD CONSTRAINT user_achievements_fk_achievement_id FOREIGN KEY (fk_achievement_id) REFERENCES achievement(id);


--
-- TOC entry 2162 (class 2606 OID 40965)
-- Name: user_achievements_fk_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_achievements
    ADD CONSTRAINT user_achievements_fk_user_id FOREIGN KEY (fk_user_id) REFERENCES achievement(id);


--
-- TOC entry 2178 (class 2606 OID 16709)
-- Name: user_fk_avatar_media_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_fk_avatar_media_id FOREIGN KEY (fk_avatar_media_id) REFERENCES media(id);


--
-- TOC entry 2179 (class 2606 OID 16715)
-- Name: user_fk_locale_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_fk_locale_id FOREIGN KEY (fk_locale_id) REFERENCES locale(id);


--
-- TOC entry 2180 (class 2606 OID 16721)
-- Name: user_friendship_fk_user1_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_friendship
    ADD CONSTRAINT user_friendship_fk_user1_id FOREIGN KEY (fk_user1_id) REFERENCES "user"(id);


--
-- TOC entry 2181 (class 2606 OID 16727)
-- Name: user_friendship_fk_user2_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_friendship
    ADD CONSTRAINT user_friendship_fk_user2_id FOREIGN KEY (fk_user2_id) REFERENCES "user"(id);


--
-- TOC entry 2185 (class 2606 OID 24623)
-- Name: user_role_fk_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_role
    ADD CONSTRAINT user_role_fk_user_id FOREIGN KEY (fk_user_id) REFERENCES "user"(id);


--
-- TOC entry 2188 (class 2606 OID 41031)
-- Name: user_status_fk_commentable_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_status
    ADD CONSTRAINT user_status_fk_commentable_id FOREIGN KEY (fk_commentable_id) REFERENCES achievement(id);


--
-- TOC entry 2187 (class 2606 OID 41026)
-- Name: user_status_fk_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_status
    ADD CONSTRAINT user_status_fk_user_id FOREIGN KEY (fk_user_id) REFERENCES "user"(id);


--
-- TOC entry 2189 (class 2606 OID 41036)
-- Name: user_status_fk_voteable_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_status
    ADD CONSTRAINT user_status_fk_voteable_id FOREIGN KEY (fk_voteable_id) REFERENCES achievement(id);


--
-- TOC entry 2184 (class 2606 OID 24605)
-- Name: user_thirdparty_creds_fk_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_thirdparty_creds
    ADD CONSTRAINT user_thirdparty_creds_fk_user_id FOREIGN KEY (fk_user_id) REFERENCES "user"(id);


--
-- TOC entry 2166 (class 2606 OID 40993)
-- Name: vote_fk_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY vote
    ADD CONSTRAINT vote_fk_user_id FOREIGN KEY (fk_user_id) REFERENCES "user"(id);


--
-- TOC entry 2165 (class 2606 OID 40988)
-- Name: vote_fk_voteable_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY vote
    ADD CONSTRAINT vote_fk_voteable_id FOREIGN KEY (fk_voteable_id) REFERENCES voteable(id);


-- Completed on 2013-01-07 00:10:41

--
-- PostgreSQL database dump complete
--

