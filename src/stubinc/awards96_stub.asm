;	Segment build for front\awards96.asm: sets its origin and the outside routines and data it uses,
;	then includes the file on its own for checking against the ROM.

; region code
	org	$013EA0

; includes for stubs to replace removed code
	include	stubinc\ports.inc	;IO_* / VDP_* ports
	include	stubinc\equals.inc	;VDP status bits
	include	ram96.asm		;RAM map
	include	externs96.asm		;outside addresses still in incbin segments. Equates only
	include	macros\genesis.mac	;String

; External addresses outside, read from lst/nhl96.bin.
sub_11226 = $011226		;season96
sub_1147E = $01147E		;season96
sub_1149E = $01149E		;season96
sub_1161E = $01161E		;season96
maketree = $021CF4		;code96_11
WritePassData = $0223B0		;code96_12
WritePassBits = $0223EA		;code96_12
GetShifter = $0224E2		;code96_12
MakeSRAMChecksum = $0241AA		;data96_02
ClearSRAMBytes = $024208		;data96_02
sub_1DFA1C = $1DFA1C		;code96_17


; Main segment code
	include	front\awards96.asm
