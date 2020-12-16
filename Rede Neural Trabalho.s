        .data
p1:		.float 0.0
p2:		.float 0.8
taxa:	.float 0.05
entrada: .word 1
msgp1:	.asciiz "\nPeso 1:"
msgp2:	.asciiz "\nPeso 2:"
msgtx:	.asciiz "\nTaxa de aprendizado:"
msgent:	.asciiz "\nEntrada:"
msgesp:	.asciiz "\nResposta esperada:"
msgenc:	.asciiz "\nResposta encontrada:"
msgerro:	.asciiz	"\nTaxa de Erro:"
espaco:	.asciiz "\n\n--------------------\n"

        .text
        .globl main
main:   l.s $f0,p1
		l.s $f1,p2
		l.s $f2,taxa
		lw $s3,entrada
		add $s4,$s3,$s3
		move $s0, $zero #Ínicio do loop (for)
		loop:
		slt $t0, $s0, 5
		beq $t0, $zero, EXIT
		slti $s5,$s3,6
		mtc1 $s3,$f3
		cvt.s.w $f3,$f3
		mtc1 $s4,$f4
		cvt.s.w $f4,$f4
		
		
		
		li $v0, 4 #Peso 1
		la $a0,msgp1
		syscall
		li $v0, 2
		mov.s $f12, $f0
		syscall
		
		li $v0, 4 #Peso 2
		la $a0,msgp2
		syscall
		li $v0, 2
		mov.s $f12, $f1
		syscall
		
		li $v0, 4 #Taxa de aprendizado
		la $a0,msgtx
		syscall
		li $v0, 2
		mov.s $f12, $f2
		syscall
		
		li $v0, 4 #Valor de entrada
		la $a0,msgent
		syscall
		li $v0, 2
		mov.s $f12, $f3
		syscall
		
		li $v0, 4 #Valor esperado
		la $a0,msgesp
		syscall
		li $v0, 1
		move $a0, $s4
		syscall
		
		li $v0, 4 #Valor encontrado
		la $a0, msgenc
		syscall
		mul.s $f6,$f0,$f3
		mul.s $f7,$f1,$f3
		add.s $f7,$f6,$f7
		li $v0, 2
		mov.s $f12, $f7
		syscall
		
		li $v0, 4 #Calcular valor do erro
		la $a0, msgerro
		syscall
		sub.s $f8,$f4,$f7
		mov.s $f5,$f8
		mul.s $f8,$f8,$f2
		mul.s $f8,$f8,$f3
		add.s $f0,$f0,$f8
		add.s $f1,$f1,$f8
		li $v0, 2
		mov.s $f12, $f5
		syscall
		
		li $v0, 4 #Espaço entre loops
		la $a0, espaco
		syscall
		addi $s3,$s3,1
		add $s4,$s3,$s3
		addi $s0, $s0, 1
		j loop
		EXIT:
		jr $ra #fim
