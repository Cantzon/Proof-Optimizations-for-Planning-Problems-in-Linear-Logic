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
\006\000\009\000\009\000\009\000\009\000\002\000\002\000\010\000\
\012\000\012\000\012\000\012\000\011\000\013\000\013\000\013\000\
\013\000\013\000\007\000\007\000\000\000"

let yylen = "\002\000\
\001\000\007\000\008\000\004\000\003\000\009\000\003\000\004\000\
\008\000\006\000\006\000\007\000\007\000\006\000\007\000\007\000\
\003\000\003\000\004\000\004\000\005\000\000\000\002\000\003\000\
\003\000\004\000\001\000\002\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\029\000\001\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\015\000\000\000\000\000\028\000\000\000\000\000\
\000\000\000\000\000\000\023\000\000\000\000\000\021\000\000\000\
\000\000\016\000\000\000\024\000\019\000\020\000\026\000"

let yydgoto = "\002\000\
\004\000\005\000\000\000\000\000\000\000\000\000\018\000\000\000\
\000\000\009\000\012\000\021\000\024\000"

let yysindex = "\005\000\
\253\254\000\000\006\255\000\000\000\000\002\255\005\255\008\255\
\007\255\009\255\011\255\010\255\014\255\012\255\253\254\013\255\
\012\255\015\255\000\000\245\254\016\255\000\000\250\254\017\255\
\018\255\019\255\020\255\000\000\021\255\022\255\000\000\013\255\
\013\255\000\000\015\255\000\000\000\000\000\000\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\026\000\000\000\
\001\255\023\255\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\024\255\
\025\255\000\000\023\255\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\015\000\000\000\000\000\000\000\000\000\240\255\000\000\
\000\000\000\000\000\000\236\255\235\255"

let yytablesize = 40
let yytable = "\026\000\
\022\000\030\000\020\000\025\000\017\000\001\000\029\000\023\000\
\028\000\017\000\003\000\037\000\038\000\039\000\027\000\027\000\
\006\000\007\000\008\000\010\000\011\000\016\000\013\000\014\000\
\015\000\014\000\020\000\017\000\023\000\019\000\027\000\031\000\
\032\000\033\000\034\000\035\000\036\000\022\000\017\000\018\000"

