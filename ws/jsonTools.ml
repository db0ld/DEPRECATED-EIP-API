(* ************************************************************************** *)
(* Project: La Vie Est Un Jeu - API                                           *)
(* Description: Some JSON tools                                               *)
(* Author: db0 (db0company@gmail.com, http://db0.fr/)                         *)
(* Latest Version is on GitHub: https://github.com/LaVieEstUnJeu/API          *)
(* ************************************************************************** *)

(* Return formatted JSON trees containing API responses                       *)

let response (rspcode, rspmsg) tree =
  `Assoc [("rspcode", `Int rspcode);
	  ("rspmsg",  `String rspmsg);
	  ("content",  tree);
	 ]

let error err =
  response err `Null

let errors err =
  let assoc (rspcode, rspmsg) =
    `Assoc [("rspcode", `Int rspcode);
	    ("rspmsg",  `String rspmsg)] in
  response Rspcode.invalid_data (`List (List.map assoc err))

let success =
  response Rspcode.success


