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

