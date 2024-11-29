Inductive AE : Type :=
    | Num (n:nat)
    | Add (x:AE) (y:AE)
    | Sub (x:AE) (y:AE)
    | Hole
.

Definition included (ae:AE) : bool :=
    match ae with 
    | Num n => true
    | Add x y => true
    | Sub x y => false
    | Hole => false
end.

Fixpoint parseAndRemove (ae:AE) 
  : AE :=
    match ae with 
    | Num n => 
        if included(ae) 
        then Num n 
        else Hole
    | Add x y => 
        if included(ae)
        then Add (parseAndRemove x) (parseAndRemove y)
        else Hole
    | Sub x y =>
        if included(ae)
        then Sub (parseAndRemove x) (parseAndRemove y)
        else Hole
    | Hole => Hole
end.

Compute parseAndRemove(
Add 
    (Num 1) 
    (Sub 
        (Num 1) 
        (Num 1)
    )
    
).

Inductive ID : Type :=
Admitted.

Inductive Expr : Type :=
    | Fix (f : ID) (x: ID) (e: Expr)
    | App (e1 : Expr) (e2 : Expr)
    | X (x : ID)
    | Parens
    | Sequence (e1: Expr) (e2: Expr)
.