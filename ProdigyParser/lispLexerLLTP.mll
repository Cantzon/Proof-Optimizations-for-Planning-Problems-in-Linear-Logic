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
  | word2 as w                 { WORD(v) }
  | integer as i             { INTEGER(int_of_string i) }
(*| filepath                 { FILEPATH } *)
  | eof                      { raise Eof }
  | _ as c      { Printf.printf "Unrecognized character: %c\n" c; raise (Failure "")}



(*Things to ask:

  regexp of filepath
  create-problem-space
  placements of "and" in preconditions, check olddomain1 of blocksworld, 
  general syntax of preconditions
  what the fuck is a control rule
  what's defun
  what does the tilde do ( apparently is supposed to introduce a directive,
                           which specifies what kind of fomatting is needed)
  the "on" verb is used within the unstack operator of hanoi and move-disk operator of blcokworld wtf is it
  
  



  operators  are pretty much implications you add to the context
  control rules are helpers for the efficiency of the problem solver
        and improves the qualitgy of solutions that are found  so should we care?

  *)