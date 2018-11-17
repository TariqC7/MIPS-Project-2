.data 
	tooLong: .asciiz "Input too long"
	emptyInputError: .asciiz "Empty input"
	baseError: .asciiz "Invalid base-34 number"
	userInput: .space 30000
.text
	main:
	
		#	--INPUT--     #
		#Get user input 
		li $v0, 8
		la $a0, userInput
		li $a1, 30000
