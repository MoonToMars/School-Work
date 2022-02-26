	org	$0		; RAM area for variables

count	rmb	2		; Storage for additional 16 bits
vx	rmb	4		; Remember the digits so we can print them

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
	jsr	PrtDec2		; Print decimal value
	ldaa	#13		; print new line
	jsr	SendChar

	ldd	count		; Load count into ACCD
	addd	#1		; Add 1
	std	count		; Update value

	cmpd	#10000		; Do it again if it isn't 10000 now
	bne	loop

	stop			; Stop CPU

; Print out decimal value of ACCD
PrtDec2
	ldx	#10		; Use IDIV instruction: ACCD = Numerator, INDX = Denominator
	idiv			;  returns quotient in INDX, remainder in ACCD
				; start by loading INDX with 10, then use IDIV
	stab	vx		; store ACCB somewhere in vx+n, the use XGDX to swap INDX/ACCD
	xgdx
	
	ldx	#10		; do it again, storing ACCB in vx+n (a different n)			
	idiv			; do this 4 times		
	stab	vx+1
	xgdx
	
	ldx	#10
	idiv						
	stab	vx+2
	xgdx	

	ldx	#10
	idiv						
	stab	vx+3
	xgdx

	ldaa	vx+3		; load vx+n into ACCA, and call PrtHex1 subroutine to print it
	bsr	PrtHex1			
				; do it for all 4 values of vx

	ldaa	vx+2
	bsr	PrtHex1
	
	ldaa	vx+1
	bsr	PrtHex1

	ldaa	vx
	bsr	PrtHex1

	rts

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
