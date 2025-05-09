	.section	.rodata
	.comm _gp, 2116, 4
	.string_const0: .string "%d\n"
	.string_const1: .string "%s"
	.string_const2: .string "input a[3, 5] = "
	.string_const3: .string "%d"
	.string_const4: .string "you input "
	.text
	.globl main
	.type main,@function
main:	nop
	pushq %rbp
	movq %rsp, %rbp
	movl $3, %ebx
	movl $5, %ecx
	leaq _gp(%rip), %r8
	addq $0, %r8
	movslq %ebx, %rbx
	subq $1, %rbx
	imulq $20, %rbx
	movslq %ecx, %rcx
	subq $1, %rcx
	addq %rcx, %rbx
	imulq $4, %rbx
	addq %rbx, %r8
	movl $10, %ebx
	movl %ebx, (%r8)
	movl $3, %ebx
	movl $5, %ecx
	leaq _gp(%rip), %r8
	addq $0, %r8
	movslq %ebx, %rbx
	subq $1, %rbx
	imulq $20, %rbx
	movslq %ecx, %rcx
	subq $1, %rcx
	addq %rcx, %rbx
	imulq $4, %rbx
	addq %rbx, %r8
	movl (%r8), %ebx
	leaq .string_const0(%rip), %rdi
	movl %ebx, %esi
	movl $0, %eax
	call printf@PLT
	leaq .string_const1(%rip), %rdi
	leaq .string_const2(%rip), %rsi
	call printf@PLT
	movl $3, %ebx
	movl $5, %ecx
	leaq _gp(%rip), %r8
	addq $0, %r8
	movslq %ebx, %rbx
	subq $1, %rbx
	imulq $20, %rbx
	movslq %ecx, %rcx
	subq $1, %rcx
	addq %rcx, %rbx
	imulq $4, %rbx
	addq %rbx, %r8
	leaq .string_const3(%rip), %rdi
	movq %r8, %rsi
	movl $0, %eax
	call scanf@PLT
	leaq .string_const1(%rip), %rdi
	leaq .string_const4(%rip), %rsi
	call printf@PLT
	movl $3, %ebx
	movl $5, %ecx
	leaq _gp(%rip), %r8
	addq $0, %r8
	movslq %ebx, %rbx
	subq $1, %rbx
	imulq $20, %rbx
	movslq %ecx, %rcx
	subq $1, %rcx
	addq %rcx, %rbx
	imulq $4, %rbx
	addq %rbx, %r8
	movl (%r8), %ebx
	leaq .string_const0(%rip), %rdi
	movl %ebx, %esi
	movl $0, %eax
	call printf@PLT
	leave
	ret
