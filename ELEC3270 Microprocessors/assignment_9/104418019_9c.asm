; Make sure a SWITCH is connected to PA0/IC3
; Make sure an LED is conencted to PA4/OC4

; ***************************
; * ADJUST THESE SIX VALUES *
; ***************************
mIC3	EQU	%00000001	; Mask bit for IC3 (see TMSK1, same as mIC3 from part B)
mOC4	EQU	%00010000	; Mask bit for OC4 (see TMSK1, same as part B)
iTCTL1f	EQU	%00001000	; TCTL1 setting to clear OC4 output line to 0 (same as part B)
iTCTL1n	EQU	%00001100	; TCTL1 setting to set OC4 output line to 1 (same as part B)
iTCTL2	EQU	%00000011	; TCTL2 setting for IC3 to capture on any edge (same as iTCTL2 in part B)
mTOF	EQU	%10000000	; Mask bit for TOI (see TMSK2, timer overflow interrupt)

iTMSK1	EQU	mIC3
iTMSK2	EQU	mTOF
iTCTL1	EQU	iTCTL1f

PORTA	EQU	$1000
TCNT	EQU	$100e	;timer counter register
TIC3	EQU	$1014	;input capture 3 register
TOC4	EQU	$101c	;output compare 4 register
TCTL1	EQU	$1020	;timer control register 1
TCTL2	EQU	$1021	;timer control register 2
TMSK1	EQU	$1022	;main timer interrupt mask register 1
TFLG1	EQU	$1023	;main timer interrupt flag register 1
TMSK2	EQU	$1024	;main timer interrupt mask register 2
TFLG2	EQU	$1025	;main timer interrupt flag register 2

	org	$0

itime	rmb	2	; Storage for input event timer (low)
itimeh	rmb	2	; Storage for input event timer (high)
istate	rmb	1	; Storage for switch state at input event
iflag	rmb	1	; Storage for whether input data in the mailbox is valid
otime	rmb	2	; Storage for output event timer (low)
otimeh	rmb	2	; Storage for output event timer (high)
oflag	rmb	1	; Storage for whether output data in the mailbox is valid
timerh	rmb	2	; Upper 16-bit storage for extended timer

	org	$d000	;set the current location

start	ldaa	#$40		; Enable STOP
	tap
	ldaa	#iTMSK1
	staa	TMSK1		; Configure TMSK1
	ldaa	#iTMSK2
	staa	TMSK2		; Configure TMSK2
	ldaa	#iTCTL2
	staa	TCTL2		; Configure TCTL2
	ldaa	#iTCTL1
	staa	TCTL1		; Configure TCTL1
	ldx	#$200		; Setup SP
	txs
	jsr	ClearDisp	; Clear LCD

	clr	iflag		; Clear the input time flag
	clr	oflag		; Clear the output time flag
	clr	timerh		; Clear extended timer
	clr	timerh+1
	cli			; Enable interrupts

loop
	wai			; Wait for an interrupt to happen

	tst	iflag		; Check input mailbox
	beq	next

; ************************************************************************
; * ADD YOUR CODE FROM PART B TO ADD $4000 TO itime AND STORE IT TO TOC4 *
; ************************************************************************
; Same as part B
	
	ldd	itime		; Loading itime for addition
	addd	#$4000		; Adding $4000 to itime
	std	TOC4		; Storing itime + $4000 to TOC4	

	ldaa	mOC4		; Clear any past pending OC4 interrupts
	staa	TFLG1
	ldaa	TMSK1		; Enable the OC4 interrupt
	oraa	#mOC4
	staa	TMSK1

	ldaa	#'i'		; Output an "i" followed by the "timeh" and "time" of when the switch was thrown
	jsr	SendChar

; **********************************
; * PRINT THE VALUE OF itimeh HERE *
; **********************************

	ldd	itimeh
	jsr	PrtHex2
	tba
	jsr	PrtHex2

	ldd	itime
	jsr	PrtHex2
	tba
	jsr	PrtHex2


	ldaa	#' '		; Output a space and then the state of the switch
	jsr	SendChar
	ldab	#iTCTL1f	; If the switch is on, setup OC4 to turn on the PA4, otherwise turn it off
	ldaa	istate
	beq	switchoff
	ldab	#iTCTL1n
