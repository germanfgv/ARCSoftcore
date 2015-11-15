#MAKEFILE


LEX = flex -I
YACC = bison -dv
CC = gcc


compilador: parser_assembly.tab.o lex.yy.o
	$(CC) -o compilador parser_assembly.tab.o lex.yy.o -ll
lex.yy.o parser_assembly.tab.o: 
	$(CC) -c lex.yy.c parser_assembly.tab.c 


# y-tab.h es el archivo de la definicion de los token
parser_assembly.tab.c parser_assembly.tab.h: parser_assembly.y
	$(YACC)  parser_assembly.y

#genera un archivo lex.yy.x el cual contiene codigo C del lexer
lex.yy.c: scan_assembly.l
	$(LEX) scan_assembly.l
