(* ************************************************************************** *)
(* Project: La Vie Est Un Jeu - API                                           *)
(* Description: Usage of the Calendar lib as part of the API                  *)
(* Author: db0 (db0company@gmail.com, http://db0.fr/)                         *)
(* Latest Version is on GitHub: https://github.com/LaVieEstUnJeu/API          *)
(* ************************************************************************** *)

(* Full time with date + hour                                                 *)
type t = CalendarLib.Printer.Calendar.t
(* Only date                                                                  *)
type date =  CalendarLib.Printer.Calendar.t

let id d = d

let make = id
let make_date d = CalendarLib.Calendar.from_date d

let dformat = "%Y-%m-%d"
let format = dformat ^ " %H:%M:%S"

let aux_to_string format date =
  CalendarLib.Printer.Calendar.sprint format date

let aux_of_string format str_date =
  CalendarLib.Printer.Calendar.from_fstring format str_date

let date_to_string = aux_to_string dformat
let date_of_string = aux_of_string dformat

let to_string = aux_to_string format
let of_string = aux_of_string format

let now () = CalendarLib.Calendar.now ()
let date_now = now

let to_datetime = id
let to_date d = CalendarLib.Calendar.to_date d

let raw_to_string d = to_string (make d)
let raw_date_to_string d = date_to_string (make_date d)
