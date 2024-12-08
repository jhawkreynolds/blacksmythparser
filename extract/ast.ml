
open Printf

type expr =
  | ENil
  | EFunc   of string

let rec pprint_header = function
  | "max" -> sprintf "max : Nat -> Nat -> Nat\n" ^ "max m n =\n" ^ "    ??\n"
  | "min" -> sprintf "min : Nat -> Nat -> Nat\n" ^ "min m n =\n" ^ "    ??\n"
  | _ -> sprintf "error: function unknown"

let rec pprint_expr = function
  | ENil -> sprintf "ENil"
  | EFunc(x) -> pprint_header (String.trim x)

let rec pprint = function
  | [] -> sprintf ""
  | e1::e2 -> pprint_expr e1 ^ "\n" ^ pprint e2

let rec unduplicate = function
  | [] -> []
  | e1::e2 -> if List.mem e1 e2 
              then unduplicate e2
              else e1 :: unduplicate e2