;	Segment build for code96_03.asm: sets its origin and the outside routines and data it uses,
;	then includes code96_03.asm on its own for checking against the ROM.

; region code
	org	$00EC30

; includes for stubs to replace removed code
	include	stubinc\ports.inc	;IO_* / VDP_* ports
	include	stubinc\equals.inc	;VDP status bits
	include	ram96.asm		;RAM map
	include	externs96.asm		;outside addresses still in incbin segments. Equates only
	include	macros\genesis.mac	;String

; External addresses outside, read from lst/nhl96.bin.
rtss7 = $00A3DA		;faceoff96
loadTeamStruct = $01D328		;code96_09


; Main segment code
	include	code96_03.asm
