;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Sebastian Garcia
; Email: sgarc133@ucr.edu
; 
; Assignment name: Assignment 3
; Lab section: 
; TA:
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=========================================================================

.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------
LD R6, Value_addr		; R6 <-- pointer to value to be displayed as binary
LDR R1, R6, #0			; R1 <-- value to be displayed as binary 
;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------
LD R2, MAIN_COUNT
LD R4, SPACE_COUNT
;LDR R3, R6, #0
	
	
	WHILE_13p
		ADD R1, R1, #0			;checks if negatives and goes to print 
		BRn OUT_ONE				;checks if negatives and goes to print 

		
		OUT_ZERO
			LD R0, ZERO			;load and output 0
			OUT
			ADD R2, R2, #-1		;subtract 1 from main count
			BRz END_WHILE_13p	;if 0, done with all bits so exit
			ADD R1, R1, R1		;shift bits to left
			ADD R4, R4, #-1     ;subtract 1 from space counter 
			BRz PRINT_SPACE		;if 0, need a space
			ADD R4, R4, #0	    ;since it dosnt need a space, 
			Brp WHILE_13p		;returns to top
			
		OUT_ONE
			LD R0, ONE			;load and output 1
			OUT
			ADD R2, R2, #-1		;subtract 1 from main count
			BRz END_WHILE_13p	;if 0, done with all bits so exit
			ADD R1, R1, R1		;shift bits to left
			ADD R4, R4, #-1     ;subtract 1 from space counter 
			BRp WHILE_13p	    ;if 0, need a space
			
		PRINT_SPACE
			LD R0, SPACE		;Load and output space
			OUT
			ADD R4, R4, #4		;reset space couter to 4
			;ADD R1, R1, R1		;shift bits to left
			ADD R2, R2, #0		;goes back to top
			BRp WHILE_13p
			
	END_WHILE_13p

	LD R0, NEW_LINE				;Load and print new line
	OUT

HALT
;---------------	
;Data
;---------------
Value_addr	.FILL xB800	; The address where value to be displayed is stored

MAIN_COUNT	.FILL #16	;Stores 16 to count down 16 bits
ZERO	.FILL #48		;Stores 0
ONE		.FILL #49		;Stores 1
SPACE	.FILL #32		;Stores a space
NEW_LINE	.FILL #10	;Stores a new line 
SPACE_COUNT	.FILL #4	;Stores 4 to count down spaces

.ORIG xB800					; Remote data
Value .FILL x73A2			; <----!!!NUMBER TO BE DISPLAYED AS BINARY!!! Note: label is redundant.


;---------------	
;END of PROGRAM
;---------------	
.END
