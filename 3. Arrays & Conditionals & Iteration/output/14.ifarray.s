	.section	.rodata
	.comm _gp, 216, 4
	.string_const0: .string "%s"
	.string_const1: .string "Enter i:"
	.string_const2: .string "%d"
	.string_const3: .string "%s\n"
	.string_const4: .string "OUT OF BOUND"
	.string_const5: .string "%d\n"
	.text
	.globl main
	.type main,@function
main:	nop
	pushq %rbp
	movq %rsp, %rbp
	leaq .string_const0(%rip), %rdi
	leaq .string_const1(%rip), %rsi
	call printf@PLT
	leaq _gp(%rip), %rbx
	addq $0, %rbx
	leaq .string_const2(%rip), %rdi
	movq %rbx, %rsi
	movl $0, %eax
	call scanf@PLT
	leaq _gp(%rip), %rbx
	addq $0, %rbx
	movl (%rbx), %ecx
	movl $51, %ebx
	cmpl %ebx, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmovl %ebx, %ecx
	leaq _gp(%rip), %rbx
	addq $0, %rbx
	movl (%rbx), %r8d
	movl $100, %ebx
	cmpl %ebx, %r8d
	movl $0, %r8d
	movl $1, %ebx
	cmovg %ebx, %r8d
	orl %r8d, %ecx
	movl $-1, %ebx
	testl %ebx, %ecx
	je .L1
	leaq .string_const3(%rip), %rdi
	leaq .string_const4(%rip), %rsi
	call printf@PLT
	jmp .L2
	.L1:	nop
	leaq _gp(%rip), %rbx
	addq $0, %rbx
	movl (%rbx), %ecx
	leaq _gp+4(%rip), %rbx
	movslq %ecx, %rcx
	subq $51, %rcx
	imulq $4, %rcx
	addq %rcx, %rbx
	leaq _gp(%rip), %rcx
	addq $0, %rcx
	movl (%rcx), %r8d
	movl $2, %ecx
	imull %ecx, %r8d
	movl %r8d, (%rbx)
	movl $51, %ebx
	leaq _gp+4(%rip), %rcx
	movslq %ebx, %rbx
	subq $51, %rbx
	imulq $4, %rbx
	addq %rbx, %rcx
	movl $1, %ebx
	movl %ebx, (%rcx)
	leaq _gp(%rip), %rbx
	addq $0, %rbx
	movl (%rbx), %ecx
	leaq _gp+4(%rip), %rbx
	movslq %ecx, %rcx
	subq $51, %rcx
	imulq $4, %rcx
	addq %rcx, %rbx
	movl (%rbx), %ecx
	movl $51, %ebx
	leaq _gp+4(%rip), %r8
	movslq %ebx, %rbx
	subq $51, %rbx
	imulq $4, %rbx
	addq %rbx, %r8
	movl (%r8), %ebx
	addl %ebx, %ecx
	leaq .string_const5(%rip), %rdi
	movl %ecx, %esi
	movl $0, %eax
	call printf@PLT
	.L2:	nop
	leave
	ret
