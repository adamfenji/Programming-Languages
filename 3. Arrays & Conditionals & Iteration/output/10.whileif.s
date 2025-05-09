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
	addq $8, %rbx
	leaq .string_const2(%rip), %rdi
	movq %rbx, %rsi
	movl $0, %eax
	call scanf@PLT
	leaq _gp(%rip), %rbx
	addq $8, %rbx
	movl (%rbx), %ecx
	movl $2, %ebx
	movl %ecx, %eax
	cdq
	idivl %ebx
	movl %eax, %ecx
	movl $2, %ebx
	imull %ebx, %ecx
	leaq _gp(%rip), %rbx
	addq $8, %rbx
	movl (%rbx), %r8d
	cmpl %r8d, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmove %ebx, %ecx
	movl $-1, %ebx
	testl %ebx, %ecx
	je .L1
	leaq _gp(%rip), %rbx
	addq $4, %rbx
	movl $1, %ecx
	movl %ecx, (%rbx)
	leaq _gp(%rip), %rbx
	addq $0, %rbx
	movl $0, %ecx
	movl %ecx, (%rbx)
	.L2:	nop
	leaq _gp(%rip), %rbx
	addq $4, %rbx
	movl (%rbx), %ecx
	leaq _gp(%rip), %rbx
	addq $8, %rbx
	movl (%rbx), %r8d
	cmpl %r8d, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmovle %ebx, %ecx
	movl $-1, %ebx
	testl %ebx, %ecx
	je .L3
	leaq _gp(%rip), %rbx
	addq $0, %rbx
	leaq _gp(%rip), %rcx
	addq $0, %rcx
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
	jmp .L2
	.L3:	nop
	jmp .L4
	.L1:	nop
	leaq _gp(%rip), %rbx
	addq $4, %rbx
	movl $1, %ecx
	movl %ecx, (%rbx)
	leaq _gp(%rip), %rbx
	addq $0, %rbx
	movl $1, %ecx
	movl %ecx, (%rbx)
	.L5:	nop
	leaq _gp(%rip), %rbx
	addq $4, %rbx
	movl (%rbx), %ecx
	leaq _gp(%rip), %rbx
	addq $8, %rbx
	movl (%rbx), %r8d
	cmpl %r8d, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmovle %ebx, %ecx
	movl $-1, %ebx
	testl %ebx, %ecx
	je .L6
	leaq _gp(%rip), %rbx
	addq $0, %rbx
	leaq _gp(%rip), %rcx
	addq $0, %rcx
	movl (%rcx), %r8d
	leaq _gp(%rip), %rcx
	addq $4, %rcx
	movl (%rcx), %r9d
	imull %r9d, %r8d
	movl %r8d, (%rbx)
	leaq _gp(%rip), %rbx
	addq $4, %rbx
	leaq _gp(%rip), %rcx
	addq $4, %rcx
	movl (%rcx), %r8d
	movl $1, %ecx
	addl %ecx, %r8d
	movl %r8d, (%rbx)
	jmp .L5
	.L6:	nop
	.L4:	nop
	leaq _gp(%rip), %rbx
	addq $0, %rbx
	movl (%rbx), %ecx
	leaq .string_const3(%rip), %rdi
	movl %ecx, %esi
	movl $0, %eax
	call printf@PLT
	leave
	ret
