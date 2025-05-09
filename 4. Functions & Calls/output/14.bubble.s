	.section	.rodata
	.comm _gp, 96, 4
	.string_const0: .string "%d\n"
	.string_const1: .string "%s"
	.string_const2: .string "Enter a[3:7]:"
	.string_const3: .string "%d"
	.text
	.globl sort
	.type sort,@function
sort:	nop
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	subq $8, %rsp
	movq %rbp, %rbx
	addq $-4, %rbx
	leaq _gp(%rip), %rcx
	addq $84, %rcx
	movl (%rcx), %r8d
	movl %r8d, (%rbx)
	leaq _gp(%rip), %rbx
	addq $84, %rbx
	movl (%rbx), %ecx
	leaq .string_const0(%rip), %rdi
	movl %ecx, %esi
	movl $0, %eax
	call printf@PLT
	leaq _gp(%rip), %rbx
	addq $88, %rbx
	movl (%rbx), %ecx
	leaq .string_const0(%rip), %rdi
	movl %ecx, %esi
	movl $0, %eax
	call printf@PLT
.L0:	nop
	movq %rbp, %rbx
	addq $-4, %rbx
	movl (%rbx), %ecx
	leaq _gp(%rip), %rbx
	addq $88, %rbx
	movl (%rbx), %r8d
	cmpl %r8d, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmovl %ebx, %ecx
	movl $-1, %ebx
	testl %ecx, %ebx
	je .L1
	movq %rbp, %rbx
	addq $-16, %rbx
	movq %rbp, %rcx
	addq $-4, %rcx
	movl (%rcx), %r8d
	movl %r8d, (%rbx)
	movq %rbp, %rbx
	addq $-8, %rbx
	movq %rbp, %rcx
	addq $-4, %rcx
	movl (%rcx), %r8d
	movl $1, %ecx
	addl %ecx, %r8d
	movl %r8d, (%rbx)
.L2:	nop
	movq %rbp, %rbx
	addq $-8, %rbx
	movl (%rbx), %ecx
	leaq _gp(%rip), %rbx
	addq $88, %rbx
	movl (%rbx), %r8d
	cmpl %r8d, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmovle %ebx, %ecx
	movl $-1, %ebx
	testl %ecx, %ebx
	je .L3
	movq %rbp, %rbx
	addq $-8, %rbx
	movl (%rbx), %ecx
	leaq _gp(%rip), %rbx
	addq $0, %rbx
	movslq %ecx, %rcx
	subq $1, %rcx
	imulq $4, %rcx
	addq %rcx, %rbx
	movl (%rbx), %ecx
	movq %rbp, %rbx
	addq $-16, %rbx
	movl (%rbx), %r8d
	leaq _gp(%rip), %rbx
	addq $0, %rbx
	movslq %r8d, %r8
	subq $1, %r8
	imulq $4, %r8
	addq %r8, %rbx
	movl (%rbx), %r8d
	cmpl %r8d, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmovl %ebx, %ecx
	movl $-1, %ebx
	testl %ecx, %ebx
	je .L4
	movq %rbp, %rbx
	addq $-16, %rbx
	movq %rbp, %rcx
	addq $-8, %rcx
	movl (%rcx), %r8d
	movl %r8d, (%rbx)
	jmp .L5
.L4:	 nop
.L5:	 nop
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
	movq %rbp, %rbx
	addq $-12, %rbx
	movq %rbp, %rcx
	addq $-4, %rcx
	movl (%rcx), %r8d
	leaq _gp(%rip), %rcx
	addq $0, %rcx
	movslq %r8d, %r8
	subq $1, %r8
	imulq $4, %r8
	addq %r8, %rcx
	movl (%rcx), %r8d
	movl %r8d, (%rbx)
	movq %rbp, %rbx
	addq $-4, %rbx
	movl (%rbx), %ecx
	leaq _gp(%rip), %rbx
	addq $0, %rbx
	movslq %ecx, %rcx
	subq $1, %rcx
	imulq $4, %rcx
	addq %rcx, %rbx
	movq %rbp, %rcx
	addq $-16, %rcx
	movl (%rcx), %r8d
	leaq _gp(%rip), %rcx
	addq $0, %rcx
	movslq %r8d, %r8
	subq $1, %r8
	imulq $4, %r8
	addq %r8, %rcx
	movl (%rcx), %r8d
	movl %r8d, (%rbx)
	movq %rbp, %rbx
	addq $-16, %rbx
	movl (%rbx), %ecx
	leaq _gp(%rip), %rbx
	addq $0, %rbx
	movslq %ecx, %rcx
	subq $1, %rcx
	imulq $4, %rcx
	addq %rcx, %rbx
	movq %rbp, %rcx
	addq $-12, %rcx
	movl (%rcx), %r8d
	movl %r8d, (%rbx)
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
	.globl output
	.type output,@function
output:	nop
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
	addq $92, %rbx
	movl $1, %ecx
	movl %ecx, (%rbx)
