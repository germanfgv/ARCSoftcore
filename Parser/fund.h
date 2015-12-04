#ifndef FUND
#define FUND

#include "templater_constants.h"
#include "Node.h"
#include "dictionary.h"
#include <stdio.h>

int inst_loc;
FILE * fp;

int var(Node **node);
//Prototipo
int org(Node **node);

int rton(char* reg);
int aricc(Node** node, int op);
int strtoinst(char* string);

int ld(Node **node);
int st(Node **node);

//Prototipos branches
int be(Node **node);
int bcs(Node **node);
int bneg(Node **node);
int bvs(Node **node);
int ba(Node **node);

//Prototipo set
int sethi(Node **node);

int printHeader(FILE* fp);
int printFooter(FILE* fp);



#endif