switchoff
	stab	TCTL1
	jsr	PrtHex1		; Print the switch value: "1" for on, "0" for off

	ldaa	#13		; Print new line
	jsr	SendChar

	clr	iflag		; Clear flag so we don't process it the next round

next
	tst	oflag		; Check output mailbox
	beq	next2

	ldaa	#'o'
	jsr	SendChar	; Output an "o" followed by the "timeh" and "time" when the interrupt was processed

; **********************************
; * PRINT THE VALUE OF otimeh HERE *
; **********************************

	ldd	otimeh
	jsr	PrtHex2
	tba
	jsr	PrtHex2
	
	ldd	otime
	jsr	PrtHex2
	tba
	jsr	PrtHex2

	ldaa	#13		; Print new line
	jsr	SendChar

	clr	oflag		; Clear flag so we don't process it the next round

next2
	bra	loop		; No more mailboxes. Go back and wait for something to happen

; **************************************
; * COPY YOUR ic3vect CODE FROM PART B *
; * COPY timerh INTO itimeh AS WELL    *
; **************************************
ic3vect

; Same as part B, but add in itimeh

	ldaa	TFLG1			; Check proper interrupt flag to make sure we should be here (read TFLG1, "and" it by mask bit)
	anda	#mIC3		; mIC3(flag bit) anded with TFLG1
	beq	ic3end		; If Z flag is set, get out by going to "ic3end"
				
	staa	TFLG1		; If so clear the interrupt flag (write a "1" to mask bit in TFLG1)

	staa	iflag		; Set flag on input mailbox to say something is there (write to iflag)

	ldd	TIC3		; Record when it happened in the item variable (copy from TIC3 to itime)
	std	itime		; Loading 16-bit value of TIC3 into itime
	
	ldaa	porta		; Copy the state of the switch too (copy from PORTA bit 0 by ANDing appropriately and store in istate)
	anda	#%00000001	; Anding bits 7-1 with 0 to make sure they're off
	staa	istate
	
	ldd	timerh
	std	itimeh

ic3end
	rti			; Leave the ISR

; **************************************
; * COPY YOUR oc4vect CODE FROM PART B *
; * COPY timerh INTO otimeh AS WELL    *
; **************************************
oc4vect

; Same as part B, but add in otimeh

	ldx	TCNT		; Record the free running timer as soon as possible in the ISR (load TCNT into INDX or INDY)
	ldaa	TFLG1		; Check proper interrupt flag to make sure we should be here (read TFLG1, "and" it by mask bit)
	anda	#mOC4		; Flag bit anded with TFLG1
	beq	oc4end		; If Z flag is set, get out by going to "oc4end"

	staa	TFLG1		; If so clear the interrupt flag (write a "1" to mask bit in TFLG1)

	stx	otime		; Store INDX or INDY (saved value from above) into otime

	staa	oflag		; Set flag on input mailbox to say something is there (write to oflag)
				
	ldaa	tmsk1		; Disable OC4 from happening again by turning off the masking bit in TMSK1 (use an AND for this)
	anda	#mIC3
	staa	tmsk1	
	
	ldd	timerh
	std	otimeh

oc4end
	rti			; Leave the ISR

; **********************************
; * ADD YOUR ISR CODE HERE FOR TOF *
; **********************************
tofvect

	ldaa	TFLG2		; Check proper interrupt flag to make sure we should be here (read TFLG2, "and" it by mask bit)
	anda	#mTOF		
	beq	tofend		; If Z flag is set, get out by going to "tofend"

	staa	TFLG2		; If so clear the interrupt flag (write a "1" to mask bit in TFLG2)
	
	ldd	timerh
	addd	#1
	std	timerh		; Increment 16-bit counter "timerh"
	
tofend
	rti			; Leave the ISR

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

	org	$FFDE		;TOF vector
	fdb	tofvect
	org	$FFE2		;OC4 vector
	fdb	oc4vect
	org	$FFEA		;IC3 vector
	fdb	ic3vect
	org	$FFFE		;RESET vector
	fdb	start
