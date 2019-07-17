
%{ 

(* Called by ocamlyacc in case of error *)
let parse_error s =
  print_string "ERROR: ";
  print_endline s;
  flush stdout

%}

%token EOF
%token SETF CURR CREATE_PROB OPERATOR NODE GOAL BINDINGS SELECT REJECT PREFER SUBGOAL 
%token PARAMS PRECONDS EFF AND DELETE ADD CONTROL_RULE IF THEN
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
  | ops 			 { $1 }
  | controlRule      { [] }
  | controlRule main { [] }


/*-------------------------------------------*/
/* DEFINING OPERATOR GRAMMAR */

/*Intended return value: LIST OF (operatorName, preconditionsList, effectsList)*/
ops:
  | LPAREN OPERATOR ID parameters
    preconditions effects RPAREN      { [($3, $5, $6)] }
  | LPAREN OPERATOR ID parameters 
    preconditions effects RPAREN ops  { ($3, $5, $6)::$8 }

parameters:
  | LPAREN PARAMS varList RPAREN {}
  | LPAREN PARAMS RPAREN         {}


/*Intended return value: LIST OF preconditions*/
preconditions: 
  LPAREN PRECONDS LPAREN RPAREN 
  LPAREN AND propList RPAREN RPAREN  { $7 }

/*Intended return value: LIST OF effects*/
effects: 
  LPAREN EFF LPAREN RPAREN LPAREN del_add RPAREN RPAREN  { $6 }

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
  | LPAREN prop RPAREN          { [$2] }
  | LPAREN prop RPAREN propList { $2::$4 }

varList:
  | VAR         { [$1] }
  | VAR varList { $1::$2 }

binding:
  | LPAREN binding RPAREN { $2 }
  | VAR DOT VAR           { ($1, $3) }

bindsList:
  | binding           { [$1] }
  | binding bindsList { $1::$2 }

%%
