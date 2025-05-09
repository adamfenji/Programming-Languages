	.section	.rodata 
	.comm _gp, 16, 4
	.string_const0: .string "%15s"
	.string_const1: .string "j = 1+3+4 ="
	.string_const2: .string "%4d\n"
	.text
	.globl main
	.type main,@function
main:	nop
	pushq %rbp
	movq %rsp, %rbp
	leaq _gp(%rip), %r8
	addq $0, %r8
	movl $1, %r9d
	movl %r9d, (%r8)
	leaq _gp(%rip), %r8
	addq $8, %r8
	movl $3, %r9d
	movl %r9d, (%r8)
	leaq _gp(%rip), %r8
	addq $12, %r8
	movl $4, %r9d
	movl %r9d, (%r8)
	leaq _gp(%rip), %r8
	addq $4, %r8
	leaq _gp(%rip), %r9
	addq $0, %r9
	movl (%r9), %r10d
	leaq _gp(%rip), %r9
	addq $12, %r9
	movl (%r9), %r11d
	addl %r11d, %r10d
	leaq _gp(%rip), %r9
	addq $8, %r9
	movl (%r9), %r11d
	addl %r11d, %r10d
	movl %r10d, (%r8)
	leaq .string_const0(%rip), %rdi
	leaq .string_const1(%rip), %rsi
	call printf@PLT
	leaq _gp(%rip), %r8
	addq $4, %r8
	movl (%r8), %r9d
	leaq .string_const2(%rip), %rdi
	movl %r9d, %esi
	movl $0, %eax
	call printf@PLT
	leave
	ret
