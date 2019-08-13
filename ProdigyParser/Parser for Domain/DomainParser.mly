
%{ 

(* Called by ocamlyacc in case of error *)
let parse_error s =
  print_string "ERROR: ";
  print_endline s;
  flush stdout

%}

%token EOF
%token /*SETF CURR CREATE_PROB */OPERATOR /*NODE GOAL BINDINGS SELECT REJECT PREFER SUBGOAL*/ 
%token PARAMS PRECONDS EFF AND OR DELETE ADD TILDE /* CONTROL_RULE IF THEN */
%token LPAREN RPAREN DOT
%token <string> WORD ID VAR
%start main             /* the entry point */

/*Following type is for the list of operators */
%type <(string * (string * string list) list * (string * string list) list) list > main 

/* Following type is for the list of names of control rules */
/*%type <(string list> main*/

%%

/* The 'main' used for testing operators i.e. with test file junk1.lisp */
/*main:
    LPAREN CREATE_PROB ID CURR ID RPAREN ops                           { $7 } */

/* The 'main' used for testing control rules i.e. with test file junk2.lisp */
main:
  | EOF              { [] }
  | ops 			 { [$1] }
  | irrelevant 		 { [] }  
  | ops main		 { $1::$2 }
  | irrelevant main	 { $2 } 


/*-------------------------------------------*/
/* DEFINING OPERATOR GRAMMAR */

/*Intended return value: LIST OF (operatorName, preconditionsList, effectsList)*/
ops:
  | LPAREN OPERATOR ID parameters
    preconditions effects RPAREN      { ($3, $5, $6) }

parameters:
  | LPAREN PARAMS varList RPAREN {}
  | LPAREN PARAMS RPAREN         {}


/*--------------------------------*/
/*--------------------------------*/
/*MAKE CASE FOR "OR" in PRECONDITIONS*/
/*--------------------------------*/
/*--------------------------------*/
preconditions:
  | LPAREN PRECONDS irrelevant propList RPAREN 					{ $4 }
  | LPAREN PRECONDS LPAREN irrelevant RPAREN propList RPAREN 		{ $6 }
  | LPAREN PRECONDS irrelevant LPAREN AND propList RPAREN RPAREN	{ $6 }
  | LPAREN PRECONDS LPAREN irrelevant RPAREN LPAREN AND propList RPAREN RPAREN	{ $8 }

/*Intended return value: LIST OF effects*/
effects: 
  | LPAREN EFF LPAREN RPAREN LPAREN del_add RPAREN RPAREN  { $6 }
  | LPAREN EFF LPAREN varSpec RPAREN LPAREN del_add RPAREN RPAREN  { $7 }

/*Intended return value: LIST OF effects*/
/* EFFECT IS ONLY ADDED IF PRECEDED WITH AN "add" */
del_add:
  | LPAREN DELETE LPAREN prop RPAREN RPAREN         { [] }
  | LPAREN ADD LPAREN prop RPAREN RPAREN            { [$4] }
  | LPAREN DELETE LPAREN prop RPAREN RPAREN del_add { $7 }
  | LPAREN ADD LPAREN prop RPAREN RPAREN del_add    { $4::$7 }


/*-------------------------------------------*/
/* DEFINING CONTROL RULE GRAMMAR */

/*Intended return value: LIST OF (controlRuleName)*/
/*
controlRule:
  | LPAREN CONTROL_RULE ID ifBranch thenBranch RPAREN { }

ifBranch:
  | LPAREN IF restrictedPDLexp RPAREN {}

restrictedPDLexp:
  | prop {}
  | LPAREN AND propList RPAREN {}

thenBranch:
  | LPAREN THEN rhsSpec RPAREN {}

rhsSpec:
  | SELECT candidate {}
  | REJECT candidate {}
  | PREFER candidate {}
  | SUBGOAL          {}

candidate:
  | NODE varList       {}
  | GOAL propList      {} 
  | OPERATOR ID        {}
  | BINDINGS bindsList {}
*/

/*-------------------------------------------*/
/* Common entities */

