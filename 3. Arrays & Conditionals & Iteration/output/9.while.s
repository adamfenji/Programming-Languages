	.section	.rodata
	.comm _gp, 12, 4
	.string_const0: .string "%d\n"
	.text
	.globl main
	.type main,@function
main:	nop
	pushq %rbp
	movq %rsp, %rbp
	leaq _gp(%rip), %rbx
	addq $0, %rbx
	movl $0, %ecx
	movl %ecx, (%rbx)
	.L1:	nop
	leaq _gp(%rip), %rbx
	addq $0, %rbx
	movl (%rbx), %ecx
	movl $50, %ebx
	cmpl %ebx, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmovl %ebx, %ecx
	movl $-1, %ebx
	testl %ebx, %ecx
	je .L2
	leaq _gp(%rip), %rbx
	addq $4, %rbx
	movl $0, %ecx
	movl %ecx, (%rbx)
	.L3:	nop
	leaq _gp(%rip), %rbx
	addq $4, %rbx
	movl (%rbx), %ecx
	movl $10, %ebx
	cmpl %ebx, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmovl %ebx, %ecx
	movl $-1, %ebx
	testl %ebx, %ecx
	je .L4
	leaq _gp(%rip), %rbx
	addq $0, %rbx
	movl (%rbx), %ecx
	leaq _gp(%rip), %rbx
	addq $4, %rbx
	movl (%rbx), %r8d
	addl %r8d, %ecx
	leaq .string_const0(%rip), %rdi
	movl %ecx, %esi
	movl $0, %eax
	call printf@PLT
	leaq _gp(%rip), %rbx
	addq $4, %rbx
	leaq _gp(%rip), %rcx
	addq $4, %rcx
	movl (%rcx), %r8d
	movl $2, %ecx
	addl %ecx, %r8d
	movl %r8d, (%rbx)
	jmp .L3
	.L4:	nop
	leaq _gp(%rip), %rbx
	addq $8, %rbx
	movl $0, %ecx
	leaq _gp(%rip), %r8
	addq $4, %r8
	movl (%r8), %r9d
	subl %r9d, %ecx
	movl %ecx, (%rbx)
	.L5:	nop
	leaq _gp(%rip), %rbx
	addq $8, %rbx
	movl (%rbx), %ecx
	leaq _gp(%rip), %rbx
	addq $4, %rbx
	movl (%rbx), %r8d
	cmpl %r8d, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmovne %ebx, %ecx
	movl $-1, %ebx
	testl %ebx, %ecx
	je .L6
	leaq _gp(%rip), %rbx
	addq $8, %rbx
	movl (%rbx), %ecx
	leaq .string_const0(%rip), %rdi
	movl %ecx, %esi
	movl $0, %eax
	call printf@PLT
	leaq _gp(%rip), %rbx
	addq $8, %rbx
	leaq _gp(%rip), %rcx
	addq $8, %rcx
	movl (%rcx), %r8d
	movl $1, %ecx
	addl %ecx, %r8d
	movl %r8d, (%rbx)
	jmp .L5
	.L6:	nop
	leaq _gp(%rip), %rbx
	addq $0, %rbx
	leaq _gp(%rip), %rcx
	addq $0, %rcx
	movl (%rcx), %r8d
	movl $10, %ecx
	addl %ecx, %r8d
	movl %r8d, (%rbx)
	jmp .L1
	.L2:	nop
	leave
	ret
