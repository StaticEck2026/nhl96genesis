;	Segment build for code96_14.asm: sets its origin and the outside routines and data it uses,
;	then includes the file on its own for checking against the ROM.

; region code
	org	$1D6B66

; includes for stubs to replace removed code
	include	stubinc\ports.inc	;IO_* / VDP_* ports
	include	stubinc\equals.inc	;VDP status bits
	include	ram96.asm		;RAM map
	include	externs96.asm		;outside addresses still in incbin segments. Equates only
	include	macros\genesis.mac	;String

; External addresses outside, read from lst/nhl96.bin.
GetRosterName = $0101E6		;trade96
GetGoalieCount = $0157A2		;players96_count
GetPlayerCount = $0157F4		;players96_count
randomd0s = $01B09A		;video96
sroot = $01B0DE		;video96
wallcollb = $01EDAE		;collide96
PAttribOverallMask = $023456		;data96_02
GAttribOverallMask = $0235B8		;data96_02
WriteSRAM = $024188		;data96_02
MakeSRAMChecksum = $0241AA		;data96_02
ReadSRAM = $0241E8		;data96_02
MinOverallRating = $1DF9C2		;create96


; Main segment code
	include	code96_14.asm
