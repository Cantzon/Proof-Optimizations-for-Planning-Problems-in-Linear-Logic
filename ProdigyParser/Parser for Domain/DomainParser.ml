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

open Parsing;;
let _ = parse_error;;
# 2 "DomainParser.mly"
 

(* Called by ocamlyacc in case of error *)
let parse_error s =
  print_string "ERROR: ";
  print_endline s;
  flush stdout

# 29 "DomainParser.ml"
let yytransl_const = [|
    0 (* EOF *);
  257 (* OPERATOR *);
  258 (* PARAMS *);
  259 (* PRECONDS *);
  260 (* EFF *);
  261 (* AND *);
  262 (* DELETE *);
  263 (* ADD *);
  264 (* LPAREN *);
  265 (* RPAREN *);
  266 (* DOT *);
    0|]

let yytransl_block = [|
  267 (* WORD *);
  268 (* ID *);
  269 (* VAR *);
    0|]

let yylhs = "\255\255\
\001\000\001\000\001\000\001\000\001\000\002\000\004\000\004\000\
\005\000\005\000\005\000\005\000\006\000\010\000\010\000\010\000\
\010\000\011\000\011\000\012\000\012\000\012\000\012\000\008\000\
\008\000\007\000\007\000\013\000\013\000\014\000\014\000\009\000\
\009\000\003\000\015\000\015\000\015\000\015\000\015\000\015\000\
\015\000\015\000\016\000\016\000\016\000\016\000\016\000\016\000\
\016\000\016\000\016\000\016\000\016\000\016\000\000\000"

let yylen = "\002\000\
\001\000\001\000\001\000\002\000\002\000\007\000\004\000\003\000\
\009\000\006\000\007\000\010\000\008\000\006\000\006\000\007\000\
\007\000\001\000\002\000\001\000\001\000\002\000\002\000\003\000\
\004\000\001\000\002\000\003\000\003\000\001\000\002\000\004\000\
\005\000\003\000\001\000\002\000\003\000\003\000\002\000\003\000\
\004\000\004\000\001\000\001\000\001\000\001\000\001\000\001\000\
\002\000\002\000\002\000\002\000\002\000\002\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\001\000\000\000\055\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\004\000\005\000\000\000\000\000\053\000\052\000\000\000\000\000\
\000\000\054\000\049\000\050\000\051\000\034\000\039\000\000\000\
\000\000\040\000\000\000\000\000\000\000\000\000\000\000\042\000\
\041\000\008\000\000\000\000\000\000\000\000\000\000\000\027\000\
\007\000\000\000\000\000\006\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\010\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\019\000\000\000\000\000\011\000\000\000\000\000\
\033\000\000\000\022\000\023\000\025\000\000\000\000\000\000\000\
\000\000\009\000\000\000\000\000\000\000\013\000\012\000\000\000\
\000\000\000\000\000\000\000\000\000\000\016\000\017\000"

let yydgoto = "\002\000\
\005\000\006\000\007\000\033\000\039\000\047\000\044\000\059\000\
\055\000\080\000\065\000\075\000\000\000\000\000\031\000\016\000"

let yysindex = "\004\000\
\001\000\000\000\000\000\051\255\000\000\001\000\001\000\090\255\
\103\255\025\255\103\255\103\255\103\255\103\255\255\254\064\255\
\000\000\000\000\103\255\077\255\000\000\000\000\064\255\009\255\
\038\255\000\000\000\000\000\000\000\000\000\000\000\000\023\255\
\019\255\000\000\064\255\064\255\015\255\026\255\034\255\000\000\
\000\000\000\000\042\255\059\255\052\255\069\255\072\255\000\000\
\000\000\032\255\078\255\000\000\081\255\099\255\102\255\108\255\
\100\255\253\254\109\255\111\255\112\255\113\255\115\255\041\255\
\116\255\000\000\254\254\117\255\119\255\120\255\118\255\122\255\
\041\255\041\255\000\000\115\255\115\255\000\000\060\255\123\255\
\000\000\124\255\000\000\000\000\000\000\125\255\121\255\127\255\
\128\255\000\000\129\255\118\255\118\255\000\000\000\000\130\255\
\131\255\132\255\133\255\119\255\119\255\000\000\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\121\000\124\000\036\255\
\049\255\000\000\062\255\071\255\075\255\084\255\000\000\009\255\
\000\000\000\000\036\255\134\255\000\000\000\000\135\255\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\136\255\137\255\000\000\000\000\000\000\000\000\
\000\000\000\000\138\255\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\139\255\
\000\000\000\000\000\000\000\000\000\000\140\255\000\000\000\000\
\141\255\142\255\000\000\143\255\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\144\255\145\255\000\000\000\000"

