	.section	.rodata
	.comm _gp, 4, 4
	.string_const0: .string "%s\n"
	.string_const1: .string "inside function"
	.string_const2: .string "%d\n"
	.text
	.globl t
	.type t,@function
t:	nop
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	subq $8, %rsp
	leaq .string_const0(%rip), %rdi
	leaq .string_const1(%rip), %rsi
	call printf@PLT
	movq %rbp, %rbx
	addq $-4, %rbx
	movl $10, %ecx
	movl %ecx, (%rbx)
	movq %rbp, %rbx
	addq $-4, %rbx
	movl (%rbx), %ecx
	movl $5, %ebx
	addl %ebx, %ecx
	movl %ecx, %eax
	addq $8, %rsp
	popq %r15
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
	.globl main
	.type main,@function
main:	nop
	pushq %rbp
	movq %rsp, %rbp
	leaq _gp(%rip), %rbx
	addq $0, %rbx
	pushq %r8
	pushq %r9
	pushq %r10
	pushq %r11
	call t
	popq %r11
	popq %r10
	popq %r9
	popq %r8
	movl %eax, %ecx
	movl %ecx, (%rbx)
	leaq _gp(%rip), %rbx
	addq $0, %rbx
	movl (%rbx), %ecx
	leaq .string_const2(%rip), %rdi
	movl %ecx, %esi
	movl $0, %eax
	call printf@PLT
	leave
	ret
