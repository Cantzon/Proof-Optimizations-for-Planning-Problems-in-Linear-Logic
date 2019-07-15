
%{ 

%}

%token EOF
%token SETF CURR_T CREATE_PROB OPERATOR 
%token PARAMS PRECONDS EFF AND DELETE ADD CONTROL_RULE IF THEN EOF
%token LPAREN RPAREN
%token <string> WORD
%start main             /* the entry point */

/*Following type is for the list of operators */
/*%type <(string * string list list * string list list) list > main */

/* Following type is for the list of names of control rules */
%type <string list> main

%%

/* The 'main' used for testing operators i.e. with test file junk1.lisp */
/*main:
    LPAREN CREATE_PROB WORD CURR_T RPAREN ops 				{ $6 } */

/* The 'main' used for testing control rules i.e. with test file junk2.lisp */
main:
	controlRule EOF											{ print_string "yeet";$1}


/*-------------------------------------------*/
/* DEFINING OPERATOR GRAMMAR */

/* Current issue: The following definition of ops does NOT work in list form,
				  but works if modified to work with only a single triple as 
				  in the next definition*/

/*Intended return value: LIST OF (operatorName, preconditionsList, effectsList)*/
ops:
    | LPAREN OPERATOR WORD parameters 
      preconditions effects RPAREN							{ [($3, $5, $6)] }	
    | LPAREN OPERATOR WORD parameters 
      preconditions effects RPAREN ops						{ ($3, $5, $6)::$8 }

/* For this definition of ops to work, the main file must be adjusted
   to work with a single triple

ops:
    | LPAREN OPERATOR WORD parameters 
      preconditions effects RPAREN							{ ($3, $5, $6) }	
*/

parameters:
    | LPAREN PARAMS words RPAREN							{}
    | LPAREN PARAMS RPAREN									{}


/*Intended return value: LIST OF preconditions*/
preconditions: 
    LPAREN PRECONDS LPAREN RPAREN 
    LPAREN AND preconds1 RPAREN	RPAREN						{$7 }

preconds1:
	| LPAREN words RPAREN									{ [$2] }
	| LPAREN words RPAREN preconds1							{ $2::$4 }


/*Intended return value: LIST OF effects*/
effects: 
	LPAREN EFF LPAREN RPAREN LPAREN del_add RPAREN RPAREN			{ $6 }

/*Intended return value: LIST OF effects*/
/* EFFECT IS ONLY ADDED IF PRECEDED WITH AN "add" */
del_add:
	| LPAREN DELETE LPAREN words RPAREN	RPAREN					{ [] }
	| LPAREN ADD LPAREN words RPAREN RPAREN						{ [$4] }
	| LPAREN DELETE LPAREN words RPAREN RPAREN del_add 				{ $7 }
	| LPAREN ADD LPAREN words RPAREN RPAREN del_add 		{ $4::$7 }


/*-------------------------------------------*/
/* DEFINING CONTROL RULE GRAMMAR */
/* Current issue: The control rules have the same problem as the operator
				  i.e. they work individually, but not as a list for whatever
				  reason */
/*Intended return value: LIST OF (controlRuleName)*/

controlRule:
	| EOF 													{[]}
	| LPAREN CONTROL_RULE WORD ifBranch thenBranch RPAREN	{ [$3]}
	| LPAREN CONTROL_RULE WORD ifBranch thenBranch RPAREN controlRule {$3::$7}

ifBranch:
	| LPAREN IF LPAREN AND ifBranch1 RPAREN RPAREN			{}

ifBranch1:
	| LPAREN words RPAREN									{}
	| LPAREN ifBranch1 RPAREN								{}
	| LPAREN words RPAREN ifBranch1							{}
	| LPAREN ifBranch1 RPAREN ifBranch1						{}


thenBranch:
	| LPAREN THEN words header RPAREN						{}


/*-------------------------------------------*/
/* DEFINING MISC GRAMMAR */

header:
	| {}
	| LPAREN RPAREN											{}
	| LPAREN header RPAREN									{}
	| LPAREN words RPAREN									{}
	| LPAREN words RPAREN header							{}

words: 
    | WORD                                                  { [$1] }
    | WORD words                                            { $1 :: $2 }

%%