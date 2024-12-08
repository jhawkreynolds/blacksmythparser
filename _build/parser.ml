
module MenhirBasics = struct
  
  exception Error
  
  let _eRR =
    fun _s ->
      raise Error
  
  type token = 
    | FOO of (
# 6 "parser.mly"
       (string)
# 15 "parser.ml"
  )
    | EOF
  
end

include MenhirBasics

# 2 "parser.mly"
  
   open Ast

# 27 "parser.ml"

type ('s, 'r) _menhir_state = 
  | MenhirState0 : ('s, _menhir_box_main) _menhir_state
    (** State 0.
        Stack shape : .
        Start symbol: main. *)

  | MenhirState5 : (('s, _menhir_box_main) _menhir_cell1_expr, _menhir_box_main) _menhir_state
    (** State 5.
        Stack shape : expr.
        Start symbol: main. *)


and ('s, 'r) _menhir_cell1_expr = 
  | MenhirCell1_expr of 's * ('s, 'r) _menhir_state * (Ast.expr)

and _menhir_box_main = 
  | MenhirBox_main of (Ast.expr) [@@unboxed]

let _menhir_action_1 =
  fun f ->
    (
# 26 "parser.mly"
    ( EFoo(f) )
# 52 "parser.ml"
     : (Ast.expr))

let _menhir_action_2 =
  fun e ->
    (
# 16 "parser.mly"
    ( EBar(e, ENil) )
# 60 "parser.ml"
     : (Ast.expr))

let _menhir_action_3 =
  fun e1 e2 ->
    (
# 20 "parser.mly"
    ( EBar(e1, e2) )
# 68 "parser.ml"
     : (Ast.expr))

let _menhir_action_4 =
  fun e ->
    (
# 22 "parser.mly"
    ( e )
# 76 "parser.ml"
     : (Ast.expr))

let _menhir_print_token : token -> string =
  fun _tok ->
    match _tok with
    | EOF ->
        "EOF"
    | FOO _ ->
        "FOO"

let _menhir_fail : unit -> 'a =
  fun () ->
    Printf.eprintf "Internal failure -- please contact the parser generator's developers.\n%!";
    assert false

include struct
  
  [@@@ocaml.warning "-4-37"]
  
  let _menhir_run_2 : type  ttv_stack. ttv_stack -> _ -> _menhir_box_main =
    fun _menhir_stack _v ->
      let e = _v in
      let _v = _menhir_action_2 e in
      MenhirBox_main _v
  
  let rec _menhir_goto_rec_expr : type  ttv_stack. ttv_stack -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _v _menhir_s ->
      match _menhir_s with
      | MenhirState5 ->
          _menhir_run_6 _menhir_stack _v
      | MenhirState0 ->
          _menhir_run_2 _menhir_stack _v
  
  and _menhir_run_6 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_expr -> _ -> _menhir_box_main =
    fun _menhir_stack _v ->
      let MenhirCell1_expr (_menhir_stack, _menhir_s, e1) = _menhir_stack in
      let e2 = _v in
      let _v = _menhir_action_3 e1 e2 in
      _menhir_goto_rec_expr _menhir_stack _v _menhir_s
  
  let rec _menhir_run_1 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let f = _v in
      let _v = _menhir_action_1 f in
      match (_tok : MenhirBasics.token) with
      | FOO _v_0 ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_1 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState5
      | EOF ->
          let e = _v in
          let _v = _menhir_action_4 e in
          _menhir_goto_rec_expr _menhir_stack _v _menhir_s
  
  let _menhir_run_0 : type  ttv_stack. ttv_stack -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState0 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | FOO _v ->
          _menhir_run_1 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
end

let main =
  fun _menhir_lexer _menhir_lexbuf ->
    let _menhir_stack = () in
    let MenhirBox_main v = _menhir_run_0 _menhir_stack _menhir_lexbuf _menhir_lexer in
    v
