.begin
.org 2048
	x:15
	y:3
	z:0	

prog: ld [x] , %r1 !Cargar x en el registro r1
      ld [y] , %r2 !Cargar y en el registro r2
      addcc %r1,%r2 ,%r3 !%r3 ← %r1 + %r2
      st %r3, [z] !Guardar el Resultado en z

	.end

