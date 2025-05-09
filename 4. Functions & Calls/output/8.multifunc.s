	.section	.rodata
	.string_const0: .string "%d\n"
	.text
	.globl b1
	.type b1,@function
b1:	nop
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	subq $8, %rsp
	movl $1, %ebx
	leaq .string_const0(%rip), %rdi
	movl %ebx, %esi
	movl $0, %eax
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
	.globl b2
	.type b2,@function
b2:	nop
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	subq $8, %rsp
	movl $2, %ebx
	leaq .string_const0(%rip), %rdi
	movl %ebx, %esi
	movl $0, %eax
	call printf@PLT
	pushq %r8
	pushq %r9
	pushq %r10
	pushq %r11
	call b1
	popq %r11
	popq %r10
	popq %r9
	popq %r8
	movl %eax, %ebx
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
	call b1
	popq %r11
	popq %r10
	popq %r9
	popq %r8
	movl %eax, %ebx
	pushq %r8
	pushq %r9
	pushq %r10
	pushq %r11
	call b2
	popq %r11
	popq %r10
	popq %r9
	popq %r8
	movl %eax, %ebx
	addl %ebx, %ebx
	leaq .string_const0(%rip), %rdi
	movl %ebx, %esi
	movl $0, %eax
	call printf@PLT
	leave
	ret
