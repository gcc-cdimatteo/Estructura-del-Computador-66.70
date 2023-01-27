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

			addcc %r1, %r2, %r0		! sumo para revisar los flags
	
			bvs no_representable

			bvc representable

x: 			-2147483648
y:			-214748364

no_representable:	addcc %r3, -1, %r3
			jmpl %r15, 4, %r0

representable:		addcc %r3, %r0, %r3
			jmpl %r15, 4, %r0

.end
