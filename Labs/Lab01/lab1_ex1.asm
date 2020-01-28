;---------------------------------------
; Garcia, Sebastian
; Login: sgarc133 (sgarc133@cs.ucr.edu)
; Section: 022
; TA: Lin, Jang-Shing
; Lab
;---------------------------------------

.org x3000
	;-------------
	;Instructions
	;-------------
	;LD R1, DEC_0
	AND R1, R1,x0	;R1 <- (R1) AND x0000
	LD R2, DEC_12	;Assigns R2, R3  value 
	LD R3, DEC_6
	
	DO_WHILE_LOOP
		ADD R1, R1, R2		;R1 = R1 + R2
		ADD R3, R3, #-1		;R3 = R3 - #1
		BRp DO_WHILE_LOOP	; if (R3>0): goto DO_WHILE_LOOP
	END_DO_WHIL_LOOP

	HALT	;halt program
	;----------
	;Local Data
	;----------
	DEC_0	.FILL	#0
	DEC_12	.FILL	#12		;puts 12 into memory 
	DEC_6	.FILL	#6
	
.end
