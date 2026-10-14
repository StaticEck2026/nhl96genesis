;	Segment build for code96_14.asm: sets its origin and the outside routines and data it uses,
;	then includes code96_14.asm on its own for checking against the ROM.

; region code
	org	$1D6B66

; includes for stubs to replace removed code
	include	stubinc\ports.inc	;IO_* / VDP_* ports
	include	stubinc\equals.inc	;VDP status bits
	include	ram96.asm		;RAM map
	include	externs96.asm		;outside addresses still in incbin segments. Equates only
	include	macros\genesis.mac	;String

; External addresses outside, read from lst/nhl96.bin.
sub_EF02 = $00EF02		;code96_04
GetRosterName = $0101E6		;trade96
GetGoalieCount = $0157A2		;code96_06
GetPlayerCount = $0157F4		;code96_06
LockScroll = $016786		;control96
assinsert = $01A3D0		;code96_08
randomd0s = $01B09A		;code96_08
sroot = $01B0DE		;code96_08
Framer = $01B9B0		;code96_08
printz = $01BB8E		;code96_08
print = $01BBA0		;code96_08
PushNumberWidth = $01BE1C		;code96_08
printbigz1 = $01C11A		;code96_09
printbigz2 = $01C12C		;code96_09
printbig1 = $01C13E		;code96_09
printbig2 = $01C15A		;code96_09
prefmes = $01C9FA		;code96_09
wallcollb = $01EDAE		;code96_10
setplayer = $01FEA0		;code96_10
FormatPlayerNumInitial = $022F44		;code96_12
PAttribOverallMask = $023456		;data96_02
GAttribOverallMask = $0235B8		;data96_02
WriteSRAM = $024188		;data96_02
MakeSRAMChecksum = $0241AA		;data96_02
ReadSRAM = $0241E8		;data96_02
MinOverallRating = $1DF9C2		;data96_11

; Main segment code
	include	code96_14.asm
