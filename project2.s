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
		syscall
		
		#Dealing with space manipulation#
		removeSpaces:
			li $t8, 32
			lb $t9, 0($a0)
			beq $t8, $t9, removeFirst
