;=================================================
; Name: 
; Email: 
; 
; Lab: lab 9, ex 1 & 2
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
	
	LOOP
		LD R2, nDEC_101
		LEA R0,  intro_32
		PUTS
		GETC
		OUT
		ADD R2, R0, R2
		BRn POP_SUB
		BRz FIN_30
		PUSH_SUB
			LD R1, SUB_STACK_PUSH_PTR
			JSRR R1
			LD R0, NEW_Line
			OUT
			AND R0, R0, x0
			BR LOOP
		POP_SUB
			LD R1, SUB_STACK_POP_FILL
			JSRR R1
			LD R0, NEW_Line
			OUT
			AND R0, R0, x0
			BR LOOP
	
		FIN_30
				 
halt
;-----------------------------------------------------------------------------------------------
; test harness local data:
BASE		.FILL xA000
MAX			.FILL xA005
TOS			.FILL xA000
DEC_48		.FILL #48
nDEC_101 	.FILL #-101
nNew_Line	.FILL #-10
NEW_Line	.FILL #10
intro_32 	.STRINGZ "Welcome, enter 'p' to push, 'd' to pop, and 'e' to exit\n"

SUB_STACK_PUSH_PTR .FILL SUB_STACK_PUSH
SUB_STACK_POP_FILL .FILL SUB_STACK_POP


;===============================================================================================


; subroutines:
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
	
	LEA R0, INTRO_36
	PUTS
	GETC
	OUT
	
	PUSH_BACK
		ADD R6, R6, #1
		STR R0, R6, #0
		BR FIN_36
	
	OVERFLOW
		LEA R0, ERROR_MSG
		PUTS
		
	FIN_36
.END
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
		LEA R0, ERR0R_MSG4
		PUTS
		BR FIN_34
	
	UNDERFLOW
		LEA R0, ERROR_MSG3
		PUTS
		
	FIN_34
	
	
.END
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

