type token =
  | EOF
  | SETF
  | CURR_T
  | CREATE_PROB
  | OPERATOR
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
  | WORD of (string)

val main :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> string list
