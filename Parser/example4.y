%{
#include <stdio.h>
#include <string.h>
int yywrap();
int yyparse();
int yylex();


	int yywrap(){
		return 1;
	}

	int main(){
		yyparse();
	}

%}


%token START END ORG LD ADD ADDCC ST REG_R1 REG_R2 REG_R3 REG_R4 REG_R5 REG_R6 REG_R7 REG_R8 REG_R9 REG_R10 REG_R11 REG_R12 REG_R13 REG_R14 REG_R15 COMMA COLON SEMICOLON LEFT_SQ_BR RIGHT_SQ_BR NAME INT ERROR

%%



instr:  param_instr_3 | param_instr_2 | init_addr | varst | ini_prog | labelst | fin_pro;
 
param_instr_2: command operand COMMA operand ;

param_instr_3: command3 operand COMMA operand COMMA operand;

operand: reg | memloc ;

command: LD | ADD | ST ;

command3: ADDCC;

reg : REG_R1| REG_R2 |REG_R3 | REG_R4 | REG_R5 | REG_R6 | REG_R7 |REG_R8 | REG_R9 | REG_R10 | REG_R11 | REG_R12 | REG_R13 | REG_R14 |REG_R15;

memloc : LEFT_SQ_BR NAME RIGHT_SQ_BR /* Buscar el nombre en la tabla de símbolos para observar si ya ha sido declarado , de lo contrario arrojar error.*/

init_addr: ORG INT ; /*Revisar Casos en los cuales el usuario pueda ingresar direcciones de memoria no validas-.*/

labelst: NAME COLON param_instr_2 | NAME COLON param_instr_3; /* Evaluar si etiqueta se puede posicionar en lugares sin instruccion*/

varst: NAME COLON INT {printf("yacc: NAME COLON INT\n");}; /* Guardar Label value.OJO. */

ini_prog: START {printf("START arrived to yacc\n");};

fin_pro: END {printf("END arrived to yacc\n");};

