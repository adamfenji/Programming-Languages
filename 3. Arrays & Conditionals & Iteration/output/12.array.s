	.section	.rodata
	.comm _gp, 56, 4
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
	leaq _gp(%rip), %rbx
	addq $52, %rbx
	movl $3, %ecx
	movl %ecx, (%rbx)
	leaq _gp(%rip), %rbx
	addq $52, %rbx
	movl (%rbx), %ecx
	leaq _gp+0(%rip), %rbx
	movslq %ecx, %rcx
	subq $0, %rcx
	imulq $4, %rcx
	addq %rcx, %rbx
	movl $7, %ecx
	movl %ecx, (%rbx)
	leaq _gp(%rip), %rbx
	addq $52, %rbx
	movl (%rbx), %ecx
	leaq _gp+0(%rip), %rbx
	movslq %ecx, %rcx
	subq $0, %rcx
	imulq $4, %rcx
	addq %rcx, %rbx
	movl (%rbx), %ecx
	leaq .string_const0(%rip), %rdi
	movl %ecx, %esi
	movl $0, %eax
	call printf@PLT
	leaq _gp(%rip), %rbx
	addq $52, %rbx
	leaq _gp(%rip), %rcx
	addq $52, %rcx
	movl (%rcx), %r8d
	movl $2, %ecx
	addl %ecx, %r8d
	movl %r8d, (%rbx)
	leaq _gp(%rip), %rbx
	addq $52, %rbx
	movl (%rbx), %ecx
	leaq _gp+0(%rip), %rbx
	movslq %ecx, %rcx
	subq $0, %rcx
	imulq $4, %rcx
	addq %rcx, %rbx
	movl $22, %ecx
	movl %ecx, (%rbx)
	movl $5, %ebx
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
