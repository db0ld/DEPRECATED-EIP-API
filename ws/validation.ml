let check_login login = Str.string_match (Str.regexp "^[a-zA-Z][a-zA-Z0-9_-]{0,63}$") login 0

let check_password password = (String.length password) >= 8

let check_email email = Str.string_match (Str.regexp "^[a-z0-9_.+-]+@([^.]+\\.)+[^.]+$") email 0
