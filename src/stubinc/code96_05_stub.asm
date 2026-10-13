;	Segment build for code96_05.asm: sets its origin and the outside routines and data it uses,
;	then includes code96_05.asm on its own for checking against the ROM.

; region code
	org	$010CB2

; includes for stubs to replace removed code
	include	stubinc\ports.inc	;IO_* / VDP_* ports
	include	stubinc\equals.inc	;VDP status bits
	include	ram96.asm		;RAM map
	include	externs96.asm		;outside addresses still in incbin segments. Equates only
	include	macros\genesis.mac	;String


; External addresses outside, read from lst/nhl96.bin.
WriteSRAMBits = $0096E8		;srambits96
ReadSRAMBits = $00975A		;srambits96
sub_1051A = $01051A		;code96_04b
SimGameStats = $01091A		;code96_04b
TeamBlockPtrs = $012BFE		;data96_01
TeamLogoPtrs = $012C6E		;data96_01
unk_12D46 = $012D46		;data96_01
SeasonSchedule = $013558		;data96_01
ResolveDayGames = $013EA2		;data96_01
GetTeamPOSlot = $0143A8		;data96_01
GetGoalieCountD7 = $015774		;code96_06
randomd0 = $01B0A6		;code96_08
sub_1B282 = $01B282		;code96_08
orjoy = $01B2C4		;code96_08
ProcessInputWithRepeat = $01B320		;code96_08
setVram = $01B57E		;code96_08
Vmaddr = $01B678		;code96_08
dobitmap = $01B692		;code96_08
DecompressGraphicsWithCallback = $01B724		;code96_08
DecompressGraphicsPlain = $01B730		;code96_08
eraser = $01B976		;code96_08
printsmallz = $01BA2E		;code96_08
printz = $01BB8E		;code96_08
PushNumberWidth = $01BE1C		;code96_08
printbigz = $01BED6		;code96_08
printbig = $01BEEC		;code96_08
NewPO = $021C28		;code96_11
GetShifter = $0224E2		;code96_12
WriteSRAM = $024188		;data96_02
MakeSRAMChecksum = $0241AA		;data96_02
ReadSRAM = $0241E8		;data96_02
ClearSRAMBytes = $024208		;data96_02
song = $088586		;data96_04
ControllerBgMap = $173C7A		;data96_07
BigFontMap2 = $17AA72		;data96_08
unk_17ECEA = $17ECEA		;data96_08
unk_1808B8 = $1808B8		;data96_08
unk_18C136 = $18C136		;data96_08
unk_18C936 = $18C936		;data96_08
unk_18DE04 = $18DE04		;data96_08
Create_HotCold_Table = $1D6F24		;code96_14
InitShooters = $1D8262		;code96_14
SetSframe = $1DA6C0		;code96_15


; Main segment code
	include	code96_05.asm
