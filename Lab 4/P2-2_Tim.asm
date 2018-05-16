	.data
newln:	.asciz 	"\r\n"
a: 	.word 	0
b: 	.word 	0
c: 	.word 	0

	.text
main: 
	# Load 3 into a0
	addi 	a0, zero, 3
	
	# Calculate 3rd Fibonacci recursively
	jal 	fibo

	# Save result to address of a
	la	t1, a
	sw	a7, 0(t1)
	
	# Load 10 into a0
	addi 	a0, zero, 10
	
	# Calculate 10th Fibonacci recursively
	jal 	fibo

	# Save result to address of b
	la	t1, b
	sw	a7, 0(t1)
	
	# Load 20 into a0
	addi 	a0, zero, 20
	
	# Calculate 20th Fibonacci recursively
	jal 	fibo

	# Save result to address of c
	la	t1, c
	sw	a7, 0(t1)
	
	# Exit the program
	j	Exit

fibo: 
	# Allocate a stack to store three elements
	addi 	sp, sp, -12
	sw	s0, 0(sp)
	sw	s1, 4(sp)
	sw	ra, 8(sp)	# store address of current ra to stack

	slti 	t0, a0, 2	# if a0 < 2, set t0 = 1, otherwise set t0 = 0
	beq 	t0, zero, else	# if t0 = 0 then jump to else

	add 	a7, zero, a0	# if t0 = 1 then assign a0 to a7 for return
	j	exit_fibo

    else: 
        addi 	s0, a0, 0
        addi 	a0, a0, -1
        jal 	fibo

        addi 	s1, a7, 0
        addi 	a0, s0, -2
        jal 	fibo

        add 	a7, s1, a7

    exit_fibo: 
	lw	s0, 0(sp)
	lw	s1, 4(sp)
	lw	ra, 8(sp)
	addi 	sp, sp, 12

	ret
	
Exit:
 