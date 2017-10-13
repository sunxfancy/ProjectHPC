	.file	"main.c"
	.text
	.p2align 4,,15
.globl checkEqual
	.type	checkEqual, @function
checkEqual:
.LFB20:
	.cfi_startproc
	testl	%edx, %edx
	je	.L2
	movsd	(%rdi), %xmm0
	xorl	%eax, %eax
	xorl	%ecx, %ecx
	ucomisd	(%rsi), %xmm0
	jp	.L3
	je	.L4
	jmp	.L3
	.p2align 4,,10
	.p2align 3
.L5:
	movsd	8(%rdi,%rax), %xmm1
	movsd	8(%rsi,%rax), %xmm0
	addq	$8, %rax
	ucomisd	%xmm0, %xmm1
	jne	.L3
	jp	.L3
.L4:
	addl	$1, %ecx
	cmpl	%ecx, %edx
	ja	.L5
.L2:
	movl	$1, %eax
	.p2align 4,,1
	ret
	.p2align 4,,10
	.p2align 3
.L3:
	xorl	%eax, %eax
	ret
	.cfi_endproc
.LFE20:
	.size	checkEqual, .-checkEqual
	.p2align 4,,15
.globl timespec_diff
	.type	timespec_diff, @function
timespec_diff:
.LFB21:
	.cfi_startproc
	movq	8(%rsi), %rax
	movq	%rax, %rcx
	subq	8(%rdi), %rcx
	js	.L14
	movq	(%rsi), %rax
	subq	(%rdi), %rax
	movq	%rcx, 8(%rdx)
	movq	%rax, (%rdx)
	ret
	.p2align 4,,10
	.p2align 3
.L14:
	movq	(%rsi), %rcx
	addq	$1000000000, %rax
	subq	8(%rdi), %rax
	subq	$1, %rcx
	subq	(%rdi), %rcx
	movq	%rax, 8(%rdx)
	movq	%rcx, (%rdx)
	ret
	.cfi_endproc
.LFE21:
	.size	timespec_diff, .-timespec_diff
	.p2align 4,,15
.globl dgemm0
	.type	dgemm0, @function
dgemm0:
.LFB24:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	testl	%ecx, %ecx
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	je	.L21
	xorl	%ebx, %ebx
	xorl	%r12d, %r12d
.L17:
	xorl	%ebp, %ebp
	.p2align 4,,10
	.p2align 3
.L20:
	leal	(%rbx,%rbp), %eax
	movl	%ebp, %r8d
	leaq	(%rdx,%rax,8), %r11
	xorl	%eax, %eax
	movsd	(%r11), %xmm1
	.p2align 4,,10
	.p2align 3
.L18:
	leal	(%rbx,%rax), %r10d
	mov	%r8d, %r9d
	addl	$1, %eax
	addl	%ecx, %r8d
	cmpl	%eax, %ecx
	movsd	(%rdi,%r10,8), %xmm0
	mulsd	(%rsi,%r9,8), %xmm0
	addsd	%xmm0, %xmm1
	movsd	%xmm1, (%r11)
	ja	.L18
	addl	$1, %ebp
	cmpl	%ebp, %ecx
	ja	.L20
	addl	$1, %r12d
	addl	%ecx, %ebx
	cmpl	%r12d, %ecx
	ja	.L17
.L21:
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE24:
	.size	dgemm0, .-dgemm0
	.p2align 4,,15
.globl dgemm1
	.type	dgemm1, @function
dgemm1:
.LFB25:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	testl	%ecx, %ecx
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	je	.L28
	xorl	%r11d, %r11d
	xorl	%r12d, %r12d
.L25:
	xorl	%ebx, %ebx
	.p2align 4,,10
	.p2align 3
.L27:
	leal	(%rbx,%r11), %eax
	movl	%ebx, %r8d
	leaq	(%rdx,%rax,8), %rbp
	xorl	%eax, %eax
	movsd	0(%rbp), %xmm1
	.p2align 4,,10
	.p2align 3
.L26:
	leal	(%rax,%r11), %r10d
	mov	%r8d, %r9d
	addl	$1, %eax
	addl	%ecx, %r8d
	cmpl	%eax, %ecx
	movsd	(%rdi,%r10,8), %xmm0
	mulsd	(%rsi,%r9,8), %xmm0
	addsd	%xmm0, %xmm1
	ja	.L26
	addl	$1, %ebx
	movsd	%xmm1, 0(%rbp)
	cmpl	%ebx, %ecx
	ja	.L27
	addl	$1, %r12d
	addl	%ecx, %r11d
	cmpl	%r12d, %ecx
	ja	.L25
