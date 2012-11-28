(* ************************************************************************** *)
(* Project: La Vie Est Un Jeu - API                                           *)
(* Description: User service API, get information about users                 *)
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

include UserTable

(* ************************************************************************** *)
(* SQL Tools                                                                  *)
(* ************************************************************************** *)

let create_user
    (login, (firstname, (surname, (gender, (birthdate, (email, password)))))) =
  let gender =
    match gender with
      | Some g -> g
      | None   -> ApiTypes.Gender.default
  and birthdate =
    match birthdate with
      | Some bd -> bd
      | None   -> ApiTypes.Date.empty (* todo: date non nullable? *) in
  let _ =
    print_endline ("test [" ^ (ApiTypes.Date.to_string birthdate) ^ "]") in
  let errors =
    Otools.option_filter
      [if Valid.login login = false
       then (print_endline ("invalid login " ^ login);
             Some Rspcode.invalid_login) else None;
       if Valid.name firstname = false || Valid.name surname = false
       then Some Rspcode.invalid_name else None;
       if Valid.email email = false
       then Some Rspcode.invalid_email else None;
      ] in
  let query =
    <:insert< $table$ :=
      {
         id                 = table?id;
         creation_time      = $timestamp:(ApiTypes.DateTime.now ())$;
         modification_time  = $timestamp:(ApiTypes.DateTime.now ())$;
         login              = $string:login$;
         firstname          = $string:firstname$;
         surname            = $string:surname$;
         gender             = $string:(ApiTypes.Gender.to_string gender)$;
         birthdate          = $date:birthdate$;
         email              = $string:email$;
         password_hash      = $string:password$; (* todo *)
         password_salt      = $string:password$; (* todo *)
         fk_avatar_media_id = 0; (* todo *)
         fk_locale_id       = 0; (* todo *)
       } >> in
  if List.length errors = 0
  then
    (try (ignore (Db.query query); (* todo: how to check result of a query? *)
          Success ())
     with _ -> Failure [Rspcode.invalid_passw])
  else Failure errors

(* ************************************************************************** *)
(* JSON Tools                                                                 *)
(* ************************************************************************** *)

(* user row -> json                                                           *)
let json_user_profile user : Yojson.Basic.json =
  let birthdate = ApiTypes.Date.to_string user#!birthdate
  and creation_time = ApiTypes.DateTime.to_string user#!creation_time
  and modif_time = ApiTypes.DateTime.to_string user#!modification_time in
  `Assoc
    [("id",                `Int    (Int32.to_int user#!id));
     ("complete",          `Bool   true);
     ("creation",          `String creation_time);
     ("last_modification", `String modif_time);
     ("login",             `String user#!login);
     ("firstname",         `String user#!firstname);
     ("surname",           `String user#!surname);
     ("gender",            `String user#!gender);
     ("birthdate",         `String birthdate);
     ("email",             `String user#!email);
     ("friend_level",      `String "todo"); (* todo *)
     ("achievements",      `String "todo"); (* todo *)
    ]

(* ************************************************************************** *)
(* API Queries                                                                *)
(* ************************************************************************** *)

(* ************************************************************************** *)
(* Get profile of the user                                                    *)
(* ************************************************************************** *)

let _ =
  EliomJson.register_service
    ~path:["user"]
    ~get_params:(suffix_prod (string "user_id") (string "token"))
    (fun (user_id, token) () ->
      lwt token_owner = Auth.token_owner token in
      match token_owner with
        | Some user_logued ->
          (lwt user = get_user user_id in
           Lwt.return
             (match user with
               | Some user -> JsonTools.success (json_user_profile user)
               | None -> JsonTools.error Rspcode.no_user))
        | None -> Lwt.return (JsonTools.error Rspcode.invalid_token))

(* ************************************************************************** *)
(* Register a new user                                                        *)
(* ************************************************************************** *)

let _ =
  EliomJson.register_service
    ~path:["user";"register"]
    ~get_params:(string "login"
                 ** string "firstname"
                 ** string "surname"
                 ** opt (user_type
                           ~of_string:ApiTypes.Gender.of_string
                           ~to_string:ApiTypes.Gender.to_string
                           "gender")
                 ** opt (user_type
                           ~of_string:ApiTypes.Date.of_string
                           ~to_string:ApiTypes.Date.to_string
                           "birthdate")
                 ** string "email"
                 ** string "password"
                )
    (fun infos () ->
      match create_user infos with
          | Success _    -> Lwt.return (JsonTools.success `Null)
            (* (get_user login >>= fun user -> *)
            (*   Lwt.return (json_user_profile user)) *)
          | Failure errors -> Lwt.return (JsonTools.errors errors))
