(* ************************************************************************** *)
(* Project: La Vie Est Un Jeu - API                                           *)
(* Description: User service API, get information about users                 *)
(* Author: db0 (db0company@gmail.com, http://db0.fr/)                         *)
(* Latest Version is on GitHub: https://github.com/LaVieEstUnJeu/API          *)
(* ************************************************************************** *)

open Eliom_content
open Eliom_parameter

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

let select_first query =
  try ((Db.get_db () >>= (fun dbh -> Db.Lwt_Query.query dbh query))
          >>= (fun a -> Lwt.return (List.hd a)))
  with _ -> raise Not_found

let get_user_from_id id =
  select_first
    (<:select<
	row | row in $table$ ; row.id = $int32:id$ >>)

let get_user_from_login login =
  select_first
    (<:select<
	row | row in $table$ ; row.login = $string:login$ >>)

let is_numeric s =
  try ignore (int_of_string s); true
  with _ -> false

let user =
  EliomJson.register_service
    ~path:["user"]
    ~get_params:(suffix (string "user_id"))
    (fun user_id () ->
      let user =
	if (is_numeric user_id)
	then get_user_from_id (Int32.of_string user_id)
	else get_user_from_login user_id
      in
      (user >>= fun user ->
       Lwt.return
         (`List
             [`Assoc
                [("id",        `Int    (Int32.to_int user#!id));
		 ("login",     `String user#!login);
		 ("firstname", `String user#!firstname);
		 ("surname",   `String user#!surname);
		 ("gender",    `String user#!gender);
		 (* ("birthdate", `String user#!birthdate); *)
		 ("email",     `String user#!email);
                ]
            ])
    )
    )
