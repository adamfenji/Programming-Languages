	.section	.rodata
	.comm _gp, 68, 4
	.string_const0: .string "%s"
	.string_const1: .string "b = "
	.string_const2: .string "%d\n"
	.string_const3: .string "c["
	.string_const4: .string "%d"
	.string_const5: .string "] = "
	.text
	.globl main
	.type main,@function
main:	nop
	pushq %rbp
	movq %rsp, %rbp
	leaq _gp(%rip), %rbx
	addq $60, %rbx
	movl $5, %ecx
	movl %ecx, (%rbx)
	.L1:	nop
	leaq _gp(%rip), %rbx
	addq $60, %rbx
	movl (%rbx), %ecx
	movl $15, %ebx
	cmpl %ebx, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmovle %ebx, %ecx
	movl $-1, %ebx
	testl %ebx, %ecx
	je .L2
	leaq _gp(%rip), %rbx
	addq $60, %rbx
	movl (%rbx), %ecx
	leaq _gp+4(%rip), %rbx
	movslq %ecx, %rcx
	subq $5, %rcx
	imulq $4, %rcx
	addq %rcx, %rbx
	leaq _gp(%rip), %rcx
	addq $60, %rcx
	movl (%rcx), %r8d
	movl %r8d, (%rbx)
	leaq _gp(%rip), %rbx
	addq $60, %rbx
	leaq _gp(%rip), %rcx
	addq $60, %rcx
	movl (%rcx), %r8d
	movl $1, %ecx
	addl %ecx, %r8d
	movl %r8d, (%rbx)
	jmp .L1
	.L2:	nop
	leaq _gp(%rip), %rbx
	addq $0, %rbx
	movl $-1, %ecx
	movl %ecx, (%rbx)
	leaq .string_const0(%rip), %rdi
	leaq .string_const1(%rip), %rsi
	call printf@PLT
	leaq _gp(%rip), %rbx
	addq $0, %rbx
	movl (%rbx), %ecx
	leaq .string_const2(%rip), %rdi
	movl %ecx, %esi
	movl $0, %eax
	call printf@PLT
	movl $4, %ebx
	leaq _gp+4(%rip), %rcx
	movslq %ebx, %rbx
	subq $5, %rbx
	imulq $4, %rbx
	addq %rbx, %rcx
	movl $4, %ebx
	movl %ebx, (%rcx)
	leaq .string_const0(%rip), %rdi
	leaq .string_const1(%rip), %rsi
	call printf@PLT
	leaq _gp(%rip), %rbx
	addq $0, %rbx
	movl (%rbx), %ecx
	leaq .string_const2(%rip), %rdi
	movl %ecx, %esi
	movl $0, %eax
	call printf@PLT
	leaq _gp(%rip), %rbx
	addq $60, %rbx
	movl $100, %ecx
	movl %ecx, (%rbx)
	leaq _gp(%rip), %rbx
	addq $64, %rbx
	movl $4, %ecx
	movl %ecx, (%rbx)
	.L3:	nop
	leaq _gp(%rip), %rbx
	addq $64, %rbx
	movl (%rbx), %ecx
	movl $16, %ebx
	cmpl %ebx, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmovle %ebx, %ecx
	movl $-1, %ebx
	testl %ebx, %ecx
	je .L4
	leaq .string_const0(%rip), %rdi
	leaq .string_const3(%rip), %rsi
	call printf@PLT
	leaq _gp(%rip), %rbx
	addq $64, %rbx
	movl (%rbx), %ecx
	leaq .string_const4(%rip), %rdi
	movl %ecx, %esi
	movl $0, %eax
	call printf@PLT
	leaq .string_const0(%rip), %rdi
	leaq .string_const5(%rip), %rsi
	call printf@PLT
	leaq _gp(%rip), %rbx
	addq $64, %rbx
	movl (%rbx), %ecx
	leaq _gp+4(%rip), %rbx
	movslq %ecx, %rcx
	subq $5, %rcx
	imulq $4, %rcx
	addq %rcx, %rbx
	movl (%rbx), %ecx
	leaq .string_const2(%rip), %rdi
	movl %ecx, %esi
	movl $0, %eax
	call printf@PLT
	leaq _gp(%rip), %rbx
	addq $64, %rbx
	leaq _gp(%rip), %rcx
	addq $64, %rcx
	movl (%rcx), %r8d
	movl $1, %ecx
	addl %ecx, %r8d
	movl %r8d, (%rbx)
	jmp .L3
	.L4:	nop
	leave
	ret
