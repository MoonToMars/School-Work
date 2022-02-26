; achieve an exact delay of 1,000,000 cycles
; make sure INDX or INDY is set to 19171 just once in this file
;  ie. don't reuse it for something else

porta	equ	$1000	;the location of porta, LED on bit 6

	org	$d000	;set the current location

start
	ldaa	porta	;4
	eora	#$40	;2 - toggle bit for LED
	staa	porta	;4	
	
; add your delay here

	ldy	#19171	;4 The number of times our outer loop will loop
loop0	
	ldx	#7	;3 The number of times the nested loop will loop. By using algebra, 7 would bring our cycles closest to one million
loop1	
	dex		;3 continually decrement x
	bne	loop1	;3 check to see if x is zero, loop otherwise
	dey		;4 continually decrement y
	bne	loop0	;3 check to see if y is zero, loop otherwise

	ldx	#514	;3 Reusing x to loop a couple more times until we reach 1 million
loop2	
	dex		;3 continually decrement x
	bne	loop2	;3 check to see if x is zero, loop otherwise
	
	nop		;2 Used to achieve additional 4 cycles
	nop		;2 Used to achieve additional 4 cycles


; you may need some extra instructions here to make up the difference
;	brn	*	;3
;	nop		;2

	jmp	start	;3

	org	$FFFE	;go to reset vector

	fdb	start	;put in vector