.global main

.data

	Func0: .string "F0 (main)\n"
	Func1: .string "Funzione 1\n"
	Func2: .string "Funzione 2\n"
	End: .string "Terminato con successo\n"
	
.text
	main:
		li a7, 4
		la a0, Func0
		ecall
		
		jal ra, F1
		
		li a7, 4
		la a0, End
		ecall

		li a0, 0
		li a7, 93
		ecall
	
	F1:
		addi sp, sp, -4
		sw   ra, 0(sp)
		li a7, 4
		la a0, Func1
		ecall
		jal ra, F2
	
	F2:
		li a7, 4
		la a0, Func2
		ecall
		lw ra, 0(sp)
		addi sp, sp, 4
		jr ra
