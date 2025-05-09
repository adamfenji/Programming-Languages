	.section	.rodata
	.comm _gp, 1580, 4
	.string_const0: .string "%s"
	.string_const1: .string "input a factor (2-10):"
	.string_const2: .string "%d"
	.string_const3: .string "  "
	.string_const4: .string "%s\n"
	.string_const5: .string "*"
	.string_const6: .string "* "
	.string_const7: .string "="
	.text
	.globl main
	.type main,@function
main:	nop
	pushq %rbp
	movq %rsp, %rbp
	leaq .string_const0(%rip), %rdi
	leaq .string_const1(%rip), %rsi
	call printf@PLT
	leaq _gp(%rip), %rbx
	addq $1576, %rbx
	leaq .string_const2(%rip), %rdi
	movq %rbx, %rsi
	movl $0, %eax
	call scanf@PLT
	leaq _gp(%rip), %rbx
	addq $1568, %rbx
	movl $1, %ecx
	movl %ecx, (%rbx)
	.L1:	nop
	leaq _gp(%rip), %rbx
	addq $1568, %rbx
	movl (%rbx), %ecx
	movl $20, %ebx
	cmpl %ebx, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmovle %ebx, %ecx
	movl $-1, %ebx
	testl %ebx, %ecx
	je .L2
	leaq _gp(%rip), %rbx
	addq $1572, %rbx
	movl $1, %ecx
	movl %ecx, (%rbx)
	.L3:	nop
	leaq _gp(%rip), %rbx
	addq $1572, %rbx
	movl (%rbx), %ecx
	movl $11, %ebx
	cmpl %ebx, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmovle %ebx, %ecx
	movl $-1, %ebx
	testl %ebx, %ecx
	je .L4
	leaq _gp(%rip), %rbx
	addq $1568, %rbx
	movl (%rbx), %ecx
	leaq _gp(%rip), %rbx
	addq $1572, %rbx
	movl (%rbx), %r8d
	leaq _gp(%rip), %rbx
	addq $0, %rbx
	movslq %ecx, %rcx
	subq $1, %rcx
	imulq $11, %rcx
	movslq %r8d, %r8
	subq $1, %r8
	addq %r8, %rcx
	imulq $4, %rcx
	addq %rcx, %rbx
	leaq _gp(%rip), %rcx
	addq $1568, %rcx
	movl (%rcx), %r8d
	movl $11, %ecx
	imull %ecx, %r8d
	leaq _gp(%rip), %rcx
	addq $1572, %rcx
	movl (%rcx), %r9d
	addl %r9d, %r8d
	movl %r8d, (%rbx)
	leaq _gp(%rip), %rbx
	addq $1568, %rbx
	movl (%rbx), %ecx
	leaq _gp(%rip), %rbx
	addq $1572, %rbx
	movl (%rbx), %r8d
	leaq _gp(%rip), %rbx
	addq $0, %rbx
	movslq %ecx, %rcx
	subq $1, %rcx
	imulq $11, %rcx
	movslq %r8d, %r8
	subq $1, %r8
	addq %r8, %rcx
	imulq $4, %rcx
	addq %rcx, %rbx
	movl (%rbx), %ecx
	leaq .string_const2(%rip), %rdi
	movl %ecx, %esi
	movl $0, %eax
	call printf@PLT
	leaq .string_const0(%rip), %rdi
	leaq .string_const3(%rip), %rsi
	call printf@PLT
	leaq _gp(%rip), %rbx
	addq $1572, %rbx
	leaq _gp(%rip), %rcx
	addq $1572, %rcx
	movl (%rcx), %r8d
	movl $1, %ecx
	addl %ecx, %r8d
	movl %r8d, (%rbx)
	jmp .L3
	.L4:	nop
	leaq .string_const4(%rip), %rdi
	leaq .string_const5(%rip), %rsi
	call printf@PLT
	leaq _gp(%rip), %rbx
	addq $1568, %rbx
	leaq _gp(%rip), %rcx
	addq $1568, %rcx
	movl (%rcx), %r8d
	movl $1, %ecx
	addl %ecx, %r8d
	movl %r8d, (%rbx)
	jmp .L1
	.L2:	nop
	leaq .string_const0(%rip), %rdi
	leaq .string_const6(%rip), %rsi
	call printf@PLT
	leaq _gp(%rip), %rbx
	addq $1576, %rbx
	movl (%rbx), %ecx
	leaq .string_const2(%rip), %rdi
	movl %ecx, %esi
	movl $0, %eax
	call printf@PLT
	leaq .string_const4(%rip), %rdi
	leaq .string_const7(%rip), %rsi
	call printf@PLT
	leaq _gp(%rip), %rbx
	addq $1568, %rbx
	movl $1, %ecx
	movl %ecx, (%rbx)
	.L5:	nop
	leaq _gp(%rip), %rbx
	addq $1568, %rbx
	movl (%rbx), %ecx
	movl $20, %ebx
	cmpl %ebx, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmovle %ebx, %ecx
	movl $-1, %ebx
	testl %ebx, %ecx
	je .L6
	leaq _gp(%rip), %rbx
	addq $1572, %rbx
	movl $1, %ecx
	movl %ecx, (%rbx)
	.L7:	nop
	leaq _gp(%rip), %rbx
	addq $1572, %rbx
	movl (%rbx), %ecx
	movl $11, %ebx
	cmpl %ebx, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmovle %ebx, %ecx
	movl $-1, %ebx
	testl %ebx, %ecx
	je .L8
	leaq _gp(%rip), %rbx
	addq $1568, %rbx
	movl (%rbx), %ecx
	leaq _gp(%rip), %rbx
	addq $1572, %rbx
	movl (%rbx), %r8d
	leaq _gp(%rip), %rbx
	addq $784, %rbx
	movslq %ecx, %rcx
	subq $1, %rcx
	imulq $11, %rcx
	movslq %r8d, %r8
	subq $1, %r8
	addq %r8, %rcx
	imulq $4, %rcx
	addq %rcx, %rbx
	leaq _gp(%rip), %rcx
	addq $1568, %rcx
	movl (%rcx), %r8d
	leaq _gp(%rip), %rcx
	addq $1572, %rcx
	movl (%rcx), %r9d
	leaq _gp(%rip), %rcx
	addq $0, %rcx
	movslq %r8d, %r8
	subq $1, %r8
	imulq $11, %r8
	movslq %r9d, %r9
	subq $1, %r9
	addq %r9, %r8
	imulq $4, %r8
	addq %r8, %rcx
	movl (%rcx), %r8d
	leaq _gp(%rip), %rcx
	addq $1576, %rcx
	movl (%rcx), %r9d
	imull %r9d, %r8d
	movl %r8d, (%rbx)
	leaq _gp(%rip), %rbx
	addq $1568, %rbx
	movl (%rbx), %ecx
	leaq _gp(%rip), %rbx
	addq $1572, %rbx
	movl (%rbx), %r8d
	leaq _gp(%rip), %rbx
	addq $784, %rbx
	movslq %ecx, %rcx
	subq $1, %rcx
	imulq $11, %rcx
	movslq %r8d, %r8
	subq $1, %r8
	addq %r8, %rcx
	imulq $4, %rcx
	addq %rcx, %rbx
	movl (%rbx), %ecx
	leaq .string_const2(%rip), %rdi
	movl %ecx, %esi
	movl $0, %eax
	call printf@PLT
	leaq .string_const0(%rip), %rdi
	leaq .string_const3(%rip), %rsi
	call printf@PLT
	leaq _gp(%rip), %rbx
	addq $1572, %rbx
	leaq _gp(%rip), %rcx
	addq $1572, %rcx
	movl (%rcx), %r8d
	movl $1, %ecx
	addl %ecx, %r8d
	movl %r8d, (%rbx)
	jmp .L7
	.L8:	nop
	leaq .string_const4(%rip), %rdi
	leaq .string_const5(%rip), %rsi
	call printf@PLT
	leaq _gp(%rip), %rbx
	addq $1568, %rbx
	leaq _gp(%rip), %rcx
	addq $1568, %rcx
	movl (%rcx), %r8d
	movl $1, %ecx
	addl %ecx, %r8d
	movl %r8d, (%rbx)
	jmp .L5
	.L6:	nop
	leave
	ret
