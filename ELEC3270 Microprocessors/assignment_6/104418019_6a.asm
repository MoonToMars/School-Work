	org	$d000	;set the current location

start	ldx	#$200		; setup SP
	txs
	jsr	ClearDisp	; Clear LCD

loop
	ldx	#message	; Specify location in memory where text is
	jsr	PrintText	; Call subroutine
	bra	*		; Wait forever

printtext

	ldaa	0,X		; Write your code to load ACCA with the memory from 0+X
	beq	leave		; If ACCA is zero, the leave the subroutine with an RTS
	jsr	SendChar	; Otherwise print ACCA by calling the "SendChar" subroutine
	inx			; Increment the INDX register and jump back to the beginning of this function.
	bne	printtext	; Making sure not equal to zero before conducting recursion

; The ASCII values are easily encoded for you using "FCC"


leave
	rts

; Since the preceeding instruction is either an RTS or BRA, this point can never be reached.
; It is safe to add "ROM" data here since the CPU will never read it as an instruction.

message
	fcc	'Emmanuel Mati'	; ASCII text
	fcb	13		; you can add non-text data as well; this is a carriage-return; keep it
	fcb	0		; strings of ASCII are usually terminated with a 0

SendChar
	staa	$1040		; Write to LCD
	rts

ClearDisp
	clr	$1040		; Clear LCD
	rts

	org	$FFFE	;go to reset vector

	fdb	start	;put in vector