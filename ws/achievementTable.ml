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
  name text NOT NULL,
  description text NOT NULL,
  fk_badge_media_id integer NOT NULL,
  fk_achievement_parent_id integer NOT NULL,
  fk_achievement_child_id integer NOT NULL
) >>

(* ************************************************************************** *)
(* SQL Tools                                                                  *)
(* ************************************************************************** *)

(* int -> user row                                                            *)
let get_achievement_from_id id =
  Db.select_first
    (<:select<
        row | row in $table$ ; row.id = $int32:id$ >>)

(* string -> user row                                                         *)
let get_achievement_from_name name =
  Db.select_first
    (<:select<
        row | row in $table$ ; row.name = $string:name$ >>)

(* string -> user row                                                         *)
(* Check if the id is a number or a name and return info about                *)
(* the achievement                                                            *)
let get_achievement achievement_id =
  if (Otools.is_numeric achievement_id)
  then get_achievement_from_id (Int32.of_string achievement_id)
  else get_achievement_from_name achievement_id

