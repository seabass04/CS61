;=================================================
; Name: Sebastian Garcia
; Email: Sgarc133@ucr.edu
; 
; Lab: lab 3, ex 3
; Lab section: 
; TA: 
; 
;=================================================

.org x3000
	;-------------
	;Instructions
	;-------------
	LD R1, DEC_10
	LD R4, NewLine
	LEA R2, ARRAY
	
	DO_WHILE_LOOP
		GETC
		OUT
		
		STR R0, R2, #0
		ADD R2, R2, #1
		
		ADD R1, R1, #-1
		BRp DO_WHILE_LOOP
		
	
	ADD R1, R1, #10 ;Rest R1 to 10
	
	LEA R2, ARRAY
	
	DO_WHILE_LOOP2
		LD R0, NewLine
		OUT
		LDR R0, R2, #0
		OUT
		

		ADD R2, R2, #1
		ADD R1, R1, #-1
		BRp DO_WHILE_LOOP2
		
	
HALT

	;----------
	;Local Data
	;----------
	DEC_10 .FILL #10
	NewLine .FILL x0A
	ARRAY .BLKW #10
	
.end
