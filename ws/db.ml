(* ************************************************************************** *)
(* Project: La Vie Est Un Jeu - API                                           *)
(* Description: Database stuff                                                *)
(* Author: db0 (db0company@gmail.com, http://db0.fr/)                         *)
(* Latest Version is on GitHub: https://github.com/LaVieEstUnJeu/API          *)
(* ************************************************************************** *)

(* ************************************************************************** *)
(* Get DB conf                                                                *)
(* ************************************************************************** *)

exception Invalid_db_config

(* /!\ This value can raise an exception that prevents the website to start   *)
let db_info =
  let fail () = raise Invalid_db_config in
  try match List.hd (Eliom_config.get_config ()) with
    | Simplexmlparser.Element (name, list_attrib, content_list) ->
      if name = "db"
      then
        ((List.assoc "login" list_attrib),
         (List.assoc "password" list_attrib),
         (List.assoc "dbname" list_attrib))
      else fail ()
    | _ -> fail ()
  with _ -> fail ()

(* ************************************************************************** *)
(* DB module                                                                  *)
(* ************************************************************************** *)

module Lwt_thread = struct
  include Lwt
  include Lwt_chan
end
module Lwt_PGOCaml = PGOCaml_generic.Make(Lwt_thread)
module Lwt_Query = Query.Make_with_Db(Lwt_thread)(Lwt_PGOCaml)

let get_db : unit -> unit Lwt_PGOCaml.t Lwt.t =
  let db_handler = ref None in
  let (login, password, dbname) = db_info in
  fun () ->
    match !db_handler with
      | Some h -> Lwt.return h
      | None -> Lwt_PGOCaml.connect ~user:login
        ~password:password ~database:dbname ()

(* ************************************************************************** *)
(* Tools                                                                      *)
(* ************************************************************************** *)

(* query -> (row list) lwt                                                    *)
(* Return the result of the query                                             *)
let query q =
  get_db () >>= (fun dbh -> Lwt_Query.query dbh ~log:stderr q)

(* query -> row lwt                                                           *)
(* Return only the first result of the query                                  *)
let select_first q =
  try (query q >>= (fun a -> Lwt.return (List.hd a)))
  with _ -> raise Not_found

