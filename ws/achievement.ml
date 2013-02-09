(* ************************************************************************** *)
(* Project: La Vie Est Un Jeu - API                                           *)
(* Description: Achievement service API, get information about achievements   *)
(* Author: db0 (db0company@gmail.com, http://db0.fr/)                         *)
(* Latest Version is on GitHub: https://github.com/LaVieEstUnJeu/API          *)
(* ************************************************************************** *)

(* Achievement : Element *)
(* name = string *)
(* description = string *)
(* badge = picture *)
(* parent_id = string *)
(* child_achievements = List<Achievement> *)

(* Représente un achievement réalisable. Cet élément n’est pas modifiable, sauf par un administrateur. Il contient les caractéristiques de l’achievement ainsi que les achievements réalisables une fois que celui-ci est réalisé. L’ensemble des achievements forme un arbre. *)

(* Achievement *)
(* create	POST(Achievement) -> Achievement *)
(* search	GET-> List<Achievement> *)
(* {id}		GET-> Achievement *)
(* {id}/edit	POST(Achievement)-> Achievement *)
(* [id}/delete	GET-> Achievement *)
(* {id}/plan	GET-> AchievementStatus *)


open Eliom_content
open Eliom_parameter
open CalendarLib
open Otools

(* ************************************************************************** *)
(* Table                                                                      *)
(* ************************************************************************** *)

include AchievementTable

(* ************************************************************************** *)
(* SQL Tools                                                                  *)
(* ************************************************************************** *)

(* ************************************************************************** *)
(* JSON Tools                                                                 *)
(* ************************************************************************** *)

(* ************************************************************************** *)
(* API Queries                                                                *)
(* ************************************************************************** *)

let urlpref = "achievement"

(* ************************************************************************** *)
(* Get an achievement by its id                                               *)
(* ************************************************************************** *)

let _ =
  EliomJson.register_service
    ~path:[urlpref]
    ~get_params:(suffix_prod (int32 "id") (string "token"))
    (fun (id, token) () ->
      lwt token_owner = Auth.token_owner token in
      match token_owner with
        | Some user_logued ->
          (lwt achievement = get_achievement id in
           Lwt.return
             (match achievement with
               | Some achievement -> JsonTools.success `Null
               | None -> JsonTools.error ApiRsp.no_user (*to change*)))
        | None -> Lwt.return (JsonTools.error ApiRsp.invalid_token))

