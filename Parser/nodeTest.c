#include "Node.h"
#include <stdio.h>

int main(int argc, char const *argv[])
{
	Node* p=newNode();
	Node* current=p;
	(*current).utype=INT;
	(*current).val.ival=0;
	int i;
	for (i = 1; i < 10; ++i){
		Node* next=newNode();
		(*next).utype=INT;
		(*next).val.ival=i;
		appendNode(current,next);
		current=next;
	}

	current=p;
	while(current!=NULL){
		printf("%d\n",(*current).val.ival);
		current=(*current).next;
	}

	return 0;
}