(* ************************************************************************** *)
(* Project: La Vie Est Un Jeu - API                                           *)
(* Description: User service API, get information about users                 *)
(* Author: db0 (db0company@gmail.com, http://db0.fr/)                         *)
(* Latest Version is on GitHub: https://github.com/LaVieEstUnJeu/API          *)
(* ************************************************************************** *)

open Eliom_content
open Eliom_parameter

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
  birthdate date (* DEFAULT(current_timestamp) *),
  email text NOT NULL,
  password_hash text NOT NULL,
  password_salt text NOT NULL,
  fk_avatar_media_id integer (* DEFAULT(0) *),
  fk_locale_id integer NOT NULL
) >>

(* ************************************************************************** *)
(* Tools                                                                      *)
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

(* string -> bool                                                             *)
(* Check if the string is a positive number                                   *)
let is_numeric s =
  try let n = int_of_string s in
      if n >= 0 then true else false
  with _ -> false

(* string -> user row                                                         *)
(* Check if the id is a number or a login and return info about the user      *)
let get_user user_id =
  if (is_numeric user_id)
  then get_user_from_id (Int32.of_string user_id)
  else get_user_from_login user_id

(* ************************************************************************** *)
(* Get profile of the user                                                    *)
(* ************************************************************************** *)

let _ =
  EliomJson.register_service
    ~path:["user"]
    ~get_params:(suffix (string "user_id"))
    (fun user_id () ->
      let user = get_user user_id in
      (user >>= fun user ->
       Lwt.return
         (`List [`Assoc
                    [("id",        `Int    (Int32.to_int user#!id));
                     ("login",     `String user#!login);
                     ("firstname", `String user#!firstname);
                     ("surname",   `String user#!surname);
                     ("gender",    `String user#!gender);
                     (* ("birthdate", `String user#!birthdate); *)
                     ("email",     `String user#!email);
                    ]])))

