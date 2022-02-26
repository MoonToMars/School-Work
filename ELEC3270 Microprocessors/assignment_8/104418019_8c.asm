	org	$0		; RAM area for variables

bcd	rmb	1		; BCD output
work	rmb	1		; Working register

	org	$d000		; Set the current location to ROM

start	ldaa	#$40		; Enable STOP
	tap
	ldx	#$200		; Setup SP
	txs
	jsr	ClearDisp	; Clear LCD

	ldy	#table		; Set Y at the beginning of our table
loop
	ldaa	#'$'		; Print out '$' to indicate hex value
	jsr	SendChar
	ldaa	0,y		; Load value from table
	psha			; Save it temporarily
	jsr	PrtHex2		; Print the value in HEX
	ldaa	#'='		; Print '='
	jsr	SendChar
	pula			; Restore value
	jsr	PrtDec1		; Print out decimal value of ACCA
	ldaa	#13		; Print new line
	jsr	SendChar
	iny			; Increment pointer
	cpy	#tableend	; Go until end of list
	bne	loop

	stop			; Stop CPU

; table in decimal; this should be the output
table
	fcb 83,86,77,15,93,35,86,92,49,21
	fcb 62,27,90,59,63,26,40,26,72,36
	fcb 11,68,67,29,82,30,62,23,67,35
	fcb 29,02,22,58,69,67,93,56,11,42
	fcb 29,73,21,19,84,37,98,24,15,70
	fcb 13,26,91,80,56,73,62,70,96,81
	fcb 05,25,84,27,36,05,46,29,13,57
	fcb 24,95,82,45,14,67,34,64,43,50
	fcb 87,08,76,78,88,84,03,51,54,99
	fcb 32,60,76,68,39,12,26,86,94,39
tableend


; PrtDec1 prints the decimal value of ACCA (value 0 to 99)
PrtDec1

	staa 	work	; first store ACCA, the input, to "work"
	clr	bcd	; clear "bcd"
	
	ldx	#8	; setup a loop to run 8 times (using INDX or INDY)
loop1
	lsl	work	; logical shift left "work"; 7th bit goes into carry
	ldaa	bcd	; load "bcd", add (with carry) to itself, DAA, store to "bcd"
	adca	bcd	
	daa
	staa	bcd

	dex
	bne	loop1	; finish loop
			
			; BCD value should be in ACCA by this point
	bsr	PrtHex2	; call PrtHex2 to print BCD value of ACCA
	rts		; return


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
