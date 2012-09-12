(* ************************************************************************** *)
(* Project: La Vie Est Un Jeu - API                                           *)
(* Description: Achievement service API, get informations about achievements  *)
(* Author: db0 (db0company@gmail.com, http://db0.fr/)                         *)
(* Latest Version is on GitHub: https://github.com/LaVieEstUnJeu/API          *)
(* ************************************************************************** *)

open Eliom_parameter

let achievement =
  EliomJson.register_service
    ~path:["achievement"]
    ~get_params:unit
    (fun () () ->
      Lwt.return
	(`List
	    [`Assoc
		[("id",        `Int    5);
		 ("nickname",  `String "db0");
		 ("firstname", `String "Barbara");
		 ("lastname",  `String "Lepage");
		 ("idpicture", `Int     5);
		 ("timezone",  `Int     5);
		 ("sex",       `Bool    true);
		 ("birth",     `String "05-30-1991");
		];
	     `Assoc
	       [("id",        `Int    5);
		("nickname",  `String "db0");
		("firstname", `String "Barbara");
		("lastname",  `String "Lepage");
		("idpicture", `Int     5);
		("timezone",  `Int     5);
		("sex",       `Bool    true);
		("birth",     `String "05-30-1991");
	       ];
	    ])
    )
