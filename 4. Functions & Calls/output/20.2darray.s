	.section	.rodata
	.comm _gp, 800, 4
	.string_const0: .string "%s"
	.string_const1: .string "input a[3, 5] = "
	.string_const2: .string "%d"
	.string_const3: .string "you input "
	.string_const4: .string "%d\n"
	.text
	.globl local
	.type local,@function
local:	nop
	pushq %rbp
	movq %rsp, %rbp
	subq $816, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	subq $8, %rsp
	leaq .string_const0(%rip), %rdi
	leaq .string_const1(%rip), %rsi
	call printf@PLT
	movl $3, %ebx
	movl $5, %ecx
	leaq _gp(%rip), %r8
	addq $0, %r8
	movslq %ebx, %rbx
	subq $1, %rbx
	movq $20, %r9
	imulq %r9, %rbx
	movslq %ecx, %rcx
	addq %rcx, %rbx
	subq $1, %rbx
	imulq $4, %rbx
	addq %rbx, %r8
	leaq .string_const2(%rip), %rdi
	movq %r8, %rsi
	movl $0, %eax
	call scanf@PLT
	leaq .string_const0(%rip), %rdi
	leaq .string_const3(%rip), %rsi
	call printf@PLT
	movl $3, %ebx
	movl $5, %ecx
	leaq _gp(%rip), %r8
	addq $0, %r8
	movslq %ebx, %rbx
	subq $1, %rbx
	movq $20, %r9
	imulq %r9, %rbx
	movslq %ecx, %rcx
	addq %rcx, %rbx
	subq $1, %rbx
	imulq $4, %rbx
	addq %rbx, %r8
	movl (%r8), %ebx
	leaq .string_const4(%rip), %rdi
	movl %ebx, %esi
	movl $0, %eax
	call printf@PLT
	movl $3, %ebx
	movl $5, %ecx
	leaq _gp(%rip), %r8
	addq $0, %r8
	movslq %ebx, %rbx
	subq $1, %rbx
	movq $20, %r9
	imulq %r9, %rbx
	movslq %ecx, %rcx
	addq %rcx, %rbx
	subq $1, %rbx
	imulq $4, %rbx
	addq %rbx, %r8
	movl (%r8), %ebx
	movl %ebx, %eax
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
	movl $3, %ebx
	movl $5, %ecx
	leaq _gp(%rip), %r8
	addq $0, %r8
	movslq %ebx, %rbx
	subq $1, %rbx
	movq $20, %r9
	imulq %r9, %rbx
	movslq %ecx, %rcx
	addq %rcx, %rbx
	subq $1, %rbx
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
	movq $20, %r9
	imulq %r9, %rbx
	movslq %ecx, %rcx
	addq %rcx, %rbx
	subq $1, %rbx
	imulq $4, %rbx
	addq %rbx, %r8
	movl (%r8), %ebx
	pushq %r8
	pushq %r9
	pushq %r10
	pushq %r11
	call local
	popq %r11
	popq %r10
	popq %r9
	popq %r8
	movl %eax, %ecx
	addl %ecx, %ebx
	leaq .string_const4(%rip), %rdi
	movl %ebx, %esi
	movl $0, %eax
	call printf@PLT
	leave
	ret
