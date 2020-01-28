;=================================================
; Name: Sebastian Garcia
; Email: Sgarc133@ucr.edu
; 
; Lab: lab 3, ex 4
; Lab section: 
; TA: 
; 
;=================================================

.ORG x3000
	;-------------
	;Instructions
	;-------------
	LD R2, ARRAY
	LD R4, NewLine
	
	DO_WHILE_LOOP
		GETC
		OUT
		
		STR R0, R2, #0
		ADD R2, R2, #1
		
		ADD R0, R0, #-10
		BRp DO_WHILE_LOOP
		
	
	LD R2, ARRAY
	
	DO_WHILE_LOOP2
		LD R0, NewLine
		OUT
		LDR R0, R2, #0
		OUT
		
		ADD R2, R2, #1
		ADD R0, R0, #-10
		;ADD R1, R1, #-1
		BRp DO_WHILE_LOOP2
		
	
HALT

	;----------
	;Local Data
	;----------
	ARRAY .FILL x4000
	NewLine .FILL x0A
	
.end
