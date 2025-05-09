	.section	.rodata
	.comm _gp, 4, 4
	.string_const0: .string "%d"
	.string_const1: .string "%s\n"
	.string_const2: .string "Your code should not reach here!"
	.text
	.globl hacked
	.type hacked,@function
hacked:	nop
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	subq $8, %rsp
	leaq _gp(%rip), %rbx
	addq $0, %rbx
	pushq %r8
	pushq %r9
	pushq %r10
	pushq %r11
	call foo
	popq %r11
	popq %r10
	popq %r9
	popq %r8
	movl %eax, %ecx
	movl %ecx, (%rbx)
	movl $7, %ebx
	movq %rbp, %rcx
	addq $-20, %rcx
	movslq %ebx, %rbx
	subq $1, %rbx
	imulq $4, %rbx
	addq %rbx, %rcx
	leaq .string_const0(%rip), %rdi
	movq %rcx, %rsi
	movl $0, %eax
	call scanf@PLT
	movl $8, %ebx
	movq %rbp, %rcx
	addq $-20, %rcx
	movslq %ebx, %rbx
	subq $1, %rbx
	imulq $4, %rbx
	addq %rbx, %rcx
	leaq .string_const0(%rip), %rdi
	movq %rcx, %rsi
	movl $0, %eax
	call scanf@PLT
	leaq _gp(%rip), %rbx
	addq $0, %rbx
	movl (%rbx), %ecx
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
	pushq %r8
	pushq %r9
	pushq %r10
	pushq %r11
	call hacked
	popq %r11
	popq %r10
	popq %r9
	popq %r8
	movl %eax, %ecx
	movl %ecx, (%rbx)
	leaq .string_const1(%rip), %rdi
	leaq .string_const2(%rip), %rsi
	call printf@PLT
	leave
	ret
