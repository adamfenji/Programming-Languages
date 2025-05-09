	.section	.rodata
	.comm _gp, 8, 4
	.string_const0: .string "%d\n"
	.text
	.globl main
	.type main,@function
main:	nop
	pushq %rbp
	movq %rsp, %rbp
	leaq _gp(%rip), %rbx
	addq $0, %rbx
	movl $0, %ecx
	movl %ecx, (%rbx)
	leaq _gp(%rip), %rbx
	addq $4, %rbx
	movl $0, %ecx
	movl $2, %r8d
	subl %r8d, %ecx
	movl %ecx, (%rbx)
	leaq _gp(%rip), %rbx
	addq $0, %rbx
	movl (%rbx), %ecx
	movl $-1, %ebx
	testl %ebx, %ecx
	je .L1
	movl $1, %ebx
	leaq .string_const0(%rip), %rdi
	movl %ebx, %esi
	movl $0, %eax
	call printf@PLT
	jmp .L2
	.L1:	nop
	movl $0, %ebx
	leaq .string_const0(%rip), %rdi
	movl %ebx, %esi
	movl $0, %eax
	call printf@PLT
	.L2:	nop
	leaq _gp(%rip), %rbx
	addq $4, %rbx
	movl (%rbx), %ecx
	movl $0, %ebx
	cmpl %ebx, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmovl %ebx, %ecx
	movl $-1, %ebx
	testl %ebx, %ecx
	je .L3
	leaq _gp(%rip), %rbx
	addq $0, %rbx
	movl (%rbx), %ecx
	movl $-1, %ebx
	testl %ebx, %ecx
	je .L4
	movl $0, %ebx
	leaq .string_const0(%rip), %rdi
	movl %ebx, %esi
	movl $0, %eax
	call printf@PLT
	jmp .L5
	.L4:	nop
	movl $1, %ebx
	leaq .string_const0(%rip), %rdi
	movl %ebx, %esi
	movl $0, %eax
	call printf@PLT
	.L5:	nop
	jmp .L6
	.L3:	nop
	movl $0, %ebx
	leaq .string_const0(%rip), %rdi
	movl %ebx, %esi
	movl $0, %eax
	call printf@PLT
	.L6:	nop
	leave
	ret
