(* ************************************************************************** *)
(* Project: La Vie Est Un Jeu - API                                           *)
(* Description: Achievement service API, get information about achievements   *)
(* Author: db0 (db0company@gmail.com, http://db0.fr/)                         *)
(* Latest Version is on GitHub: https://github.com/LaVieEstUnJeu/API          *)
(* ************************************************************************** *)

let achievement_id_seq = (<:sequence< serial "achievement_id_seq" >>)

let table = <:table< achievement (
  id integer NOT NULL DEFAULT(nextval $achievement_id_seq$),
  creation_time timestamp NOT NULL (* DEFAULT(current_timestamp) *),
  modification_time timestamp NOT NULL,
  fk_creator_user_id integer NOT NULL,
  fk_icon_media_id integer (* DEFAULT(0) *),
  fk_achievement_category_id integer NOT NULL,
  fk_achivement_parent_id integer (* DEFAULT(0) *),
  default_privacy integer NOT NULL (* does macaque support custom enum? *)
) >>

let select id =
  let id = Int32.of_int id in
  Db.select_first
    (<:select<
        { a = row_a ; u = row_u } |
	 row_a in $table$ ; row_u in $User.table$ ;
         row_a.id = $int32:id$ >>)

let _ =
  lwt a = select 1 in
  Lwt.return
    (match a with
      | Some a -> print_endline a#!u#!login
      | None   -> print_endline "none")

