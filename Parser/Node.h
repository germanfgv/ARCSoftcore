#ifndef NODELIB 
#define NODELIB

#include <stdlib.h>
#include <stddef.h>
#include <string.h>

#ifndef INT
#define INT 0x1
#endif

#ifndef FLOAT
#define FLOAT 0x2
#endif

#ifndef STRING
#define STRING 0x3
#endif

#ifndef NODE
#define NODE 0x4
#endif

typedef struct Node{
	int utype;
	union{
		int ival;
		float fval;
		char* sval;
	}val;
	struct Node * next;
	struct Node * previous;
}Node;


void appendNode(Node* nodet , Node* noden );

void prependNode(Node* nodet , Node* nodep );

Node* newNode(void);

Node* newNodeString(char* string);	

#endif