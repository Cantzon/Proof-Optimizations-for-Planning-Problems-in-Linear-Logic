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

val main :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> string * string list list * string list list
