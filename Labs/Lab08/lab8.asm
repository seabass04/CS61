;=================================================
; Name: 
; Email: 
; 
; Lab: lab 8, ex 1 & 2
; Lab section: 
; TA: 
; 
;=================================================

; test harness
.ORIG x3000
	JSR PRINT_TABLE_PTR
	
	
	;LEA R1, SUB_FIND_OPCODE_PTR
	LD R2, SUB_FIND_OPCODE_PTR
	;LDI R3, SUB_FIND_OPCODE_PTR
	JSRR R2
	;LD R1, SUB_FIND_OPCODE_PTR
	;JSRR R1
	;JSR SUB_FIND_OPCODE_PTR
	
				 
				 
				 
halt
;-----------------------------------------------------------------------------------------------
; test harness local data:
	SUB_FIND_OPCODE_PTR .FILL SUB_FIND_OPCODE
	PRINT_TABLE_PTR .FILL SUB_PRINT_OPCODES
	
	;SUB_FIND_OPCODE_PTR .FILL x3600

;===============================================================================================


; subroutines:
;-----------------------------------------------------------------------------------------------
; Subroutine: SUB_PRINT_OPCODE_TABLE
; Parameters: None
; Postcondition: The subroutine has printed out a list of every LC3 instruction
;		 		 and corresponding opcode in the following format:
;		 		 ADD = 0001
;		  		 AND = 0101
;		  		 BR = 0000
;		  		 …
; Return Value: None
;-----------------------------------------------------------------------------------------------
.ORIG x3200
SUB_PRINT_OPCODES

;--------------
;Register Backup
;---------------
	ST R0, BACKUP_R0_3200
	ST R1, BACKUP_R0_3200
	ST R2, BACKUP_R2_3200
	ST R3, BACKUP_R3_3200
	ST R4, BACKUP_R4_3200
	ST R5, BACKUP_R5_3200
	ST R6, BACKUP_R6_3200
	ST R7, BACKUP_R7_3200
	
;------------
;Instructions
;-------------
	
		LDI R2, opcodes_po_ptr
		LD R4, opcodes_po_ptr
		LD R6, instructions_po_ptr
		LD R1, PRINT_OPCODE_PTR__
		LD R3, COUNTER_17
		
		PRINT_LOOP
			LDR R2, R4, #0
			LDR R0, R6, #0
			DONT_PRINT
				ADD R0, R0, #0
				BRz CONTINUE
			OUT
			ADD R6, R6, #1
			BR PRINT_LOOP
			CONTINUE
				JSRR R1
				ADD R6, R6, #1
				ADD R4, R4, #1
				ADD R3, R3, #-1
				Brp PRINT_LOOP		 
				 
;-----------------
;Restore registers
;-----------------
	LD R0, BACKUP_R0_3200
	LD R1, BACKUP_R0_3200
	LD R2, BACKUP_R2_3200
	LD R3, BACKUP_R3_3200
	LD R4, BACKUP_R4_3200
	LD R5, BACKUP_R5_3200
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
	BACKUP_R5_3200		.BLKW #1
	BACKUP_R6_3200		.BLKW #1
	BACKUP_R7_3200		.BLKW #1
;-----------------------------------------------------------------------------------------------
; SUB_PRINT_OPCODES local data
PRINT_OPCODE_PTR__	.FILL SUB_PRINT_OPCODE
opcodes_po_ptr		.fill x4000
instructions_po_ptr	.fill x4100
COUNTER_17			.FILL #17
COUNTER_1			.FILL #1
NULL_char			.FILL #0
COUNTER_0			.FILL #0


;===============================================================================================


;-----------------------------------------------------------------------------------------------
; Subroutine: SUB_PRINT_OPCODE
; Parameters: R2 containing a 4-bit op-code in the 4 LSBs of the register
; Postcondition: The subroutine has printed out just the 4 bits as 4 ascii 1s and 0s
;				 The output is NOT newline terminated.
; Return Value: None
;-----------------------------------------------------------------------------------------------
.ORIG x3400
SUB_PRINT_OPCODE

;--------------
;Register Backup
;---------------
	ST R0, BACKUP_R0_3400
	ST R1, BACKUP_R0_3400
	ST R2, BACKUP_R2_3400
	ST R3, BACKUP_R3_3400
	ST R4, BACKUP_R4_3400
	ST R5, BACKUP_R5_3400
	ST R6, BACKUP_R6_3400
	ST R7, BACKUP_R7_3400
	
