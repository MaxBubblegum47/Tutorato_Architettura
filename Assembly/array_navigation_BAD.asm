.global main

.data 
	n: .byte 4         # memorizzo il numero di elementi dell'array
	X: .word 5, 6, 7, 8

	
.text
	main:
		la	a1, n        # usiamo da a1 a seguire e a0 come valore di ritorno
		lb	a1, (a1)     # prendo l'indirizzo di n e carico il contenuto, non tengo solamente l'indirizzo
		la	a2, X
		jal	ra, dot
		
		li	a7, 93
		li	a0, 0
		ecall

	dot:
		addi	sp, sp, -8
		sw	s1, 4(sp)
		sw	s2, 0(sp)
	
		li	s1, 0          # i = 0, indice
		for:
			# In questo caso sto andando a lavorare con il puntatore al primo
			# elemento dell'array per effettuare la navigazione. Essenzialmente
			# lo sposto in avanti di un elemento alla volta

			lw	s2, (a2) # carico l'indirizzo corrente dell'array
			addi	a2, a2, 4 # sposto in avanti l'offeset dell'array

			li a7, 1 # stampa dell'elemento corrente dell'array
			mv a0, s2
			ecall
					
			addi	s1, s1, 1   # i = i + 1
			
			blt	s1, a1, for
		
		lw	s1, 4(sp)
		lw	s2, 0(sp)
		addi	sp, sp, 8
		ret 
