#include "fund.h"
#include <stdio.h>
#include <stdlib.h>



/*=====================================*/
/*		         fund   				*/
/*=====================================*/
int rton(char* reg){
	return atoi(reg+2);
}


int aricc(Node** node, int op){
	int ir=0;
	ir|=TARIT_FMT<<TOP;
	ir|=op<<TOP3;
	char* str;
	entry* dEntry;
	
	*node=(**node).next;
	ir|=rton((**node).val.sval)<<TRS1;

	*node=(**node).next;
	str=(**node).val.sval;

	if(*str=='%'){
		
		ir|=rton(str);

	}else if(*str>=48 && *str<=57 ){
		
		ir|=atoi(str);
		ir|=1<<TIBIT;

	}else{
		if(getEntryKey(&symbols , str , &dEntry)){
			printf("La variable %s no ha sido definida.\n", str);
			printf("Error al obtener IR de la función ORCC\n");
			return 1;
		}else{
			ir|=(*dEntry).value;
			ir|=1<<TIBIT;
		}
	}

	*node=(**node).next;
	ir|=rton((**node).val.sval)<<TRD;

	*node=(**node).next;
	

	printf("		data%d=%X;\n", inst_loc ,ir );

	fprintf(fp,"		data%d=32'h%X;\n", inst_loc ,ir );

	return 0 ;

}

int strtoinst(char* string){
	if(!strcmp(string,"addcc")){
		return TADDCC;
	}else if(!strcmp(string,"andcc")){
		return TANDCC;
	}else if(!strcmp(string,"orcc")){
		return TORCC;
	}else if(!strcmp(string,"orncc")){
		return TORNCC;
	}else if(!strcmp(string,"srl")){
		return TSRL;
	}else if(!strcmp(string,"jumpl")){
		return TJMPL;
	}else{
		return -1;
	}

}


/*=====================================*/
/*		         fung   				*/
/*=====================================*/

int ld(Node **node){
	
	int ir=0;
	int num=1;
	entry *ent;
	*node=(**node).next;
	char *str=(**node).val.sval;

	ir|=TMEM_FMT<<TOP;
	ir|=TLD<<TOP3;

	while(strcmp(str,"\n")!=0){
		if(num==1){
			if(*str=='%'){
				int rs=rton(str);
				ir|=rs<<TRS1;			
			}else if(*str<=57 && *str>=48){
				int simm=atoi(str);
				ir|=1<<TIBIT;
				ir|=simm;
			}else if(getEntryKey(&symbols,str,&ent)<0){
				printf("Error\n");
				printf( "No hay entreda con la key \"%s\"\n",  str);
			}else{
				int simm=atoi(str);
				ir|=1<<TIBIT;
				ir|=(*ent).value;	
			}
			num++;
		}else if(num==2){
			if(*str=='%'){
				int rd=rton(str);
				ir|=rd<<TRD;			
			}else{
				printf("Error obteniendo IR para función LD. El argumento 2 debe ser un registro: %s\n",str);
				return -1;
			}
			num++;
		}else{
			printf("Error obteniendo IR para función LD. Más instrucciones de las necesarias\n");
			return -1;
		}
		*node=(**node).next;
		str=(**node).val.sval;
	}

	printf("		data%d=%X;\n",inst_loc,ir);
	fprintf(fp,"		data%d=32'h%X;\n",inst_loc,ir);
	return 0;
}


