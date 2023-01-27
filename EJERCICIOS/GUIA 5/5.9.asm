.begin
	.org 2048
	ld [x], %r1			! cargo el valor de x en r1
	addcc %r14, -4, %r14		! muevo el puntero de la pila
	st %r1, %r14			! guardo el valor de x en el stack
	addcc %r14, 4, %r14		! dejo la pila como estaba
	ld %r0, %r1			! dejo r1 como estaba

	addcc %r14, -4, %r14		! muevo el puntero de la pila
	ld %r14, %r1			! cargo en r1 lo que hay en la primer posicion del stack
	addcc %r14, 4, %r14		! dejo la pila como estaba

	addcc %r1, %r0, %r0		! opero para ver si el numero es negativo

	bneg abs			! si es negativo, convierto a absoluto

	jmpl %r15, 4, %r0		!vuelvo

x:	-1

abs:	subcc %r0, %r1, %r1
	jmpl %r15, 4, %r0

.end
