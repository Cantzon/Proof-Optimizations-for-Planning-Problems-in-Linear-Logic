type token =
  | EOF
  | SETF
  | CURR
  | CREATE_PROB
  | OPERATOR
  | NODE
  | GOAL
  | BINDINGS
  | SELECT
  | REJECT
  | PREFER
  | SUBGOAL
  | PARAMS
  | PRECONDS
  | EFF
  | AND
  | DELETE
  | ADD
  | CONTROL_RULE
  | IF
  | THEN
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

# 42 "DomainParser.ml"
let yytransl_const = [|
    0 (* EOF *);
  257 (* SETF *);
  258 (* CURR *);
  259 (* CREATE_PROB *);
  260 (* OPERATOR *);
  261 (* NODE *);
  262 (* GOAL *);
  263 (* BINDINGS *);
  264 (* SELECT *);
  265 (* REJECT *);
  266 (* PREFER *);
  267 (* SUBGOAL *);
  268 (* PARAMS *);
  269 (* PRECONDS *);
  270 (* EFF *);
  271 (* AND *);
  272 (* DELETE *);
  273 (* ADD *);
  274 (* CONTROL_RULE *);
  275 (* IF *);
  276 (* THEN *);
  277 (* LPAREN *);
  278 (* RPAREN *);
  279 (* DOT *);
    0|]

let yytransl_block = [|
  280 (* WORD *);
  281 (* ID *);
  282 (* VAR *);
    0|]

let yylhs = "\255\255\
\001\000\001\000\001\000\001\000\002\000\002\000\004\000\004\000\
\005\000\006\000\009\000\009\000\009\000\009\000\003\000\011\000\
\013\000\013\000\012\000\014\000\014\000\014\000\014\000\015\000\
\015\000\015\000\015\000\010\000\010\000\017\000\017\000\017\000\
\017\000\008\000\008\000\007\000\007\000\018\000\018\000\016\000\
\016\000\000\000"

let yylen = "\002\000\
\001\000\001\000\001\000\002\000\007\000\008\000\004\000\003\000\
\009\000\008\000\006\000\006\000\007\000\007\000\006\000\004\000\
\001\000\004\000\004\000\002\000\002\000\002\000\001\000\002\000\
\002\000\002\000\002\000\001\000\002\000\001\000\001\000\002\000\
\002\000\003\000\004\000\001\000\002\000\003\000\003\000\001\000\
\002\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\001\000\000\000\042\000\002\000\000\000\000\000\
\000\000\004\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\008\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\017\000\000\000\
\000\000\015\000\037\000\007\000\000\000\000\000\000\000\000\000\
\000\000\000\000\029\000\016\000\000\000\000\000\000\000\023\000\
\000\000\000\000\000\000\000\000\006\000\000\000\000\000\032\000\
\033\000\000\000\000\000\000\000\000\000\020\000\021\000\022\000\
\019\000\000\000\000\000\000\000\018\000\026\000\024\000\025\000\
\000\000\000\000\027\000\000\000\000\000\000\000\000\000\000\000\
\000\000\041\000\000\000\000\000\000\000\035\000\038\000\039\000\
\000\000\000\000\000\000\000\000\009\000\000\000\000\000\010\000\
\000\000\000\000\000\000\000\000\000\000\000\000\013\000\014\000"

let yydgoto = "\002\000\
\005\000\006\000\007\000\014\000\019\000\028\000\025\000\055\000\
\085\000\031\000\016\000\022\000\032\000\049\000\062\000\075\000\
\043\000\076\000"

