;=================================================
; Name: Sebastian Garcia
; Email: sgarc133@ucr.edu
; 
; Lab: lab 9, ex 3
; Lab section: 
; TA: 
; 
;=================================================

; test harness
.orig x3000
	LD R5, MAX
	LD R4, BASE
	LD R6, TOS
	LD R2, nDEC_101
	
	
	LEA R0, INTRO_MULT
	PUTS
		
	GETC 	;FIRST INPUT
	OUT
	LD R1, SUB_STACK_PUSH_PTR
	JSRR R1
	
	GETC	;SECOND INPUT
	OUT
	LD R1, SUB_STACK_PUSH_PTR
	JSRR R1
		
	GETC	;THIRD INPUT
	OUT
	
	LD R1, SUB_RPN_MULTIPLY_PTR
	JSRR R1

				 
halt
;-----------------------------------------------------------------------------------------------
; test harness local data:
BASE		.FILL xA000
MAX			.FILL xA005
TOS			.FILL xA000
nDEC_101 	.FILL #-101
SUB_STACK_PUSH_PTR .FILL SUB_STACK_PUSH
SUB_STACK_POP_FILL .FILL SUB_STACK_POP
SUB_RPN_MULTIPLY_PTR .FILL SUB_RPN_MULTIPLY	 

INTRO_MULT .STRINGZ "ENTER two single digits to multiply followed by '*'\n"



;===============================================================================================
;------------------------------------------------------------------------------------------
; Subroutine: SUB_STACK_PUSH
; Parameter (R0): The value to push onto the stack
; Parameter (R4): BASE: A pointer to the base (one less than the lowest available
;                       address) of the stack
; Parameter (R5): MAX: The "highest" available address in the stack
; Parameter (R6): TOS (Top of Stack): A pointer to the current top of the stack
; Postcondition: The subroutine has pushed (R0) onto the stack (i.e to address TOS+1). 
;		    If the stack was already full (TOS = MAX), the subroutine has printed an
;		    overflow error message and terminated.
; Return Value: R6 ← updated TOS
;------------------------------------------------------------------------------------------
.orig x3200
SUB_STACK_PUSH
;--------------
;Register Backup
;---------------
	ST R0, BACKUP_R0_3200
	ST R1, BACKUP_R0_3200
	ST R2, BACKUP_R2_3200
	ST R3, BACKUP_R3_3200
	ST R4, BACKUP_R4_3200
	ST R5, BACKUP_R5_3200
	ST R7, BACKUP_R7_3200	 
;------------
;Instructions
;-------------
	ADD R1, R5, #0
	
	NOT R1, R1
	ADD R1, R1, #1
	
	ADD R1, R1, R6
	BRz OVERFLOW
	
	;LEA R0, INTRO_36
	;PUTS
	;GETC
	;OUT
	
	PUSH_BACK
		ADD R6, R6, #1
		STR R0, R6, #0
		BR FIN_36
	
	OVERFLOW
		;LEA R0, ERROR_MSG
		PUTS
		
	FIN_36

;-----------------
;Restore registers
;-----------------
	LD R0, BACKUP_R0_3200
	LD R1, BACKUP_R0_3200
	LD R2, BACKUP_R2_3200
	LD R3, BACKUP_R3_3200
	LD R4, BACKUP_R4_3200
	LD R5, BACKUP_R5_3200
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
	BACKUP_R7_3200		.BLKW #1
;-----------------------------------------------------------------------------------------------
; SUB_STACK_PUSH local data
ERROR_MSG	.STRINGZ "\nERROR: Overflow"
INTRO_36	.STRINGZ "\nEnter number to push\n"
;===============================================================================================



;------------------------------------------------------------------------------------------
; Subroutine: SUB_STACK_POP
; Parameter (R4): BASE: A pointer to the base (one less than the lowest available                      ;                       address) of the stack
; Parameter (R5): MAX: The "highest" available address in the stack
; Parameter (R6): TOS (Top of Stack): A pointer to the current top of the stack
; Postcondition: The subroutine has popped MEM[TOS] off of the stack.
;		    If the stack was already empty (TOS = BASE), the subroutine has printed
;                an underflow error message and terminated.
; Return Value: R0 ← value popped off the stack
;		   R6 ← updated TOS
;------------------------------------------------------------------------------------------
.orig x3400
SUB_STACK_POP			 
;--------------
;Register Backup
;---------------
	;ST R0, BACKUP_R0_3400
	ST R1, BACKUP_R1_3400
	ST R2, BACKUP_R2_3400
	ST R3, BACKUP_R3_3400
	ST R4, BACKUP_R4_3400
	ST R5, BACKUP_R5_3400
	ST R7, BACKUP_R7_3400	 
;------------
;Instructions
;-------------
	ADD R1, R4, #0
	
	NOT R1, R1
	ADD R1, R1, #1
	
	ADD R1, R1, R6
	BRz UNDERFLOW
	
	
	POP_BACK
		ADD R6, R6, #-1
		;LEA R0, ERR0R_MSG4
		;PUTS
		BR FIN_34
	
	UNDERFLOW
		;LEA R0, ERROR_MSG3
		;PUTS
		
	FIN_34
	
	

