
open Printf

type expr =
  | ENil
  | EFoo   of string
  | EBar   of expr * expr

let rec pprint_expr = function
  | ENil -> sprintf "ENil"
  | EFoo(x) -> sprintf "func("^ x ^")"
  | EBar(e1, e2) -> "cons(" ^ pprint_expr e1 ^ ",\n" ^
                            pprint_expr e2 ^ ")"

