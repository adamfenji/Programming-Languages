	.section	.rodata
	.comm _gp, 636, 4
	.string_const0: .string "%d"
	.string_const1: .string "%s"
	.string_const2: .string "  "
	.string_const3: .string "%s\n"
	.string_const4: .string "|"
	.string_const5: .string "*"
	.string_const6: .string "="
	.text
	.globl main
	.type main,@function
main:	nop
	pushq %rbp
	movq %rsp, %rbp
	leaq _gp(%rip), %rbx
	addq $620, %rbx
	movl $1, %ecx
	movl %ecx, (%rbx)
	.L1:	nop
	leaq _gp(%rip), %rbx
	addq $620, %rbx
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
	addq $624, %rbx
	movl $1, %ecx
	movl %ecx, (%rbx)
	.L3:	nop
	leaq _gp(%rip), %rbx
	addq $624, %rbx
	movl (%rbx), %ecx
	movl $8, %ebx
	cmpl %ebx, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmovle %ebx, %ecx
	movl $-1, %ebx
	testl %ebx, %ecx
	je .L4
	leaq _gp(%rip), %rbx
	addq $620, %rbx
	movl (%rbx), %ecx
	leaq _gp(%rip), %rbx
	addq $624, %rbx
	movl (%rbx), %r8d
	leaq _gp(%rip), %rbx
	addq $0, %rbx
	movslq %ecx, %rcx
	subq $1, %rcx
	imulq $8, %rcx
	movslq %r8d, %r8
	subq $1, %r8
	addq %r8, %rcx
	imulq $4, %rcx
	addq %rcx, %rbx
	leaq _gp(%rip), %rcx
	addq $620, %rcx
	movl (%rcx), %r8d
	movl $8, %ecx
	imull %ecx, %r8d
	leaq _gp(%rip), %rcx
	addq $624, %rcx
	movl (%rcx), %r9d
	addl %r9d, %r8d
	movl %r8d, (%rbx)
	leaq _gp(%rip), %rbx
	addq $620, %rbx
	movl (%rbx), %ecx
	leaq _gp(%rip), %rbx
	addq $624, %rbx
	movl (%rbx), %r8d
	leaq _gp(%rip), %rbx
	addq $0, %rbx
	movslq %ecx, %rcx
	subq $1, %rcx
	imulq $8, %rcx
	movslq %r8d, %r8
	subq $1, %r8
	addq %r8, %rcx
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
	addq $624, %rbx
	leaq _gp(%rip), %rcx
	addq $624, %rcx
	movl (%rcx), %r8d
	movl $1, %ecx
	addl %ecx, %r8d
	movl %r8d, (%rbx)
	jmp .L3
	.L4:	nop
	leaq .string_const3(%rip), %rdi
	leaq .string_const4(%rip), %rsi
	call printf@PLT
	leaq _gp(%rip), %rbx
	addq $620, %rbx
	leaq _gp(%rip), %rcx
	addq $620, %rcx
	movl (%rcx), %r8d
	movl $1, %ecx
	addl %ecx, %r8d
	movl %r8d, (%rbx)
	jmp .L1
	.L2:	nop
	leaq .string_const3(%rip), %rdi
	leaq .string_const5(%rip), %rsi
	call printf@PLT
	leaq _gp(%rip), %rbx
	addq $624, %rbx
	movl $2, %ecx
	movl %ecx, (%rbx)
	.L5:	nop
	leaq _gp(%rip), %rbx
	addq $624, %rbx
	movl (%rbx), %ecx
	movl $9, %ebx
	cmpl %ebx, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmovle %ebx, %ecx
	movl $-1, %ebx
	testl %ebx, %ecx
	je .L6
	leaq _gp(%rip), %rbx
	addq $624, %rbx
	movl (%rbx), %ecx
	leaq _gp+484(%rip), %rbx
	movslq %ecx, %rcx
	subq $2, %rcx
	imulq $4, %rcx
	addq %rcx, %rbx
	leaq _gp(%rip), %rcx
	addq $624, %rcx
	movl (%rcx), %r8d
	leaq _gp(%rip), %rcx
	addq $624, %rcx
	movl (%rcx), %r9d
	imull %r9d, %r8d
	movl %r8d, (%rbx)
	leaq _gp(%rip), %rbx
	addq $624, %rbx
	movl (%rbx), %ecx
	leaq _gp+484(%rip), %rbx
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
	leaq _gp(%rip), %rbx
	addq $624, %rbx
	leaq _gp(%rip), %rcx
	addq $624, %rcx
	movl (%rcx), %r8d
	movl $1, %ecx
	addl %ecx, %r8d
	movl %r8d, (%rbx)
	jmp .L5
	.L6:	nop
	leaq .string_const3(%rip), %rdi
	leaq .string_const4(%rip), %rsi
	call printf@PLT
	leaq .string_const3(%rip), %rdi
	leaq .string_const6(%rip), %rsi
	call printf@PLT
	leaq _gp(%rip), %rbx
	addq $620, %rbx
	movl $1, %ecx
	movl %ecx, (%rbx)
	.L7:	nop
	leaq _gp(%rip), %rbx
	addq $620, %rbx
	movl (%rbx), %ecx
	movl $20, %ebx
	cmpl %ebx, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmovle %ebx, %ecx
	movl $-1, %ebx
	testl %ebx, %ecx
	je .L8
	leaq _gp(%rip), %rbx
	addq $624, %rbx
	movl $1, %ecx
	movl %ecx, (%rbx)
	leaq _gp(%rip), %rbx
	addq $632, %rbx
	movl $0, %ecx
	movl %ecx, (%rbx)
	.L9:	nop
	leaq _gp(%rip), %rbx
	addq $624, %rbx
	movl (%rbx), %ecx
	movl $8, %ebx
	cmpl %ebx, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmovle %ebx, %ecx
	movl $-1, %ebx
	testl %ebx, %ecx
	je .L10
	leaq _gp(%rip), %rbx
	addq $632, %rbx
	leaq _gp(%rip), %rcx
	addq $632, %rcx
	movl (%rcx), %r8d
	leaq _gp(%rip), %rcx
	addq $620, %rcx
	movl (%rcx), %r9d
	leaq _gp(%rip), %rcx
	addq $624, %rcx
	movl (%rcx), %r10d
	leaq _gp(%rip), %rcx
	addq $0, %rcx
	movslq %r9d, %r9
	subq $1, %r9
	imulq $8, %r9
	movslq %r10d, %r10
	subq $1, %r10
	addq %r10, %r9
	imulq $4, %r9
	addq %r9, %rcx
	movl (%rcx), %r9d
	leaq _gp(%rip), %rcx
	addq $624, %rcx
	movl (%rcx), %r10d
	movl $1, %ecx
	addl %ecx, %r10d
	leaq _gp+484(%rip), %rcx
	movslq %r10d, %r10
	subq $2, %r10
	imulq $4, %r10
	addq %r10, %rcx
	movl (%rcx), %r10d
	imull %r10d, %r9d
	addl %r9d, %r8d
	movl %r8d, (%rbx)
	leaq _gp(%rip), %rbx
	addq $624, %rbx
	leaq _gp(%rip), %rcx
	addq $624, %rcx
	movl (%rcx), %r8d
	movl $1, %ecx
	addl %ecx, %r8d
	movl %r8d, (%rbx)
	jmp .L9
	.L10:	nop
	leaq _gp(%rip), %rbx
	addq $620, %rbx
	movl (%rbx), %ecx
	leaq _gp+528(%rip), %rbx
	movslq %ecx, %rcx
	subq $1, %rcx
	imulq $4, %rcx
	addq %rcx, %rbx
	leaq _gp(%rip), %rcx
	addq $632, %rcx
	movl (%rcx), %r8d
	movl %r8d, (%rbx)
	leaq _gp(%rip), %rbx
	addq $620, %rbx
	leaq _gp(%rip), %rcx
	addq $620, %rcx
	movl (%rcx), %r8d
	movl $1, %ecx
	addl %ecx, %r8d
	movl %r8d, (%rbx)
	jmp .L7
	.L8:	nop
	leaq _gp(%rip), %rbx
	addq $628, %rbx
	movl $1, %ecx
	movl %ecx, (%rbx)
	.L11:	nop
	leaq _gp(%rip), %rbx
	addq $628, %rbx
	movl (%rbx), %ecx
	movl $20, %ebx
	cmpl %ebx, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmovle %ebx, %ecx
	movl $-1, %ebx
	testl %ebx, %ecx
	je .L12
	leaq _gp(%rip), %rbx
	addq $628, %rbx
	movl (%rbx), %ecx
	leaq _gp+528(%rip), %rbx
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
	addq $628, %rbx
	leaq _gp(%rip), %rcx
	addq $628, %rcx
	movl (%rcx), %r8d
	movl $1, %ecx
	addl %ecx, %r8d
	movl %r8d, (%rbx)
	jmp .L11
	.L12:	nop
	leaq .string_const3(%rip), %rdi
	leaq .string_const4(%rip), %rsi
	call printf@PLT
	leave
	ret
