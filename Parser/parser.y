%{
	#ifndef YYDEBUG
	#define YYDEBUG 0
	#endif
	#include <stdio.h>
	#include <string.h>
	#include "Node.h"
	FILE *yyin;
	int yywrap();
	int yyparse();
	int yylex();
	void yyerror(const char* string);
	void addStringList(Node** lnode, char* string);
	Node* fNode;
	Node* cNode;
	Node** pcNode;

%}

%union {
	char *str;
}

%token <str> ORG EQU HALT NOP
%token <str> LD ST 
%token <str> ADD ADDCC SRL SLL SRA
%token <str> AND ANDCC OR ORCC
%token <str> BE BNE BCS BCC BNEG BPOS BVS BVC BA JMPL CALL 
%token <str> REG_R0 REG_R1 REG_R2 REG_R3 REG_R4 REG_R5 
%token <str> REG_R6 REG_R7 REG_R8 REG_R9 REG_R10 
%token <str> REG_R11 REG_R12 REG_R13 REG_R14 REG_R15
%token <str> NAME 
%token <str> P_INT N_INT
%token <str> COMMA COLON SEMICOLON LEFT_SQ_BR RIGHT_SQ_BR PLUS
%start program

%type <str> memloc ld_instr st_instr mem_operand reg command3 operand 
%type <str> command1 mem_reg labelst instruction instr_0 instr_1 instr_2 instr_3
%type <str> instr_equ instr_jmpl init_addr


%%


reg : REG_R0 | REG_R1 | REG_R2  |REG_R3 | REG_R4 | REG_R5 | REG_R6 | REG_R7 |REG_R8 
	| REG_R9 | REG_R10 | REG_R11 | REG_R12 | REG_R13 | REG_R14 |REG_R15;

memloc : LEFT_SQ_BR NAME RIGHT_SQ_BR  {$$=$2;} ;/* Buscar el nombre en la tabla de símbolos para observar si ya ha sido declarado , de lo contrario arrojar error.*/

mem_operand: memloc | P_INT ;

mem_reg: mem_operand | reg ;
 
operand: reg | P_INT | N_INT ;

instr_0 : HALT {	addStringList(pcNode, $1);
					addStringList(pcNode, "\n");} | NOP {	addStringList(pcNode , $1);
															addStringList(pcNode , "\n");};

command1: BE | BNE | BCS | BCC | BNEG | BPOS | BVS | BVC | BA | CALL;

instr_1: command1 NAME {	addStringList(pcNode, $1);
							addStringList(pcNode, $2);
							addStringList(pcNode, "\n");	} ;
 

ld_instr: LD mem_reg COMMA mem_reg '\n' { 	addStringList(pcNode , $1);
											addStringList(pcNode , $2);
											addStringList(pcNode , $4);
											addStringList(pcNode , "\n");
																		} ;

st_instr: ST mem_reg COMMA mem_reg '\n' { 	addStringList(pcNode , $1);
											addStringList(pcNode , $2);
											addStringList(pcNode , $4);
											addStringList(pcNode , "\n");
																		} ;

instr_2: ld_instr | st_instr;

command3: ADDCC | ADD | SRL | SLL | SRA | AND | ANDCC | OR | ORCC;

instr_3: command3 reg COMMA operand COMMA reg '\n'{ addStringList(pcNode , $1);
													addStringList(pcNode , $2);
													addStringList(pcNode , $4);
													addStringList(pcNode , $6);
													addStringList(pcNode , "\n");
																				};

init_addr: ORG P_INT '\n' { addStringList(pcNode, $1);
							addStringList(pcNode, $2);
							addStringList(pcNode, "\n");};
		| ORG NAME '\n' { addStringList(pcNode, $1);
							addStringList(pcNode, $2);
							addStringList(pcNode, "\n");
														}; /* e.g.: org 12 Revisar Casos en los cuales el usuario pueda ingresar direcciones de memoria no validas-.*/
instr_equ: NAME EQU P_INT '\n'	{ 	addStringList(pcNode, $1);
									addStringList(pcNode, $2);
									addStringList(pcNode, $3);
									addStringList(pcNode, "\n");
															};

instr_jmpl: JMPL reg PLUS P_INT COMMA reg {	addStringList(pcNode, $1);
											addStringList(pcNode, $2);
											addStringList(pcNode, $4);
											addStringList(pcNode, $6);
											addStringList(pcNode, "\n");
																		} 
			| JMPL reg  N_INT COMMA reg {	addStringList(pcNode, $1);
											addStringList(pcNode, $2);
											addStringList(pcNode, $3);
											addStringList(pcNode, $5);											
											addStringList(pcNode, "\n");
																		};

instruction: instr_0 | instr_1 | instr_2 | instr_3 | instr_jmpl | init_addr | instr_equ ; /*Posicionamiento de ini_prog y fin_prog en esta regla sujeto a evaluación*/

labelst: NAME COLON instruction { 	addStringList(pcNode,$1);
									addStringList(pcNode,$3);
									addStringList(pcNode,"\n");}
		| NAME COLON NAME { 		addStringList(pcNode,$1);
									addStringList(pcNode,$3);
									addStringList(pcNode,"\n");};  /* e.g.: start:inst
											 Evaluar si etiqueta se puede posicionar en lugares sin instruccion*/
varst: NAME COLON P_INT '\n' | NAME COLON N_INT '\n';  /* e.g: x:5 .Guardar Label value.OJO. */

label: labelst | varst ;

program: instruction | label | '\n' | program instruction | program label | program '\n' ;



%%


int yywrap(){
	return 1;
}


int main(int argc, char const * argv[])
{
	#if YYDEBUG
		yydebug=1;
	#endif

	yylval.str=malloc(40*sizeof(char));
	fNode = newNode();
	cNode= fNode;
	pcNode=&cNode;

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

	cNode=(*fNode).next;
	while(cNode!=NULL){
		printf("%s\n",(*cNode).val.sval );
		cNode=(*cNode).next;
	}	

	return 0;
}

void addStringList(Node** lnode, char* string){
	Node* temp = newNodeString(string);
	appendNode(*lnode,temp);
	*lnode=temp;
}