let yycheck = "\020\000\
\017\000\023\000\014\001\020\000\016\001\001\000\023\000\014\001\
\015\001\016\001\014\001\032\000\033\000\035\000\014\001\015\001\
\011\001\016\001\014\001\012\001\014\001\008\001\014\001\013\001\
\015\001\000\000\014\001\016\001\014\001\015\000\015\001\015\001\
\015\001\015\001\015\001\015\001\015\001\015\001\015\001\015\001"

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
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'controlRule) in
    Obj.repr(
# 27 "DomainParser.mly"
                        ( print_string "yeet";_1)
# 136 "DomainParser.ml"
               : string list))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 4 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 3 : 'parameters) in
    let _5 = (Parsing.peek_val __caml_parser_env 2 : 'preconditions) in
    let _6 = (Parsing.peek_val __caml_parser_env 1 : 'effects) in
    Obj.repr(
# 40 "DomainParser.mly"
                                         ( [(_3, _5, _6)] )
# 146 "DomainParser.ml"
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
# 157 "DomainParser.ml"
               : 'ops))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'words) in
    Obj.repr(
# 53 "DomainParser.mly"
                                       ()
# 164 "DomainParser.ml"
               : 'parameters))
; (fun __caml_parser_env ->
    Obj.repr(
# 54 "DomainParser.mly"
                                   ()
# 170 "DomainParser.ml"
               : 'parameters))
; (fun __caml_parser_env ->
    let _7 = (Parsing.peek_val __caml_parser_env 2 : 'preconds1) in
    Obj.repr(
# 60 "DomainParser.mly"
                                            (_7 )
# 177 "DomainParser.ml"
               : 'preconditions))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'words) in
    Obj.repr(
# 63 "DomainParser.mly"
                               ( [_2] )
# 184 "DomainParser.ml"
               : 'preconds1))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'words) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'preconds1) in
    Obj.repr(
# 64 "DomainParser.mly"
                                       ( _2::_4 )
# 192 "DomainParser.ml"
               : 'preconds1))
; (fun __caml_parser_env ->
    let _6 = (Parsing.peek_val __caml_parser_env 2 : 'del_add) in
    Obj.repr(
# 69 "DomainParser.mly"
                                                         ( _6 )
# 199 "DomainParser.ml"
               : 'effects))
; (fun __caml_parser_env ->
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'words) in
    Obj.repr(
# 74 "DomainParser.mly"
                                                ( [] )
# 206 "DomainParser.ml"
               : 'del_add))
; (fun __caml_parser_env ->
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'words) in
    Obj.repr(
# 75 "DomainParser.mly"
                                              ( [_4] )
# 213 "DomainParser.ml"
               : 'del_add))
; (fun __caml_parser_env ->
    let _4 = (Parsing.peek_val __caml_parser_env 3 : 'words) in
    let _7 = (Parsing.peek_val __caml_parser_env 0 : 'del_add) in
    Obj.repr(
# 76 "DomainParser.mly"
                                                        ( _7 )
# 221 "DomainParser.ml"
               : 'del_add))
; (fun __caml_parser_env ->
    let _4 = (Parsing.peek_val __caml_parser_env 3 : 'words) in
    let _7 = (Parsing.peek_val __caml_parser_env 0 : 'del_add) in
    Obj.repr(
# 77 "DomainParser.mly"
                                                   ( _4::_7 )
# 229 "DomainParser.ml"
               : 'del_add))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'ifBranch) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : 'thenBranch) in
    Obj.repr(
# 88 "DomainParser.mly"
                                                       ( [_3])
# 238 "DomainParser.ml"
               : 'controlRule))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 4 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 3 : 'ifBranch) in
    let _5 = (Parsing.peek_val __caml_parser_env 2 : 'thenBranch) in
    let _7 = (Parsing.peek_val __caml_parser_env 0 : 'controlRule) in
    Obj.repr(
# 89 "DomainParser.mly"
                                                                   (_3::_7)
# 248 "DomainParser.ml"
               : 'controlRule))
; (fun __caml_parser_env ->
    let _5 = (Parsing.peek_val __caml_parser_env 2 : 'ifBranch1) in
    Obj.repr(
# 92 "DomainParser.mly"
                                                  ()
# 255 "DomainParser.ml"
               : 'ifBranch))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'words) in
    Obj.repr(
# 95 "DomainParser.mly"
                               ()
# 262 "DomainParser.ml"
               : 'ifBranch1))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'ifBranch1) in
    Obj.repr(
# 96 "DomainParser.mly"
                                  ()
# 269 "DomainParser.ml"
               : 'ifBranch1))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'words) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'ifBranch1) in
    Obj.repr(
# 97 "DomainParser.mly"
                                       ()
# 277 "DomainParser.ml"
               : 'ifBranch1))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'ifBranch1) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'ifBranch1) in
    Obj.repr(
# 98 "DomainParser.mly"
                                          ()
# 285 "DomainParser.ml"
               : 'ifBranch1))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'words) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'header) in
    Obj.repr(
# 102 "DomainParser.mly"
                                        ()
# 293 "DomainParser.ml"
               : 'thenBranch))
; (fun __caml_parser_env ->
    Obj.repr(
# 109 "DomainParser.mly"
   ()
# 299 "DomainParser.ml"
               : 'header))
; (fun __caml_parser_env ->
    Obj.repr(
# 110 "DomainParser.mly"
                           ()
# 305 "DomainParser.ml"
               : 'header))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'header) in
    Obj.repr(
# 111 "DomainParser.mly"
                                ()
# 312 "DomainParser.ml"
               : 'header))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'words) in
    Obj.repr(
# 112 "DomainParser.mly"
                               ()
# 319 "DomainParser.ml"
               : 'header))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'words) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'header) in
    Obj.repr(
# 113 "DomainParser.mly"
                                    ()
# 327 "DomainParser.ml"
               : 'header))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 116 "DomainParser.mly"
                                                            ( [_1] )
# 334 "DomainParser.ml"
               : 'words))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'words) in
    Obj.repr(
# 117 "DomainParser.mly"
                                                            ( _1 :: _2 )
# 342 "DomainParser.ml"
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
