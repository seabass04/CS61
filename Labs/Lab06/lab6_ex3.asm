;=================================================
; Name: 
; Email: 
; 
; Lab: lab 6, ex 2
; Lab section: 
; TA: 
; 
;=================================================

.ORIG x3000

;-------------
;INSTRUCTIONS
;-------------
	LD R1, ARRAY_PTR
	JSR SUB_GET_STRING
	
	JSR SUB_IS_A_PALINDROME

	LEA R0, THES
	PUTS
	LD R0, ARRAY_PTR
	PUTS
	;LEA R0, PAL
	;PUTS
	ADD R4, R4, #0
	BRz LOAD_NOT
	
	LOAD_IS
		LEA R0, PAL
		PUTS
		BR FIN
	LOAD_NOT
		LEA R0, NPAL
		PUTS
	
	
	FIN
HALT
;----------
;LOCAL DATA
;-----------
	ARRAY_PTR .FILL ARRAY2
	THES	.STRINGZ "The String " 
	PAL		.STRINGZ " IS a palindrome\n"
	NPAL	.STRINGZ " IS NOT a palindrome\n"
	

.ORIG x4000
	ARRAY2 .BLKW #100


.end



;------------------------------------------------------------------------------
; Subroutine: SUB_GET_STRING
; Parameter (R1): The starting address of the character array
; Postcondition: The subroutine has prompted the user to input a string,
;
;terminated by the [ENTER] key (the "sentinel"), and has stored
;
;the received characters in an array of characters starting at (R1).
;
;the array is NULL-terminated; the sentinel character is NOT stored.
;Return Value (R5): The number of ​ non-sentinel​ characters read from the user.
;
;R1 contains the starting address of the array unchanged.
;--------------------------------------------------------------------------------

.ORIG x3200			; Program begins here
SUB_GET_STRING

;--------------
;Register Backup
;---------------
	ST R0, BACKUP_R0_3200
	ST R1, BACKUP_R1_3200
	ST R2, BACKUP_R2_3200
	ST R3, BACKUP_R3_3200
	ST R4, BACKUP_R4_3200
	ST R6, BACKUP_R6_3200
	ST R7, BACKUP_R7_3200


;------------
;Instructions
;-------------
	LD R4, NewLine
	LD R2, NULL
	LD R5, COUNT
	
	DO_WHILE_LOOP
		GETC
		OUT
		
		STR R0, R1, #0
		ADD R1, R1, #1	
		
		ADD R5, R5, #1
		
		ADD R0, R0, #-10
		BRp DO_WHILE_LOOP
	
	ADD R5, R5, #-1
	ADD R1, R1, #-1
	STR R2, R1, #0
	
	

;-----------------
;Restore registers
;-----------------
	LD R0, BACKUP_R0_3200
	LD R1, BACKUP_R1_3200
	LD R2, BACKUP_R2_3200
	LD R3, BACKUP_R3_3200
	LD R4, BACKUP_R4_3200
	LD R6, BACKUP_R6_3200
	LD R7, BACKUP_R7_3200
RET	

;--------------
;subroutine data
;---------------
	BACKUP_R0_3200		.BLKW #1
	BACKUP_R1_3200		.BLKW #1
	BACKUP_R2_3200		.BLKW #1
	BACKUP_R3_3200		.BLKW #1
	BACKUP_R4_3200		.BLKW #1
	BACKUP_R6_3200		.BLKW #1
	BACKUP_R7_3200		.BLKW #1
;---------------	
;Data
;---------------
	NewLine .FILL x0A
	NULL 	.FILL x0
	COUNT	.FILL #0

;----------------------------------------------------------------------------
; Subroutine: SUB_IS_A_PALINDROME
; Parameter (R1): The starting address of a null-terminated string
; Parameter (R5): The number of characters in the array.
; Postcondition: The subroutine has determined whether the string at (R1) is
;				 a palindrome or not, and returned a flag to that effect.
; Return Value: R4 {1 if the string is a palindrome, 0 otherwise}
;--------------------------------------------------------------------------------


.ORIG x3400			; Program begins here
SUB_IS_A_PALINDROME
;--------------
;Register Backup
;---------------
	ST R0, BACKUP_R0_3400
	ST R1, BACKUP_R1_3400
	ST R2, BACKUP_R2_3400
	ST R3, BACKUP_R3_3400
	;ST R4, BACKUP_R4_3400
	ST R5, BACKUP_R5_3400
	ST R6, BACKUP_R6_3400
	ST R7, BACKUP_R7_3400
