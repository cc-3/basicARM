	.data
	.align 3
A:	.space 80	// reserve space for a int_64[10]
str_01:	.asciz "A[%d]=%d\n"

	.text
	.align 2
	.globl main

// I will create this program:
// #include <stdio.h>
// int A[10];
// int main(){
//	for (int i=0; i<10; i++){
//		A[i]=i;
// }}

main:
	add sp, sp, -16
	str	x30, [sp]
	
	ldr x20, =A
	ldr x0, =str_01

//	for (int i=0; i<10; i++) A[i]=i; 
	mov x19, #0	// int i=0;
main_for:
	cmp x19, #10
	b.ge exit_for
	lsl x10, x19, #3
	add x11, x10, x20
	str x19,	[x11]
	add x19, x19, #1
	b main_for

exit_for:
// lets now print the contents of the array
// for (int i=0; i<10; i++) printf (A[i]=i); 
	mov x19, #0	// int i=0;
printf_for:
	cmp x19, #10
	b.ge exit_printf_for
	lsl x10, x19, #3
	add x11, x10, x20
	ldr x2,	[x11]
	mov x1, x19
	ldr x0, =str_01
	bl printf
	add x19, x19, #1
	b printf_for

exit_printf_for:
main_exit:
	ldr	x30, [sp]
	add sp, sp, 16
	ret
	
