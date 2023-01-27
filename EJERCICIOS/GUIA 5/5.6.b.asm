.begin
	.org 2048
	ld [x], %r1		! cargo el valor de x en r1
	addcc %r14, -4, %r14	! muevo el puntero de la pila
	st %r1, %r14		! guardo el contenido de r1 en la pila
	ld [y], %r2		! cargo el valor de y en r2
	addcc %r14, -4, %r14	! muevo el puntero de la pila
	st %r2, %r14		! guardo el contenido de r2 en la pila
	addcc %r14, 8, %r14	! devuelvo el puntero de la pila a su posicion original
	call suma
	ld %r14, %r3		! cargo el contenido del puntero de la pila en r3
	st %r3, [z]		! guardo el contenido de r3 en z
	addcc %r14, 8, %r14	! devuelvo el puntero de la pila a su posicion original
	ld %r0, %r15
	jmpl %r15, 4, %r0
x:	2
y:	3
z:	0
suma:	addcc %r14, -4, %r14	! muevo el puntero de la pila para obtener x
	ld %r14, %r10		! cargo el contenido del puntero de la pila en r10
	addcc %r14, -4, %r14	! muevo el puntero de la pila para obtener y
	ld %r14, %r11		! cargo el contenido del puntero de la pila en r11
	addcc %r10, %r11, %r12	! r10 + r11 -> r12
	st %r12, %r14		! guardo el contenido de la suma en el puntero de la pila
	jmpl %r15, 4, %r0
.end
	
