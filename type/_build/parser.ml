
module MenhirBasics = struct
  
  exception Error
  
  let _eRR =
    fun _s ->
      raise Error
  
  type token = 
    | TYPELINE of (
# 7 "parser.mly"
       (string)
# 15 "parser.ml"
  )
    | OTHERLINE of (
# 8 "parser.mly"
       (string)
# 20 "parser.ml"
  )
    | FUNC of (
# 6 "parser.mly"
       (string)
# 25 "parser.ml"
  )
    | EOF
  
end

include MenhirBasics

# 2 "parser.mly"
  
   open Ast

# 37 "parser.ml"

type ('s, 'r) _menhir_state = 
  | MenhirState0 : ('s, _menhir_box_main) _menhir_state
    (** State 0.
        Stack shape : .
        Start symbol: main. *)

  | MenhirState7 : (('s, _menhir_box_main) _menhir_cell1_expr, _menhir_box_main) _menhir_state
    (** State 7.
        Stack shape : expr.
        Start symbol: main. *)


and ('s, 'r) _menhir_cell1_expr = 
  | MenhirCell1_expr of 's * ('s, 'r) _menhir_state * (Ast.expr list)

and _menhir_box_main = 
  | MenhirBox_main of (Ast.expr list) [@@unboxed]

let _menhir_action_1 =
  fun f ->
    (
# 28 "parser.mly"
    ( [EFunc(f)] )
# 62 "parser.ml"
     : (Ast.expr list))

let _menhir_action_2 =
  fun t ->
    (
# 30 "parser.mly"
    ( [TypeLine(t)] )
# 70 "parser.ml"
     : (Ast.expr list))

let _menhir_action_3 =
  fun o ->
    (
# 32 "parser.mly"
    ( [OtherLine(o)] )
# 78 "parser.ml"
     : (Ast.expr list))

let _menhir_action_4 =
  fun e ->
    (
# 18 "parser.mly"
    ( e )
# 86 "parser.ml"
     : (Ast.expr list))

let _menhir_action_5 =
  fun e1 e2 ->
    (
# 22 "parser.mly"
    ( e1 @ e2 )
# 94 "parser.ml"
     : (Ast.expr list))

let _menhir_action_6 =
  fun e ->
    (
# 24 "parser.mly"
    ( e )
# 102 "parser.ml"
     : (Ast.expr list))

let _menhir_print_token : token -> string =
  fun _tok ->
    match _tok with
    | EOF ->
        "EOF"
    | FUNC _ ->
        "FUNC"
    | OTHERLINE _ ->
        "OTHERLINE"
    | TYPELINE _ ->
        "TYPELINE"

let _menhir_fail : unit -> 'a =
  fun () ->
    Printf.eprintf "Internal failure -- please contact the parser generator's developers.\n%!";
    assert false

include struct
  
  [@@@ocaml.warning "-4-37"]
  
  let _menhir_run_4 : type  ttv_stack. ttv_stack -> _ -> _menhir_box_main =
    fun _menhir_stack _v ->
      let e = _v in
      let _v = _menhir_action_4 e in
      MenhirBox_main _v
  
  let rec _menhir_goto_rec_expr : type  ttv_stack. ttv_stack -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _v _menhir_s ->
      match _menhir_s with
      | MenhirState7 ->
          _menhir_run_8 _menhir_stack _v
      | MenhirState0 ->
          _menhir_run_4 _menhir_stack _v
  
  and _menhir_run_8 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_expr -> _ -> _menhir_box_main =
    fun _menhir_stack _v ->
      let MenhirCell1_expr (_menhir_stack, _menhir_s, e1) = _menhir_stack in
      let e2 = _v in
      let _v = _menhir_action_5 e1 e2 in
      _menhir_goto_rec_expr _menhir_stack _v _menhir_s
  
  let rec _menhir_run_1 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let t = _v in
      let _v = _menhir_action_2 t in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_expr : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | TYPELINE _v_0 ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_1 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState7
      | OTHERLINE _v_1 ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_2 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState7
      | FUNC _v_2 ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_3 _menhir_stack _menhir_lexbuf _menhir_lexer _v_2 MenhirState7
      | EOF ->
          let e = _v in
          let _v = _menhir_action_6 e in
          _menhir_goto_rec_expr _menhir_stack _v _menhir_s
  
  and _menhir_run_2 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let o = _v in
      let _v = _menhir_action_3 o in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_3 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let f = _v in
      let _v = _menhir_action_1 f in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  let _menhir_run_0 : type  ttv_stack. ttv_stack -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState0 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TYPELINE _v ->
          _menhir_run_1 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OTHERLINE _v ->
          _menhir_run_2 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FUNC _v ->
          _menhir_run_3 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
end

let main =
  fun _menhir_lexer _menhir_lexbuf ->
    let _menhir_stack = () in
    let MenhirBox_main v = _menhir_run_0 _menhir_stack _menhir_lexbuf _menhir_lexer in
    v
