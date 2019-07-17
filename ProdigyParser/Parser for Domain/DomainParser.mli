type token =
  | EOF
  | OPERATOR
  | PARAMS
  | PRECONDS
  | EFF
  | AND
  | DELETE
  | ADD
  | LPAREN
  | RPAREN
  | DOT
  | WORD of (string)
  | ID of (string)
  | VAR of (string)

val main :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> (string * (string * string list) list * (string * string list) list) list 
