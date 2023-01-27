.begin
			.org 2048
			ld [x], %r1			! cargo el valor de x en r1
			addcc %r14, -4, %r14		! muevo el puntero de la pila
			st %r1, %r14			! guardo el valor de x en el stack
			ld [y], %r2			! cargo el valor de y en r2
			addcc %r14, -4, %r14		! muevo el puntero de la pila
			st %r2, %r14			! guardo el valor de y en el stack
			addcc %r14, 8, %r14		! dejo la pila como estaba
			ld %r0, %r1			! dejo r1 como estaba
			ld %r0, %r2			! dejo r2 como estaba

			addcc %r14, -4, %r14		! muevo el puntero de la pila
			ld %r14, %r1			! cargo en r1 lo que hay en la primer posicion del stack
			addcc %r14, -4, %r14		! muevo el puntero de la pila
			ld %r14, %r2			! cargo en r2 lo que hay en la segunda posicion del stack
			addcc %r14, 8, %r14		! dejo la pila como estaba

			st %r1, %r10
			st %r2, %r11
			
			call multiplicar		! r10 * r11 -> r3

			st %r3, [z]

			ld %r0, %r15
			jmpl %r15, 4, %r0

x: 			2
y:			-3
z:			0

multiplicar:		andcc %r1, %r1, %r0		! r1 ?= r0
			
			be break

			bne continue

break:			jmpl %r15, 4, %r0

continue:		addcc %r3, %r2, %r3		! r3 + r2 -> r3
			
			addcc %r1, %r0, %r0		! r1 + r0 -> r0 para ver si es positivo o negativo

				bneg es_negativo

				bpos es_positivo
			
			jmpl %r15, %r0, %r0

es_negativo:		addcc %r1, 1, %r1		! r1 + 1 -> r1
			jmpl %r15, %r0, %r0

es_positivo:		addcc %r1, -1, %r1		! r1 - 1 -> r1
			jmpl %r15, %r0, %r0

.end
