	.file	"cdpl.c"
	.def	___main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
	.align 4
LC0:
	.ascii "usage: codepeel <src-file> <code-file> <comment-file>\12\0"
LC1:
	.ascii "r\0"
LC2:
	.ascii "w\0"
LC3:
	.ascii "(//)[/*]{*/}\0"
	.align 4
LC4:
	.ascii "=======ERROR=======\12[1] Error occured in Codepeel function\12[2] ERR_CODE := ERR_%d\12\0"
	.text
	.globl	_main
	.def	_main;	.scl	2;	.type	32;	.endef
_main:
	pushl	%ebp
	movl	%esp, %ebp
	andl	$-16, %esp
	subl	$32, %esp
	call	___main
	cmpl	$4, 8(%ebp)
	je	L2
	movl	$LC0, (%esp)
	call	_puts
	movl	$1, (%esp)
	call	_exit
L2:
	movl	12(%ebp), %eax
	addl	$4, %eax
	movl	(%eax), %eax
	movl	$LC1, 4(%esp)
	movl	%eax, (%esp)
	call	_fopen
	movl	%eax, 28(%esp)
	cmpl	$0, 28(%esp)
	jne	L3
	movl	12(%ebp), %eax
	addl	$4, %eax
	movl	(%eax), %eax
	movl	%eax, (%esp)
	call	_perror
	movl	$2, (%esp)
	call	_exit
L3:
	movl	12(%ebp), %eax
	addl	$8, %eax
	movl	(%eax), %eax
	movl	$LC2, 4(%esp)
	movl	%eax, (%esp)
	call	_fopen
	movl	%eax, 24(%esp)
	cmpl	$0, 24(%esp)
	jne	L4
	movl	12(%ebp), %eax
	addl	$8, %eax
	movl	(%eax), %eax
	movl	%eax, (%esp)
	call	_perror
	movl	$3, (%esp)
	call	_exit
L4:
	movl	12(%ebp), %eax
	addl	$12, %eax
	movl	(%eax), %eax
	movl	$LC2, 4(%esp)
	movl	%eax, (%esp)
	call	_fopen
	movl	%eax, 20(%esp)
	cmpl	$0, 20(%esp)
	jne	L5
	movl	12(%ebp), %eax
	addl	$12, %eax
	movl	(%eax), %eax
	movl	%eax, (%esp)
	call	_perror
	movl	$4, (%esp)
	call	_exit
L5:
	movl	$LC3, 12(%esp)
	movl	20(%esp), %eax
	movl	%eax, 8(%esp)
	movl	24(%esp), %eax
	movl	%eax, 4(%esp)
	movl	28(%esp), %eax
	movl	%eax, (%esp)
	call	_codepeel
	movl	%eax, 16(%esp)
	cmpl	$0, 16(%esp)
	jle	L7
	movl	16(%esp), %eax
	movl	%eax, 8(%esp)
	movl	$LC4, 4(%esp)
	movl	__imp___iob, %eax
	addl	$64, %eax
	movl	%eax, (%esp)
	call	_fprintf
	movl	$5, (%esp)
	call	_exit
L7:
	leave
	ret
	.globl	_codepeel
	.def	_codepeel;	.scl	2;	.type	32;	.endef
_codepeel:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$104, %esp
	cmpl	$0, 8(%ebp)
	je	L9
	cmpl	$0, 12(%ebp)
	je	L9
	cmpl	$0, 16(%ebp)
	jne	L10
L9:
	movl	$1, %eax
	jmp	L33