int st(Node **node){
	
	int ir=0;
	int num=1;
	entry *ent;
	*node=(**node).next;
	char *str=(**node).val.sval;

	ir|=TMEM_FMT<<TOP;
	ir|=TST<<TOP3;

	while(strcmp(str,"\n")!=0){
		if(num==2){
			if(*str=='%'){
				int rs=rton(str);
				ir|=rs<<TRS1;			
			}else if(*str<=57 && *str>=48){
				int simm=atoi(str);
				ir|=1<<TIBIT;
				ir|=simm;
			}else if(getEntryKey(&symbols,str,&ent)<0){
				printf("Error\n");
				printf( "No hay entreda con la key \"%s\"\n",  str);
			}else{
				int simm=atoi(str);
				ir|=1<<TIBIT;
				ir|=(*ent).value;	
			}
			num++;
		}else if(num==1){
			if(*str=='%'){
				int rd=rton(str);
				ir|=rd<<TRD;			
			}else{
				printf("Error obteniendo IR para función ST. Argumento 1 debe ser reg\n");
				return -1;
			}
			num++;
		}else{
			printf("Error obteniendo IR para función ST. Mas argumentos de los necesarios\n");
			return -1;
		}
		*node=(**node).next;
		str=(**node).val.sval;
	}
	
	printf("		data%d=%X;\n",inst_loc,ir);
	fprintf(fp,"		data%d=32'h%X;\n",inst_loc,ir);
	return 0;
}

/*=====================================*/
/*		         funa   				*/
/*=====================================*/

int be(Node **node){
	int ir = 0;
	*node = (**node).next;
	char *str = (**node).val.sval;
	entry *ent;


	ir |= TSET_BRA_FMT << TOP;
	ir |= TBE << TCOND;
	ir |= TBRANCH << TOP2;
	int val = getEntryKey(&symbols,str,&ent);
	if(val<0){
		printf("Error obteniendo ir para la funcion BE");
		return -1;
	}else{
		ir |= (*ent).value;
	}
	*node = (**node).next;
	
	printf("		data%d=%X;\n", ir);
	fprintf(fp,"		data%d=32'h%X;\n", ir);
	return 0;
}

int bcs(Node **node){
	int ir = 0;
	*node = (**node).next;
	char *str = (**node).val.sval;
	entry *ent;

	ir |= TSET_BRA_FMT << TOP;
	ir |= TBCS << TCOND;
	ir |= TBRANCH << TOP2;
	int val = getEntryKey(&symbols,str,&ent);
	if(val<0){
		printf("Error obteniendo ir para la funcion BCS");
		return -1;
	}else{
		ir |= (*ent).value;
	}

	*node = (**node).next;
	
	printf("		data%d=%X;\n", ir);
	fprintf(fp ,"		data%d=32'h%X;\n", ir);

	return 0;
}

int bneg(Node **node){
	int ir = 0;
	*node = (**node).next;
	char *str = (**node).val.sval;
	entry *ent;

	ir |= TSET_BRA_FMT << TOP;
	ir |= TBNEG << TCOND;
	ir |= TBRANCH << TOP2;
	int val = getEntryKey(&symbols,str,&ent);
	if(val<0){
		printf("Error obteniendo ir para la funcion BNEG");
		return -1;
	}else{
		ir |= (*ent).value;
	}
	*node = (**node).next;
	
	printf("		data%d=%X;\n", inst_loc , ir);
	fprintf(fp,"		data%d=32'h%X;\n", inst_loc , ir);

	return 0;
}

int bvs(Node **node){
	int ir = 0;
	*node = (**node).next;
	char *str = (**node).val.sval;
	entry *ent;

	ir |= TSET_BRA_FMT << TOP;
	ir |= TBVS << TCOND;
	ir |= TBRANCH << TOP2;
	int val = getEntryKey(&symbols,str,&ent);
	if(val<0){
		printf("Error obteniendo ir para la funcion BVS");
		return -1;
	}else{
		ir |= (*ent).value;
	}
	*node = (**node).next;
	
	printf("		data%d=%X;\n",inst_loc ,ir);
	fprintf(fp,"		data%d=32'h%X;\n",inst_loc ,ir);

	return 0;
}