;------------
;Instructions
;-------------
	 
	 LD R3, COUNTER_12
	 
	 ADD_12						;shift bits 12 times to remove bits [16:4] 
		ADD R2, R2, R2
		ADD R3, R3, #-1
		BRp ADD_12
	
	
	LD R3, COUNTER_4
	PRINT
		ADD R2, R2, #0
		BRn PRINT_1
		
		PRINT_0
			LD R0, DEC_48
			OUT
			ADD R2, R2, R2
			ADD R3, R3, #-1
			BRz FIN
			BR PRINT
		PRINT_1
			LD R0, DEC_49
			OUT
			ADD R2, R2, R2
			ADD R3, R3, #-1
			BRz FIN
			BR PRINT
				 
	FIN
	LD R0, NEW_LINE
	OUT

;-----------------
;Restore registers
;-----------------
	LD R0, BACKUP_R0_3400
	LD R1, BACKUP_R0_3400
	LD R2, BACKUP_R2_3400
	LD R3, BACKUP_R3_3400
	LD R4, BACKUP_R4_3400
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
	BACKUP_R4_3400		.BLKW #1
	BACKUP_R5_3400		.BLKW #1
	BACKUP_R6_3400		.BLKW #1
	BACKUP_R7_3400		.BLKW #1
;-----------------------------------------------------------------------------------------------
; SUB_PRINT_OPCODE local data
	COUNTER_12 	.FILL #12
	COUNTER_4	.FILL #4
	DEC_48		.FILL #48
	DEC_49		.FILL #49
	NEW_LINE	.FILL '\n'


;===============================================================================================


;-----------------------------------------------------------------------------------------------
; Subroutine: SUB_FIND_OPCODE
; Parameters: None
; Postcondition: The subroutine has invoked the SUB_GET_STRING subroutine and stored a string
; 				as local data; it has searched the AL instruction list for that string, and reported
;				either the instruction/opcode pair, OR "Invalid instruction"
; Return Value: None
;-----------------------------------------------------------------------------------------------
.ORIG x3600
SUB_FIND_OPCODE

;--------------
;Register Backup
;---------------
	ST R0, BACKUP_R0_3600
	ST R1, BACKUP_R0_3600
	ST R2, BACKUP_R2_3600
	ST R3, BACKUP_R3_3600
	ST R4, BACKUP_R4_3600
	ST R5, BACKUP_R5_3600
	ST R6, BACKUP_R6_3600
	ST R7, BACKUP_R7_3600
;------------
;Instructions
;-------------
	LD R6, SUB_GET_STRING_PTR_2
	JSRR R6
	
	LD R2, input_ptr
	LD R3, instructions_fo_ptr
	AND R5, R5, x0
	
	LD R5, opcodes_fo_ptr
	AND R1, R1, x0
	
	MAIN_LOOP
		LDR R4, R2, #0
		LDR R5, R3, #0
		NOT R5, R5
		ADD R5, R5, #1
		ADD R1, R5, R4
		BRz EQUAL
		BRnp NO_SAME
		
		EQUAL
			LD R0, nSPACE_1
			ADD R4, R4, R0
			;ADD R4, R4, #0
			BRz AT_NULL
			
			;ADD R2, R2, #1
			;ADD R3, R3, #1
			ADD R2, R2, x0001
			ADD R3, R3, x0001
			BR MAIN_LOOP
			
		AT_NULL
			;LDR R0, R2, #0
			LD R0, input_ptr
			PUTS
			LEA R0, equal_sign
			PUTS
			AND R1, R1, x0
			ADD R1, R1, R6
			
			LD R0, nSPACE_1
			ADD R2, R2, R0
			LD R6, SUB_PRINT_OPCODE_PTR
			JSRR R6
			;LEA R0, newline
			;PUTS 
			LEA R0, Is_valid
			PUTS
			BR FIN_2
			
		NO_SAME
			NOT R5, R5
			ADD R5, R5, #1
			BRn INVALID
			BRp DIFFERENT
			BRz DIFFERENT_0
			
		DIFFERENT_0
			;ADD R6, R6, #1
			;ADD R3, R3, #1
			LDR R4, R2, #0
			;LD R2, 
			LD R2, input_ptr
			BRp MAIN_LOOP
			
		DIFFERENT
			;ADD R3, R3, x0001
			ADD R3, R3, #1
			LDR R5, R3, #0
			ADD R5, R5, #0
			BRz CORRECT
			BRp DIFFERENT
			
		CORRECT
			ADD R3, R3, #1
			;ADD R3, R3, #1
			LDR R5, R3, #0
			ADD R5, R5, #0
			BRn INVALID
			LD R2, input_ptr
			;ADD R6, R6, #1
			ADD R6, R6, x0001
			BR MAIN_LOOP
			
		INVALID
			LEA R0, is_nvalid
			PUTS
	FIN_2
	