.L28:
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE25:
	.size	dgemm1, .-dgemm1
	.p2align 4,,15
.globl dgemm2
	.type	dgemm2, @function
dgemm2:
.LFB26:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	testl	%ecx, %ecx
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	je	.L36
	leal	(%rcx,%rcx), %ebp
	movl	$0, -8(%rsp)
	movl	$0, -4(%rsp)
.L33:
	movl	-8(%rsp), %r13d
	xorl	%r12d, %r12d
	.p2align 4,,10
	.p2align 3
.L35:
	movslq	%r13d, %rax
	xorl	%r8d, %r8d
	leaq	(%rdx,%rax,8), %r15
	leaq	8(%rdx,%rax,8), %r14
	leal	0(%r13,%rcx), %eax
	cltq
	movsd	(%r15), %xmm3
	leaq	(%rdx,%rax,8), %rbx
	leaq	8(%rdx,%rax,8), %rax
	movsd	(%r14), %xmm2
	movq	%rax, -24(%rsp)
	movsd	(%rax), %xmm0
	movl	-8(%rsp), %eax
	movq	%rbx, -16(%rsp)
	movsd	(%rbx), %xmm1
	movl	%r12d, %ebx
	.p2align 4,,10
	.p2align 3
.L34:
	movslq	%eax, %r10
	movslq	%ebx, %r11
	leal	(%rax,%rcx), %r9d
	movsd	(%rdi,%r10,8), %xmm6
	addl	$2, %r8d
	movsd	8(%rsi,%r11,8), %xmm4
	movslq	%r9d, %r9
	movsd	(%rdi,%r9,8), %xmm8
	addl	$2, %eax
	movsd	(%rsi,%r11,8), %xmm5
	movapd	%xmm6, %xmm7
	mulsd	%xmm4, %xmm6
	mulsd	%xmm8, %xmm4
	mulsd	%xmm5, %xmm7
	mulsd	%xmm8, %xmm5
	movsd	8(%rdi,%r9,8), %xmm8
	leal	(%rbx,%rcx), %r9d
	addsd	%xmm2, %xmm6
	movsd	8(%rdi,%r10,8), %xmm2
	addsd	%xmm0, %xmm4
	movslq	%r9d, %r9
	addsd	%xmm3, %xmm7
	addl	%ebp, %ebx
	addsd	%xmm1, %xmm5
	movsd	8(%rsi,%r9,8), %xmm0
	movsd	(%rsi,%r9,8), %xmm1
	cmpl	%r8d, %ecx
	movapd	%xmm2, %xmm3
	mulsd	%xmm0, %xmm2
	mulsd	%xmm8, %xmm0
	mulsd	%xmm1, %xmm3
	mulsd	%xmm8, %xmm1
	addsd	%xmm6, %xmm2
	addsd	%xmm4, %xmm0
	addsd	%xmm7, %xmm3
	addsd	%xmm5, %xmm1
	ja	.L34
	movq	-16(%rsp), %rax
	movq	-24(%rsp), %rbx
	addl	$2, %r12d
	addl	$2, %r13d
	cmpl	%r12d, %ecx
	movsd	%xmm3, (%r15)
	movsd	%xmm2, (%r14)
	movsd	%xmm1, (%rax)
	movsd	%xmm0, (%rbx)
	ja	.L35
	addl	$2, -4(%rsp)
	addl	%ebp, -8(%rsp)
	cmpl	-4(%rsp), %ecx
	ja	.L33
.L36:
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE26:
	.size	dgemm2, .-dgemm2
	.p2align 4,,15
.globl dgemm3
	.type	dgemm3, @function
dgemm3:
.LFB27:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	movq	%rdx, %r8
	movl	%ecx, %eax
	xorl	%edx, %edx
	movl	%ecx, %r15d
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movl	$3, %ebx
	divl	%ebx
	subq	$16, %rsp
	.cfi_def_cfa_offset 72
	subl	$2, %r15d
	leal	(%rax,%rax,2), %eax
	movl	%eax, -12(%rsp)
	je	.L40
	imull	%ecx, %eax
	leal	(%rcx,%rcx), %r14d
	leal	(%rcx,%rcx,2), %r12d
	movl	$0, -8(%rsp)
	movl	$0, 8(%rsp)
	movl	%eax, 12(%rsp)
