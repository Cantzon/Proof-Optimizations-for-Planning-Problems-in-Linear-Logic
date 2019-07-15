type token =
  | EOF
  | SETF
  | CURR_T
  | CREATE_PROB
  | OPERATOR
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
  | WORD of (string)

open Parsing;;
let _ = parse_error;;
# 2 "DomainParser.mly"
 

# 26 "DomainParser.ml"
let yytransl_const = [|
    0 (* EOF *);
  257 (* SETF *);
  258 (* CURR_T *);
  259 (* CREATE_PROB *);
  260 (* OPERATOR *);
  261 (* PARAMS *);
  262 (* PRECONDS *);
  263 (* EFF *);
  264 (* AND *);
  265 (* DELETE *);
  266 (* ADD *);
  267 (* CONTROL_RULE *);
  268 (* IF *);
  269 (* THEN *);
  270 (* LPAREN *);
  271 (* RPAREN *);
    0|]

let yytransl_block = [|
  272 (* WORD *);
    0|]

let yylhs = "\255\255\
\001\000\003\000\003\000\004\000\004\000\005\000\008\000\008\000\
\006\000\009\000\009\000\009\000\009\000\002\000\002\000\002\000\
\010\000\012\000\012\000\012\000\012\000\011\000\013\000\013\000\
\013\000\013\000\013\000\007\000\007\000\000\000"

let yylen = "\002\000\
\002\000\007\000\008\000\004\000\003\000\009\000\003\000\004\000\
\008\000\006\000\006\000\007\000\007\000\001\000\006\000\007\000\
\007\000\003\000\003\000\004\000\004\000\005\000\000\000\002\000\
\003\000\003\000\004\000\001\000\002\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\014\000\000\000\030\000\000\000\000\000\001\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\016\000\000\000\000\000\029\000\
\000\000\000\000\000\000\000\000\000\000\024\000\000\000\000\000\
\022\000\000\000\000\000\017\000\000\000\025\000\020\000\021\000\
\027\000"

let yydgoto = "\002\000\
\005\000\006\000\000\000\000\000\000\000\000\000\020\000\000\000\
\000\000\011\000\014\000\023\000\026\000"

let yysindex = "\003\000\
\001\000\000\000\000\000\253\254\000\000\018\000\003\255\000\000\
\006\255\009\255\008\255\010\255\012\255\011\255\015\255\013\255\
\001\000\014\255\013\255\016\255\000\000\247\254\017\255\000\000\
\001\255\018\255\019\255\020\255\021\255\000\000\022\255\023\255\
\000\000\014\255\014\255\000\000\016\255\000\000\000\000\000\000\
\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\252\254\024\255\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\025\255\026\255\000\000\024\255\000\000\000\000\000\000\
\000\000"

let yygindex = "\000\000\
\000\000\010\000\000\000\000\000\000\000\000\000\240\255\000\000\
\000\000\000\000\000\000\234\255\233\255"

let yytablesize = 271
let yytable = "\028\000\
\003\000\032\000\024\000\001\000\022\000\027\000\019\000\007\000\
\031\000\028\000\028\000\039\000\040\000\041\000\025\000\030\000\
\019\000\008\000\009\000\010\000\012\000\013\000\018\000\015\000\
\016\000\017\000\021\000\022\000\019\000\025\000\000\000\029\000\
\033\000\034\000\035\000\036\000\037\000\038\000\023\000\018\000\
\019\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
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
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\004\000"

let yycheck = "\022\000\
\000\000\025\000\019\000\001\000\014\001\022\000\016\001\011\001\
\025\000\014\001\015\001\034\000\035\000\037\000\014\001\015\001\
\016\001\000\000\016\001\014\001\012\001\014\001\008\001\014\001\
\013\001\015\001\017\000\014\001\016\001\014\001\255\255\015\001\
\015\001\015\001\015\001\015\001\015\001\015\001\015\001\015\001\
\015\001\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
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
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\014\001"

let yynames_const = "\
  EOF\000\
  SETF\000\
  CURR_T\000\
  CREATE_PROB\000\
  OPERATOR\000\
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
  "

