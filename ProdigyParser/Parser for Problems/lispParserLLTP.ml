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
\001\000\001\000\002\000\003\000\006\000\006\000\006\000\006\000\
\004\000\008\000\008\000\008\000\005\000\005\000\005\000\005\000\
\005\000\005\000\005\000\005\000\005\000\009\000\009\000\009\000\
\007\000\007\000\000\000"

let yylen = "\002\000\
\013\000\012\000\004\000\004\000\000\000\002\000\003\000\004\000\
\007\000\002\000\003\000\004\000\007\000\007\000\004\000\010\000\
\010\000\007\000\006\000\009\000\009\000\002\000\003\000\004\000\
\001\000\002\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\027\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\003\000\
\000\000\000\000\000\000\000\000\000\000\000\000\006\000\000\000\
\000\000\004\000\000\000\000\000\000\000\000\000\002\000\026\000\
\000\000\000\000\000\000\001\000\000\000\000\000\000\000\000\000\
\000\000\015\000\008\000\010\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\009\000\022\000\
\000\000\000\000\000\000\000\000\019\000\000\000\000\000\024\000\
\012\000\013\000\014\000\000\000\000\000\000\000\000\000\018\000\
\000\000\000\000\000\000\000\000\020\000\021\000\000\000\000\000\
\016\000\017\000"

let yydgoto = "\002\000\
\004\000\012\000\015\000\016\000\023\000\026\000\049\000\043\000\
\038\000"

let yysindex = "\005\000\
\009\255\000\000\020\255\000\000\030\255\025\255\031\255\033\255\
\034\255\035\255\037\255\036\255\032\255\026\255\038\255\039\255\
\040\255\042\255\043\255\041\255\039\255\045\255\044\255\000\000\
\000\255\046\255\049\255\047\255\050\255\048\255\000\000\051\255\
\053\255\000\000\052\255\054\255\253\254\055\255\000\000\000\000\
\042\255\024\255\056\255\000\000\058\255\058\255\059\255\060\255\
\061\255\000\000\000\000\000\000\062\255\063\255\027\255\064\255\
\065\255\006\255\066\255\068\255\058\255\052\255\000\000\000\000\
\069\255\070\255\058\255\058\255\000\000\017\255\071\255\000\000\
\000\000\000\000\000\000\072\255\073\255\058\255\058\255\000\000\
\074\255\075\255\076\255\077\255\000\000\000\000\078\255\079\255\
\000\000\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\080\255\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\081\255\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\080\255\000\000\000\000\000\000\000\000\000\000\082\255\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\083\255\084\255\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000"

let yygindex = "\000\000\
\000\000\000\000\000\000\035\000\040\000\245\255\234\255\008\000\
\211\255"

let yytablesize = 95
let yytable = "\056\000\
\057\000\059\000\033\000\045\000\046\000\001\000\025\000\047\000\
\032\000\040\000\031\000\032\000\067\000\068\000\071\000\072\000\
\064\000\032\000\003\000\053\000\005\000\076\000\077\000\078\000\
\079\000\048\000\007\000\064\000\032\000\051\000\018\000\019\000\
\083\000\084\000\052\000\032\000\010\000\064\000\032\000\006\000\
\013\000\008\000\009\000\017\000\011\000\014\000\019\000\020\000\
\022\000\021\000\024\000\025\000\027\000\029\000\030\000\035\000\
\034\000\036\000\039\000\037\000\028\000\042\000\032\000\041\000\
\044\000\050\000\054\000\055\000\058\000\073\000\060\000\061\000\
\062\000\063\000\065\000\066\000\069\000\070\000\000\000\074\000\
\075\000\080\000\081\000\082\000\085\000\086\000\087\000\088\000\
\089\000\090\000\005\000\025\000\022\000\023\000\011\000"

let yycheck = "\045\000\
\046\000\047\000\025\000\007\001\008\001\001\000\010\001\011\001\
\012\001\032\000\011\001\012\001\007\001\008\001\060\000\061\000\
\011\001\012\001\010\001\042\000\001\001\067\000\068\000\007\001\
\008\001\037\000\002\001\011\001\012\001\041\000\005\001\006\001\
\078\000\079\000\011\001\012\001\003\001\011\001\012\001\010\001\
\004\001\011\001\010\001\012\001\010\001\010\001\006\001\010\001\
\010\001\015\000\011\001\010\001\010\001\009\001\011\001\007\001\
\011\001\011\001\011\001\010\001\021\000\010\001\012\001\011\001\
\011\001\011\001\011\001\010\001\010\001\062\000\011\001\011\001\
\011\001\011\001\011\001\011\001\011\001\010\001\255\255\011\001\
\011\001\011\001\011\001\011\001\011\001\011\001\011\001\011\001\
\011\001\011\001\011\001\011\001\011\001\011\001\011\001"

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
# 162 "lispParserLLTP.ml"
               : string * string list list * string list list))
