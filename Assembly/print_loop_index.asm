 
.global main

.text
	main:
		li s1, 0 # inizializzazione indice
		li s2, 10 # inizializzazione limitatore

		li a7, 1
		for:
			mv a0, s1 # stampa dell'indice corrente
			ecall
			
			addi s1, s1, 1 # incremento indice
			blt s1, s2, for # s1 < s2 (i < 10)

		li a7, 93 # return 0
		li a0, 0
		ecall 
