	.begin
	ld %r14, %r2
	add %r0, 25, %r1
	add %r2, %r1, %r2
	st %r2, %r14
	jmpl %r15, 4, %r0
	.end
