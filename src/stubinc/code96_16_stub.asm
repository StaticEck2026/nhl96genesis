;	Segment build for code96_16.asm: sets its origin and the outside routines and data it uses,
;	then includes code96_16.asm on its own for checking against the ROM.

; region code
	org	$1DB288

; includes for stubs to replace removed code
	include	stubinc\ports.inc	;IO_* / VDP_* ports
	include	stubinc\equals.inc	;VDP status bits
	include	ram96.asm		;RAM map
	include	externs96.asm		;outside addresses still in incbin segments. Equates only
	include	macros\genesis.mac	;String

; External addresses outside, read from lst/nhl96.bin.
DefaultRosters = $0100C0		;code96_04
FormatPlayerNameD7 = $01017A		;code96_04
sub_10F02 = $010F02		;code96_05
sub_11582 = $011582		;code96_05
sub_1217A = $01217A		;code96_05
sub_1218A = $01218A		;code96_05
unk_122A4 = $0122A4		;code96_05
sub_12640 = $012640		;code96_05
DrawSetupTeamBlock = $012B84		;code96_05
unk_12D46 = $012D46		;data96_01
GetTeamPOSlot = $0143A8		;data96_01
GetPOSlotTeam = $0143BC		;data96_01
PrintMenuList2 = $01455A		;data96_01
GetGoalieCountD7 = $015774		;code96_06
GetPlayerCountD7 = $0157B2		;code96_06
sub_1B282 = $01B282		;code96_08
orjoy = $01B2C4		;code96_08
ProcessInputWithRepeat = $01B320		;code96_08
ReadJoy1 = $01B348		;code96_08
ReadJoy2 = $01B360		;code96_08
ReadJoy3 = $01B378		;code96_08
ReadJoy4 = $01B390		;code96_08
setVram = $01B57E		;code96_08
dobitmap = $01B692		;code96_08
DecompressGraphicsPlain = $01B730		;code96_08
eraser = $01B976		;code96_08
printsmallz = $01BA2E		;code96_08
printz = $01BB8E		;code96_08
printcurz = $01BC72		;code96_08
printcur = $01BC84		;code96_08
PushNumberWidth = $01BE1C		;code96_08
printbigz = $01BED6		;code96_08
printbig = $01BEEC		;code96_08
SkipStrings = $01D7F2		;code96_09
maketree = $021CF4		;code96_11
ReadPassBits = $0221D4		;code96_12
ReadPassData = $022386		;code96_12
WriteSRAM = $024188		;data96_02
MakeSRAMChecksum = $0241AA		;data96_02
ClearSRAMBytes = $024208		;data96_02
unk_170B0C = $170B0C		;data96_07
ControllerBgMap = $173C7A		;data96_07
RosterFont = $179168		;data96_08
SmallFontMap2 = $17A164		;data96_08
BigFontMap2 = $17AA72		;data96_08
BigFontMap4 = $17B680		;data96_08
unk_17C2AE = $17C2AE		;data96_08
unk_18948A = $18948A		;data96_08
unk_18ACD8 = $18ACD8		;data96_08
unk_18B4F8 = $18B4F8		;data96_08
unk_18B916 = $18B916		;data96_08
unk_18E152 = $18E152		;data96_08
unk_18E932 = $18E932		;data96_08
unk_190380 = $190380		;data96_08
unk_1DAE32 = $1DAE32		;code96_15
RosterMenuList = $1DC03C		;data96_11
YesNoMenuList = $1DC10E		;data96_11
MenuCreatePlayers = $1DC140		;data96_11
MenuSignFreeAgents = $1DC148		;data96_11
MenuReleasePlayer = $1DC150		;data96_11
TradePlayers = $1DC158		;data96_11

; Main segment code
	include	code96_16.asm
