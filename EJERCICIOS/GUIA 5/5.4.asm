	.begin
	.org 2048
	ld	[x], %r1
	ld 	[y], %r2
	ld	[x], %r2
	ld 	[y], %r1
	jmpl	%r15 + 4, %r0
x:	15
y: 	9
	.end
