#include "dictionary.h"

int main(){
	int i;
	char *str="0";
	printf("Declarando dict\n");
	dict test;
	test.first=NULL;
	test.n_entries=0;

	printf("Declarando entry\n");

	for(i=0;i<9;i++){
		entry *ne =malloc(sizeof(entry));
		str =malloc(3*sizeof(char));
		str[0] = 'k';
		str[1] = (char)(48+i);
		str[2] = '\n';


		(*ne).key = str;
		(*ne).value = i;
		printf("agregando entry\n");
		addEntry(&test,ne);
	}

	printf("obteniendo entry\n");
	entry *ent;

	for(i=0;i<15;i++){
		if(getEntryIdx(&test,i,&ent)<0){
			printf("Error\n");
			printf("size: %d\n",test.n_entries );
		}else{
			printf("Printing\n");
			printf("value is: %d\n",(*ent).value );
			printf("idx is: %d\n",(*ent).idx );	
			printf("key is: %s\n", (*ent).key );	

		}
	}

}