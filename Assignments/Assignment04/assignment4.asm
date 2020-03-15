;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Sebastian Garcia
; Email: sgarc133@ucr.edu
; 
; Assignment name: Assignment 4
; Lab section: 
; TA: 
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=================================================================================
;THE BINARY REPRESENTATION OF THE USER-ENTERED DECIMAL NUMBER MUST BE STORED IN R2
;=================================================================================

					.ORIG x3000		
;-------------
;Instructions
;-------------

; output intro prompt
						
; Set up flags, counters, accumulators as needed
	LD R1, COUNTER_5
	

; Get first character, test for '\n', '+', '-', digit/non-digit 					
					; is very first character = '\n'? if so, just quit (no message)
					; is it = '+'? if so, ignore it, go get digits
					; is it = '-'? if so, set neg flag, go get digits				
					; is it < '0'? if so, it is not a digit	- o/p error message, start over
					; is it > '9'? if so, it is not a digit	- o/p error message, start over				
					; if none of the above, first character is first numeric digit - convert it to number & store in target register!					
; Now get remaining digits (max 5) from user, testing each to see if it is a digit, and build up number in accumulator
					; remember to end with a newline!

	

	INTRO
		LD R0, introPromptPtr
		PUTS				
	
	TOP
		GETC						;gets input
		OUT
		
		LD R3, nNEGATIVE_SIGN		;fill and check for negative
		ADD R4, R0, R3			 
		BRz NEGATIVE_SIGN		
		
		LD R3, nPOSITIVE_SIGN		;fill and check for plus
		ADD R4, R0, R3			
		BRz POSITIVE_SIGN		
		
		LD R3, nENTER				;fill and check for enter 
		ADD R4, R0, R3
		BRz	ENTER_LOOP
		
		
		LD R3, nZero				;fill and check for 0 
		ADD R4, R0, R3
		BRz	VALID_NUM
		LD R3, nONE					;fill and check for 1 
		ADD R4, R0, R3
		BRz	VALID_NUM
		LD R3, nTWO					;fill and check for 2 
		ADD R4, R0, R3
		BRz	VALID_NUM
		LD R3, nTHREE				;fill and check for 3 
		ADD R4, R0, R3
		BRz	VALID_NUM
		LD R3, nFOUR				;fill and check for 4 
		ADD R4, R0, R3
		BRz	VALID_NUM
		LD R3, nFIVE				;fill and check for 5 
		ADD R4, R0, R3
		BRz	VALID_NUM
		LD R3, nSIX					;fill and check for 6 
		ADD R4, R0, R3
		BRz	VALID_NUM
		LD R3, nSEVEN				;fill and check for 7 
		ADD R4, R0, R3
		BRz	VALID_NUM
		LD R3, nEIGHT				;fill and check for 8 
		ADD R4, R0, R3	
		BRz	VALID_NUM
		LD R3, nNINE				;fill and check for 9 
		ADD R4, R0, R3
		BRz	VALID_NUM
		
		LD R0, ENTER				;if invalid input, output enter 
		OUT							;and error msg
		LD R0, errorMessagePtr
		PUTS
			
		AND R2, R2, x0				;clear R2
		AND R6, R6, x0				;clear R6
		AND R5, R5, x0				;clear R5
		LD R1, COUNTER_5			;reset counter
		BRnzp INTRO					;reset to INTRO
		
		
		NEGATIVE_SIGN
			ADD R3, R5, #-5			;check if + entered
			BRz ERROR				;if so, output error and reset 
			
			AND R5, R5, x0			;add back 5
			ADD R5, R5, #10			;check if - entered
			BRnzp TOP				;return to top
			
		POSITIVE_SIGN
			AND R5, R5, x0			;reset R5
			ADD R5, R5, #5			;make flag for positive
			BRnzp TOP				;return to top
			
		ENTER_LOOP
			BRnzp NEGATIVE_CHECK	;Done inserting so check for -
		
		VALID_NUM					;entered num was valid
			LD R3, nZero	
			ADD R0, R0, R3			;convert ascii to dec
			ADD R6, R6, R0			;enter dec to R6
			ADD R2, R6, #0			;add R6 to R2 pre 
			LD R4, COUNTER_10		;load multiplier counter
			
		MULTIPLY					;multiply by 10
			ADD R6, R6, R2			;add to R6 (R6 += R2)
			ADD R4, R4, #-1			;subtract fro multiplier
			BRp MULTIPLY			;keep adding until counter reaches 0
			
		ADD R1, R1, #-1				;subtracr from main counter
		Brz INSERT_ENTER
		Brp TOP
		
		INSERT_ENTER				;output new line
			LD R0, ENTER			
			OUT	
			BR NEGATIVE_CHECK
			
		ERROR						;output error msg
			LD R0, ENTER			
			OUT	
			LD R0, errorMessagePtr
			PUTS
			BRnzp INTRO
		
	
	NEGATIVE_CHECK					;check for -, annd if so, convrt
		ADD R5, R5, #-10
		BRnp FIN
		NOT R2, R2
		ADD R2, R2, #1
	
	FIN
	
	
HALT

;---------------	
; Program Data
;---------------

	introPromptPtr	.FILL xA100
	errorMessagePtr	.FILL xA200

	COUNTER_5		.FILL 	#5
	COUNTER_10		.FILL   #9
	ENTER			.FILL	#10
	nENTER			.FILL	#-10 
	nNEGATIVE_SIGN	.FILL	#-45
	nPOSITIVE_SIGN	.FILL	#-43
	
	nZero			.FILL	#-48
	nONE			.FILL	#-49
	nTWO			.FILL	#-50
	nTHREE			.FILL	#-51
	nFOUR			.FILL	#-52
	nFIVE			.FILL	#-53
	nSIX			.FILL	#-54
	nSEVEN			.FILL	#-55
	nEIGHT			.FILL	#-56
	nNINE			.FILL	#-57
;------------
; Remote data
;------------
	.ORIG xA100			; intro prompt
	.STRINGZ	"Input a positive or negative decimal number (max 5 digits), followed by ENTER\n"
					
					
	.ORIG xA200			; error message
	.STRINGZ	"ERROR: invalid input\n"

;---------------
; END of PROGRAM
;---------------
.END

;-------------------
; PURPOSE of PROGRAM
;-------------------
; Convert a sequence of up to 5 user-entered ascii numeric digits into a 16-bit two's complement binary representation of the number.
; if the input sequence is less than 5 digits, it will be user-terminated with a newline (ENTER).
; Otherwise, the program will emit its own newline after 5 input digits.
; The program must end with a *single* newline, entered either by the user (< 5 digits), or by the program (5 digits)
; Input validation is performed on the individual characters as they are input, but not on the magnitude of the number.
