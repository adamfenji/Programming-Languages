	.section	.rodata
	.comm _gp, 1760, 4
	.string_const0: .string "%d"
	.string_const1: .string "%s"
	.string_const2: .string "  "
	.string_const3: .string "%s\n"
	.string_const4: .string "*"
	.string_const5: .string "input a factor (2-10):"
	.string_const6: .string "* "
	.string_const7: .string "="
	.string_const8: .string "%d\n"
	.text
	.globl init
	.type init,@function
init:	nop
	pushq %rbp
	movq %rsp, %rbp
	subq $896, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	subq $8, %rsp
	movq %rbp, %rbx
	addq $-884, %rbx
	movl $1, %ecx
	movl %ecx, (%rbx)
.L0:	nop
	movq %rbp, %rbx
	addq $-884, %rbx
	movl (%rbx), %ecx
	movl $20, %ebx
	cmpl %ebx, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmovle %ebx, %ecx
	movl $-1, %ebx
	testl %ecx, %ebx
	je .L1
	movq %rbp, %rbx
	addq $-888, %rbx
	movl $1, %ecx
	movl %ecx, (%rbx)
.L2:	nop
	movq %rbp, %rbx
	addq $-888, %rbx
	movl (%rbx), %ecx
	movl $11, %ebx
	cmpl %ebx, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmovle %ebx, %ecx
	movl $-1, %ebx
	testl %ecx, %ebx
	je .L3
	movq %rbp, %rbx
	addq $-884, %rbx
	movl (%rbx), %ecx
	movq %rbp, %rbx
	addq $-888, %rbx
	movl (%rbx), %r8d
	leaq _gp(%rip), %rbx
	addq $0, %rbx
	movslq %ecx, %rcx
	subq $1, %rcx
	movq $11, %r9
	imulq %r9, %rcx
	movslq %r8d, %r8
	addq %r8, %rcx
	subq $1, %rcx
	imulq $4, %rcx
	addq %rcx, %rbx
	movq %rbp, %rcx
	addq $-884, %rcx
	movl (%rcx), %r8d
	movl $11, %ecx
	imull %ecx, %r8d
	movq %rbp, %rcx
	addq $-888, %rcx
	movl (%rcx), %r9d
	addl %r9d, %r8d
	movl %r8d, (%rbx)
	movq %rbp, %rbx
	addq $-884, %rbx
	movl (%rbx), %ecx
	movq %rbp, %rbx
	addq $-888, %rbx
	movl (%rbx), %r8d
	leaq _gp(%rip), %rbx
	addq $0, %rbx
	movslq %ecx, %rcx
	subq $1, %rcx
	movq $11, %r9
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
	addq $-888, %rbx
	movq %rbp, %rcx
	addq $-888, %rcx
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
	addq $-884, %rbx
	movq %rbp, %rcx
	addq $-884, %rcx
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
	.globl compute
	.type compute,@function
compute:	nop
	pushq %rbp
	movq %rsp, %rbp
	subq $2672, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	subq $8, %rsp
	pushq %r8
	pushq %r9
	pushq %r10
	pushq %r11
	call init
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
	je .L4
	leaq .string_const1(%rip), %rdi
	leaq .string_const5(%rip), %rsi
	call printf@PLT
	movq %rbp, %rbx
	addq $-2660, %rbx
	leaq .string_const0(%rip), %rdi
	movq %rbx, %rsi
	movl $0, %eax
	call scanf@PLT
	movq %rbp, %rbx
	addq $-2652, %rbx
	movl $1, %ecx
	movl %ecx, (%rbx)
.L5:	nop
	movq %rbp, %rbx
	addq $-2652, %rbx
	movl (%rbx), %ecx
	movl $20, %ebx
	cmpl %ebx, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmovle %ebx, %ecx
	movl $-1, %ebx
	testl %ecx, %ebx
	je .L6
	movq %rbp, %rbx
	addq $-2656, %rbx
	movl $1, %ecx
	movl %ecx, (%rbx)
.L7:	nop
	movq %rbp, %rbx
	addq $-2656, %rbx
	movl (%rbx), %ecx
	movl $11, %ebx
	cmpl %ebx, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmovle %ebx, %ecx
	movl $-1, %ebx
	testl %ecx, %ebx
	je .L8
	movq %rbp, %rbx
	addq $-2652, %rbx
	movl (%rbx), %ecx
	movq %rbp, %rbx
	addq $-2656, %rbx
	movl (%rbx), %r8d
	leaq _gp(%rip), %rbx
	addq $0, %rbx
	movslq %ecx, %rcx
	subq $1, %rcx
	movq $11, %r9
	imulq %r9, %rcx
	movslq %r8d, %r8
	addq %r8, %rcx
	subq $1, %rcx
	imulq $4, %rcx
	addq %rcx, %rbx
	movq %rbp, %rcx
	addq $-2652, %rcx
	movl (%rcx), %r8d
	movq %rbp, %rcx
	addq $-2656, %rcx
	movl (%rcx), %r9d
	addl %r9d, %r8d
	movl %r8d, (%rbx)
	movq %rbp, %rbx
	addq $-2652, %rbx
	movl (%rbx), %ecx
	movq %rbp, %rbx
	addq $-2656, %rbx
	movl (%rbx), %r8d
	leaq _gp(%rip), %rbx
	addq $0, %rbx
	movslq %ecx, %rcx
	subq $1, %rcx
	movq $11, %r9
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
	addq $-2656, %rbx
	movq %rbp, %rcx
	addq $-2656, %rcx
	movl (%rcx), %r8d
	movl $1, %ecx
	addl %ecx, %r8d
	movl %r8d, (%rbx)
	jmp .L7
