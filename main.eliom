(* ************************************************************************** *)
(* Project: La Vie Est Un Jeu - API                                           *)
(* Description: Main service of the API                                       *)
(* Author: db0 (db0company@gmail.com, http://db0.fr/)                         *)
(* Latest Version is on GitHub: https://github.com/LaVieEstUnJeu/API          *)
(* ************************************************************************** *)

open Eliom_content
open Eliom_parameter

let main =
  EliomJson.register_service
    ~path:[]
    ~get_params:unit
    (fun () () ->
      Lwt.return
	(`String "toto"))