int ba(Node **node){
	int ir = 0;
	*node = (**node).next;
	char *str = (**node).val.sval;
	entry *ent;

	ir |= TSET_BRA_FMT << TOP;
	ir |= TBA << TCOND;
	ir |= TBRANCH << TOP2;
	int val = getEntryKey(&symbols,str,&ent);
	if(val<0){
		printf("Error obteniendo ir para la funcion BA");
		return -1;
	}else{
		ir |= (*ent).value;
	}
	*node = (**node).next;
	
	printf("		data%d=%X;\n", inst_loc ,ir);
	fprintf(fp,"		data%d=32'h%X;\n", inst_loc ,ir);

	return 0;
}
//Funcion set
int sethi(Node **node){
	int ir = 0;
	ir |= TSET_BRA_FMT << TOP;
	ir |= TSETHI << TOP2;
	*node = (**node).next;
	char *str = (**node).val.sval;
	while(strcmp(str,"\n")!=0){
		if(*str == '%'){
			ir |= rton(str) << TRD;
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
		str = (**node).val.sval;		
	}
	*node = (**node).next;
	
	printf("		data%d=%X;\n", ir);
	fprintf(fp,"		data%d=32'h%X;\n;", ir);

	return 0;
}



int var(Node **node){
	int ir = 0;
	*node = (**node).next;
	char *str = (**node).val.sval;
	ir |= atoi(str);
	printf("		data%d=%X;\n",inst_loc,ir);
	fprintf(fp,"		data%d=32'h%X;\n",inst_loc,ir);
	*node = (**node).next;
	return 0;
}



int org(Node **node){
	*node = (**node).next;
	char *str = (**node).val.sval;
	inst_loc = atoi(str);
	*node = (**node).next;
	printf("		org=%d\n",inst_loc);
	return 0;
}


int printHeader(FILE* fp)
{
	fprintf(fp, "module main_memory(\n"
	"input [31:0] address,\n"
	"input [31:0] data_in,\n"
	"input 	clk,rst,\n"
	"	rd,\n"
	"	wr,\n"
	"output reg [31:0] data_out\n"
	");\n"
	"/* Declaración de registro de la main memory.\n Esta contener hasta 2³² registros. Para este\n" "ejemplo se utilizaran solo 32 registros*/\n"
	"reg [31:0]\n data0,data1,data2,data3,data4,data5,data6,data7,data8,data12,data16,data20,data2048,\n"
	"data2049,data2050,data2051,data2052,data2053,data2054,data2055,data2056,\n"
	"data2057,data2058,data2059,data2060,data2061,data2062,data2063,data2064,\n"
	"data2065,data2066,data2067,data2068,data2069,data2070,data2071,data2072,\n"
	"data2073,data2074,data2075,data2076,data2077,data2078,data2079,data2080,\n"
	"data2081,data2082,data2083,data2084,data2085,data2086,data2087,data2088,\n"
	"data2089,data2090,data2091,data2092,data2093,data2094,data2095,data2096,\n"
	"data2097,data2098,data2099,data2100,data2101,data2102,data2103,data2104,\n"
	"data2105,data2106,data2107,data2108,data2109,data2110,data2111,data2112,\n"
	"data2113,data2114,data2115,data2116,data2117,data2118,data2119,data2120;\n"
	"always@(posedge clk)\n"
	"begin\n"
	"if(rst)\n"
	"begin\n"
	"/*===========================================*/\n"
	"/*==============INICIO INSTRUCCIONES===========*/\n"
	"/*===========================================*/\n"
	"		data0=32'b10000001110000000010100000000000;\n");
   
   return 0;
}


int printFooter(FILE* fp){
	fprintf(fp,	"/*===========================================*/\n"
	"/*==============FIN INSTRUCCIONES===========*/\n"
	"/*===========================================*/\n"
	"end\n"
	"else if(wr)\n"
	"	case(address)\n"
	"	0:data0=data_in;\n"
	"	1:data1=data_in;\n"
	"	2:data2=data_in;\n"
	"	3:data3=data_in;\n"
	"	4:data4=data_in;\n"
	"	5:data5=data_in;\n"
	"	6:data6=data_in;\n"
	"	7:data7=data_in;\n"
	"	8:data8=data_in;\n"
	"	12:data12=data_in;\n"
	"	16:data16=data_in;\n"
	"	20:data20=data_in;\n"
	"	2048:data2048=data_in;\n"
	"	2049:data2049=data_in;\n"
	"	2050:data2050=data_in;\n"
	"	2051:data2051=data_in;\n"
	"	2052:data2052=data_in;\n"
	"	2053:data2053=data_in;\n"
	"	2054:data2054=data_in;\n"
	"	2055:data2055=data_in;\n"
	"	2056:data2056=data_in;\n"
	"	2057:data2057=data_in;\n"
	"	2058:data2058=data_in;\n"
	"	2059:data2059=data_in;\n"
	"	2060:data2060=data_in;\n"
	"	2061:data2061=data_in;\n"
	"	2062:data2062=data_in;\n"
	"	2063:data2063=data_in;\n"
	"	2064:data2064=data_in;\n"
	"	2065:data2065=data_in;\n"
	"	2066:data2066=data_in;\n"
	"	2067:data2067=data_in;\n"
	"	2068:data2068=data_in;\n"
	"	2069:data2069=data_in;\n"
	"	2070:data2070=data_in;\n"
	"	2071:data2071=data_in;\n"
	"	2072:data2072=data_in;\n"
	"	2073:data2073=data_in;\n"
	"	2074:data2074=data_in;\n"
	"	2075:data2075=data_in;\n"
	"	2076:data2076=data_in;\n"
	"	2077:data2077=data_in;\n"
	"	2078:data2078=data_in;\n"
	"	2079:data2079=data_in;\n"
	"	2080:data2080=data_in;\n"
	"	2081:data2081=data_in;\n"
	"	2082:data2082=data_in;\n"
	"	2083:data2083=data_in;\n"
	"	2084:data2084=data_in;\n"
	"	2085:data2085=data_in;\n"
	"	2086:data2086=data_in;\n"
	"	2087:data2087=data_in;\n"
	"	2088:data2088=data_in;\n"
	"	2089:data2089=data_in;\n"
	"	2090:data2090=data_in;\n"
	"	2091:data2091=data_in;\n"
	"	2092:data2092=data_in;\n"
	"	2093:data2093=data_in;\n"
	"	2094:data2094=data_in;\n"
	"	2095:data2095=data_in;\n"
	"	2096:data2096=data_in;\n"
	"	2097:data2097=data_in;\n"
	"	2098:data2098=data_in;\n"
	"	2099:data2099=data_in;\n"
	"	2100:data2100=data_in;\n"
	"	2101:data2101=data_in;\n"
	"	2102:data2102=data_in;\n"
	"	2103:data2103=data_in;\n"
	"	2104:data2104=data_in;\n"
	"	2105:data2105=data_in;\n"
	"	2106:data2106=data_in;\n"
	"	2107:data2107=data_in;\n"
	"	2108:data2108=data_in;\n"
	"	2109:data2109=data_in;\n"
	"	2110:data2110=data_in;\n"
	"	2111:data2111=data_in;\n"
	"	2112:data2112=data_in;\n"
	"	2113:data2113=data_in;\n"
	"	2114:data2114=data_in;\n"
	"	2115:data2115=data_in;\n"
	"	2116:data2116=data_in;\n"
	"	2117:data2117=data_in;\n"
	"	2118:data2118=data_in;\n"
	"	2119:data2119=data_in;\n"
	"	2120:data2120=data_in;\n"
	"	default:data0=data_in;\n"
	"	endcase\n"
	"end\n"
	"always@(posedge clk)\n"
	"begin\n"
	"if(rd)\n"
	"	case(address)\n"
	"	0:data_out=data0;\n"
	"	1:data_out=data1;\n"
	"	2:data_out=data2;\n"
	"	3:data_out=data3;\n"
	"	4:data_out=data4;\n"
	"	5:data_out=data5;\n"
	"	6:data_out=data6;\n"
	"	7:data_out=data7;\n"
	"	8:data_out=data8;\n"
	"	12:data_out=data12;\n"
	"	16:data_out=data16;\n"
	"	20:data_out=data20;\n"
	"	2048:data_out=data2048;\n"
	"	2049:data_out=data2049;\n"
	"	2050:data_out=data2050;\n"
	"	2051:data_out=data2051;\n"
	"	2052:data_out=data2052;\n"
	"	2053:data_out=data2053;\n"
	"	2054:data_out=data2054;\n"
	"	2055:data_out=data2055;\n"
	"	2056:data_out=data2056;\n"
	"	2057:data_out=data2057;\n"
	"	2058:data_out=data2058;\n"
	"	2059:data_out=data2059;\n"
	"	2060:data_out=data2060;\n"
	"	2061:data_out=data2061;\n"
	"	2062:data_out=data2062;\n"
	"	2063:data_out=data2063;\n"
	"	2064:data_out=data2064;\n"
	"	2065:data_out=data2065;\n"
	"	2066:data_out=data2066;\n"
	"	2067:data_out=data2067;\n"
	"	2068:data_out=data2068;\n"
	"	2069:data_out=data2069;\n"
	"	2070:data_out=data2070;\n"
	"	2071:data_out=data2071;\n"
	"	2072:data_out=data2072;\n"
	"	2073:data_out=data2073;\n"
	"	2074:data_out=data2074;\n"
	"	2075:data_out=data2075;\n"
	"	2076:data_out=data2076;\n"
	"	2077:data_out=data2077;\n"
	"	2078:data_out=data2078;\n"
	"	2079:data_out=data2079;\n"
	"	2080:data_out=data2080;\n"
	"	2081:data_out=data2081;\n"
	"	2082:data_out=data2082;\n"
	"	2083:data_out=data2083;\n"
	"	2084:data_out=data2084;\n"
	"	2085:data_out=data2085;\n"
	"	2086:data_out=data2086;\n"
	"	2087:data_out=data2087;\n"
	"	2088:data_out=data2088;\n"
	"	2089:data_out=data2089;\n"
	"	2090:data_out=data2090;\n"
	"	2091:data_out=data2091;\n"
	"	2092:data_out=data2092;\n"
	"	2093:data_out=data2093;\n"
	"	2094:data_out=data2094;\n"
	"	2095:data_out=data2095;\n"
	"	2096:data_out=data2096;\n"
	"	2097:data_out=data2097;\n"
	"	2098:data_out=data2098;\n"
	"	2099:data_out=data2099;\n"
	"	2100:data_out=data2100;\n"
	"	2101:data_out=data2101;\n"
	"	2102:data_out=data2102;\n"
	"	2103:data_out=data2103;\n"
	"	2104:data_out=data2104;\n"
	"	2105:data_out=data2105;\n"
	"	2106:data_out=data2106;\n"
	"	2107:data_out=data2107;\n"
	"	2108:data_out=data2108;\n"
	"	2109:data_out=data2109;\n"
	"	2110:data_out=data2110;\n"
	"	2111:data_out=data2111;\n"
	"	2112:data_out=data2112;\n"
	"	2113:data_out=data2113;\n"
	"	2114:data_out=data2114;\n"
	"	2115:data_out=data2115;\n"
	"	2116:data_out=data2116;\n"
	"	2117:data_out=data2117;\n"
	"	2118:data_out=data2118;\n"
	"	2119:data_out=data2119;\n"
	"	2120:data_out=data2120;\n"
	"	default:data_out=data0;\n"
	"	endcase\n"
	"end\n"
	"endmodule");
return 0;
}


