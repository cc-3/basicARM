	.text
	.align 2
	.globl main

// cycle me this!

main:
	mov x19, #0 	//for (x19 = 0)
start_while:
	cmp x19, #10
	b.eq finish_while
	add x19, x19, #1
	b start_while

finish_while:
	mov x0, x19
	ret