L10:
	movl	$1024, (%esp)
	call	_malloc
	movl	%eax, -32(%ebp)
	movl	$1024, (%esp)
	call	_malloc
	movl	%eax, -36(%ebp)
	movl	$1024, (%esp)
	call	_malloc
	movl	%eax, -40(%ebp)
	movl	-32(%ebp), %eax
	movl	%eax, -12(%ebp)
	movl	-36(%ebp), %eax
	movl	%eax, -16(%ebp)
	movl	-36(%ebp), %eax
	movl	%eax, -20(%ebp)
	movl	-40(%ebp), %eax
	movl	%eax, -24(%ebp)
	leal	-76(%ebp), %eax
	movl	%eax, 12(%esp)
	leal	-72(%ebp), %eax
	movl	%eax, 8(%esp)
	leal	-68(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	20(%ebp), %eax
	movl	%eax, (%esp)
	call	_brkcom
	movl	-68(%ebp), %eax
	movl	%eax, (%esp)
	call	_strlen
	movl	%eax, -44(%ebp)
	movl	-72(%ebp), %eax
	movl	%eax, (%esp)
	call	_strlen
	movl	%eax, -48(%ebp)
	movl	-76(%ebp), %eax
	movl	%eax, (%esp)
	call	_strlen
	movl	%eax, -52(%ebp)
	movl	$0, -28(%ebp)
	movl	$0, -56(%ebp)
	movl	-44(%ebp), %eax
	cmpl	-48(%ebp), %eax
	jle	L12
	movl	-44(%ebp), %eax
	jmp	L13
L12:
	movl	-52(%ebp), %edx
	movl	-48(%ebp), %eax
	cmpl	%edx, %eax
	jge	L14
	movl	%edx, %eax
L14:
L13:
	movl	%eax, (%esp)
	call	_malloc
	movl	%eax, -60(%ebp)
	jmp	L15
L32:
	movl	8(%ebp), %eax
	movl	12(%eax), %eax
	andl	$16, %eax
	testl	%eax, %eax
	jne	L34
L16:
	movl	-36(%ebp), %eax
	movl	%eax, -20(%ebp)
	movl	-40(%ebp), %eax
	movl	%eax, -24(%ebp)
	movl	-36(%ebp), %eax
	movl	%eax, -16(%ebp)
	movl	-32(%ebp), %eax
	movl	%eax, -12(%ebp)
	jmp	L18
L31:
	movl	-12(%ebp), %eax
	movb	(%eax), %al
	cmpb	$34, %al
	jne	L19
	cmpl	$0, -28(%ebp)
	jne	L20
	movl	$1, -28(%ebp)
	jmp	L19
L20:
	movl	$0, -28(%ebp)
L19:
	movl	-12(%ebp), %eax
	movb	(%eax), %dl
	movl	-68(%ebp), %eax
	movb	(%eax), %al
	cmpb	%al, %dl
	je	L21
	movl	-12(%ebp), %eax
	movb	(%eax), %dl
	movl	-72(%ebp), %eax
	movb	(%eax), %al
	cmpb	%al, %dl
	je	L21
	movl	-12(%ebp), %eax
	movb	(%eax), %dl
	movl	-76(%ebp), %eax
	movb	(%eax), %al
	cmpb	%al, %dl
	jne	L22
L21:
	cmpl	$0, -28(%ebp)
	je	L23
L22:
	movl	-12(%ebp), %eax
	movb	(%eax), %dl
	movl	-16(%ebp), %eax
	movb	%dl, (%eax)
	incl	-16(%ebp)
	jmp	L24
L23:
	movl	-44(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	-12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	-60(%ebp), %eax
	movl	%eax, (%esp)
	call	_strncpy
	movl	-44(%ebp), %edx
	movl	-60(%ebp), %eax
	addl	%edx, %eax
	movb	$0, (%eax)
	movl	-68(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	-60(%ebp), %eax
	movl	%eax, (%esp)
	call	_strcmp
	testl	%eax, %eax
	jne	L25
	movl	-16(%ebp), %eax
	movl	%eax, -20(%ebp)
	movl	-24(%ebp), %eax
	movl	%eax, -16(%ebp)
	movl	-44(%ebp), %eax
	addl	%eax, -12(%ebp)
	jmp	L26
L27:
	movl	-12(%ebp), %eax
	movb	(%eax), %dl
	movl	-16(%ebp), %eax
	movb	%dl, (%eax)
	incl	-16(%ebp)
	incl	-12(%ebp)
L26:
	movl	-12(%ebp), %eax
	movb	(%eax), %al
	cmpb	$10, %al
	jne	L27
	movl	-12(%ebp), %eax
	movb	(%eax), %al
	cmpb	$10, %al
	jne	L28
	movl	-16(%ebp), %eax
	movb	$10, (%eax)
	incl	-16(%ebp)
L28:
	movl	-16(%ebp), %eax
	movl	%eax, -24(%ebp)
	movl	-20(%ebp), %eax
	movl	%eax, -16(%ebp)
	jmp	L24
L25:
	movl	-48(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	-12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	-60(%ebp), %eax
	movl	%eax, (%esp)
	call	_strncpy
	movl	-48(%ebp), %edx
	movl	-60(%ebp), %eax
	addl	%edx, %eax
	movb	$0, (%eax)
	movl	-72(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	-60(%ebp), %eax
	movl	%eax, (%esp)
	call	_strcmp
	testl	%eax, %eax
	jne	L29
	movl	-16(%ebp), %eax
	movl	%eax, -20(%ebp)
	movl	-24(%ebp), %eax
	movl	%eax, -16(%ebp)
	movl	-48(%ebp), %eax
	decl	%eax
	addl	%eax, -12(%ebp)
	jmp	L24
L29:
	movl	-52(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	-12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	-60(%ebp), %eax
	movl	%eax, (%esp)
	call	_strncpy
	movl	-52(%ebp), %edx
	movl	-60(%ebp), %eax
	addl	%edx, %eax
	movb	$0, (%eax)
	movl	-76(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	-60(%ebp), %eax
	movl	%eax, (%esp)
	call	_strcmp
	testl	%eax, %eax
	jne	L30
	movl	-16(%ebp), %eax
	movl	%eax, -24(%ebp)
	movl	-20(%ebp), %eax
	movl	%eax, -16(%ebp)
	movl	-52(%ebp), %eax
	decl	%eax
	addl	%eax, -12(%ebp)
	jmp	L24
L30:
	movl	-12(%ebp), %eax
	movb	(%eax), %dl
	movl	-16(%ebp), %eax
	movb	%dl, (%eax)
	incl	-16(%ebp)
L24:
	incl	-12(%ebp)
L18:
	movl	-64(%ebp), %edx
	movl	-32(%ebp), %eax
	addl	%edx, %eax
	cmpl	-12(%ebp), %eax
	ja	L31
	movl	$1024, 8(%esp)
	movl	-36(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$1, (%esp)
	call	_write
	movl	$1024, 8(%esp)
	movl	-40(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$2, (%esp)
	call	_write
L15:
	movl	8(%ebp), %eax
	movl	16(%eax), %eax
	movl	$1024, 8(%esp)
	movl	-32(%ebp), %edx
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_read
	movl	%eax, -64(%ebp)
	cmpl	$0, -64(%ebp)
	jg	L32
	jmp	L17
L34:
	nop
L17:
	movl	$0, %eax
L33:
	leave
	ret
	.globl	_brkcom
	.def	_brkcom;	.scl	2;	.type	32;	.endef
_brkcom:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$40, %esp
	cmpl	$0, 8(%ebp)
	jne	L36
	movl	$1, %eax
	jmp	L37
L36:
	movl	8(%ebp), %eax
	movl	%eax, -12(%ebp)
	movl	20(%ebp), %eax
	movl	$0, (%eax)
	movl	20(%ebp), %eax
	movl	(%eax), %edx
	movl	16(%ebp), %eax
	movl	%edx, (%eax)
	movl	16(%ebp), %eax
	movl	(%eax), %edx
	movl	12(%ebp), %eax
	movl	%edx, (%eax)
	movl	-12(%ebp), %eax
	movb	(%eax), %al
	cmpb	$40, %al
	jne	L38
	movl	$0, -16(%ebp)
	jmp	L39
L40:
	incl	-16(%ebp)
L39:
	movl	-16(%ebp), %edx
	movl	-12(%ebp), %eax
	addl	%edx, %eax
	movb	(%eax), %al
	cmpb	$41, %al
	jne	L40
	movl	-16(%ebp), %eax
	movl	%eax, (%esp)
	call	_malloc
	movl	%eax, %edx
	movl	12(%ebp), %eax
	movl	%edx, (%eax)
	movl	-16(%ebp), %eax
	decl	%eax
	movl	%eax, %edx
	movl	-12(%ebp), %eax
	leal	1(%eax), %ecx
	movl	12(%ebp), %eax
	movl	(%eax), %eax
	movl	%edx, 8(%esp)
	movl	%ecx, 4(%esp)
	movl	%eax, (%esp)
	call	_strncpy
	movl	12(%ebp), %eax
	movl	(%eax), %eax
	movl	-16(%ebp), %edx
	decl	%edx
	addl	%edx, %eax
	movb	$0, (%eax)
	movl	-16(%ebp), %eax
	incl	%eax
	addl	%eax, -12(%ebp)
L38:
	movl	-12(%ebp), %eax
	movb	(%eax), %al
	cmpb	$91, %al
	jne	L41
	movl	$0, -16(%ebp)
	jmp	L42
L43:
	incl	-16(%ebp)
L42:
	movl	-16(%ebp), %edx
	movl	-12(%ebp), %eax
	addl	%edx, %eax
	movb	(%eax), %al
	cmpb	$93, %al
	jne	L43
	movl	-16(%ebp), %eax
	movl	%eax, (%esp)
	call	_malloc
	movl	%eax, %edx
	movl	16(%ebp), %eax
	movl	%edx, (%eax)
	movl	-16(%ebp), %eax
	decl	%eax
	movl	%eax, %edx
	movl	-12(%ebp), %eax
	leal	1(%eax), %ecx
	movl	16(%ebp), %eax
	movl	(%eax), %eax
	movl	%edx, 8(%esp)
	movl	%ecx, 4(%esp)
	movl	%eax, (%esp)
	call	_strncpy
	movl	16(%ebp), %eax
	movl	(%eax), %eax
	movl	-16(%ebp), %edx
	decl	%edx
	addl	%edx, %eax
	movb	$0, (%eax)
	movl	-16(%ebp), %eax
	incl	%eax
	addl	%eax, -12(%ebp)
L41:
	movl	-12(%ebp), %eax
	movb	(%eax), %al
	cmpb	$123, %al
	jne	L44
	movl	$0, -16(%ebp)
	jmp	L45
L46:
	incl	-16(%ebp)
L45:
	movl	-16(%ebp), %edx
	movl	-12(%ebp), %eax
	addl	%edx, %eax
	movb	(%eax), %al
	cmpb	$125, %al
	jne	L46
	movl	-16(%ebp), %eax
	movl	%eax, (%esp)
	call	_malloc
	movl	%eax, %edx
	movl	20(%ebp), %eax
	movl	%edx, (%eax)
	movl	-16(%ebp), %eax
	decl	%eax
	movl	%eax, %edx
	movl	-12(%ebp), %eax
	leal	1(%eax), %ecx
	movl	20(%ebp), %eax
	movl	(%eax), %eax
	movl	%edx, 8(%esp)
	movl	%ecx, 4(%esp)
	movl	%eax, (%esp)
	call	_strncpy
	movl	20(%ebp), %eax
	movl	(%eax), %eax
	movl	-16(%ebp), %edx
	decl	%edx
	addl	%edx, %eax
	movb	$0, (%eax)
	movl	-16(%ebp), %eax
	incl	%eax
	addl	%eax, -12(%ebp)
L44:
	movl	12(%ebp), %eax
	movl	(%eax), %eax
	testl	%eax, %eax
	jne	L47
	movl	16(%ebp), %eax
	movl	(%eax), %eax
	testl	%eax, %eax
	jne	L47
	movl	20(%ebp), %eax
	movl	(%eax), %eax
	testl	%eax, %eax
	jne	L47
	movl	$2, %eax
	jmp	L37
L47:
	movl	$0, %eax
L37:
	leave
	ret
	.def	_puts;	.scl	2;	.type	32;	.endef
	.def	_exit;	.scl	2;	.type	32;	.endef
	.def	_fopen;	.scl	2;	.type	32;	.endef
	.def	_perror;	.scl	2;	.type	32;	.endef
	.def	_fprintf;	.scl	2;	.type	32;	.endef
	.def	_malloc;	.scl	2;	.type	32;	.endef
	.def	_strlen;	.scl	2;	.type	32;	.endef
	.def	_strncpy;	.scl	2;	.type	32;	.endef
	.def	_strcmp;	.scl	2;	.type	32;	.endef
	.def	_write;	.scl	2;	.type	32;	.endef
	.def	_read;	.scl	2;	.type	32;	.endef
