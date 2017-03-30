	.text
	.globl main

main:
	mov x3, #3
	mov x4, #5
	add x2, x3, #8
	add x1, x4, x3
	sub x0, x2, x1

	mov x5, #0xF0
	ORR x0, x0, x5
	ret
