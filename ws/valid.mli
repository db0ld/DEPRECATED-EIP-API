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
val login    : string -> bool
val name     : string -> bool

(* Check if the password is valid:                                            *)
(* - lenght >= 8                                                              *)
val password : string -> bool

(* Check if the e-mail is valid                                               *)
val email    : string -> bool

