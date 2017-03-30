	.text
	.align 2
	.globl main

main:
	mov x19, #15
	cmp x19, #10
	b.le true_branch
else_branch:
	mov x0, #1
	b exit

true_branch:
	mov x0, #0

exit:
	ret
