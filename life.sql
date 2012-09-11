--
-- Base de données: "life"
--

-- --------------------------------------------------------

--
-- Structure de la table "achievement"
--

CREATE TABLE IF NOT EXISTS "achievement" (
  "id" serial NOT NULL,
  "name" varchar(50) NOT NULL,
  "description" text NOT NULL,
  "idphoto" integer NOT NULL,
  "idpermission" integer NOT NULL,
  "starttime" timestamp NOT NULL,
  "endtime" timestamp NOT NULL,
  "creation" timestamp NOT NULL,
  "update" timestamp NOT NULL,
  "location" varchar(50) NOT NULL,
  PRIMARY KEY ("id")
) ;

-- --------------------------------------------------------

--
-- Structure de la table "album"
--

CREATE TABLE IF NOT EXISTS "album" (
  "id" serial NOT NULL,
  "iduser" integer NOT NULL,
  "idphoto" integer NOT NULL,
  "name" varchar(50) NOT NULL,
  "creation" timestamp NOT NULL,
  "update" timestamp NOT NULL,
  "idpermission" integer NOT NULL,
  PRIMARY KEY ("id")
) ;

-- --------------------------------------------------------

--
-- Structure de la table "comment"
--

CREATE TABLE IF NOT EXISTS "comment" (
  "id" serial NOT NULL,
  "iduser" integer NOT NULL,
  "content" text NOT NULL,
  "creation" timestamp NOT NULL,
  "idachievement" integer NOT NULL,
  PRIMARY KEY ("id")
) ;

-- --------------------------------------------------------

--
-- Structure de la table "friend"
--

CREATE TABLE IF NOT EXISTS "friend" (
  "iduser1" integer NOT NULL,
  "iduser2" integer NOT NULL,
  "level" smallint NOT NULL,
  PRIMARY KEY ("iduser1","iduser2")
);

-- --------------------------------------------------------

--
-- Structure de la table "group"
--

CREATE TABLE IF NOT EXISTS "group" (
  "id" serial NOT NULL,
  "name" varchar(50) NOT NULL,
  "description" text NOT NULL,
  "idpicture" integer NOT NULL,
  "idcreator" integer NOT NULL,
  "creation" timestamp NOT NULL,
  "update" timestamp NOT NULL,
  PRIMARY KEY ("id")
) ;

-- --------------------------------------------------------

--
-- Structure de la table "group_assoc"
--

CREATE TABLE IF NOT EXISTS "group_assoc" (
  "iduser" integer NOT NULL,
  "idgroup" integer NOT NULL,
  PRIMARY KEY ("iduser","idgroup")
);

-- --------------------------------------------------------

--
-- Structure de la table "info"
--

CREATE TABLE IF NOT EXISTS "info" (
  "id" serial NOT NULL,
  "name" varchar(50) NOT NULL,
  PRIMARY KEY ("id")
) ;

-- --------------------------------------------------------

--
-- Structure de la table "info_assoc"
--

CREATE TABLE IF NOT EXISTS "info_assoc" (
  "id_info" integer NOT NULL,
  "id_user" integer NOT NULL,
  "value" varchar(100) NOT NULL,
  PRIMARY KEY ("id_info","id_user")
);

-- --------------------------------------------------------

--
-- Structure de la table "message"
--

CREATE TABLE IF NOT EXISTS "message" (
  "id" integer NOT NULL,
  "idusersrc" integer NOT NULL,
  "iduserdst" integer NOT NULL,
  "title" varchar(50) NOT NULL,
  "content" text NOT NULL,
  "creation" timestamp NOT NULL
);

-- --------------------------------------------------------

--
-- Structure de la table "permission"
--

CREATE TABLE IF NOT EXISTS "permission" (
  "id" serial NOT NULL,
  "leveladm" smallint NOT NULL,
  "levelusr" smallint NOT NULL,
  PRIMARY KEY ("id")
) ;

-- --------------------------------------------------------

--
-- Structure de la table "photo"
--

CREATE TABLE IF NOT EXISTS "photo" (
  "id" serial NOT NULL,
  "title" varchar(50) NOT NULL,
  "adress" varchar(50) NOT NULL,
  "creation" timestamp NOT NULL,
  PRIMARY KEY ("id")
) ;

-- --------------------------------------------------------

--
-- Structure de la table "photo_assoc"
--

CREATE TABLE IF NOT EXISTS "photo_assoc" (
  "idalbum" integer NOT NULL,
  "idphoto" integer NOT NULL,
  PRIMARY KEY ("idalbum","idphoto")
);

-- --------------------------------------------------------

--
-- Structure de la table "user"
--

CREATE TABLE IF NOT EXISTS "user" (
  "id" serial NOT NULL,
  "nickname" varchar(50) NOT NULL,
  "firstname" varchar(50) NOT NULL,
  "lastname" varchar(50) NOT NULL,
  "idpicture" integer NOT NULL,
  "timezone" integer NOT NULL,
  "sex" smallint NOT NULL,
  "birth" date NOT NULL,
  PRIMARY KEY ("id")
) ;
