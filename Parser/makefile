#MAKEFILE


LEX = flex 
YACC = bison -d
CC = gcc


comp: y.tab.o lex.yy.o
	$(CC) -o comp parser_assembly.tab.o lex.yy.o -ll -lm 


lex.yy.o: lex.yy.c parser_assembly.tab.h
lex.yy.o parser_assembly.tab.o: comp.h


parser_assembly.tab.c parser_assembly.tab.h: parser_assembly.y
	$(YACC) -v parser_assembly.y

lex.yy.c: scan_assembly.l
	$(LEX) scan_assembly.l

clean:
	-rm -f *.o lex.yy.c *.tab.*  parser_assembly*.output
