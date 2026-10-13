;	Segment build for code96_12.asm: sets its origin and the outside routines and data it uses,
;	then includes code96_12.asm on its own for checking against the ROM.

; region code
	org	$0221D4

; includes for stubs to replace removed code
	include	stubinc\ports.inc	;IO_* / VDP_* ports
	include	stubinc\equals.inc	;VDP status bits
	include	ram96.asm		;RAM map
	include	externs96.asm		;outside addresses still in incbin segments. Equates only
	include	macros\genesis.mac	;String

; External addresses outside, read from lst/nhl96.bin.
Penaltylist = $00E818		;code96_03
lcfound2 = $00EEC4		;code96_04
GetPlayerNamePointer = $0101C6		;code96_04
GetJerseyNumber = $0102B8		;code96_04
sub_10F02 = $010F02		;code96_05
sub_10F22 = $010F22		;code96_05
GetGoalieCountD7 = $015774		;code96_06
randomd0 = $01B0A6		;code96_08
eraser = $01B976		;code96_08
Framer = $01B9B0		;code96_08
printz = $01BB8E		;code96_08
print = $01BBA0		;code96_08
printcurz = $01BC72		;code96_08
printcur = $01BC84		;code96_08
PushNumberWidth = $01BE1C		;code96_08
appendz = $01BE78		;code96_08
appstring = $01BE80		;code96_08
printbigz2 = $01C12C		;code96_09
printbig2 = $01C15A		;code96_09
prefmes = $01C9FA		;code96_09
sub_1CFE4 = $01CFE4		;code96_09
rtss2 = $01F84A		;code96_10
maketree = $021CF4		;code96_11
WriteSRAM = $024188		;data96_02
MakeSRAMChecksum = $0241AA		;data96_02
ReadSRAM = $0241E8		;data96_02
song = $088586		;data96_04
Rinktilelist = $0923E4		;data96_05
CountGoalies = $1D7D0E		;code96_14
ShootoutModeBox = $1D7FA6		;code96_14
nullsub_7 = $1D8A86		;code96_14
PrintPlayerAssists = $1D8EF6		;code96_15
PrintPlayerGoals = $1D8F0C		;code96_15
ShowBigScore = $1E78C4		;code96_19
ClearBigScore = $1E7A78		;code96_19


; Main segment code
	include	code96_12.asm
