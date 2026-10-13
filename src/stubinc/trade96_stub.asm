;	Segment build for front\trade96.asm: sets its origin and the outside routines and data it uses,
;	then includes the file on its own for checking against the ROM.

; region code
	org	$0100C0

; includes for stubs to replace removed code
	include	stubinc\ports.inc	;IO_* / VDP_* ports
	include	stubinc\equals.inc	;VDP status bits
	include	ram96.asm		;RAM map
	include	externs96.asm		;outside addresses still in incbin segments. Equates only
	include	macros\genesis.mac	;String

; External addresses outside, read from lst/nhl96.bin.
sub_10CB2 = $010CB2		;code96_05
TeamList = $00077E		;teamdata96
GetGoalieCount = $0157A2		;code96_06
GetPlayerCount = $0157F4		;code96_06
randomd0 = $01B0A6		;code96_08
FinalizeTextBuffer = $0230AA		;code96_12
ConvertByteToDigits = $0230C4		;code96_12
PAttribOverallMask = $023456		;data96_02
GAttribOverallMask = $0235B8		;data96_02
ReadSRAM = $0241E8		;data96_02
CalcAttrib = $1D7DF8		;code96_14


; Main segment code
	include	front\trade96.asm
