	.data
str01:	.asciz "float: %f\n"
str02:  .asciz "bits: 0x%llx, float: %f\n"
	.align 2		// es necesario alinear a 2^2 = 4 bytes dado que un float ocupa 4 bytes 
float01: .single 0.123
	.align 3
double01: .double 5.678		// es necesario alinear a 2^3 = 8 bytes dado que un double ocupa 8 bytes
	.text
	.align 2
	.globl main
main:
	// prologue
	add sp, sp, #-0x10
	str x30, [sp, #0]

	// body

	// primero veamos varias formas de imprimir floats:
	// 1.5 codificado en single precision: #0x3fc00000

	ldr x0, =str02		// cargo a x0 el primer argumento str
	fmov s0, #0x3fc00000	// cargo el numero codificado en IEEE 754 single
	fcvt d0, s0		// dado los "default argument promotions", printf espera recibir double por lo que hay que convertirlo
	fmov x1, d0		// imprimo el numero codificado en hex
	bl printf		// printf(x0, d0);

	// ahoira imprimamos el double 1.5: 0x3ff8000000000000
	ldr x0, =str02
	fmov d0, #0x3ff8000000000000
	fmov x1, d0
	bl printf 		// en este caso no es necesario el fcvt (float convert)

	// ahora carguemos un #imm
	ldr x0, =str02
	fmov d0, #1.25		// tambien podemos cargar immediates.. algunos.. probar con 8.25..
	fmov x1, d0
	bl printf

	// carguemos de memoria a un registro un .single 
	ldr x0, =str02
	ldr x9, =float01
	ldr s0, [x9, #0]
	fcvt d0, s0
	fmov x1, d0
	bl printf

	// ahora un double guardado en memoria...
	ldr x0, =str02
	ldr x9, =double01
	ldr d0, [x9, #0]
	fmov x1, d0
	bl printf

	// epilogue
	ldr x30, [sp, #0]
	add sp, sp, #0x10
	ret
