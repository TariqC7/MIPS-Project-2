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
			addi $t0, $t0, 1
			j checkLengthLoop
			
		#This function basically ends the loop if any input matches the errors 
		endLoop:
			beqz $t0, emptyInput
			slti $t3, $t0, 5
			beqz $t3, tooLong
			move $a0, $t4
			j stringDetection
			
		#This function returns an error if input is null
		emptyInput:
			li $v0, 4
			la $a0, emptyInputError
			syscall
			j endProgram
			
		#This function returns an error if the string input is too long
		tooLongError:
			li $v0, 4
			la $a0, tooLong
			syscall
			j endProgram
		
		stringDetection:
			lb $t5, 0($a0)
			beqz $t5, initializations
			beq $t5, $t1, initializations
			slti $t6, $t5, 48
			bne $t6, $zero, baseError
			slti $t6, $t5, 58
			bne $t6, $zero, Increment
			slti $t6, $t5, 65
			bne $t6, $zero, baseError
			slti $t6, $t5, 89
			bne $t6, $zero, Increment
			slti $t6, $t5, 97
			bne $t6, $zero, baseError
			slti $t6, $t5, 121
			bne $t6, $zero, Increment
			bgt $t5, 120, baseError
			
		baseErrorMessage:
			li $v0, 4
			la $a0, baseError
			syscall
			j endProgram
