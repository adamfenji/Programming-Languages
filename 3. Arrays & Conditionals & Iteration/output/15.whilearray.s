	.section	.rodata
	.comm _gp, 60, 4
	.string_const0: .string "%d\n"
	.text
	.globl main
	.type main,@function
main:	nop
	pushq %rbp
	movq %rsp, %rbp
	leaq _gp(%rip), %rbx
	addq $56, %rbx
	movl $-5, %ecx
	movl %ecx, (%rbx)
	.L1:	nop
	leaq _gp(%rip), %rbx
	addq $56, %rbx
	movl (%rbx), %ecx
	movl $5, %ebx
	cmpl %ebx, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmovle %ebx, %ecx
	movl $-1, %ebx
	testl %ebx, %ecx
	je .L2
	leaq _gp(%rip), %rbx
	addq $56, %rbx
	movl (%rbx), %ecx
	leaq _gp+0(%rip), %rbx
	movslq %ecx, %rcx
	subq $-5, %rcx
	imulq $4, %rcx
	addq %rcx, %rbx
	leaq _gp(%rip), %rcx
	addq $56, %rcx
	movl (%rcx), %r8d
	movl %r8d, (%rbx)
	leaq _gp(%rip), %rbx
	addq $56, %rbx
	leaq _gp(%rip), %rcx
	addq $56, %rcx
	movl (%rcx), %r8d
	movl $1, %ecx
	addl %ecx, %r8d
	movl %r8d, (%rbx)
	jmp .L1
	.L2:	nop
	leaq _gp(%rip), %rbx
	addq $56, %rbx
	movl $-5, %ecx
	movl %ecx, (%rbx)
	.L3:	nop
	leaq _gp(%rip), %rbx
	addq $56, %rbx
	movl (%rbx), %ecx
	movl $5, %ebx
	cmpl %ebx, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmovle %ebx, %ecx
	movl $-1, %ebx
	testl %ebx, %ecx
	je .L4
	leaq _gp(%rip), %rbx
	addq $56, %rbx
	movl (%rbx), %ecx
	movl $0, %ebx
	cmpl %ebx, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmovg %ebx, %ecx
	movl $-1, %ebx
	testl %ebx, %ecx
	je .L5
	movl $0, %ebx
	leaq _gp(%rip), %rcx
	addq $56, %rcx
	movl (%rcx), %r8d
	leaq _gp+0(%rip), %rcx
	movslq %r8d, %r8
	subq $-5, %r8
	imulq $4, %r8
	addq %r8, %rcx
	movl (%rcx), %r8d
	subl %r8d, %ebx
	leaq .string_const0(%rip), %rdi
	movl %ebx, %esi
	movl $0, %eax
	call printf@PLT
	jmp .L6
	.L5:	nop
	movl $0, %ebx
	leaq .string_const0(%rip), %rdi
	movl %ebx, %esi
	movl $0, %eax
	call printf@PLT
	.L6:	nop
	leaq _gp(%rip), %rbx
	addq $56, %rbx
	leaq _gp(%rip), %rcx
	addq $56, %rcx
	movl (%rcx), %r8d
	movl $1, %ecx
	addl %ecx, %r8d
	movl %r8d, (%rbx)
	jmp .L3
	.L4:	nop
	leave
	ret
