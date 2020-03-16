;=================================================
; Name: 
; Email: 
; 
; Lab: lab 5, ex 2
; Lab section: 
; TA: 
; 
;=================================================

.ORIG x3000

;-------------
;INSTRUCTIONS
;-------------

	JSR USER_IN
	
	LD R0, NEW__LINE
	OUT
	
	LDR R1, R2, #0
	JSR CONVERT_TO_16_BIT_3200
	OUT


HALT


;----------
;LOCAL DATA
;-----------
	NEW__LINE	.FILL #10	;Stores a new line 
.end

;-------------------------------------
;subroutine: USER_IN
;Input (R5): none
;Post condition: takes in 16 bit user input with b(which is ignores) and 
;convert to decimal, storing into R2
;Returns value: none
;------------------------------------------


.ORIG x3400			; Program begins here

USER_IN
;---------------
;Rigister Backup
;---------------
ST R7, BACKUP_R7_3400


;------------
;Instructions
;-------------
	LD R2, DEC_0
	LD R3, COUNTER_DEC_16
	LD R4, ARRAY
	LD R5, DEC_1
	LD R6, DEC_n48
	
	GETC
	OUT
	INPUT_WHILE_LOOP		;gets user input and stores into array
		GETC
		OUT
		
		STR R0, R4, #0
		ADD R4, R4, #1
		
		ADD R3, R3, #-1
		BRp INPUT_WHILE_LOOP
		
		
	ADD R4, R4, #-1			;go back one space in the array tp be in last element
	LD R3, COUNTER_DEC_16	;reset counter
	CONVERT_TO_DEC
		
		LDR R1, R4, #0		;load number of array into R1
		ADD R1, R1, R6		;checks if 0 or 1 by subtracing
		BRz NEXT_NUM		;number is 0 so ignore
	
		ADD R2, R2, R5		;add power of 2 to R2
		
		NEXT_NUM
		ADD R5, R5, R5		;compute next power of 2
		ADD R4, R4, #-1		;go back one spot in the array
		ADD R3, R3, #-1		;decrament counter
		BRp CONVERT_TO_DEC
	
		

;-----------------
;Restore registers
;-----------------
LD R7, BACKUP_R7_3400

RET


;---------------	
;Data
;---------------
	DEC_0	.FILL #0
	DEC_1	.FILL #1
	COUNTER_DEC_16 .FILL #16
	ARRAY 	.FILL x4000
	DEC_n48	.FILL #-48
	
	BACKUP_R7_3400	.BLKW #1





;-------------------------------------
;subroutine: CONVERT_TO_16_BIT_3200
;Input (R5): value to be converted 
;Post condition: takes in a dec value and outputs the 16bit binary version
;with spaces every 4 bits
;Retunb value: retruns 16bit binary for input
;------------------------------------------


.ORIG x3200			; Program begins here

CONVERT_TO_16_BIT_3200
;---------------
;Rigister Backup
;---------------
	;ST R0, BACKUP_R0_3200
	;ST R1, BACKUP_R1_3200
	ST R2, BACKUP_R2_3200
	;ST R4, BACKUP_R4_3200
	;ST R6, BACKUP_R6_3200
	ST R7, BACKUP_R7_3200
	
;------------
;Instructions
;-------------
	;LD R6, Value_addr		; R6 <-- pointer to value to be displayed as binary
	;LDR R1, R6, #0			; R1 <-- value to be displayed as binary 
;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------
	LD R1, MAIN_COUNT
	LD R4, SPACE_COUNT	
	WHILE_13p
		ADD R2, R2, #0	;;		;checks if negatives and goes to print 
		BRn OUT_ONE				;checks if negatives and goes to print 

		OUT_ZERO
			LD R0, ZERO			;load and output 0
			OUT
			ADD R1, R1, #-1		;subtract 1 from main count
			BRz END_WHILE_13p	;if 0, done with all bits so exit
			ADD R2, R2, R2	;;	;shift bits to left
			ADD R4, R4, #-1     ;subtract 1 from space counter 
			BRz PRINT_SPACE		;if 0, need a space
			ADD R4, R4, #0	    ;since it dosnt need a space, 
			Brp WHILE_13p		;returns to top
					OUT_ONE
			LD R0, ONE			;load and output 1
			OUT
			ADD R1, R1, #-1		;subtract 1 from main count
			BRz END_WHILE_13p	;if 0, done with all bits so exit
			ADD R2, R2, R2;;;		;shift bits to left
			ADD R4, R4, #-1     ;subtract 1 from space counter 
			BRp WHILE_13p	    ;if 0, need a space
			
		PRINT_SPACE
			LD R0, SPACE		;Load and output space
			OUT
			ADD R4, R4, #4		;reset space couter to 4
			ADD R1, R1, #0		;goes back to top
			BRp WHILE_13p
			
	END_WHILE_13p

	LD R0, NEW_LINE				;Load and print new line
	OUT

;HALT


;-----------------
;Restore registers
;-----------------
;LD R0, BACKUP_R0_3200
;LD R1, BACKUP_R1_3200
LD R2, BACKUP_R2_3200
;LD R4, BACKUP_R4_3200
;LD R6, BACKUP_R6_3200
LD R7, BACKUP_R7_3200

RET


;--------------
;subroutine data
;---------------
	;BACKUP_R0_3200		.BLKW #1
	;BACKUP_R1_3200		.BLKW #1
	BACKUP_R2_3200		.BLKW #1
	;BACKUP_R4_3200		.BLKW #1
	;BACKUP_R6_3200		.BLKW #1
	BACKUP_R7_3200		.BLKW #1

;---------------	
;Data
;---------------
	;Value_addr	.FILL xB800	; The address where value to be displayed is stored

	MAIN_COUNT	.FILL #16	;Stores 16 to count down 16 bits
	ZERO	.FILL #48		;Stores 0
	ONE		.FILL #49		;Stores 1
	SPACE	.FILL #32		;Stores a space
	NEW_LINE	.FILL #10	;Stores a new line 
	SPACE_COUNT	.FILL #4	;Stores 4 to count down spaces

.ORIG xB800					; Remote data
	;Value .FILL x73A2			; <----!!!NUMBER TO BE DISPLAYED AS BINARY!!! Note: label is redundant.

;---------------	
;END of PROGRAM
;---------------	
.END
