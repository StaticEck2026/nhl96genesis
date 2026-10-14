;	Segment build for code96_17.asm: sets its origin and the outside routines and data it uses,
;	then includes code96_17.asm on its own for checking against the ROM.

; region code
	org	$1DFA1C

; includes for stubs to replace removed code
	include	stubinc\ports.inc	;IO_* / VDP_* ports
	include	stubinc\equals.inc	;VDP status bits
	include	ram96.asm		;RAM map
	include	externs96.asm		;outside addresses still in incbin segments. Equates only
	include	macros\genesis.mac	;String

; External addresses outside, read from lst/nhl96.bin.
sub_1149E = $01149E		;season96
sub_1217A = $01217A		;season96
sub_1218A = $01218A		;season96
sub_12640 = $012640		;season96
unk_12D46 = $012D46		;teamgfx96
PrintMenuList2 = $01455A		;pause96_list
sub_1B282 = $01B282		;code96_08
orjoy = $01B2C4		;code96_08
ProcessInputWithRepeat = $01B320		;code96_08
setVram = $01B57E		;code96_08
dobitmap = $01B692		;code96_08
DecompressGraphicsPlain = $01B730		;code96_08
eraser = $01B976		;code96_08
printsmallz = $01BA2E		;code96_08
printz = $01BB8E		;code96_08
printcurz = $01BC72		;code96_08
NewPO = $021C28		;code96_11
maketree = $021CF4		;code96_11
ReadPassBits = $0221D4		;code96_12
ReadPassData = $022386		;code96_12
WriteSRAM = $024188		;data96_02
MakeSRAMChecksum = $0241AA		;data96_02
ReadSRAM = $0241E8		;data96_02
ClearSRAMBytes = $024208		;data96_02
ControllerBgMap = $173C7A		;data96_07
RosterFont = $179168		;data96_08
SmallFontMap2 = $17A164		;data96_08
unk_199BE4 = $199BE4		;data96_09
unk_19A3E4 = $19A3E4		;data96_09
unk_19C232 = $19C232		;data96_09
unk_1C4C4E = $1C4C4E		;data96_10
ClearShootout = $1D8180		;code96_14
PStatsPalette = $1DBB92		;code96_16
PlayoffMenuScreen = $1DBBB2		;code96_16
SetGoalieModes = $1E1A3C		;code96_18
FlipUserRec = $1E1A5E		;code96_18
SetLineOption = $1E1A66		;code96_18
SetPenOption = $1E1A8E		;code96_18
SetSkillLevel = $1E1AA8		;code96_18
OptionsAnimFrame = $1E1AD4		;code96_18

; Main segment code
	include	code96_17.asm
