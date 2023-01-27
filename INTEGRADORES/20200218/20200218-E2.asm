!Un programa declara un arreglo de 32 palabras de 32 bits
!y carga en él las primeras 32 lecturas de un periférico que está 
!mapeado en la dirección C3101200h. Una vez finalidad esta tarea,
!invoca una subrutina que calcula su promedio. Luego devuelve el promedio por el stack y termina


! uso de registros:
! r1: dirección de inicio del arreglo
! r2: largo del arreglo en bytes, que servirá como indice del arreglo para iterar sobre los elementos
! r3: valor del elemento actual
! r5: acumulador de suma de elementos y luego también el promedio
! r16: dirección de backup de la dirección a la cual volver después de terminar el programa

    .begin

periferico_22 .equ 30c404h      ! los 22 bits mas significativos del periferico
periferico_10 .equ 200h         ! los 10 bits menos significativos del periferico 
tamanio_arreglo .equ 128        ! cantidad de bytes a leer es 32 palabras * 4 bytes por palabra = 128 bytes
arreglo: .dwb 32                ! declaración de un arreglo de 32 palabras de 32 bits

    .macro push registro_fuente
	add %r14, -4, %r14
	st registro_fuente, %r14
    .endmacro

    .macro pop registro_destino
	ld %r14, registro_destino
	add %r14, 4, %r14
    .endmacro


    .macro por_cada_elemento funcion    ! me hice el elegante haciendo una macro que le pasas por parametro una subrutina y la llama por cada elemento del arreglo.
                                        ! algo asi como un foreach. No hace falta hacerlo, pero queria ver si era posible, así no repetía codigo de loopear dos veces.
while:                          ! linea 40 y 41 conforman el chequeo de condición del while: mientras el índice sea menor o igual al último
    subcc %r2, 128, %r0         ! no me deja usar la constante asi que la uso como literal acá
    be end_while
    call funcion
    add %r2, 4, %r2             ! incremento el índice
    ba while                    ! ir a siguiente iteración del ciclo while
end_while:
    .endmacro

    .org 2048
start: ba main

lectura_periferico:
    ld %r1, %r3                 ! lectura de periferico
    st %r3, %r2, arreglo        ! guardo el valor leído en el arreglo
    jmpl %r15+4, %r0

suma_arreglo:
    ld arreglo, %r2, %r3       ! cargo el valor del arreglo en r3
    add %r3, %r5, %r5          ! sumo el valor del acumulador con el valor del arreglo
    jmpl %r15+4, %r0

main:
    add %r15, %r0, %r16
    sethi periferico_22, %r1    ! cargo la primer parte de la dirección del periferico usando sethi
    or %r1, periferico_10, %r1  ! cargo la segunda parte de la dirección del periferico usando or
    add %r0, 2, %r27
    st %r27, %r1
    add %r0, %r0, %r2           ! empiezo el indicie en 0
    por_cada_elemento lectura_periferico    ! llamo a la subrutina lectura_periferico para leer el periferico
    call promedio               ! llamo a la subrutina que calcula el promedio
    jmpl %r16+4, %r0            ! vuelvo a la dirección de inicio del programa

promedio:
    add %r0, %r0, %r2           ! empiezo el indicie en 0
    por_cada_elemento suma_arreglo          ! llamo a la subrutina suma_arreglo para sumar los valores del arreglo
    srl %r5, 5, %r5             ! cargo el valor del acumulador en r5
    push %r5
    jmpl %r16+4, %r0
fin: 
    .end
