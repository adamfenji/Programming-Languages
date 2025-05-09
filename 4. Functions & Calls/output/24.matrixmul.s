	.section	.rodata
	.comm _gp, 1904, 4
	.string_const0: .string "%d"
	.string_const1: .string "%s"
	.string_const2: .string "  "
	.string_const3: .string "%s\n"
	.string_const4: .string "|"
	.string_const5: .string "*"
	.string_const6: .string "pick a prime seed (7, 11, 13, 17): "
	.string_const7: .string "="
	.text
	.globl init
	.type init,@function
init:	nop
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
	movl $20, %ebx
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
	movl $15, %ebx
	cmpl %ebx, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmovle %ebx, %ecx
	movl $-1, %ebx
	testl %ecx, %ebx
	je .L3
	leaq _gp(%rip), %rbx
	addq $1900, %rbx
	leaq _gp(%rip), %rcx
	addq $1900, %rcx
	movl (%rcx), %r8d
	movl $7, %ecx
	imull %ecx, %r8d
	leaq _gp(%rip), %rcx
	addq $1900, %rcx
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
	movq $15, %r9
	imulq %r9, %rcx
	movslq %r8d, %r8
	addq %r8, %rcx
	subq $1, %rcx
	imulq $4, %rcx
	addq %rcx, %rbx
	leaq _gp(%rip), %rcx
	addq $1900, %rcx
	movl (%rcx), %r8d
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
	movq $15, %r9
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
	leaq .string_const3(%rip), %rdi
	leaq .string_const5(%rip), %rsi
	call printf@PLT
	movq %rbp, %rbx
	addq $-4, %rbx
	movl $1, %ecx
	movl %ecx, (%rbx)
.L4:	nop
	movq %rbp, %rbx
	addq $-4, %rbx
	movl (%rbx), %ecx
	movl $15, %ebx
	cmpl %ebx, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmovle %ebx, %ecx
	movl $-1, %ebx
	testl %ecx, %ebx
	je .L5
	movq %rbp, %rbx
	addq $-8, %rbx
	movl $1, %ecx
	movl %ecx, (%rbx)
.L6:	nop
	movq %rbp, %rbx
	addq $-8, %rbx
	movl (%rbx), %ecx
	movl $5, %ebx
	cmpl %ebx, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmovle %ebx, %ecx
	movl $-1, %ebx
	testl %ecx, %ebx
	je .L7
	leaq _gp(%rip), %rbx
	addq $1900, %rbx
	leaq _gp(%rip), %rcx
	addq $1900, %rcx
	movl (%rcx), %r8d
	movl $5, %ecx
	imull %ecx, %r8d
	leaq _gp(%rip), %rcx
	addq $1900, %rcx
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
	movq %rbp, %rbx
	addq $-4, %rbx
	movl (%rbx), %ecx
	movq %rbp, %rbx
	addq $-8, %rbx
	movl (%rbx), %r8d
	leaq _gp(%rip), %rbx
	addq $1200, %rbx
	movslq %ecx, %rcx
	subq $1, %rcx
	movq $5, %r9
	imulq %r9, %rcx
	movslq %r8d, %r8
	addq %r8, %rcx
	subq $1, %rcx
	imulq $4, %rcx
	addq %rcx, %rbx
	leaq _gp(%rip), %rcx
	addq $1900, %rcx
	movl (%rcx), %r8d
	movl %r8d, (%rbx)
	movq %rbp, %rbx
	addq $-4, %rbx
	movl (%rbx), %ecx
	movq %rbp, %rbx
	addq $-8, %rbx
	movl (%rbx), %r8d
	leaq _gp(%rip), %rbx
	addq $1200, %rbx
	movslq %ecx, %rcx
	subq $1, %rcx
	movq $5, %r9
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
	jmp .L6
.L7:	 nop
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
	jmp .L4
.L5:	 nop
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
	.globl mm
	.type mm,@function
mm:	nop
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
	addq $-16, %rbx
	movl $1, %ecx
	movl %ecx, (%rbx)
.L8:	nop
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
	je .L9
	movq %rbp, %rbx
	addq $-20, %rbx
	movl $1, %ecx
	movl %ecx, (%rbx)
.L10:	nop
	movq %rbp, %rbx
	addq $-20, %rbx
	movl (%rbx), %ecx
	movl $5, %ebx
	cmpl %ebx, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmovle %ebx, %ecx
	movl $-1, %ebx
	testl %ecx, %ebx
	je .L11
	movq %rbp, %rbx
	addq $-24, %rbx
	movl $1, %ecx
	movl %ecx, (%rbx)
	movq %rbp, %rbx
	addq $-12, %rbx
	movl $0, %ecx
	movl %ecx, (%rbx)
