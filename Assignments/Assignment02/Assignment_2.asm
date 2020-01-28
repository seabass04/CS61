;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Sebastian Garcia
; Email: sgarc133@ucr.edu
; 
; Assignment name: Assignment 2
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
	LD R3, DEC_48

;----------------------------------------------
;output prompt
;----------------------------------------------	
LEA R0, intro			; get starting address of prompt string
PUTS			    	; Invokes BIOS routine to output string

;-------------------------------
;INSERT YOUR CODE here
;--------------------------------
	GETC
	OUT
	ADD R1, R0, #0	;get, store, and output value w/ newline
	LD R0, newline
	OUT
	
	GETC
	OUT
	ADD R2, R0, #0	;get, store, and output value w/ newline
	LD R0, newline
	OUT

	NOT R3, R3
	ADD R3, R3, #1	;take 2's compliment for -48
	
	ADD R4, R1, R3	;subrtact 48 from both vales for ddecimal value
	ADD R5, R2, R3	;and store
	;ADD R4, R1, #-48
	;ADD R5, R2, #-48

	NOT R5, R5
	ADD R5, R5, #1	;take 2's compliment of 2nd value for negative
		
	;LDR R0, R1, #0
	ADD R0, R1, #0	
	OUT				;output first number
	LD R0, SPACE
	OUT				;output space
	LD R0, DASH
	OUT				;output dash 
	LD R0, SPACE
	OUT				;output space 
	;LDR R0, R2, #0
	ADD R0, R2, #0	
	OUT				;output second number
	LD R0, SPACE
	OUT				;output space
	LD R0, EQUAL
	OUT				;output equal sign
	LD R0, SPACE
	OUT				;output space
	
	
	NOT R3, R3
	ADD R3, R3, #1	;revert -48 back to 48
	
	ADD R5, R4, R5	;Subtract two values and rewrite

	IF_STATMENT	
		BRzp IS_POSITIVE	;if sum is negative go to ISNegative else
	IS_NEGATIVE		;negative so print out negative sign 
		LD R0, DASH
		OUT				;output dash/negative
		;LD R0, SPACE
		;OUT				;output space
		NOT R5, R5
		ADD R5, R5, 1	;Take 2s compliment to make number positive
		ADD R0, R5, R3	;add 48 to sum for asiic value
		OUT
		LD R0, newline
		OUT
		BR END_IF
	IS_POSITIVE
		ADD R0, R5, R3	;add 48 to sum for asiic value
		OUT
		LD R0, newline
		OUT
	END_IF
	 


HALT				; Stop execution of program
;------	
;Data
;------
; String to prompt user. Note: already includes terminating newline!
intro 	.STRINGZ	"ENTER two numbers (i.e '0'....'9')\n" 		; prompt string - use with LEA, followed by PUTS.
newline .FILL '\n'	; newline character - use with LD followed by OUT

	SPACE .FILL ' '
	DASH .FILL '-'	;also negative
	EQUAL .FILL '='
	DEC_48 .FILL #48



;---------------	
;END of PROGRAM
;---------------	
.END