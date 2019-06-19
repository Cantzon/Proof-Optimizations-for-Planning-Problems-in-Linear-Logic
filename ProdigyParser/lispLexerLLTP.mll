 (* File lexer.mll *)
{
open LispParserLLTP        (* The type token is defined in parser.mli *)
exception Eof
}


let word = ['a'-'z']+['a'-'z' 'A'-'Z' '0'-'9' '_']*
let word2 = ['A'-'Z']+['a'-'z' 'A'-'Z' '0'-'9' '_']* 
 let integer = ['0'-'9']+
(*let filepath = ''' [^''']* '''*)
(*Comment starts with ;*)
let comment = [';'][^'\n']*   

rule token = parse
    [' ' '\t' '\r' '\n']     { token lexbuf }     (* skip blanks *)
  | comment as c             { token lexbuf}
  | '('                      { LPAREN }
  | ')'                      { RPAREN }
  | "setf"                   { SETF }
  | "current-problem"        { CURR_PROB }
  | "create-problem"         { CREATE_PROB }
  | "name"                   { NAME }
  | "objects"                { OBJECTS }
(*| "object-is" *)
(*| "objects-are" *)
  | "state"                  { STATE }
  | "and"                    { AND }
  | "igoal"                  { GOAL }
  | word as w                { WORD(w) }
  | word2 as w                 { WORD(w) }
  | integer as i             { INT(int_of_string i) }
(*| filepath                 { FILEPATH } *)
  | eof                      { raise Eof }
  | _ as c      { Printf.printf "Unrecognized character: %c\n" c; raise (Failure "")}

