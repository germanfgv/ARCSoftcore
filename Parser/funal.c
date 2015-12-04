#include "funal.h"


//Funciones Branches
int be(Node **node){
	int ir = 0;
	*node = (**node).next;
	char *str = (**node).val.sval;

	ir |= SET_BRA_FMT << OP;
	ir |= BE << COND;
	ir |= BRANCH << OP2;
	entry *ent;
	int val = getEntryKey(&symbols,str,&ent);
	if(val<0){
		printf("Error obteniendo ir para la funcion SETHI");
		return -1;
	}else{
		ir |= (*ent).value;
	}
	return 0;
}

int bcs(Node **node){
	int ir = 0;
	*node = (**node).next;
	char *str = (**node).val.sval;

	ir |= SET_BRA_FMT << OP;
	ir |= BCS << COND;
	ir |= BRANCH << OP2;
	int val = getEntryKey(&symbols,str,&ent);
	if(val<0){
		printf("Error obteniendo ir para la funcion SETHI");
		return -1;
	}else{
		ir |= (*ent).value;
	}
	return 0;
}

int bneg(Node **node){
	int ir = 0;
	*node = (**node).next;
	char *str = (**node).val.sval;

	ir |= SET_BRA_FMT << OP;
	ir |= BNEG << COND;
	ir |= BRANCH << OP2;
	int val = getEntryKey(&symbols,str,&ent);
	if(val<0){
		printf("Error obteniendo ir para la funcion SETHI");
		return -1;
	}else{
		ir |= (*ent).value;
	}
	return 0;
}

int bvs(Node **node){
	int ir = 0;
	*node = (**node).next;
	char *str = (**node).val.sval;

	ir |= SET_BRA_FMT << OP;
	ir |= BVS << COND;
	ir |= BRANCH << OP2;
	int val = getEntryKey(&symbols,str,&ent);
	if(val<0){
		printf("Error obteniendo ir para la funcion SETHI");
		return -1;
	}else{
		ir |= (*ent).value;
	}
	return 0;
}

int ba(Node **node){
	int ir = 0;
	*node = (**node).next;
	char *str = (**node).val.sval;

	ir |= SET_BRA_FMT << OP;
	ir |= BA << COND;
	ir |= BRANCH << OP2;
	int val = getEntryKey(&symbols,str,&ent);
	if(val<0){
		printf("Error obteniendo ir para la funcion SETHI");
		return -1;
	}else{
		ir |= (*ent).value;
	}
	return 0;
}
//Funcion set
int sethi(Node **node){
	int ir = 0;
	ir |= SET_BRA_FMT << OP;
	ir |= SETHI << OP2;
	*node = (**node).next;
	char *str = (**node).val.sval;
	while(strcmp(str,"\n")!=0){
		if(*str == '%'){
			ir |= rton(str) << RD;
		}else if((48<=*str) && (*str<=57)){
			ir |= atoi(str);
		}else{
			entry *ent;
			int val = getEntryKey(&symbols,str,&ent);
			if(val<0){
				printf("Error obteniendo ir para la funcion SETHI");
				return -1;
			}else{
				ir |= (*ent).value;
			}
		}
		*node = (**node).next;
		char *str = (**node).val.sval;		
	}
	return 0;
}

