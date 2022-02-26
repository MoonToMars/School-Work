	org	$d000	;set the current location

start	ldx	#$200		; setup SP
	txs
	jsr	ClearDisp	; Clear LCD

loop
	jsr	PrintText
; uncomment the fcb and fcc entries below when your code is ready.
	fcc	'More repeated text.'
	fcb	13,0
	jsr	PrintText
; uncomment the fcb and fcc entries below when your code is ready.
	fcc	'And more text.'
	fcb	13,0

	bra	loop		; Do it over and over again

PrintText
				
	tsx			
	ldd	0,x
				; Remove upper lines which print ACCD		
	xgdx			; Use previous section's code to print text
	
secA

	ldaa	0,X		; Write your code to load ACCA with the memory from 0+X
	beq	leave		; If ACCA is zero, the leave the subroutine with an RTS
	jsr	SendChar	; Otherwise print ACCA by calling the "SendChar" subroutine
	inx			; Increment the INDX register and jump back to the beginning of this function.
	bne	SecA


leave
	inx			; increment this, and now INDX should be the new return PC
	xgdx			; Move INDX back to ACCD, and store ACCD back to memory pointed by SP
	std	$01fe		;storing in the second line

				; When done, INDX should be pointing to zero value for string termination
	rts

; Print 2 digit hexadecimal value in ACCA
PrtHex2
	psha			; Remember 8 bit value
	lsra			; Shift higher 4-bits down 4 bits
	lsra
	lsra
	lsra
	oraa	#$30		; Place it in ASCII 0-9 range
	cmpa	#$3a		; If it is greater than or equal to $3A, add 7 to put it in A-F
	blo	PrtHex20
	adda	#7
PrtHex20
	bsr	SendChar	; Print nybble
	pula			; Get original value

PrtHex1
	anda	#15		; Turn off higher order 4 bits
	oraa	#$30		; Place it in ASCII 0-9 range
	cmpa	#$3a		; If it is greater than or equal to $3A, add 7 to put it in A-F
	blo	SendChar
	adda	#7		; Print by following through to next subroutine

SendChar
	staa	$1040
	rts

ClearDisp
	clr	$1040
	rts

	org	$FFFE	;go to reset vector

	fdb	start	;put in vector
