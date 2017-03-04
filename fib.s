	.data
	.align 3
string:	.asciz	"Fibonacci of %d is %d\n"

	.text
	.align 2
	.globl main

// Fibonacci Function

main:
	// initialize
	add sp, sp, -16
	str	x30, [sp]

	mov x1, #9

	mov x0, x1
	bl fib
	mov x2, x0

	ldr x0, =string
	bl printf

	// ender
	ldr	x30, [sp]
	add sp, sp, 16
	ret

fib:
	// initialize
	add sp, sp, -32
	str	x30, [sp]
	str x20, [sp, 8]
	str x21, [sp, 16]

	cmp x0, #0
	b.eq isZero

	cmp x0, #1
	b.eq isOne

	//compute fibn = (fibn -1) + (fibn -2)
	mov x20, x0
	mov x21, x0

	// first compute (fibn -1)
	add x0, x20, #-1
	bl fib
	mov x20, x0

	// now (fibn -2)
	add x0, x21, #-2
	bl fib
	mov x21, x0

	// finally...
	add x0, x20, x21	// fibn = (fibn -1) + (fibn -2)
	b fibEnder

isOne:
	mov x0, #1
	b fibEnder

isZero:
	mov x0, #0

fibEnder:
	// ender
	ldr	x30, [sp]
	ldr x20, [sp, 8]
	ldr x21, [sp, 16]
	add sp, sp, 32
	ret
