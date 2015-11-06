%{
#include <string.h>
 
%}

%union{
	int intval;
	struct symtab *symp;
}

%token BEGIN END ORG
%token LD ADD ADDCC ST

%token REG_R1 REG_R2 REG_R3 REG_R4 REG_R5 REG_R6
%token REG_R7 REG_R8 REG_R9 REG_R10 REG_R11
%token REG_R12 REG_R13 REG_R14 REG_R15

%token COMMA COLON SEMICOLON LEFT_SQ_BR RIGHT_SQ_BR

%token <symp> NAME
%token intval INT

%%

instr:  3param_instr | 2param_instr | init_addr | varst | labelst;
 
2param_instr: command operand COMMA operand ;

3param_instr: command3 operand COMMA operand COMMA operand ;

operand: reg | memloc ;

command: LD | ADD | ST ;

command3: ADDCC;

reg : REG_R1 | REG_R2 | REG_R3 | REG_R4 | REG_R5 | REG_R6 | REG_R7
	| REG_R8 | REG_R9 | REG_R10 | REG_R11 | REG_R12 | REG_R13
	| REG_R14 | REG_R15 ; // Evaluar compresión de esta regla de gramática con el fin de construirlo genérico para el número de registros

memloc : LEFT_SQ_BR NAME RIGHT_SQ_BR // Buscar el nombre en la tabla de símbolos para observar si ya ha sido declarado , de lo contrario arrojar error.

init_addr: ORG INT ; //Revisar Casos en los cuales el usuario pueda ingresar direcciones de memoria no validas-.

labelst: NAME COLON 2param_instr | NAME COLON 3param_instr; // Evaluar si etiqueta se puede posicionar en lugares sin instruccion

varst: NAME COLON INT ; // Guardar Label value.OJO.


%%



