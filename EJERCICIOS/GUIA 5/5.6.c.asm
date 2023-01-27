.begin
	.org 2048
	ld [x], %r1		! cargo el valor de x en r1
	st %r1, [M]		! guardo el valor de r1 en el espacio en memoria reservado
	ld [y], %r2		! cargo el valor de y en r2
	st %r2, [M + 4]		! guardo el valor de r1 en el espacio en memoria reservado +4 
	sethi M, %r5		! establezco r5 como la zona de transferencia de datos -> guardo los 22 bis mas significativos de M en r5 -> me guarde la direccion en memoria de M
	srl %r5, 10, %r5	! dejo los 22 bits mas significativos de r5 en la zona baja (a la derecha) -> en r5 queda la direccion de la zona de transferencia de datos
	call suma
	ld [M + 8], %r3
	st %r3, [z]
	ld %r0, %r15
	jmpl %r15, 4, %r0
M:	.dwb 3			! reservo 12 bytes de memoria
x:	2
y:	3
z:	0
suma:	ld %r5, %r10		! cargo el valor en memoria de M en r10 -> x
	ld %r5 + 4, %r11	! cargo el valor en memoria de M + 4 en r11 -> y
	addcc %r10, %r11, %r12
	st %r12, %r5 + 8	! guardo el resultado de la suma en M + 8
	jmpl %r15, 4, %r0
.end