let yygindex = "\000\000\
\090\000\000\000\000\000\000\000\000\000\000\000\093\000\200\255\
\085\000\254\255\013\000\036\000\000\000\000\000\252\255\003\000"

let yytablesize = 265
let yytable = "\015\000\
\003\000\063\000\077\000\068\000\001\000\024\000\072\000\030\000\
\064\000\064\000\021\000\022\000\025\000\026\000\027\000\028\000\
\029\000\035\000\034\000\085\000\086\000\021\000\028\000\042\000\
\037\000\019\000\038\000\043\000\045\000\009\000\040\000\041\000\
\010\000\023\000\011\000\012\000\013\000\014\000\019\000\053\000\
\054\000\046\000\009\000\047\000\047\000\010\000\036\000\011\000\
\012\000\013\000\014\000\008\000\073\000\074\000\043\000\009\000\
\046\000\046\000\010\000\050\000\011\000\012\000\013\000\014\000\
\019\000\087\000\088\000\049\000\009\000\048\000\048\000\010\000\
\051\000\011\000\012\000\013\000\014\000\019\000\043\000\043\000\
\052\000\009\000\044\000\044\000\032\000\056\000\011\000\012\000\
\013\000\014\000\019\000\045\000\045\000\057\000\009\000\017\000\
\018\000\102\000\103\000\011\000\012\000\020\000\014\000\019\000\
\096\000\097\000\058\000\009\000\083\000\084\000\060\000\062\000\
\011\000\012\000\013\000\014\000\061\000\066\000\067\000\069\000\
\002\000\070\000\071\000\003\000\076\000\078\000\079\000\053\000\
\092\000\064\000\082\000\089\000\090\000\091\000\093\000\048\000\
\094\000\095\000\098\000\099\000\100\000\101\000\044\000\036\000\
\038\000\037\000\026\000\018\000\032\000\020\000\021\000\024\000\
\014\000\015\000\081\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\004\000"

let yycheck = "\004\000\
\000\000\005\001\005\001\060\000\001\000\010\000\063\000\009\001\
\012\001\012\001\008\000\009\000\010\000\011\000\012\000\013\000\
\014\000\009\001\023\000\076\000\077\000\019\000\020\000\009\001\
\002\001\001\001\008\001\013\001\003\001\005\001\035\000\036\000\
\008\001\009\001\010\001\011\001\012\001\013\001\001\001\008\001\
\009\001\008\001\005\001\008\001\009\001\008\001\009\001\010\001\
\011\001\012\001\013\001\001\001\012\001\013\001\013\001\005\001\
\008\001\009\001\008\001\008\001\010\001\011\001\012\001\013\001\
\001\001\006\001\007\001\009\001\005\001\008\001\009\001\008\001\
\004\001\010\001\011\001\012\001\013\001\001\001\008\001\009\001\
\009\001\005\001\008\001\009\001\008\001\008\001\010\001\011\001\
\012\001\013\001\001\001\008\001\009\001\013\001\005\001\006\000\
\007\000\100\000\101\000\010\001\011\001\012\001\013\001\001\001\
\092\000\093\000\008\001\005\001\073\000\074\000\009\001\012\001\
\010\001\011\001\012\001\013\001\009\001\009\001\008\001\008\001\
\000\000\009\001\008\001\000\000\009\001\009\001\008\001\008\001\
\008\001\012\001\009\001\009\001\009\001\009\001\008\001\043\000\
\009\001\009\001\009\001\009\001\009\001\009\001\009\001\009\001\
\009\001\009\001\009\001\009\001\009\001\009\001\009\001\009\001\
\009\001\009\001\070\000\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\008\001"

let yynames_const = "\
  EOF\000\
  OPERATOR\000\
  PARAMS\000\
  PRECONDS\000\
  EFF\000\
  AND\000\
  DELETE\000\
  ADD\000\
  LPAREN\000\
  RPAREN\000\
  DOT\000\
  "

let yynames_block = "\
  WORD\000\
  ID\000\
  VAR\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    Obj.repr(
# 33 "DomainParser.mly"
                     ( [] )