let yynames_block = "\
  WORD\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'controlRule) in
    Obj.repr(
# 27 "DomainParser.mly"
                           ( print_string "yeet";_1)
# 197 "DomainParser.ml"
               : string list))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 4 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 3 : 'parameters) in
    let _5 = (Parsing.peek_val __caml_parser_env 2 : 'preconditions) in
    let _6 = (Parsing.peek_val __caml_parser_env 1 : 'effects) in
    Obj.repr(
# 40 "DomainParser.mly"
                                         ( [(_3, _5, _6)] )
# 207 "DomainParser.ml"
               : 'ops))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 5 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 4 : 'parameters) in
    let _5 = (Parsing.peek_val __caml_parser_env 3 : 'preconditions) in
    let _6 = (Parsing.peek_val __caml_parser_env 2 : 'effects) in
    let _8 = (Parsing.peek_val __caml_parser_env 0 : 'ops) in
    Obj.repr(
# 42 "DomainParser.mly"
                                            ( (_3, _5, _6)::_8 )
# 218 "DomainParser.ml"
               : 'ops))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'words) in
    Obj.repr(
# 53 "DomainParser.mly"
                                       ()
# 225 "DomainParser.ml"
               : 'parameters))
; (fun __caml_parser_env ->
    Obj.repr(
# 54 "DomainParser.mly"
                                   ()
# 231 "DomainParser.ml"
               : 'parameters))
; (fun __caml_parser_env ->
    let _7 = (Parsing.peek_val __caml_parser_env 2 : 'preconds1) in
    Obj.repr(
# 60 "DomainParser.mly"
                                            (_7 )
# 238 "DomainParser.ml"
               : 'preconditions))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'words) in
    Obj.repr(
# 63 "DomainParser.mly"
                               ( [_2] )
# 245 "DomainParser.ml"
               : 'preconds1))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'words) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'preconds1) in
    Obj.repr(
# 64 "DomainParser.mly"
                                       ( _2::_4 )
# 253 "DomainParser.ml"
               : 'preconds1))
; (fun __caml_parser_env ->
    let _6 = (Parsing.peek_val __caml_parser_env 2 : 'del_add) in
    Obj.repr(
# 69 "DomainParser.mly"
                                                         ( _6 )
# 260 "DomainParser.ml"
               : 'effects))
; (fun __caml_parser_env ->
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'words) in
    Obj.repr(
# 74 "DomainParser.mly"
                                                ( [] )
# 267 "DomainParser.ml"
               : 'del_add))
; (fun __caml_parser_env ->
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'words) in
    Obj.repr(
# 75 "DomainParser.mly"
                                              ( [_4] )
# 274 "DomainParser.ml"
               : 'del_add))
; (fun __caml_parser_env ->
    let _4 = (Parsing.peek_val __caml_parser_env 3 : 'words) in
    let _7 = (Parsing.peek_val __caml_parser_env 0 : 'del_add) in
    Obj.repr(
# 76 "DomainParser.mly"
                                                        ( _7 )
# 282 "DomainParser.ml"
               : 'del_add))
; (fun __caml_parser_env ->
    let _4 = (Parsing.peek_val __caml_parser_env 3 : 'words) in
    let _7 = (Parsing.peek_val __caml_parser_env 0 : 'del_add) in
    Obj.repr(
# 77 "DomainParser.mly"
                                                   ( _4::_7 )
# 290 "DomainParser.ml"
               : 'del_add))
; (fun __caml_parser_env ->
    Obj.repr(
# 88 "DomainParser.mly"
                    ([])
# 296 "DomainParser.ml"
               : 'controlRule))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'ifBranch) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : 'thenBranch) in
    Obj.repr(
# 89 "DomainParser.mly"
                                                       ( [_3])
# 305 "DomainParser.ml"
               : 'controlRule))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 4 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 3 : 'ifBranch) in
    let _5 = (Parsing.peek_val __caml_parser_env 2 : 'thenBranch) in
    let _7 = (Parsing.peek_val __caml_parser_env 0 : 'controlRule) in
    Obj.repr(
# 90 "DomainParser.mly"
                                                                   (_3::_7)
# 315 "DomainParser.ml"
               : 'controlRule))
; (fun __caml_parser_env ->
    let _5 = (Parsing.peek_val __caml_parser_env 2 : 'ifBranch1) in
    Obj.repr(
# 93 "DomainParser.mly"
                                                  ()
# 322 "DomainParser.ml"
               : 'ifBranch))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'words) in
    Obj.repr(
# 96 "DomainParser.mly"
                               ()
# 329 "DomainParser.ml"
               : 'ifBranch1))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'ifBranch1) in
    Obj.repr(
# 97 "DomainParser.mly"
                                  ()
# 336 "DomainParser.ml"
               : 'ifBranch1))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'words) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'ifBranch1) in
    Obj.repr(
# 98 "DomainParser.mly"
                                       ()
# 344 "DomainParser.ml"
               : 'ifBranch1))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'ifBranch1) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'ifBranch1) in
    Obj.repr(
# 99 "DomainParser.mly"
                                          ()
# 352 "DomainParser.ml"
               : 'ifBranch1))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'words) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'header) in
    Obj.repr(
# 103 "DomainParser.mly"
                                        ()
# 360 "DomainParser.ml"
               : 'thenBranch))
; (fun __caml_parser_env ->
    Obj.repr(
# 110 "DomainParser.mly"
   ()
# 366 "DomainParser.ml"
               : 'header))
; (fun __caml_parser_env ->
    Obj.repr(
# 111 "DomainParser.mly"
                           ()
# 372 "DomainParser.ml"
               : 'header))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'header) in
    Obj.repr(
# 112 "DomainParser.mly"
                                ()
# 379 "DomainParser.ml"
               : 'header))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'words) in
    Obj.repr(
# 113 "DomainParser.mly"
                               ()
# 386 "DomainParser.ml"
               : 'header))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'words) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'header) in
    Obj.repr(
# 114 "DomainParser.mly"
                                    ()
# 394 "DomainParser.ml"
               : 'header))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 117 "DomainParser.mly"
                                                            ( [_1] )
# 401 "DomainParser.ml"
               : 'words))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'words) in
    Obj.repr(
# 118 "DomainParser.mly"
                                                            ( _1 :: _2 )
# 409 "DomainParser.ml"
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
   (Parsing.yyparse yytables 1 lexfun lexbuf : string list)
;;
