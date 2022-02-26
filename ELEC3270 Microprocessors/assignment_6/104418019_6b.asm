	org	$d000	;set the current location

start	ldx	#$200		; setup SP
	txs
	jsr	ClearDisp	; Clear LCD

loop
	ldd	#message	; Load D with address
	pshb			; Push it on stack in proper order
	psha			; could have just used "LDX" and then "PSHX", but this way X never has address
	jsr	PrintText	; Call subroutine to take address from last 16-bit value stored on stack
	pulx

	bra	loop		; Do it over and over again

PrintText
	tsx			; Transfer SP+1 to INDX, TSX does this so now the INDX is pointing to the last byte of the stack
				; The last 16-bit entry is the return PC
				; The next 16-bit entry is what we are interested in
	ldd	2,X		; Load ACCD from the memory pointed by INDX+2
	xgdx			; Move ACCD to INDX
	
; Now just use your code from Section A
secA

	ldaa	0,X		; Write your code to load ACCA with the memory from 0+X
	beq	leave		; If ACCA is zero, the leave the subroutine with an RTS
	jsr	SendChar	; Otherwise print ACCA by calling the "SendChar" subroutine
	inx			; Increment the INDX register and jump back to the beginning of this function.
	bne	SecA		; Making sure not equal to zero before conducting recursion


leave
	rts			; Exit subroutine

; Since the preceeding instruction is a RTS, this point can never be reached.
; It is safe to add "ROM" data here since the CPU will never read it as an instruction.

message
	fcc	'It worked. Trying again.'	; Don't change this
	fcb	13,0

SendChar
	staa	$1040		; Write to LCD
	rts

ClearDisp
	clr	$1040		; Clear LCD
	rts

	org	$FFFE	;go to reset vector

	fdb	start	;put in vector