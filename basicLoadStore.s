	.data
	.align 3
a:	.space 8
b: 	.space 8

	.text
	.align 2
	.globl main

// lets test some loads and stores

main:
	ldr x1, =a
	ldr x2, =b

	mov x0, #5
	str x0, [x1]

	mov x0, #3
	str x0, [x2]

	mov x0, #0
	ldr x0, [x1]

	ldr x3, [x2]
	add x3, x3, #1
	str	x3, [x2]

	ret

