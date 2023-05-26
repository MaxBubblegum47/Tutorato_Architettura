.global main

.data
	parola1: .string "ciao come stai?\n"
	parola2: .string "come stai?\n"
	
.text 

	main:
		la a0, parola1
		la a1, parola2

		jal ra, strcpy

		li	a7, 4
		la	a0, parola1
		ecall			# print string X
		la	a0, parola2
		ecall			# print string Y	
		
		li	a7, 93
		li	a0, 0
		ecall

	strcpy:
		mv	t0, a1
		mv	t1, a0
	
		addi	sp, sp, -4 	# adjust stack for 1 word
		sw	s3, 0(sp) 	# push x19
		li	s3, 0 	# i=0
		
		L1:
		add 	t0, s3, a1 	# x5=addr of y[i] 
		lbu 	t1, 0(t0) 	# x6=y[i] 
		add 	t2, s3, a0	# x7=addr of x[i] 
		sb 	t1, 0(t2)	# x[i]=y[i] 
		beq 	t1, zero, L2  	# if y[i]==0 then exit 
		addi 	s3, s3,1 	# i=i+1
		jal 	zero, L1	# next iteration of loop 

		L2:
		lw 	s3, 0(sp)	# restore saved x19 
		addi 	sp,sp,8		# pop 1 dw from stack 
		jalr 	zero,0(ra)	# and return
		
		
