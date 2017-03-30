	.data
	.align 3
msg:	.asciz	"x19 is: %d\n"
	.text
	.align 2
	.globl main

main:
	add sp, sp, -16
	str	x30, [sp, #0]
	mov x19, #0
for_init:
	cmp x19, #10
	b.ge exit
	ldr x0, =msg
	mov x1, x19
	bl printf
	add x19, x19, #1
	b for_init
exit:
	ldr x30, [sp, #0]
	add sp, sp, 16
	ret
