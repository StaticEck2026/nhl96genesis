;	Segment build for code96_04.asm: sets its origin and the outside routines and data it uses,
;	then includes code96_04.asm on its own for checking against the ROM.

; region code
	org	$00EC6E

; includes for stubs to replace removed code
	include	stubinc\ports.inc	;IO_* / VDP_* ports
	include	stubinc\equals.inc	;VDP status bits
	include	ram96.asm		;RAM map
	include	externs96.asm		;outside addresses still in incbin segments. Equates only
	include	macros\genesis.mac	;String

; External addresses outside, read from lst/nhl96.bin.
rtss7 = $00A3DA		;code96_02
TeamList = $00077E		;teamdata96


; Main segment code
	include	code96_04.asm
