#ifndef TEMPLATE
#define TEMPLATE 

/* Constantes de formato de instruccion */
#define TSET_BRA_FMT 0
#define TCALL_FMT 1
#define TARIT_FMT 2
#define TMEM_FMT 3

/* Constantes de OP2 */
#define TBRANCH 2
#define TSETHI 4

/* Constantes de op3 */
#define TLD 0
#define TST 4
#define TADDCC 16
#define TANDCC 17
#define TORCC  18
#define TORNCC 22
#define TSRL 38
#define TJMPL 56

/* Constantes de branchs */
#define TBE 1
#define TBCS 5
#define TBNEG 6
#define TBVS 7
#define TBA 8

/* Constantes de corrimientos */
#define TOP 30
#define TRD 25
#define TOP2 22
#define TCOND 25
#define TOP3 19
#define TRS1 14
#define TIBIT 13
#define TRS2 0

#endif