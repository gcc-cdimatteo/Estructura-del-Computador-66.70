!Un programa recibe por stack la dirección de inicio y largo de un arreglo. Se sabe que
!este arreglo está conformado por elementos en punto fijo con 4 bits para la parte
!fraccionaria. El programa debe obtener la suma de todos los elementos cuya parte
!entera es nula y escribir este resultado en un periférico mapeado en la dirección
!BAD00132h. Para verificar si cada elemento cumple con la condición indicada se debe
!pasar el mismo a una rutina por via stack devolviendo esta también por stack un 1 si a
!condición se cumple o un 0 si no se cumple. Subrutina y programa principal está en el
!mismo módulo

! uso de registros:
! r1: dirección de inicio del arreglo
! r2: largo del arreglo en bytes, que servirá como indice del arreglo para iterar sobre los elementos
! r3: valor del elemento actual
! r4: valor del elemento actual temporal y también resultado de la subrutina que se fija si la parte entera es nula
! r5: acumulador de suma de elementos con parte entera nula
! r16: dirección de backup de la dirección a la cual volver después de terminar el programa

    .begin

periferico .equ BAD00132h

    .macro push registro_fuente
	add %r14, -4, %r14
	st registro_fuente, %r14
    .endmacro

    .macro pop registro_destino
	ld %r14, registro_destino
	add %r14, 4, %r14
    .endmacro

    .org 2048
main: !solo precarga el stack para simular el problema
    add %r0, fin, %r15          ! pongo la dirección desde la cual se llama al programa (en etiqueta fin, para simular que desde ahí se llama)
    add %r0, 4000, %r14         ! pongo la dirección inicial del stack en 4000
    ld [largo_arreglo], %r1     !   ->
    add %r0, inicio_arreglo, %r2!   ->
    push %r1                    !   -> pongo en el stack los parametros de entrada del programa
    push %r2                    !   ->
    call prog                   ! llamo al programa que me pidieron
    ba fin

prog:
    pop %r1                     ! muevo del stack al registro la direccion de inicio del array
    pop %r2                     ! muevo del stack al registro el largo del arreglo en bytes
    add %r0, %r0, %r5           ! inicializo el acumulador de suma a 0
    add %r0, %r15, %r16         ! guardo la dirección a la cual volver al finalizar el programa

loop:
    subcc %r2, 4, %r2           ! reduzco el largo del arreglo en 4 bytes
    bneg loop_end               ! si el largo del array es negativo, termino el ciclo              
    ld %r1, %r2, %r3            ! guardo el siguiente elemento del arreglo en el registro
    push %r3                    ! guardo %r3 en la pila
    call parte_entera_es_nula   ! llamo a la subrutina que verifica si la parte entera del elemento es nula
    pop %r4                     ! obtengo el valor devuelto por la subrutina
    andcc %r4, %r4, %r0         ! activo los flags para saber el resultado del valor returnado por la subrutina
    be loop                     ! el valor es 0, sigo con el ciclo sin sumar el elemento
    add %r5, %r3, %r5           ! el valor es 1, sumo el elemento al acumulador
    ba loop                     ! sigo con el ciclo habiendo sumado el elemento al acumulador
loop_end:
    jmpl %r16 + 4, %r0          ! vuelvo al lugar desde el cual llamaron a mi programa

parte_entera_es_nula: 
    pop %r4                     ! guardo el numero de punto fijo en %r4
    srl %r4, 4, %r4             ! desplazo el numero de punto fijo 4 bits a la derecha
    orcc %r4, 0, %r4            ! verifico si la parte entera del numero es nula
    bne parte_entera_no_es_nula ! si no es nula, salta a parte_entera_no_es_nula
    add %r0, 1, %r4             ! si es nula, guardo 1 en %r4
    push %r4                    ! agrego %r4 a la pila
    jmpl %r15 +4, %r0           ! retorna a la subrutina que realizó el llamado

parte_entera_no_es_nula:
    push %r0                    
    jmpl %r15 +4, %r0           ! retorna a la subrutina que realizó el llamado con 0

largo_arreglo: 40
inicio_arreglo: 0x0000000F
                0x0000000F
                0x0000000F
                0x0000000F
                0x0000000F
                0x0000000F
                0x0000000F
                0x0000000F
                0x0000000F		!15 = 1111
                0x0060200F
fin: 
    .end
