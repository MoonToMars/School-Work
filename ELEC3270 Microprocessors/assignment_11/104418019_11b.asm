; Assignment 11 code for 104418019
; *********************************************** 
; * DO NOT REMOVE COMMENTS ALREADY IN THIS FILE *	
;;***********************************************	

; Go to menu "Connect", "Keypad" to add a keypad	

iDDRC	EQU	%00001111	; Setup the data direction on port C	

PORTC	EQU	$1003		; I/O port C 
DDRC	EQU	$1007		; Data direction for port C (1=output,0=input) 

	org	$0		; Set the current location for variables 

row	rmb	4		; One byte per keypad row	

	org	$d000		; Set the current location for program	

start	ldaa	#$40		; Enable STOP	
	tap

	ldaa	#iDDRC		; Setup PORTC data direction	
	staa	ddrc

	ldx	#$200		; Setup SP 
	txs
	jsr	ClearDisp	; Clear LCD 

	cli			; Enable interrupts 

loop	bsr	getkey		; Get an input from the keypad	
	jsr	PrtHex1		; Print its hexadecimal value ($A=*, $B=#)	
	bra	loop		; Go back and get another	

; *******************************************************************************************	
; * ADD YOUR CODE HERE. DO NOT REMOVE OR TAB OVER COMMENT LINES BELOW.JUST CODE AROUND THEM * 
; *                                 -DO NOT REMOVE THIS TEXT-                               * 
;;******************************************************************************************* 

getkey

; scan for any key	
; set PC0-3 to 0	
	ldab	#%11110000
	andb	PORTC
	stab	PORTC


; read PC6-4 until they are NOT all 1
reading
	ldaa	PORTC
	anda	#%01110000
	beq	reading


; set PC0 to 0, others to 1
	ldab	#%00001110
	stab	PORTC
; read PC6-4 and store in row+0 
	ldaa	PORTC
	anda	#%01110000
	staa	row+0

; set PC1 to 0, others to 1
	ldab	#%00001101
	stab	PORTC
; read PC6-4 and store in row+1 
	ldaa	PORTC
	anda	#%01110000
	staa	row+1

; set PC2 to 0, others to 1	
	ldab	#%00001011
	stab	PORTC
; read PC6-4 and store in row+2	
	ldaa	PORTC
	anda	#%01110000
	staa	row+2

; set PC3 to 0, others to 1
	ldab	#%00000111
	stab	PORTC	
; read PC6-4 and store in row+3	
	ldaa	PORTC
	anda	#%01110000
	staa	row+3

; set PC0-3 to 0 
	ldab	#%11110000
	andb	PORTC
	stab	PORTC


; read PC6-4 until they are all 1
release
	ldaa	PORTC
	anda	#%01110000
	suba	#%01110000
	bne	release
	
	ldab	#0

; process "0", set return value to 0 
	ldaa	#0
; load row+3, AND with "010" at PC6-4, if it is 0, leave	
	ldab	row+3
	andb	#%00100000
	beq	leave

; process "1", increment return value
	inca	
; load row+0, AND with "001" at PC6-4, if it is 0, leave	
	ldab	row+0
	andb	#%00010000
	beq	leave

; process "2", increment return value	
	inca
; load row+0, AND with "010" at PC6-4, if it is 0, leave 
	ldab	row+0
	andb	#%00100000
	beq	leave

; process "3", increment return value
	inca
; load row+0, AND with "100" at PC6-4, if it is 0, leave 
	ldab	row+0
	andb	#%01000000
	beq	leave
; process "4", increment return value
	inca	
; load row+1, AND with "001" at PC6-4, if it is 0, leave	
	ldab	row+1
	andb	#%00010000
	beq	leave
; process all remaining keys
	inca	
	ldab	row+1		;5
	andb	#%00100000
	beq	leave
	
	inca
	ldab	row+1		;6
	andb	#%01000000
	beq	leave

	inca
	ldab	row+2		;7
	andb	#%00010000
	beq	leave

	inca
	ldab	row+2		;8
	andb	#%00100000
	beq	leave
	
	inca
	ldab	row+2		;9
	andb	#%01000000
	beq	leave

	inca
	ldab	row+3		;*
	andb	#%00010000
	beq	leave

	inca
	ldab	row+3		;#
	andb	#%01000000
	beq	leave

; ACCA should have decimal value of key pressed	
leave
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
	cmpa	#$3a		; If it is greater than or equal to $3A (one above ASCII '9'), add 7 to put it in ASCII A-F range ($41-$46) 
	blo	SendChar	; Regardless, follow through to next subroutine to print it 
	adda	#7

SendChar
	staa	$1040
	rts

ClearDisp
	clr	$1040
	rts

	org	$FFFE		;RESET vector	
	fdb	start