/* Propositions are predicates followed by a list of arguments that consist
   of constants or variables */
prop:
  | ID                 { ($1, []) }
  | ID args            { ($1, $2) }

args:
  | ID        { [$1] } /* constant */
  | VAR       { [$1] }
  | ID args   { $1::$2 }
  | VAR args  { $1::$2 }

propList:
  | 												   { [] }
  | LPAREN prop RPAREN          					   { [$2] }
  | LPAREN prop RPAREN propList 					   { $2::$4 }
  | LPAREN TILDE LPAREN prop RPAREN	RPAREN			   { let (a,b) = $4 in 
  															[("~"^a, b)]}
  | LPAREN TILDE LPAREN prop RPAREN RPAREN propList    { let (a,b) = $4 in 
  															("~"^a, b)::$7}

varList:
  | VAR         { [$1] }
  | VAR varList { $1::$2 }

binding:
  | LPAREN binding RPAREN { $2 }
  | VAR DOT VAR           { ($1, $3) }

bindsList:
  | binding           { [$1] }
  | binding bindsList { $1::$2 }

objList: 
  | LPAREN VAR ID RPAREN				{}
  | LPAREN VAR ID RPAREN objList		{}

varDescriptor:
  | ID 												{}
  | LPAREN AND varDescriptor constraints RPAREN   {}
  | LPAREN OR varDescriptor constraints RPAREN    {}
  | LPAREN TILDE varDescriptor constraints RPAREN {}

constraints:
  | varDescriptor				{}
  | LPAREN words RPAREN		{}

 varSpec: 
  | 										{}
  | LPAREN RPAREN						    {}
  | LPAREN VAR varDescriptor RPAREN		    {}
  | LPAREN VAR varDescriptor RPAREN varSpec {}

/*irrelevant: 
  | LPAREN RPAREN					{}
  | LPAREN words RPAREN				{}
  | LPAREN words irrelevantList RPAREN	{}
  | LPAREN words irrelevantList words RPAREN	{}
  | LPAREN irrelevantList words RPAREN	{}
  | LPAREN irrelevantList RPAREN		{}

irrelevantList: 
  | LPAREN RPAREN					{}
  | LPAREN words RPAREN				{}
  | LPAREN words irrelevant RPAREN	{}
  | LPAREN words irrelevant words RPAREN	{}
  | LPAREN irrelevant RPAREN		{}
  | LPAREN irrelevant words RPAREN		{}
  | LPAREN RPAREN	irrelevant				{}
  | LPAREN words irrelevant words RPAREN irrelevant	{}
  | LPAREN words RPAREN		irrelevant		{}
  | LPAREN words irrelevant RPAREN irrelevant	{}
  | LPAREN irrelevant RPAREN	irrelevant	{}
  | LPAREN irrelevant words RPAREN	irrelevant	{}
*/

irrelevant:
  | LPAREN RPAREN	             {}
  | LPAREN irrelevantList RPAREN {}


irrelevantList:
  | words										{}
  | LPAREN RPAREN								{}
  | LPAREN words RPAREN							{}
  | LPAREN irrelevantList RPAREN				{}
  | words irrelevantList						{}
  | LPAREN RPAREN irrelevantList				{}
  | LPAREN words RPAREN	irrelevantList			{}
  | LPAREN irrelevantList RPAREN irrelevantList	{}

words: 
  | WORD 			 {}
  | ID               {}
  | VAR  			 {}
  | AND				 {}
  | OR 				 {}
  | OPERATOR 		 {}
  | PARAMS 			 {}
  | PRECONDS 		 {}
  | EFF 			 {}
  | ADD 			 {}
  | DELETE		     {}
  | DOT 			 {}
  | TILDE 			 {}
  | WORD words		 {}
  | ID   words       {}
  | VAR  words   	 {}
  | AND words 		 {}
  | OPERATOR words   {}
  | DOT words		 {}
  | TILDE words      {}
  | OR words         {}
  | PARAMS words 			 {}
  | PRECONDS words		 {}
  | EFF words			 {}
  | ADD words			 {}
  | DELETE words			 {}


%%
