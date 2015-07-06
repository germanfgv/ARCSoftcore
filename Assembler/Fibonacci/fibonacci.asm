.begin
	z:		3072
	one:		1
	minus1:		-1
	almost:		2147483647
	max:		4294967295
	
	.org 2048
start:	ld [one], %r1
loop:	addcc %r1,%r2,%r1
      	st %r1, [z]
	addcc %r1,%r2,%r2
      	st %r2, [z]
	jmpl loop
	halt

	.end
