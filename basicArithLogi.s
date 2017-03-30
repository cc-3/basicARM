	.text
	.globl main

// just testing some adds, subs and logic operations

main:
	mov x1, #1
	mov x2, #5
	add x0, x1, #3
	sub x0, x0, #2
//	orr x0, x0, #5 //wtf?
	orr x0, x0, x2
	ret

