;	Segment build for code96_08.asm: sets its origin and the outside routines and data it uses,
;	then includes code96_08.asm on its own for checking against the ROM.

; region code
	org	$019F3E

; includes for stubs to replace removed code
	include	stubinc\ports.inc	;IO_* / VDP_* ports
	include	stubinc\equals.inc	;VDP status bits
	include	ram96.asm		;RAM map
	include	externs96.asm		;outside addresses still in incbin segments. Equates only
	include	macros\genesis.mac	;String

; External addresses outside, read from lst/nhl96.bin.
AdjustFacingDirection = $017C06		;code96_07
PrintBigChar = $01BF94		;code96_09
unk_1C01C = $01C01C		;code96_09


; Main segment code
	include	code96_08.asm
