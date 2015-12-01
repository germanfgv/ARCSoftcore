#MAKEFILE
FNAME=parser
LEX = flex 
YACC = bison -d
CC = gcc


$(FNAME).o: $(FNAME).tab.o lex.yy.o
	$(CC) -o $@ $(FNAME).tab.o lex.yy.o -lfl


$(FNAME).tab.o: lex.yy.c $(FNAME).tab.c
	$(CC) -c lex.yy.c $(FNAME).tab.c 

lex.yy.o: $(FNAME).tab.o


$(FNAME).tab.c: $(FNAME).y
	$(YACC)  $(FNAME).y

lex.yy.c: $(FNAME).l
	$(LEX) $(FNAME).l


.PHONY: clean

clean:
	rm -f *.o $(FNAME).tab* lex.yy.c *~