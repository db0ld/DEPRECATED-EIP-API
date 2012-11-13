(* ************************************************************************** *)
(* Project: La Vie Est Un Jeu - API                                           *)
(* Description: Error exceptions and messages                                 *)
(* Author: db0 (db0company@gmail.com, http://db0.fr/)                         *)
(* Latest Version is on GitHub: https://github.com/LaVieEstUnJeu/API          *)
(* ************************************************************************** *)

(* ************************************************************************** *)
(* Authentification                                                           *)
(* ************************************************************************** *)

let auth_fail = "Authentification failure"
let wrong_pwd = auth_fail ^ ": Invalid password"
let wrong_usr = auth_fail ^ ": Invalid login"
let auth_req =  "Authentification session invalid or timeout"

(* ************************************************************************** *)
(* User                                                                       *)
(* ************************************************************************** *)

let no_user = "Invalid login or id. This user does not exists."
