;	Segment build for data96_12.asm: sets its origin and the outside routines and data it uses,
;	then includes data96_12.asm on its own for checking against the ROM.

; region code
	org	$1E2E76

; includes for stubs to replace removed code
	include	stubinc\ports.inc	;IO_* / VDP_* ports
	include	stubinc\equals.inc	;VDP status bits
	include	ram96.asm		;RAM map

; External addresses outside, read from lst/nhl96.bin.


; Main segment code
	include	data96_12.asm
