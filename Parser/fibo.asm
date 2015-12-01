.begin
	z:		5004
	one:		1
	limit:		2584
	
	.org 2048
a_start .equ 3000
	ld [one], %r1
	ld [limit], %r3
SEC1:	addcc %r1,%r2,%r1
      	st %r1, [limit]
	ba SEC2
SEC2:	addcc %r1,%r2,%r2
	st %r2, [limit]	
	ba SEC1
	jmpl %r15 + 2048,%r1
	halt
	.end
 
