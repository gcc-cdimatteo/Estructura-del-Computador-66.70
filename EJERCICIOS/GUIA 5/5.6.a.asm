	.begin
	.org 2048
	ld [x], %r1
	ld [y], %r2
	call suma
	jmpl %r15 + 4, %r0
suma:	addcc %r1, %r2, %r3
	st %r3, [z]
x:	15
y:	9
z:	0
	.end
