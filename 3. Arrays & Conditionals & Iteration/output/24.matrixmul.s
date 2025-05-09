	.section	.rodata
	.comm _gp, 1828, 4
	.string_const0: .string "%s"
	.string_const1: .string "pick a prime seed (7, 11, 13, 17): "
	.string_const2: .string "%d"
	.string_const3: .string "  "
	.string_const4: .string "%s\n"
	.string_const5: .string "|"
	.string_const6: .string "*"
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
	addq $1808, %rbx
	leaq .string_const2(%rip), %rdi
	movq %rbx, %rsi
	movl $0, %eax
	call scanf@PLT
	leaq _gp(%rip), %rbx
	addq $1816, %rbx
	movl $1, %ecx
	movl %ecx, (%rbx)
	.L1:	nop
	leaq _gp(%rip), %rbx
	addq $1816, %rbx
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
	addq $1820, %rbx
	movl $1, %ecx
	movl %ecx, (%rbx)
	.L3:	nop
	leaq _gp(%rip), %rbx
	addq $1820, %rbx
	movl (%rbx), %ecx
	movl $15, %ebx
	cmpl %ebx, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmovle %ebx, %ecx
	movl $-1, %ebx
	testl %ebx, %ecx
	je .L4
	leaq _gp(%rip), %rbx
	addq $1808, %rbx
	leaq _gp(%rip), %rcx
	addq $1808, %rcx
	movl (%rcx), %r8d
	movl $7, %ecx
	imull %ecx, %r8d
	leaq _gp(%rip), %rcx
	addq $1808, %rcx
	movl (%rcx), %r9d
	movl $7, %ecx
	imull %ecx, %r9d
	movl $1811, %ecx
	movl %r9d, %eax
	cdq
	idivl %ecx
	movl %eax, %r9d
	movl $1811, %ecx
	imull %ecx, %r9d
	subl %r9d, %r8d
	movl %r8d, (%rbx)
	leaq _gp(%rip), %rbx
	addq $1816, %rbx
	movl (%rbx), %ecx
	leaq _gp(%rip), %rbx
	addq $1820, %rbx
	movl (%rbx), %r8d
	leaq _gp(%rip), %rbx
	addq $0, %rbx
	movslq %ecx, %rcx
	subq $1, %rcx
	imulq $15, %rcx
	movslq %r8d, %r8
	subq $1, %r8
	addq %r8, %rcx
	imulq $4, %rcx
	addq %rcx, %rbx
	leaq _gp(%rip), %rcx
	addq $1808, %rcx
	movl (%rcx), %r8d
	movl %r8d, (%rbx)
	leaq _gp(%rip), %rbx
	addq $1816, %rbx
	movl (%rbx), %ecx
	leaq _gp(%rip), %rbx
	addq $1820, %rbx
	movl (%rbx), %r8d
	leaq _gp(%rip), %rbx
	addq $0, %rbx
	movslq %ecx, %rcx
	subq $1, %rcx
	imulq $15, %rcx
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
	addq $1820, %rbx
	leaq _gp(%rip), %rcx
	addq $1820, %rcx
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
	addq $1816, %rbx
	leaq _gp(%rip), %rcx
	addq $1816, %rcx
	movl (%rcx), %r8d
	movl $1, %ecx
	addl %ecx, %r8d
	movl %r8d, (%rbx)
	jmp .L1
	.L2:	nop
	leaq .string_const4(%rip), %rdi
	leaq .string_const6(%rip), %rsi
	call printf@PLT
	leaq _gp(%rip), %rbx
	addq $1816, %rbx
	movl $1, %ecx
	movl %ecx, (%rbx)
	.L5:	nop
	leaq _gp(%rip), %rbx
	addq $1816, %rbx
	movl (%rbx), %ecx
	movl $15, %ebx
	cmpl %ebx, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmovle %ebx, %ecx
	movl $-1, %ebx
	testl %ebx, %ecx
	je .L6
	leaq _gp(%rip), %rbx
	addq $1820, %rbx
	movl $1, %ecx
	movl %ecx, (%rbx)
	.L7:	nop
	leaq _gp(%rip), %rbx
	addq $1820, %rbx
	movl (%rbx), %ecx
	movl $5, %ebx
	cmpl %ebx, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmovle %ebx, %ecx
	movl $-1, %ebx
	testl %ebx, %ecx
	je .L8
	leaq _gp(%rip), %rbx
	addq $1808, %rbx
	leaq _gp(%rip), %rcx
	addq $1808, %rcx
	movl (%rcx), %r8d
	movl $5, %ecx
	imull %ecx, %r8d
	leaq _gp(%rip), %rcx
	addq $1808, %rcx
	movl (%rcx), %r9d
	movl $5, %ecx
	imull %ecx, %r9d
	movl $1811, %ecx
	movl %r9d, %eax
	cdq
	idivl %ecx
	movl %eax, %r9d
	movl $1811, %ecx
	imull %ecx, %r9d
	subl %r9d, %r8d
	movl %r8d, (%rbx)
	leaq _gp(%rip), %rbx
	addq $1816, %rbx
	movl (%rbx), %ecx
	leaq _gp(%rip), %rbx
	addq $1820, %rbx
	movl (%rbx), %r8d
	leaq _gp(%rip), %rbx
	addq $1296, %rbx
	movslq %ecx, %rcx
	subq $1, %rcx
	imulq $5, %rcx
	movslq %r8d, %r8
	subq $1, %r8
	addq %r8, %rcx
	imulq $4, %rcx
	addq %rcx, %rbx
	leaq _gp(%rip), %rcx
	addq $1808, %rcx
	movl (%rcx), %r8d
	movl %r8d, (%rbx)
	leaq _gp(%rip), %rbx
	addq $1816, %rbx
	movl (%rbx), %ecx
	leaq _gp(%rip), %rbx
	addq $1820, %rbx
	movl (%rbx), %r8d
	leaq _gp(%rip), %rbx
	addq $1296, %rbx
	movslq %ecx, %rcx
	subq $1, %rcx
	imulq $5, %rcx
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
	addq $1820, %rbx
	leaq _gp(%rip), %rcx
	addq $1820, %rcx
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
	addq $1816, %rbx
	leaq _gp(%rip), %rcx
	addq $1816, %rcx
	movl (%rcx), %r8d
	movl $1, %ecx
	addl %ecx, %r8d
	movl %r8d, (%rbx)
	jmp .L5
	.L6:	nop
	leaq .string_const4(%rip), %rdi
	leaq .string_const7(%rip), %rsi
	call printf@PLT
	leaq _gp(%rip), %rbx
	addq $1816, %rbx
	movl $1, %ecx
	movl %ecx, (%rbx)
	.L9:	nop
	leaq _gp(%rip), %rbx
	addq $1816, %rbx
	movl (%rbx), %ecx
	movl $20, %ebx
	cmpl %ebx, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmovle %ebx, %ecx
	movl $-1, %ebx
	testl %ebx, %ecx
	je .L10
	leaq _gp(%rip), %rbx
	addq $1820, %rbx
	movl $1, %ecx
	movl %ecx, (%rbx)
	.L11:	nop
	leaq _gp(%rip), %rbx
	addq $1820, %rbx
	movl (%rbx), %ecx
	movl $5, %ebx
	cmpl %ebx, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmovle %ebx, %ecx
	movl $-1, %ebx
	testl %ebx, %ecx
	je .L12
	leaq _gp(%rip), %rbx
	addq $1824, %rbx
	movl $1, %ecx
	movl %ecx, (%rbx)
	leaq _gp(%rip), %rbx
	addq $1812, %rbx
	movl $0, %ecx
	movl %ecx, (%rbx)
	.L13:	nop
	leaq _gp(%rip), %rbx
	addq $1824, %rbx
	movl (%rbx), %ecx
	movl $15, %ebx
	cmpl %ebx, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmovle %ebx, %ecx
	movl $-1, %ebx
	testl %ebx, %ecx
	je .L14
	leaq _gp(%rip), %rbx
	addq $1812, %rbx
	leaq _gp(%rip), %rcx
	addq $1812, %rcx
	movl (%rcx), %r8d
	leaq _gp(%rip), %rcx
	addq $1816, %rcx
	movl (%rcx), %r9d
	leaq _gp(%rip), %rcx
	addq $1824, %rcx
	movl (%rcx), %r10d
	leaq _gp(%rip), %rcx
	addq $0, %rcx
	movslq %r9d, %r9
	subq $1, %r9
	imulq $15, %r9
	movslq %r10d, %r10
	subq $1, %r10
	addq %r10, %r9
	imulq $4, %r9
	addq %r9, %rcx
	movl (%rcx), %r9d
	leaq _gp(%rip), %rcx
	addq $1824, %rcx
	movl (%rcx), %r10d
	leaq _gp(%rip), %rcx
	addq $1820, %rcx
	movl (%rcx), %r11d
	leaq _gp(%rip), %rcx
	addq $1296, %rcx
	movslq %r10d, %r10
	subq $1, %r10
	imulq $5, %r10
	movslq %r11d, %r11
	subq $1, %r11
	addq %r11, %r10
	imulq $4, %r10
	addq %r10, %rcx
	movl (%rcx), %r10d
	imull %r10d, %r9d
	addl %r9d, %r8d
	movl %r8d, (%rbx)
	leaq _gp(%rip), %rbx
	addq $1824, %rbx
	leaq _gp(%rip), %rcx
	addq $1824, %rcx
	movl (%rcx), %r8d
	movl $1, %ecx
	addl %ecx, %r8d
	movl %r8d, (%rbx)
	jmp .L13
	.L14:	nop
	leaq _gp(%rip), %rbx
	addq $1816, %rbx
	movl (%rbx), %ecx
	leaq _gp(%rip), %rbx
	addq $1820, %rbx
	movl (%rbx), %r8d
	leaq _gp(%rip), %rbx
	addq $1552, %rbx
	movslq %ecx, %rcx
	subq $1, %rcx
	imulq $5, %rcx
	movslq %r8d, %r8
	subq $1, %r8
	addq %r8, %rcx
	imulq $4, %rcx
	addq %rcx, %rbx
	leaq _gp(%rip), %rcx
	addq $1812, %rcx
	movl (%rcx), %r8d
	movl %r8d, (%rbx)
	leaq _gp(%rip), %rbx
	addq $1816, %rbx
	movl (%rbx), %ecx
	leaq _gp(%rip), %rbx
	addq $1820, %rbx
	movl (%rbx), %r8d
	leaq _gp(%rip), %rbx
	addq $1552, %rbx
	movslq %ecx, %rcx
	subq $1, %rcx
	imulq $5, %rcx
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
	addq $1820, %rbx
	leaq _gp(%rip), %rcx
	addq $1820, %rcx
	movl (%rcx), %r8d
	movl $1, %ecx
	addl %ecx, %r8d
	movl %r8d, (%rbx)
	jmp .L11
	.L12:	nop
	leaq .string_const4(%rip), %rdi
	leaq .string_const5(%rip), %rsi
	call printf@PLT
	leaq _gp(%rip), %rbx
	addq $1816, %rbx
	leaq _gp(%rip), %rcx
	addq $1816, %rcx
	movl (%rcx), %r8d
	movl $1, %ecx
	addl %ecx, %r8d
	movl %r8d, (%rbx)
	jmp .L9
	.L10:	nop
	leave
	ret
