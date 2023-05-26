 .global main

.data
	msg: .string "sum: "
.text 
	main:
	
		li	a1, 10	# n = 10
		jal	ra, sum
		
		mv t1, a0 # mi salvo su un temporary il valore di ritorno della sum
		
		li a7, 4	# stampo il messaggio di somma avvenuta
		la a0, msg
		ecall
			
		li a7, 1	# stampo il valore della somma spostandolo da t1 ad a0
		mv a0, t1
		ecall
	
		li	a7, 93
		li	a0, 0
		ecall
	sum:
		addi	sp, sp, -8 # mi riservo dello spazio sullo stack pointer
		sw	s1, 4(sp)
		sw	s2, 0(sp)
		
		li	s1, 0	# i = 0
		li	s2, 0   # sum = 0
		for:
			add	s2, s2, s1
		
			addi	s1, s1, 1
			blt	s1, a1, for
		
		mv a0, s2 # mi salvo su a0 il valore sum
		
		lw	s1, 4(sp) 
		lw	s2, 0(sp)
		addi	sp, sp, 8 # ri alloco lo spazio sullo stack
		ret
