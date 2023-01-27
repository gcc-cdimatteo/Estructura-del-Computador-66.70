.begin 
	.org 2048
	ld [x], %r1		! cargo x en r1
	ld [y], %r2		! cargo y en r2
	call suma
	st %r3, [z]		! guardo el resultado de la suma en z
	ld %r0, %r15
	jmpl %r15, 4, %r0	! vuelvo
x:	2
y:	3
z:	0
.end

.begin
	.org 2084
suma:	addcc %r1, %r2, %r3
	jmpl %r15, 4, %r0
.end
