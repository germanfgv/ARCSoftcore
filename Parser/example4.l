%{

#include <string.h>
#include <stdio.h>	
#include "example4.tab.h"
void yyerror(const char* string);

int lineno=1;

void yyerror(const char* string){
	printf ("At line %d: %s --> %s\n", lineno, string, yytext) ;
}

%}

%option yylineno

%%

"!".*			{}
[ \r\t]+		{}

"."begin	{printf("START\n");return START;}
"."end		{printf("END\n"); return END;}
"."org		{printf("ORG\n"); return ORG;}


ld			{printf("LD\n"); return LD;}
add			{printf("ADD\n"); return ADD;}
addcc		{printf("ADDCC\n"); return ADDCC;}
st 			{printf("ST\n"); return ST;}


"%"r1    { printf("REG_R1\n"); return REG_R1;}
"%"r2    { printf("REG_R2\n"); return REG_R2;}
"%"r3    { printf("REG_R3\n"); return REG_R3;}
"%"r4    { printf("REG_R4\n"); return REG_R4;}
"%"r5    { printf("REG_R5\n"); return REG_R5;}
"%"r6    { printf("REG_R6\n"); return REG_R6;}
"%"r7    { printf("REG_R7\n"); return REG_R7;}
"%"r8    { printf("REG_R8\n"); return REG_R8;}
"%"r9    { printf("REG_R9\n"); return REG_R9;}
"%"r10   { printf("REG_R10\n"); return REG_R10;}
"%"r11   { printf("REG_R11\n"); return REG_R11;}
"%"r12   { printf("REG_R12\n"); return REG_R12;}
"%"r13   { printf("REG_R13\n"); return REG_R13;}
"%"r14   { printf("REG_R14\n"); return REG_R14;}
"%"r15   { printf("REG_R15\n"); return REG_R15;}


[_a-zA-Z][_a-zA-Z0-9]*		{printf("NAME\n");return NAME;}	
[0-9]+						{printf("INT\n"); return INT;}

","      { printf("COMMA\n");return COMMA; }
":"      { printf("COLON\n"); return COLON;}
";"      { printf("SEMICOLON\n"); return SEMICOLON;}
"["		 { printf("LEFT_SQ_BR\n"); return LEFT_SQ_BR;}
"]"		 { printf("RIGHT_SQ_BR\n"); return RIGHT_SQ_BR;}

\n 		 lineno++;
.        { yyerror("syntax error");}

%%

