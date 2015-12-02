#include <stdio.h>
#include "templater_constants.h"

void main(){
    int IR=0;
    IR |= R1 << RS1 ;
    IR |= R2 << RS2;
    IR |= 0 << IBIT;
    IR |= ADDCC << OP3;
    IR |= R1 << RD;
    IR |= ARIT_FMT << OP;
    printf("%x \n",IR);
}