let yysindex = "\005\000\
\001\000\000\000\000\000\000\255\000\000\000\000\001\000\248\254\
\250\254\000\000\244\254\017\255\009\255\018\255\023\255\022\255\
\241\254\031\255\024\255\243\254\026\255\025\255\000\000\027\255\
\028\255\030\255\034\255\032\255\037\255\002\255\000\000\033\255\
\005\255\000\000\000\000\000\000\035\255\038\255\039\255\040\255\
\002\255\002\255\000\000\000\000\019\255\019\255\019\255\000\000\
\036\255\041\255\042\255\045\255\000\000\043\255\044\255\000\000\
\000\000\046\255\027\255\040\255\240\254\000\000\000\000\000\000\
\000\000\048\255\049\255\047\255\000\000\000\000\000\000\000\000\
\240\254\050\255\000\000\240\254\040\255\051\255\040\255\052\255\
\053\255\000\000\054\255\013\255\055\255\000\000\000\000\000\000\
\056\255\059\255\060\255\061\255\000\000\043\255\043\255\000\000\
\062\255\063\255\064\255\065\255\051\255\051\255\000\000\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\056\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\028\255\
\000\000\000\000\000\000\000\000\000\000\066\255\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\065\000\000\000\
\067\255\068\255\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\069\255\000\000\000\000\025\255\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\070\255\071\255\000\000\000\000"

let yygindex = "\000\000\
\060\000\036\000\000\000\000\000\000\000\000\000\234\255\199\255\
\186\255\202\255\000\000\000\000\000\000\000\000\243\255\006\000\
\250\255\021\000"

let yytablesize = 278
let yytable = "\068\000\
\003\000\035\000\072\000\008\000\073\000\001\000\023\000\029\000\
\013\000\074\000\024\000\030\000\045\000\046\000\047\000\048\000\
\011\000\009\000\012\000\083\000\017\000\086\000\058\000\059\000\
\060\000\061\000\041\000\042\000\090\000\091\000\103\000\104\000\
\063\000\064\000\056\000\057\000\071\000\015\000\018\000\097\000\
\098\000\020\000\021\000\026\000\027\000\033\000\034\000\038\000\
\008\000\036\000\037\000\040\000\024\000\039\000\044\000\003\000\
\050\000\065\000\051\000\052\000\054\000\066\000\077\000\067\000\
\005\000\069\000\010\000\030\000\079\000\078\000\070\000\084\000\
\081\000\087\000\053\000\089\000\092\000\093\000\088\000\094\000\
\095\000\082\000\096\000\099\000\100\000\101\000\102\000\028\000\
\030\000\031\000\040\000\011\000\012\000\080\000\000\000\000\000\
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
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\004\000"

let yycheck = "\054\000\
\000\000\024\000\060\000\004\001\021\001\001\000\022\001\021\001\
\021\001\026\001\026\001\025\001\008\001\009\001\010\001\011\001\
\025\001\018\001\025\001\077\000\012\001\079\000\004\001\005\001\
\006\001\007\001\025\001\026\001\016\001\017\001\101\000\102\000\
\046\000\047\000\041\000\042\000\059\000\021\001\021\001\094\000\
\095\000\019\001\021\001\013\001\021\001\020\001\022\001\014\001\
\004\001\022\001\021\001\015\001\026\001\022\001\022\001\000\000\
\022\001\022\001\021\001\021\001\021\001\021\001\015\001\022\001\
\000\000\022\001\007\000\025\001\022\001\021\001\025\001\021\001\
\023\001\022\001\039\000\022\001\022\001\022\001\026\001\021\001\
\021\001\076\000\022\001\022\001\022\001\022\001\022\001\022\001\
\022\001\022\001\022\001\022\001\022\001\073\000\255\255\255\255\
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
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\021\001"