; (fun __caml_parser_env ->
    let _8 = (Parsing.peek_val __caml_parser_env 4 : 'naming) in
    let _9 = (Parsing.peek_val __caml_parser_env 3 : 'states) in
    let _10 = (Parsing.peek_val __caml_parser_env 2 : 'goals) in
    Obj.repr(
# 19 "lispParserLLTP.mly"
                                                    ( (_8, _9, _10) )
# 171 "lispParserLLTP.ml"
               : string * string list list * string list list))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 1 : string) in
    Obj.repr(
# 23 "lispParserLLTP.mly"
                                                          ( _3 )
# 178 "lispParserLLTP.ml"
               : 'naming))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'irrelevant) in
    Obj.repr(
# 28 "lispParserLLTP.mly"
                                                           ()
# 185 "lispParserLLTP.ml"
               : 'obj))
; (fun __caml_parser_env ->
    Obj.repr(
# 33 "lispParserLLTP.mly"
   ()
# 191 "lispParserLLTP.ml"
               : 'irrelevant))
; (fun __caml_parser_env ->
    Obj.repr(
# 34 "lispParserLLTP.mly"
                             ()
# 197 "lispParserLLTP.ml"
               : 'irrelevant))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'words) in
    Obj.repr(
# 35 "lispParserLLTP.mly"
                                                           ()
# 204 "lispParserLLTP.ml"
               : 'irrelevant))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'words) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'irrelevant) in
    Obj.repr(
# 36 "lispParserLLTP.mly"
                                                           ()
# 212 "lispParserLLTP.ml"
               : 'irrelevant))
; (fun __caml_parser_env ->
    let _5 = (Parsing.peek_val __caml_parser_env 2 : 'states1) in
    Obj.repr(
# 42 "lispParserLLTP.mly"
                                                          ( _5 )
# 219 "lispParserLLTP.ml"
               : 'states))
; (fun __caml_parser_env ->
    Obj.repr(
# 45 "lispParserLLTP.mly"
                           ([])
# 225 "lispParserLLTP.ml"
               : 'states1))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'words) in
    Obj.repr(
# 46 "lispParserLLTP.mly"
                                                          ( [_2] )
# 232 "lispParserLLTP.ml"
               : 'states1))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'words) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'states1) in
    Obj.repr(
# 47 "lispParserLLTP.mly"
                                                         ( _2::_4 )
# 240 "lispParserLLTP.ml"
               : 'states1))
; (fun __caml_parser_env ->
    let _5 = (Parsing.peek_val __caml_parser_env 2 : 'goals1) in
    Obj.repr(
# 53 "lispParserLLTP.mly"
                                                           ( _5 )
# 247 "lispParserLLTP.ml"
               : 'goals))
; (fun __caml_parser_env ->
    let _5 = (Parsing.peek_val __caml_parser_env 2 : 'goals1) in
    Obj.repr(
# 54 "lispParserLLTP.mly"
                                                     ( _5 )
# 254 "lispParserLLTP.ml"
               : 'goals))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'goals1) in
    Obj.repr(
# 55 "lispParserLLTP.mly"
                                                           ( _3 )
# 261 "lispParserLLTP.ml"
               : 'goals))
; (fun __caml_parser_env ->
    let _4 = (Parsing.peek_val __caml_parser_env 6 : 'irrelevant) in
    let _8 = (Parsing.peek_val __caml_parser_env 2 : 'goals1) in
    Obj.repr(
# 57 "lispParserLLTP.mly"
                                            ( _8 )
# 269 "lispParserLLTP.ml"
               : 'goals))
; (fun __caml_parser_env ->
    let _4 = (Parsing.peek_val __caml_parser_env 6 : 'irrelevant) in
    let _8 = (Parsing.peek_val __caml_parser_env 2 : 'goals1) in
    Obj.repr(
# 59 "lispParserLLTP.mly"
                                            ( _8 )
# 277 "lispParserLLTP.ml"
               : 'goals))
; (fun __caml_parser_env ->
    let _4 = (Parsing.peek_val __caml_parser_env 3 : 'irrelevant) in
    let _6 = (Parsing.peek_val __caml_parser_env 1 : 'goals1) in
    Obj.repr(
# 61 "lispParserLLTP.mly"
                               ( _6 )
# 285 "lispParserLLTP.ml"
               : 'goals))
; (fun __caml_parser_env ->
    let _5 = (Parsing.peek_val __caml_parser_env 1 : 'goals1) in
    Obj.repr(
# 63 "lispParserLLTP.mly"
                               ( _5 )
# 292 "lispParserLLTP.ml"
               : 'goals))
; (fun __caml_parser_env ->
    let _7 = (Parsing.peek_val __caml_parser_env 2 : 'goals1) in
    Obj.repr(
# 65 "lispParserLLTP.mly"
                                            ( _7 )
# 299 "lispParserLLTP.ml"
               : 'goals))
; (fun __caml_parser_env ->
    let _7 = (Parsing.peek_val __caml_parser_env 2 : 'goals1) in
    Obj.repr(
# 67 "lispParserLLTP.mly"
                                           ( _7 )
# 306 "lispParserLLTP.ml"
               : 'goals))
; (fun __caml_parser_env ->
    Obj.repr(
# 71 "lispParserLLTP.mly"
                           ([])
# 312 "lispParserLLTP.ml"
               : 'goals1))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'words) in
    Obj.repr(
# 72 "lispParserLLTP.mly"
                                                          ( [_2] )
# 319 "lispParserLLTP.ml"
               : 'goals1))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'words) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'goals1) in
    Obj.repr(
# 73 "lispParserLLTP.mly"
                                                          ( _2::_4 )
# 327 "lispParserLLTP.ml"
               : 'goals1))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 78 "lispParserLLTP.mly"
                                                            ( [_1] )
# 334 "lispParserLLTP.ml"
               : 'words))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'words) in
    Obj.repr(
# 79 "lispParserLLTP.mly"
                                                            ( _1 :: _2 )
# 342 "lispParserLLTP.ml"
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