.L41:
	movl	-8(%rsp), %eax
	movl	$0, -104(%rsp)
	addl	$1, %eax
	movl	%eax, -96(%rsp)
	movl	-8(%rsp), %eax
	addl	$2, %eax
	movl	%eax, -100(%rsp)
	movl	12(%rsp), %eax
	movl	%eax, -16(%rsp)
	movl	-8(%rsp), %eax
	movl	%eax, -92(%rsp)
	addl	%ecx, %eax
	movl	%eax, -4(%rsp)
	movl	-8(%rsp), %eax
	addl	%r14d, %eax
	movl	%eax, (%rsp)
	movl	-8(%rsp), %eax
	addl	-12(%rsp), %eax
	movl	%eax, 4(%rsp)
	.p2align 4,,10
	.p2align 3
.L45:
	mov	-92(%rsp), %eax
	movl	-104(%rsp), %ebp
	xorl	%r11d, %r11d
	movl	-104(%rsp), %ebx
	movl	-4(%rsp), %r10d
	movl	(%rsp), %r9d
	movl	-104(%rsp), %edx
	addl	%ecx, %ebp
	leaq	(%r8,%rax,8), %rax
	addl	%r14d, %ebx
	movq	%rax, -24(%rsp)
	movsd	(%rax), %xmm8
	mov	-96(%rsp), %eax
	leaq	(%r8,%rax,8), %rax
	movq	%rax, -32(%rsp)
	movsd	(%rax), %xmm7
	mov	-100(%rsp), %eax
	leaq	(%r8,%rax,8), %rax
	movq	%rax, -40(%rsp)
	movsd	(%rax), %xmm6
	movl	-92(%rsp), %eax
	addl	%ecx, %eax
	leaq	(%r8,%rax,8), %rax
	movq	%rax, -48(%rsp)
	movsd	(%rax), %xmm5
	movl	-96(%rsp), %eax
	addl	%ecx, %eax
	leaq	(%r8,%rax,8), %rax
	movq	%rax, -56(%rsp)
	movsd	(%rax), %xmm4
	movl	-100(%rsp), %eax
	addl	%ecx, %eax
	leaq	(%r8,%rax,8), %rax
	movq	%rax, -64(%rsp)
	movsd	(%rax), %xmm3
	movl	-92(%rsp), %eax
	addl	%r14d, %eax
	leaq	(%r8,%rax,8), %rax
	movq	%rax, -72(%rsp)
	movsd	(%rax), %xmm2
	movl	-96(%rsp), %eax
	addl	%r14d, %eax
	leaq	(%r8,%rax,8), %rax
	movq	%rax, -80(%rsp)
	movsd	(%rax), %xmm1
	movl	-100(%rsp), %eax
	addl	%r14d, %eax
	leaq	(%r8,%rax,8), %rax
	movq	%rax, -88(%rsp)
	movsd	(%rax), %xmm0
	movl	-8(%rsp), %eax
	.p2align 4,,10
	.p2align 3
