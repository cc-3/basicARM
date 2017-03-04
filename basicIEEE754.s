	.data
	.align 3
str01:	.asciz "number: %d, float:%f, hex codified float: %llx\n"
str02:	.asciz "x0: %llx\n"
	.text
	.globl main
	.align 2
main:
	add sp, sp, -0x10
	str x30, [sp, #0]
	str x19, [sp, #8]

	mov x19, #-5	// number to be tested
	mov x0, x19
	bl encodeIEEE754D64
	fmov d0, x0
	mov x2, x0
	mov x1, x19
	ldr x0, =str01
	bl printf

	ldr x30, [sp, #0]
	ldr x19, [sp, #8]
	add sp, sp, 0x10
	ret
/////////////////////////////////////////////////////////////////////////
// esta es mi funcion para codificar numeros enteros distintos de cero //
/////////////////////////////////////////////////////////////////////////
encodeIEEE754D64:
	// prologo
	add sp, sp, -0x10
	str x30, [sp, #0]
	str x19, [sp, #8]

	// use temporal x9 to store recieved number, and x0 for answer
	mov x9, x0
	mov x0, xzr

	// start with the sign
	cmp x9, xzr
	b.ge encodeIEEE754D64_encodeBias

	// if we got here it's because it's negative, so set the sign bit, and make it positive
	mov x0, #1
	lsl x0, x0, #63		// set IEEE754 sign bit
	sub x9, xzr, x9		// make number positive

encodeIEEE754D64_encodeBias:
	mov x10, #0		// init accum, this will tell me how many shifts I did (or equivalently, where was the firstOne)
	mov x11, 0x4000000000000000	// set the most significant bit to one so I can compare against this number

// search for the firstOne from left to right
encodeIEEE754D64_firstOne:
	and x12, x9, x11
        lsl x9, x9, #1          // shift the whole number left until i find the first one
        add x10, x10, #1        // how many shifts have i done
	cmp x12, xzr
	b.gt encodeIEEE754D64_foundFirstOne	// found it!
	cmp x10, #64
	b.ge encodeIEEE754D64_foundFirstOne	// there are no ones!
	b encodeIEEE754D64_firstOne

encodeIEEE754D64_foundFirstOne:	// now that i've found it, I can calculate bias and significand
	mov x15, #63
	sub x10, x15, x10	// 64 bits - first one, tells me where i found the first one (since i started from the left and bits are counted from right)
	add x13, x10, #1023	// x13 will be the bias, so add the bias for IEEE754 double 
	lsl x13, x13, #52	// position the bias
	orr x0, x0, x13		// place the bias in return value

encodeIEEE754D64_encodeMantissa:
	and x9, x9, #0x7FFFFFFFFFFFFFFF	// elimino el primer uno dado que este esta implicito en la codificacion
	lsr x9, x9, #11		// since we had been shifting x9, we eliminated all zeros and only have the significand here
	orr x0, x0, x9

// epilogo
encodeIEEE754D64_exit:
	ldr x30, [sp, #0]
	ldr x19, [sp, #8]
	add sp, sp, 0x10
	ret
