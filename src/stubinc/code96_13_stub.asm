;	Segment build for code96_13.asm: sets its origin and the outside routines and data it uses,
;	then includes code96_13.asm on its own for checking against the ROM.

; region code
	org	$0887E4

; includes for stubs to replace removed code
	include	stubinc\ports.inc	;IO_* / VDP_* ports
	include	stubinc\equals.inc	;VDP status bits
	include	ram96.asm		;RAM map
	include	externs96.asm		;outside addresses still in incbin segments. Equates only

; External addresses outside, read from lst/nhl96.bin.
randomd0 = $01B0A6		;code96_08
sfx = $088470		;data96_04

; Main segment code
	include	code96_13.asm
