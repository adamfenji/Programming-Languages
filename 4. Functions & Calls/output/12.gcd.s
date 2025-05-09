	.section	.rodata
	.comm _gp, 8, 4
	.string_const0: .string "%s"
	.string_const1: .string "x="
	.string_const2: .string "%d"
	.string_const3: .string "y="
	.string_const4: .string "gcd="
	.string_const5: .string "%d\n"
	.text
	.globl gcd
	.type gcd,@function
gcd:	nop
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	subq $8, %rsp
	leaq _gp(%rip), %rbx
	addq $4, %rbx
	movl (%rbx), %ecx
	movl $0, %ebx
	cmpl %ebx, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmove %ebx, %ecx
	movl $-1, %ebx
	testl %ecx, %ebx
	je .L0
	leaq _gp(%rip), %rbx
	addq $0, %rbx
	movl (%rbx), %ecx
	movl %ecx, %eax
	jmp .L1
.L0:	 nop
	movq %rbp, %rbx
	addq $-4, %rbx
	leaq _gp(%rip), %rcx
	addq $0, %rcx
	movl (%rcx), %r8d
	movl %r8d, (%rbx)
	leaq _gp(%rip), %rbx
	addq $0, %rbx
	leaq _gp(%rip), %rcx
	addq $4, %rcx
	movl (%rcx), %r8d
	movl %r8d, (%rbx)
	leaq _gp(%rip), %rbx
	addq $4, %rbx
	movq %rbp, %rcx
	addq $-4, %rcx
	movl (%rcx), %r8d
	leaq _gp(%rip), %rcx
	addq $4, %rcx
	movl (%rcx), %r9d
	movq %rbp, %rcx
	addq $-4, %rcx
	movl (%rcx), %r10d
	leaq _gp(%rip), %rcx
	addq $4, %rcx
	movl (%rcx), %r11d
	movl %r10d, %eax
	cdq
	idivl %r11d
	movl %eax, %r10d
	imull %r10d, %r9d
	subl %r9d, %r8d
	movl %r8d, (%rbx)
	pushq %r8
	pushq %r9
	pushq %r10
	pushq %r11
	call gcd
	popq %r11
	popq %r10
	popq %r9
	popq %r8
	movl %eax, %ebx
	movl %ebx, %eax
.L1:	 nop
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
	leaq .string_const0(%rip), %rdi
	leaq .string_const1(%rip), %rsi
	call printf@PLT
	leaq _gp(%rip), %rbx
	addq $0, %rbx
	leaq .string_const2(%rip), %rdi
	movq %rbx, %rsi
	movl $0, %eax
	call scanf@PLT
	leaq .string_const0(%rip), %rdi
	leaq .string_const3(%rip), %rsi
	call printf@PLT
	leaq _gp(%rip), %rbx
	addq $4, %rbx
	leaq .string_const2(%rip), %rdi
	movq %rbx, %rsi
	movl $0, %eax
	call scanf@PLT
.L2:	nop
	leaq _gp(%rip), %rbx
	addq $0, %rbx
	movl (%rbx), %ecx
	movl $0, %ebx
	cmpl %ebx, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmovne %ebx, %ecx
	leaq _gp(%rip), %rbx
	addq $4, %rbx
	movl (%rbx), %r8d
	movl $0, %ebx
	cmpl %ebx, %r8d
	movl $0, %r8d
	movl $1, %ebx
	cmovne %ebx, %r8d
	orl %r8d, %ecx
	movl $-1, %ebx
	testl %ecx, %ebx
	je .L3
	leaq .string_const0(%rip), %rdi
	leaq .string_const4(%rip), %rsi
	call printf@PLT
	pushq %r8
	pushq %r9
	pushq %r10
	pushq %r11
	call gcd
	popq %r11
	popq %r10
	popq %r9
	popq %r8
	movl %eax, %ebx
	leaq .string_const5(%rip), %rdi
	movl %ebx, %esi
	movl $0, %eax
	call printf@PLT
	leaq .string_const0(%rip), %rdi
	leaq .string_const1(%rip), %rsi
	call printf@PLT
	leaq _gp(%rip), %rbx
	addq $0, %rbx
	leaq .string_const2(%rip), %rdi
	movq %rbx, %rsi
	movl $0, %eax
	call scanf@PLT
	leaq .string_const0(%rip), %rdi
	leaq .string_const3(%rip), %rsi
	call printf@PLT
	leaq _gp(%rip), %rbx
	addq $4, %rbx
	leaq .string_const2(%rip), %rdi
	movq %rbx, %rsi
	movl $0, %eax
	call scanf@PLT
	jmp .L2
.L3:	 nop
	leave
	ret
