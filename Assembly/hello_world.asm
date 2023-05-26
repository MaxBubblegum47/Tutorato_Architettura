 
.global main

.data
	msg: .string "Hello World!"

.text
	main:
		li a7, 4
		la a0, msg
		ecall
		
		li a0, 0
		li a7, 93
		ecall
