type token =
  | EOF
  | SETF
  | CURR
  | CREATE_PROB
  | OPERATOR
  | NODE
  | GOAL
  | BINDINGS
  | SELECT
  | REJECT
  | PREFER
  | SUBGOAL
  | PARAMS
  | PRECONDS
  | EFF
  | AND
  | DELETE
  | ADD
  | CONTROL_RULE
  | IF
  | THEN
  | LPAREN
  | RPAREN
  | DOT
  | WORD of (string)
  | ID of (string)
  | VAR of (string)

val main :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> (string * (string * string list) list * (string * string list) list) list 
