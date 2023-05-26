.globl main
.data
	msg1: .byte 0x6B	# equivale a [01101011]_2
	msg2: .byte 0x7F	# equivale a [01111111]_2
	str1: .string "The original message is "
	str2: .string "The encoded message is "
	str3: .string "\n"
	
.text
main:
	# Stampa str1
	li	a7, 4
	la	a0, str1
	ecall
	# stampa msg1 (in formato binario)
	la	t0, msg1	
	lb	a0, 0(t0)	# messaggio
	mv	t0, a0		# salviamo il messaggio per dopo
	li	a7, 35
	ecall
	# Stampa str3 (newline)
	li	a7, 4
	la	a0, str3
	ecall
	
	# calcola codifica per parità pari
	mv	a0, t0		# ripristiniamo il messaggio come parametro per la check_parity
	jal	ra, check_parity
	mv	t0, a0
	
	# Stampa str2
	li	a7, 4
	la	a0, str2
	ecall
	# stampa msg1 codificato (in formato binario)
	mv	a0, t0
	li	a7, 35
	ecall
	# Stampa str3 (newline)
	li	a7, 4
	la	a0, str3
	ecall
	
	# return 0
	li	a7, 93
	li	a0, 0
	ecall

# char check_parity (char msg);
check_parity:
	li	t0, 0	# contatore delle occorrenze di 1
	li	t1, 7	# numero di bit nel messaggio
	li	t2, 0	# indice del loop
	li	t3, 0x01	# maschera 0x1

# contiamo il numero di '1' nel messaggio
loop:
	beq	t2, t1, exit	# if (i == 7) break;
	sll	t4, t3, t2	# crea la maschera per il confronto
	and	t4, t4, a0	# seleziona il corrispondente bit di a0
	beq	t4, zero, next
	addi	t0, t0, 1	# incrementa il contatore di occorrenze di '1'
next:
	addi	t2, t2, 1	# i = i + 1;
	j loop
exit:

# verifichiamo se il numero di '1' è pari o dispari
	li	t4, 0x01
	and	t4, t4, t0		# se il LSB in t0 è 0 il numero di '1' nel messaggio è pari
	beq	t4, zero, handle_even	# se il numero di '1' è pari non devo far niente
	li	t2, 0x80		# creo la maschera col bit più significativo a '1'
	or	a0, t2, a0		# e setto il MSB del messaggio in a0 a '1'
	j	end
handle_even:
	mv	a0, t4
end:
	jr	ra 