;-----------------
;Restore registers
;-----------------
	;LD R0, BACKUP_R0_3400
	LD R1, BACKUP_R1_3400
	LD R2, BACKUP_R2_3400
	LD R3, BACKUP_R3_3400
	LD R4, BACKUP_R4_3400
	LD R5, BACKUP_R5_3400
	LD R7, BACKUP_R7_3400
RET	
;--------------
;subroutine data
;---------------
	;BACKUP_R0_3400		.BLKW #1
	BACKUP_R1_3400		.BLKW #1
	BACKUP_R2_3400		.BLKW #1
	BACKUP_R3_3400		.BLKW #1
	BACKUP_R4_3400		.BLKW #1
	BACKUP_R5_3400		.BLKW #1
	BACKUP_R7_3400		.BLKW #1
;-----------------------------------------------------------------------------------------------
; SUB_STACK_POP local data
ERROR_MSG3	.STRINGZ "\nError: Underflow"
ERR0R_MSG4	.STRINGZ "\nPOP Successfull"
;===============================================================================================

;------------------------------------------------------------------------------------------
; Subroutine: SUB_RPN_MULTIPLY
; Parameter (R4): BASE: A pointer to the base (one less than the lowest available
;                       address) of the stack
; Parameter (R5): MAX: The "highest" available address in the stack
; Parameter (R6): TOS (Top of Stack): A pointer to the current top of the stack
; Postcondition: The subroutine has popped off the top two values of the stack,
;		    multiplied them together, and pushed the resulting value back
;		    onto the stack.
; Return Value: R6 ← updated TOS address
;------------------------------------------------------------------------------------------
.orig x3600
SUB_RPN_MULTIPLY 
;--------------
;Register Backup
;---------------
	;ST R0, BACKUP_R0_3400
	ST R1, BACKUP_R1_3600
	ST R2, BACKUP_R2_3600
	ST R3, BACKUP_R3_3600
	ST R4, BACKUP_R4_3600
	ST R5, BACKUP_R5_3600
	ST R7, BACKUP_R7_3600	 
;------------
;Instructions
;-------------

		LD R2, n48 
		LDR R3, R6, #0 
		ADD R3, R3, R2
		
		LD R1, SUB_STACK_POP_FILL_2
		JSRR R1

		LDR R4, R6, #0 
		ADD R4, R4, R2
		
		LD R1, SUB_STACK_POP_FILL_2
		JSRR R1
			
		AND R2, R2, x0
		MULT
			ADD R3, R3, #0
			BRz END_MULT
			ADD R2, R2, R4
			ADD R3, R3, #-1
			BR MULT
		END_MULT	
		
		LD R0, 	NEW_Line
		OUT
		
		ADD R5, R2, #0
;========================================================						
	;======10======
	AND R2, R2, x0
	AND R0, R0, x0
	
	LD R3, N10
	DEVIDE_10
		ADD R5, R5, R3	;subtracr zero from R5
		BRn SKIP_10
		ADD R0, R0, #1
		BR DEVIDE_10
		
	SKIP_10
	LD R3, DEC_10
	ADD R5, R5, R3
	
	LD R7, DEC_48
	ADD R0, R0, R7
	OUT
	
	;======1=====
	AND R2, R2, x0
	AND R0, R0, x0
	
	LD R3, N1
	DEVIDE_1
		ADD R5, R5, R3	;subtracr zero from R5
		BRn SKIP_1
		ADD R0, R0, #1
		BR DEVIDE_1
		
	SKIP_1
	LD R3, DEC_1
	ADD R5, R5, R3
	
	LD R7, DEC_48
	ADD R0, R0, R7
	OUT	
;========================================================			
	LD R0, 	NEW_Line
	OUT
	
				 

;-----------------
;Restore registers
;-----------------
	;LD R0, BACKUP_R0_3400
	LD R1, BACKUP_R1_3600
	LD R2, BACKUP_R2_3600
	LD R3, BACKUP_R3_3600
	LD R4, BACKUP_R4_3600
	LD R5, BACKUP_R5_3600
	LD R7, BACKUP_R7_3600
RET	
;--------------
;subroutine data
;---------------
	;BACKUP_R0_3400		.BLKW #1
	BACKUP_R1_3600		.BLKW #1
	BACKUP_R2_3600		.BLKW #1
	BACKUP_R3_3600		.BLKW #1
	BACKUP_R4_3600		.BLKW #1
	BACKUP_R5_3600		.BLKW #1
	BACKUP_R7_3600		.BLKW #1
;-----------------------------------------------------------------------------------------------
; SUB_RPN_MULTIPLY local data
	
n48	.FILL #-48
DEC_48		.FILL #48
NEW_Line	.FILL #10

N10			.FILL	#-10
N1			.FILL	#-1
DEC_10		.FILL	#10
DEC_1		.FILL	#1
SUB_STACK_PUSH_PTR_2 .FILL SUB_STACK_PUSH
SUB_STACK_POP_FILL_2 .FILL SUB_STACK_POP

;===============================================================================================



; SUB_MULTIPLY		

; SUB_GET_NUM		

; SUB_PRINT_DECIMAL		Only needs to be able to print 1 or 2 digit numbers. 
;						You can use your lab 7 s/r.


