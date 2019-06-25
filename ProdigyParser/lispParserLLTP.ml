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

open Parsing;;
let _ = parse_error;;
# 2 "lispParserLLTP.mly"
 

# 21 "lispParserLLTP.ml"
let yytransl_const = [|
    0 (* EOF *);
  257 (* SETF *);
  258 (* CURR_PROB *);
  259 (* CREATE_PROB *);
  260 (* NAME *);
  261 (* OBJECTS *);
  262 (* STATE *);
  263 (* AND *);
  264 (* GOAL *);
  265 (* LPAREN *);
  266 (* RPAREN *);
    0|]

let yytransl_block = [|
  267 (* WORD *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\003\000\006\000\006\000\004\000\008\000\008\000\
\005\000\005\000\009\000\009\000\007\000\007\000\000\000"

let yylen = "\002\000\
\013\000\004\000\004\000\003\000\004\000\007\000\003\000\004\000\
\007\000\004\000\003\000\004\000\001\000\002\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\015\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\002\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\003\000\000\000\000\000\000\000\014\000\
\000\000\000\000\000\000\000\000\001\000\005\000\000\000\000\000\
\000\000\000\000\010\000\000\000\000\000\000\000\000\000\000\000\
\000\000\006\000\000\000\012\000\008\000\009\000"

let yydgoto = "\002\000\
\004\000\012\000\015\000\019\000\025\000\022\000\042\000\040\000\
\036\000"

let yysindex = "\002\000\
\254\254\000\000\003\255\000\000\000\255\008\255\001\255\004\255\
\009\255\005\255\011\255\007\255\006\255\014\255\012\255\010\255\
\013\255\017\255\015\255\000\000\016\255\018\255\020\255\022\255\
\021\255\016\255\023\255\000\000\019\255\025\255\026\255\000\000\
\013\255\028\255\251\254\029\255\000\000\000\000\016\255\030\255\
\032\255\033\255\000\000\034\255\035\255\016\255\036\255\032\255\
\028\255\000\000\037\255\000\000\000\000\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\038\255\000\000\000\000\000\000\000\000\000\000\000\000\
\039\255\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\040\255\
\041\255\000\000\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\248\255\235\255\239\255\
\216\255"

let yytablesize = 51
let yytable = "\027\000\
\047\000\041\000\001\000\005\000\032\000\026\000\003\000\052\000\
\006\000\007\000\008\000\010\000\009\000\011\000\013\000\014\000\
\016\000\044\000\017\000\020\000\018\000\021\000\023\000\024\000\
\038\000\034\000\026\000\028\000\029\000\030\000\031\000\053\000\
\033\000\035\000\000\000\037\000\039\000\000\000\043\000\045\000\
\046\000\000\000\048\000\049\000\050\000\051\000\054\000\013\000\
\004\000\011\000\007\000"

let yycheck = "\021\000\
\041\000\007\001\001\000\001\001\026\000\011\001\009\001\048\000\
\009\001\002\001\010\001\003\001\009\001\009\001\004\001\009\001\
\011\001\039\000\005\001\010\001\009\001\009\001\006\001\009\001\
\033\000\007\001\011\001\010\001\009\001\008\001\010\001\049\000\
\010\001\009\001\255\255\010\001\009\001\255\255\010\001\010\001\
\009\001\255\255\010\001\010\001\010\001\010\001\010\001\010\001\
\010\001\010\001\010\001"

let yynames_const = "\
  EOF\000\
  SETF\000\
  CURR_PROB\000\
  CREATE_PROB\000\
  NAME\000\
  OBJECTS\000\
  STATE\000\
  AND\000\
  GOAL\000\
  LPAREN\000\
  RPAREN\000\
  "

let yynames_block = "\
  WORD\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _8 = (Parsing.peek_val __caml_parser_env 5 : 'naming) in
    let _9 = (Parsing.peek_val __caml_parser_env 4 : 'obj) in
    let _10 = (Parsing.peek_val __caml_parser_env 3 : 'states) in
    let _11 = (Parsing.peek_val __caml_parser_env 2 : 'goals) in
    Obj.repr(
# 17 "lispParserLLTP.mly"
                                                    ( (_8, _10, _11) )
# 130 "lispParserLLTP.ml"
               : string * string list list * string list list))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 1 : string) in
    Obj.repr(
# 21 "lispParserLLTP.mly"
                                                          ( _3 )
# 137 "lispParserLLTP.ml"
               : 'naming))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'irrelevant) in
    Obj.repr(
# 26 "lispParserLLTP.mly"
                                                           ()
# 144 "lispParserLLTP.ml"
               : 'obj))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'words) in
    Obj.repr(
# 29 "lispParserLLTP.mly"
                                                           ()
# 151 "lispParserLLTP.ml"
               : 'irrelevant))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'words) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'irrelevant) in
    Obj.repr(
# 30 "lispParserLLTP.mly"
                                                           ()
# 159 "lispParserLLTP.ml"
               : 'irrelevant))
; (fun __caml_parser_env ->
    let _5 = (Parsing.peek_val __caml_parser_env 2 : 'states1) in
    Obj.repr(
# 36 "lispParserLLTP.mly"
                                                          ( _5 )
# 166 "lispParserLLTP.ml"
               : 'states))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'words) in
    Obj.repr(
# 39 "lispParserLLTP.mly"
                                                          ( [_2] )
# 173 "lispParserLLTP.ml"
               : 'states1))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'words) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'states1) in
    Obj.repr(
# 40 "lispParserLLTP.mly"
                                                         ( _2::_4 )
# 181 "lispParserLLTP.ml"
               : 'states1))
; (fun __caml_parser_env ->
    let _5 = (Parsing.peek_val __caml_parser_env 2 : 'goals1) in
    Obj.repr(
# 46 "lispParserLLTP.mly"
                                                           ( _5 )
# 188 "lispParserLLTP.ml"
               : 'goals))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'goals1) in
    Obj.repr(
# 47 "lispParserLLTP.mly"
                                                           ( _3 )
# 195 "lispParserLLTP.ml"
               : 'goals))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'words) in
    Obj.repr(
# 50 "lispParserLLTP.mly"
                                                          ( [_2] )
# 202 "lispParserLLTP.ml"
               : 'goals1))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'words) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'goals1) in
    Obj.repr(
# 51 "lispParserLLTP.mly"
                                                         ( _2::_4 )
# 210 "lispParserLLTP.ml"
               : 'goals1))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 55 "lispParserLLTP.mly"
                                                            ( [_1] )
# 217 "lispParserLLTP.ml"
               : 'words))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'words) in
    Obj.repr(
# 56 "lispParserLLTP.mly"
                                                            ( _1 :: _2 )
# 225 "lispParserLLTP.ml"
               : 'words))
(* Entry main *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let main (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : string * string list list * string list list)
;;
