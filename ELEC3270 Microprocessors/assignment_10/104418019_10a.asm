; Assignment 10 code for 104418019
; *********************************************** 
; * DO NOT REMOVE COMMENTS ALREADY IN THIS FILE *	
;;***********************************************	

; Connect BIT INSERTER to PA7	
; Right click on bit inserter window, select "Maximum Amount...", and enter 10000	
; Right click on bit inserter window, select "Load...", and pick either assign_10a.txt 
;  or assign_10b.txt depending on which part of the assignment you are on 
; Right click on bit inserter window, uncheck "Repeat" 

; ***********************	
; * ADJUST THESE VALUES *	
;;***********************	
mPAOVI	EQU	%00100000	; Mask bit for PAOVI (see TMSK2)	
; for part A: DDRA7=0. PAEN=1, PAMOD=0, PEDGE=1 (see PACTL; positive edge) 
; for part B: DDRA7=0. PAEN=1, PAMOD=1, PEDGE=0 (see PACTL; 0 inhibit) 
iPACTL	EQU	%01010000	; DO NOT REMOVE THIS COMMENT 
mRTII	EQU	%01000000	; Mask bit for RTII (see TMSK2)	

TMSK2	EQU	$1024		;main timer interrupt mask register 2	
TFLG2	EQU	$1025		;main timer interrupt flag register 2	
PACTL	EQU	$1026		;port A control port	
PACNT	EQU	$1027		;pulse accumulator counter 
HPRIO	EQU	$103c		;highest priority interrupt 

	org	$0		; Set the current location for variables 

pacnth	rmb	1		; Storage for upper 8 bits of PACNT	
itime	rmb	1		; Storage for PACNT when switch is thrown	
itimeh	rmb	1		; Storage for PACNTH when switch is thrown	
iflag	rmb	1		; Storage for whether input data in the mailbox is valid	

	org	$d000		; Set the current location for program 

start	ldaa	#$40		; Enable STOP 
	tap
	ldaa	#mPAOVI|mRTII
	staa	TMSK2		; Configure TMSK2 
	ldaa	#iPACTL
	staa	PACTL		; Configure PACTL	
	ldaa	#%10000101
	staa	HPRIO
	ldx	#$200		; Setup SP	
	txs
	jsr	ClearDisp	; Clear LCD	

	clr	pacnt		; Reset lower PA counter to 0	
	clr	pacnth		; Reset higher PA counter to 0 
	clr	iflag		; Reset mailbox flag 
	cli			; Enable interrupts 

loop
	wai			; Wait for an interrupt to happen	

	tst	iflag		; Check input mailbox	
	beq	next

; ****************************************************************	
; * ADD YOUR CODE TO PRINT THE UPPER PACNT COUNTER USING PRTHEX2 *	
;;**************************************************************** 
; * ADD YOUR CODE TO PRINT THE LOWER PACNT COUNTER USING PRTHEX2 * 
; *                  -DO NOT REMOVE THIS TEXT-                   * 
; ****************************************************************;	
	ldaa	itimeh
	jsr	PrtHex2	
	ldaa	itime
	jsr	PrtHex2

	ldaa	#13		; Print new line	
	jsr	SendChar

	clr	iflag		; Clear flag so we don't process it the next round	

next
	bra	loop		; No more mailboxes. Go back and wait for something to happen	

; ****************************** 
; * ADD YOUR RTI ISR CODE HERE * 
; * -DO NOT REMOVE THIS TEXT-  * 
;;******************************	
rtivect

	ldab	TFLG2		;  check the flag, leave if not set	
	andb	#mRTII		
	beq	rtiend
	
	stab	TFLG2		;  clear the flag	
	
	ldaa	pacnt
	staa	itime		; copy pacnt to itime

	ldaa	pacnth			
	staa	itimeh		; copy pacnth to itimeh 
	
	ldaa	#%1
	staa	iflag		; set iflag to non-zero value 
	
	clr	pacnt
	clr	pacnth		; clear both pacnt and pacnth 

rtiend
	rti

; *******************************	
; * ADD YOUR PAO ISR CODE HERE  *	
; * -DO NOT REMOVE THIS TEXT-   *	
;;*******************************	
paovect

	ldab	TFLG2
	andb	#mPAOVI
	beq	paoend		; check the flag, leave if not set
	
	stab	TFLG2		; clear the flag
	
	ldab	pacnth		
	incb
	tba
	staa	pacnth		; increment pacnth (it is 8-bits, don't use INDX, INDY or ACCD) 

paoend
	rti

; Print 2 digit hexadecimal value in ACCA	
PrtHex2
	psha			; Remember 8 bit value	
	lsra			; Shift higher 4-bits down 4 bits	
	lsra
	lsra
	lsra
	bsr	PrtHex1		; Print out what was the upper 4-bits	
	pula			; Restore it and follow through to the next subroutine 

; Print 1 digit hexadecimal value in lower 4-bits of ACCA 
PrtHex1
	anda	#15		; Turn off higher order 4 bits 
	oraa	#$30		; Place it in ASCII 0-9 range	
	cmpa	#$3a		; If it is greater than or equal to $3A (one above ASCII '9'), add 7 to put it in ASCII A-F range ($41-$46)	
	blo	SendChar	; Regardless, follow through to next subroutine to print it	
	adda	#7

SendChar
	staa	$1040
	rts

ClearDisp
	clr	$1040
	rts

	org	$FFDC		; PAOV vector	
	fdb	paovect
	org	$FFF0		; RTI vector 
	fdb	rtivect
	org	$FFFE		; RESET vector 
	fdb	start
