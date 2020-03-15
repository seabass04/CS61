;=================================================
; Name: 
; Email: 
; 
; Lab: lab 6, ex 1
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
	ADD R0, R1, #0
	PUTS

HALT
;----------
;LOCAL DATA
;-----------
	ARRAY_PTR .FILL ARRAY2

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


.END


