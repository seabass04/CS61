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
	LD R5, DEC_48
	
	GETC
	OUT
	ADD R1, R0, #0
	JSR COUNT_1s
	
	LEA R0, out1
	PUTS
	
	AND R0, R0, x0
	ADD R0, R0, R1
	OUT
	
	LEA R0, out2
	PUTS
	
	AND R0, R0, x0
	ADD R0, R2, R5
	OUT
	
	

HALT
;---------------	
;Data
;---------------
	out1 	.STRINGZ "\nThe number of 1's in \'"
	out2	.STRINGZ "\' is:  "
	DEC_48	.FILL #48

;------------------------------------------------------------------------------
; Subroutine: 
; Parameter: R1, holds user input
; Postcondition: 
; Return Value: 
;--------------------------------------------------------------------------------

.ORIG x3200			; Program begins here
COUNT_1s

;--------------
;Register Backup
;---------------
	ST R0, BACKUP_R0_3200
	ST R1, BACKUP_R1_3200
	;ST R2, BACKUP_R2_3200
	ST R3, BACKUP_R3_3200
	ST R4, BACKUP_R4_3200
	ST R6, BACKUP_R6_3200
	ST R7, BACKUP_R7_3200


;------------
;Instructions
;-------------
;;R2 = num of 1's
	LD R3 ,COUNT
	
	COUNT_ONES
		ADD R1, R1, #0			;checks if negatives and goes to print 
		BRn ADD_ONE
		
		SKIPA
		ADD R1, R1, R1			;move bits 
		ADD R3, R3, #-1			;decrament count 
		BRz FIN
		BRp COUNT_ONES
		
		ADD_ONE
			ADD R2, R2, #1
			BR SKIPA
		
	FIN
.END	

;-----------------
;Restore registers
;-----------------
	LD R0, BACKUP_R0_3200
	LD R1, BACKUP_R1_3200
	;LD R2, BACKUP_R2_3200
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
	;BACKUP_R2_3200		.BLKW #1
	BACKUP_R3_3200		.BLKW #1
	BACKUP_R4_3200		.BLKW #1
	BACKUP_R6_3200		.BLKW #1
	BACKUP_R7_3200		.BLKW #1
;---------------	
;Data
;---------------
	COUNT	.FILL #16
.END