.L42:
	mov	%eax, %r13d
	addl	$3, %r11d
	movsd	(%rdi,%r13,8), %xmm14
	mov	%r10d, %r13d
	movsd	(%rdi,%r13,8), %xmm13
	mov	%r9d, %r13d
	movsd	(%rdi,%r13,8), %xmm9
	mov	%edx, %r13d
	movsd	(%rsi,%r13,8), %xmm12
	leal	1(%rdx), %r13d
	movsd	(%rsi,%r13,8), %xmm11
	leal	2(%rdx), %r13d
	addl	%r12d, %edx
	movsd	(%rsi,%r13,8), %xmm10
	leal	1(%rax), %r13d
	movsd	%xmm10, -120(%rsp)
	movapd	%xmm14, %xmm10
	mulsd	%xmm12, %xmm10
	movsd	-120(%rsp), %xmm15
	mulsd	%xmm13, %xmm15
	addsd	%xmm10, %xmm8
	movapd	%xmm14, %xmm10
	mulsd	%xmm11, %xmm10
	addsd	%xmm3, %xmm15
	movapd	%xmm9, %xmm3
	movsd	%xmm8, -112(%rsp)
	movsd	-120(%rsp), %xmm8
	mulsd	%xmm12, %xmm3
	addsd	%xmm7, %xmm10
	mulsd	%xmm14, %xmm8
	movapd	%xmm13, %xmm14
	mulsd	%xmm11, %xmm14
	addsd	%xmm2, %xmm3
	movapd	%xmm9, %xmm2
	addsd	%xmm6, %xmm8
	movapd	%xmm13, %xmm6
	mulsd	%xmm11, %xmm2
	mulsd	%xmm12, %xmm6
	addsd	%xmm4, %xmm14
	addsd	%xmm1, %xmm2
	movsd	-120(%rsp), %xmm1
	addsd	%xmm5, %xmm6
	movsd	(%rdi,%r13,8), %xmm5
	leal	1(%r10), %r13d
	mulsd	%xmm9, %xmm1
	movapd	%xmm5, %xmm4
	movapd	%xmm5, %xmm7
	movsd	(%rdi,%r13,8), %xmm13
	leal	1(%r9), %r13d
	movsd	(%rdi,%r13,8), %xmm9
	mov	%ebp, %r13d
	movsd	(%rsi,%r13,8), %xmm12
	leal	1(%rbp), %r13d
	addsd	%xmm0, %xmm1
	movsd	(%rsi,%r13,8), %xmm11
	leal	2(%rbp), %r13d
	addl	%r12d, %ebp
	mulsd	%xmm12, %xmm7
	mulsd	%xmm11, %xmm4
	movsd	(%rsi,%r13,8), %xmm0
	leal	2(%rax), %r13d
	addl	$3, %eax
	mulsd	%xmm0, %xmm5
	addsd	-112(%rsp), %xmm7
	addsd	%xmm4, %xmm10
	movapd	%xmm13, %xmm4
	mulsd	%xmm12, %xmm4
	mulsd	%xmm9, %xmm12
	addsd	%xmm8, %xmm5
	movsd	%xmm10, -112(%rsp)
	addsd	%xmm6, %xmm4
	movapd	%xmm13, %xmm6
	addsd	%xmm3, %xmm12
	mulsd	%xmm0, %xmm13
	mulsd	%xmm11, %xmm6
	mulsd	%xmm9, %xmm11
	mulsd	%xmm0, %xmm9
	addsd	%xmm15, %xmm13
	addsd	%xmm6, %xmm14
	movsd	(%rdi,%r13,8), %xmm6
	leal	2(%r10), %r13d
	addsd	%xmm2, %xmm11
	addl	$3, %r10d
	movapd	%xmm6, %xmm8
	movsd	(%rdi,%r13,8), %xmm3
	leal	2(%r9), %r13d
	addsd	%xmm1, %xmm9
	addl	$3, %r9d
	movsd	%xmm14, -120(%rsp)
	movsd	(%rdi,%r13,8), %xmm10
	mov	%ebx, %r13d
	movsd	(%rsi,%r13,8), %xmm2
	leal	1(%rbx), %r13d
	mulsd	%xmm2, %xmm8
	movsd	(%rsi,%r13,8), %xmm1
	leal	2(%rbx), %r13d
	addl	%r12d, %ebx
	cmpl	%r11d, %r15d
	movsd	(%rsi,%r13,8), %xmm0
	addsd	%xmm7, %xmm8
	movapd	%xmm6, %xmm7
	mulsd	%xmm0, %xmm6
	mulsd	%xmm1, %xmm7
	addsd	%xmm5, %xmm6
	movapd	%xmm3, %xmm5
	addsd	-112(%rsp), %xmm7
	mulsd	%xmm2, %xmm5
	mulsd	%xmm10, %xmm2
	addsd	%xmm4, %xmm5
	movapd	%xmm3, %xmm4
	mulsd	%xmm0, %xmm3
	addsd	%xmm12, %xmm2
	mulsd	%xmm1, %xmm4
	mulsd	%xmm10, %xmm0
	mulsd	%xmm10, %xmm1
	addsd	%xmm13, %xmm3
	addsd	%xmm14, %xmm4
	addsd	%xmm9, %xmm0
	addsd	%xmm11, %xmm1
	ja	.L42
	cmpl	-12(%rsp), %ecx
	jbe	.L43
	movl	4(%rsp), %edx
	movl	-16(%rsp), %eax
	movl	-12(%rsp), %ebx
	.p2align 4,,10
	.p2align 3
