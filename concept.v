Require Coq.extraction.Extraction.
Extraction Language OCaml.

Inductive AE : Type :=
    | Num (n:nat)
    | Add (x:AE) (y:AE)
    | Sub (x:AE) (y:AE)
    | Hole
.

Inductive ChangelogStatus : Type :=
    | Unchanged
    | Added
    | Removed
    | Modified
.

Inductive Transformation : Type :=
    | L1_to_core
    | Core_to_L2
.

Definition changelogMapping (ae:AE) : ChangelogStatus :=
    match ae with 
    | Num n => Unchanged
    | Add x y => Unchanged
    | Sub x y => Removed
    | Hole => Removed
end.

Definition included (t:Transformation) (ae:AE) : bool :=
    match changelogMapping (ae) with
    | Unchanged => true
    | Added =>
        match t with
        | L1_to_core => false
        | Core_to_L2 => true 
        (* Only allow on second translation *)
        end
    | Removed => false
    | Modified => false
end.

Fixpoint preprocess (t:Transformation) (ae:AE) 
  : AE :=
    match ae with 
    | Num n => 
        if included t ae 
        then Num n 
        else Hole
    | Add x y => 
        if included t ae
        then Add (preprocess t x) (preprocess t y)
        else Hole
    | Sub x y =>
        if included t ae
        then Sub (preprocess t x) (preprocess t y)
        else Hole
    | Hole => Hole
end.

Compute preprocess
L1_to_core
(
Add 
    (Num 1) 
    (Sub 
        (Num 1) 
        (Num 1)
    )
    
).

Extraction "preprocessor.ml" preprocess. 