let yynames_const = "\
  EOF\000\
  SETF\000\
  CURR\000\
  CREATE_PROB\000\
  OPERATOR\000\
  NODE\000\
  GOAL\000\
  BINDINGS\000\
  SELECT\000\
  REJECT\000\
  PREFER\000\
  SUBGOAL\000\
  PARAMS\000\
  PRECONDS\000\
  EFF\000\
  AND\000\
  DELETE\000\
  ADD\000\
  CONTROL_RULE\000\
  IF\000\
  THEN\000\
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
# 261 "DomainParser.ml"
               : (string * (string * string list) list * (string * string list) list) list ))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'ops) in
    Obj.repr(
# 34 "DomainParser.mly"
            ( _1 )
# 268 "DomainParser.ml"
               : (string * (string * string list) list * (string * string list) list) list ))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'controlRule) in
    Obj.repr(
# 35 "DomainParser.mly"
                     ( [] )
# 275 "DomainParser.ml"
               : (string * (string * string list) list * (string * string list) list) list ))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'controlRule) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : (string * (string * string list) list * (string * string list) list) list ) in
    Obj.repr(
# 36 "DomainParser.mly"
                     ( [] )
# 283 "DomainParser.ml"
               : (string * (string * string list) list * (string * string list) list) list ))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 4 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 3 : 'parameters) in
    let _5 = (Parsing.peek_val __caml_parser_env 2 : 'preconditions) in
    let _6 = (Parsing.peek_val __caml_parser_env 1 : 'effects) in
    Obj.repr(
# 45 "DomainParser.mly"
                                      ( [(_3, _5, _6)] )
# 293 "DomainParser.ml"
               : 'ops))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 5 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 4 : 'parameters) in
    let _5 = (Parsing.peek_val __caml_parser_env 3 : 'preconditions) in
    let _6 = (Parsing.peek_val __caml_parser_env 2 : 'effects) in
    let _8 = (Parsing.peek_val __caml_parser_env 0 : 'ops) in
    Obj.repr(
# 47 "DomainParser.mly"
                                      ( (_3, _5, _6)::_8 )
# 304 "DomainParser.ml"
               : 'ops))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'varList) in
    Obj.repr(
# 50 "DomainParser.mly"
                                 ()
# 311 "DomainParser.ml"
               : 'parameters))
; (fun __caml_parser_env ->
    Obj.repr(
# 51 "DomainParser.mly"
                                 ()
# 317 "DomainParser.ml"
               : 'parameters))
; (fun __caml_parser_env ->
    let _7 = (Parsing.peek_val __caml_parser_env 2 : 'propList) in
    Obj.repr(
# 57 "DomainParser.mly"
                                     ( _7 )
# 324 "DomainParser.ml"
               : 'preconditions))
; (fun __caml_parser_env ->
    let _6 = (Parsing.peek_val __caml_parser_env 2 : 'del_add) in
    Obj.repr(
# 61 "DomainParser.mly"
                                                         ( _6 )
# 331 "DomainParser.ml"
               : 'effects))
; (fun __caml_parser_env ->
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'prop) in
    Obj.repr(
# 66 "DomainParser.mly"
                                                    ( [] )
# 338 "DomainParser.ml"
               : 'del_add))
; (fun __caml_parser_env ->
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'prop) in
    Obj.repr(
# 67 "DomainParser.mly"
                                                    ( [_4] )
# 345 "DomainParser.ml"
               : 'del_add))
; (fun __caml_parser_env ->
    let _4 = (Parsing.peek_val __caml_parser_env 3 : 'prop) in
    let _7 = (Parsing.peek_val __caml_parser_env 0 : 'del_add) in
    Obj.repr(
# 68 "DomainParser.mly"
                                                    ( _7 )
# 353 "DomainParser.ml"
               : 'del_add))
; (fun __caml_parser_env ->
    let _4 = (Parsing.peek_val __caml_parser_env 3 : 'prop) in
    let _7 = (Parsing.peek_val __caml_parser_env 0 : 'del_add) in
    Obj.repr(
# 69 "DomainParser.mly"
                                                    ( _4::_7 )
# 361 "DomainParser.ml"
               : 'del_add))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'ifBranch) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : 'thenBranch) in
    Obj.repr(
# 77 "DomainParser.mly"
                                                      ( )
# 370 "DomainParser.ml"
               : 'controlRule))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'restrictedPDLexp) in
    Obj.repr(
# 80 "DomainParser.mly"
                                      ()
# 377 "DomainParser.ml"
               : 'ifBranch))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'prop) in
    Obj.repr(
# 83 "DomainParser.mly"
         ()
# 384 "DomainParser.ml"
               : 'restrictedPDLexp))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'propList) in
    Obj.repr(
# 84 "DomainParser.mly"
                               ()
# 391 "DomainParser.ml"
               : 'restrictedPDLexp))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'rhsSpec) in
    Obj.repr(
# 87 "DomainParser.mly"
                               ()
# 398 "DomainParser.ml"
               : 'thenBranch))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'candidate) in
    Obj.repr(
# 90 "DomainParser.mly"
                     ()
# 405 "DomainParser.ml"
               : 'rhsSpec))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'candidate) in
    Obj.repr(
# 91 "DomainParser.mly"
                     ()
# 412 "DomainParser.ml"
               : 'rhsSpec))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'candidate) in
    Obj.repr(
# 92 "DomainParser.mly"
                     ()
# 419 "DomainParser.ml"
               : 'rhsSpec))
; (fun __caml_parser_env ->
    Obj.repr(
# 93 "DomainParser.mly"
                     ()
# 425 "DomainParser.ml"
               : 'rhsSpec))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'varList) in
    Obj.repr(
# 96 "DomainParser.mly"
                       ()
# 432 "DomainParser.ml"
               : 'candidate))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'propList) in
    Obj.repr(
# 97 "DomainParser.mly"
                       ()
# 439 "DomainParser.ml"
               : 'candidate))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 98 "DomainParser.mly"
                       ()
# 446 "DomainParser.ml"
               : 'candidate))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'bindsList) in
    Obj.repr(
# 99 "DomainParser.mly"
                       ()
# 453 "DomainParser.ml"
               : 'candidate))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 107 "DomainParser.mly"
                       ( (_1, []) )
# 460 "DomainParser.ml"
               : 'prop))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'args) in
    Obj.repr(
# 108 "DomainParser.mly"
                       ( (_1, _2) )
# 468 "DomainParser.ml"
               : 'prop))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 111 "DomainParser.mly"
              ( [_1] )
# 475 "DomainParser.ml"
               : 'args))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 112 "DomainParser.mly"
              ( [_1] )
# 482 "DomainParser.ml"
               : 'args))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'args) in
    Obj.repr(
# 113 "DomainParser.mly"
              ( _1::_2 )
# 490 "DomainParser.ml"
               : 'args))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'args) in
    Obj.repr(
# 114 "DomainParser.mly"
              ( _1::_2 )
# 498 "DomainParser.ml"
               : 'args))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'prop) in
    Obj.repr(
# 117 "DomainParser.mly"
                                ( [_2] )
# 505 "DomainParser.ml"
               : 'propList))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'prop) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'propList) in
    Obj.repr(
# 118 "DomainParser.mly"
                                ( _2::_4 )
# 513 "DomainParser.ml"
               : 'propList))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 121 "DomainParser.mly"
                ( [_1] )
# 520 "DomainParser.ml"
               : 'varList))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'varList) in
    Obj.repr(
# 122 "DomainParser.mly"
                ( _1::_2 )
# 528 "DomainParser.ml"
               : 'varList))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'binding) in
    Obj.repr(
# 125 "DomainParser.mly"
                          ( _2 )
# 535 "DomainParser.ml"
               : 'binding))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 126 "DomainParser.mly"
                          ( (_1, _3) )
# 543 "DomainParser.ml"
               : 'binding))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'binding) in
    Obj.repr(
# 129 "DomainParser.mly"
                      ( [_1] )
# 550 "DomainParser.ml"
               : 'bindsList))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'binding) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'bindsList) in
    Obj.repr(
# 130 "DomainParser.mly"
                      ( _1::_2 )
# 558 "DomainParser.ml"
               : 'bindsList))
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
