type token =
  | EOF
  | SETF
  | CURR_PROB
  | CREATE_PROB
  | NAME
  | OBJECTS
  | STATE
  | AND
  | GOAL
  | LPAREN
  | RPAREN
  | WORD of (string)
  | INT of (int)

val main :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> string * string list * string list
