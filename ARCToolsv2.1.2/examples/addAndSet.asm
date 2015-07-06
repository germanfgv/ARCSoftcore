.begin
	z:		5004
	one:		1
	two	:	2
	three:		3
	minus1:		-1
	almost:		2147483647
	max:		4294967295
	
	.org 2048
a_start .equ 3000
	ld [4096], %r1
	ld [two], %r2
	addcc %r1,%r2,%r3
      	st %r3, [z]
	jmpl %r15 + 2048,%r0
	halt

	.end
