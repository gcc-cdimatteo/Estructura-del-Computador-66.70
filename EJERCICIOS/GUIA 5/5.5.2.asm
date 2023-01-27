	.begin
	ld %r14, %r2
	ld [value], %r1
	add %r2, %r1, %r2
	st %r2, %r14
	jmpl %r15, 4, %r0
value: 	25
	.end
