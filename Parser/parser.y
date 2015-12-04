%{
	#ifndef YYDEBUG
	#define YYDEBUG 0
	#endif
	#include <stdio.h>
	#include <string.h>
	#include "fund.h"
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
%token <str> LD ST SETHI 
%token <str> ADD ADDCC SRL SLL SRA
%token <str> AND ANDCC OR ORCC ORNCC
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
%type <str> instr_equ init_addr sethi_instr


%%


reg : REG_R0 | REG_R1 | REG_R2  |REG_R3 | REG_R4 | REG_R5 | REG_R6 | REG_R7 |REG_R8 
	| REG_R9 | REG_R10 | REG_R11 | REG_R12 | REG_R13 | REG_R14 |REG_R15;

memloc : LEFT_SQ_BR NAME RIGHT_SQ_BR  {$$=$2;} ;/* Buscar el nombre en la tabla de símbolos para observar si ya ha sido declarado , de lo contrario arrojar error.*/

mem_operand: memloc | P_INT ;

mem_reg: mem_operand | reg ;
 
operand: reg | P_INT | N_INT | memloc;

instr_0 : HALT {	addStringList(pcNode, $1);
					addStringList(pcNode, "\n");
					inst_loc+=4;
												} 
		| NOP {	addStringList(pcNode , $1);
				addStringList(pcNode , "\n");
				inst_loc+=4;
			};

command1: BE | BNE | BCS | BCC | BNEG | BPOS | BVS | BVC | BA | CALL;

instr_1: command1 NAME {	addStringList(pcNode, $1);
							addStringList(pcNode, $2);
							addStringList(pcNode, "\n");
							inst_loc+=4;	} ;
 

ld_instr: LD mem_reg COMMA mem_reg '\n' { 	addStringList(pcNode , $1);
											addStringList(pcNode , $2);
											addStringList(pcNode , $4);
											addStringList(pcNode , "\n");
											inst_loc+=4;
																		} ;

st_instr: ST mem_reg COMMA mem_reg '\n' { 	addStringList(pcNode , $1);
											addStringList(pcNode , $2);
											addStringList(pcNode , $4);
											addStringList(pcNode , "\n");
											inst_loc+=4;
																		} ;

sethi_instr: SETHI operand COMMA reg { addStringList(pcNode , $1);
									 addStringList(pcNode , $2);
									 addStringList(pcNode , $4);
									 addStringList(pcNode, "\n");
									 inst_loc+=4;
									}																		

instr_2: ld_instr | st_instr | sethi_instr;

command3: ADDCC | ADD | SRL | SLL | SRA | AND | ANDCC | OR | ORCC | ORNCC | JMPL;

instr_3: command3 reg COMMA operand COMMA reg '\n'{ addStringList(pcNode , $1);
													addStringList(pcNode , $2);
													addStringList(pcNode , $4);
													addStringList(pcNode , $6);
													addStringList(pcNode , "\n");
													inst_loc+=4;
																				};

init_addr: ORG P_INT '\n' { inst_loc=atoi($2);
							addStringList(pcNode,$1);
							addStringList(pcNode,$2);
							addStringList(pcNode,"\n");
								}; /* e.g.: org 12 Revisar Casos en los cuales el usuario pueda ingresar direcciones de memoria no validas-.*/

instr_equ: NAME EQU P_INT '\n'	{ };


instruction: instr_0 | instr_1 | instr_2 | instr_3  | init_addr | instr_equ ; /*Posicionamiento de ini_prog y fin_prog en esta regla sujeto a evaluación*/

labelst: NAME COLON instruction  { 
									entry *ne=malloc(sizeof(entry));
									(*ne).key= ($1);
									(*ne).value=inst_loc;
									if(addEntry(&symbols,ne)<0){
										printf("Error al agregar entrada al diccionario: %s\n", $1);
									}
								}
		| NAME COLON NAME { 
									entry *ne=malloc(sizeof(entry));
									entry *ent;
									(*ne).key= ($1);
									if(getEntryKey(&symbols,$3,&ent)<0){
										printf("Error\n");
										printf( "No hay entreda con la key \"%s\"\n",  $3);
									}else{
										(*ne).value=(*ent).value;
									}
								}; 

varst: 	NAME COLON P_INT '\n' { 
								addStringList(pcNode, "var");
								addStringList(pcNode, $3);
								addStringList(pcNode, "\n");
								entry *ne=malloc(sizeof(entry));
								(*ne).key= ($1);
								(*ne).value=inst_loc;
								if(addEntry(&symbols,ne)<0){
									printf("Error al agregar entrada al diccionario: %s\n", $1);
								}
								inst_loc+=4;
							}
		| NAME COLON N_INT '\n' {

								addStringList(pcNode, "var");
								addStringList(pcNode, $3);
								addStringList(pcNode, "\n");
								entry *ne=malloc(sizeof(entry));
								(*ne).key= ($1);
								(*ne).value=inst_loc;
								if(addEntry(&symbols,ne)<0){
									printf("Error al agregar entrada al diccionario: %s\n", $1);
								}
								inst_loc+=4;
							};

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

	char* str;
	int op;

	yylval.str=malloc(40*sizeof(char));
	fNode = newNode();
	cNode= fNode;
	pcNode=&cNode;

	inst_loc=0;



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

	fp = fopen ("main_memory.v", "w+");

	inst_loc=0;

	cNode=(*fNode).next;
	printHeader(fp);
	while(cNode!=NULL){
		str=(*cNode).val.sval;
		printf("Inst: %s\n", str );

			if((op=strtoinst(str))!=-1){
			printf("Entro a arit con instr: %s\n", str);
			if(aricc(pcNode , op)){
				printf("Error en generación de instrucción aritmética %s : %d \n", str , op);
			};
		}else if(strcmp(str,"ld")==0){
			printf("Entro a ld con instr: %s\n", str);
			ld(pcNode);
		}else if (strcmp(str,"st")==0){
			printf("Entro a st con instr: %s\n", str);
			st(pcNode);
		}else if(strcmp(str,"be")==0){
			printf("Entro a be con instr: %s\n", str);
			be(pcNode);
		}else if(strcmp(str,"bcs")==0){
			printf("Entro a bcs con instr: %s\n", str);
			bcs(pcNode);
		}else if(strcmp(str,"bneg")==0){
			printf("Entro a bneg con instr: %s\n", str);
			bneg(pcNode);
		}else if(strcmp(str,"bvs")==0){
			printf("Entro a bvs con instr: %s\n", str);
			bvs(pcNode);
		}else if(strcmp(str,"ba")==0){
			printf("Entro a ba con instr: %s\n", str);
			ba(pcNode);
		}else if(strcmp(str,"sethi")==0){
			printf("Entro a sethi con instr: %s\n", str);
			sethi(pcNode);
		}else if(strcmp(str, ".org")==0){
			printf("Entro a .org con instr: %s\n", str);
			org(pcNode);
		}else if(strcmp(str,"var")==0){
			printf("Entro a var con instr: %s\n", str);
			var(pcNode);
		}else{
			printf("Error en el reconocimiento de la instruccion: %s\n",str);
			return -1;
		}
		inst_loc+=4;

		cNode=(*cNode).next;
	}
	printFooter(fp);
	fclose(fp);

	return 0;
}

void addStringList(Node** lnode, char* string){
	Node* temp = newNodeString(string);
	appendNode(*lnode,temp);
	*lnode=temp;
}