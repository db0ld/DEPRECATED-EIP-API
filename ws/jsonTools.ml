(* ************************************************************************** *)
(* Project: La Vie Est Un Jeu - API                                           *)
(* Description: Some JSON tools                                               *)
(* Author: db0 (db0company@gmail.com, http://db0.fr/)                         *)
(* Latest Version is on GitHub: https://github.com/LaVieEstUnJeu/API          *)
(* ************************************************************************** *)

(* string -> json                                                             *)
let error error : Yojson.Basic.json =
  `Assoc [("error", `String error)]

let success : Yojson.Basic.json =
  `String "OK"

