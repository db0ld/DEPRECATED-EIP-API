(* ************************************************************************** *)
(* Project: La Vie Est Un Jeu - API                                           *)
(* Description: Some JSON tools                                               *)
(* Author: db0 (db0company@gmail.com, http://db0.fr/)                         *)
(* Latest Version is on GitHub: https://github.com/LaVieEstUnJeu/API          *)
(* ************************************************************************** *)

(* Return formatted JSON trees containing API responses                       *)

val response : Rspcode.t -> Yojson.Basic.json -> Yojson.Basic.json
val error    : Rspcode.t -> Yojson.Basic.json
val errors   : Rspcode.t list -> Yojson.Basic.json
val success  : Yojson.Basic.json -> Yojson.Basic.json
