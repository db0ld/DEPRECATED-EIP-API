(* ************************************************************************** *)
(* Project: La Vie Est Un Jeu - API                                           *)
(* Description: Tools to check data validity                                  *)
(* Author: Tuxkowo                                                            *)
(* Latest Version is on GitHub: https://github.com/LaVieEstUnJeu/API          *)
(* ************************************************************************** *)

(* Check if the given login is valid:                                         *)
(* - contain only letters, numbers, underscores ans dash                      *)
(* - start with a letter                                                      *)
(* - lenght >= 2 and <= 64                                                    *)
let login login =
  Str.string_match (Str.regexp "^[a-zA-Z][a-zA-Z0-9_-]{1,63}$") login 0

let name = login

(* Check if the password is valid:                                            *)
(* - lenght >= 8                                                              *)
let password password =
  (String.length password) >= 6

(* Check if the e-mail is valid                                               *)
let email email =
  Str.string_match (Str.regexp "^[a-z0-9_.+-]+@([^.]+\\.)+[^.]+$") email 0
