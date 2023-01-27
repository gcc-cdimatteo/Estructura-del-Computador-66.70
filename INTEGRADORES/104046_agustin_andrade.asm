!Un programa declara un arreglo de 16 elementos de 32 bits no inicializados y guarda en la primera posición 
!de este arreglo la constante DB0321CCh. Luego invoca a una subrutina (cuyo código también se pide) a la cual 
!le pasa por stack la dirección de inicio del arreglo y su largo para que esta devuelva también por stack el 
!promedio de todos los valores contenidos en el arreglo. El programa principal copia este promedio en la 
!segunda posición del arreglo y termina.
!Programa principal y subrutina deben ser declarados en el mismo módulo

!como no me lo dice doy por supuesto que el enunciado utiliza numeros signados, de no ser asi deberia
!usar bcs para capturar un error de representacion y ademas usar srl en vez de sra
.begin
.org 2048

.macro push arg
	add %r14,-4,%r14
	st arg,%r14
.endmacro

.macro pop arg
	ld %r14,arg
	add %r14,4,%r14
.endmacro

add %r15,0,%r16	!back up %r15

array: .dwb 16

A	.equ BD032h
B	.equ 1CCh
sethi A,%r3
sll %r3,2,%r3
add %r3,B,%r3		!cargue la constante en r3

add %r0,array,%r1	!cargue en %r1 la direccion de inicio del array	

add %r0,64,%r2	!cargue en r2 el largo del array

add %r2,%r1,%r4	
add %r4,-4,%r4	!primer pos del array
st %r3,%r4		!cargo la cte en la primera pos del array

push %r1

push %r2

call calcular_promedio

pop %r10

add %r4,-4,%r4	!segunda pos del array
st %r10,%r4

jmpl %r16+4,%r0	!finaliza el programa

calcular_promedio:	pop %r5	!largo del array
			pop %r6	!dir d inicio del array
			add %r0,%r0,%r9	!suma parcial
			loop:	andcc %r5,%r5,%r0
				be devolver_promedio
				add %r5,-4,%r5
				add %r5,%r6,%r7
				ld %r7,%r8
				add %r9,%r8,%r9
				bvs error
				ba loop
error:		push %r0	!cuando se da un overflow en la suma devuelvo promedio=0
		jmpl %r15+4,%r0
devolver_promedio:	sra %r9,4,%r13
			push %r13
			jmpl %r15+4,%r0			

.end
