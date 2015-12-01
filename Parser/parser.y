%{
#ifndef YYDEBUG
#define YYDEBUG 0
#endif
#include <stdio.h>
#include <string.h>
int yywrap();
int yyparse();
int yylex();
void yyerror(const char* string);

%}


%token START END ORG 
%token LD ADD ADDCC ST 
%token REG_R1 REG_R2 REG_R3 REG_R4 REG_R5 
%token REG_R6 REG_R7 REG_R8 REG_R9 REG_R10 
%token REG_R11 REG_R12 REG_R13 REG_R14 REG_R15
%token COMMA COLON SEMICOLON LEFT_SQ_BR RIGHT_SQ_BR 
%token NAME P_INT N_INT
%token NEWL

%start program


%%


program: instruction | label | program instruction | program label | program NEWL

label: labelst | varst

instruction:  instr_2 | instr_3 | init_addr | ini_prog  | fin_prog; /*Posicionamiento de ini_prog y fin_prog en esta regla sujeto a evaluación*/

mem_operand: memloc | P_INT ;
 
ld_instr: LD mem_operand COMMA reg NEWL ;

st_instr: ST reg COMMA mem_operand NEWL ;

instr_2: ld_instr | st_instr;

operand: reg |  P_INT | N_INT;

command3: ADDCC | ADD;

instr_3: command3 operand COMMA operand COMMA operand NEWL ;

reg : REG_R1| REG_R2 |REG_R3 | REG_R4 | REG_R5 | REG_R6 | REG_R7 |REG_R8 | REG_R9 | REG_R10 | REG_R11 | REG_R12 | REG_R13 | REG_R14 |REG_R15;

memloc : LEFT_SQ_BR NAME RIGHT_SQ_BR ;/* Buscar el nombre en la tabla de símbolos para observar si ya ha sido declarado , de lo contrario arrojar error.*/

init_addr: ORG P_INT NEWL ; /* e.g.: org 12 Revisar Casos en los cuales el usuario pueda ingresar direcciones de memoria no validas-.*/

labelst: NAME COLON instr_2 | NAME COLON instr_3; /* e.g.: start:inst
											 Evaluar si etiqueta se puede posicionar en lugares sin instruccion*/

varst: NAME COLON P_INT NEWL | NAME COLON N_INT NEWL;  /* e.g: x:5 .Guardar Label value.OJO. */

ini_prog: START NEWL;

fin_prog: END {return 0;}; /*Por ahora, todo lo que se escriba despues de .end será ignorado por el programa.
							Sería interesante que botase error si encunetra caracteres no "vacios"(Espacios ...)
							después de toparse con .end*/

%%


int yywrap(){
	return 1;
}

int main(){
	#if YYDEBUG
		yydebug=1;
	#endif
	yyparse();
	return 0;
}