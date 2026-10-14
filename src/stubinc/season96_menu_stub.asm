;	Segment build for front\season96_menu.asm: sets its origin and the outside routines and data it uses,
;	then includes the file on its own for checking against the ROM.

; region code
	org	$1DA6C0

; includes for stubs to replace removed code
	include	stubinc\ports.inc	;IO_* / VDP_* ports
	include	stubinc\equals.inc	;VDP status bits
	include	ram96.asm		;RAM map
	include	externs96.asm		;outside addresses still in incbin segments. Equates only
	include	macros\genesis.mac	;String

; External addresses outside, read from lst/nhl96.bin.
printz = $01BB8E		;video96
PushNumberWidth = $01BE1C		;video96
WriteSRAM = $024188		;data96_02
MakeSRAMChecksum = $0241AA		;data96_02
sub_1218A = $01218A		;season96
unk_122A4 = $0122A4		;season96
sub_12640 = $012640		;season96
GetPOSlotTeam = $0143BC		;awards96
GetGoalieCountD7 = $015774		;players96_count
GetPlayerCountD7 = $0157B2		;players96_count
dobitmap = $01B692		;video96
DecompressGraphicsPlain = $01B730		;video96
Opening2 = $02174A		;hockey96_open
unk_18B4F8 = $18B4F8		;data96_08
DefaultRosters = $0100C0		;trade96
FormatPlayerNameD7 = $01017A		;trade96
sub_10F02 = $010F02		;season96
sub_11582 = $011582		;season96
sub_1217A = $01217A		;season96
DrawSetupTeamBlock = $012B84		;season96
unk_12D46 = $012D46		;teamgfx96
GetTeamPOSlot = $0143A8		;awards96
PrintMenuList2 = $01455A		;pause96_list
sub_1B282 = $01B282		;video96
orjoy = $01B2C4		;video96
ProcessInputWithRepeat = $01B320		;video96
ReadJoy1 = $01B348		;video96
ReadJoy2 = $01B360		;video96
ReadJoy3 = $01B378		;video96
ReadJoy4 = $01B390		;video96
setVram = $01B57E		;video96
eraser = $01B976		;video96
printsmallz = $01BA2E		;video96
printcurz = $01BC72		;video96
printcur = $01BC84		;video96
printbigz = $01BED6		;video96
printbig = $01BEEC		;video96
SkipStrings = $01D7F2		;hockey96_inter
maketree = $021CF4		;playoff96
ReadPassBits = $0221D4		;playoff96
ReadPassData = $022386		;playoff96
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
unk_18B916 = $18B916		;data96_08
unk_18E152 = $18E152		;data96_08
unk_18E932 = $18E932		;data96_08
unk_190380 = $190380		;data96_08
RosterMenuList = $1DC03C		;trade96_edit
YesNoMenuList = $1DC10E		;trade96_edit
MenuCreatePlayers = $1DC140		;trade96_edit
MenuSignFreeAgents = $1DC148		;trade96_edit
MenuReleasePlayer = $1DC150		;trade96_edit
TradePlayers = $1DC158		;trade96_edit
TeamRosterScreen = $1E2EFC		;summary96


; Main segment code
	include	front\season96_menu.asm
