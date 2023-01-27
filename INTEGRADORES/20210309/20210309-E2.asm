!1. Un programa recibe por stack la direccion de inicio de un arreglo de 16 elementos no signados. 
!Debe calcular el promedio de todos los elementos pares y comunicar el resultado a un periférico 
!mapeado en la direccion B71300A1h.
!a) El promedio debe ser calculado por una subrutina
!b) El promedio debe ser calculado utilizando una macro

B      7       1       3       0       0       A       1   
1011  0111    0001    0011    0000    0000    1010    0001

22 bits mas altos: (00)10 1101 1100 0100 1100 0000b = 2DC4C0h
10 bits mas bajos: (00)00 1010 0001b = A1h

! uso de registros:
! r1 = direccion de inicio del arreglo
! r2 = índice del arreglo
! r3 = elemento actual del arreglo
! r4 = suma de elementos
! r5 = promedio
! r6 = dirección de periferico
tamanio_arreglo .equ 64 ! 16 elementos de 4 bytes

a) 
.begin
.org 2048

.macro push registro_fuente
    add %r14, -4, %r14
    st %registro_fuente, %r14
.endmacro

.macro pop registro_destino
    ld %r14, registro_destino
    add %r14, 4, %r14
.endmacro

main:
    call calcular_promedio              !ya tiene la dirección del inicio del arreglo en el stack
    pop %r5
    sethi 2DC4C0h, %r6
	or %r6, A1h, %r6
    st %r5, %r6
    ba fin

calcular_promedio:
    pop %r1					!baja r1 del stack, o sea la direccion del arreglo
    add %r0, %r0, %r2		!inicializa r2 y r4
    add %r0, %r0, %r4
while:
    subcc %r2, tamanio_arreglo, %r0			!si el indice es igual al tamaño del arreglo termina el loop
    be promedio
    ld %r1, %r2, %r3				! carga el sig. elemento en r3
    and %r3, 1, %r3			!chequea paridad
    bne es_impar                           
es_par:
    add %r4, %r3, %r4		!si es par hacé la suma y ponela en r4
es_impar:
    add %r2, 4, %r2			!si es impar incrementá el indic
    ba while
promedio:
    srl %r4, 4, %r5			!hace la división (recordar srl 4 = dividir entre 2^4)
    push %r5				!pone el promedio en r5
    jmpl %r15+4, %r0		!vuelve al programa original
fin:
.end






	
b) 

.begin
.org 2048

.macro push registro_fuente
    add %r14, -4, %r14
    st %registro_fuente, %r14
.endmacro

.macro pop registro_destino
    ld %r14, registro_destino
    add %r14, 4, %r14
.endmacro

.macro calcular_promedio inicio_arreglo registro_destino
    add %r0, %r0, %r2
    add %r0, %r0, %r4
while:
    subcc %r2, tamanio_arreglo, %r0
    be promedio
    ld inicio_arreglo, %r2, %r3
    and %r3, 1, %r3
    bne es_impar                           
es_par:
    add %r4, %r3, %r4
es_impar:
    add %r2, 4, %r2
    ba while
promedio:
    srl %r4, 4, registro_destino
.endmacro

main:
    pop %r1
    calcular_promedio %r1 %r5
    sethi 2DC4C0h, %r6
	or %r6, A1h, %r6
    st %r5, %r6
.end