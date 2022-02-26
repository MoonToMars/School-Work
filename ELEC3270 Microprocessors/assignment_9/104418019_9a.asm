; Make sure a SWITCH is connected to PA0/IC3

; ***************************
; * ADJUST THESE TWO VALUES *
; ***************************
mIC3	EQU	%00000001	; Mask bit for IC3 (see TMSK1)
iTCTL2	EQU	%00000011	; IC3 set to "on any edge" (see TCTL2)

iTMSK1	EQU	mIC3

PORTA	EQU	$1000	;I/O port A
TCNT	EQU	$100e	;timer counter register
TIC3	EQU	$1014	;input capture 3 register
TCTL2	EQU	$1021	;timer control register 2
TMSK1	EQU	$1022	;main timer interrupt mask register 1
TFLG1	EQU	$1023	;main timer interrupt flag register 1

	org	$0

itime	rmb	2	; Storage for input event timer
istate	rmb	1	; Storage for switch state at event
iflag	rmb	1	; Storage for whether input data in the mailbox is valid

	org	$d000	;set the current location

start	ldaa	#$40		; Enable STOP
	tap
	ldaa	#iTMSK1
	staa	TMSK1		; Configure TMSK1
	ldaa	#iTCTL2
	staa	TCTL2		; Configure TCTL2
	ldx	#$200		; Setup SP
	txs
	jsr	ClearDisp	; Clear LCD

	clr	iflag		; Clear the input time flag
	cli			; Enable interrupts

loop

	wai			; Wait for an interrupt to happen

	tst	iflag		; Check input mailbox
	beq	next

	ldd	TCNT		; Output the current FRT
	jsr	PrtHex2
	tba
	jsr	PrtHex2

	ldaa	#' '		; Output a space
	jsr	SendChar

	ldd	itime		; Output the "time" of when the switch was thrown
	jsr	PrtHex2
	tba
	jsr	PrtHex2

	ldaa	#' '		; Output a space and then the state of the switch
	jsr	SendChar
	ldaa	istate		; Print the switch value: "1" for on, "0" for off
	jsr	PrtHex1

	ldaa	#13		; Print new line
	jsr	SendChar

	clr	iflag		; Clear flag so we don't process it the next round

next
	bra	loop		; No more mailboxes. Go back and wait for something to happen

; **************************
; * ADD YOUR ISR CODE HERE *
; **************************
ic3vect

	ldaa	TFLG1		; Check proper interrupt flag to make sure we should be here (read TFLG1, "and" it by mask bit)
	anda	#mIC3		; mIC3(flag bit) anded with TFLG1
	beq	ic3end		; If Z flag is set, get out by going to "ic3end"
				
	staa	TFLG1		; If so clear the interrupt flag (write a "1" to mask bit in TFLG1)

	staa	iflag		; Set flag on input mailbox to say something is there (write to iflag)

	ldd	TIC3		; Record when it happened in the item variable (copy from TIC3 to itime)
	std	itime		; Loading 16-bit value of TIC3 into itime
	
	ldaa	porta		; Copy the state of the switch too (copy from PORTA bit 0 by ANDing appropriately and store in istate)
	anda	#%00000001	; Anding bits 7-1 with 0 to make sure they're off
	staa	istate
ic3end
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

	org	$FFEA		;IC3 vector
	fdb	ic3vect
	org	$FFFE		;RESET vector
	fdb	start