.L44:
	mov	%edx, %ebp
	addl	$1, %ebx
	movsd	(%rdi,%rbp,8), %xmm14
	leal	(%rdx,%rcx), %ebp
	movsd	(%rdi,%rbp,8), %xmm13
	leal	(%rdx,%r14), %ebp
	movapd	%xmm14, %xmm15
	addl	$1, %edx
	movsd	(%rdi,%rbp,8), %xmm10
	mov	%eax, %ebp
	movsd	(%rsi,%rbp,8), %xmm12
	leal	1(%rax), %ebp
	mulsd	%xmm12, %xmm15
	movsd	(%rsi,%rbp,8), %xmm11
	leal	2(%rax), %ebp
	addl	%ecx, %eax
	cmpl	%ebx, %ecx
	movsd	(%rsi,%rbp,8), %xmm9
	addsd	%xmm15, %xmm8
	movapd	%xmm14, %xmm15
	mulsd	%xmm9, %xmm14
	mulsd	%xmm11, %xmm15
	addsd	%xmm14, %xmm6
	movapd	%xmm13, %xmm14
	addsd	%xmm15, %xmm7
	mulsd	%xmm12, %xmm14
	mulsd	%xmm10, %xmm12
	addsd	%xmm14, %xmm5
	movapd	%xmm13, %xmm14
	mulsd	%xmm9, %xmm13
	addsd	%xmm12, %xmm2
	mulsd	%xmm11, %xmm14
	mulsd	%xmm10, %xmm9
	mulsd	%xmm10, %xmm11
	addsd	%xmm13, %xmm3
	addsd	%xmm14, %xmm4
	addsd	%xmm9, %xmm0
	addsd	%xmm11, %xmm1
	ja	.L44
.L43:
	movq	-24(%rsp), %rax
	addl	$3, -104(%rsp)
	addl	$3, -92(%rsp)
	addl	$3, -96(%rsp)
	addl	$3, -100(%rsp)
	movsd	%xmm8, (%rax)
	movq	-32(%rsp), %rax
	addl	$3, -16(%rsp)
	cmpl	-104(%rsp), %r15d
	movsd	%xmm7, (%rax)
	movq	-40(%rsp), %rax
	movsd	%xmm6, (%rax)
	movq	-48(%rsp), %rax
	movsd	%xmm5, (%rax)
	movq	-56(%rsp), %rax
	movsd	%xmm4, (%rax)
	movq	-64(%rsp), %rax
	movsd	%xmm3, (%rax)
	movq	-72(%rsp), %rax
	movsd	%xmm2, (%rax)
	movq	-80(%rsp), %rax
	movsd	%xmm1, (%rax)
	movq	-88(%rsp), %rax
	movsd	%xmm0, (%rax)
	ja	.L45
	addl	$3, 8(%rsp)
	addl	%r12d, -8(%rsp)
	cmpl	8(%rsp), %r15d
	ja	.L41
.L40:
	testl	%ecx, %ecx
	je	.L56
	movl	-12(%rsp), %r13d
	xorl	%r10d, %r10d
	xorl	%r12d, %r12d
.L47:
	cmpl	%r13d, %ecx
	movl	%r13d, %r11d
	jbe	.L49
	.p2align 4,,10
	.p2align 3
.L51:
	leal	(%r11,%r10), %eax
	movl	%r11d, %edx
	leaq	(%r8,%rax,8), %r9
	xorl	%eax, %eax
	movsd	(%r9), %xmm1
	.p2align 4,,10
	.p2align 3
.L48:
	leal	(%rax,%r10), %ebp
	mov	%edx, %ebx
	addl	$1, %eax
	addl	%ecx, %edx
	cmpl	%eax, %ecx
	movsd	(%rdi,%rbp,8), %xmm0
	mulsd	(%rsi,%rbx,8), %xmm0
	addsd	%xmm0, %xmm1
	movsd	%xmm1, (%r9)
	ja	.L48
	addl	$1, %r11d
	cmpl	%r11d, %ecx
	ja	.L51
.L49:
	addl	$1, %r12d
	addl	%ecx, %r10d
	cmpl	%r12d, %ecx
	ja	.L47
	cmpl	-12(%rsp), %ecx
	jbe	.L56
	movl	-12(%rsp), %r10d
	movl	-12(%rsp), %r12d
	imull	%ecx, %r10d
	movl	%r12d, %r13d
.L52:
	xorl	%r11d, %r11d
	testl	%r13d, %r13d
	je	.L54
	.p2align 4,,10
	.p2align 3
.L55:
	leal	(%r11,%r10), %eax
	movl	%r11d, %edx
	leaq	(%r8,%rax,8), %r9
	xorl	%eax, %eax
	movsd	(%r9), %xmm1
	.p2align 4,,10
	.p2align 3
.L53:
	leal	(%rax,%r10), %ebp
	mov	%edx, %ebx
	addl	$1, %eax
	addl	%ecx, %edx
	cmpl	%eax, %ecx
	movsd	(%rdi,%rbp,8), %xmm0
	mulsd	(%rsi,%rbx,8), %xmm0
	addsd	%xmm0, %xmm1
	movsd	%xmm1, (%r9)
	ja	.L53
	addl	$1, %r11d
	cmpl	%r11d, %r13d
	ja	.L55
