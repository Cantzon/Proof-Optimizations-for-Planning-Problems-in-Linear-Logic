
%{
open Translation  
%}


%token EOF
%token SETF CURR_PROB CREATE_PROB NAME OBJECTS STATE AND GOAL
%token LPAREN RPAREN
%token <string> WORD
%token <int> INTEGER
%start main             /* the entry point */

%%
main:
    e=expr EOF                                              { e }

expr:
    e=expr1                                                 { e }

expr1:
    LPAREN SETF LPAREN CURR_PROB RPAREN LPAREN CREATE_PROB
    n=naming obj s=states g=goals RPAREN RPAREN             { [n, s, g] }

/* -------------------------------------------------------- */
naming:
    LPAREN NAME w=WORD RPAREN                               { w }

/* -------------------------------------------------------- */

obj: 
    LPAREN OBJECTS irrelevant RPAREN

irrelevant:
    | LPAREN words RPAREN
    | LPAREN words RPAREN irrelevant


/* -------------------------------------------------------- */

states:
    LPAREN STATE LPAREN AND s=states1 RPAREN RPAREN         { s }

states1: 
    | s=words                                               { [s] }
    | s1=words states1                                      { s1::$2 }

/* -------------------------------------------------------- */


goals:
    LPAREN GOAL LPAREN AND g=goals1 RPAREN RPAREN           { g }

goals1: 
    | g=words                                               { [g] }
    | g1=words goals1                                       { g1::$2 }

/* -------------------------------------------------------- */

words: 
    | WORD                                                  { [$1] }
    | INT                                                   { [$1] }
    | WORD words                                            { $1 :: $2 }
    | INT words                                             { $1 :: $2 }

%%