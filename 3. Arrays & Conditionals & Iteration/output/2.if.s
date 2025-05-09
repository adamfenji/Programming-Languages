	.section	.rodata
	.comm _gp, 4, 4
	.string_const0: .string "%s"
	.string_const1: .string "Enter a:"
	.string_const2: .string "%d"
	.string_const3: .string "%d\n"
	.string_const4: .string "%s\n"
	.string_const5: .string "Complete!"
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
	je .L1
	movl $1, %ebx
	leaq .string_const3(%rip), %rdi
	movl %ebx, %esi
	movl $0, %eax
	call printf@PLT
	jmp .L2
	.L1:	nop
	movl $0, %ebx
	leaq .string_const3(%rip), %rdi
	movl %ebx, %esi
	movl $0, %eax
	call printf@PLT
	.L2:	nop
	leaq .string_const4(%rip), %rdi
	leaq .string_const5(%rip), %rsi
	call printf@PLT
	leave
	ret
