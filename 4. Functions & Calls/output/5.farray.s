	.section	.rodata
	.comm _gp, 8, 4
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
	movl $3, %ebx
	movq %rbp, %rcx
	addq $-48, %rcx
	movslq %ebx, %rbx
	subq $0, %rbx
	imulq $4, %rbx
	addq %rbx, %rcx
	movl $5, %ebx
	movl %ebx, (%rcx)
	movq %rbp, %rbx
	addq $-4, %rbx
	movl $2, %ecx
	movl %ecx, (%rbx)
	movq %rbp, %rbx
	addq $-4, %rbx
	movl (%rbx), %ecx
	leaq .string_const0(%rip), %rdi
	movl %ecx, %esi
	movl $0, %eax
	call printf@PLT
	movq %rbp, %rbx
	addq $-4, %rbx
	movl (%rbx), %ecx
	movl $3, %ebx
	movq %rbp, %r8
	addq $-48, %r8
	movslq %ebx, %rbx
	subq $0, %rbx
	imulq $4, %rbx
	addq %rbx, %r8
	movl (%r8), %ebx
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
	movl $1, %ecx
	movl %ecx, (%rbx)
	leaq _gp(%rip), %rbx
	addq $4, %rbx
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
	leaq _gp(%rip), %rbx
	addq $4, %rbx
	movl (%rbx), %r8d
	addl %r8d, %ecx
	leaq .string_const0(%rip), %rdi
	movl %ecx, %esi
	movl $0, %eax
	call printf@PLT
	leave
	ret
