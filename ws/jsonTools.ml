(* ************************************************************************** *)
(* Project: La Vie Est Un Jeu - API                                           *)
(* Description: Some JSON tools                                               *)
(* Author: db0 (db0company@gmail.com, http://db0.fr/)                         *)
(* Latest Version is on GitHub: https://github.com/LaVieEstUnJeu/API          *)
(* ************************************************************************** *)

(* Return formatted JSON trees containing API responses                       *)

let response (apiRsp, rspmsg) tree =
  `Assoc [("rspcode", `Int apiRsp);
	  ("rspmsg",  `String rspmsg);
	  ("content",  tree);
	 ]

let error err =
  response err `Null

let errors err =
  let assoc (apiRsp, rspmsg) =
    `Assoc [("apiRsp", `Int apiRsp);
	    ("rspmsg",  `String rspmsg)] in
  response ApiRsp.invalid_data (`List (List.map assoc err))

let success =
  response ApiRsp.success


