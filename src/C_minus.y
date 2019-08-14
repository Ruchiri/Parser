%{                                                                                   
   #include <stdarg.h> 
   #include "src/C_minus_shared.h"                                                        
   #define YYSTYPE char *                                                            
   int yydebug=1;                                                                    
   int indent=0;                                                                     
   char *iden_dum;                                                                   
%}                    

%token ELSE
%token IF
%token INT
%token RETURN
%token VOID
%token WHILE
%token ADD
%token SUB
%token MUL
%token DIV
%token LT
%token LE
%token GR
%token GE
%token EQ
%token ET
%token NE
%token CM
%token SC
%token LC
%token RC
%token LP
%token RP
%token LS
%token RS
%token NUM
%token ID

%% /* Grammar rules and actions follow */  

program:
    declaration-list declaration
;

declaration-list:
    declaration-list declaration
    |declaration
;

declaration:                                                                         
      var-declaration                                               
      | fun-declaration                                                               
;  

var-declaration:
    type-specifier ID SC
    | type-specifier ID LS NUM RS SC 
;  

type-specifier:                                                                      
    INT                                                                                              
    | VOID                                                                                                     
;

fun-declaration:
    type-specifier ID LP params RP compound-stmt 
;

params:
    param-list 
    | VOID
;

param-list:
    param-list CM param
    | param
;

param:
    type-specifier ID 
    | type-specifier ID LS RS
;

compound-stmt:
    LC local-declarations statement-list RC
;

local-declarations:
    local-declarations var-declaration
    | %empty
;

statement-list: 
    statement-list statement 
    | %empty
;

statement:
    expression-stmt 
    | compound-stmt 
    | selection-stmt 
    | iteration-stmt 
    |return-stmt
;

expression-stmt:
    expression SC 
    | SC
;

selection-stmt:
    IF LP expression RP statement 
    | IF LP expression RP statement ELSE statement
;

iteration-stmt:
    WHILE LP expression RP statement
;

return-stmt:
    RETURN SC 
    | RETURN expression SC
;

expression:
    var EQ expression 
    | simple-expression
;

var:
    ID 
    | ID LS expression RS
;

simple-expression: 
    additive-expression relop additive-expression
    | additive-expression
;

relop:
    LT 
    | LE 
    | GR 
    | GE 
    | ET 
    | NE
;

additive-expression:
    additive-expression addop term 
    | term
;

addop:
    ADD
    | SUB
;

term:
    term mulop factor 
    | factor
;

mulop:
    MUL 
    | DIV
;

factor:
    LP expression RP 
    | var 
    | call 
    | NUM
;

call:
    ID LP args RP
;

args:
    arg-list 
    | %empty
;

arg-list:
    arg-list CM expression 
    | expression
;

%%

main ()                                                                              
{                                                                                    
  if (yyparse ()==0){
      printf("Valid Syntax");
  }else{
      printf("Invalid Syntax");
  };                                                                        
}