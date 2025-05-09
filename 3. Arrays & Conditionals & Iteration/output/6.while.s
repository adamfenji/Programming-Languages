	.section	.rodata
	.comm _gp, 8, 4
	.string_const0: .string "%d\n"
	.text
	.globl main
	.type main,@function
main:	nop
	pushq %rbp
	movq %rsp, %rbp
	leaq _gp(%rip), %rbx
	addq $0, %rbx
	movl $1, %ecx
	movl %ecx, (%rbx)
	leaq _gp(%rip), %rbx
	addq $4, %rbx
	movl $0, %ecx
	movl %ecx, (%rbx)
	.L1:	nop
	leaq _gp(%rip), %rbx
	addq $0, %rbx
	movl (%rbx), %ecx
	movl $10, %ebx
	cmpl %ebx, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmovle %ebx, %ecx
	movl $-1, %ebx
	testl %ebx, %ecx
	je .L2
	leaq _gp(%rip), %rbx
	addq $4, %rbx
	leaq _gp(%rip), %rcx
	addq $4, %rcx
	movl (%rcx), %r8d
	leaq _gp(%rip), %rcx
	addq $0, %rcx
	movl (%rcx), %r9d
	addl %r9d, %r8d
	movl %r8d, (%rbx)
	leaq _gp(%rip), %rbx
	addq $0, %rbx
	leaq _gp(%rip), %rcx
	addq $0, %rcx
	movl (%rcx), %r8d
	movl $1, %ecx
	addl %ecx, %r8d
	movl %r8d, (%rbx)
	jmp .L1
	.L2:	nop
	leaq _gp(%rip), %rbx
	addq $4, %rbx
	movl (%rbx), %ecx
	leaq .string_const0(%rip), %rdi
	movl %ecx, %esi
	movl $0, %eax
	call printf@PLT
	leave
	ret
