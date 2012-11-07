(* ************************************************************************** *)
(* Project: La Vie Est Un Jeu - API                                           *)
(* Description: Some JSON tools                                               *)
(* Author: db0 (db0company@gmail.com, http://db0.fr/)                         *)
(* Latest Version is on GitHub: https://github.com/LaVieEstUnJeu/API          *)
(* ************************************************************************** *)

(* Return a JSON tree containing an error message                             *)
val error : string -> Yojson.Basic.json

val success : Yojson.Basic.json
