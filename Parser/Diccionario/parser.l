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

"."begin	{ BEGIN P ;}
<P>"."end	{ BEGIN 0;}
<P>"."org	{ return ORG;}
<P>"."equ	{ return EQU;}

<P>halt		{ return HALT;}
<P>nop		{ return NOP;}


<P>ld		{ return LD;}
<P>st 		{ return ST;}


<P>add		{ return ADD;}
<P>addcc	{ return ADDCC;}
<P>srl		{ return SRL;}
<P>sll		{ return SLL;}
<P>sra		{ return SRA;}

<P>and		{ return AND;}
<P>andcc	{ return ANDCC;}
<P>or 		{ return OR;}
<P>orcc		{ return ORCC;}



<P>be		{ return BE;}
<P>bne		{ return BNE;}
<P>bcs		{ return BCS;}
<P>bcc		{ return BCC;}
<P>bneg		{ return BNEG;}
<P>bpos		{ return BPOS;}
<P>bvs		{ return BVS;}
<P>bvc		{ return BVC;}
<P>ba		{ return BA;}
<P>jmpl		{ return JMPL;}
<P>call		{ return CALL;}



<P>"%"r1    { return REG_R1;}
<P>"%"r2    { return REG_R2;}
<P>"%"r3    { return REG_R3;}
<P>"%"r4    { return REG_R4;}
<P>"%"r5    { return REG_R5;}
<P>"%"r6    { return REG_R6;}
<P>"%"r7    { return REG_R7;}
<P>"%"r8    { return REG_R8;}
<P>"%"r9    { return REG_R9;}
<P>"%"r10   { return REG_R10;}
<P>"%"r11   { return REG_R11;}
<P>"%"r12   { return REG_R12;}
<P>"%"r13   { return REG_R13;}
<P>"%"r14   { return REG_R14;}
<P>"%"r15   { return REG_R15;}


<P>[_a-zA-Z][_a-zA-Z0-9]*		{ strcpy(yylval.str,yytext); return NAME;}	
<P>[0-9]+				{ yylval.str=(yytext); return P_INT;}
<P>-[0-9]+				{ yylval.str=(yytext); return N_INT;}


<P>","     	{ return COMMA; }
<P>":"     	{  return COLON; }
<P>";"     	{  return SEMICOLON; }
<P>"["		{  return LEFT_SQ_BR; }
<P>"]"		{  return RIGHT_SQ_BR; }
<P>"+"		{ return PLUS;}
<P>.        { yyerror("Unknown character or expression.");}

\n 		 {lineno++;return '\n';}
. 		 { yyerror("Syntax Error , no code is allowed outside .begin and .end."); 	return 1;}


%%

