;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Sebastian Garcia
; Email: sgarc133@ucr.edu
; 
; Assignment name: Assignment 5
; Lab section: 
; TA: 
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=========================================================================

.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------
;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------
	TOP
		JSR MENU
		
		;LD R6, nONE					;fill and check for 1 
		LD R6, ONE_30
		NOT R6, R6
		ADD R6, R6, #1
		ADD R6, R1, R6
		BRnp SKIP_1
		JSR ALL_MACHINES_BUSY
		ADD R1, R1, #0
		BRz PRINT_ALL_BUSY
		BR PRINT_NOT_BUSY
		
		
		SKIP_1
			LD R6, TWO_30
			NOT R6, R6					;fill and check for 2 
			ADD R6, R6, #1
			ADD R6, R1, R6
			BRnp SKIP_2
			LD R5, ALL_MACHINES_FREE_SUB_PTR
			JSRR R5
			ADD R2, R2, #0
			BRp PRINT_ALL_FREE
			ADD R2, R2, #0
			BR PRINT_NOT_FREE
		
		SKIP_2
			LD R6, THREE_30
			NOT R6, R6					;fill and check for 3 
			ADD R6, R6, #1		
			ADD R6, R1, R6
			BRnp SKIP_3
			LD R5, NUM_BUSY_MACHINES_SUB_PTR
			JSRR R5
			;LDR R1, R2, #0;;;;;
			ADD R1, R2, #0
			LEA R0, busymachine1
			PUTS
			LD R5, PRINT_NUM_SUB_PTR
			JSRR R5
			LEA R0, busymachine2
			PUTS
			BR TOP
			
		
		SKIP_3
			LD R6, FOUR_30
			NOT R6, R6					;fill and check for 4
			ADD R6, R6, #1
			ADD R6, R1, R6
			BRnp SKIP_4
			LD R5, NUM_FREE_MACHINES_SUB_PTR
			JSRR R5
			LEA R0, freemachine1
			ADD R1, R2, #0
			PUTS
			LD R5, PRINT_NUM_SUB_PTR
			JSRR R5
			LEA R0, freemachine2
			PUTS
			BR TOP
			
			
		SKIP_4
			LD R6, FIVE_30
			NOT R6, R6					;fill and check for 5
			ADD R6, R6, #1
			ADD R6, R1, R6
			BRnp SKIP_5
			
			LD R5, MACHINE_STATUS_SUB_PTR
			JSRR R5
			
			LEA R0, status1
			PUTS
			LD R5, PRINT_NUM_SUB_PTR
			JSRR R5
			
			BUSY_CHECK
				ADD R2, R2, #0
				BRz PRINT_IS_BUSY
				
				LEA R0, status3
				PUTS
				BR TOP
				
				PRINT_IS_BUSY
					LEA R0, status2
					PUTS
				
			BR TOP
		
		SKIP_5
			LD R6, SIX_30
			NOT R6, R6					;fill and check for 6
			ADD R6, R6, #1		
			ADD R6, R1, R6
			BRnp SKIP_6
			
			LD R5, FIRST_FREE_SUP_PTR
			JSRR R5
			
			ADD R2, R2, #0
			BRzp HAS_BUSY
			LEA R0, firstfree2
			PUTS
			BR TOP
			
			HAS_BUSY
				LEA R0, firstfree1
				PUTS
				ADD R1, R2, #0
				LD R5, PRINT_NUM_SUB_PTR
				JSRR R5
				LD R0, newline
				OUT
			
			BR TOP
			
			
		SKIP_6
		BR BYE
			
		
	
	
	PRINT_ALL_BUSY
		LEA R0, allbusy
		PUTS
		BR TOP
	PRINT_NOT_BUSY
		LEA R0, allnotbusy
		PUTS
		BR TOP
	PRINT_ALL_FREE
		LEA R0, allfree
		PUTS
		BR TOP
	PRINT_NOT_FREE
		LEA R0, allnotfree
		PUTS
		BR TOP

		
		LEA R0, busymachine2
		PUTS
		BR TOP
	
	BYE
		LEA R0, goodbye
		PUTS
HALT
;---------------	
;Data
;---------------
;Subroutine pointers
	ALL_MACHINES_FREE_SUB_PTR	.FILL ALL_MACHINES_FREE
	NUM_BUSY_MACHINES_SUB_PTR	.FILL NUM_BUSY_MACHINES
	NUM_FREE_MACHINES_SUB_PTR	.FILL NUM_FREE_MACHINES
	MACHINE_STATUS_SUB_PTR		.FILL MACHINE_STATUS
	FIRST_FREE_SUP_PTR			.FILL FIRST_FREE
	PRINT_NUM_SUB_PTR			.FILL PRINT_NUM