.L54:
	addl	$1, %r12d
	addl	%ecx, %r10d
	cmpl	%r12d, %ecx
	ja	.L52
.L56:
	addq	$16, %rsp
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE27:
	.size	dgemm3, .-dgemm3
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"%.2f "
	.text
	.p2align 4,,15
.globl printMatrix
	.type	printMatrix, @function
printMatrix:
.LFB22:
	.cfi_startproc
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	xorl	%r14d, %r14d
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	xorl	%r13d, %r13d
	testl	%esi, %esi
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	movl	%esi, %r12d
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	movq	%rdi, %rbx
	je	.L67
	.p2align 4,,10
	.p2align 3
.L65:
	xorl	%ebp, %ebp
	.p2align 4,,10
	.p2align 3
.L66:
	leal	0(%r13,%rbp), %eax
	movl	$.LC0, %edi
	addl	$1, %ebp
	movsd	(%rbx,%rax,8), %xmm0
	movl	$1, %eax
	call	printf
	cmpl	%ebp, %r12d
	ja	.L66
	movl	$10, %edi
	addl	$1, %r14d
	addl	%r12d, %r13d
	call	putchar
	cmpl	%r14d, %r12d
	ja	.L65
.L67:
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE22:
	.size	printMatrix, .-printMatrix
	.p2align 4,,15
.globl createMatrix
	.type	createMatrix, @function
createMatrix:
.LFB18:
	.cfi_startproc
	imull	%edi, %edi
	leal	1(%rdi), %esi
	movl	$8, %edi
	jmp	calloc
	.cfi_endproc
.LFE18:
	.size	createMatrix, .-createMatrix
	.p2align 4,,15
.globl createMatrixWithRandomData
	.type	createMatrixWithRandomData, @function
createMatrixWithRandomData:
.LFB19:
	.cfi_startproc
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	movl	%edi, %ebx
	imull	%edi, %ebx
	movl	$8, %edi
	leal	1(%rbx), %esi
	call	calloc
	testl	%ebx, %ebx
	movq	%rax, %r14
	je	.L72
	movq	%rax, %r12
	xorl	%ebp, %ebp
	movl	$880754283, %r13d
	.p2align 4,,10
	.p2align 3
.L73:
	call	rand
	movl	%eax, %ecx
	addl	$1, %ebp
	imull	%r13d
	movl	%ecx, %eax
	sarl	$31, %eax
	sarl	$11, %edx
	subl	%eax, %edx
	imull	$9987, %edx, %edx
	subl	%edx, %ecx
	cvtsi2sd	%ecx, %xmm0
	divsd	.LC1(%rip), %xmm0
	movsd	%xmm0, (%r12)
	addq	$8, %r12
	cmpl	%ebx, %ebp
	jb	.L73
.L72:
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	movq	%r14, %rax
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE19:
	.size	createMatrixWithRandomData, .-createMatrixWithRandomData
	.section	.rodata.str1.1
.LC3:
	.string	"performace: %lf Gflops\n"
.LC4:
	.string	"timespec is %lu s %lu ns\n"
	.text
	.p2align 4,,15
.globl runTest
	.type	runTest, @function
runTest:
.LFB23:
	.cfi_startproc
	movq	%r13, -16(%rsp)
	movq	%rsi, %r13
	.cfi_offset 13, -24
	movl	%ecx, %esi
	imull	%ecx, %esi
	movq	%rbx, -40(%rsp)
	movq	%rbp, -32(%rsp)
	movq	%r12, -24(%rsp)
	movq	%r14, -8(%rsp)
	movq	%rdi, %r12
	.cfi_offset 14, -16
	.cfi_offset 12, -32
	.cfi_offset 6, -40
	.cfi_offset 3, -48
	subq	$72, %rsp
	.cfi_def_cfa_offset 80
	movl	$8, %edi
	movq	%rdx, %r14
	addl	$1, %esi
	movl	%ecx, %ebx
	call	calloc
	leaq	16(%rsp), %rsi
	xorl	%edi, %edi
	movq	%rax, %rbp
	call	clock_gettime
	movq	%r13, %rdi
	movl	%ebx, %ecx
	movq	%rbp, %rdx
	movq	%r14, %rsi
	call	*%r12
	xorl	%edi, %edi
	movq	%rsp, %rsi
	call	clock_gettime
	movq	8(%rsp), %r13
	subq	24(%rsp), %r13
	js	.L82
	movq	(%rsp), %r12
	subq	16(%rsp), %r12
