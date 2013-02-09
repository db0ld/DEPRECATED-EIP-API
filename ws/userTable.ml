(* ************************************************************************** *)
(* Project: La Vie Est Un Jeu - API                                           *)
(* Description: User service API, get information about users                 *)
(* Author: db0 (db0company@gmail.com, http://db0.fr/)                         *)
(* Latest Version is on GitHub: https://github.com/LaVieEstUnJeu/API          *)
(* ************************************************************************** *)

(* ************************************************************************** *)
(* Table                                                                      *)
(* ************************************************************************** *)

let user_id_seq = (<:sequence< serial "user_id_seq" >>)

let table = <:table< user (
  id integer NOT NULL DEFAULT(nextval $user_id_seq$),
  creation_time timestamp NOT NULL (* DEFAULT(current_timestamp) *),
  modification_time timestamp NOT NULL,
  login text NOT NULL,
  firstname text NOT NULL,
  surname text NOT NULL,
  gender text NOT NULL,
  birthdate date NOT NULL, (* nullable? *)
  email text NOT NULL,
  password_hash text NOT NULL,
  password_salt text NOT NULL,
  fk_avatar_media_id integer (* DEFAULT(0) *),
  fk_locale_id integer NOT NULL,
  email_code text,
  verified boolean (* DEFAULT false *) NOT NULL
) >>

(* ************************************************************************** *)
(* SQL Tools                                                                  *)
(* ************************************************************************** *)

(* int -> user row                                                            *)
let get_user_from_id id =
  Db.select_first
    (<:select<
        row | row in $table$ ; row.id = $int32:id$ >>)

(* string -> user row                                                         *)
let get_user_from_login login =
  Db.select_first
    (<:select<
        row | row in $table$ ; row.login = $string:login$ >>)

(* string -> user row                                                         *)
(* Check if the id is a number or a login and return info about the user      *)
let get_user user_id =
  if (Otools.is_numeric user_id)
  then get_user_from_id (Int32.of_string user_id)
  else get_user_from_login user_id

