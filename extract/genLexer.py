import sys

def read(input_file : str) -> list[str]:
    try:
        # Open the file in read mode
        with open(input_file, 'r') as file:
            # Read all lines and store them in a list
            lines = file.readlines()
            # Optionally strip newlines
            lines = [line for line in lines if line.strip() != '']

        return lines
    except FileNotFoundError:
        print(f"Error: The file '{input_file}' was not found.")
        return []
    except Exception as e:
        print(f"An error occurred: {e}")
        return []

def write(output_str : str, output_file : str ):
    try:
        with open(output_file, 'w') as file:
            file.write(output_str)
    except Exception as e:
        print(f"An error occurred: {e}")
    
def parse( funcs : list[str]) -> list[list[str]]:
    funcs_split = []
    funcs_parsed = []
    to_remove = [':', '->']
    for func in funcs:
        funcs_split.append(func.split())

    for func in funcs_split:
        new_terms = []
        for term in func:
            if term in to_remove:
                continue
            new_terms.append(term)
        funcs_parsed.append(new_terms)
    
    return funcs_parsed

# Generates a list of parameters for a function from a, b, ...
# Should include a check for reasonable number of params however does not yet
def genParams( func : list[str]):
    num_param = len(func) - 2

    base_chr = 97
    params_str = ""

    for i in range(0,num_param):
        params_str += chr(base_chr + i) + " "

    return params_str

def genLexer(funcs : list[list[str]]):
    prestring = '''   
{
 open Parser
 exception Error of char
}
'''

    poststring = '''
(* Possible functions to substitute in. *)
let ws = [' ' '\\t']
let wsn = [' ' '\\t' '\\n']
let wslpar = ws | ['(']
let wsnrpar = wsn | [')']
(* Multiple shorthands for variations of whitespace.*)

rule token = parse
| wslpar func wsnrpar as lxm
    { FUNC(lxm) }
    (* Grab a function name and store it as a token.*)
|  wsn
    { token lexbuf }
    (* Trash all whitespace. *)
| eof
    { EOF }
    (* Track the end of file. *)
| _
    { token lexbuf }
    (* Trash everything else. *)
| _ as c
    { raise (Error c) }'''
    
    # let func = "max" | "min"

    instring = '\nlet func = '
    for i in range(len(funcs)):
        func = funcs[i]
        func_str = '"' + func[0] + '"'
        
        if(i < len(funcs)-1): func_str += ' | '
        else: func_str += '\n'

        instring += func_str
    
    return prestring + instring + poststring

def genAST(funcs : list[list[str]]):
    prestring = '''
open Printf
(* Required for using printing in OCaml. *)

type expr =
 | ENil
 | EFunc   of string
(*
Simple expr type that can accept a nil constructor (used for debugging)
or a function constructor with the name of a function.
*)

(*
The following function prints out the collected
function headers when an instance of the function is mentioned.
It is autogenerated by genLexer.py.
*)
let rec pprint_header = function'''

    poststring = '''
 | _ -> sprintf "error: function unknown"

 
(*
Print an expression. This just invokes printing the header.
*)
let rec pprint_expr = function
 | ENil -> sprintf "ENil"
 | EFunc(x) -> pprint_header (String.trim x)

(*
This pretty prints the input list of expressions.
It breaks by newline.
*)
let rec pprint = function
| [] -> sprintf ""
| e1::e2 -> pprint_expr e1 ^ "\\n" ^ pprint e2

(*
The following function turns a list
which may contain duplicates
into a list that cannot.
It removes the head of the list
if the rest of the list contains the head.
This is needed to avoid multiple function declarations.
*)
let rec unduplicate = function
| [] -> []
| e1::e2 -> if List.mem e1 e2 
            then unduplicate e2
            else e1 :: unduplicate e2'''
    
    #| "max" -> sprintf "max : Nat -> Nat -> Nat\n" ^ "max m n =\n" ^ "    ??\n"

    instring = '\n'

    for i in range(len(funcs)):
        func = funcs[i]
        func_str = ' | \"' + func[0] + '\" -> sprintf \"' + func[0] + ' : '

        for j in range(1, len(func)-1):
            func_str += func[j] + ' -> '
        func_str += func[j] + '\\n" ^ "' + func[0] + ' ' + genParams(func) + '=\\n" ^ "    ??\\n"'

        if i < (len(funcs)-1) : 
            func_str += '\n'

        instring += func_str

    return prestring + instring + poststring


input_file = sys.argv[1]
func_decl = parse(read(input_file))

outputAST = "ast.ml"
outputLexer = "lexer.mll"

write(genAST(func_decl), outputAST)
write(genLexer(func_decl), outputLexer)