.L78:
	mov	%ebx, %ebx
	cvtsi2sdq	%r13, %xmm2
	cvtsi2sdq	%rbx, %xmm1
	movl	$.LC3, %edi
	movsd	.LC2(%rip), %xmm3
	movl	$1, %eax
	mulsd	%xmm3, %xmm2
	movapd	%xmm1, %xmm0
	addsd	%xmm1, %xmm0
	mulsd	%xmm1, %xmm0
	mulsd	%xmm1, %xmm0
	cvtsi2sdq	%r12, %xmm1
	addsd	%xmm2, %xmm1
	divsd	%xmm1, %xmm0
	mulsd	%xmm3, %xmm0
	call	printf
	movq	%r13, %rdx
	movq	%r12, %rsi
	movl	$.LC4, %edi
	xorl	%eax, %eax
	call	printf
	movq	%rbp, %rax
	movq	32(%rsp), %rbx
	movq	40(%rsp), %rbp
	movq	48(%rsp), %r12
	movq	56(%rsp), %r13
	movq	64(%rsp), %r14
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L82:
	.cfi_restore_state
	movq	(%rsp), %r12
	addq	$1000000000, %r13
	subq	$1, %r12
	subq	16(%rsp), %r12
	jmp	.L78
	.cfi_endproc
.LFE23:
	.size	runTest, .-runTest
	.section	.rodata.str1.1
.LC5:
	.string	"dgemm0, when n = %d\n"
.LC6:
	.string	"dgemm1, when n = %d\n"
.LC7:
	.string	"dgemm2, when n = %d\n"
.LC8:
	.string	"dgemm3, when n = %d\n"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC9:
	.string	"\n==================\nRandom data generated\n------------------"
	.section	.rodata.str1.1
.LC10:
	.string	"\n------------------"
.LC11:
	.string	"c1 output error when n = %d\n"
.LC12:
	.string	"c2 output error when n = %d\n"
.LC13:
	.string	"c3 output error when n = %d\n"
	.section	.rodata.str1.8
	.align 8
.LC14:
	.string	"c1 output checked when n = %d\n"
	.align 8
.LC15:
	.string	"c2 output checked when n = %d\n"
	.align 8
.LC16:
	.string	"c3 output checked when n = %d\n"
	.text
	.p2align 4,,15
.globl main
	.type	main, @function
main:
.LFB28:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	movl	$12306, %edi
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movl	$880754283, %r12d
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movl	$64, %ebx
	subq	$40, %rsp
	.cfi_def_cfa_offset 96
	call	srand
	movl	$0, 28(%rsp)
.L95:
	movl	%ebx, %ebp
	movl	$8, %edi
	xorl	%r14d, %r14d
	imull	%ebx, %ebp
	leal	1(%rbp), %r13d
	movq	%r13, %rsi
	call	calloc
	movq	%rax, %r15
	movq	%rax, %rsi
	.p2align 4,,10
	.p2align 3
.L84:
	movq	%rsi, 8(%rsp)
	addl	$1, %r14d
	call	rand
	movl	%eax, %ecx
	movq	8(%rsp), %rsi
	imull	%r12d
	movl	%ecx, %eax
	sarl	$31, %eax
	sarl	$11, %edx
	subl	%eax, %edx
	imull	$9987, %edx, %edx
	subl	%edx, %ecx
	cvtsi2sd	%ecx, %xmm0
	divsd	.LC1(%rip), %xmm0
	movsd	%xmm0, (%rsi)
	addq	$8, %rsi
	cmpl	%ebp, %r14d
	jb	.L84
	movq	%r13, %rsi
	movl	$8, %edi
	xorl	%r13d, %r13d
	call	calloc
	movq	%rax, 16(%rsp)
	movq	%rax, %r14
	.p2align 4,,10
	.p2align 3
