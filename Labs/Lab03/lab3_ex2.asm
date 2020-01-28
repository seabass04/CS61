;=================================================
; Name: Sebastian Garcia
; Email: Sgarc33@ucr.edu
; 
; Lab: lab 3, ex 2
; Lab section: 
; TA: 
; 
;=================================================

.org x3000
	;-------------
	;Instructions
	;-------------
	LD R1, DEC_10
	LEA R2, ARRAY
	
	DO_WHILE_LOOP
		Trap x20
		Trap x21
		
		STR R0, R2, #0
		ADD R2, R2, #1
		
		ADD R1, R1, #-1
		BRp DO_WHILE_LOOP
		
	
HALT

	;----------
	;Local Data
	;----------
	DEC_10 .FILL #10
	ARRAY .BLKW #10
	
.end
