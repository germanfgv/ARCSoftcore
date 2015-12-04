
#include "Node.h"

Node* newNode(void){
	Node* temp = (Node*)malloc(sizeof(struct Node));
	(*temp).next=NULL;
	(*temp).previous=NULL;

	return temp;
}

Node* newNodeString(char* string){
	Node* temp = newNode();
	(*temp).val.sval=string;
	(*temp).utype=STRING;
	return temp;
}

void appendNode(Node* nodet, Node* noden){
	(*nodet).next=noden;
	(*noden).previous=nodet;
}

void prependNode(Node* nodet, Node* nodep){
	(*nodet).previous=nodep;
	(*nodep).next=nodet;
}


