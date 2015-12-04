!Suma de elementos en un arreglo
!REGISTROS : %r1- # De bytes restantes a sumar del arreglo. Cada palabra(int) es de 32 bits.
!	     %r2- Dirección inicial del arreglo a
!	     %r3- Suma parcial (Acumulador)
!	     %r4- Apuntador del elemento seleccionado en el arreglo a
!	     %r5- Alamacena un elemento del arreglo a
.begin
.org 2048          		   !Comienza el posicionamiento de instrucciones en la dirección 2048 de memoria
a_start 	.equ 3000   	   !Dirección del arreglo a en memoria
		ld [length],%r1	   !%r1 ←length del arreglo a
		ld [address],%r2   !%r2 ← Dirección del arreglo a
		andcc %r3,%r0,%r3  !%r3 ←0 .Inicializar el registro acumulador %r3 en cero.
loop:		andcc %r1,%r1,%r0  !Prueba de elementos restantes.(Pasar el valor almacenado en %r1(# de bytes restantes) por la ALU actualizando banderas)
		be  done	   !Realizar salto a subrutina done para la culminación del algoritmo si el # de bytes restantes es 0.
		addcc %r1,-4,%r1   !Disminuir el # de bytes restantes por 4.
		addcc %r1,%r2,%r4  !Cálculo de la dirección en memoria del elemento a sumar.
		ld    %r4,%r5	   !Cargar el elemento a sumar en %r5
		addcc %r3,%r5,%r3  !Sumar el elemento seleccionado con el acumulado de la suma.
		ba loop            !Recomenzar el loop
done: 		st %r3,[4096] 	   !Salto a siguiente rutina almacenada en memoria principal.
inf:		ba inf 		
length: 	20	           !Largo del arreglo de números a sumar.
address:	a_start		   !Dirección de inicio del arreglo. Se posiciona s
		.org a_start
a:27
-10
45
-18
6
.end 


