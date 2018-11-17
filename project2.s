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
			move $t9, $a0
			j lengthCheck
		
		removeFirst:
			addi $a0, $a0, 1
			j removeSpaces
			
		#Count characters in the string input
		lengthCheck:
			addi $t0, $t0, 0
			addi $t1, $t1, 10
			add $t4, $t4, $a0
		
		#Check the string for null character/loading next character into the t2 register
		checkLengthLoop:
			lb $t2, 0($a0)
			beqz $t2, endLoop
			beq $t2, $t1, endLoop
			addi $a0, $a0, 1
