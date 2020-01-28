;=================================================
; Name: Sebastian Garcia
; Email: sgarc133@ucr.edu
; 
; Lab: lab 2. ex 1
; Lab section: 22
; TA: Lin, Jang-Shing
;=================================================

.org x3000

	;-------------
	;Instructions
	;-------------
	LDI R3, DEC_65_PTR	
	LDI R4, HEX_41_PTR
	
	ADD R3, R3, #1
	ADD R4, R4, #1
	
	STI R3, DEC_65_PTR
	STI R4, HEX_41_PTR
	
HALT

	;----------
	;Local Data
	;----------
	DEC_65_PTR .FILL x4000
	HEX_41_PTR .FILL x4001
	
	;----------
	;Remote Data
	;----------
.orig x4000
	.FILL #65
	.FILL x41

.END
