	.section	.rodata
	.comm _gp, 732, 4
	.string_const0: .string "%d"
	.string_const1: .string "%s"
	.string_const2: .string "  "
	.string_const3: .string "%s\n"
	.string_const4: .string "|"
	.string_const5: .string "*"
	.string_const6: .string "="
	.text
	.globl vectormul
	.type vectormul,@function
vectormul:	nop
	pushq %rbp
	movq %rsp, %rbp
	subq $64, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	subq $8, %rsp
	movq %rbp, %rbx
	addq $-40, %rbx
	movl $2, %ecx
	movl %ecx, (%rbx)
.L0:	nop
	movq %rbp, %rbx
	addq $-40, %rbx
	movl (%rbx), %ecx
	movl $9, %ebx
	cmpl %ebx, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmovle %ebx, %ecx
	movl $-1, %ebx
	testl %ecx, %ebx
	je .L1
	movq %rbp, %rbx
	addq $-40, %rbx
	movl (%rbx), %ecx
	movq %rbp, %rbx
	addq $-36, %rbx
	movslq %ecx, %rcx
	subq $2, %rcx
	imulq $4, %rcx
	addq %rcx, %rbx
	movq %rbp, %rcx
	addq $-40, %rcx
	movl (%rcx), %r8d
	movq %rbp, %rcx
	addq $-40, %rcx
	movl (%rcx), %r9d
	imull %r9d, %r8d
	movl %r8d, (%rbx)
	movq %rbp, %rbx
	addq $-40, %rbx
	movl (%rbx), %ecx
	movq %rbp, %rbx
	addq $-36, %rbx
	movslq %ecx, %rcx
	subq $2, %rcx
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
	addq $-40, %rbx
	movq %rbp, %rcx
	addq $-40, %rcx
	movl (%rcx), %r8d
	movl $1, %ecx
	addl %ecx, %r8d
	movl %r8d, (%rbx)
	jmp .L0
.L1:	 nop
	leaq .string_const3(%rip), %rdi
	leaq .string_const4(%rip), %rsi
	call printf@PLT
	movq %rbp, %rbx
	addq $-36, %rbx
	movl $1, %ecx
	movl %ecx, (%rbx)
.L2:	nop
	movq %rbp, %rbx
	addq $-36, %rbx
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
	addq $-40, %rbx
	movl $1, %ecx
	movl %ecx, (%rbx)
	movq %rbp, %rbx
	addq $-44, %rbx
	movl $0, %ecx
	movl %ecx, (%rbx)
.L4:	nop
	movq %rbp, %rbx
	addq $-40, %rbx
	movl (%rbx), %ecx
	movl $8, %ebx
	cmpl %ebx, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmovle %ebx, %ecx
	movl $-1, %ebx
	testl %ecx, %ebx
	je .L5
	movq %rbp, %rbx
	addq $-44, %rbx
	movq %rbp, %rcx
	addq $-44, %rcx
	movl (%rcx), %r8d
	movq %rbp, %rcx
	addq $-36, %rcx
	movl (%rcx), %r9d
	movq %rbp, %rcx
	addq $-40, %rcx
	movl (%rcx), %r10d
	leaq _gp(%rip), %rcx
	addq $0, %rcx
	movslq %r9d, %r9
	subq $1, %r9
	movq $8, %r11
	imulq %r11, %r9
	movslq %r10d, %r10
	addq %r10, %r9
	subq $1, %r9
	imulq $4, %r9
	addq %r9, %rcx
	movl (%rcx), %r9d
	movq %rbp, %rcx
	addq $-40, %rcx
	movl (%rcx), %r10d
	movl $1, %ecx
	addl %ecx, %r10d
	movq %rbp, %rcx
	addq $-36, %rcx
	movslq %r10d, %r10
	subq $2, %r10
	imulq $4, %r10
	addq %r10, %rcx
	movl (%rcx), %r10d
	imull %r10d, %r9d
	addl %r9d, %r8d
	movl %r8d, (%rbx)
	movq %rbp, %rbx
	addq $-40, %rbx
	movq %rbp, %rcx
	addq $-40, %rcx
	movl (%rcx), %r8d
	movl $1, %ecx
	addl %ecx, %r8d
	movl %r8d, (%rbx)
	jmp .L4
