	org	$0		; RAM area for variables

count	rmb	2		; Storage for additional 16 bits

	org	$d000		; Set the current location to ROM

start	ldaa	#$40		; Enable STOP
	tap
	ldx	#$200		; Setup SP
	txs
	jsr	ClearDisp	; Clear LCD

	ldd	#0
	std	count
loop
	ldd	count		; Load count into ACCD, ACCA is MSB, ACCB is LSB
	jsr	PrtHex2		; Print MSB of count
	tba			; Move LSB to ACCA
	jsr	PrtHex2		; Print LSB of count
	ldaa	#13		; print new line
	jsr	SendChar

	ldaa	count+1		; Load LSB of count into ACCA
	adda	#1		; Add 1, ignore previous carry
	daa
	staa	count+1		; Update value

	ldaa	count		; Load MSB of count into ACCA
	adca	#0		; Add 0 including carry from previous add
	daa	
	staa	count		; Update value

	ldd	count
	cmpd	#0000		; Do it again if it isn't 0 now
	bne	loop

	stop			; Stop CPU

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
	cmpa	#$3a		; If it is greater than or equal to $3A (one above ASCII '0'), add 7 to put it in ASCII A-F range ($41-$46)
	blo	SendChar	; Regardless, follow through to next subroutine to print it
	adda	#7

SendChar
	staa	$1040
	rts

ClearDisp
	clr	$1040
	rts

	org	$FFFE	;RESET vector
	fdb	start
