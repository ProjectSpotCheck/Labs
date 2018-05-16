.data

.text

main:
	# This program is outlined after my testbench

	#----------Test adder-------------------#
	li	t0, 0x4F302C85		# DataIn1
 	li 	t1, 0x7A222578		# DataIn2
 	
 	# I use add here instead of addi because addi in RISC-V does not allow immediate of more than 12 bits
 	add 	t2, t0, t1		# Expected add = 0xC95251FD
 	sub 	t3, t0, t1		# Expected sub = 0xD50E070D
 
	li 	t0, 0xC0765A22 		# DataIn1
 	li 	t1, 0xB4059ADD		# DataIn2
 	
 	add 	t4, t0, t1		# Expected add = 0x747BF4FF
 	sub 	t5, t0, t1		# Expected sub = 0x0C70BF45
 	
 	#----------Test shift-------------------#
 	li	t6, 0x789ABCDE
 	srli	t0, t6, 1		# Shift by 1 bit(R) Expected: 0x3C4D5E6F
 	li	t6, 0x789ABCDE
 	slli  	t1, t6, 2		# Shift by 2 bit(L) Expected: 0xE26AF378
	
	#----------Test AND-------------------#
	li 	s0, 0x00000000 		# DataIn1
 	li 	s1, 0xFFFFFFFF		# DataIn2
 	and	s0, s0, s1		# Expected: 0x00000000
 	
 	li 	s1, 0xAAAAAAAA 		# DataIn1
 	li 	s2, 0xAAAAAAAA		# DataIn2
 	and	s1, s1, s2		# Expected: 0xAAAAAAAA
 	
	#----------Test OR-------------------#
	li 	s2, 0xFFFFFFFF		# DataIn1
 	li 	s3, 0x00000000		# DataIn2
 	or	s2, s2, s3		# Expected: 0xFFFFFFFF
 	
 	li 	s3, 0xAAAAAAAA 		# DataIn1
 	li 	s4, 0x55555555 		# DataIn2
 	
 	# I use or here instead of ori since ori in RISC-V does not allow immediate of more than 12 bits
 	or	s3, s3, s4		# Expected: 0xFFFFFFFF	
