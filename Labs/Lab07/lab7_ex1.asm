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
	JSR HARD_FILL
	
	ADD R1, R1, #1
	
	JSR OUTPUT_HARD


HALT
;---------------	
;Data
;---------------


;------------------------------------------------------------------------------
; Subroutine: HARD_FILL
; Parameter: none
; Postcondition: Hard codes a value to be converted to dec
; Return Value: R1 - hard coded value
;--------------------------------------------------------------------------------

.ORIG x3200			; Program begins here
HARD_FILL

;--------------
;Register Backup
;---------------
	ST R0, BACKUP_R0_3200
	;ST R1, BACKUP_R1_3200
	ST R2, BACKUP_R2_3200
	ST R3, BACKUP_R3_3200
	ST R4, BACKUP_R4_3200
	ST R6, BACKUP_R6_3200
	ST R7, BACKUP_R7_3200


;------------
;Instructions
;-------------
	LD R1, VALUE
;-----------------
;Restore registers
;-----------------
	LD R0, BACKUP_R0_3200
	;LD R1, BACKUP_R1_3200
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
	;BACKUP_R1_3200		.BLKW #1
	BACKUP_R2_3200		.BLKW #1
	BACKUP_R3_3200		.BLKW #1
	BACKUP_R4_3200		.BLKW #1
	BACKUP_R6_3200		.BLKW #1
	BACKUP_R7_3200		.BLKW #1
;---------------	
;Data
;---------------
	VALUE .FILL #15872			;_____HARD_CODDED_VALUE____




;------------------------------------------------------------------------------
; Subroutine: OUTPUT_HARD
; Parameter: R1, hard coded value from first subroutine 
; Postcondition: Takes the hard coded value and convert it to a decimal
; Return Value: Output as deciaml
;--------------------------------------------------------------------------------

.ORIG x3400			; Program begins here
OUTPUT_HARD
;--------------
;Register Backup
;---------------
	ST R0, BACKUP_R0_3400
	ST R1, BACKUP_R1_3400
	ST R2, BACKUP_R2_3400
	ST R3, BACKUP_R3_3400
	ST R4, BACKUP_R4_3400
	ST R6, BACKUP_R6_3400
	ST R7, BACKUP_R7_3400
	
;------------
;Instructions
;-------------
;====== 10000
	ADD R5, R1, R5
	
	LD R3, N10000
	DEVIDE_10000
		ADD R5, R5, R3	;subtracr zero from R1
		BRn SKIP_10000
		ADD R0, R0, #1
		BR DEVIDE_10000
		
	SKIP_10000
	LD R3, DEC_10000
	ADD R5, R5, R3
	
	LD R6, DEC_48
	ADD R0, R0, R6
	OUT
;====== 1000
	AND R2, R2, x0
	AND R0, R0, x0
	
	LD R3, N1000
	DEVIDE_1000
		ADD R5, R5, R3	;subtracr zero from R1
		BRn SKIP_1000
		ADD R0, R0, #1
		BR DEVIDE_1000
		
	SKIP_1000
	LD R3, DEC_1000
	ADD R5, R5, R3
	
	LD R6, DEC_48
	ADD R0, R0, R6
	OUT
	
;====== 100
	AND R2, R2, x0
	AND R0, R0, x0
	
	LD R3, N100
	DEVIDE_100
		ADD R5, R5, R3	;subtracr zero from R1
		BRn SKIP_100
		ADD R0, R0, #1
		BR DEVIDE_100
		
	SKIP_100
	LD R3, DEC_100
	ADD R5, R5, R3
	
	LD R6, DEC_48
	ADD R0, R0, R6
	OUT
	
;====== 10
	AND R2, R2, x0
	AND R0, R0, x0
	
	LD R3, N10
	DEVIDE_10
		ADD R5, R5, R3	;subtracr zero from R1
		BRn SKIP_10
		ADD R0, R0, #1
		BR DEVIDE_10
		
	SKIP_10
	LD R3, DEC_10
	ADD R5, R5, R3
	
	LD R6, DEC_48
	ADD R0, R0, R6
	OUT
	
;====== 1
	AND R2, R2, x0
	AND R0, R0, x0
	
	LD R3, N1
	DEVIDE_1
		ADD R5, R5, R3	;subtracr zero from R1
		BRn SKIP_1
		ADD R0, R0, #1
		BR DEVIDE_1
		
	SKIP_1
	LD R3, DEC_1
	ADD R5, R5, R3
	
	LD R6, DEC_48
	ADD R0, R0, R6
	OUT


	
;-----------------
;Restore registers
;-----------------
	LD R0, BACKUP_R0_3400
	LD R1, BACKUP_R1_3400
	LD R2, BACKUP_R2_3400
	LD R3, BACKUP_R3_3400
	LD R4, BACKUP_R4_3400
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
	BACKUP_R6_3400		.BLKW #1
	BACKUP_R7_3400		.BLKW #1
;---------------	
;Data
;---------------
	N10000		.FILL	#-10000
	N1000		.FILL	#-1000
	N100		.FILL	#-100
	N10			.FILL	#-10
	N1			.FILL	#-1
	
	DEC_10000	.FILL	#10000
	DEC_1000	.FILL	#1000
	DEC_100		.FILL	#100
	DEC_10		.FILL	#10
	DEC_1		.FILL	#1


	
	DEC_48		.FILL	#48
.END
