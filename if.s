	.text
	.align 2
	.globl main

main:
	mov x19, #1
	mov x0, #0
	cmp x19, #0
	b.eq exit
	mov x0, #1

exit:
	ret