.L12:	nop
	movq %rbp, %rbx
	addq $-24, %rbx
	movl (%rbx), %ecx
	movl $15, %ebx
	cmpl %ebx, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmovle %ebx, %ecx
	movl $-1, %ebx
	testl %ecx, %ebx
	je .L13
	movq %rbp, %rbx
	addq $-12, %rbx
	movq %rbp, %rcx
	addq $-12, %rcx
	movl (%rcx), %r8d
	movq %rbp, %rcx
	addq $-16, %rcx
	movl (%rcx), %r9d
	movq %rbp, %rcx
	addq $-24, %rcx
	movl (%rcx), %r10d
	leaq _gp(%rip), %rcx
	addq $0, %rcx
	movslq %r9d, %r9
	subq $1, %r9
	movq $15, %r11
	imulq %r11, %r9
	movslq %r10d, %r10
	addq %r10, %r9
	subq $1, %r9
	imulq $4, %r9
	addq %r9, %rcx
	movl (%rcx), %r9d
	movq %rbp, %rcx
	addq $-24, %rcx
	movl (%rcx), %r10d
	movq %rbp, %rcx
	addq $-20, %rcx
	movl (%rcx), %r11d
	leaq _gp(%rip), %rcx
	addq $1200, %rcx
	movslq %r10d, %r10
	subq $1, %r10
	movq $5, %r12
	imulq %r12, %r10
	movslq %r11d, %r11
	addq %r11, %r10
	subq $1, %r10
	imulq $4, %r10
	addq %r10, %rcx
	movl (%rcx), %r10d
	imull %r10d, %r9d
	addl %r9d, %r8d
	movl %r8d, (%rbx)
	movq %rbp, %rbx
	addq $-24, %rbx
	movq %rbp, %rcx
	addq $-24, %rcx
	movl (%rcx), %r8d
	movl $1, %ecx
	addl %ecx, %r8d
	movl %r8d, (%rbx)
	jmp .L12
.L13:	 nop
	movq %rbp, %rbx
	addq $-16, %rbx
	movl (%rbx), %ecx
	movq %rbp, %rbx
	addq $-20, %rbx
	movl (%rbx), %r8d
	leaq _gp(%rip), %rbx
	addq $1500, %rbx
	movslq %ecx, %rcx
	subq $1, %rcx
	movq $5, %r9
	imulq %r9, %rcx
	movslq %r8d, %r8
	addq %r8, %rcx
	subq $1, %rcx
	imulq $4, %rcx
	addq %rcx, %rbx
	movq %rbp, %rcx
	addq $-12, %rcx
	movl (%rcx), %r8d
	movl %r8d, (%rbx)
	movq %rbp, %rbx
	addq $-16, %rbx
	movl (%rbx), %ecx
	movq %rbp, %rbx
	addq $-20, %rbx
	movl (%rbx), %r8d
	leaq _gp(%rip), %rbx
	addq $1500, %rbx
	movslq %ecx, %rcx
	subq $1, %rcx
	movq $5, %r9
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
	addq $-20, %rbx
	movq %rbp, %rcx
	addq $-20, %rcx
	movl (%rcx), %r8d
	movl $1, %ecx
	addl %ecx, %r8d
	movl %r8d, (%rbx)
	jmp .L10
.L11:	 nop
	leaq .string_const3(%rip), %rdi
	leaq .string_const4(%rip), %rsi
	call printf@PLT
	movq %rbp, %rbx
	addq $-16, %rbx
	movq %rbp, %rcx
	addq $-16, %rcx
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
	.globl main
	.type main,@function
main:	nop
	pushq %rbp
	movq %rsp, %rbp
	leaq .string_const1(%rip), %rdi
	leaq .string_const6(%rip), %rsi
	call printf@PLT
	leaq _gp(%rip), %rbx
	addq $1900, %rbx
	leaq .string_const0(%rip), %rdi
	movq %rbx, %rsi
	movl $0, %eax
	call scanf@PLT
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
	je .L14
	leaq .string_const3(%rip), %rdi
	leaq .string_const7(%rip), %rsi
	call printf@PLT
	leaq _gp(%rip), %rbx
	addq $1900, %rbx
	pushq %r8
	pushq %r9
	pushq %r10
	pushq %r11
	call mm
	popq %r11
	popq %r10
	popq %r9
	popq %r8
	movl %eax, %ecx
	movl %ecx, (%rbx)
	jmp .L15
.L14:	 nop
.L15:	 nop
	leave
	ret
