;	Segment build for engine\video96.asm: sets its origin and the outside routines and data it uses,
;	then includes the file on its own for checking against the ROM.

; region code
	org	$01AF00

; includes for stubs to replace removed code
	include	stubinc\ports.inc	;IO_* / VDP_* ports
	include	stubinc\equals.inc	;VDP status bits
	include	ram96.asm		;RAM map
	include	externs96.asm		;outside addresses still in incbin segments. Equates only
	include	macros\genesis.mac	;String

; External addresses outside, read from lst/nhl96.bin.
PrintBigChar = $01BF94		;penalty96
unk_1C01C = $01C01C		;penalty96
rtss2 = $01F84A		;collide96
vb2 = $0202C4		;display96
SoundCmd = $08839E		;data96_04
Framermap = $091B86		;data96_05
RosterFont = $179168		;data96_08
SmallFontMap = $179A76		;data96_08
BigFontMap2 = $17AA72		;data96_08
BigFontMap4 = $17B680		;data96_08


; Main segment code
	include	engine\video96.asm
