type token =
  | EOF
  | SETF
  | CURR_PROB
  | CREATE_PROB
  | NAME
  | OBJECTS
  | STATE
  | AND
  | OR
  | GOAL
  | LPAREN
  | RPAREN
  | WORD of (string)

open Parsing;;
let _ = parse_error;;
# 2 "lispParserLLTP.mly"
 

# 22 "lispParserLLTP.ml"
let yytransl_const = [|
    0 (* EOF *);
  257 (* SETF *);
  258 (* CURR_PROB *);
  259 (* CREATE_PROB *);
  260 (* NAME *);
  261 (* OBJECTS *);
  262 (* STATE *);
  263 (* AND *);
  264 (* OR *);
  265 (* GOAL *);
  266 (* LPAREN *);
  267 (* RPAREN *);
    0|]

let yytransl_block = [|
  268 (* WORD *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\003\000\006\000\006\000\006\000\004\000\008\000\
\008\000\008\000\005\000\005\000\005\000\005\000\005\000\005\000\
\005\000\005\000\005\000\009\000\009\000\009\000\007\000\007\000\
\000\000"

let yylen = "\002\000\
\013\000\004\000\004\000\002\000\003\000\004\000\007\000\002\000\
\003\000\004\000\007\000\007\000\004\000\010\000\010\000\007\000\
\006\000\009\000\009\000\002\000\003\000\004\000\001\000\002\000\
\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\025\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\002\000\000\000\000\000\000\000\000\000\
\000\000\004\000\000\000\000\000\003\000\000\000\000\000\000\000\
\024\000\000\000\000\000\000\000\000\000\001\000\006\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\013\000\008\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\007\000\020\000\000\000\000\000\000\000\000\000\
\017\000\000\000\000\000\022\000\010\000\011\000\012\000\000\000\
\000\000\000\000\000\000\016\000\000\000\000\000\000\000\000\000\
\018\000\019\000\000\000\000\000\014\000\015\000"

let yydgoto = "\002\000\
\004\000\012\000\015\000\019\000\025\000\022\000\046\000\041\000\
\037\000"

let yysindex = "\019\000\
\024\255\000\000\034\255\000\000\026\255\035\255\027\255\029\255\
\037\255\031\255\038\255\033\255\032\255\040\255\036\255\039\255\
\041\255\042\255\043\255\000\000\251\254\044\255\046\255\045\255\
\047\255\000\000\048\255\050\255\000\000\052\255\053\255\051\255\
\000\000\041\255\054\255\001\255\055\255\000\000\000\000\005\255\
\056\255\058\255\058\255\059\255\060\255\061\255\000\000\000\000\
\062\255\063\255\007\255\064\255\065\255\017\255\066\255\068\255\
\058\255\054\255\000\000\000\000\069\255\070\255\058\255\058\255\
\000\000\019\255\071\255\000\000\000\000\000\000\000\000\072\255\
\073\255\058\255\058\255\000\000\074\255\075\255\076\255\077\255\
\000\000\000\000\078\255\079\255\000\000\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\080\255\000\000\000\000\000\000\000\000\000\000\
\000\000\081\255\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\039\255\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\082\255\083\255\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\225\255\239\255\245\255\
\214\255"

let yytablesize = 94
let yytable = "\052\000\
\053\000\055\000\039\000\028\000\045\000\026\000\027\000\042\000\
\043\000\033\000\021\000\044\000\027\000\067\000\068\000\048\000\
\027\000\060\000\027\000\001\000\072\000\073\000\049\000\063\000\
\064\000\074\000\075\000\060\000\027\000\060\000\027\000\079\000\
\080\000\003\000\005\000\006\000\007\000\008\000\009\000\010\000\
\011\000\013\000\014\000\016\000\017\000\018\000\069\000\023\000\
\000\000\020\000\021\000\000\000\024\000\031\000\029\000\030\000\
\000\000\032\000\035\000\027\000\034\000\038\000\036\000\040\000\
\000\000\047\000\050\000\051\000\054\000\000\000\056\000\057\000\
\058\000\059\000\061\000\062\000\065\000\066\000\000\000\070\000\
\071\000\076\000\077\000\078\000\081\000\082\000\083\000\084\000\
\085\000\086\000\023\000\005\000\021\000\009\000"

let yycheck = "\042\000\
\043\000\044\000\034\000\021\000\036\000\011\001\012\001\007\001\
\008\001\027\000\010\001\011\001\012\001\056\000\057\000\011\001\
\012\001\011\001\012\001\001\000\063\000\064\000\040\000\007\001\
\008\001\007\001\008\001\011\001\012\001\011\001\012\001\074\000\
\075\000\010\001\001\001\010\001\002\001\011\001\010\001\003\001\
\010\001\004\001\010\001\012\001\005\001\010\001\058\000\006\001\
\255\255\011\001\010\001\255\255\010\001\009\001\011\001\010\001\
\255\255\011\001\007\001\012\001\011\001\011\001\010\001\010\001\
\255\255\011\001\011\001\010\001\010\001\255\255\011\001\011\001\
\011\001\011\001\011\001\011\001\011\001\010\001\255\255\011\001\
\011\001\011\001\011\001\011\001\011\001\011\001\011\001\011\001\
\011\001\011\001\011\001\011\001\011\001\011\001"

let yynames_const = "\
  EOF\000\
  SETF\000\
  CURR_PROB\000\
  CREATE_PROB\000\
  NAME\000\
  OBJECTS\000\
  STATE\000\
  AND\000\
  OR\000\
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
# 159 "lispParserLLTP.ml"
               : string * string list list * string list list))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 1 : string) in
    Obj.repr(
# 21 "lispParserLLTP.mly"
                                                          ( _3 )
# 166 "lispParserLLTP.ml"
               : 'naming))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'irrelevant) in
    Obj.repr(
# 26 "lispParserLLTP.mly"
                                                           ()
# 173 "lispParserLLTP.ml"
               : 'obj))
; (fun __caml_parser_env ->
    Obj.repr(
# 29 "lispParserLLTP.mly"
                             ()
# 179 "lispParserLLTP.ml"
               : 'irrelevant))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'words) in
    Obj.repr(
# 30 "lispParserLLTP.mly"
                                                           ()
# 186 "lispParserLLTP.ml"
               : 'irrelevant))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'words) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'irrelevant) in
    Obj.repr(
# 31 "lispParserLLTP.mly"
                                                           ()
# 194 "lispParserLLTP.ml"
               : 'irrelevant))
; (fun __caml_parser_env ->
    let _5 = (Parsing.peek_val __caml_parser_env 2 : 'states1) in
    Obj.repr(
# 37 "lispParserLLTP.mly"
                                                          ( _5 )
# 201 "lispParserLLTP.ml"
               : 'states))
; (fun __caml_parser_env ->
    Obj.repr(
# 40 "lispParserLLTP.mly"
                           ([])
# 207 "lispParserLLTP.ml"
               : 'states1))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'words) in
    Obj.repr(
# 41 "lispParserLLTP.mly"
                                                          ( [_2] )
# 214 "lispParserLLTP.ml"
               : 'states1))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'words) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'states1) in
    Obj.repr(
# 42 "lispParserLLTP.mly"
                                                         ( _2::_4 )
# 222 "lispParserLLTP.ml"
               : 'states1))
; (fun __caml_parser_env ->
    let _5 = (Parsing.peek_val __caml_parser_env 2 : 'goals1) in
    Obj.repr(
# 48 "lispParserLLTP.mly"
                                                           ( _5 )
# 229 "lispParserLLTP.ml"
               : 'goals))
; (fun __caml_parser_env ->
    let _5 = (Parsing.peek_val __caml_parser_env 2 : 'goals1) in
    Obj.repr(
# 49 "lispParserLLTP.mly"
                                                     ( _5 )
# 236 "lispParserLLTP.ml"
               : 'goals))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'goals1) in
    Obj.repr(
# 50 "lispParserLLTP.mly"
                                                           ( _3 )
# 243 "lispParserLLTP.ml"
               : 'goals))
; (fun __caml_parser_env ->
    let _4 = (Parsing.peek_val __caml_parser_env 6 : 'irrelevant) in
    let _8 = (Parsing.peek_val __caml_parser_env 2 : 'goals1) in
    Obj.repr(
# 52 "lispParserLLTP.mly"
                                            ( _8 )
# 251 "lispParserLLTP.ml"
               : 'goals))
; (fun __caml_parser_env ->
    let _4 = (Parsing.peek_val __caml_parser_env 6 : 'irrelevant) in
    let _8 = (Parsing.peek_val __caml_parser_env 2 : 'goals1) in
    Obj.repr(
# 54 "lispParserLLTP.mly"
                                            ( _8 )
# 259 "lispParserLLTP.ml"
               : 'goals))
; (fun __caml_parser_env ->
    let _4 = (Parsing.peek_val __caml_parser_env 3 : 'irrelevant) in
    let _6 = (Parsing.peek_val __caml_parser_env 1 : 'goals1) in
    Obj.repr(
# 56 "lispParserLLTP.mly"
                               ( _6 )
# 267 "lispParserLLTP.ml"
               : 'goals))
; (fun __caml_parser_env ->
    let _5 = (Parsing.peek_val __caml_parser_env 1 : 'goals1) in
    Obj.repr(
# 58 "lispParserLLTP.mly"
                               ( _5 )
# 274 "lispParserLLTP.ml"
               : 'goals))
; (fun __caml_parser_env ->
    let _7 = (Parsing.peek_val __caml_parser_env 2 : 'goals1) in
    Obj.repr(
# 60 "lispParserLLTP.mly"
                                            ( _7 )
# 281 "lispParserLLTP.ml"
               : 'goals))
; (fun __caml_parser_env ->
    let _7 = (Parsing.peek_val __caml_parser_env 2 : 'goals1) in
    Obj.repr(
# 62 "lispParserLLTP.mly"
                                           ( _7 )
# 288 "lispParserLLTP.ml"
               : 'goals))
; (fun __caml_parser_env ->
    Obj.repr(
# 66 "lispParserLLTP.mly"
                           ([])
# 294 "lispParserLLTP.ml"
               : 'goals1))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'words) in
    Obj.repr(
# 67 "lispParserLLTP.mly"
                                                          ( [_2] )
# 301 "lispParserLLTP.ml"
               : 'goals1))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'words) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'goals1) in
    Obj.repr(
# 68 "lispParserLLTP.mly"
                                                          ( _2::_4 )
# 309 "lispParserLLTP.ml"
               : 'goals1))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 73 "lispParserLLTP.mly"
                                                            ( [_1] )
# 316 "lispParserLLTP.ml"
               : 'words))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'words) in
    Obj.repr(
# 74 "lispParserLLTP.mly"
                                                            ( _1 :: _2 )
# 324 "lispParserLLTP.ml"
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
