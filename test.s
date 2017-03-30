	.arch armv8-a
	.file	"test.c"
	.comm	myVar,8,8
	.comm	A,40,8
	.text
	.align	2
	.global	main
	.type	main, %function
main:
	sub	sp, sp, #16
	adrp	x0, myVar
	add	x0, x0, :lo12:myVar
	mov	x1, 5
	str	x1, [x0]
	str	wzr, [sp, 12]
	b	.L2
.L3:
	adrp	x0, A
	add	x0, x0, :lo12:A
	ldrsw	x1, [sp, 12]
	ldr	w2, [sp, 12]
	str	w2, [x0, x1, lsl 2]
	ldr	w0, [sp, 12]
	add	w0, w0, 1
	str	w0, [sp, 12]
.L2:
	ldr	w0, [sp, 12]
	cmp	w0, 9
	ble	.L3
	mov	w0, 0
	add	sp, sp, 16
	ret
	.size	main, .-main
	.ident	"GCC: (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
