; achieve an exact delay of 184707 cycles

porta	equ	$1000	;the location of porta, LED on bit 6

	org	$d000	;set the current location

start

	ldaa	porta	;4
	eora	#$40	;2 - toggle bit for LED
	staa	porta	;4	
	ldx	#30781	;3 - change "@" to your value
loop0	
	dex		;3
	bne	loop0	;3
	
	brn	*	;3 Used to add 5 additional cycles
	nop		;2 Used to add 5 additional cycles

; you may need some extra instructions here to make up the difference
;	brn	*	;3
;	nop		;2

	jmp	start	;3

	org	$FFFE	;go to reset vector

	fdb	start	;put in vector