.L6:	nop
	leaq _gp(%rip), %rbx
	addq $92, %rbx
	movl (%rbx), %ecx
	movl $20, %ebx
	cmpl %ebx, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmovle %ebx, %ecx
	movl $-1, %ebx
	testl %ecx, %ebx
	je .L7
	leaq _gp(%rip), %rbx
	addq $92, %rbx
	movl (%rbx), %ecx
	leaq _gp(%rip), %rbx
	addq $0, %rbx
	movslq %ecx, %rcx
	subq $1, %rcx
	imulq $4, %rcx
	addq %rcx, %rbx
	movl (%rbx), %ecx
	leaq .string_const0(%rip), %rdi
	movl %ecx, %esi
	movl $0, %eax
	call printf@PLT
	leaq _gp(%rip), %rbx
	addq $92, %rbx
	leaq _gp(%rip), %rcx
	addq $92, %rcx
	movl (%rcx), %r8d
	movl $1, %ecx
	addl %ecx, %r8d
	movl %r8d, (%rbx)
	jmp .L6
.L7:	 nop
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
	.globl input
	.type input,@function
input:	nop
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
	addq $84, %rbx
	movl $3, %ecx
	movl %ecx, (%rbx)
	leaq _gp(%rip), %rbx
	addq $88, %rbx
	movl $7, %ecx
	movl %ecx, (%rbx)
	leaq _gp(%rip), %rbx
	addq $92, %rbx
	leaq _gp(%rip), %rcx
	addq $84, %rcx
	movl (%rcx), %r8d
	movl %r8d, (%rbx)
	leaq .string_const1(%rip), %rdi
	leaq .string_const2(%rip), %rsi
	call printf@PLT
.L8:	nop
	leaq _gp(%rip), %rbx
	addq $92, %rbx
	movl (%rbx), %ecx
	leaq _gp(%rip), %rbx
	addq $88, %rbx
	movl (%rbx), %r8d
	cmpl %r8d, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmovle %ebx, %ecx
	movl $-1, %ebx
	testl %ecx, %ebx
	je .L9
	leaq _gp(%rip), %rbx
	addq $92, %rbx
	movl (%rbx), %ecx
	leaq _gp(%rip), %rbx
	addq $0, %rbx
	movslq %ecx, %rcx
	subq $1, %rcx
	imulq $4, %rcx
	addq %rcx, %rbx
	leaq .string_const3(%rip), %rdi
	movq %rbx, %rsi
	movl $0, %eax
	call scanf@PLT
	leaq _gp(%rip), %rbx
	addq $92, %rbx
	leaq _gp(%rip), %rcx
	addq $92, %rcx
	movl (%rcx), %r8d
	movl $1, %ecx
	addl %ecx, %r8d
	movl %r8d, (%rbx)
	jmp .L8
.L9:	 nop
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
	.globl initialize
	.type initialize,@function
initialize:	nop
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
	addq $92, %rbx
	movl $1, %ecx
	movl %ecx, (%rbx)
.L10:	nop
	leaq _gp(%rip), %rbx
	addq $92, %rbx
	movl (%rbx), %ecx
	movl $20, %ebx
	cmpl %ebx, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmovle %ebx, %ecx
	movl $-1, %ebx
	testl %ecx, %ebx
	je .L11
	leaq _gp(%rip), %rbx
	addq $92, %rbx
	movl (%rbx), %ecx
	leaq _gp(%rip), %rbx
	addq $0, %rbx
	movslq %ecx, %rcx
	subq $1, %rcx
	imulq $4, %rcx
	addq %rcx, %rbx
	movl $0, %ecx
	movl %ecx, (%rbx)
	leaq _gp(%rip), %rbx
	addq $92, %rbx
	leaq _gp(%rip), %rcx
	addq $92, %rcx
	movl (%rcx), %r8d
	movl $1, %ecx
	addl %ecx, %r8d
	movl %r8d, (%rbx)
	jmp .L10
.L11:	 nop
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
	leaq _gp(%rip), %rbx
	addq $80, %rbx
	pushq %r8
	pushq %r9
	pushq %r10
	pushq %r11
	call initialize
	popq %r11
	popq %r10
	popq %r9
	popq %r8
	movl %eax, %ecx
	movl %ecx, (%rbx)
	leaq _gp(%rip), %rbx
	addq $80, %rbx
	pushq %r8
	pushq %r9
	pushq %r10
	pushq %r11
	call output
	popq %r11
	popq %r10
	popq %r9
	popq %r8
	movl %eax, %ecx
	movl %ecx, (%rbx)
	leaq _gp(%rip), %rbx
	addq $80, %rbx
	pushq %r8
	pushq %r9
	pushq %r10
	pushq %r11
	call input
	popq %r11
	popq %r10
	popq %r9
	popq %r8
	movl %eax, %ecx
	movl %ecx, (%rbx)
	leaq _gp(%rip), %rbx
	addq $80, %rbx
	pushq %r8
	pushq %r9
	pushq %r10
	pushq %r11
	call output
	popq %r11
	popq %r10
	popq %r9
	popq %r8
	movl %eax, %ecx
	movl %ecx, (%rbx)
	leaq _gp(%rip), %rbx
	addq $80, %rbx
	pushq %r8
	pushq %r9
	pushq %r10
	pushq %r11
	call sort
	popq %r11
	popq %r10
	popq %r9
	popq %r8
	movl %eax, %ecx
	movl %ecx, (%rbx)
	leaq _gp(%rip), %rbx
	addq $80, %rbx
	pushq %r8
	pushq %r9
	pushq %r10
	pushq %r11
	call output
	popq %r11
	popq %r10
	popq %r9
	popq %r8
	movl %eax, %ecx
	movl %ecx, (%rbx)
	leave
	ret
