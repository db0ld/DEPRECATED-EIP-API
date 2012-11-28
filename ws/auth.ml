(* ************************************************************************** *)
(* Project: La Vie Est Un Jeu - API                                           *)
(* Description: Auth service API, login, logout, get tokens                   *)
(* Author: db0 (db0company@gmail.com, http://db0.fr/)                         *)
(* Latest Version is on GitHub: https://github.com/LaVieEstUnJeu/API          *)
(* ************************************************************************** *)

open Eliom_content
open Eliom_parameter
open CalendarLib
open Otools

(* ************************************************************************** *)
(* Table                                                                      *)
(* ************************************************************************** *)

let api_auth_id_seq = (<:sequence< serial "api_auth_id_seq" >>)

let table = <:table< api_auth (
  id integer NOT NULL DEFAULT(nextval $api_auth_id_seq$),
  creation_time timestamp NOT NULL (* DEFAULT(current_timestamp) *),
  modification_time timestamp NOT NULL,
  expiration_time timestamp NOT NULL,
  fk_user_id integer NOT NULL,
  fk_api_client_id integer NOT NULL,
  token text NOT NULL
) >>

(* ************************************************************************** *)
(* Get Auth Conf                                                              *)
(* ************************************************************************** *)

(* The lifetime of a session authentification (hours, minutes, seconds)       *)
(* This value is retrieved from the Ocsigen conf file or set to default value *)
(* (int * int * int)                                                          *)
let session_lifetime =
  let default = (2, 0, 0) in (* 2 hours *)
  try match List.hd (Eliom_config.get_config ()) with
    | Simplexmlparser.Element (name, list_attrib, content_list) ->
      if name = "session_lifetime"
      then
        (int_of_string (List.assoc "hours" list_attrib),
         int_of_string (List.assoc "minutes" list_attrib),
         int_of_string (List.assoc "seconds" list_attrib))
      else default | _ -> default with _ -> default

(* ************************************************************************** *)
(* SQL tools                                                                  *)
(* ************************************************************************** *)

(* macaque user -> (string * bool * ApiTypes.DateTime) result                 *)
(* Insert the authentification token in database and return auth info:        *)
(*   (creation_time, expiration_time, user, token)                            *)
let sql_auth user =
  let now = ApiTypes.DateTime.now () in
  let expiration =
    let (hours, minutes, seconds) = session_lifetime in
    let period = CalendarLib.Calendar.Period.make 0 0 0 hours minutes seconds in
    CalendarLib.Calendar.add now period
  and token = random_string 40 in
  let query =
    <:insert< $table$ :=
      {
         id = table?id;
         creation_time     = $timestamp:now$;
         modification_time = $timestamp:now$;
         expiration_time   = $timestamp:expiration$;
         fk_user_id        = $int32:(user#!id)$;
         fk_api_client_id  = 0; (* todo: what is it? *)
         token             = $string:token$
       } >> in
  let logged = ignore (Db.query query)(* todo: check result *); true in
  Success (token, logged, expiration)

let sql_delete_token token =
  let token_str = token#!token in
  let query =
    <:delete< row in $table$ | row.token = $string:token_str$; >> in
  let _ = Db.query query (* todo: check query *) in
  Success (token_str, false, token#!expiration_time)

(* string -> (macaque auth) Lwt                                               *)
(* Get the token in the database                                              *)
let get_token token =
  lwt token =
    Db.select_first
      (<:select< row | row in $table$ ; row.token = $string:token$ >>) in
  Lwt.return
    (match token with
      | Some token ->
        if ApiTypes.DateTime.is_past token#!expiration_time
        then (print_endline "Nope"; None) (* todo: delete *)
        else Some token
      | None -> None)

(* ************************************************************************** *)
(* Auth tools                                                                 *)
(* ************************************************************************** *)

(* macaque user -> bool                                                       *)
(* Take a user (User.get_user), a password and check if the password match    *)
let check_password user password =
  password = user#!password_hash (* todo *)

(* macaque user -> (string * bool * ApiTypes.DateTime) result                 *)
(* Authenticate a user and return authentification info:                      *)
(*   (creation_time, expiration_time, user, token)                            *)
(* Can return a failure error                                                 *)
let authenticate user =
  sql_auth user

(* ((macaque auth) option) -> ((macaque user) option) Lwt                     *)
(* Take a token and return the user who own it                                *)
let token_owner_from_token token =
  match token with
    | Some token -> UserTable.get_user_from_id token#!fk_user_id
    | None       -> Lwt.return None

(* string -> ((macaque user) option) Lwt                                      *)
(* Take a string token and return the user who own it                         *)
let token_owner token =
  lwt token = get_token token in
  token_owner_from_token token

(* string -> bool Lwt                                                          *)
let is_authenticated token =
  lwt user = token_owner token in
  Lwt.return
    (match user with
      | Some _ -> true
      | None   -> false)

let delete_token =
  sql_delete_token

(* ************************************************************************** *)
(* JSON tools                                                                 *)
(* ************************************************************************** *)

let json_auth (token, logged, expiration) : Yojson.Basic.json =
  `Assoc
    [("token",  `String token);
     ("logged", `Bool   logged);
     ("expire", `String (ApiTypes.DateTime.to_string expiration))
    ]

(* ************************************************************************** *)
(* API Queries                                                                *)
(* ************************************************************************** *)

(* ************************************************************************** *)
(* Login                                                                      *)
(* ************************************************************************** *)

let _ =
  EliomJson.register_service
    ~path:["auth";"login"]
    ~get_params:(string "login" ** string "password")
    (fun (login, password) () ->
      lwt user = UserTable.get_user login in
      Lwt.return
        (match user with
          | Some user ->
            (if check_password user password
             then match authenticate user with
               | Success auth -> JsonTools.success (json_auth auth)
               | Failure err  -> JsonTools.error err
             else JsonTools.error Rspcode.wrong_pwd)
          | None -> JsonTools.error Rspcode.wrong_usr))

(* ************************************************************************** *)
(* Logout                                                                     *)
(* ************************************************************************** *)

let _ =
  EliomJson.register_service
    ~path:["auth";"logout"]
    ~get_params:(string "login" ** string "token")
    (fun (login, token_str) () ->
      lwt token = get_token token_str in
      lwt owner = token_owner_from_token token in
      Lwt.return
        (match token with
          | None -> JsonTools.error Rspcode.invalid_token
          | Some token ->
            (match owner with
              | None -> JsonTools.error Rspcode.no_user
              | Some o ->
                if o#!login = login
                then
                  match delete_token token with
                    | Failure rsp -> JsonTools.error rsp
                    | Success res -> JsonTools.success (json_auth res)
                else JsonTools.error Rspcode.unmatch_user)))
