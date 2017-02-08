	.data
string:	.asciz	"current number: %d\n"

	.text
	.align 2
	.globl main

// cycle and print me this!

main:
	add sp, sp, -16
	str	x30, [sp]
	mov x19, #0 	//for (x19 = 0)
start_while:
	cmp x19, #10
	b.eq finish_while
	add x19, x19, #1
	mov x1, x19
	ldr x0, =string
	bl printf
	b start_while

finish_while:
	mov x0, x19
	ldr	x30, [sp]
	add sp, sp, 16
	ret