;------------
;Instructions
;------------
	JSR SUB_TO_UPPER
	LD R2, ARRAY_PTR3
	
	
	ADD R4, R5, #0			;backup count
	ADD R1, R1, R5 			;holds place to end of firest vector
	ADD R1, R1, #-1
	COPY_BACKWARDS			;copys vector backwards
		LDR R3, R1, #0
		STR R3, R2, #0
		
		ADD R2, R2, #1		;decrmaen second loop
		ADD R1, R1, #-1		;incrament first loop
		ADD R5, R5, #-1
	BRp COPY_BACKWARDS
	
	ADD R5, R4, #0			;reset count
	LD R1, BACKUP_R1_3400
	ADD R1, R1, R5 			;holds place to end of firest vector
	ADD R1, R1, #-1
	
	ADD R2, R2, #-1
	PAL_CHECK				;checks if its plaindroms
		LDR R6, R1, #0		;laod 1st array
		LDR R3, R2, #0		;load 2nd array 
		STR R3, R2, #0		;store contect of 2nd 
		NOT R3, R3			;take negative of R3
		ADD R3, R3, #1
			
		ADD R4, R6, R3		;check if sum is zero
		BRnp NOT_PAL
		
		ADD R2, R2, #-1		;decrament R2
		ADD R1, R1, #-1		;decrament R1
		ADD R5, R5, #-1		;decrament counter 
		BRz IS_PAL			;check for plaindrome		
		BRnp PAL_CHECK 
		
		IS_PAL				
			LD R4, DEC_1
			BR SKIP_END
		NOT_PAL
			LD R4, DEC_0
		
	SKIP_END
;-----------------
;Restore registers
;-----------------
	LD R0, BACKUP_R0_3400
	LD R1, BACKUP_R1_3400
	LD R2, BACKUP_R2_3400
	LD R3, BACKUP_R3_3400
	;LD R4, BACKUP_R4_3400
	LD R5, BACKUP_R5_3400
	LD R6, BACKUP_R6_3400
	LD R7, BACKUP_R7_3400
RET	

;--------------
;subroutine data
;---------------
	BACKUP_R0_3400		.BLKW #1
	BACKUP_R1_3400		.BLKW #1
	BACKUP_R2_3400		.BLKW #1
	BACKUP_R3_3400		.BLKW #1
	;BACKUP_R4_3400		.BLKW #1
	BACKUP_R5_3400		.BLKW #1
	BACKUP_R6_3400		.BLKW #1
	BACKUP_R7_3400		.BLKW #1
;---------------	
;Data
;---------------
	DEC_0	.FILL 	#0
	DEC_1	.FILL	#1
	ARRAY_PTR3 .FILL ARRAY3

.ORIG x4101
	ARRAY3 .BLKW #100

;------------------------------------------------------------------------------------------------------------------
; Subroutine: SUB_TO_UPPER
; Parameter (R1): Starting address of a null-terminated string
; Postcondition: The subroutine has converted the string to upper-case ​ in-place
;
;i.e. the upper-case string has replaced the original string
; No return value, no output (but R1 still contains the array address, unchanged).
;------------------------------------------------------------------------------------------------------------------
.ORIG x3600			; Program begins here
SUB_TO_UPPER

;--------------
;Register Backup
;---------------
	ST R0, BACKUP_R0_3600
	ST R1, BACKUP_R1_3600
	ST R2, BACKUP_R2_3600
	ST R3, BACKUP_R3_3600
	ST R4, BACKUP_R4_3600
	ST R5, BACKUP_R5_3600
	ST R6, BACKUP_R6_3600
	ST R7, BACKUP_R7_3600

;------------
;Instructions
;------------
	LD R2, LOWER_BOUND
	LD R5, SUB_32
	
	CONVERT_TO_UPPER
		LDR R3, R1, #0		;load array value
		Brz FIN2			;check for null
		ADD R4, R3, R2		;check if lower or upper
		BRn IS_UPPER
		
		IS_LOWER
			ADD R3, R3, R5	;if lower, decrament to convert
			STR R3, R1, #0	;store uppercased char
		
		IS_UPPER
		ADD R1, R1, #1		;increase array
		BR CONVERT_TO_UPPER
		
	FIN2
;-----------------
;Restore registers
;-----------------
	LD R0, BACKUP_R0_3600
	LD R1, BACKUP_R1_3600
	LD R2, BACKUP_R2_3600
	LD R3, BACKUP_R3_3600
	LD R4, BACKUP_R4_3600
	LD R5, BACKUP_R5_3600
	LD R6, BACKUP_R6_3600
	LD R7, BACKUP_R7_3600
RET	

;--------------
;subroutine data
;---------------
	BACKUP_R0_3600		.BLKW #1
	BACKUP_R1_3600		.BLKW #1
	BACKUP_R2_3600		.BLKW #1
	BACKUP_R3_3600		.BLKW #1
	BACKUP_R4_3600		.BLKW #1
	BACKUP_R5_3600		.BLKW #1
	BACKUP_R6_3600		.BLKW #1
	BACKUP_R7_3600		.BLKW #1
;---------------	
;Data
;---------------
	LOWER_BOUND		.FILL #-97
	SUB_32			.FILL #-32
	;NULL			.FILL #0
	

.END


