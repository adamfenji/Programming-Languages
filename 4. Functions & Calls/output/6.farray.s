	.section	.rodata
	.comm _gp, 44, 4
	.string_const0: .string "%d\n"
	.text
	.globl t
	.type t,@function
t:	nop
	pushq %rbp
	movq %rsp, %rbp
	subq $64, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	subq $8, %rsp
	movq %rbp, %rbx
	addq $-4, %rbx
	movl $2, %ecx
	movl %ecx, (%rbx)
.L0:	nop
	movq %rbp, %rbx
	addq $-4, %rbx
	movl (%rbx), %ecx
	movl $11, %ebx
	cmpl %ebx, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmovle %ebx, %ecx
	movl $-1, %ebx
	testl %ecx, %ebx
	je .L1
	movq %rbp, %rbx
	addq $-4, %rbx
	movl (%rbx), %ecx
	movq %rbp, %rbx
	addq $-52, %rbx
	movslq %ecx, %rcx
	subq $2, %rcx
	imulq $4, %rcx
	addq %rcx, %rbx
	movq %rbp, %rcx
	addq $-4, %rcx
	movl (%rcx), %r8d
	movl $1, %ecx
	subl %ecx, %r8d
	leaq _gp(%rip), %rcx
	addq $4, %rcx
	movslq %r8d, %r8
	subq $1, %r8
	imulq $4, %r8
	addq %r8, %rcx
	movl (%rcx), %r8d
	movl %r8d, (%rbx)
	movq %rbp, %rbx
	addq $-4, %rbx
	movq %rbp, %rcx
	addq $-4, %rcx
	movl (%rcx), %r8d
	movl $1, %ecx
	addl %ecx, %r8d
	movl %r8d, (%rbx)
	jmp .L0
.L1:	 nop
	movl $5, %ebx
	movq %rbp, %rcx
	addq $-52, %rcx
	movslq %ebx, %rbx
	subq $2, %rbx
	imulq $4, %rbx
	addq %rbx, %rcx
	movl (%rcx), %ebx
	movl %ebx, %eax
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
	movl $1, %ecx
	movl %ecx, (%rbx)
.L2:	nop
	leaq _gp(%rip), %rbx
	addq $0, %rbx
	movl (%rbx), %ecx
	movl $10, %ebx
	cmpl %ebx, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmovle %ebx, %ecx
	movl $-1, %ebx
	testl %ecx, %ebx
	je .L3
	leaq _gp(%rip), %rbx
	addq $0, %rbx
	movl (%rbx), %ecx
	leaq _gp(%rip), %rbx
	addq $4, %rbx
	movslq %ecx, %rcx
	subq $1, %rcx
	imulq $4, %rcx
	addq %rcx, %rbx
	leaq _gp(%rip), %rcx
	addq $0, %rcx
	movl (%rcx), %r8d
	movl %r8d, (%rbx)
	leaq _gp(%rip), %rbx
	addq $0, %rbx
	leaq _gp(%rip), %rcx
	addq $0, %rcx
	movl (%rcx), %r8d
	movl $1, %ecx
	addl %ecx, %r8d
	movl %r8d, (%rbx)
	jmp .L2
.L3:	 nop
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
	leaq .string_const0(%rip), %rdi
	movl %ecx, %esi
	movl $0, %eax
	call printf@PLT
	leave
	ret
