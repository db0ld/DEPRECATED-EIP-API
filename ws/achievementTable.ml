(* ************************************************************************** *)
(* Project: La Vie Est Un Jeu - API                                           *)
(* Description: Achievement table API                                         *)
(* Author: nox                                                                *)
(* Latest Version is on GitHub: https://github.com/LaVieEstUnJeu/API          *)
(* ************************************************************************** *)

(* ************************************************************************** *)
(* Table                                                                      *)
(* ************************************************************************** *)

let achievement_id_seq = (<:sequence< serial "achievement_id_seq" >>)


let table = <:table< achievement (
  id integer NOT NULL DEFAULT(nextval $achievement_id_seq$),
  creation_time timestamp NOT NULL (* DEFAULT(current_timestamp) *),
  modification_time timestamp NOT NULL,
  (* name text NOT NULL, *)
  (* description text NOT NULL, *)
  fk_creator_user_id integer NOT NULL,
  fk_icon_media_id integer,
  fk_achievement_category_id integer NOT NULL,
  fk_achievement_parent_id integer,
  default_privacy integer NOT NULL (* privacy type *)
) >>

(* ************************************************************************** *)
(* SQL Tools                                                                  *)
(* ************************************************************************** *)

(* int -> user row                                                            *)
let get_achievement id =
  Db.select_first
    (<:select<
        row | row in $table$ ; row.id = $int32:id$ >>)