.L5:	 nop
	movq %rbp, %rbx
	addq $-36, %rbx
	movl (%rbx), %ecx
	leaq _gp(%rip), %rbx
	addq $640, %rbx
	movslq %ecx, %rcx
	subq $1, %rcx
	imulq $4, %rcx
	addq %rcx, %rbx
	movq %rbp, %rcx
	addq $-44, %rcx
	movl (%rcx), %r8d
	movl %r8d, (%rbx)
	movq %rbp, %rbx
	addq $-36, %rbx
	movq %rbp, %rcx
	addq $-36, %rcx
	movl (%rcx), %r8d
	movl $1, %ecx
	addl %ecx, %r8d
	movl %r8d, (%rbx)
	jmp .L2
.L3:	 nop
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
	addq $720, %rbx
	movl $1, %ecx
	movl %ecx, (%rbx)
.L6:	nop
	leaq _gp(%rip), %rbx
	addq $720, %rbx
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
	addq $724, %rbx
	movl $1, %ecx
	movl %ecx, (%rbx)
.L8:	nop
	leaq _gp(%rip), %rbx
	addq $724, %rbx
	movl (%rbx), %ecx
	movl $8, %ebx
	cmpl %ebx, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmovle %ebx, %ecx
	movl $-1, %ebx
	testl %ecx, %ebx
	je .L9
	leaq _gp(%rip), %rbx
	addq $720, %rbx
	movl (%rbx), %ecx
	leaq _gp(%rip), %rbx
	addq $724, %rbx
	movl (%rbx), %r8d
	leaq _gp(%rip), %rbx
	addq $0, %rbx
	movslq %ecx, %rcx
	subq $1, %rcx
	movq $8, %r9
	imulq %r9, %rcx
	movslq %r8d, %r8
	addq %r8, %rcx
	subq $1, %rcx
	imulq $4, %rcx
	addq %rcx, %rbx
	leaq _gp(%rip), %rcx
	addq $720, %rcx
	movl (%rcx), %r8d
	movl $8, %ecx
	imull %ecx, %r8d
	leaq _gp(%rip), %rcx
	addq $724, %rcx
	movl (%rcx), %r9d
	addl %r9d, %r8d
	movl %r8d, (%rbx)
	leaq _gp(%rip), %rbx
	addq $720, %rbx
	movl (%rbx), %ecx
	leaq _gp(%rip), %rbx
	addq $724, %rbx
	movl (%rbx), %r8d
	leaq _gp(%rip), %rbx
	addq $0, %rbx
	movslq %ecx, %rcx
	subq $1, %rcx
	movq $8, %r9
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
	leaq _gp(%rip), %rbx
	addq $724, %rbx
	leaq _gp(%rip), %rcx
	addq $724, %rcx
	movl (%rcx), %r8d
	movl $1, %ecx
	addl %ecx, %r8d
	movl %r8d, (%rbx)
	jmp .L8
.L9:	 nop
	leaq .string_const3(%rip), %rdi
	leaq .string_const4(%rip), %rsi
	call printf@PLT
	leaq _gp(%rip), %rbx
	addq $720, %rbx
	leaq _gp(%rip), %rcx
	addq $720, %rcx
	movl (%rcx), %r8d
	movl $1, %ecx
	addl %ecx, %r8d
	movl %r8d, (%rbx)
	jmp .L6
.L7:	 nop
	leaq .string_const3(%rip), %rdi
	leaq .string_const5(%rip), %rsi
	call printf@PLT
	leaq _gp(%rip), %rbx
	addq $728, %rbx
	pushq %r8
	pushq %r9
	pushq %r10
	pushq %r11
	call vectormul
	popq %r11
	popq %r10
	popq %r9
	popq %r8
	movl %eax, %ecx
	movl %ecx, (%rbx)
	leaq .string_const3(%rip), %rdi
	leaq .string_const6(%rip), %rsi
	call printf@PLT
.L10:	nop
	leaq _gp(%rip), %rbx
	addq $728, %rbx
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
	addq $728, %rbx
	movl (%rbx), %ecx
	leaq _gp(%rip), %rbx
	addq $640, %rbx
	movslq %ecx, %rcx
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
	leaq _gp(%rip), %rbx
	addq $728, %rbx
	leaq _gp(%rip), %rcx
	addq $728, %rcx
	movl (%rcx), %r8d
	movl $1, %ecx
	addl %ecx, %r8d
	movl %r8d, (%rbx)
	jmp .L10
.L11:	 nop
	leaq .string_const3(%rip), %rdi
	leaq .string_const4(%rip), %rsi
	call printf@PLT
	leave
	ret
