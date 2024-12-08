
open Printf

type expr =
  | ENil
  | EFoo   of string
  | EBar   of expr * expr

let rec pprint_header = function
  | "max" -> sprintf "max :: Int -> Int -> Int\n" ^ "max m n = ??"
  | "min" -> sprintf "min :: Int -> Int -> Int\n" ^ "min m n = ??"
  | _ -> sprintf "error: function unknown"

let rec pprint_expr = function
  | ENil -> sprintf "ENil"
  | EFoo(x) -> pprint_header (String.trim x)
  | EBar(e1, e2) -> pprint_expr e1 ^ "\n" ^
                    pprint_expr e2

let rec pprint = function
  | [] -> sprintf ""
  | e1::e2 -> pprint_expr e1 ^ "\n" ^ pprint e2

let rec unduplicate = function
  | [] -> []
  | e1::e2 -> if List.mem e1 e2 
              then unduplicate e2
              else e1 :: unduplicate e2