# 220 "DomainParser.ml"
               : (string * (string * string list) list * (string * string list) list) list ))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'ops) in
    Obj.repr(
# 34 "DomainParser.mly"
            ( [_1] )
# 227 "DomainParser.ml"
               : (string * (string * string list) list * (string * string list) list) list ))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'irrelevant) in
    Obj.repr(
# 35 "DomainParser.mly"
                  ( [] )
# 234 "DomainParser.ml"
               : (string * (string * string list) list * (string * string list) list) list ))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'ops) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : (string * (string * string list) list * (string * string list) list) list ) in
    Obj.repr(
# 36 "DomainParser.mly"
               ( _1::_2 )
# 242 "DomainParser.ml"
               : (string * (string * string list) list * (string * string list) list) list ))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'irrelevant) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : (string * (string * string list) list * (string * string list) list) list ) in
    Obj.repr(
# 37 "DomainParser.mly"
                     ( _2 )
# 250 "DomainParser.ml"
               : (string * (string * string list) list * (string * string list) list) list ))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 4 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 3 : 'parameters) in
    let _5 = (Parsing.peek_val __caml_parser_env 2 : 'preconditions) in
    let _6 = (Parsing.peek_val __caml_parser_env 1 : 'effects) in
    Obj.repr(
# 46 "DomainParser.mly"
                                      ( (_3, _5, _6) )
# 260 "DomainParser.ml"
               : 'ops))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'varList) in
    Obj.repr(
# 51 "DomainParser.mly"
                                 ()
# 267 "DomainParser.ml"
               : 'parameters))
; (fun __caml_parser_env ->
    Obj.repr(
# 52 "DomainParser.mly"
                                 ()
# 273 "DomainParser.ml"
               : 'parameters))
; (fun __caml_parser_env ->
    let _7 = (Parsing.peek_val __caml_parser_env 2 : 'propList) in
    Obj.repr(
# 58 "DomainParser.mly"
                                     ( _7 )
# 280 "DomainParser.ml"
               : 'preconditions))
; (fun __caml_parser_env ->
    let _5 = (Parsing.peek_val __caml_parser_env 1 : 'propList) in
    Obj.repr(
# 60 "DomainParser.mly"
                         ( _5 )
# 287 "DomainParser.ml"
               : 'preconditions))
; (fun __caml_parser_env ->
    let _4 = (Parsing.peek_val __caml_parser_env 3 : 'objList) in
    let _6 = (Parsing.peek_val __caml_parser_env 1 : 'propList) in
    Obj.repr(
# 62 "DomainParser.mly"
                        ( _6 )
# 295 "DomainParser.ml"
               : 'preconditions))
; (fun __caml_parser_env ->
    let _4 = (Parsing.peek_val __caml_parser_env 6 : 'objList) in
    let _8 = (Parsing.peek_val __caml_parser_env 2 : 'propList) in
    Obj.repr(
# 64 "DomainParser.mly"
                                     ( _8 )
# 303 "DomainParser.ml"
               : 'preconditions))
; (fun __caml_parser_env ->
    let _6 = (Parsing.peek_val __caml_parser_env 2 : 'del_add) in
    Obj.repr(
# 68 "DomainParser.mly"
                                                         ( _6 )
# 310 "DomainParser.ml"
               : 'effects))
; (fun __caml_parser_env ->
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'prop) in
    Obj.repr(
# 73 "DomainParser.mly"
                                                    ( [] )
# 317 "DomainParser.ml"
               : 'del_add))
; (fun __caml_parser_env ->
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'prop) in
    Obj.repr(
# 74 "DomainParser.mly"
                                                    ( [_4] )
# 324 "DomainParser.ml"
               : 'del_add))
; (fun __caml_parser_env ->
    let _4 = (Parsing.peek_val __caml_parser_env 3 : 'prop) in
    let _7 = (Parsing.peek_val __caml_parser_env 0 : 'del_add) in
    Obj.repr(
# 75 "DomainParser.mly"
                                                    ( _7 )
# 332 "DomainParser.ml"
               : 'del_add))
; (fun __caml_parser_env ->
    let _4 = (Parsing.peek_val __caml_parser_env 3 : 'prop) in
    let _7 = (Parsing.peek_val __caml_parser_env 0 : 'del_add) in
    Obj.repr(
# 76 "DomainParser.mly"
                                                    ( _4::_7 )
# 340 "DomainParser.ml"
               : 'del_add))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 116 "DomainParser.mly"
                       ( (_1, []) )
# 347 "DomainParser.ml"
               : 'prop))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'args) in
    Obj.repr(
# 117 "DomainParser.mly"
                       ( (_1, _2) )
# 355 "DomainParser.ml"
               : 'prop))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 120 "DomainParser.mly"
              ( [_1] )
# 362 "DomainParser.ml"
               : 'args))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 121 "DomainParser.mly"
              ( [_1] )
# 369 "DomainParser.ml"
               : 'args))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'args) in
    Obj.repr(
# 122 "DomainParser.mly"
              ( _1::_2 )
# 377 "DomainParser.ml"
               : 'args))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'args) in
    Obj.repr(
# 123 "DomainParser.mly"
              ( _1::_2 )
# 385 "DomainParser.ml"
               : 'args))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'prop) in
    Obj.repr(
# 126 "DomainParser.mly"
                                ( [_2] )
# 392 "DomainParser.ml"
               : 'propList))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'prop) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'propList) in
    Obj.repr(
# 127 "DomainParser.mly"
                                ( _2::_4 )
# 400 "DomainParser.ml"
               : 'propList))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 130 "DomainParser.mly"
                ( [_1] )
# 407 "DomainParser.ml"
               : 'varList))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'varList) in
    Obj.repr(
# 131 "DomainParser.mly"
                ( _1::_2 )
# 415 "DomainParser.ml"
               : 'varList))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'binding) in
    Obj.repr(
# 134 "DomainParser.mly"
                          ( _2 )
# 422 "DomainParser.ml"
               : 'binding))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 135 "DomainParser.mly"
                          ( (_1, _3) )
# 430 "DomainParser.ml"
               : 'binding))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'binding) in
    Obj.repr(
# 138 "DomainParser.mly"
                      ( [_1] )
# 437 "DomainParser.ml"
               : 'bindsList))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'binding) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'bindsList) in
    Obj.repr(
# 139 "DomainParser.mly"
                      ( _1::_2 )
# 445 "DomainParser.ml"
               : 'bindsList))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : string) in
    Obj.repr(
# 142 "DomainParser.mly"
                            ()
# 453 "DomainParser.ml"
               : 'objList))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : 'objList) in
    Obj.repr(
# 143 "DomainParser.mly"
                                  ()
# 462 "DomainParser.ml"
               : 'objList))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'irrelevantList) in
    Obj.repr(
# 169 "DomainParser.mly"
                                 ()
# 469 "DomainParser.ml"
               : 'irrelevant))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'words) in
    Obj.repr(
# 173 "DomainParser.mly"
                ()
# 476 "DomainParser.ml"
               : 'irrelevantList))
; (fun __caml_parser_env ->
    Obj.repr(
# 174 "DomainParser.mly"
                      ()
# 482 "DomainParser.ml"
               : 'irrelevantList))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'words) in
    Obj.repr(
# 175 "DomainParser.mly"
                           ()
# 489 "DomainParser.ml"
               : 'irrelevantList))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'irrelevantList) in
    Obj.repr(
# 176 "DomainParser.mly"
                                 ()
# 496 "DomainParser.ml"
               : 'irrelevantList))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'words) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'irrelevantList) in
    Obj.repr(
# 177 "DomainParser.mly"
                           ()
# 504 "DomainParser.ml"
               : 'irrelevantList))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'irrelevantList) in
    Obj.repr(
# 178 "DomainParser.mly"
                                 ()
# 511 "DomainParser.ml"
               : 'irrelevantList))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'words) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'irrelevantList) in
    Obj.repr(
# 179 "DomainParser.mly"
                                         ()
# 519 "DomainParser.ml"
               : 'irrelevantList))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'irrelevantList) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'irrelevantList) in
    Obj.repr(
# 180 "DomainParser.mly"
                                                ()
# 527 "DomainParser.ml"
               : 'irrelevantList))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 183 "DomainParser.mly"
             ()
# 534 "DomainParser.ml"
               : 'words))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 184 "DomainParser.mly"
                     ()
# 541 "DomainParser.ml"
               : 'words))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 185 "DomainParser.mly"
             ()
# 548 "DomainParser.ml"
               : 'words))
; (fun __caml_parser_env ->
    Obj.repr(
# 186 "DomainParser.mly"
            ()
# 554 "DomainParser.ml"
               : 'words))
; (fun __caml_parser_env ->
    Obj.repr(
# 187 "DomainParser.mly"
                ()
# 560 "DomainParser.ml"
               : 'words))
; (fun __caml_parser_env ->
    Obj.repr(
# 188 "DomainParser.mly"
            ()
# 566 "DomainParser.ml"
               : 'words))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'words) in
    Obj.repr(
# 189 "DomainParser.mly"
                 ()
# 574 "DomainParser.ml"
               : 'words))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'words) in
    Obj.repr(
# 190 "DomainParser.mly"
                     ()
# 582 "DomainParser.ml"
               : 'words))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'words) in
    Obj.repr(
# 191 "DomainParser.mly"
                   ()
# 590 "DomainParser.ml"
               : 'words))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'words) in
    Obj.repr(
# 192 "DomainParser.mly"
                 ()
# 597 "DomainParser.ml"
               : 'words))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'words) in
    Obj.repr(
# 193 "DomainParser.mly"
                     ()
# 604 "DomainParser.ml"
               : 'words))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'words) in
    Obj.repr(
# 194 "DomainParser.mly"
                ()
# 611 "DomainParser.ml"
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
   (Parsing.yyparse yytables 1 lexfun lexbuf : (string * (string * string list) list * (string * string list) list) list )
;;
