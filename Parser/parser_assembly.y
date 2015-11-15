%{
#include <string.h>
 
%}

%union{
	int intval;
	struct symtab *symp;
}

%token END ORG BEGIN
%token LD ADD ADDCC ST

%token REG_R1 REG_R2 REG_R3 REG_R4 REG_R5 REG_R6
%token REG_R7 REG_R8 REG_R9 REG_R10 REG_R11
%token REG_R12 REG_R13 REG_R14 REG_R15

%token COMMA COLON SEMICOLON LEFT_SQ_BR RIGHT_SQ_BR

%token <symp> NAME
%token intval INT

%%

instr:  param_instr_3 | param_instr_2 | init_addr | varst | labelst | ini_prog | fin_pro
;
 
param_instr_2: command operand COMMA operand ;

param_instr_3: command3 operand COMMA operand COMMA operand;

operand: reg | memloc ;

command: LD | ADD | ST ;

command3: ADDCC;

reg : REG_R1| REG_R2 |REG_R3 | REG_R4 | REG_R5 | REG_R6 | REG_R7 |REG_R8 | REG_R9 | REG_R10 | REG_R11 | REG_R12 | REG_R13 | REG_R14 |REG_R15;

memloc : LEFT_SQ_BR NAME RIGHT_SQ_BR /* Buscar el nombre en la tabla de símbolos para observar si ya ha sido declarado , de lo contrario arrojar error.*/

init_addr: ORG INT 
; /*Revisar Casos en los cuales el usuario pueda ingresar direcciones de memoria no validas-.*/

labelst: NAME COLON param_instr_2 | NAME COLON param_instr_3; /* Evaluar si etiqueta se puede posicionar en lugares sin instruccion*/

varst: NAME COLON INT 

; /* Guardar Label value.OJO. */

ini_prog: BEGIN
;
fin_pro: END;
%%



