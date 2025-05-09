	.section	.rodata
	.comm _gp, 800, 4
	.string_const0: .string "%d"
	.string_const1: .string "%s"
	.string_const2: .string "  "
	.string_const3: .string "%s\n"
	.string_const4: .string "*"
	.string_const5: .string "column sum:"
	.string_const6: .string "%d\n"
	.text
	.globl initialize
	.type initialize,@function
initialize:	nop
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	subq $8, %rsp
	movq %rbp, %rbx
	addq $-4, %rbx
	movl $1, %ecx
	movl %ecx, (%rbx)
.L0:	nop
	movq %rbp, %rbx
	addq $-4, %rbx
	movl (%rbx), %ecx
	movl $10, %ebx
	cmpl %ebx, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmovle %ebx, %ecx
	movl $-1, %ebx
	testl %ecx, %ebx
	je .L1
	movq %rbp, %rbx
	addq $-8, %rbx
	movl $1, %ecx
	movl %ecx, (%rbx)
.L2:	nop
	movq %rbp, %rbx
	addq $-8, %rbx
	movl (%rbx), %ecx
	movl $20, %ebx
	cmpl %ebx, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmovle %ebx, %ecx
	movl $-1, %ebx
	testl %ecx, %ebx
	je .L3
	movq %rbp, %rbx
	addq $-4, %rbx
	movl (%rbx), %ecx
	movq %rbp, %rbx
	addq $-8, %rbx
	movl (%rbx), %r8d
	leaq _gp(%rip), %rbx
	addq $0, %rbx
	movslq %ecx, %rcx
	subq $1, %rcx
	movq $20, %r9
	imulq %r9, %rcx
	movslq %r8d, %r8
	addq %r8, %rcx
	subq $1, %rcx
	imulq $4, %rcx
	addq %rcx, %rbx
	movq %rbp, %rcx
	addq $-4, %rcx
	movl (%rcx), %r8d
	movl $20, %ecx
	imull %ecx, %r8d
	movq %rbp, %rcx
	addq $-8, %rcx
	movl (%rcx), %r9d
	addl %r9d, %r8d
	movl %r8d, (%rbx)
	movq %rbp, %rbx
	addq $-4, %rbx
	movl (%rbx), %ecx
	movq %rbp, %rbx
	addq $-8, %rbx
	movl (%rbx), %r8d
	leaq _gp(%rip), %rbx
	addq $0, %rbx
	movslq %ecx, %rcx
	subq $1, %rcx
	movq $20, %r9
	imulq %r9, %rcx
	movslq %r8d, %r8
	addq %r8, %rcx
	subq $1, %rcx
	imulq $4, %rcx
	addq %rcx, %rbx
	movl (%rbx), %ecx
	leaq .string_const0(%rip), %rdi
	movl %ecx, %esi
	movl $0, %eax
	call printf@PLT
	leaq .string_const1(%rip), %rdi
	leaq .string_const2(%rip), %rsi
	call printf@PLT
	movq %rbp, %rbx
	addq $-8, %rbx
	movq %rbp, %rcx
	addq $-8, %rcx
	movl (%rcx), %r8d
	movl $1, %ecx
	addl %ecx, %r8d
	movl %r8d, (%rbx)
	jmp .L2
.L3:	 nop
	leaq .string_const3(%rip), %rdi
	leaq .string_const4(%rip), %rsi
	call printf@PLT
	movq %rbp, %rbx
	addq $-4, %rbx
	movq %rbp, %rcx
	addq $-4, %rcx
	movl (%rcx), %r8d
	movl $1, %ecx
	addl %ecx, %r8d
	movl %r8d, (%rbx)
	jmp .L0
.L1:	 nop
	movl $1, %ebx
	movl %ebx, %eax
	addq $8, %rsp
	popq %r15
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
	.globl colsum
	.type colsum,@function
colsum:	nop
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	subq $8, %rsp
	leaq .string_const3(%rip), %rdi
	leaq .string_const5(%rip), %rsi
	call printf@PLT
	movq %rbp, %rbx
	addq $-16, %rbx
	movl $1, %ecx
	movl %ecx, (%rbx)
.L4:	nop
	movq %rbp, %rbx
	addq $-16, %rbx
	movl (%rbx), %ecx
	movl $20, %ebx
	cmpl %ebx, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmovle %ebx, %ecx
	movl $-1, %ebx
	testl %ecx, %ebx
	je .L5
	movq %rbp, %rbx
	addq $-12, %rbx
	movl $1, %ecx
	movl %ecx, (%rbx)
	movq %rbp, %rbx
	addq $-20, %rbx
	movl $0, %ecx
	movl %ecx, (%rbx)
.L6:	nop
	movq %rbp, %rbx
	addq $-12, %rbx
	movl (%rbx), %ecx
	movl $10, %ebx
	cmpl %ebx, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmovle %ebx, %ecx
	movl $-1, %ebx
	testl %ecx, %ebx
	je .L7
	movq %rbp, %rbx
	addq $-20, %rbx
	movq %rbp, %rcx
	addq $-20, %rcx
	movl (%rcx), %r8d
	movq %rbp, %rcx
	addq $-12, %rcx
	movl (%rcx), %r9d
	movq %rbp, %rcx
	addq $-16, %rcx
	movl (%rcx), %r10d
	leaq _gp(%rip), %rcx
	addq $0, %rcx
	movslq %r9d, %r9
	subq $1, %r9
	movq $20, %r11
	imulq %r11, %r9
	movslq %r10d, %r10
	addq %r10, %r9
	subq $1, %r9
	imulq $4, %r9
	addq %r9, %rcx
	movl (%rcx), %r9d
	addl %r9d, %r8d
	movl %r8d, (%rbx)
	movq %rbp, %rbx
	addq $-12, %rbx
	movq %rbp, %rcx
	addq $-12, %rcx
	movl (%rcx), %r8d
	movl $1, %ecx
	addl %ecx, %r8d
	movl %r8d, (%rbx)
	jmp .L6
.L7:	 nop
	movq %rbp, %rbx
	addq $-20, %rbx
	movl (%rbx), %ecx
	leaq .string_const0(%rip), %rdi
	movl %ecx, %esi
	movl $0, %eax
	call printf@PLT
	leaq .string_const1(%rip), %rdi
	leaq .string_const2(%rip), %rsi
	call printf@PLT
	movq %rbp, %rbx
	addq $-16, %rbx
	movq %rbp, %rcx
	addq $-16, %rcx
	movl (%rcx), %r8d
	movl $1, %ecx
	addl %ecx, %r8d
	movl %r8d, (%rbx)
	jmp .L4
.L5:	 nop
	leaq .string_const3(%rip), %rdi
	leaq .string_const4(%rip), %rsi
	call printf@PLT
	movl $1, %ebx
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
	pushq %r8
	pushq %r9
	pushq %r10
	pushq %r11
	call initialize
	popq %r11
	popq %r10
	popq %r9
	popq %r8
	movl %eax, %ebx
	movl $1, %ebx
	cmpl %ebx, %ebx
	movl $0, %ebx
	movl $1, %ebx
	cmove %ebx, %ebx
	movl $-1, %ebx
	testl %ebx, %ebx
	je .L8
	pushq %r8
	pushq %r9
	pushq %r10
	pushq %r11
	call colsum
	popq %r11
	popq %r10
	popq %r9
	popq %r8
	movl %eax, %ebx
	leaq .string_const6(%rip), %rdi
	movl %ebx, %esi
	movl $0, %eax
	call printf@PLT
	jmp .L9
.L8:	 nop
.L9:	 nop
	leave
	ret
