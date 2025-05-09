	.section	.rodata
	.comm _gp, 8, 4
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
	addq $0, %rbx
	movl (%rbx), %ecx
	movl $0, %ebx
	cmpl %ebx, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmovl %ebx, %ecx
	movl $-1, %ebx
	testl %ebx, %ecx
	je .L1
	leaq _gp(%rip), %rbx
	addq $4, %rbx
	movl $0, %ecx
	leaq _gp(%rip), %r8
	addq $0, %r8
	movl (%r8), %r9d
	subl %r9d, %ecx
	movl %ecx, (%rbx)
	leaq _gp(%rip), %rbx
	addq $4, %rbx
	movl (%rbx), %ecx
	leaq .string_const3(%rip), %rdi
	movl %ecx, %esi
	movl $0, %eax
	call printf@PLT
	jmp .L2
	.L1:	nop
	leaq _gp(%rip), %rbx
	addq $4, %rbx
	leaq _gp(%rip), %rcx
	addq $0, %rcx
	movl (%rcx), %r8d
	movl %r8d, (%rbx)
	leaq _gp(%rip), %rbx
	addq $4, %rbx
	movl (%rbx), %ecx
	leaq .string_const3(%rip), %rdi
	movl %ecx, %esi
	movl $0, %eax
	call printf@PLT
	.L2:	nop
	leave
	ret
