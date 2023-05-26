.global ciao

.data
	parola: .string "ciao\n"
	
.text 

	ciao:
		la a1, parola		# carico l'address della parola

		li	a7, 4
		mv 	a0, a1
		ecall			# stampo la parola per prova
					
		jal ra, strlen		# chiamo la funzione strlen
		
		li a7, 1		# stampo la lunghezza della stringa che ho salvato su a0
		ecall
		
		li	a7, 93		# return 0
		li	a0, 0
		ecall
		
	strlen:
		
		lb t0, 0(a1) 		# carico il primo carattere della stringa
		li t1, 0     		# contatore di caratteri e contatore del loop
		
		beq t0, zero, exit 	# se a priori vedo che il primo carattere della stringa è nullo, allora la stringa è vuota e ritorno 0

		loop:
			add t2, a0, t1 	# carico l'indirizzo di &A[i] dentro t2
			lb t0, 0(t2)	# carico il valore di A[i] dentro t0
			beq t0, zero, exit	# se il valore di t0 è nullo, allora ho finito di navigare la stringa
			addi t1, t1, 1	 # incremento il mio contatore
			jal zero, loop 	# ricomincio il loop
		
		exit:
			mv a0, t1
			jr ra		# potete anche usare una jalr zero, 0(ra)
			
	
