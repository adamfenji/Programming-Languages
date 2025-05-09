	.section	.rodata
	.comm _gp, 8, 4
	.string_const0: .string "%s"
	.string_const1: .string "enter a:"
	.string_const2: .string "%d"
	.string_const3: .string "enter b:"
	.string_const4: .string "a = "
	.string_const5: .string "%d\n"
	.string_const6: .string "b = "
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
	leaq _gp(%rip), %rbx
	addq $4, %rbx
	movl (%rbx), %ecx
	leaq _gp(%rip), %rbx
	addq $0, %rbx
	movl (%rbx), %r8d
	cmpl %r8d, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmovg %ebx, %ecx
	movl $-1, %ebx
	testl %ebx, %ecx
	je .L1
	leaq _gp(%rip), %rbx
	addq $0, %rbx
	movl (%rbx), %ecx
	movl $0, %ebx
	cmpl %ebx, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmovg %ebx, %ecx
	movl $-1, %ebx
	testl %ebx, %ecx
	je .L2
	leaq .string_const0(%rip), %rdi
	leaq .string_const4(%rip), %rsi
	call printf@PLT
	leaq _gp(%rip), %rbx
	addq $0, %rbx
	movl (%rbx), %ecx
	leaq .string_const5(%rip), %rdi
	movl %ecx, %esi
	movl $0, %eax
	call printf@PLT
	jmp .L3
	.L2:	nop
	leaq .string_const0(%rip), %rdi
	leaq .string_const6(%rip), %rsi
	call printf@PLT
	leaq _gp(%rip), %rbx
	addq $4, %rbx
	movl (%rbx), %ecx
	leaq .string_const5(%rip), %rdi
	movl %ecx, %esi
	movl $0, %eax
	call printf@PLT
	.L3:	nop
	jmp .L4
	.L1:	nop
	leaq _gp(%rip), %rbx
	addq $0, %rbx
	movl (%rbx), %ecx
	movl $0, %ebx
	cmpl %ebx, %ecx
	movl $0, %ecx
	movl $1, %ebx
	cmovl %ebx, %ecx
	movl $-1, %ebx
	testl %ebx, %ecx
	je .L5
	leaq .string_const0(%rip), %rdi
	leaq .string_const4(%rip), %rsi
	call printf@PLT
	leaq _gp(%rip), %rbx
	addq $0, %rbx
	movl (%rbx), %ecx
	leaq .string_const5(%rip), %rdi
	movl %ecx, %esi
	movl $0, %eax
	call printf@PLT
	jmp .L6
	.L5:	nop
	leaq .string_const0(%rip), %rdi
	leaq .string_const6(%rip), %rsi
	call printf@PLT
	leaq _gp(%rip), %rbx
	addq $4, %rbx
	movl (%rbx), %ecx
	leaq .string_const5(%rip), %rdi
	movl %ecx, %esi
	movl $0, %eax
	call printf@PLT
	.L6:	nop
	.L4:	nop
	leave
	ret
