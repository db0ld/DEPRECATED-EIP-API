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

let select_ids () =
  let query =
    <:select<
      id | id in $table$ >> in
  (Db.get_db () >>=
     (fun dbh -> Db.Lwt_Query.query dbh query)
   )
    >>= (fun a -> Lwt.return (List.hd a)#!id)

let user =
  EliomJson.register_service
    ~path:["user"]
    ~get_params:unit
    (fun () () ->
      (select_ids () >>= fun id ->
       Lwt.return
         (`List
             [`Assoc
                [("id",        `Int    (Int32.to_int id));
                 ("nickname",  `String "db0");
                 ("firstname", `String "Barbara");
                 ("lastname",  `String "Lepage");
                 ("sex",       `Bool    true);
                 ("birth",     `String "05-30-1991");
                ];
             `Assoc
               [("id",        `Int    5);
                ("nickname",  `String "db0");
                ("firstname", `String "Barbara");
                ("lastname",  `String "Lepage");
                ("sex",       `Bool    true);
                ("birth",     `String "05-30-1991");
               ];
            ])
    )
    )
