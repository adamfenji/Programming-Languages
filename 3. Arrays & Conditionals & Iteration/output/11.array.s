	.section	.rodata
	.comm _gp, 52, 4
	.string_const0: .string "%d\n"
	.text
	.globl main
	.type main,@function
main:	nop
	pushq %rbp
	movq %rsp, %rbp
	movl $3, %ebx
	leaq _gp+0(%rip), %rcx
	movslq %ebx, %rbx
	subq $0, %rbx
	imulq $4, %rbx
	addq %rbx, %rcx
	movl $4, %ebx
	movl %ebx, (%rcx)
	movl $3, %ebx
	leaq _gp+0(%rip), %rcx
	movslq %ebx, %rbx
	subq $0, %rbx
	imulq $4, %rbx
	addq %rbx, %rcx
	movl (%rcx), %ebx
	leaq .string_const0(%rip), %rdi
	movl %ebx, %esi
	movl $0, %eax
	call printf@PLT
	leave
	ret
