.global main

.data
	msg: .string "Hello World!"
.text
	main:	
		jal	ra, function
		
		li	a7, 93
		li	a0, 0
		ecall

	function:
		la t0, msg
		
		li a7, 4
		mv a0, t0
		ecall
		
		ret 
