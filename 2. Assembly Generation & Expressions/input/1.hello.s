	.section	.rodata 
	.string_const0: .string "%s"
	.string_const1: .string "Hello world!\n"
	.text
	.globl main
	.type main,@function
main:	nop
	pushq %rbp
	movq %rsp, %rbp
	leaq .string_const0(%rip), %rdi
	leaq .string_const1(%rip), %rsi
	movl $0, %eax
	call printf@PLT
	leave
	ret