.END
;-----------------
;Restore registers
;-----------------
	LD R0, BACKUP_R0_3600
	LD R1, BACKUP_R0_3600
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
;-----------------------------------------------------------------------------------------------
; SUB_FIND_OPCODE local data
equal_sign				.STRINGZ " = " 
newline					.STRINGZ "\n"
is_nvalid				.STRINGZ "Please enter corect command"
Is_valid				.STRINGZ "Comand is valid\n"

opcodes_fo_ptr			.fill x4000
instructions_fo_ptr		.fill x4100
input_ptr				.fill x4400
SUB_GET_STRING_PTR_2	.fill x3800
SUB_PRINT_OPCODE_PTR	.fill x3400
;nSPACE				.FILL #-32
nSPACE_1			.FILL #-32


;===============================================================================================


;-----------------------------------------------------------------------------------------------
; Subroutine: SUB_GET_STRING
; Parameters: R2 - the address to which the null-terminated string will be stored.
; Postcondition: The subroutine has prompted the user to enter a short string, terminated 
; 				by [ENTER]. That string has been stored as a null-terminated character array 
; 				at the address in R2
; Return Value: None (the address in R2 does not need to be preserved)
;-----------------------------------------------------------------------------------------------
.ORIG x3800
SUB_GET_STRING

;--------------
;Register Backup
;---------------
	ST R0, BACKUP_R0_3800
	ST R1, BACKUP_R0_3800
	;ST R2, BACKUP_R2_3800
	ST R3, BACKUP_R3_3800
	ST R4, BACKUP_R4_3800
	ST R5, BACKUP_R5_3800
	ST R6, BACKUP_R6_3800
	ST R7, BACKUP_R7_3800
;------------
;Instructions
;------------- 
	 LD R1, nNewLine
	 LD R2, SUB_GET_STRING_Array	
	 LEA R0, introprompt
		PUTS	 
	
	GET_INPUT
		GETC
		OUT
		ADD R4, R0, R1
		BRz IS_ENTER
		STR R0, R2, #0
		ADD R2, R2, x0001
		ADD R3, R3, R2
		BR GET_INPUT
		
		IS_ENTER
			AND R0, R0, x0
			ADD R2, R2, x0001
			STR R0, R2, #0
			
			ADD R2, R3, #0
			LD R4, nSPACE
			;ADD R2, 
.END
;-----------------
;Restore registers
;-----------------
	LD R0, BACKUP_R0_3800
	LD R1, BACKUP_R0_3800
	;LD R2, BACKUP_R2_3800
	LD R3, BACKUP_R3_3800
	LD R4, BACKUP_R4_3800
	LD R5, BACKUP_R5_3800
	LD R6, BACKUP_R6_3800
	LD R7, BACKUP_R7_3800
RET
;--------------
;subroutine data
;---------------
	BACKUP_R0_3800		.BLKW #1
	BACKUP_R1_3800		.BLKW #1
	;BACKUP_R2_3800		.BLKW #1
	BACKUP_R3_3800		.BLKW #1
	BACKUP_R4_3800		.BLKW #1
	BACKUP_R5_3800		.BLKW #1
	BACKUP_R6_3800		.BLKW #1
	BACKUP_R7_3800		.BLKW #1
;-----------------------------------------------------------------------------------------------
; SUB_GET_STRING local data
	introprompt 	.STRINGZ "\nENTER command followed by enter\n"
	nNewLine		.FILL #-10
	SUB_GET_STRING_Array .FILL x4400
	nSPACE			.FILL #-32




;===============================================================================================


;-----------------------------------------------------------------------------------------------
; REMOTE DATA
.ORIG x4000			; list opcodes as numbers, e.g. .fill #12 or .fill xC
	opcodes
		.FILL #1 
		.FILL #5
		.FILL #0
		.FILL #12
		.FILL #4
		.FILL #4
		.FILL #2
		.FILL #10
		.FILL #6
		.FILL #14
		.FILL #10
		.FILL #12
		.FILL #8
		.FILL #3
		.FILL #11
		.FILL #7
		.FILL #15

.ORIG x4100			; list AL instructions as null-terminated character strings, e.g. .stringz "JMP"
	instructions				 			; - be sure to follow same order in opcode & instruction arrays!
		.STRINGZ "ADD = "
		.STRINGZ "AND = "
		.STRINGZ "BR = "
		.STRINGZ "JMP = "
		.STRINGZ "JSR = "
		.STRINGZ "JSRR = "
		.STRINGZ "LD = "
		.STRINGZ "LDI = "
		.STRINGZ "LDR = "
		.STRINGZ "LEA = "
		.STRINGZ "NOT = "
		.STRINGZ "RET = "
		.STRINGZ "RTI = "
		.STRINGZ "ST = "
		.STRINGZ "STI = "
		.STRINGZ "STR = "
		.STRINGZ "TRAP = "
		.FILL #-1
	
.ORIG x4200
	.FILL #2

;===============================================================================================
