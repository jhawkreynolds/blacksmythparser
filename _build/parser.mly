
%{
   open Ast
%}

%token <string> FOO
%token EOF

%start main
%type <expr> main

%%

main:
  | e = rec_expr EOF
    { EBar(e, ENil) }

rec_expr:
  | e1 = expr e2 = rec_expr
    { EBar(e1, e2) }
  | e = expr
    { e }

expr:
  | f = FOO
    { EFoo(f) }
