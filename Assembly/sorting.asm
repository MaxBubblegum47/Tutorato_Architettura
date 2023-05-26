.globl main

.data
	numv:    .byte 10 
	vett:    .word 8, 3, 9, 2, 5, 6, 1, 0, 2, 2
.text
	
main:

	#
	# parametri della funzione
	# sort(n, vett)
	#
	la 	a0, numv
	la 	a1, vett
	lb 	a0, (a0)
	
	jal	ra, print

	la 	a0, numv
	la 	a1, vett
	lb 	a0, (a0)
	# chiamata a funzione
	jal ra, sort
	
	la 	a0, numv
	la 	a1, vett
	lb 	a0, (a0)
	
	jal	ra, print


	li a7, 93
	li a0, 0
	ecall
	
print:
	li	t0, 0
	mv	t1, a0
	for: 
		li	a7, 1
		lw	a0, (a1)
		ecall
		
		li	a7, 11
		li	a0, ' '
		ecall
		
		addi	a1, a1, 4
		addi	t0, t0, 1
		blt	t0, t1, for
		
	li	a7, 11
	li	a0, '\n'
	ecall
	ret

sort:

	# indice del loop
	li 	t0, 0

	# limiti dei loop
	mv 	a2, a0
	addi 	a2, a2, -1

	loop_a:
	
		mv 	t1, t0
		addi	t1, t1, 1
	
		loop_b:
			#
			# calcolo offset sul vettore
			# 
			# t3 <- a1 + 4 x t0
			# t4 <- a1 + 4 x t1
		
			mv 	s3, t0
			slli	s3, s3, 2
			mv	s4, t1
			slli	s4, s4, 2

			#
			# puntatori
			#
			add	t3, a1, s3	
			add	t4, a1, s4	
			
			#
			# valori del vettore
			#
			lw	s3, (t3)
			lw	s4, (t4)
			
			# if vett_j < vett_i
			# t3 <- vett_j
			# t4 <- vett_i
			blt	s3, s4, noswp
				
				# swap dei valori
				#
				sw	s4, (t3)	
				sw	s3, (t4)	
	
				noswp:

			addi	t1, t1, 1
			blt	t1, a0, loop_b
		
		addi 	t0, t0, 1
		blt	t0, a2, loop_a

		jr 	ra 
