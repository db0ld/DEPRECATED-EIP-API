(* ************************************************************************** *)
(* Project: La Vie Est Un Jeu - API                                           *)
(* Description: JSON Eliom Module to return a JSON page                       *)
(* Author: db0 (db0company@gmail.com, http://db0.fr/)                         *)
(* Latest Version is on GitHub: https://github.com/LaVieEstUnJeu/API          *)
(* ************************************************************************** *)

open Eliom_content
open Eliom_service
open Eliom_lib
open Eliom_lib.Lwt_ops
open Eliom_parameter
include Eliom_registration

let register_service content_generator =
  let tuppled_content a () =
    content_generator a () >>=
      fun x ->
    Lwt.return
      (Yojson.Basic.pretty_to_string x,
       "application/json") in
  
  Eliom_registration.Text.register_service tuppled_content
