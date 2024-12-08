
(* The type of tokens. *)

type token = 
  | TYPELINE of (string)
  | OTHERLINE of (string)
  | FUNC of (string)
  | EOF

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val main: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Ast.expr list)