;Other data 
	newline 		.fill '\n'
	ONE_30			.FILL 	#1
	TWO_30			.FILL	#2
	THREE_30		.FILL	#3
	FOUR_30			.FILL 	#4
	FIVE_30			.FILL	#5
	SIX_30			.FILL	#6
	SEVEN_30		.FILL	#7
; Strings for reports from menu subroutines:
status1         .stringz "Machine "
busymachine1    .stringz "There are "
busymachine2    .stringz " busy machines\n"
freemachine2    .stringz " free machines\n"
freemachine1    .stringz "There are "
firstfree2      .stringz "No machines are free\n"
status2		    .stringz " is busy\n"
status3		    .stringz " is free\n"
goodbye         .stringz "Goodbye!\n"
allbusy         .stringz "All machines are busy\n"
allnotbusy      .stringz "Not all machines are busy\n"
allfree         .stringz "All machines are free\n"
allnotfree		.stringz "Not all machines are free\n"
firstfree1      .stringz "The first available machine is number "



;-----------------------------------------------------------------------------------------------------------------
; Subroutine: MENU
; Inputs: None
; Postcondition: The subroutine has printed out a menu with numerical options, invited the
;                user to select an option, and returned the selected option.
; Return Value (R1): The option selected:  #1, #2, #3, #4, #5, #6 or #7 (as a number, not a character)
;                    no other return value is possible
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine MENU
;--------------------------------
.ORIG x3200			; Program begins here
MENU

;--------------
;Register Backup
;---------------
	ST R0, BACKUP_R0_3200
	ST R2, BACKUP_R2_3200
	ST R3, BACKUP_R3_3200
	ST R4, BACKUP_R4_3200
	ST R5, BACKUP_R5_3200
	ST R6, BACKUP_R6_3200
	ST R7, BACKUP_R7_3200
	
;------------
;Instructions
;-------------
	INTRO
		LD R0, Menu_string_addr
		PUTS				
	
	
		GETC					;gets input
		OUT
		
		
		LD R3, nONE_32			;fill and check for 1 
		ADD R4, R0, R3
		BRz	VALID_NUM
		LD R3, nTWO_32			;fill and check for 2 
		ADD R4, R0, R3
		BRz	VALID_NUM
		LD R3, nTHREE_32		;fill and check for 3 
		ADD R4, R0, R3
		BRz	VALID_NUM
		LD R3, nFOUR_32			;fill and check for 4 
		ADD R4, R0, R3
		BRz	VALID_NUM
		LD R3, nFIVE_32			;fill and check for 5 
		ADD R4, R0, R3
		BRz	VALID_NUM
		LD R3, nSIX_32			;fill and check for 6 
		ADD R4, R0, R3
		BRz	VALID_NUM
		LD R3, nSEVEN_32		;fill and check for 7 
		ADD R4, R0, R3
		BRz	VALID_NUM
		
		AND R1, R1, x0			;clear R1
		
		LD R0, ENTER			;if invalid input, output enter 
		OUT						;and error msg
		LEA R0, Error_msg_1	
		PUTS

		BR INTRO				;reset to INTRO
	
	VALID_NUM					;entered num was valid
		LD R3, nZero_32	
		ADD R0, R0, R3			;convert ascii to dec
		ADD R6, R6, R0			;enter dec to R6
		ADD R1, R6, #0			;add R6 to R2 pre 
		BR FIN
		
		
	FIN
	LD R0, ENTER
	OUT

.END	
;-----------------
;Restore registers
;-----------------
	LD R0, BACKUP_R0_3200
	LD R2, BACKUP_R2_3200
	LD R3, BACKUP_R3_3200
	LD R4, BACKUP_R4_3200
	LD R5, BACKUP_R5_3200
	LD R6, BACKUP_R6_3200
	LD R7, BACKUP_R7_3200
RET	

;--------------
;subroutine data
;---------------
	BACKUP_R0_3200		.BLKW #1
	BACKUP_R2_3200		.BLKW #1
	BACKUP_R3_3200		.BLKW #1
	BACKUP_R4_3200		.BLKW #1
	BACKUP_R5_3200		.BLKW #1
	BACKUP_R6_3200		.BLKW #1
	BACKUP_R7_3200		.BLKW #1
