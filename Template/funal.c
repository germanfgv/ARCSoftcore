int branch(Node **node);

int branch(Node **node){
    *node = (**node).next;
    char *str = (**node).val.sval;
    
    ir |= SET_BRA_FMT << OP;
    ir |=  << COND;
    ir |= BRANCH << OP2;
    ir |= ;
    
    while(strcmp(str,"\n")!=0){
        
    }
}
