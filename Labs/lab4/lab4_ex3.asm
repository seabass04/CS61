;=================================================
; Name: Sebastian Garca
; Email: Sgarc133@ucr.edu
; 
; Lab: lab 4, ex 3
; Lab section: 
; TA: 
; 
;=================================================

.ORIG x3000

;------------
;INSTRUCTIONS
;------------
	LD R3, DEC_1
    LD R4, DEC_10
    LD R5, ARRAY_PTR
    
    
    DO_WHILE_LOOP
		STR R3, R5, #0
		ADD R3, R3, R3
		ADD R5, R5, #1 
		
		ADD R4, R4, #-1
	BRp DO_WHILE_LOOP
	
		
	ADD R5, R5, #-4
	LDR R2, R5, #0
	
HALT


;----------
;LOCAL DATA
;-----------
	DEC_1 .FILL #1
	DEC_10 .FILL #10
	ARRAY_PTR .FILL ARRAY
	
.orig x4000
	ARRAY .BLKW #10
	
.end
