(* ************************************************************************** *)
(* Project: La Vie Est Un Jeu - API                                           *)
(* Description: Usage of the Calendar lib as part of the API                  *)
(* Author: db0 (db0company@gmail.com, http://db0.fr/)                         *)
(* Latest Version is on GitHub: https://github.com/LaVieEstUnJeu/API          *)
(* ************************************************************************** *)

(* Full time with date + hour                                                 *)

type t

val make : CalendarLib.Calendar.t -> t
val to_datetime : t -> CalendarLib.Calendar.t

val to_string : t -> string
val of_string : string -> t
val raw_to_string : CalendarLib.Calendar.t -> string

val now : unit -> t

(* Only date                                                                  *)

type date

val make_date : CalendarLib.Date.t -> date
val to_date : date -> CalendarLib.Date.t

val date_to_string : date -> string
val date_of_string : string -> date
val raw_date_to_string : CalendarLib.Date.t -> string

val date_now : unit -> date

