
%{ 

%}

%token EOF
%token SETF CURR_PROB CREATE_PROB NAME OBJECTS STATE AND GOAL
%token LPAREN RPAREN
%token <string> WORD
%start main             /* the entry point */
%type <string * string list list * string list list> main 

%%

main:
    LPAREN SETF LPAREN CURR_PROB RPAREN LPAREN CREATE_PROB
    naming obj states goals RPAREN RPAREN           { ($8, $10, $11) }

/* -------------------------------------------------------- */
naming:
    LPAREN NAME WORD RPAREN                               { $3 }

/* -------------------------------------------------------- */

obj: 
    LPAREN OBJECTS irrelevant RPAREN                       {}

irrelevant:
    | LPAREN words RPAREN                                  {}
    | LPAREN words RPAREN irrelevant                       {}


/* -------------------------------------------------------- */

states:
    LPAREN STATE LPAREN AND states1 RPAREN RPAREN         { $5 }

states1: 
    | LPAREN words RPAREN                                 { [$2] }
    | LPAREN words RPAREN states1                        { $2::$4 }

/* -------------------------------------------------------- */


goals:
    |LPAREN GOAL LPAREN AND goals1 RPAREN RPAREN           { $5 }
    |LPAREN GOAL goals1 RPAREN                             { $3 }

goals1: 
    | LPAREN words RPAREN                                 { [$2] }
    | LPAREN words RPAREN  goals1                        { $2::$4 }


words: 
    | WORD                                                  { [$1] }
    | WORD words                                            { $1 :: $2 }

%%