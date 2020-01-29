;=================================================
; Name: Sebastian Garca
; Email: Sgarc133@ucr.edu
; 
; Lab: lab 4, ex 2
; Lab section: 
; TA: 
; 
;=================================================

.ORIG x3000

;------------
;INSTRUCTIONS
;------------
	LD R3, DEC_0
    LD R4, DEC_10
    LD R5, ARRAY_PTR
    LD R6, DEC_48
    
    
    DO_WHILE_LOOP
		STR R3, R5, #0
		ADD R3, R3, #1
		ADD R5, R5, #1 
		
		ADD R4, R4, #-1
	BRp DO_WHILE_LOOP
		
	ADD R5, R5, #-4
	LDR R2, R5, #0
	
	
	;NOT R6, R6
	;ADD R6, R6, #1
	
	ADD R5, R5, #-6
	ADD R4, R4, #10
	DO_WHILE_LOOP2
		LDR R0, R5, #0
		ADD R0, R0, R6
		OUT
		
		ADD R4, R4, #-1
	BRp DO_WHILE_LOOP2
	
	
HALT


;----------
;LOCAL DATA
;-----------
	DEC_0 .FILL #0
	DEC_10 .FILL #10
	ARRAY_PTR .FILL ARRAY
	DEC_48 .FILL x48
	
.orig x4000
	ARRAY .BLKW #10
	
.end
