(* ************************************************************************** *)
(* Project: La Vie Est Un Jeu - API                                           *)
(* Description: User service API, get information about users                 *)
(* Author: db0 (db0company@gmail.com, http://db0.fr/)                         *)
(* Latest Version is on GitHub: https://github.com/LaVieEstUnJeu/API          *)
(* ************************************************************************** *)

open Eliom_content
open Eliom_parameter
open CalendarLib

(* ************************************************************************** *)
(* Table                                                                      *)
(* ************************************************************************** *)

let user_id_seq = (<:sequence< serial "user_id_seq" >>)

let table = <:table< user (
  id integer NOT NULL DEFAULT(nextval $user_id_seq$),
  creation_time timestamp NOT NULL (* DEFAULT(current_timestamp) *),
  modification_time timestamp NOT NULL,
  login text NOT NULL,
  firstname text NOT NULL,
  surname text NOT NULL,
  gender text NOT NULL,
  birthdate date NOT NULL, (* nullable? *)
  email text NOT NULL,
  password_hash text NOT NULL,
  password_salt text NOT NULL,
  fk_avatar_media_id integer (* DEFAULT(0) *),
  fk_locale_id integer NOT NULL
) >>

(* ************************************************************************** *)
(* SQL Tools                                                                  *)
(* ************************************************************************** *)

(* int -> user row                                                            *)
let get_user_from_id id =
  Db.select_first
    (<:select<
        row | row in $table$ ; row.id = $int32:id$ >>)

(* string -> user row                                                         *)
let get_user_from_login login =
  Db.select_first
    (<:select<
        row | row in $table$ ; row.login = $string:login$ >>)

(* string -> user row                                                         *)
(* Check if the id is a number or a login and return info about the user      *)
let get_user user_id =
  if (Otools.is_numeric user_id)
  then get_user_from_id (Int32.of_string user_id)
  else get_user_from_login user_id

let create_user
    (login, (firstname, (surname, (gender, (birthdate, (email, password)))))) =
  let query =
    <:insert< $table$ :=
      {
	 id = table?id;
	 creation_time     = $timestamp:(ApiTypes.DateTime.now ())$;
	 modification_time = $timestamp:(ApiTypes.DateTime.now ())$;
	 login     = $string:login$;
	 firstname = $string:firstname$;
	 surname   = $string:surname$;
	 gender    = $string:(ApiTypes.Gender.to_string gender)$;
	 birthdate = $date:birthdate$;
	 email     = $string:email$;
	 password_hash = $string:password$; (* todo *)
	 password_salt = $string:password$; (* todo *)
	 fk_avatar_media_id = 0; (* todo *)
	 fk_locale_id = 0; (* todo *)
       } >> in
  (* todo: check information validity *)
  if 1 = 2
  then Otools.Failure "wrong universe"
  else (ignore (Db.query query); (* todo: how to check result of a query? *)
	Otools.Success ())

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
     ("creation_time",     `String creation_time);
     ("modification_time", `String modif_time);
     ("login",             `String user#!login);
     ("firstname",         `String user#!firstname);
     ("surname",           `String user#!surname);
     ("gender",            `String user#!gender);
     ("birthdate",         `String birthdate);
     ("email",             `String user#!email);
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
    ~get_params:(suffix (string "user_id"))
    (fun user_id () ->
      let user = get_user user_id in
      (user >>= fun user ->
       Lwt.return (json_user_profile user)))

(* ************************************************************************** *)
(* Register a new user                                                        *)
(* ************************************************************************** *)

let _ =
  EliomJson.register_service
    ~path:["user";"register"]
    ~get_params:(string "login"
		 ** string "firstname"
		 ** string "surname"
		 ** (user_type
		       ~of_string:ApiTypes.Gender.of_string
		       ~to_string:ApiTypes.Gender.to_string
		       "gender")
		 ** (user_type
		       ~of_string:ApiTypes.Date.of_string
		       ~to_string:ApiTypes.Date.to_string
		       "birthdate")
		 ** string "email"
		 ** string "password"
                )
    (fun infos () ->
      match create_user infos with
          | Otools.Success ()    -> Lwt.return (JsonTools.success)
	    (* (get_user login >>= fun user -> *)
	    (*   Lwt.return (json_user_profile user)) *)
	  | Otools.Failure error -> Lwt.return (JsonTools.error error))
