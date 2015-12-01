%{

#include <string.h>
#include <stdio.h>	
#include "parser.tab.h"
void yyerror(const char* string);

int lineno=1;
void yyerror(const char* string){
	 printf("At line %d: %s --> %s\n", lineno, string, yytext) ;
}


%}

%option yylineno
%s P

%%

"!".*			{}

[ \r\t]+		{}

"."begin	{ BEGIN P ; return START;}
<P>"."end		{ BEGIN 0; return END;}
<P>"."org		{ return ORG;}
<P>ld			{ return LD;}
<P>add			{ return ADD;}
<P>addcc		{ return ADDCC;}
<P>st 			{ return ST;}


<P>"%"r1    { return REG_R1;}
<P>"%"r2    { return REG_R2;}
<P>"%"r3    {  return REG_R3;}
<P>"%"r4    {  return REG_R4;}
<P>"%"r5    {  return REG_R5;}
<P>"%"r6    {  return REG_R6;}
<P>"%"r7    {  return REG_R7;}
<P>"%"r8    {  return REG_R8;}
<P>"%"r9    {  return REG_R9;}
<P>"%"r10   {  return REG_R10;}
<P>"%"r11   {  return REG_R11;}
<P>"%"r12   {  return REG_R12;}
<P>"%"r13   {  return REG_R13;}
<P>"%"r14   {  return REG_R14;}
<P>"%"r15   {  return REG_R15;}


<P>[_a-zA-Z][_a-zA-Z0-9]*		{return NAME;}	
<P>[0-9]+						{ return P_INT;}
<P>-[0-9]+						{ return N_INT;}


<P>","      { return COMMA; }
<P>":"      {  return COLON;}
<P>";"      {  return SEMICOLON;}
<P>"["		 {  return LEFT_SQ_BR;}
<P>"]"		 {  return RIGHT_SQ_BR;}
<P>.        { yyerror("Unknown character or expression.");}

\n 		 {lineno++;return '\n';}
. 		 { yyerror("Syntax Error , no code is allowed outside .begin and .end."); return 1;}


%%

