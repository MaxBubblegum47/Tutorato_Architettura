.global main

.data 
	X: .word 5, 6, 7, 8, 9, 10, 11, 12

	
.text
	main:
		la	a2, X
		
		jal	ra, dot
		
		li	a7, 93
		li	a0, 0
		ecall

	dot:
		li t5, 8
		li	t1, 0          # i = 0, indice
		for:

			slli t3, t1, 2 # mi sto spostando di 4 byte alla volta (un elemento solo)
			add t4, a2, t3
			lw t4, 0(t4)
			
			li a7, 1 # stampa dell'elemento corrente dell'array
			mv a0, t4
			ecall
									
			addi	t1, t1, 1   # i = i + 1
			
			blt	t1, t5, for

		ret 
