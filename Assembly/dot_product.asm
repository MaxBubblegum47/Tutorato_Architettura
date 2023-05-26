.globl main

.data 
	n: .byte 4         # memorizzo il numero di elementi dell'array
	X: .word 1, 2, 3, 4
	Y: .word 5, 6, 7, 8
	
.text
	main:
		la	a1, n        # usiamo da a1 a seguire e a0 come valore di ritorno
		lb	a1, (a1)     # prendo l'indirizzo di n e carico il contenuto, non tengo solamente l'indirizzo
		la	a2, X
		la	a3, Y
		jal	ra, dot
		
		li	a7, 1
		ecall
		
		li	a7, 93
		li	a0, 0
		ecall
		
	dot:
		addi	sp, sp, -12
		sw	s1, 12(sp)
		sw	s2, 4(sp)
		sw	s3, 0(sp)
	
		li	s1, 0          # i = 0
		li	a0, 0          # valore prodotto scalare
		for:
			lw	s2, (a2)
			lw	s3, (a3)
			mul	s2, s2, s3
			add	a0, a0, s2
			addi	a2, a2, 4
			addi	a3, a3, 4
					
			addi	s1, s1, 1   # i = i + 1
			blt	s1, a1, for   # a1 = n = 4
		
		lw	s1, 12(sp)
		lw	s2, 4(sp)
		lw	s3, 0(sp)
		addi	sp, sp, 12
		ret 
