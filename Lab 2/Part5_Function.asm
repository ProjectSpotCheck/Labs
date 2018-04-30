.data	# Data declaration section

A:	.word	
B:	.word
C:	.word 
	



	.text

main:
	li t0, 5   #i
	li t1, 10  # J

	la 		x1, A # load address of A into x1
	la 		x2, B #load address of B into x2
	la 		x3, C # load address of C into x2
	li		x4, 0 # x
	li		x12, 1
	#addi		sp, sp, -8
		
	addi		a0, t0, 0
	li		t0, 0
	jal Additup
	add		x29, x4, x0
	addi		a0, t1, 0
	li		t1, 0
	jal Additup
	add		x18, x4, x29
	j Exit
Additup:
	For: 
	
	beq		x11, x12 Next
	add 		x4, x4, t0
	addi 		x4, x4, 1
	addi		t0, t0, 1


	j For
	Next: ret
	Exit:
	
