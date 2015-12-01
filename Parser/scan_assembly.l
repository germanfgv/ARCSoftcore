%{

/*#include "y.tab.h"*/
#include <string.h>

int lineno =1;
void yyerror(char* string);

%}

%e 1200

%%

"!".*			{}
[ \r\t]+		{}

"."begin	{printf("BEGIN\n");}
"."end		{printf("END\n");}
"."org		{printf("ORG\n");}


ld			{printf("LD\n");}
add			{printf("ADD\n");}
addcc		{printf("ADDCC\n");}
st 			{printf("ST\n");}


"%"r1    { printf("REG_R1\n"); }
"%"r2    { printf("REG_R2\n"); }
"%"r3    { printf("REG_R3\n"); }
"%"r4    { printf("REG_R4\n"); }
"%"r5    { printf("REG_R5\n"); }
"%"r6    { printf("REG_R6\n"); }
"%"r7    { printf("REG_R7\n"); }
"%"r8    { printf("REG_R8\n"); }
"%"r9    { printf("REG_R9\n"); }
"%"r10   { printf("REG_R10\n"); }
"%"r11   { printf("REG_R11\n"); }
"%"r12   { printf("REG_R12\n"); }
"%"r13   { printf("REG_R13\n"); }
"%"r14   { printf("REG_R14\n"); }
"%"r15   { printf("REG_R15\n"); }


[_a-zA-Z][_a-zA-Z0-9]*		{printf("NAME\n");}	
[0-9]+						{printf("INT\n");}

","      { printf("COMMA\n"); }
":"      { printf("COLON\n"); }
";"      { printf("SEMICOLON\n"); }
"["		 { printf("LEFT_SQ_BR\n");}
"]"		 { printf("RIGHT_SQ_BR\n");}

\n 		 lineno++;
.        { yyerror("syntax error\n");}

%%

void yyerror(char* string){
	printf ("%d: %s at %s\n", lineno, string, yytext) ;
}

void main(int argc, char const *argv[]){

	if (argc!=2){
		printf("El número de parámetros ingresado no es el correcto.\n" 
			"Debe ingresar el nombre del archivo a analizar\n");
		exit(1);
	}else if((yyin = fopen(argv[1], "r\n")) == NULL){
		printf("El archivo ingresado por parámetro no existe.\n");
		perror (argv[1]);
		exit (1);
	}

	/*if(!yyparse()){
		printf("Assembler worked\n\n");
	}else{
		printf("Assembler failed\n\n");
	}*/
}