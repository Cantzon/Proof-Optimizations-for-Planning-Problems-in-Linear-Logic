
%{ 

%}

%token EOF
%token SETF CURR_PROB CREATE_PROB NAME OBJECTS STATE AND OR GOAL TILDE
%token LPAREN RPAREN
%token <string> WORD
%start main             /* the entry point */
%type <string * string list list * string list list> main 

%%

main:
    |LPAREN SETF LPAREN CURR_PROB RPAREN LPAREN CREATE_PROB
    naming obj states goals RPAREN RPAREN          		  { ($8, $10, $11) }
   	|LPAREN SETF LPAREN CURR_PROB RPAREN LPAREN CREATE_PROB
    naming states goals RPAREN RPAREN          			  { ($8, $9, $10) }

/* -------------------------------------------------------- */
naming:
    LPAREN NAME WORD RPAREN                               { $3 }

/* -------------------------------------------------------- */

obj: 
    LPAREN OBJECTS irrelevant RPAREN                       {}
/* MAKE SURE TO ACCOUNT FOR THE CASES WITHOUT OBJECTS */


irrelevant:
	| {}
	| LPAREN RPAREN										   {}
    | LPAREN words RPAREN                                  {}
    | LPAREN words RPAREN irrelevant                       {}


/* -------------------------------------------------------- */

states:
    LPAREN STATE LPAREN AND states1 RPAREN RPAREN         { $5 }

states1: 
	| LPAREN RPAREN											{[]}
    | LPAREN words RPAREN                                 { [$2] }
    | LPAREN words RPAREN states1                        { $2::$4 }

/* -------------------------------------------------------- */


goals:
    |LPAREN GOAL LPAREN AND goals1 RPAREN RPAREN           { $5 }
    |LPAREN GOAL LPAREN OR goals1 RPAREN RPAREN			   { $5 }
    |LPAREN GOAL goals1 RPAREN                             { $3 }
    |LPAREN GOAL LPAREN goals1 RPAREN RPAREN 			   { $4 }
    |LPAREN GOAL LPAREN irrelevant RPAREN
     LPAREN AND goals1 RPAREN RPAREN					   { $8 }
    |LPAREN GOAL LPAREN irrelevant RPAREN
     LPAREN OR goals1 RPAREN RPAREN						   { $8 }
    |LPAREN GOAL LPAREN irrelevant RPAREN
     goals1 RPAREN										   { $6 }
    |LPAREN GOAL LPAREN RPAREN
     goals1 RPAREN										   { $5 }
    |LPAREN GOAL LPAREN RPAREN
     LPAREN AND goals1 RPAREN RPAREN					   { $7 }
    |LPAREN GOAL LPAREN RPAREN
     LPAREN OR goals1 RPAREN RPAREN					   	   { $7 }


goals1: 
	| LPAREN RPAREN											{[]}
    | LPAREN words RPAREN                                 { [$2] }
    | LPAREN words RPAREN  goals1                         { $2::$4 }
    | TILDE LPAREN words RPAREN								{ ["~"::$3] }
    | TILDE LPAREN words RPAREN	goals1						{ ("~"::$3)::$5 }
    | LPAREN TILDE LPAREN words RPAREN RPAREN				{ ["~"::$4] }
    | LPAREN TILDE LPAREN words RPAREN RPAREN goals1		{ ("~"::$4)::$7 }



words: 
    | WORD                                                  { [$1] }
    | WORD words                                            { $1 :: $2 }

%%