	.data
str01: .asciz "la sumatoria es: %d\n"

	.text
	.align 2
	.globl main

main:
// entrada a funcion main
	add sp, sp, #-16
	str x30, [sp, #0]

	mov x0, #0	// inicializaciones
	mov x1, #0	// x0 = j, x1=i

for_cond:
	cmp x1, 10
	b.ge for_exit
	add x0, x0, x1
	add x1, x1, #1
	b for_cond

for_exit:
	mov x1, x0
	ldr x0, =str01
	bl printf
main_exit:
	ldr x30, [sp, #0]
	add sp, sp, #16
	ret