.L8:	 nop
	leaq .string_const3(%rip), %rdi
	leaq .string_const4(%rip), %rsi
	call printf@PLT
	movq %rbp, %rbx
	addq $-2652, %rbx
	movq %rbp, %rcx
	addq $-2652, %rcx
	movl (%rcx), %r8d
	movl $1, %ecx
	addl %ecx, %r8d
	movl %r8d, (%rbx)
	jmp .L5
.L6:	 nop
	leaq .string_const1(%rip), %rdi
	leaq .string_const6(%rip), %rsi
	call printf@PLT
	movq %rbp, %rbx
	addq $-2660, %rbx
	movl (%rbx), %ecx
	leaq .string_const0(%rip), %rdi
	movl %ecx, %esi
	movl $0, %eax
	call printf@PLT
	leaq .string_const3(%rip), %rdi
	leaq .string_const7(%rip), %rsi
	call printf@PLT
	movq %rbp, %rbx
	addq $-2652, %rbx
	movl $1, %ecx
	movl %ecx, (%rbx)
.L9:	nop
	movq %rbp, %rbx
	addq $-2652, %rbx
	movl (%rbx), %ecx
	movl $20, %ebx
	cmpl %ebx, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmovle %ebx, %ecx
	movl $-1, %ebx
	testl %ecx, %ebx
	je .L10
	movq %rbp, %rbx
	addq $-2656, %rbx
	movl $1, %ecx
	movl %ecx, (%rbx)
.L11:	nop
	movq %rbp, %rbx
	addq $-2656, %rbx
	movl (%rbx), %ecx
	movl $11, %ebx
	cmpl %ebx, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmovle %ebx, %ecx
	movl $-1, %ebx
	testl %ecx, %ebx
	je .L12
	movq %rbp, %rbx
	addq $-2652, %rbx
	movl (%rbx), %ecx
	movq %rbp, %rbx
	addq $-2656, %rbx
	movl (%rbx), %r8d
	leaq _gp(%rip), %rbx
	addq $880, %rbx
	movslq %ecx, %rcx
	subq $1, %rcx
	movq $11, %r9
	imulq %r9, %rcx
	movslq %r8d, %r8
	addq %r8, %rcx
	subq $1, %rcx
	imulq $4, %rcx
	addq %rcx, %rbx
	movq %rbp, %rcx
	addq $-2652, %rcx
	movl (%rcx), %r8d
	movq %rbp, %rcx
	addq $-2656, %rcx
	movl (%rcx), %r9d
	leaq _gp(%rip), %rcx
	addq $0, %rcx
	movslq %r8d, %r8
	subq $1, %r8
	movq $11, %r10
	imulq %r10, %r8
	movslq %r9d, %r9
	addq %r9, %r8
	subq $1, %r8
	imulq $4, %r8
	addq %r8, %rcx
	movl (%rcx), %r8d
	movq %rbp, %rcx
	addq $-2660, %rcx
	movl (%rcx), %r9d
	imull %r9d, %r8d
	movl %r8d, (%rbx)
	movq %rbp, %rbx
	addq $-2652, %rbx
	movl (%rbx), %ecx
	movq %rbp, %rbx
	addq $-2656, %rbx
	movl (%rbx), %r8d
	leaq _gp(%rip), %rbx
	addq $880, %rbx
	movslq %ecx, %rcx
	subq $1, %rcx
	movq $11, %r9
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
	addq $-2656, %rbx
	movq %rbp, %rcx
	addq $-2656, %rcx
	movl (%rcx), %r8d
	movl $1, %ecx
	addl %ecx, %r8d
	movl %r8d, (%rbx)
	jmp .L11
.L12:	 nop
	leaq .string_const3(%rip), %rdi
	leaq .string_const4(%rip), %rsi
	call printf@PLT
	movq %rbp, %rbx
	addq $-2652, %rbx
	movq %rbp, %rcx
	addq $-2652, %rcx
	movl (%rcx), %r8d
	movl $1, %ecx
	addl %ecx, %r8d
	movl %r8d, (%rbx)
	jmp .L9
.L10:	 nop
	jmp .L13
.L4:	 nop
.L13:	 nop
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
	call compute
	popq %r11
	popq %r10
	popq %r9
	popq %r8
	movl %eax, %ebx
	leaq .string_const8(%rip), %rdi
	movl %ebx, %esi
	movl $0, %eax
	call printf@PLT
	leave
	ret
