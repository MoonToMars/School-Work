	org	$0		; RAM area for variables

bcd	rmb	2		; BCD output
work	rmb	2		; Working register

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
	ldd	0,y		; Load value from table
	pshb			; Save it temporarily
	psha
	jsr	PrtHex2		; Print the MSB value in HEX
	tba
	jsr	PrtHex2		; Print the LSB value in HEX
	ldaa	#'='		; Print '='
	jsr	SendChar
	pula			; Restore value
	pulb
	jsr	PrtDec2		; Print out decimal value of ACCA
	ldaa	#13		; Print new line
	jsr	SendChar
	iny			; Increment pointer (16-bits)
	iny
	cpy	#tableend	; Go until end of list
	bne	loop

	stop			; Stop CPU

; table in decimal; this should be the output
table
	fdb 0297,4092,9454,5848,1230,8507,5082,3673,1482,1676
	fdb 7538,9191,8797,9593,6243,7716,4069,0834,2466,3436
	fdb 9771,9699,5332,7320,6741,4894,3139,3718,3785,6499
	fdb 2841,6720,6275,5438,4240,2791,6323,9069,0715,8926
	fdb 0889,7240,2810,1017,4774,6875,6735,4730,6301,2005
	fdb 9347,4856,2290,2530,5866,0818,5581,5836,4369,0590
	fdb 9574,1763,6164,4524,1765,8110,6581,1839,2444,2182
	fdb 6230,5218,6311,5406,3259,4827,8517,4299,8187,7550
	fdb 0557,1222,9082,6114,2683,4841,1301,5976,6465,3496
	fdb 7682,7514,5118,1384,5788,3462,9798,8488,8098,0259
tableend


; PrtDec2 prints the decimal value of ACCD (value 0 to 9999)
PrtDec2

				; "work" and "bcd" are 16-bits, so extend the operations appropriately
	std	work		; store ACCD, the input, to "work"
	clr	bcd		; clear "bcd" (16-bits)
	clr	bcd+1

	ldx	#0		; setup a loop to run 16 times using INDX
loop1
	ldd	work		
	lsld			; logical shift left "work" (16 bits); 15th bit goes into carry
	std	work		
	ldd	bcd		; load "bcd", add (with carry) to itself, DAA, store to "bcd" (16-bits, but use 8-bit operations)
	
	pshx			; putting loop counter onto stack so we can reuse index register
	ldx	#bcd		; taking location of bcd(decimal)
	psha			; pushing A onto stack to make room for B
	tba			; moving B into A		
	adca	1,X		; adding upper byte
	daa			; making into BCD
	tab			; Moving A to B
	pula			; taking original A from the stack
	adca	0,X		; adding lower byte position
	daa			; making into BCD again	
	std	bcd		; placing output inside of d register
	pulx			; taking our loop counter back
	
	inx
	cmpx	#16
	bne	loop1		; finish loop
	
	bsr	PrtHex2		; print out MSB of BCD values first using PrtHex2, and then LSB of BCD values
	tba			; moving LSB
	bsr	PrtHex2	
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
