		.data
message: 	.asciz 	"Enter the Farenheit value you want to convert to Celsius and Kelvin: "
message1: 	.asciz 	"\nCelsius = "
message2: 	.asciz 	"\nKelvin = "
celsiusVal: 	.float 	0.0
kelvinVal: 	.float 	0.0
zeroFloat: 	.float 	0.0
constant32: 	.float 	32.0
constant5: 	.float 	5.0
constant9: 	.float 	9.0
constant273: 	.float 	273.15

		.text
main:
		
	# load float values
	flw 	ft0, zeroFloat, t0
	flw	ft1, constant32, t0
	flw	ft2, constant5, t0
	flw	ft3, constant9, t0
	flw	ft4, constant273, t0
		
	# Display message
	li	a7, 4 		# system call for printing string
	la	a0, message
	ecall
	
	# Read input
	li	a7, 6		# system call for reading float
	ecall

	# Store user's value in ft11
	fadd.s	ft11, ft0, fa0	
		
	# Celsius Conversion function jump
	jal	convertCelsius
			
	# Store Celsius value in memory
	fsw	fa0, celsiusVal, t0
	
	# Display message1
	li	a7, 4		# system call for printing string
	la	a0, message1
	ecall
	
	# Display Celsius
	li 	a7, 2		# system call for printing float in ascii
	ecall
	
	# Store celsius value in ft11 to assign to Kelvin conversion
	fadd.s 	ft11, ft0, fa0
		
	# Kelvin function jump
	jal 	convertKelvin
		
	# Store Kelvin value in memory
	fsw 	fa0, kelvinVal, t0
	
	# Display message2
	li 	a7, 4		# system call for printing string
	la 	a0, message2
	ecall
	
	# Display Kelvin
	li 	a7, 2		# system call for printing float in ascii
	ecall
		
	# Exit program
	j 	Exit
	
convertCelsius:

	# Celsius	
	fsub.s 	ft11, ft11, ft1	# F - 32.0
	fmul.s 	ft11, ft11, ft2	# (F - 32.0) * 5
	fdiv.s 	ft11, ft11, ft3	#  (F - 32.0) * 5 / 9
		
	# Store result in fa0 (return)
	fadd.s 	fa0, ft11, ft0

	# Return to main
	ret			

convertKelvin:
	# Kelvin
	fadd.s 	ft11, ft11, ft4
		
	# Store result in fa0 (return)
	fadd.s 	fa0, ft11, ft0

	# Return to main
	ret
Exit:
