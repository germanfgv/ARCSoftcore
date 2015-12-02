#include "dictionary.h"

int8_t addEntry(dict *dic, entry *ne){
	int i=0;
	int n_entries=(*dic).n_entries;

	(*ne).idx=n_entries;
	if(n_entries==0){
		(*dic).first=ne;
		(*dic).n_entries++;
		return 0;
	}

	entry (*act)= (*dic).first;
	
	for(i=0;i < n_entries-1;i++){
		act=(*act).next;
	}

	(*act).next=ne;
	(*dic).n_entries++;
	return 0;
}

int8_t getEntryIdx(dict *dic, int32_t idx, entry **ent){
	int i=0;

	if(idx+1>(*dic).n_entries){
		return -1;
	}

	entry *act= (*dic).first;

	for(i=0;i<idx;i++){
		act=(*act).next;
	}

	*ent=act;
	return 0;
}

int8_t getEntryKey(dict *dic, char *key, entry **ent){
	int i=0;
	int nfound=-1;						//nfound=0 -> no se ha encontrado entrada buscada
										//nfound=1 -> no se ha encontrado entrada buscada
	int n_entries=(*dic).n_entries;

	if(n_entries==0){
		printf("No hay entradas en el diccionario. (En funcion getEntryKey\n");
		return -1;
	}

	entry *act= (*dic).first;

	for(i=0;i<n_entries;i++){

		if(strcmp((*act).key,key)==0){
			nfound=0;
			break;
		}
		act=(*act).next;
	}

	*ent=act;
	return nfound;
}