;---------------	
;Data
;---------------
	ENTER			.FILL	#10
	nZero_32		.FILL	#-48
	nONE_32			.FILL	#-49
	nTWO_32			.FILL	#-50
	nTHREE_32		.FILL	#-51
	nFOUR_32		.FILL	#-52
	nFIVE_32		.FILL	#-53
	nSIX_32			.FILL	#-54
	nSEVEN_32		.FILL	#-55

;--------------------------------
;Data for subroutine MENU
;--------------------------------
Error_msg_1	      .STRINGZ "INVALID INPUT\n"
Menu_string_addr  .FILL x6A00

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_BUSY (#1)
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are busy
; Return value (R2): 1 if all machines are busy, 0 otherwise
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine ALL_MACHINES_BUSY
;--------------------------------
.ORIG x3400			; Program begins here
ALL_MACHINES_BUSY
;checks for all 0's

;--------------
;Register Backup
;---------------
	ST R0, BACKUP_R0_3400
	ST R1, BACKUP_R0_3400
	ST R3, BACKUP_R3_3400
	ST R4, BACKUP_R4_3400
	ST R5, BACKUP_R5_3400
	ST R6, BACKUP_R6_3400
	ST R7, BACKUP_R7_3400
	
;------------
;Instructions
;-------------
	LDI R1, BUSYNESS_ADDR_ALL_MACHINES_BUSY
	LD R3, COUNT_16
	
	ADD R1, R1, #0
	CHECK_STATUS
		BRz IS_BUSY
		
		NOT_ALL_BUSY
			LD R2, ZERO_34
			BR SKIP
		
		IS_BUSY
			LD R2, ONE_34
			ADD R1, R1, R1
			ADD R3, R3, #-1
			BR CHECK_STATUS
	
	SKIP
		
.END	
;-----------------
;Restore registers
;-----------------
	LD R0, BACKUP_R0_3400
	LD R3, BACKUP_R3_3400
	LD R4, BACKUP_R4_3400
	LD R5, BACKUP_R5_3400
	LD R6, BACKUP_R6_3400
	LD R7, BACKUP_R7_3400
RET	

;--------------
;subroutine data
;---------------
	BACKUP_R0_3400		.BLKW #1
	BACKUP_R3_3400		.BLKW #1
	BACKUP_R4_3400		.BLKW #1
	BACKUP_R5_3400		.BLKW #1
	BACKUP_R6_3400		.BLKW #1
	BACKUP_R7_3400		.BLKW #1

;--------------------------------
;Data for subroutine ALL_MACHINES_BUSY
;--------------------------------
	ZERO_34	.FILL #0
	ONE_34	.FILL #1
	COUNT_16 .FILL #16
	BUSYNESS_ADDR_ALL_MACHINES_BUSY .FILL xBA00
	ALL_BUST_MASK .FILL xFFFF

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_FREE (#2)
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are free
; Return value (R2): 1 if all machines are free, 0 otherwise
;-----------------------------------------------------------------------------------------------------------------
.ORIG x3600			; Program begins here
ALL_MACHINES_FREE
;checks for all 1's

;--------------
;Register Backup
;---------------
	ST R0, BACKUP_R0_3600
	ST R1, BACKUP_R0_3600
	ST R3, BACKUP_R3_3600
	ST R4, BACKUP_R4_3600
	ST R5, BACKUP_R5_3600
	ST R6, BACKUP_R6_3600
	ST R7, BACKUP_R7_3600
	
;------------
;Instructions
;-------------
	LDI R1, ALL_MACHINES_FREE_PTR
	LD R3, COUNT_16_36
	LD R2, ONE_36
	
	ADD R1, R1, R2
	BRz EDGE_36
	
	LDI R1, ALL_MACHINES_FREE_PTR
	ADD R1, R1, #0
	CHECK_STATUS_36
		BRn NOT_BUSY_36
		
		
		IS_BUSY_36
			LD R2, ZERO_36
			BR SKIP_36
			
		NOT_BUSY_36
			LD R2, ONE_36
			ADD R1, R1, R1
			ADD R3, R3, #-1
			BR CHECK_STATUS_36
			
		EDGE_36
			LD R2, ONE_36
 
	
	SKIP_36
		
.END	
;-----------------
;Restore registers
;-----------------
	LD R0, BACKUP_R0_3600
	LD R3, BACKUP_R3_3600
	LD R4, BACKUP_R4_3600
	LD R5, BACKUP_R5_3600
	LD R6, BACKUP_R6_3600
	LD R7, BACKUP_R7_3600
	
RET	

;--------------
;subroutine data
;---------------
	BACKUP_R0_3600		.BLKW #1
	BACKUP_R3_3600		.BLKW #1
	BACKUP_R4_3600		.BLKW #1
	BACKUP_R5_3600		.BLKW #1
	BACKUP_R6_3600		.BLKW #1
	BACKUP_R7_3600		.BLKW #1

;--------------------------------
;Data for subroutine ALL_MACHINES_BUSY
;--------------------------------
	COUNT_16_36				.FILL #16
	ALL_NOT_BUST_MASK 		.FILL x0000
	ZERO_36					.FILL #0
	ONE_36					.FILL #1
	ALL_MACHINES_FREE_PTR 	.FILL xBA00

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_BUSY_MACHINES (#3)
; Inputs: None
; Postcondition: The subroutine has returned the number of busy machines.
; Return Value (R2): The number of machines that are busy (0)
;-----------------------------------------------------------------------------------------------------------------
.ORIG x3800			; Program begins here
NUM_BUSY_MACHINES
;--------------
;Register Backup
;---------------
	ST R0, BACKUP_R0_3800
	ST R1, BACKUP_R0_3800
	ST R3, BACKUP_R3_3800
	ST R4, BACKUP_R4_3800
	ST R5, BACKUP_R5_3800
	ST R6, BACKUP_R6_3800
	ST R7, BACKUP_R7_3800
	
;------------
;Instructions
;-------------
	LDI R1, BUSYNESS_ADDR_NUM_BUSY_MACHINES
	LD R2, COUNTER_0_38							;counter for busy bits
	LD R3, COUNTER_16_38						;counter for 16 bits
	
	ADD R1, R1, #0
	CHECK_BUSY
		ADD R1, R1, #0
		BRzp IS_ZERO_38
		
		IS_ONE_38
			ADD R1, R1, R1						;left shift bits 
			ADD R3, R3, #-1						;decrament counter 
			BRp CHECK_BUSY
			BR FIN_38
		
		IS_ZERO_38
			ADD R2, R2, #1						;incrament counter
			ADD R1, R1, R1						;left shift bits 
			ADD R3, R3, #-1						;decrament counter 
			BRp CHECK_BUSY
			
	FIN_38 
		
		
.END	
;-----------------
;Restore registers
;-----------------
	LD R0, BACKUP_R0_3800
	LD R3, BACKUP_R3_3800
	LD R4, BACKUP_R4_3800
	LD R5, BACKUP_R5_3800
	LD R6, BACKUP_R6_3800
	LD R7, BACKUP_R7_3800
	
RET	

;--------------
;subroutine data
;---------------
	BACKUP_R0_3800		.BLKW #1
	BACKUP_R3_3800		.BLKW #1
	BACKUP_R4_3800		.BLKW #1
	BACKUP_R5_3800		.BLKW #1
	BACKUP_R6_3800		.BLKW #1
	BACKUP_R7_3800		.BLKW #1

;--------------------------------
;Data for subroutine NUM_BUSY_MACHINES
;--------------------------------
COUNTER_16_38		.FILL #16
COUNTER_0_38		.FILL #0
BUSYNESS_ADDR_NUM_BUSY_MACHINES .Fill xBA00


;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_FREE_MACHINES (#4)
; Inputs: None
; Postcondition: The subroutine has returned the number of free machines
; Return Value (R2): The number of machines that are free (1)
;-----------------------------------------------------------------------------------------------------------------
.ORIG x4000			; Program begins here
NUM_FREE_MACHINES
;--------------
;Register Backup
;---------------
	ST R0, BACKUP_R0_4000
	ST R1, BACKUP_R0_4000
	ST R3, BACKUP_R3_4000
	ST R4, BACKUP_R4_4000
	ST R5, BACKUP_R5_4000
	ST R6, BACKUP_R6_4000
	ST R7, BACKUP_R7_4000
	
;------------
;Instructions
;-------------
	LDI R1, BUSYNESS_ADDR_NUM_FREE_MACHINES
	LD R2, COUNTER_0_40							;counter for busy bits
	LD R3, COUNTER_16_40						;counter for 16 bits
	
	ADD R1, R1, #0
	CHECK_BUSY_40
		ADD R1, R1, #0
		BRzp IS_ZERO_40
		
		IS_ONE_40
			ADD R1, R1, R1						;left shift bits 
			ADD R2, R2, #1						;incrament counter
			ADD R3, R3, #-1						;decrament counter 
			BRp CHECK_BUSY_40
			BR FIN_40
		
		IS_ZERO_40
			ADD R1, R1, R1						;left shift bits 
			ADD R3, R3, #-1						;decrament counter 
			BRp CHECK_BUSY_40
			
	FIN_40
		
.END	
;-----------------
;Restore registers
;-----------------
	LD R0, BACKUP_R0_4000
	LD R3, BACKUP_R3_4000
	LD R4, BACKUP_R4_4000
	LD R5, BACKUP_R5_4000
	LD R6, BACKUP_R6_4000
	LD R7, BACKUP_R7_4000
	
RET	

;--------------
;subroutine data
;---------------
	BACKUP_R0_4000		.BLKW #1
	BACKUP_R3_4000		.BLKW #1
	BACKUP_R4_4000		.BLKW #1
	BACKUP_R5_4000		.BLKW #1
	BACKUP_R6_4000		.BLKW #1
	BACKUP_R7_4000		.BLKW #1

;--------------------------------
;Data for subroutine NUM_BUSY_MACHINES
;--------------------------------
COUNTER_16_40		.FILL #16
COUNTER_0_40		.FILL #0
BUSYNESS_ADDR_NUM_FREE_MACHINES .Fill xBA00


;-----------------------------------------------------------------------------------------------------------------
; Subroutine: MACHINE_STATUS (#5)
; Input (R1): Which machine to check, guaranteed in range {0,15}
; Postcondition: The subroutine has returned a value indicating whether
;                the selected machine (R1) is busy or not.
; Return Value (R2): 0 if machine (R1) is busy, 1 if it is free
;              (R1) unchanged
;-----------------------------------------------------------------------------------------------------------------
.ORIG x4200			; Program begins here
MACHINE_STATUS
;--------------
;Register Backup
;---------------
	ST R0, BACKUP_R0_4200
	ST R1, BACKUP_R0_4200
	ST R3, BACKUP_R3_4200
	ST R4, BACKUP_R4_4200
	ST R5, BACKUP_R5_4200
	ST R6, BACKUP_R6_4200
	ST R7, BACKUP_R7_4200
	
;------------
;Instructions
;-------------
	LD R5, GET_MACHINE_NUM_PRE
		JSRR R5
		
		ADD R6, R1, #0
		NOT R6, R6
		ADD R6, R6, #1
		
		LD R5, COUNTER_15_42
		ADD R5, R5, R6
		
		LDI R4, BUSYNESS_ADDR_MACHINE_STATUS
		SHIFT_BITS_42
			ADD R5, R5, #0
			BRz CHECK_BUSY_42
			ADD R4, R4, R4
			ADD R5, R5, #-1
			BRp SHIFT_BITS_42
		
		CHECK_BUSY_42
			ADD R4, R4, #0
			BRn IS_FREE_42
		
		IS_BUSY_42
			LD R2, DEC_0_42
			BR FIN_42
		
		IS_FREE_42
			LD R2, DEC_1_42
		
		
		FIN_42
		
		
		
		
.END		
;-----------------
;Restore registers
;-----------------
	LD R0, BACKUP_R0_4200
	;LD R1, BACKUP_R0_4200
	LD R3, BACKUP_R3_4200
	LD R4, BACKUP_R4_4200
	LD R5, BACKUP_R5_4200
	LD R6, BACKUP_R6_4200
	LD R7, BACKUP_R7_4200
	
RET	

;--------------
;subroutine data
;---------------
	BACKUP_R0_4200		.BLKW #1
	BACKUP_R1_4200		.BLKW #1
	BACKUP_R3_4200		.BLKW #1
	BACKUP_R4_4200		.BLKW #1
	BACKUP_R5_4200		.BLKW #1
	BACKUP_R6_4200		.BLKW #1
	BACKUP_R7_4200		.BLKW #1

;--------------------------------
;Data for subroutine MACHINE_STATUS
;--------------------------------
DEC_0_42		.FILL #0
DEC_1_42		.FILL #1
COUNTER_15_42	.FILL #15
BUSYNESS_ADDR_MACHINE_STATUS.Fill xBA00
GET_MACHINE_NUM_PRE			.FILL GET_MACHINE_NUM

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: FIRST_FREE (#6)
; Inputs: None
; Postcondition: The subroutine has returned a value indicating the lowest numbered free machine
; Return Value (R2): the number of the free machine
;-----------------------------------------------------------------------------------------------------------------
.ORIG x4400			; Program begins here
FIRST_FREE
;--------------
;Register Backup
;---------------
	ST R0, BACKUP_R0_4400
	ST R1, BACKUP_R0_4400
	ST R3, BACKUP_R3_4400
	ST R4, BACKUP_R4_4400
	ST R5, BACKUP_R5_4400
	ST R6, BACKUP_R6_4400
	ST R7, BACKUP_R7_4400
	
;------------
;Instructions
;-------------
	LDI R1, BUSYNESS_ADDR_FIRST_FREE
	LD R4, COUNTER_0_44						;counter for busy bits
	LD R3, COUNTER_16_44						;counter for 16 bits
	LD R2, COUNTER_0_44
	
	CHECK_BUSY_44
		ADD R1, R1, #0
		BRzp IS_ZERO_44
		
		IS_ONE_44
			ADD R2, R3, #0
			ADD R1, R1, R1						;left shift bits 
			ADD R3, R3, #-1						;decrament counter 
			BRp CHECK_BUSY_44
			BR FIN_44
		
		IS_ZERO_44
			;ADD R2, R3, #0
			ADD R1, R1, R1						;left shift bits 
			ADD R3, R3, #-1						;decrament counter 
			BRp CHECK_BUSY_44
			
	FIN_44
	ADD R2, R2, #-1
		
.END	
;-----------------
;Restore registers
;-----------------
	LD R0, BACKUP_R0_4400
	LD R3, BACKUP_R3_4400
	LD R4, BACKUP_R4_4400
	LD R5, BACKUP_R5_4400
	LD R6, BACKUP_R6_4400
	LD R7, BACKUP_R7_4400
	
RET	

;--------------
;subroutine data
;---------------
	BACKUP_R0_4400		.BLKW #1
	BACKUP_R3_4400		.BLKW #1
	BACKUP_R4_4400		.BLKW #1
	BACKUP_R5_4400		.BLKW #1
	BACKUP_R6_4400		.BLKW #1
	BACKUP_R7_4400		.BLKW #1


;--------------------------------
;Data for subroutine FIRST_FREE
;--------------------------------
COUNTER_16_44		.FILL #16
COUNTER_0_44		.FILL #0
BUSYNESS_ADDR_FIRST_FREE .Fill xBA00
;///////////////////////////////////////////////////////////////////////
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: GET_MACHINE_NUM
; Inputs: None
; Postcondition: The number entered by the user at the keyboard has been converted into binary,
;                and stored in R1. The number has been validated to be in the range {0,15}
; Return Value (R1): The binary equivalent of the numeric keyboard entry
; NOTE: You can use your code from assignment 4 for this subroutine, changing the prompt, 
;       and with the addition of validation to restrict acceptable values to the range {0,15}
;-----------------------------------------------------------------------------------------------------------------
.ORIG x4600			; Program begins here
GET_MACHINE_NUM
;--------------
;Register Backup
;---------------
	ST R0, BACKUP_R0_4600
	ST R2, BACKUP_R0_4600
	ST R3, BACKUP_R3_4600
	ST R4, BACKUP_R4_4600
	ST R5, BACKUP_R5_4600
	ST R6, BACKUP_R6_4600
	ST R7, BACKUP_R7_4600
	
;------------
;Instructions
;-------------


	;LD R2, COUNTER_5_46	
		
	INTRO_46
	LD R2, COUNTER_5_46	
		LEA R0, prompt
		PUTS				
	
	TOP_46
		GETC						;gets input
		OUT
			
		LD R3, nNEGATIVE_SIGN_46		;fill and check for negative
		ADD R4, R0, R3			 
		BRz ISSA_NEG		


		LD R3, nPOSITIVE_SIGN_46		;fill and check for plus
		ADD R4, R0, R3			
		BRz POSITIVE_SIGN_46			
		
		LD R3, nENTER_46			;fill and check for enter 
		ADD R4, R0, R3
		BRz	ENTER_LOOP_46	
		
		
		LD R3, nZero_46				;fill and check for 0 
		ADD R4, R0, R3
		BRz	VALID_NUM_46
		LD R3, nONE_46						;fill and check for 1 
		ADD R4, R0, R3
		BRz	VALID_NUM_46
		LD R3, nTWO_46						;fill and check for 2 
		ADD R4, R0, R3
		BRz	VALID_NUM_46
		LD R3, nTHREE_46					;fill and check for 3 
		ADD R4, R0, R3
		BRz	VALID_NUM_46
		LD R3, nFOUR_46					;fill and check for 4 
		ADD R4, R0, R3
		BRz	VALID_NUM_46
		LD R3, nFIVE_46					;fill and check for 5 
		ADD R4, R0, R3
		BRz	VALID_NUM_46
		LD R3, nSIX_46						;fill and check for 6 
		ADD R4, R0, R3
		BRz	VALID_NUM_46
		LD R3, nSEVEN_46					;fill and check for 7 
		ADD R4, R0, R3
		BRz	VALID_NUM_46
		LD R3, nEIGHT_46					;fill and check for 8 
		ADD R4, R0, R3	
		BRz	VALID_NUM_46
		LD R3, nNINE_46					;fill and check for 9 
		ADD R4, R0, R3
		BRz	VALID_NUM_46
		
		LD R0, ENTER_46					;if invalid input, output enter 
		OUT							;and error msg
		LEA R0, Error_msg_2
		PUTS
			
		AND R1, R1, x0				;clear R2
		AND R6, R6, x0				;clear R6
		AND R5, R5, x0				;clear R5
		LD R2, COUNTER_5_46			;reset counter
		BRnzp INTRO_46					;reset to INTRO
		
			NEGATIVE_SIGN_46
			ADD R3, R5, #-5			;check if + entered
			BRz ERROR_46				;if so, output error and reset 
			
			AND R5, R5, x0			;add back 5
			ADD R5, R5, #10			;check if - entered
			BRnzp TOP_46				;return to top
			
		POSITIVE_SIGN_46	
			AND R5, R5, x0			;reset R5
			ADD R5, R5, #5			;make flag for positive
			BRnzp TOP_46				;return to top
			
		ENTER_LOOP_46	
			LD R3, COUNTER_5_n46
			ADD R3, R2, R3
			BRz ISSA_NEG
		
			BRnzp NEGATIVE_CHECK_46	;Done inserting so check for -
		
		VALID_NUM_46					;entered num was valid
			LD R3, nZero_46	
			ADD R0, R0, R3			;convert ascii to dec
			ADD R6, R6, R0			;enter dec to R6
			ADD R1, R6, #0			;add R6 to R2 pre 
			LD R4, COUNTER_10_46			;load multiplier counter
			
		MULTIPLY_46						;multiply by 10
			ADD R6, R6, R1			;add to R6 (R6 += R2)
			ADD R4, R4, #-1			;subtract fro multiplier
			BRp MULTIPLY_46			;keep adding until counter reaches 0
			
		ADD R2, R2, #-1				;subtracr from main counter
		Brz INSERT_ENTER_46	
		Brp TOP_46	
		
		INSERT_ENTER_46					;output new line
			;LD R0, ENTER_46			
			;OUT	
			BR NEGATIVE_CHECK_46	
			
		ERROR_46				;output error msg
			;LD R0, ENTER_46			
			;OUT	
			AND R1, R1, x0
			AND R5, R5, x0
			AND R6, R6, x0
			LEA R0, Error_msg_2
			PUTS
			BRnzp INTRO_46	
		ISSA_NEG
			LD R0, ENTER_46			
			OUT	
			BR ERROR_46	
		
	
	NEGATIVE_CHECK_46				;check for -, annd if so, convrt
		ADD R5, R5, #-10
		BRnp FIN_46
		NOT R1, R1
		ADD R1, R1, #1
	
	FIN_46	
	
	
	CKECK_RANGE
		ADD R1, R1, #0
		BRn ISSA_NEG
		LD R5, nCHECK
		ADD R5, R5, R1
		BRp ISSA_NEG
	
.END	
;-----------------
;Restore registers
;-----------------
	LD R0, BACKUP_R0_4600
	LD R2, BACKUP_R3_4600
	LD R3, BACKUP_R3_4600
	LD R4, BACKUP_R4_4600
	LD R5, BACKUP_R5_4600
	LD R6, BACKUP_R6_4600
	LD R7, BACKUP_R7_4600
	
RET	

;--------------
;subroutine data
;---------------
	BACKUP_R0_4600		.BLKW #1
	BACKUP_R2_4600		.BLKW #1
	BACKUP_R3_4600		.BLKW #1
	BACKUP_R4_4600		.BLKW #1
	BACKUP_R5_4600		.BLKW #1
	BACKUP_R6_4600		.BLKW #1
	BACKUP_R7_4600		.BLKW #1
;---------------	
; Program Data
;---------------


	COUNTER_5_46		.FILL 	#5
	COUNTER_5_n46		.FILL 	#-5
	COUNTER_10_46		.FILL   #9
	ENTER_46			.FILL	#10
	nENTER_46			.FILL	#-10 
	nNEGATIVE_SIGN_46	.FILL	#-45
	nPOSITIVE_SIGN_46	.FILL	#-43
	nCHECK				.FILL	#-15

	
	nZero_46			.FILL	#-48
	nONE_46				.FILL	#-49
	nTWO_46				.FILL	#-50
	nTHREE_46			.FILL	#-51
	nFOUR_46			.FILL	#-52
	nFIVE_46			.FILL	#-53
	nSIX_46				.FILL	#-54
	nSEVEN_46			.FILL	#-55
	nEIGHT_46			.FILL	#-56
	nNINE_46			.FILL	#-57

;--------------------------------
;Data for subroutine Get input
;--------------------------------
prompt .STRINGZ "Enter which machine you want the status of (0 - 15), followed by ENTER: "
Error_msg_2 .STRINGZ "ERROR INVALID INPUT\n"
	
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: PRINT_NUM
; Inputs: R1, which is guaranteed to be in range {0,15}
; Postcondition: The subroutine has output the number in R1 as a decimal ascii string, 
; WITHOUT leading 0's, a leading sign, or a trailing newline.
;      Note: that number is guaranteed to be in the range {#0, #15}, 
;            i.e. either a single digit, or '1' followed by a single digit.
; Return Value: None; the value in R1 is unchanged
;-----------------------------------------------------------------------------------------------------------------
.ORIG x4800			; Program begins here
PRINT_NUM
;--------------
;Register Backup
;---------------
	ST R0, BACKUP_R0_4800	
	ST R1, BACKUP_R0_4800
	ST R2, BACKUP_R0_4800	
	ST R3, BACKUP_R3_4800	
	ST R4, BACKUP_R4_4800	
	ST R5, BACKUP_R5_4800	
	ST R6, BACKUP_R6_4800	
	ST R7, BACKUP_R7_4800	
	
;------------
;Instructions
;-------------
	;LDR R1, R2, #0
	LD R6, DEC_48_48
	;ADD R2, R2, #0
	ADD R1, R1, #0
	BRz PRINT_ZERO
	
	LD R5, DEC_9_48
	
	;ADD R5, R2, R5
	ADD R5, R1, R5
	BRnz PRINT_R1
	
	PRINT_R1_M10
		LD R0, DEC_49_48
		OUT
		LD R5, DEC_10
		NOT R5, R5
		ADD R5, R5, #1
		;ADD R0, R2, R5
		ADD R0, R1, R5
		ADD R0, R0, R6
		OUT
		BR FIN_48
		
	PRINT_R1
		;ADD R0, R2, #0
		ADD R0, R1, #0
		ADD R0, R0, R6
		OUT
		BR FIN_48
	
	PRINT_ZERO
		LD R0, DEC_48_48
		OUT
	
	FIN_48
.END	
;-----------------
;Restore registers
;-----------------
	LD R0, BACKUP_R0_4800
	LD R1, BACKUP_R0_4800
	LD R2, BACKUP_R0_4800	
	LD R3, BACKUP_R3_4800	
	LD R4, BACKUP_R4_4800	
	LD R5, BACKUP_R5_4800	
	LD R6, BACKUP_R6_4800	
	LD R7, BACKUP_R7_4800	
RET	

;--------------
;subroutine data
;---------------
	BACKUP_R0_4800		.BLKW #1
	BACKUP_R1_4800		.BLKW #1
	BACKUP_R2_4800		.BLKW #1
	BACKUP_R3_4800		.BLKW #1
	BACKUP_R4_4800		.BLKW #1
	BACKUP_R5_4800		.BLKW #1
	BACKUP_R6_4800		.BLKW #1
	BACKUP_R7_4800		.BLKW #1

;--------------------------------
;Data for subroutine PRINT_NUM
;--------------------------------
	DEC_49_48	.FILL	#49
	DEC_48_48	.FILL	#48
	DEC_9_48	.FILL	#-9
	DEC_10		.FILL 	#10

;-------------------------------
;END
;-------------------------------


.ORIG x6A00
MENUSTRING .STRINGZ "**********************\n* The Busyness Server *\n**********************\n1. Check to see whether all machines are busy\n2. Check to see whether all machines are free\n3. Report the number of busy machines\n4. Report the number of free machines\n5. Report the status of machine n\n6. Report the number of the first available machine\n7. Quit\n"

.ORIG xBA00			; Remote data
BUSYNESS .FILL x8000	; <----!!!BUSYNESS VECTOR!!! Change this value to test your program.

;---------------	
;END of PROGRAM
;---------------	
.END
