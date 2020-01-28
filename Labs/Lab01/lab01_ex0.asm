;Hello world example 
;also illustrates how to use PUTUS
;
.ORIG x3000
;------------
;Instuctions
;------------
	LEA R0, MSG_TO_PRINT	;R0<-the location of the label:MSG_TO_PRINT
	PUTS	;Prints dtring dewfined to MSG_TO_PRINT
	
	HALT	;terminates programs
	
;-----------
;Local data
;-----------
	MSG_TO_PRINT	.STRINGZ	"Hello World!\n"	
	
	;store 'H' in an address labelled MSG_TO_PRINT and then 
	;each caracter in its own memory address, followed by #0 at 
	;the end of the string to mark the end 
