
CREATE TABLE user_profile (
 id SERIAL PRIMARY KEY,
 username VARCHAR(64) UNIQUE NOT NULL CHECK (LENGTH(username) > 2),
 email VARCHAR(255) UNIQUE,
 firstname VARCHAR(64),
 lastname VARCHAR(64),
 gender SMALLINT,
 birthdate TIMESTAMP,
 password_salt VARCHAR(255),
 password_hash VARCHAR(255),
 fk_country_id INTEGER,
 location VARCHAR(128),
 timezone VARCHAR(16),
 creation_date TIMESTAMP,
 modification_date TIMESTAMP,
 fk_locale_id INTEGER,
 fk_media_id_avatar INTEGER
);
