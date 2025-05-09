	.section	.rodata
	.comm _gp, 52, 4
	.string_const0: .string "%d\n"
	.text
	.globl main
	.type main,@function
main:	nop
	pushq %rbp
	movq %rsp, %rbp
	leaq _gp(%rip), %rbx
	addq $44, %rbx
	movl $8, %ecx
	movl %ecx, (%rbx)
	leaq _gp(%rip), %rbx
	addq $44, %rbx
	movl (%rbx), %ecx
	leaq _gp+0(%rip), %rbx
	movslq %ecx, %rcx
	subq $2, %rcx
	imulq $4, %rcx
	addq %rcx, %rbx
	movl $9, %ecx
	movl %ecx, (%rbx)
	leaq _gp(%rip), %rbx
	addq $44, %rbx
	movl (%rbx), %ecx
	leaq _gp+0(%rip), %rbx
	movslq %ecx, %rcx
	subq $2, %rcx
	imulq $4, %rcx
	addq %rcx, %rbx
	movl (%rbx), %ecx
	leaq .string_const0(%rip), %rdi
	movl %ecx, %esi
	movl $0, %eax
	call printf@PLT
	leaq _gp(%rip), %rbx
	addq $48, %rbx
	movl $9, %ecx
	movl %ecx, (%rbx)
	leaq _gp(%rip), %rbx
	addq $48, %rbx
	movl (%rbx), %ecx
	leaq _gp+0(%rip), %rbx
	movslq %ecx, %rcx
	subq $2, %rcx
	imulq $4, %rcx
	addq %rcx, %rbx
	movl $19, %ecx
	movl %ecx, (%rbx)
	leaq _gp(%rip), %rbx
	addq $48, %rbx
	movl (%rbx), %ecx
	leaq _gp+0(%rip), %rbx
	movslq %ecx, %rcx
	subq $2, %rcx
	imulq $4, %rcx
	addq %rcx, %rbx
	movl (%rbx), %ecx
	leaq .string_const0(%rip), %rdi
	movl %ecx, %esi
	movl $0, %eax
	call printf@PLT
	leaq _gp(%rip), %rbx
	addq $44, %rbx
	movl (%rbx), %ecx
	leaq _gp+0(%rip), %rbx
	movslq %ecx, %rcx
	subq $2, %rcx
	imulq $4, %rcx
	addq %rcx, %rbx
	movl (%rbx), %ecx
	leaq _gp+0(%rip), %rbx
	movslq %ecx, %rcx
	subq $2, %rcx
	imulq $4, %rcx
	addq %rcx, %rbx
	movl (%rbx), %ecx
	leaq .string_const0(%rip), %rdi
	movl %ecx, %esi
	movl $0, %eax
	call printf@PLT
	leave
	ret
