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
	LD R3, DEC_65	
	LD R4, HEX_41
	
HALT

	;----------
	;Local Data
	;----------

	DEC_65	.FILL	#65
	HEX_41	.FILL	x41

.END
