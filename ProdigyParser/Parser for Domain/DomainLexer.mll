 (* File lexer.mll *)
{
open DomainParser        (* The type token is defined in parser.mli *)
exception Eof
}

(* id-name *)
let id = ['a'-'z' 'A'-'Z' '0'-'9']['a'-'z' 'A'-'Z' '0'-'9' '_' '-' '/']*
(* Variables are enclosed in <> *)
let var = '<'['a'-'z' 'A'-'Z' '0'-'9' '_' '-' ''']+'>'

let word = ['a'-'z' '<' '>' ':' '~' '*' '"' '`']+['a'-'z' 'A'-'Z' '0'-'9' '_' '-' ''' '<' '>' ':']*
let word2 = ['A'-'Z' '0'-'9' '#']+['a'-'z' 'A'-'Z' '0'-'9' '_' '-' ''' '<' '>']* 
 let integer = ['0'-'9']+
(*let filepath = ''' [^''']* '''*)
(*Comment starts with ;*)
let comment = [';'][^'\n']*   
let multilineComment = "#|"_*"|#"  

rule token = parse
    [' ' '\t' '\r' '\n']     { token lexbuf }     (* skip blanks *)
  | comment as c             { token lexbuf}
  | multilineComment as c    { token lexbuf} 
  | "'"                      { token lexbuf}
  | '('                      { LPAREN }
  | ')'                      { RPAREN }
  | '.'                      { DOT }
(*  | "create-problem-space"   { CREATE_PROB }
  | ":current"               { CURR } *)
  | "OPERATOR"               { OPERATOR }
  | "operator"               { OPERATOR }
  | "Operator"               { OPERATOR }
  | "params"                 { PARAMS }
  | "PARAMS"                 { PARAMS }
  | "preconds"               { PRECONDS }
  | "PRECONDS"               { PRECONDS }
  | "effects"                { EFF }
  | "EFFECTS"                { EFF }
  | "del"                    { DELETE }
  | "DEL"                    { DELETE }
  | "add"                    { ADD }
  | "ADD"                    { ADD }
  | "and"                    { AND }
  | "AND"                    { AND }
  | "or"                     { OR  }
  | "OR"                     { OR  }
  | "~"                      { TILDE }
(*  | "CONTROL-RULE"           { CONTROL_RULE }
  | "control-rule"           { CONTROL_RULE }
  | "defun"                  { DEFUN } 
  | "if"                     { IF } 
  | "IF"                     { IF }
  | "then"                   { THEN } 
  | "THEN"                   { THEN }
  | "node"                   { NODE }
  | "goal"                   { GOAL }
  | "bindings"               { BINDINGS }
  | "select"                 { SELECT }
  | "reject"                 { REJECT }
  | "prefer"                 { PREFER }
  | "sub-goal"               { SUBGOAL } *)
  | id as s                  { ID(s) }
  | var as v                 { VAR(v) }
  | word as w                { WORD(w) }
  | word2 as w               { WORD(w) }
  | integer as i             { WORD(i) }
(*| filepath                 { FILEPATH } *)
  | eof                      { EOF }
  | _ as c      { Printf.printf "Unrecognized character: %c\n" c; raise (Failure "")}
