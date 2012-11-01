.include "m32def.inc"

;***** Macros
.MACRO CALL_DELAY
	ldi		r16, @0
	rcall	delay
.ENDMACRO

;***** Pin definitions

.equ	PIN_LED	= PD6

.cseg
.org 0
	rjmp	reset

;INPUT: r16 time
;DESTROYS: r0, r1, r2
delay:
	clr		r0
	clr		r1
delay0: 
	dec		r0
	brne	delay0
	dec		r1
	brne	delay0
	dec		r16
	brne	delay0
	ret

;***** Program Execution Starts Here

reset:
	;init the stack pointer
	ldi		r16, low(RAMEND)
	out		SPL, r16
	ldi		r16, high(RAMEND)
	out		SPH, r16

	sbi		DDRD, PIN_LED

forever:
	sbi		PORTD, PIN_LED
	CALL_DELAY	50

	cbi		PORTD, PIN_LED
	CALL_DELAY	50

	rjmp	forever
