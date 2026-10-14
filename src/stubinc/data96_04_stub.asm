;	Segment build for data96_04.asm: sets its origin and the outside routines and data it uses,
;	then includes data96_04.asm on its own for checking against the ROM.

; region code
	org	$07A40A

; includes for stubs to replace removed code
	include	stubinc\ports.inc	;IO_* / VDP_* ports
	include	stubinc\equals.inc	;VDP status bits
	include	ram96.asm		;RAM map
	include	externs96.asm		;outside addresses still in incbin segments. Equates only

; External addresses outside, read from lst/nhl96.bin.
randomd0 = $01B0A6		;video96
SndDriver = $024496		;sound96

; Main segment code
	include	data96_04.asm
