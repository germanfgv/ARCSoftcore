#MAKEFILE
CC = gcc


test: dictionary.c dictionary.h test.c
	$(CC) -o $@.o test.c dictionary.c

clean:
	rm -f *.o