/* Constantes de formato de instruccion */
#define SET_BRA_FMT 0
#define CALL_FMT 1
#define ARIT_FMT 2
#define MEM_FMT 3

/* Constantes de OP2 */
#define BRANCH 2
#define SETHI 4

/* Constantes de op3 */
#define LD 0
#define ST 4
#define ADDCC 16
#define ANDCC 17
#define ORCC  18
#define ORNCC 22
#define SRL 38
#define JMPL 56

/* Constantes de branchs */
#define BE 1
#define BCS 5
#define BNEG 6
#define BVS 7
#define BA 8

/* Constantes de corrimientos */
#define OP 30
#define RD 25
#define OP2 22
#define COND 25
#define OP3 19
#define RS1 14
#define IBIT 13
#define RS2 0

/* Constantes de registros */
#define R0 0
#define R1 1
#define R2 2
#define R3 3
#define R4 4
#define R5 5
#define R6 6
#define R7 7
