%{

#include "parser_assembly.tab.h"
#include <string.h>

int lineno =1;
void yyerror(char* s);

%}

%e 1200

%%

"!".*			{}
[ \r\t]+		{}



"."org		{return ORG;}
ld		{return LD;}
add		{return ADD;}
addcc		{return ADDCC;}
st 		{return ST;}
r1    { return REG_R1; }
r2    { return REG_R2; }
r3    { return REG_R3; }
r4    { return REG_R4; }
r5    { return REG_R5; }
r6    { return REG_R6; }
r7    { return REG_R7; }
r8    { return REG_R8; }
r9    { return REG_R9; }
r10   { return REG_R10; }
r11   { return REG_R11; }
r12   { return REG_R12; }
r13   { return REG_R13; }
r14   { return REG_R14; }
r15   { return REG_R15; }

[_a-zA-Z][_a-zA-Z0-9]*		{return NAME;}	
[0-9]+						{return INT;}

","      { return COMMA; }
":"      { return COLON; }
";"      { return SEMICOLON; }
"["	{ return LEFT_SQ_BR;}
"]"	{ return RIGHT_SQ_BR;}

\n 		 lineno++;
.        { yyerror("syntax error");}

%%

void yyerror(char* s){
	printf ("%d: %s at %s\n", lineno, s, yytext) ;
}

void main(int argc, char const *argv[]){

	if(argc > 1 && (yyin = fopen(argv[1], "r")) == NULL){
		perror (argv[1]);
		exit (1);
	}

	if(!yyparse()){
		printf("Assembler worked\n");
	}else{
		printf("Assembler failed\n");
	}
}