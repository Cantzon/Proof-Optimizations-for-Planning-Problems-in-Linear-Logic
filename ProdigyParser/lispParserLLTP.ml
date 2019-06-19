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
  268 (* INT *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\003\000\006\000\006\000\004\000\008\000\008\000\
\005\000\009\000\009\000\007\000\007\000\007\000\007\000\000\000"

let yylen = "\002\000\
\013\000\004\000\004\000\003\000\004\000\007\000\003\000\004\000\
\007\000\003\000\004\000\001\000\001\000\002\000\002\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\016\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\002\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\003\000\000\000\000\000\000\000\
\014\000\015\000\000\000\000\000\000\000\001\000\005\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\006\000\
\000\000\000\000\008\000\000\000\009\000\011\000"

let yydgoto = "\002\000\
\004\000\012\000\015\000\019\000\025\000\022\000\028\000\041\000\
\046\000"

let yysindex = "\003\000\
\252\254\000\000\005\255\000\000\254\254\006\255\255\254\001\255\
\008\255\003\255\009\255\007\255\004\255\012\255\011\255\013\255\
\015\255\016\255\017\255\000\000\247\254\018\255\020\255\010\255\
\021\255\247\254\247\254\022\255\000\000\014\255\024\255\025\255\
\000\000\000\000\015\255\027\255\023\255\000\000\000\000\247\254\
\028\255\030\255\031\255\032\255\247\254\033\255\027\255\000\000\
\034\255\035\255\000\000\030\255\000\000\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\036\255\037\255\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\038\255\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\039\255\000\000\
\000\000\000\000\000\000\040\255\000\000\000\000"

let yygindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\246\255\230\255\236\255\
\238\255"

let yytablesize = 50
let yytable = "\033\000\
\034\000\026\000\027\000\001\000\003\000\005\000\006\000\007\000\
\008\000\009\000\010\000\011\000\013\000\043\000\016\000\014\000\
\017\000\031\000\049\000\018\000\036\000\023\000\020\000\021\000\
\039\000\024\000\051\000\029\000\030\000\042\000\032\000\035\000\
\037\000\054\000\038\000\040\000\000\000\044\000\045\000\000\000\
\047\000\048\000\050\000\052\000\053\000\012\000\013\000\004\000\
\007\000\010\000"

let yycheck = "\026\000\
\027\000\011\001\012\001\001\000\009\001\001\001\009\001\002\001\
\010\001\009\001\003\001\009\001\004\001\040\000\011\001\009\001\
\005\001\008\001\045\000\009\001\007\001\006\001\010\001\009\001\
\035\000\009\001\047\000\010\001\009\001\007\001\010\001\010\001\
\009\001\052\000\010\001\009\001\255\255\010\001\009\001\255\255\
\010\001\010\001\010\001\010\001\010\001\010\001\010\001\010\001\
\010\001\010\001"

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
  INT\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _8 = (Parsing.peek_val __caml_parser_env 5 : 'naming) in
    let _9 = (Parsing.peek_val __caml_parser_env 4 : 'obj) in
    let _10 = (Parsing.peek_val __caml_parser_env 3 : 'states) in
    let _11 = (Parsing.peek_val __caml_parser_env 2 : 'goals) in
    Obj.repr(
# 16 "lispParserLLTP.mly"
                                                    ( (_8, _10, _11) )
# 132 "lispParserLLTP.ml"
               : string * string list * string list))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 1 : string) in
    Obj.repr(
# 20 "lispParserLLTP.mly"
                                                          ( _3 )
# 139 "lispParserLLTP.ml"
               : 'naming))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'irrelevant) in
    Obj.repr(
# 25 "lispParserLLTP.mly"
                                                           ()
# 146 "lispParserLLTP.ml"
               : 'obj))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'words) in
    Obj.repr(
# 28 "lispParserLLTP.mly"
                                                           ()
# 153 "lispParserLLTP.ml"
               : 'irrelevant))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'words) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'irrelevant) in
    Obj.repr(
# 29 "lispParserLLTP.mly"
                                                           ()
# 161 "lispParserLLTP.ml"
               : 'irrelevant))
; (fun __caml_parser_env ->
    let _5 = (Parsing.peek_val __caml_parser_env 2 : 'states1) in
    Obj.repr(
# 35 "lispParserLLTP.mly"
                                                          ( _5 )
# 168 "lispParserLLTP.ml"
               : 'states))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'words) in
    Obj.repr(
# 38 "lispParserLLTP.mly"
                                                          ( [_2] )
# 175 "lispParserLLTP.ml"
               : 'states1))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'words) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'states1) in
    Obj.repr(
# 39 "lispParserLLTP.mly"
                                                         ( _2::_4 )
# 183 "lispParserLLTP.ml"
               : 'states1))
; (fun __caml_parser_env ->
    let _5 = (Parsing.peek_val __caml_parser_env 2 : 'goals1) in
    Obj.repr(
# 45 "lispParserLLTP.mly"
                                                          ( _5 )
# 190 "lispParserLLTP.ml"
               : 'goals))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'words) in
    Obj.repr(
# 48 "lispParserLLTP.mly"
                                                          ( [_2] )
# 197 "lispParserLLTP.ml"
               : 'goals1))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'words) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'goals1) in
    Obj.repr(
# 49 "lispParserLLTP.mly"
                                                         ( _2::_4 )
# 205 "lispParserLLTP.ml"
               : 'goals1))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 53 "lispParserLLTP.mly"
                                                            ( [_1] )
# 212 "lispParserLLTP.ml"
               : 'words))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 54 "lispParserLLTP.mly"
                                                            ( [_1] )
# 219 "lispParserLLTP.ml"
               : 'words))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'words) in
    Obj.repr(
# 55 "lispParserLLTP.mly"
                                                            ( _1 :: _2 )
# 227 "lispParserLLTP.ml"
               : 'words))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : int) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'words) in
    Obj.repr(
# 56 "lispParserLLTP.mly"
                                                            ( _1 :: _2 )
# 235 "lispParserLLTP.ml"
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
   (Parsing.yyparse yytables 1 lexfun lexbuf : string * string list * string list)
;;
