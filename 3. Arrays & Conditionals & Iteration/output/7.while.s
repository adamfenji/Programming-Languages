	.section	.rodata
	.comm _gp, 12, 4
	.string_const0: .string "%s"
	.string_const1: .string "Enter a:"
	.string_const2: .string "%d"
	.string_const3: .string "%d\n"
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
	addq $8, %rbx
	movl $0, %ecx
	movl %ecx, (%rbx)
	leaq _gp(%rip), %rbx
	addq $4, %rbx
	movl $0, %ecx
	movl %ecx, (%rbx)
	.L1:	nop
	leaq _gp(%rip), %rbx
	addq $4, %rbx
	movl (%rbx), %ecx
	leaq _gp(%rip), %rbx
	addq $0, %rbx
	movl (%rbx), %r8d
	cmpl %r8d, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmovle %ebx, %ecx
	leaq _gp(%rip), %rbx
	addq $4, %rbx
	movl (%rbx), %r8d
	movl $100, %ebx
	cmpl %ebx, %r8d
	movl $0, %r8d
	movl $1, %ebx
	cmovle %ebx, %r8d
	andl %r8d, %ecx
	movl $-1, %ebx
	testl %ebx, %ecx
	je .L2
	leaq _gp(%rip), %rbx
	addq $8, %rbx
	leaq _gp(%rip), %rcx
	addq $8, %rcx
	movl (%rcx), %r8d
	leaq _gp(%rip), %rcx
	addq $4, %rcx
	movl (%rcx), %r9d
	addl %r9d, %r8d
	movl %r8d, (%rbx)
	leaq _gp(%rip), %rbx
	addq $4, %rbx
	leaq _gp(%rip), %rcx
	addq $4, %rcx
	movl (%rcx), %r8d
	movl $1, %ecx
	addl %ecx, %r8d
	movl %r8d, (%rbx)
	jmp .L1
	.L2:	nop
	leaq _gp(%rip), %rbx
	addq $8, %rbx
	movl (%rbx), %ecx
	leaq .string_const3(%rip), %rdi
	movl %ecx, %esi
	movl $0, %eax
	call printf@PLT
	leave
	ret
