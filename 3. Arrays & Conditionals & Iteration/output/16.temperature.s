	.section	.rodata
	.comm _gp, 1372, 4
	.string_const0: .string "%10d"
	.string_const1: .string "%10d\n"
	.text
	.globl main
	.type main,@function
main:	nop
	pushq %rbp
	movq %rsp, %rbp
	leaq _gp(%rip), %rbx
	addq $456, %rbx
	movl $-10, %ecx
	movl %ecx, (%rbx)
	.L1:	nop
	leaq _gp(%rip), %rbx
	addq $456, %rbx
	movl (%rbx), %ecx
	movl $100, %ebx
	cmpl %ebx, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmovle %ebx, %ecx
	movl $-1, %ebx
	testl %ebx, %ecx
	je .L2
	leaq _gp(%rip), %rbx
	addq $456, %rbx
	movl (%rbx), %ecx
	leaq _gp+0(%rip), %rbx
	movslq %ecx, %rcx
	subq $-10, %rcx
	imulq $4, %rcx
	addq %rcx, %rbx
	leaq _gp(%rip), %rcx
	addq $456, %rcx
	movl (%rcx), %r8d
	movl %r8d, (%rbx)
	leaq _gp(%rip), %rbx
	addq $456, %rbx
	leaq _gp(%rip), %rcx
	addq $456, %rcx
	movl (%rcx), %r8d
	movl $1, %ecx
	addl %ecx, %r8d
	movl %r8d, (%rbx)
	jmp .L1
	.L2:	nop
	leaq _gp(%rip), %rbx
	addq $456, %rbx
	movl $100, %ecx
	movl %ecx, (%rbx)
	.L3:	nop
	leaq _gp(%rip), %rbx
	addq $456, %rbx
	movl (%rbx), %ecx
	movl $-10, %ebx
	cmpl %ebx, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmovge %ebx, %ecx
	movl $-1, %ebx
	testl %ebx, %ecx
	je .L4
	leaq _gp(%rip), %rbx
	addq $456, %rbx
	movl (%rbx), %ecx
	leaq _gp+460(%rip), %rbx
	movslq %ecx, %rcx
	subq $-10, %rcx
	imulq $4, %rcx
	addq %rcx, %rbx
	leaq _gp(%rip), %rcx
	addq $456, %rcx
	movl (%rcx), %r8d
	leaq _gp+0(%rip), %rcx
	movslq %r8d, %r8
	subq $-10, %r8
	imulq $4, %r8
	addq %r8, %rcx
	movl (%rcx), %r8d
	movl $32, %ecx
	subl %ecx, %r8d
	movl $10, %ecx
	imull %ecx, %r8d
	movl $18, %ecx
	movl %r8d, %eax
	cdq
	idivl %ecx
	movl %eax, %r8d
	movl %r8d, (%rbx)
	leaq _gp(%rip), %rbx
	addq $456, %rbx
	movl (%rbx), %ecx
	leaq _gp+916(%rip), %rbx
	movslq %ecx, %rcx
	subq $-10, %rcx
	imulq $4, %rcx
	addq %rcx, %rbx
	leaq _gp(%rip), %rcx
	addq $456, %rcx
	movl (%rcx), %r8d
	leaq _gp+460(%rip), %rcx
	movslq %r8d, %r8
	subq $-10, %r8
	imulq $4, %r8
	addq %r8, %rcx
	movl (%rcx), %r8d
	movl $0, %ecx
	cmpl %ecx, %r8d
	movl $0, %r8d
	movl $1, %ecx
	cmovl %ecx, %r8d
	movl %r8d, (%rbx)
	leaq _gp(%rip), %rbx
	addq $456, %rbx
	leaq _gp(%rip), %rcx
	addq $456, %rcx
	movl (%rcx), %r8d
	movl $1, %ecx
	subl %ecx, %r8d
	movl %r8d, (%rbx)
	jmp .L3
	.L4:	nop
	leaq _gp(%rip), %rbx
	addq $456, %rbx
	movl $-10, %ecx
	movl %ecx, (%rbx)
	.L5:	nop
	leaq _gp(%rip), %rbx
	addq $456, %rbx
	movl (%rbx), %ecx
	movl $100, %ebx
	cmpl %ebx, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmovle %ebx, %ecx
	movl $-1, %ebx
	testl %ebx, %ecx
	je .L6
	leaq _gp(%rip), %rbx
	addq $456, %rbx
	movl (%rbx), %ecx
	leaq _gp+0(%rip), %rbx
	movslq %ecx, %rcx
	subq $-10, %rcx
	imulq $4, %rcx
	addq %rcx, %rbx
	movl (%rbx), %ecx
	leaq .string_const0(%rip), %rdi
	movl %ecx, %esi
	movl $0, %eax
	call printf@PLT
	leaq _gp(%rip), %rbx
	addq $456, %rbx
	movl (%rbx), %ecx
	leaq _gp+460(%rip), %rbx
	movslq %ecx, %rcx
	subq $-10, %rcx
	imulq $4, %rcx
	addq %rcx, %rbx
	movl (%rbx), %ecx
	leaq .string_const0(%rip), %rdi
	movl %ecx, %esi
	movl $0, %eax
	call printf@PLT
	leaq _gp(%rip), %rbx
	addq $456, %rbx
	movl (%rbx), %ecx
	leaq _gp+916(%rip), %rbx
	movslq %ecx, %rcx
	subq $-10, %rcx
	imulq $4, %rcx
	addq %rcx, %rbx
	movl (%rbx), %ecx
	leaq .string_const1(%rip), %rdi
	movl %ecx, %esi
	movl $0, %eax
	call printf@PLT
	leaq _gp(%rip), %rbx
	addq $456, %rbx
	leaq _gp(%rip), %rcx
	addq $456, %rcx
	movl (%rcx), %r8d
	movl $1, %ecx
	addl %ecx, %r8d
	movl %r8d, (%rbx)
	jmp .L5
	.L6:	nop
	leave
	ret
