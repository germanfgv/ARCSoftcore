%{
#ifndef YYDEBUG
#define YYDEBUG 0
#endif
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "Diccionario/dictionary.h"


FILE *yyin;
int yywrap();
int yyparse();
int yylex();
void yyerror(const char* string);

%}

%union {
	char *str;
	int  num;
}
%token ORG EQU HALT NOP
%token LD ST 
%token ADD ADDCC SRL SLL SRA
%token AND ANDCC OR ORCC
%token BE BNE BCS BCC BNEG BPOS BVS BVC BA JMPL CALL 
%token REG_R1 REG_R2 REG_R3 REG_R4 REG_R5 
%token REG_R6 REG_R7 REG_R8 REG_R9 REG_R10 
%token REG_R11 REG_R12 REG_R13 REG_R14 REG_R15
%token <str> NAME P_INT N_INT
%token COMMA COLON SEMICOLON LEFT_SQ_BR RIGHT_SQ_BR PLUS
%start program
%type <str> memloc


%%

program: instruction | label | '\n' | program instruction | program label | program '\n' ;

label: labelst | varst ;

instruction:  instr_2 | instr_3 | instr_1 | init_addr | instr_equ | marker | instr_jmpl; /*Posicionamiento de ini_prog y fin_prog en esta regla sujeto a evaluación*/

mem_operand: memloc {printf("%s\n", $1);}
			| P_INT ;
 
ld_instr: LD mem_operand COMMA reg '\n' ;

st_instr: ST reg COMMA mem_operand '\n' ;

instr_2: ld_instr | st_instr;

operand: reg |  P_INT | N_INT;

command3: ADDCC | ADD | SRL | SLL | SRA | AND | ANDCC | OR | ORCC;

instr_3: command3 operand COMMA operand COMMA operand '\n' ;

instr_1: command1 NAME 

instr_equ: NAME EQU P_INT ;

marker: HALT|NOP;

instr_jmpl: JMPL reg PLUS P_INT COMMA reg | JMPL reg  N_INT COMMA reg;

command1: BE | BNE | BCS | BCC | BNEG | BPOS | BVS | BVC | BA | CALL;

reg : REG_R1| REG_R2 |REG_R3 | REG_R4 | REG_R5 | REG_R6 | REG_R7 |REG_R8 | REG_R9 | REG_R10 | REG_R11 | REG_R12 | REG_R13 | REG_R14 |REG_R15;

memloc : LEFT_SQ_BR NAME RIGHT_SQ_BR {$$=$2;};/* Buscar el nombre en la tabla de símbolos para observar si ya ha sido declarado , de lo contrario arrojar error.*/

init_addr: ORG P_INT '\n' ; /* e.g.: org 12 Revisar Casos en los cuales el usuario pueda ingresar direcciones de memoria no validas-.*/

labelst: NAME COLON instr_2 | NAME COLON instr_3; /* e.g.: start:inst
											 Evaluar si etiqueta se puede posicionar en lugares sin instruccion*/

varst: 	NAME COLON P_INT '\n' { printf("num is: %d\n", atoi($3));
								entry *ne=malloc(sizeof(entry));
								(*ne).key= $1;
								(*ne).value=atoi($3);
								addEntry(&symbols,ne);

							}
		| NAME COLON N_INT '\n' { printf("num is: %d\n", atoi($3));}
		;  /* e.g: x:5 .Guardar Label value.OJO. */

%%


int yywrap(){
	return 1;
}


int main(int argc, char const * argv[])
{
	entry *ent;
	char key[5];

	yylval.str=malloc(40*sizeof(char));

	#if YYDEBUG
		yydebug=1;
	#endif

	if (argc ==2){
		if ((yyin=fopen(argv[1],"rb"))!=NULL){
			yyparse();
			fclose(yyin);
		}
	}else{
		/*Se permite PROVISIONALMENTE que el programa corra sin archivo ingresado por parámetro.
		Para realización de pruebas rápidas.*/
		yyparse();
	}

	printf("Buscando simbolo\n");
	strcpy(key,"x");
	if(getEntryIdx(&symbols,0,&ent)<0){
		printf("Error\n");
		printf( "No hay entreda con la key \"%s\"\n",  key);
	}else{
		printf("Printing\n");
		printf("value is: %d\n",(*ent).value );
		printf("idx is: %d\n",(*ent).idx );	
		printf("key is: %s\n", (*ent).key );	

	}
}