.L85:
	call	rand
	movl	%eax, %ecx
	addl	$1, %r13d
	imull	%r12d
	movl	%ecx, %eax
	sarl	$31, %eax
	sarl	$11, %edx
	subl	%eax, %edx
	imull	$9987, %edx, %edx
	subl	%edx, %ecx
	cvtsi2sd	%ecx, %xmm0
	divsd	.LC1(%rip), %xmm0
	movsd	%xmm0, (%r14)
	addq	$8, %r14
	cmpl	%r13d, %ebp
	ja	.L85
	movl	$.LC9, %edi
	call	puts
	movl	%ebx, %esi
	movl	$.LC5, %edi
	xorl	%eax, %eax
	call	printf
	movq	16(%rsp), %rdx
	movl	%ebx, %ecx
	movq	%r15, %rsi
	movl	$dgemm0, %edi
	call	runTest
	movl	$.LC10, %edi
	movq	%rax, %rbp
	call	puts
	movl	%ebx, %esi
	movl	$.LC6, %edi
	xorl	%eax, %eax
	call	printf
	movq	16(%rsp), %rdx
	movl	%ebx, %ecx
	movq	%r15, %rsi
	movl	$dgemm1, %edi
	call	runTest
	movl	$.LC10, %edi
	movq	%rax, %r13
	call	puts
	movl	%ebx, %esi
	movl	$.LC7, %edi
	xorl	%eax, %eax
	call	printf
	movq	16(%rsp), %rdx
	movl	%ebx, %ecx
	movq	%r15, %rsi
	movl	$dgemm2, %edi
	call	runTest
	movl	$.LC10, %edi
	movq	%rax, %r14
	call	puts
	movl	%ebx, %esi
	movl	$.LC8, %edi
	xorl	%eax, %eax
	call	printf
	movq	16(%rsp), %rdx
	movl	%ebx, %ecx
	movq	%r15, %rsi
	movl	$dgemm3, %edi
	call	runTest
	movl	$.LC10, %edi
	movq	%rax, 8(%rsp)
	call	puts
	movq	8(%rsp), %rdx
	xorl	%eax, %eax
	xorl	%ecx, %ecx
	.p2align 4,,10
	.p2align 3
.L87:
	movsd	0(%rbp,%rax), %xmm0
	ucomisd	0(%r13,%rax), %xmm0
	jne	.L86
	jp	.L86
	addl	$1, %ecx
	addq	$8, %rax
	cmpl	%ebx, %ecx
	jb	.L87
	movl	%ebx, %esi
	movl	$.LC14, %edi
	xorl	%eax, %eax
	movq	%rdx, 8(%rsp)
	call	printf
	movq	8(%rsp), %rdx
	xorl	%eax, %eax
	xorl	%ecx, %ecx
	.p2align 4,,10
	.p2align 3
.L90:
	movsd	0(%rbp,%rax), %xmm0
	ucomisd	(%r14,%rax), %xmm0
	jne	.L89
	jp	.L89
	addl	$1, %ecx
	addq	$8, %rax
	cmpl	%ebx, %ecx
	jb	.L90
	movl	%ebx, %esi
	movl	$.LC15, %edi
	xorl	%eax, %eax
	movq	%rdx, 8(%rsp)
	call	printf
	movq	8(%rsp), %rdx
	xorl	%eax, %eax
	xorl	%ecx, %ecx
	.p2align 4,,10
	.p2align 3
.L93:
	movsd	0(%rbp,%rax), %xmm0
	ucomisd	(%rdx,%rax), %xmm0
	jne	.L92
	jp	.L92
	addl	$1, %ecx
	addq	$8, %rax
	cmpl	%ebx, %ecx
	jb	.L93
	movl	%ebx, %esi
	movl	$.LC16, %edi
	xorl	%eax, %eax
	call	printf
	movq	%r15, %rdi
	addl	%ebx, %ebx
	call	free
	movq	16(%rsp), %rdi
	call	free
	movq	%rbp, %rdi
	call	free
	movq	%r13, %rdi
	call	free
	movq	%r14, %rdi
	call	free
	addl	$1, 28(%rsp)
	cmpl	$6, 28(%rsp)
	jne	.L95
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L86:
	.cfi_restore_state
	movl	$.LC11, %edi
	movl	%ebx, %esi
	xorl	%eax, %eax
	call	printf
	movl	$1, %edi
	call	exit
.L92:
	movl	$.LC13, %edi
	movl	%ebx, %esi
	xorl	%eax, %eax
	call	printf
	movl	$1, %edi
	call	exit
.L89:
	movl	$.LC12, %edi
	movl	%ebx, %esi
	xorl	%eax, %eax
	call	printf
	movl	$1, %edi
	call	exit
	.cfi_endproc
.LFE28:
	.size	main, .-main
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC1:
	.long	0
	.long	1079574528
	.align 8
.LC2:
	.long	3894859413
	.long	1041313291
	.ident	"GCC: (GNU) 4.4.7 20120313 (Red Hat 4.4.7-18)"
	.section	.note.GNU-stack,"",@progbits
