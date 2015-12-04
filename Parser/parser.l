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

"."begin		{ BEGIN P ;}
<P>"."end		{ BEGIN 0; }
<P>"."org		{ yylval.str=strdup(yytext); return ORG;}
<P>"."equ		{ yylval.str=strdup(yytext); return EQU;}

<P>halt			{ yylval.str=strdup(yytext); return HALT;}
<P>nop			{ yylval.str=strdup(yytext); return NOP;}


<P>ld			{ yylval.str=strdup(yytext); return LD;}
<P>st 			{ yylval.str=strdup(yytext); return ST;}


<P>add			{ yylval.str=strdup(yytext); return ADD;}
<P>addcc		{ yylval.str=strdup(yytext); return ADDCC;}
<P>srl			{ yylval.str=strdup(yytext); return SRL;}
<P>sll			{ yylval.str=strdup(yytext); return SLL;}
<P>sra			{ yylval.str=strdup(yytext); return SRA;}

<P>and			{ yylval.str=strdup(yytext); return AND;}
<P>andcc		{ yylval.str=strdup(yytext); return ANDCC;}
<P>or 			{ yylval.str=strdup(yytext); return OR;}
<P>onrcc		{ yylval.str=strdup(yytext); return ORNCC;}
<P>orcc			{ yylval.str=strdup(yytext); return ORCC;}



<P>be			{ yylval.str=strdup(yytext); return BE;}
<P>bne			{ yylval.str=strdup(yytext); return BNE;}
<P>bcs			{ yylval.str=strdup(yytext); return BCS;}
<P>bcc			{ yylval.str=strdup(yytext); return BCC;}
<P>bneg			{ yylval.str=strdup(yytext); return BNEG;}
<P>bpos			{ yylval.str=strdup(yytext); return BPOS;}
<P>bvs			{ yylval.str=strdup(yytext); return BVS;}
<P>bvc			{ yylval.str=strdup(yytext); return BVC;}
<P>ba			{ yylval.str=strdup(yytext); return BA;}
<P>jmpl			{ yylval.str=strdup(yytext); return JMPL;}
<P>call			{ yylval.str=strdup(yytext); return CALL;}
<P>sethi		{ yylval.str=strdup(yytext); return SETHI;}


<P>"%"r0    { yylval.str=strdup(yytext); return REG_R0;}
<P>"%"r1    { yylval.str=strdup(yytext); return REG_R1;}
<P>"%"r2    { yylval.str=strdup(yytext); return REG_R2;}
<P>"%"r3    { yylval.str=strdup(yytext); return REG_R3;}
<P>"%"r4    { yylval.str=strdup(yytext); return REG_R4;}
<P>"%"r5    { yylval.str=strdup(yytext); return REG_R5;}
<P>"%"r6    { yylval.str=strdup(yytext); return REG_R6;}
<P>"%"r7    { yylval.str=strdup(yytext); return REG_R7;}
<P>"%"r8    { yylval.str=strdup(yytext); return REG_R8;}
<P>"%"r9    { yylval.str=strdup(yytext); return REG_R9;}
<P>"%"r10   { yylval.str=strdup(yytext); return REG_R10;}
<P>"%"r11   { yylval.str=strdup(yytext); return REG_R11;}
<P>"%"r12   { yylval.str=strdup(yytext); return REG_R12;}
<P>"%"r13   { yylval.str=strdup(yytext); return REG_R13;}
<P>"%"r14   { yylval.str=strdup(yytext); return REG_R14;}
<P>"%"r15   { yylval.str=strdup(yytext); return REG_R15;}


<P>[_a-zA-Z][_a-zA-Z0-9]*		{yylval.str=strdup(yytext); return NAME;}	
<P>[0-9]+				{ yylval.str=strdup(yytext); return P_INT;}
<P>-[0-9]+				{ yylval.str=strdup(yytext); return N_INT;}


<P>","      { return COMMA; }
<P>":"     	{ return COLON;}
<P>";"      { return SEMICOLON;}
<P>"["		{ return LEFT_SQ_BR;}
<P>"]"		{ return RIGHT_SQ_BR;}
<P>"+"		{ return PLUS;}
<P>.        { yyerror("Unknown character or expression.");}

\n 		 {lineno++;return '\n';}
. 		 { yyerror("Syntax Error , no code is allowed outside .begin and .end."); 	return 1;}


%%

